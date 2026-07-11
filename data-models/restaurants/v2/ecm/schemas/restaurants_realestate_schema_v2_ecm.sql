-- Schema for Domain: realestate | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`realestate` COMMENT 'Manages site selection, lease negotiations, property acquisition, facility design and construction, CAM (Common Area Maintenance) charges, landlord relationships, lease administration, NRO development pipeline, facility R&M (Repairs and Maintenance), and CapEx planning for new builds and remodels. Tracks lease obligations for IFRS 16 / ASC 842 compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`site` (
    `site_id` BIGINT COMMENT 'Unique identifier for the physical site record. Primary key for the site entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the franchise agreement governing this site, if operated under franchise model. Links site to franchisee obligations and royalty calculations.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Site Assignment Report requires each property to be linked to the operating franchisee for lease compliance and royalty calculations.',
    `landlord_id` BIGINT COMMENT 'FK to realestate.landlord',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity or franchisee responsible for operating this site. Used for financial consolidation and P&L (Profit and Loss) reporting.',
    `trade_area_id` BIGINT COMMENT 'FK to realestate.trade_area',
    `accessibility_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of ease of ingress and egress, typically scored 0-100. Considers turn lanes, traffic signals, median cuts, and parking availability.',
    `acquisition_date` DATE COMMENT 'Date on which the site was acquired or lease was executed. Used for portfolio tenure analysis and depreciation start date for owned properties.',
    `address_line_1` STRING COMMENT 'Primary street address line for the site location. Business-confidential organizational contact data.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, unit, or building identifiers. Business-confidential organizational contact data.',
    `building_square_footage` STRING COMMENT 'Total interior square footage of the restaurant building. Used for lease valuation, R&M (Repairs and Maintenance) budgeting, and utility forecasting.',
    `city` STRING COMMENT 'City or municipality name where the site is located.',
    `closure_date` DATE COMMENT 'Date on which the restaurant ceased operations at this site. Used for portfolio reporting, lease termination tracking, and asset disposition.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the site location. Determines regulatory jurisdiction and reporting requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this site record was first created in the system. Used for data lineage and audit trail.',
    `daily_traffic_count` STRING COMMENT 'Average daily vehicle or pedestrian traffic count passing the site. Critical visibility and accessibility metric for site selection scoring.',
    `drive_thru_capable` BOOLEAN COMMENT 'Indicates whether the site configuration and zoning permit a drive-thru lane. Critical for QSR (Quick-Service Restaurant) operational model and throughput forecasting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this site record was last updated. Used for change tracking and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the site in decimal degrees. Used for GIS mapping, trade area analysis, and proximity calculations.',
    `lease_commencement_date` DATE COMMENT 'Date on which the lease agreement becomes effective and rent obligations begin. Critical for IFRS 16 / ASC 842 right-of-use asset recognition.',
    `lease_expiration_date` DATE COMMENT 'Date on which the current lease term expires. Used for lease renewal planning, portfolio optimization, and financial forecasting.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the site within the NRO (New Restaurant Opening) pipeline or existing portfolio lifecycle. Drives workflow, reporting, and financial treatment. [ENUM-REF-CANDIDATE: prospecting|under_negotiation|approved|under_construction|active|temporarily_closed|closed|disposed — 8 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the site in decimal degrees. Used for GIS mapping, trade area analysis, and proximity calculations.',
    `lot_square_footage` STRING COMMENT 'Total land area of the site parcel in square feet. Used for property valuation, CAM (Common Area Maintenance) calculations, and site development planning.',
    `market_classification` STRING COMMENT 'Demographic and geographic market segment classification. Drives menu mix, pricing strategy, and operational model selection.. Valid values are `urban|suburban|rural|highway|airport|campus`',
    `monthly_base_rent` DECIMAL(18,2) COMMENT 'Fixed monthly rent payment obligation under the lease agreement, excluding variable charges. Used for P&L (Profit and Loss) forecasting and lease liability calculation.',
    `monthly_cam_charges` DECIMAL(18,2) COMMENT 'Monthly charges for common area maintenance, property taxes, and insurance allocated to the tenant. Variable component of total occupancy cost.',
    `site_name` STRING COMMENT 'Human-readable name or designation for the site, often incorporating location landmarks or address elements for easy identification.',
    `opening_date` DATE COMMENT 'Date on which the restaurant began serving customers at this site. Used for SSS (Same-Store Sales) eligibility and maturity curve analysis.',
    `ownership_status` STRING COMMENT 'Legal ownership structure of the site. Determines accounting treatment under IFRS 16 / ASC 842 lease standards and CapEx (Capital Expenditure) responsibility.. Valid values are `owned|leased|ground_lease|franchise_owned`',
    `parking_spaces` STRING COMMENT 'Number of dedicated parking spaces available at the site. Must meet local zoning minimums and impacts customer accessibility scoring.',
    `percentage_rent_rate` DECIMAL(18,2) COMMENT 'Percentage of sales above the threshold that is paid as additional rent. Expressed as a decimal (e.g., 0.0600 for 6%).',
    `percentage_rent_threshold` DECIMAL(18,2) COMMENT 'Annual sales breakpoint above which percentage rent becomes due to the landlord. Common in retail lease structures for high-traffic locations.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address. Business-confidential organizational contact data. Used for trade area analysis and demographic mapping.',
    `projected_auv` DECIMAL(18,2) COMMENT 'Forecasted annual sales volume for the site based on site selection model. Used for NRO (New Restaurant Opening) approval and ROI (Return on Investment) analysis.',
    `seating_capacity` STRING COMMENT 'Total number of customer seats within the dining area. Used for capacity planning, labor scheduling, and health department permitting.',
    `site_number` STRING COMMENT 'Externally-known unique business identifier for the site, used across real estate, operations, and finance systems. Typically assigned during site prospecting phase.. Valid values are `^[A-Z0-9]{6,12}$`',
    `site_type` STRING COMMENT 'Physical configuration and placement classification of the site within its development or property. Critical for site selection scoring and operational model determination. [ENUM-REF-CANDIDATE: freestanding|inline|endcap|pad|food_court|airport|travel_center — 7 candidates stripped; promote to reference product]',
    `state_province` STRING COMMENT 'Two-letter state or province code for the site location. Used for tax jurisdiction, regulatory compliance, and market segmentation.. Valid values are `^[A-Z]{2}$`',
    `total_capex_investment` DECIMAL(18,2) COMMENT 'Total capital investment for site development, including land acquisition, construction, equipment, and pre-opening costs. Used for ROI calculation and capital planning.',
    `visibility_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of site visibility from primary traffic routes, typically scored 0-100. Incorporates signage sightlines, obstructions, and approach angles.',
    `zoning_classification` STRING COMMENT 'Local government zoning designation for the site parcel. Determines permitted uses, building restrictions, and signage allowances.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master record for every physical site under evaluation, active operation, or disposition in the restaurant real estate portfolio. Captures site identification, geographic coordinates, full address, market classification, trade area demographics, traffic counts (ADT), visibility scores, zoning classification, site type (pad, inline, endcap, freestanding, drive-thru capable), ownership status (owned/leased/ground-lease), parcel size, and current lifecycle stage (prospecting, under negotiation, LOI executed, active, temporarily closed, permanently closed, disposed). Serves as the SSOT for all site-level real estate data across the NRO pipeline and existing portfolio. Links to restaurant unit in the restaurant domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`lease` (
    `lease_id` BIGINT COMMENT 'Unique identifier for the lease agreement. Primary key for the lease entity.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Lease Management process tracks which franchisee is the tenant; needed for rent payment scheduling, compliance, and financial reporting.',
    `landlord_id` BIGINT COMMENT 'Reference to the landlord entity that owns the leased property.',
    `site_id` BIGINT COMMENT 'Reference to the restaurant site or location governed by this lease agreement.',
    `accounting_classification` STRING COMMENT 'Lease classification for financial reporting purposes under IFRS 16 / ASC 842: operating lease (most common for real estate) or finance lease (if lease transfers substantially all risks and rewards of ownership).. Valid values are `operating_lease|finance_lease`',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'Fixed monthly or annual base rent payment amount specified in the lease agreement, excluding variable charges such as CAM, taxes, and percentage rent.',
    `base_rent_frequency` STRING COMMENT 'Frequency at which base rent payments are due: monthly, quarterly, or annually.. Valid values are `monthly|quarterly|annually`',
    `cam_charges_annual` DECIMAL(18,2) COMMENT 'Estimated annual Common Area Maintenance charges for shared property expenses such as landscaping, parking lot maintenance, snow removal, and common utilities.',
    `co_tenancy_clause_flag` BOOLEAN COMMENT 'Indicates whether the lease includes a co-tenancy provision allowing rent reduction or termination if anchor tenants or a minimum occupancy threshold is not maintained.',
    `commencement_date` DATE COMMENT 'Date when the lease agreement becomes effective and rent obligations begin. Critical for IFRS 16 / ASC 842 right-of-use asset recognition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this lease (e.g., USD, CAD, EUR). Critical for multi-currency lease portfolios.. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'Interest rate used to discount future lease payments to present value for IFRS 16 / ASC 842 calculations. Represents the rate the lessee would pay to borrow funds to purchase a similar asset.',
    `document_url` STRING COMMENT 'Reference URL or file path to the digitally stored lease agreement document for audit and compliance purposes.',
    `exclusive_use_rights` STRING COMMENT 'Description of exclusive use provisions that restrict the landlord from leasing to competing restaurant concepts within the same property or trade area.',
    `execution_date` DATE COMMENT 'Date when the lease agreement was signed by all parties, establishing the legal contract.',
    `expiration_date` DATE COMMENT 'Date when the initial lease term ends, excluding any renewal options. Used to calculate remaining lease term for accounting and planning purposes.',
    `guarantor_entity` STRING COMMENT 'Name of the corporate entity providing a lease guarantee, typically the parent company for franchise or subsidiary-operated locations.',
    `insurance_annual` DECIMAL(18,2) COMMENT 'Estimated annual property insurance premium obligation passed through to the tenant under a triple-net (NNN) lease structure.',
    `lease_number` STRING COMMENT 'Externally-known unique business identifier for the lease agreement, used in legal documents and correspondence.',
    `lease_status` STRING COMMENT 'Current lifecycle status of the lease agreement: draft (under negotiation), active (in force), expired (term ended), terminated (ended early), renewed (extended), or pending renewal (approaching expiration with renewal option).. Valid values are `draft|active|expired|terminated|renewed|pending_renewal`',
    `lease_type` STRING COMMENT 'Classification of the lease arrangement: ground lease (land only), building lease (structure and land), sublease (tenant subleases from another tenant), or license agreement.. Valid values are `ground_lease|building_lease|sublease|license_agreement`',
    `liability_value` DECIMAL(18,2) COMMENT 'Initial measurement of the lease liability recognized on the balance sheet under IFRS 16 / ASC 842, representing the present value of future lease payments discounted at the incremental borrowing rate.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease record was last modified in the system.',
    `percentage_rent_rate` DECIMAL(18,2) COMMENT 'Percentage of gross sales above the threshold that is paid as additional rent to the landlord. Typically ranges from 3% to 8% in QSR leases.',
    `percentage_rent_threshold` DECIMAL(18,2) COMMENT 'Annual sales breakpoint above which percentage rent becomes due. Common in retail leases where landlord receives a percentage of sales exceeding this threshold.',
    `permitted_use` STRING COMMENT 'Legal description of the permitted business activities and operations allowed under the lease, typically specifying restaurant or foodservice use.',
    `property_tax_annual` DECIMAL(18,2) COMMENT 'Estimated annual property tax obligation passed through to the tenant under a triple-net (NNN) lease structure.',
    `remaining_term_months` STRING COMMENT 'Number of months remaining from the current date until lease expiration, used for lease liability calculations under IFRS 16 / ASC 842.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to lease expiration by which the tenant must notify the landlord of intent to exercise a renewal option. Typically 180-365 days.',
    `renewal_option_count` STRING COMMENT 'Number of renewal option periods available to the tenant after the initial lease term expires. Common in restaurant leases to provide long-term site control.',
    `renewal_option_term_months` STRING COMMENT 'Duration in months of each renewal option period. Typically 5 years (60 months) per option in QSR leases.',
    `rent_escalation_rate` DECIMAL(18,2) COMMENT 'Annual percentage rate of rent increase if escalation type is fixed percentage. Null if escalation is CPI-indexed or fair market value.',
    `rent_escalation_type` STRING COMMENT 'Method by which base rent increases over the lease term: fixed percentage (e.g., 3% annually), CPI-indexed (tied to Consumer Price Index), fair market value (periodic reappraisal), or none (flat rent).. Valid values are `fixed_percentage|cpi_indexed|fair_market_value|none`',
    `rou_asset_value` DECIMAL(18,2) COMMENT 'Initial measurement of the right-of-use asset recognized on the balance sheet under IFRS 16 / ASC 842, representing the present value of future lease payments plus initial direct costs.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Refundable deposit held by the landlord to cover potential damages or unpaid rent. Typically equivalent to 1-3 months of base rent.',
    `term_months` STRING COMMENT 'Total duration of the initial lease term expressed in months, excluding renewal options.',
    `termination_clause_flag` BOOLEAN COMMENT 'Indicates whether the lease includes an early termination clause allowing the tenant to exit the lease before expiration under specified conditions.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to exercise the early termination clause, if applicable.',
    `termination_penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty or buyout amount required to exercise the early termination clause, if applicable.',
    CONSTRAINT pk_lease PRIMARY KEY(`lease_id`)
) COMMENT 'Authoritative master record for every lease agreement governing a restaurant location, including ground leases, building leases, and sublease arrangements. Captures lease type, commencement and expiration dates, base rent, rent escalation schedule, renewal option terms, termination clauses, co-tenancy provisions, exclusive use rights, permitted use language, landlord entity, guarantor, and IFRS 16 / ASC 842 classification (operating vs. finance lease). Tracks right-of-use (ROU) asset value, lease liability, discount rate, and remaining lease term for accounting compliance. Includes structured clause abstractions: clause type (rent escalation, renewal option, termination right, co-tenancy, exclusivity, assignment, subletting, HVAC responsibility, CAM cap, audit right), clause text, effective date range, financial impact flag, and compliance obligation indicator. Links to site and landlord records. Serves as the SSOT for all lease agreement data including clause-level detail.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`landlord` (
    `landlord_id` BIGINT COMMENT 'Unique identifier for the landlord entity. Primary key.',
    `billing_address_line1` STRING COMMENT 'First line of the landlords billing address for rent payments and invoicing.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (suite, unit, building number).',
    `billing_city` STRING COMMENT 'City for the landlords billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code for the landlords billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the landlords billing address.',
    `billing_state_province` STRING COMMENT 'State or province for the landlords billing address.',
    `cam_billing_method` STRING COMMENT 'Method by which CAM charges are calculated and billed by this landlord.. Valid values are `fixed|pro_rata|reconciliation|pass_through|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this landlord record was first created in the system.',
    `dba_name` STRING COMMENT 'Trade name or DBA name under which the landlord operates, if different from legal name.',
    `effective_date` DATE COMMENT 'Date when the landlord relationship became effective or when the landlord record was first established.',
    `entity_type` STRING COMMENT 'Classification of the landlords organizational structure. REIT = Real Estate Investment Trust.. Valid values are `REIT|private_owner|developer|municipality|institutional_investor|family_trust`',
    `escalation_history_count` STRING COMMENT 'Total number of formal escalations or disputes raised with this landlord over the relationship history.',
    `insurance_certificate_frequency` STRING COMMENT 'Frequency at which insurance certificates must be submitted to this landlord.. Valid values are `annual|semi_annual|quarterly|upon_renewal|not_required`',
    `insurance_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether this landlord requires periodic submission of insurance certificates.',
    `landlord_status` STRING COMMENT 'Current lifecycle status of the landlord relationship.. Valid values are `active|inactive|suspended|under_review`',
    `last_escalation_date` DATE COMMENT 'Date of the most recent formal escalation or dispute with this landlord.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this landlord record was last updated.',
    `legal_name` STRING COMMENT 'The full legal name of the landlord entity as registered with governing authorities.',
    `negotiation_posture` STRING COMMENT 'Assessment of the landlords typical approach to lease negotiations and dispute resolution.. Valid values are `collaborative|firm|aggressive|flexible|unresponsive`',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special requirements, or relationship notes about the landlord.',
    `payment_terms_days` STRING COMMENT 'Standard number of days for rent payment terms agreed with this landlord (e.g., Net 30).',
    `portfolio_property_count` STRING COMMENT 'Number of properties currently leased from this landlord across the restaurant portfolio.',
    `preferred_communication_channel` STRING COMMENT 'The landlords preferred method for receiving communications and notices.. Valid values are `email|phone|portal|mail|fax|in_person`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for landlord communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person for landlord communications and relationship management.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the landlord contact.. Valid values are `^+?[1-9][0-9]{1,14}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person (e.g., Property Manager, Leasing Director, Asset Manager).',
    `relationship_health_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the overall health of the landlord relationship based on payment history, dispute frequency, and collaboration quality.',
    `relationship_tier` STRING COMMENT 'Classification of the landlord relationship based on portfolio size, negotiation history, and strategic importance.. Valid values are `strategic|preferred|standard|limited|probationary`',
    `status_reason` STRING COMMENT 'Explanation or reason code for the current status, particularly for inactive or suspended landlords.',
    `tax_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID for the landlord entity.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `termination_date` DATE COMMENT 'Date when the landlord relationship was terminated or when the last lease with this landlord expired.',
    `w9_last_updated_date` DATE COMMENT 'Date when the W-9 form was last received or updated for this landlord.',
    `w9_on_file_flag` BOOLEAN COMMENT 'Indicates whether a current IRS Form W-9 is on file for this landlord for tax reporting purposes.',
    `website_url` STRING COMMENT 'Official website URL for the landlord entity.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    CONSTRAINT pk_landlord PRIMARY KEY(`landlord_id`)
) COMMENT 'Master record for every landlord, property owner, or lessor entity with whom the company maintains a real estate relationship. Captures landlord legal name, entity type (REIT, private owner, developer, municipality), primary contact details, billing address, tax identification, preferred communication channel, relationship tier, and portfolio overlap count. Tracks relationship health score, escalation history, and negotiation posture. Serves as the SSOT for landlord identity within the real estate domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` (
    `rent_schedule_id` BIGINT COMMENT 'Unique identifier for the rent schedule record. Primary key. Represents one billing period for one lease agreement.',
    `landlord_id` BIGINT COMMENT 'FK to realestate.landlord',
    `lease_id` BIGINT COMMENT 'Reference to the executed lease agreement that governs this rent schedule period. Links to the master lease agreement entity.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location occupying the leased premises for this rent schedule period.',
    `rent_unit_id` BIGINT COMMENT 'Reference to the restaurant location occupying the leased premises for this rent schedule period.',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'The fixed minimum rent amount due for this billing period as stipulated in the lease agreement, excluding percentage rent, CAM, taxes, and insurance.',
    `billing_period_end_date` DATE COMMENT 'The last day of the rent billing period covered by this schedule record. Defines the period for which rent and occupancy costs are calculated.',
    `billing_period_start_date` DATE COMMENT 'The first day of the rent billing period covered by this schedule record. Typically the first day of a calendar month or lease anniversary month.',
    `cam_amount` DECIMAL(18,2) COMMENT 'The tenants share of common area maintenance charges for this billing period, including property management, landscaping, parking lot maintenance, and shared facility upkeep. May be estimated or reconciled.',
    `cam_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether this billing period includes a CAM reconciliation adjustment, where estimated CAM charges are trued up to actual landlord expenses.',
    `cost_center_code` STRING COMMENT 'The cost center or profit center code to which this rent expense is allocated, typically the restaurant location or regional operating unit.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rent schedule record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rent schedule record (e.g., USD, CAD, EUR, GBP, MXN).. Valid values are `^[A-Z]{3}$`',
    `escalation_rate` DECIMAL(18,2) COMMENT 'The annual escalation rate applied to base rent for this period, expressed as a decimal (e.g., 0.0300 for 3% annual increase). Null if escalation type is none or stepped.',
    `escalation_type` STRING COMMENT 'The method by which base rent increases over the lease term. Fixed = predetermined amount, CPI = Consumer Price Index linked, Percentage = annual percentage increase, Stepped = scheduled step increases, None = flat rent.. Valid values are `fixed|cpi|percentage|stepped|none`',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this rent expense is posted in the financial system. Typically maps to rent expense or occupancy cost accounts.',
    `insurance_amount` DECIMAL(18,2) COMMENT 'The tenants share of property insurance premiums for this billing period, covering landlords building and liability insurance. May be estimated and reconciled.',
    `interest_expense` DECIMAL(18,2) COMMENT 'The interest expense component of the lease payment for this period under IFRS 16 / ASC 842 finance lease accounting. Calculated using the incremental borrowing rate.',
    `lease_accounting_classification` STRING COMMENT 'The accounting treatment classification for this lease under IFRS 16 / ASC 842. Operating leases recognize rent expense; finance leases recognize depreciation and interest expense.. Valid values are `operating|finance`',
    `lease_liability_reduction` DECIMAL(18,2) COMMENT 'The portion of the total occupancy cost that reduces the lease liability on the balance sheet for this period under IFRS 16 / ASC 842. Represents principal payment component.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rent schedule record was last updated. Audit trail for change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, explanations, or special circumstances related to this rent schedule period (e.g., rent abatement, dispute details, payment plan arrangements).',
    `occupancy_cost_percentage` DECIMAL(18,2) COMMENT 'The total occupancy cost as a percentage of restaurant sales for this period, calculated as (total_occupancy_cost / reported_sales_amount). Key performance metric for site profitability. Null if sales not reported.',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'Additional charges not classified as base rent, percentage rent, CAM, taxes, or insurance. May include utilities, signage fees, parking fees, or special assessments.',
    `payment_date` DATE COMMENT 'The actual date the rent payment was remitted to the landlord. Null if payment has not yet been made.',
    `payment_due_date` DATE COMMENT 'The date by which the total rent and occupancy cost payment must be remitted to the landlord to avoid late fees or default.',
    `payment_reference_number` STRING COMMENT 'The check number, wire transfer reference, or electronic payment confirmation number used to remit this rent payment. Null if payment has not yet been made.',
    `payment_status` STRING COMMENT 'Current payment status for this rent schedule period. Tracks whether the scheduled payment has been made, is outstanding, or is under dispute.. Valid values are `scheduled|paid|partial|overdue|waived|disputed`',
    `percentage_rent_amount` DECIMAL(18,2) COMMENT 'The calculated percentage rent due for this billing period based on actual sales performance exceeding the threshold. Zero if sales did not exceed threshold or lease has no percentage rent clause.',
    `percentage_rent_rate` DECIMAL(18,2) COMMENT 'The percentage of sales revenue above the threshold that is owed as additional rent. Expressed as a decimal (e.g., 0.0600 for 6%). Null if lease does not include percentage rent clause.',
    `percentage_rent_threshold` DECIMAL(18,2) COMMENT 'The sales revenue breakpoint above which percentage rent becomes due. Also known as natural breakpoint or sales threshold. Null if lease does not include percentage rent clause.',
    `property_address` STRING COMMENT 'The full street address of the leased restaurant property for this rent schedule. Organizational contact data classified as confidential.',
    `real_estate_tax_amount` DECIMAL(18,2) COMMENT 'The tenants proportionate share of property taxes for this billing period. May be estimated monthly and reconciled annually based on actual tax assessments.',
    `rent_per_square_foot` DECIMAL(18,2) COMMENT 'The base rent amount divided by square footage for this billing period, expressed as cost per square foot. Key benchmarking metric for real estate portfolio management.',
    `reported_sales_amount` DECIMAL(18,2) COMMENT 'The gross sales revenue reported to the landlord for this billing period, used to calculate percentage rent. Confidential business performance data. Null if sales reporting is not required.',
    `right_of_use_asset_depreciation` DECIMAL(18,2) COMMENT 'The depreciation expense for the right-of-use asset for this period under IFRS 16 / ASC 842. Typically straight-line over the lease term.',
    `sales_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the tenant is contractually required to report sales revenue to the landlord for this billing period, typically for percentage rent calculation or lease compliance.',
    `square_footage` DECIMAL(18,2) COMMENT 'The total leasable square footage of the restaurant premises as defined in the lease agreement. Used to calculate per-square-foot rent metrics.',
    `tax_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether this billing period includes a real estate tax reconciliation adjustment, where estimated tax charges are trued up to actual property tax assessments.',
    `total_occupancy_cost` DECIMAL(18,2) COMMENT 'The sum of all rent and occupancy charges for this billing period: base rent + percentage rent + CAM + real estate tax + insurance + other charges. Represents total cash outflow for occupancy.',
    CONSTRAINT pk_rent_schedule PRIMARY KEY(`rent_schedule_id`)
) COMMENT 'Periodic rent obligation schedule derived from executed lease agreements, capturing each scheduled rent payment period, base rent amount, percentage rent threshold and rate, CAM (Common Area Maintenance) estimate, real estate tax contribution, insurance contribution, total occupancy cost, and payment due date. Supports IFRS 16 / ASC 842 lease liability amortization schedules, cash flow forecasting, and occupancy cost benchmarking against AUV (Average Unit Volume). One record per lease per billing period.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` (
    `rent_payment_id` BIGINT COMMENT 'Unique identifier for the rent payment transaction. Primary key.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which this payment was disbursed.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this rent payment is allocated for internal cost tracking and P&L reporting.',
    `landlord_id` BIGINT COMMENT 'Reference to the landlord or property owner receiving the payment.',
    `lease_id` BIGINT COMMENT 'Reference to the lease agreement under which this payment is made.',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center to which this rent payment is allocated for segment reporting and profitability analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee who approved this payment for disbursement.',
    `rent_employee_id` BIGINT COMMENT 'Reference to the user or employee who approved this payment for disbursement.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location for which this rent payment applies.',
    `rent_unit_id` BIGINT COMMENT 'Reference to the restaurant location for which this rent payment applies.',
    `approval_date` DATE COMMENT 'The date on which this payment was approved for disbursement by the authorized approver.',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'The base rent amount paid for the lease period, excluding additional charges such as CAM, taxes, and insurance.',
    `cam_amount` DECIMAL(18,2) COMMENT 'The Common Area Maintenance charge paid as part of this rent payment, covering shared facility costs such as landscaping, parking lot maintenance, and common utilities.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rent payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which this payment was made (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `days_late` STRING COMMENT 'The number of days between the payment due date and the actual payment date, indicating payment timeliness.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this payment is under dispute with the landlord due to billing discrepancies or lease interpretation issues.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the payment is flagged as disputed (e.g., incorrect CAM charges, billing error, lease term interpretation).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied if this payment was made in a foreign currency, used to convert to the companys reporting currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (e.g., 2024-01, 2024-Q1) to which this payment is allocated for financial reporting.',
    `gl_posting_date` DATE COMMENT 'The date on which this payment was posted to the general ledger for financial reporting purposes.',
    `insurance_amount` DECIMAL(18,2) COMMENT 'The insurance premium amount paid as part of this rent payment, covering property and liability insurance as required by the lease.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'The amount of late fee charged for this payment if payment was made after the due date.',
    `late_fee_applied_flag` BOOLEAN COMMENT 'Indicates whether a late fee was applied to this payment due to payment being made after the due date.',
    `lease_period_end_date` DATE COMMENT 'The end date of the lease period covered by this rent payment.',
    `lease_period_start_date` DATE COMMENT 'The start date of the lease period covered by this rent payment.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this rent payment record was last modified or updated.',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'Any additional charges or fees included in this rent payment that are not categorized as base rent, CAM, taxes, or insurance (e.g., utilities, parking fees, signage fees).',
    `payment_date` DATE COMMENT 'The date on which the rent payment was made or disbursed to the landlord.',
    `payment_due_date` DATE COMMENT 'The date by which this rent payment was contractually due per the lease agreement.',
    `payment_method` STRING COMMENT 'The payment instrument or method used to disburse the rent payment (e.g., ACH, wire transfer, check).. Valid values are `ACH|wire transfer|check|credit card|electronic funds transfer|cash`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments related to this payment, capturing special circumstances, adjustments, or additional context.',
    `payment_reference_number` STRING COMMENT 'External reference number or check number assigned to this payment for tracking and reconciliation purposes.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction indicating whether it has been processed, cleared, or is pending.. Valid values are `pending|processed|cleared|failed|cancelled|reversed`',
    `payment_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the scheduled payment amount and the actual total payment amount, indicating overpayment or underpayment.',
    `property_tax_amount` DECIMAL(18,2) COMMENT 'The property tax amount paid as part of this rent payment, representing the tenants share of real estate taxes.',
    `reconciliation_date` DATE COMMENT 'The date on which this payment was reconciled and approved in the accounts payable system.',
    `reconciliation_status` STRING COMMENT 'Indicates whether this payment has been reconciled against the lease schedule and landlord invoice, and whether any disputes exist.. Valid values are `unreconciled|reconciled|disputed|pending review|approved`',
    `scheduled_payment_amount` DECIMAL(18,2) COMMENT 'The originally scheduled or expected payment amount per the lease agreement for this period.',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The total amount paid in this rent payment transaction, including base rent, CAM, taxes, insurance, and any other charges.',
    CONSTRAINT pk_rent_payment PRIMARY KEY(`rent_payment_id`)
) COMMENT 'Transactional record of each rent and occupancy cost payment made to a landlord, capturing payment date, payment method, amount paid (base rent, CAM, taxes, insurance), payment reference number, lease period covered, variance from scheduled amount, late fee applied flag, and reconciliation status. Supports accounts payable integration with SAP S/4HANA, landlord dispute resolution, and occupancy cost audit trails. Distinct from the rent schedule (obligation) — this captures actual cash disbursements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` (
    `cam_reconciliation_id` BIGINT COMMENT 'System-generated unique identifier for each CAM reconciliation record.',
    `landlord_id` BIGINT COMMENT 'Identifier of the landlord party associated with the lease.',
    `lease_id` BIGINT COMMENT 'add column lease_id (BIGINT) with FK to realestate.lease.lease_id - CAM reconciliations must reference the lease governing the charges',
    `tenant_id` BIGINT COMMENT 'Identifier of the restaurant (tenant) for which CAM is being reconciled.',
    `audit_user` STRING COMMENT 'User ID of the person who performed the last audit action on the record.',
    `cam_adjustments_amount` DECIMAL(18,2) COMMENT 'Adjustments applied after audit (e.g., credits, penalties).',
    `cam_billed_amount` DECIMAL(18,2) COMMENT 'Total CAM charges billed by the landlord for the period.',
    `cam_cap_amount` DECIMAL(18,2) COMMENT 'Maximum CAM charge allowed under the lease cap provision.',
    `cam_estimated_amount` DECIMAL(18,2) COMMENT 'Estimated CAM payment made by the tenant during the period.',
    `cam_exclusions_amount` DECIMAL(18,2) COMMENT 'Amount of CAM charges excluded per lease terms (e.g., non‑recoverable items).',
    `cam_final_amount` DECIMAL(18,2) COMMENT 'Final net CAM amount after all adjustments, exclusions, and caps.',
    `cam_itemization_flag` BOOLEAN COMMENT 'Indicates whether detailed CAM line‑item breakdown is attached.',
    `cam_reconciliation_status` STRING COMMENT 'Current lifecycle status of the reconciliation record.. Valid values are `draft|pending|completed|disputed|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the reconciliation is under dispute.',
    `dispute_resolution_date` DATE COMMENT 'Date when the CAM dispute was resolved.',
    `dispute_status` STRING COMMENT 'Current status of any CAM dispute.. Valid values are `open|resolved|rejected|escalated`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the reconciliation.',
    `overpayment_credit_amount` DECIMAL(18,2) COMMENT 'Credit amount returned to the tenant for over‑payment of CAM.',
    `period_end_date` DATE COMMENT 'End date of the CAM billing period covered by this reconciliation.',
    `period_start_date` DATE COMMENT 'Start date of the CAM billing period covered by this reconciliation.',
    `reconciliation_number` STRING COMMENT 'Business identifier assigned to the reconciliation (e.g., CAM-2024-001).',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Date and time when the reconciliation was performed.',
    `reconciliation_type` STRING COMMENT 'Frequency or nature of the reconciliation.. Valid values are `annual|quarterly|monthly|ad_hoc`',
    `underpayment_due_amount` DECIMAL(18,2) COMMENT 'Amount the tenant owes to the landlord after reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    CONSTRAINT pk_cam_reconciliation PRIMARY KEY(`cam_reconciliation_id`)
) COMMENT 'Annual or periodic CAM (Common Area Maintenance) reconciliation record capturing the landlords actual CAM charges versus estimated CAM payments made during the reconciliation period. Tracks gross CAM billed, allowable CAM exclusions, CAM cap application, audit adjustments, final reconciled amount, overpayment credit or underpayment due, dispute flag, and resolution outcome. Supports CAM audit rights enforcement, CapEx vs. OpEx classification of CAM items, and occupancy cost management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` (
    `site_selection_id` BIGINT COMMENT 'Unique surrogate key for each site selection evaluation record.',
    `employee_id` BIGINT COMMENT 'Employee responsible for leading the evaluation.',
    `site_id` BIGINT COMMENT 'Reference to the master record of the candidate location.',
    `site_approval_authority_employee_id` BIGINT COMMENT 'Employee or executive who approved the site selection.',
    `site_created_by_user_employee_id` BIGINT COMMENT 'System user who created the record.',
    `site_employee_id` BIGINT COMMENT 'Employee responsible for leading the evaluation.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee or corporate unit for which the site is being evaluated.',
    `site_franchisee_id` BIGINT COMMENT 'Identifier of the franchisee or corporate unit for which the site is being evaluated.',
    `site_last_modified_by_user_employee_id` BIGINT COMMENT 'System user who last updated the record.',
    `tertiary_site_created_by_user_employee_id` BIGINT COMMENT 'System user who created the record.',
    `auv_projection` DECIMAL(18,2) COMMENT 'Projected average weekly sales per unit (in local currency).',
    `cannibalization_risk_score` STRING COMMENT 'Score (1‑10) estimating risk of cannibalizing existing stores.',
    `comments` STRING COMMENT 'Free‑form notes entered by evaluators.',
    `competition_score` STRING COMMENT 'Score (1‑10) indicating competitive pressure in the trade area.',
    `compliance_haccp_flag` BOOLEAN COMMENT 'Indicates whether the site meets HACCP food‑safety requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary fields.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `decision_date` DATE COMMENT 'Date the evaluation committee rendered its final decision.',
    `demographic_score` STRING COMMENT 'Numeric score (1‑10) reflecting demographic suitability.',
    `environmental_impact_score` STRING COMMENT 'Score (1‑10) assessing environmental sustainability considerations.',
    `evaluation_code` STRING COMMENT 'Human‑readable code assigned to the evaluation for tracking and reference.',
    `evaluation_stage` STRING COMMENT 'Most recent stage of the evaluation workflow.. Valid values are `initial_screening|trade_area_analysis|financial_modeling|committee_review|final_decision`',
    `evaluation_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation process was initiated.',
    `expected_employee_count` STRING COMMENT 'Projected number of staff required to operate the site.',
    `expected_fte` STRING COMMENT 'Projected full‑time equivalent labor units.',
    `lease_term_years` STRING COMMENT 'Length of the lease agreement for the site, if applicable.',
    `lease_type` STRING COMMENT 'Classification of lease cost structure.. Valid values are `gross|net|percentage|other`',
    `market_share_estimate_percent` DECIMAL(18,2) COMMENT 'Projected share of the local market captured by the new site.',
    `overall_site_score` DECIMAL(18,2) COMMENT 'Weighted composite score summarizing all evaluation criteria.',
    `payback_period_months` STRING COMMENT 'Estimated number of months to recoup the investment.',
    `projected_annual_sales` DECIMAL(18,2) COMMENT 'Estimated total sales for the first fiscal year.',
    `projected_capex_amount` DECIMAL(18,2) COMMENT 'Projected CAPEX specific to construction, equipment, and fit‑out.',
    `projected_cogs_percent` DECIMAL(18,2) COMMENT 'Estimated COGS as a percentage of sales.',
    `projected_investment_amount` DECIMAL(18,2) COMMENT 'Estimated total capital required to open the site.',
    `projected_labor_percent` DECIMAL(18,2) COMMENT 'Estimated labor cost as a percentage of sales.',
    `projected_roi_percent` DECIMAL(18,2) COMMENT 'Estimated ROI expressed as a percentage over the analysis horizon.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why a site was rejected.. Valid values are `location_unviable|financial_unviable|strategic_mismatch|regulatory_issue|other`',
    `risk_level` STRING COMMENT 'Overall risk classification for the site selection.. Valid values are `low|medium|high`',
    `site_area_sqft` DECIMAL(18,2) COMMENT 'Total usable square footage of the candidate location.',
    `site_selection_status` STRING COMMENT 'Current lifecycle status of the site selection evaluation.. Valid values are `pending|in_review|approved|rejected|withdrawn`',
    `traffic_score` STRING COMMENT 'Numeric score (1‑10) based on vehicle and foot traffic analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_site_selection PRIMARY KEY(`site_selection_id`)
) COMMENT 'Transactional record capturing the formal site selection evaluation process for a candidate restaurant location. Tracks evaluation stage (initial screening, trade area analysis, financial modeling, committee review, approved/rejected), site scoring criteria (demographics, traffic, competition proximity, cannibalization risk, AUV projection, payback period), evaluation team members, committee decision date, approval authority, and rejection reason code. Links to the site master and NRO pipeline. Supports FranConnect site selection workflows.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` (
    `nro_project_id` BIGINT COMMENT 'Unique system-generated identifier for the NRO development project.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchise entity that owns the new restaurant.',
    `nro_franchisee_id` BIGINT COMMENT 'Identifier of the franchise entity that owns the new restaurant.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: New‑restaurant opening projects use a general contractor (supplier); linking supports cost tracking and risk management.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: A NRO project is always associated with a physical site; linking to site eliminates silo and removes duplicated address columns.',
    `actual_opening_date` DATE COMMENT 'Actual date the restaurant opened for service.',
    `architect_name` STRING COMMENT 'Name of the architect or design firm responsible for the building design.',
    `capex_actual_amount` DECIMAL(18,2) COMMENT 'Total actual spend recorded against the project to date.',
    `capex_budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for the project before any spend is incurred.',
    `capex_committed_amount` DECIMAL(18,2) COMMENT 'Amount of budget that has been formally committed to vendors or contracts.',
    `certificate_of_occupancy_date` DATE COMMENT 'Date the Certificate of Occupancy was issued, allowing the restaurant to operate.',
    `compliance_status` STRING COMMENT 'Current compliance status with local health, safety, and regulatory requirements.. Valid values are `compliant|non_compliant|pending|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created in the lakehouse.',
    `nro_project_description` STRING COMMENT 'Free‑form description of the projects scope and objectives.',
    `ifr16_lease_asset_flag` BOOLEAN COMMENT 'Indicates whether the lease is accounted for as a right‑of‑use asset under IFRS 16.',
    `ifr16_lease_end_date` DATE COMMENT 'Effective end date of the IFRS 16 lease accounting period.',
    `ifr16_lease_start_date` DATE COMMENT 'Effective start date of the IFRS 16 lease accounting period.',
    `lease_obligation_end_date` DATE COMMENT 'End date of the lease obligation for the site.',
    `lease_obligation_start_date` DATE COMMENT 'Start date of the lease obligation for the site (IFRS 16 / ASC 842).',
    `lease_term_years` STRING COMMENT 'Total lease term expressed in years.',
    `lease_type` STRING COMMENT 'Classification of the lease (e.g., gross, net, percentage rent).. Valid values are `gross|net|percentage`',
    `nro_project_status` STRING COMMENT 'Current lifecycle status of the NRO project.. Valid values are `planned|approved|in_construction|completed|closed|cancelled`',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the permit, if applicable.',
    `permit_issue_date` DATE COMMENT 'Date the permit was issued.',
    `permit_number` STRING COMMENT 'Official permit identifier issued by the permitting authority.',
    `permitting_approval_date` DATE COMMENT 'Date when all required permits were approved.',
    `permitting_status` STRING COMMENT 'Current status of required construction and health permits.. Valid values are `pending|approved|rejected|expired`',
    `project_code` STRING COMMENT 'External business code or identifier used for the project in franchise and CapEx systems.',
    `project_manager_name` STRING COMMENT 'Name of the internal manager responsible for the NRO project.',
    `project_name` STRING COMMENT 'Human‑readable name of the development project.',
    `project_phase` STRING COMMENT 'Current high‑level phase of the NRO project lifecycle.. Valid values are `site_selection|design|permits|construction|fit_out|opening`',
    `project_phase_end_date` DATE COMMENT 'Projected or actual end date of the current project phase.',
    `project_phase_start_date` DATE COMMENT 'Date the current project phase began.',
    `project_type` STRING COMMENT 'Classification of the NRO project indicating whether it is a new build, remodel, relocation, or conversion.. Valid values are `new_build|remodel|relocation|conversion`',
    `risk_assessment_date` DATE COMMENT 'Date the most recent risk assessment was performed.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the project.. Valid values are `low|medium|high|critical`',
    `target_opening_date` DATE COMMENT 'Planned date for the restaurant to open to the public.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record.',
    CONSTRAINT pk_nro_project PRIMARY KEY(`nro_project_id`)
) COMMENT 'Master record for each New Restaurant Opening (NRO) development project, tracking the full lifecycle from site approval through construction completion and restaurant opening. Captures project name, restaurant unit number, project type (new build, relocation, conversion), target and actual opening dates, project manager, general contractor, architect of record, total CapEx budget reference, and blocking issues. Includes detailed construction milestone tracking: each milestone (site plan approval, permit submission, permit issuance, groundbreaking, foundation complete, steel erection, MEP rough-in, drywall, equipment installation, punch list, final inspection, certificate of occupancy, opening day) with planned date, actual date, variance in days, responsible party, completion status, and blocking issues. Supports critical path management, CapEx draw schedule alignment, and integration with SAP S/4HANA CapEx modules and FranConnect NRO tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` (
    `capex_budget_id` BIGINT COMMENT 'Unique surrogate key for each CapEx budget record.',
    `capex_project_id` BIGINT COMMENT 'Identifier of the CapEx project to which this budget belongs.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity owning the budget.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - CapEx budgets need unit-level granularity for restaurant investments',
    `amendment_date` DATE COMMENT 'Date the latest amendment was recorded.',
    `amendment_number` STRING COMMENT 'Sequential number of the most recent budget amendment.',
    `amendment_reason` STRING COMMENT 'Reason or justification for the most recent budget amendment.',
    `approval_date` DATE COMMENT 'Date the budget was formally approved.',
    `approving_authority` STRING COMMENT 'Name or identifier of the person/role that approved the budget.',
    `budget_code` STRING COMMENT 'External code or number used to reference the budget in finance systems.',
    `budget_name` STRING COMMENT 'Human‑readable name of the budget (e.g., "Downtown Store Build 2025").',
    `budget_phase` STRING COMMENT 'Current phase of the budget lifecycle.. Valid values are `planning|execution|closed`',
    `budget_revision_amount` DECIMAL(18,2) COMMENT 'Amount change applied during the latest budget revision.',
    `budget_revision_date` DATE COMMENT 'Date of the most recent budget reforecast or revision.',
    `budget_type` STRING COMMENT 'Category of the CapEx project the budget supports.. Valid values are `new_build|remodel|relocation|upgrade`',
    `building_shell_cost` DECIMAL(18,2) COMMENT 'Budget for structural construction of the building shell.',
    `capex_budget_status` STRING COMMENT 'Current lifecycle state of the budget record.. Valid values are `draft|submitted|approved|rejected|closed`',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code responsible for the budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget amounts.',
    `capex_budget_description` STRING COMMENT 'Free‑form description of the budget purpose and scope.',
    `end_date` DATE COMMENT 'Planned end date of the budget period.',
    `ffe_cost` DECIMAL(18,2) COMMENT 'Budget for furniture, fixtures, and equipment.',
    `funding_source` STRING COMMENT 'Source of capital funding (e.g., corporate cash, debt, lease financing).',
    `land_cost` DECIMAL(18,2) COMMENT 'Approved budget amount allocated for land acquisition.',
    `leasehold_improvements_cost` DECIMAL(18,2) COMMENT 'Budget for interior build‑out and leasehold improvements.',
    `notes` STRING COMMENT 'Additional remarks, comments, or special conditions.',
    `other_costs` DECIMAL(18,2) COMMENT 'Any additional budgeted cost items not captured by other categories.',
    `signage_cost` DECIMAL(18,2) COMMENT 'Budget for exterior and interior signage.',
    `soft_costs` DECIMAL(18,2) COMMENT 'Budget for professional services, permits, design, and other indirect costs.',
    `start_date` DATE COMMENT 'Planned start date of the budget period.',
    `technology_cost` DECIMAL(18,2) COMMENT 'Budget for POS, kitchen display, networking, and other technology.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Aggregate approved budget amount across all cost categories.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the budget record.',
    CONSTRAINT pk_capex_budget PRIMARY KEY(`capex_budget_id`)
) COMMENT 'CapEx (Capital Expenditure) planning, budgeting, and spend tracking record for each real estate project (NRO, remodel, relocation, or major facility upgrade). Budget envelope: total approved budget, budget by cost category (land, building shell, leasehold improvements, FF&E, signage, technology, soft costs), budget version, approval date, approving authority, funding source. Actual spend detail: each invoice-level expenditure event with vendor, cost category, amount, payment date, PO reference, SAP cost element, budget line item, cumulative spend to date, and variance to budget. Enables real-time CapEx tracking, budget burn rate monitoring, cost-to-complete forecasting, and draw schedule management. Integrates with SAP S/4HANA CO (Controlling) and Coupa Procurement for PO-to-invoice matching. Serves as the single source of truth for both authorized budgets and actual capital expenditures.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility record.',
    `legal_entity_id` BIGINT COMMENT 'add column legal_entity_id (BIGINT) with FK to finance.legal_entity.legal_entity_id - facilities need legal entity ownership for asset management and IFRS 16 compliance',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Facility belongs to a Site; linking provides parent relationship and removes duplicated address fields.',
    `ada_compliance_status` STRING COMMENT 'Indicates compliance with the Americans with Disabilities Act.. Valid values are `compliant|non_compliant`',
    `building_material` STRING COMMENT 'Primary material used in the construction of the facility (e.g., brick, steel).',
    `cam_charges` DECIMAL(18,2) COMMENT 'Common Area Maintenance charges associated with the facility.',
    `capex_spent` DECIMAL(18,2) COMMENT 'Capital expenditures incurred to date for the facility.',
    `facility_code` STRING COMMENT 'External business identifier or code for the facility used in operational systems.',
    `condition_score` DECIMAL(18,2) COMMENT 'Overall condition rating of the facility (e.g., 0-100 scale).',
    `construction_status` STRING COMMENT 'Status of any ongoing construction projects.. Valid values are `planned|under_construction|completed|on_hold`',
    `energy_rating` STRING COMMENT 'Energy efficiency rating of the facility.. Valid values are `A|B|C|D|E|F`',
    `facility_status` STRING COMMENT 'Current lifecycle status of the facility.. Valid values are `active|inactive|closed|pending`',
    `facility_type` STRING COMMENT 'Category of the facility based on its operational model.. Valid values are `restaurant|drive_thru|standalone|kiosk`',
    `fire_safety_compliance_status` STRING COMMENT 'Indicates compliance with fire safety regulations.. Valid values are `compliant|non_compliant`',
    `health_inspection_score` DECIMAL(18,2) COMMENT 'Score from the latest health inspection.',
    `hvac_type` STRING COMMENT 'Heating, ventilation, and air conditioning system type.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the facilitys insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Policy number for the facilitys insurance coverage.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent health or safety inspection.',
    `lease_end_date` DATE COMMENT 'End date of the lease agreement.',
    `lease_rate` DECIMAL(18,2) COMMENT 'Periodic lease payment amount (e.g., monthly rent).',
    `lease_start_date` DATE COMMENT 'Start date of the lease agreement for the facility.',
    `maintenance_last_date` DATE COMMENT 'Date when the most recent maintenance activity was performed.',
    `maintenance_next_due` DATE COMMENT 'Scheduled date for the next maintenance activity.',
    `facility_name` STRING COMMENT 'Descriptive name of the facility (e.g., restaurant location name).',
    `ownership_type` STRING COMMENT 'Indicates whether the facility is owned by the company or leased.. Valid values are `owned|leased`',
    `property_tax_rate` DECIMAL(18,2) COMMENT 'Applicable property tax rate (percentage).',
    `r_and_m_status` STRING COMMENT 'Current status of repairs and maintenance activities.. Valid values are `planned|in_progress|completed|deferred`',
    `remodel_date` DATE COMMENT 'Date of the most recent remodel or renovation.',
    `remodel_type` STRING COMMENT 'Scope of the most recent remodel.. Valid values are `full|partial|cosmetic`',
    `roof_type` STRING COMMENT 'Type of roof installed on the facility (e.g., flat, pitched).',
    `seating_capacity` STRING COMMENT 'Number of guest seats (covers) available in the front of house.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total building area in square feet.',
    `tax_assessment_value` DECIMAL(18,2) COMMENT 'Assessed property tax value of the facility.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Percentage of food waste relative to total food usage.',
    `year_built` STRING COMMENT 'Calendar year the facility was originally constructed.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of usable product yield from raw inputs.',
    `zoning_type` STRING COMMENT 'Zoning classification of the property (e.g., commercial, mixed-use).',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master record for the physical facility (building and improvements) associated with each restaurant location, capturing building square footage, seating capacity (FOH covers), drive-thru lane configuration (DT lanes, stacking capacity), kitchen layout type (BOH configuration), building ownership (owned/leased shell), year built, last remodel date, remodel type, ADA compliance status, energy rating, utility account references, and facility condition score. Distinct from the site (land/location) — this represents the built structure. Links to the restaurant unit in the restaurant domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` (
    `maintenance_work_order_id` BIGINT COMMENT 'System-generated unique identifier for the maintenance work order record.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Maintenance Approval workflow requires the franchisee to approve work orders for their locations, linking orders to the responsible franchisee.',
    `maintenance_contract_id` BIGINT COMMENT 'Foreign key linking to realestate.maintenance_contract. Business justification: Work orders are issued under a Maintenance Contract; linking captures this relationship.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal or contracted technician who performed the work.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant facility where the work order originated.',
    `maintenance_technician_employee_id` BIGINT COMMENT 'Identifier of the internal or contracted technician who performed the work.',
    `maintenance_unit_id` BIGINT COMMENT 'Identifier of the restaurant facility where the work order originated.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the external vendor or service provider assigned to the work order.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for cost amounts.. Valid values are `[A-Z]{3}`',
    `issue_category` STRING COMMENT 'Category of the maintenance issue (e.g., HVAC, plumbing, electrical, equipment, structural, exterior, signage, other). [ENUM-REF-CANDIDATE: hvac|plumbing|electrical|equipment|structural|exterior|signage|other — promote to reference product]',
    `issue_description` STRING COMMENT 'Detailed textual description of the maintenance issue reported.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Monetary cost of labor associated with the work order.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended to resolve the work order.',
    `maintenance_work_order_status` STRING COMMENT 'Current lifecycle status of the work order.. Valid values are `open|in_progress|completed|cancelled|on_hold`',
    `parts_cost` DECIMAL(18,2) COMMENT 'Monetary cost of parts and materials used for the work order.',
    `priority_level` STRING COMMENT 'Business-assigned priority indicating urgency of the work order.. Valid values are `low|medium|high|critical`',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance issue was reported.',
    `resolution_notes` STRING COMMENT 'Notes describing how the issue was resolved, including any follow‑up actions.',
    `scheduled_date` DATE COMMENT 'Planned date for the work to be performed.',
    `total_cost` DECIMAL(18,2) COMMENT 'Aggregate cost (labor + parts) for the work order.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the work order record.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether the work order is covered under a warranty claim.',
    `work_order_number` STRING COMMENT 'External business identifier assigned to the work order, used in communications and reporting.. Valid values are `^WO-d{6}$`',
    CONSTRAINT pk_maintenance_work_order PRIMARY KEY(`maintenance_work_order_id`)
) COMMENT 'Transactional record for each R&M (Repairs and Maintenance) work order issued for a restaurant facility, capturing work order number, facility, issue category (HVAC, plumbing, electrical, equipment, structural, exterior, signage), issue description, priority level, reported date, assigned vendor/technician, scheduled date, completion date, labor hours, parts cost, total cost, warranty claim flag, and resolution notes. Supports OpEx R&M spend tracking, vendor performance management, and preventive maintenance compliance. Integrates with facility management workflows.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` (
    `maintenance_contract_id` BIGINT COMMENT 'System-generated unique identifier for the maintenance contract record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Maintenance contracts are scoped to a specific Facility; linking enables hierarchy and reporting.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Maintenance contracts are agreements with specific suppliers; linking enables contract management and compliance tracking.',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract on an annual basis.',
    `applicable_restaurant_ids` STRING COMMENT 'Comma‑separated list of restaurant identifiers covered by the contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of its term.',
    `compliance_requirements` STRING COMMENT 'Specific regulatory or internal compliance obligations tied to the contract (e.g., HACCP, OSHA).',
    `contract_document_url` STRING COMMENT 'Link to the stored contract document (PDF, scanned copy, etc.).',
    `contract_manager_email` STRING COMMENT 'Email address of the contract manager.',
    `contract_manager_name` STRING COMMENT 'Name of the internal employee responsible for overseeing the contract.',
    `contract_manager_phone` STRING COMMENT 'Phone number of the contract manager.',
    `contract_number` STRING COMMENT 'External contract reference number used in vendor and internal communications.',
    `contract_type` STRING COMMENT 'Category of maintenance service covered by the contract.. Valid values are `hvac_pm|hood_cleaning|grease_trap|pest_control|elevator|fire_suppression`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts (e.g., USD).',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or is scheduled to terminate; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes binding.',
    `equipment_covered` STRING COMMENT 'List or description of equipment, systems, or assets that are covered by the contract.',
    `escalation_contact_email` STRING COMMENT 'Email address for escalation communications.',
    `escalation_contact_name` STRING COMMENT 'Name of the person to contact for escalations.',
    `escalation_contact_phone` STRING COMMENT 'Phone number for escalation communications.',
    `insurance_certificate_url` STRING COMMENT 'Link to the uploaded insurance certificate document.',
    `insurance_requirements` STRING COMMENT 'Insurance coverage requirements the vendor must maintain.',
    `invoice_due_days` STRING COMMENT 'Number of days after invoice receipt that payment is due.',
    `last_review_date` DATE COMMENT 'Date when the contract was last reviewed for compliance or performance.',
    `maintenance_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|suspended|terminated|pending|draft`',
    `next_review_date` DATE COMMENT 'Planned date for the next contract performance or compliance review.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the contract.',
    `payment_frequency` STRING COMMENT 'How often payments are made under the contract.. Valid values are `monthly|quarterly|annually|semi_annually|biweekly|weekly`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the vendor.. Valid values are `net30|net45|net60|net90|due_on_receipt|custom`',
    `penalty_clause` STRING COMMENT 'Description of penalties for non‑performance or breach of contract.',
    `regulatory_certifications` STRING COMMENT 'Certifications or approvals required for the service provider under applicable regulations.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period in months if auto‑renewal is enabled.',
    `service_area` STRING COMMENT 'Geographic region or set of restaurants the contract applies to.',
    `service_frequency` STRING COMMENT 'How often the maintenance service is scheduled to be performed.. Valid values are `daily|weekly|monthly|quarterly|annually|on_demand`',
    `service_provider_contact_email` STRING COMMENT 'Primary email address for the service providers point of contact.',
    `service_provider_contact_phone` STRING COMMENT 'Primary telephone number for the service providers point of contact.',
    `sla_description` STRING COMMENT 'Narrative description of service level commitments.',
    `sla_response_time_hours` STRING COMMENT 'Maximum response time promised by the vendor for service requests, expressed in hours.',
    `termination_notice_days` STRING COMMENT 'Number of days notice required to terminate the contract early.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the contract record.',
    `warranty_coverage_flag` BOOLEAN COMMENT 'Indicates whether the contract includes warranty coverage for the equipment.',
    `warranty_expiration_date` DATE COMMENT 'Date when any warranty coverage provided by the contract expires.',
    CONSTRAINT pk_maintenance_contract PRIMARY KEY(`maintenance_contract_id`)
) COMMENT 'Master record for each preventive maintenance and service contract covering restaurant facility equipment and systems, capturing contract type (HVAC PM, hood cleaning, grease trap, pest control, elevator, fire suppression, refrigeration), service provider, covered equipment list, service frequency, contract start and end dates, annual contract value, SLA response time, and auto-renewal terms. Enables R&M budget forecasting, vendor contract compliance tracking, and equipment warranty management. Distinct from procurement contracts — this is facility-specific service agreements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` (
    `lease_amendment_id` BIGINT COMMENT 'System-generated unique identifier for the lease amendment record.',
    `landlord_id` BIGINT COMMENT 'Identifier of the landlord party involved in the amendment.',
    `lease_id` BIGINT COMMENT 'Identifier of the original lease agreement to which this amendment applies.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the tenant (restaurant entity) affected by the amendment.',
    `tenant_id` BIGINT COMMENT 'Identifier of the tenant (restaurant entity) affected by the amendment.',
    `amendment_document_reference` STRING COMMENT 'Link or identifier to the stored amendment contract document.',
    `amendment_number` STRING COMMENT 'Business identifier assigned to the amendment (e.g., AM-2024-001).',
    `amendment_reason` STRING COMMENT 'Business rationale or driver for executing the amendment.',
    `amendment_summary` STRING COMMENT 'Brief textual summary of the amendment purpose and key changes.',
    `amendment_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the amendment event was recorded in the system.',
    `amendment_type` STRING COMMENT 'Category of the lease amendment describing the nature of the change. [ENUM-REF-CANDIDATE: rent_modification|term_extension|space_change|permitted_use_change|assignment_consent|landlord_work_letter|co_tenancy_waiver — 7 candidates stripped; promote to reference product]',
    `co_tenancy_waiver_flag` BOOLEAN COMMENT 'True if the amendment includes a waiver of co-tenancy requirements.',
    `effective_date` DATE COMMENT 'Date on which the amendment terms become legally effective.',
    `execution_date` DATE COMMENT 'Date the amendment was signed/executed by the parties.',
    `free_rent_months` STRING COMMENT 'Number of months of rent abatement granted by the amendment.',
    `ifrs16_impact_flag` BOOLEAN COMMENT 'True if the amendment triggers a remeasurement under IFRS 16 / ASC 842.',
    `lease_amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|pending|executed|cancelled|rejected`',
    `legal_review_status` STRING COMMENT 'Current status of the legal departments review of the amendment.. Valid values are `not_started|in_review|approved|rejected`',
    `net_impact_amount` DECIMAL(18,2) COMMENT 'Net financial impact of the amendment after considering rent change, free rent, TI allowance, etc.',
    `notes` STRING COMMENT 'Additional free-form comments or observations about the amendment.',
    `permitted_use_change_flag` BOOLEAN COMMENT 'True if the amendment modifies the permitted use of the leased space.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record.',
    `rent_change_amount` DECIMAL(18,2) COMMENT 'Monetary amount by which the periodic rent is increased (positive) or decreased (negative).',
    `rent_change_currency` STRING COMMENT 'ISO 4217 currency code for the rent change amount.. Valid values are `^[A-Z]{3}$`',
    `space_change_sqft` DECIMAL(18,2) COMMENT 'Change in leased square footage (positive for expansion, negative for reduction).',
    `space_change_type` STRING COMMENT 'Indicates whether the amendment expands, reduces, or leaves space unchanged.. Valid values are `increase|decrease|none`',
    `ti_allowance_amount` DECIMAL(18,2) COMMENT 'Monetary amount of tenant improvement allowance provided under the amendment.',
    `ti_allowance_currency` STRING COMMENT 'ISO 4217 currency code for the TI allowance amount.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_lease_amendment PRIMARY KEY(`lease_amendment_id`)
) COMMENT 'Transactional record for each lease lifecycle change event including executed amendments, renewal exercises, option exercises, and lease modifications. Captures event type (rent modification, term extension, renewal exercise, space expansion/reduction, permitted use change, assignment consent, landlord work letter, co-tenancy waiver, early termination), effective date, financial impact (rent change amount, TI allowance received, free rent granted, new rent amount, rent delta versus expiring rent), negotiation details (start date, option exercise deadline, negotiating broker, approval authority, negotiation outcome), option number exercised (for renewals), renewal term length, new expiration date, and execution date. Maintains complete modification and renewal history for IFRS 16 / ASC 842 lease modification accounting, proactive lease expiration management, and portfolio renewal pipeline tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` (
    `property_acquisition_id` BIGINT COMMENT 'System-generated unique identifier for the property acquisition record.',
    `capex_project_id` BIGINT COMMENT 'Identifier of the capital expenditure project linked to this acquisition.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier of the selling party (owner) of the property.',
    `property_legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that owns the acquired property.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: A property acquisition represents the purchase of a site; linking to site centralizes location data and removes duplicated address fields.',
    `acquiring_legal_entity_id` BIGINT COMMENT '',
    `acquisition_date` DATE COMMENT 'Date the property acquisition became effective (closing date).',
    `acquisition_number` STRING COMMENT 'Business-assigned identifier for the acquisition transaction, used in external reporting and contracts.',
    `acquisition_price` DECIMAL(18,2) COMMENT 'Purchase price paid to acquire the property before closing costs.',
    `capitalization_rate` DECIMAL(18,2) COMMENT 'Rate used to estimate the propertys value based on net operating income.',
    `closing_costs` DECIMAL(18,2) COMMENT 'Total ancillary costs incurred at closing (legal, escrow, fees).',
    `cost_center_code` STRING COMMENT 'Cost center responsible for the acquisition expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the acquisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|CAD|GBP|JPY|AUD`',
    `deed_recording_reference` STRING COMMENT 'Reference identifier for the recorded deed in the county recorder.',
    `due_diligence_completion_date` DATE COMMENT 'Date when all due‑diligence activities were finalized.',
    `effective_from` DATE COMMENT 'Date from which the acquisition record is considered effective for reporting.',
    `effective_until` DATE COMMENT 'Date until which the acquisition record remains active (null if open‑ended).',
    `environmental_assessment_status` STRING COMMENT 'Result of the environmental impact assessment.. Valid values are `completed|pending|failed`',
    `financing_structure` STRING COMMENT 'Method used to finance the acquisition.. Valid values are `cash|mortgage|sale_leaseback|other`',
    `lease_end_date` DATE COMMENT 'End date of the lease term.',
    `lease_obligation_flag` BOOLEAN COMMENT 'Indicates whether the acquisition includes a lease obligation subject to IFRS 16 / ASC 842.',
    `lease_start_date` DATE COMMENT 'Start date of the lease term.',
    `lease_term_years` STRING COMMENT 'Duration of the lease component, if applicable.',
    `lender_code` BIGINT COMMENT 'Identifier of the financial institution providing the loan.',
    `lender_name` STRING COMMENT 'Name of the lender or bank.',
    `loan_amount` DECIMAL(18,2) COMMENT 'Principal amount of any mortgage or loan used for the acquisition.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the acquisition.',
    `property_acquisition_status` STRING COMMENT 'Current lifecycle status of the acquisition transaction.. Valid values are `pending|approved|closed|rejected`',
    `property_type` STRING COMMENT 'Classification of the property asset.. Valid values are `land|building|leasehold|mixed_use`',
    `title_company_code` BIGINT COMMENT 'Identifier of the title company that performed the title search and insurance.',
    `title_company_name` STRING COMMENT 'Name of the title company handling the transaction.',
    `title_insurance_policy_number` STRING COMMENT 'Policy number of the title insurance covering the acquisition.',
    `total_acquisition_cost` DECIMAL(18,2) COMMENT 'Sum of acquisition price and all closing costs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the acquisition record.',
    CONSTRAINT pk_property_acquisition PRIMARY KEY(`property_acquisition_id`)
) COMMENT 'Master record for each owned property acquisition transaction, capturing property address, acquisition date, purchase price, closing costs, total acquisition cost, seller entity, title company, financing structure (cash, mortgage, sale-leaseback), loan amount, lender, capitalization rate, due diligence completion date, environmental assessment status, title insurance policy number, and deed recording reference. Supports fixed asset creation in SAP S/4HANA FA module and owned property portfolio management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` (
    `site_permit_id` BIGINT COMMENT 'Unique identifier for the site permit record.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Permit Management reports tie each permit to the franchisee responsible for compliance and renewal tracking.',
    `site_id` BIGINT COMMENT 'Identifier of the restaurant site associated with the permit.',
    `application_date` DATE COMMENT 'Date the permit application was initially submitted.',
    `approval_date` DATE COMMENT 'Date the permit was approved by the authority.',
    `audit_trail` STRING COMMENT 'Audit trail details for changes to the permit record.',
    `compliance_deadline` DATE COMMENT 'Deadline for achieving compliance as per permit conditions.',
    `compliance_notes` STRING COMMENT 'Notes related to compliance actions or observations.',
    `compliance_status` STRING COMMENT 'Current compliance status of the permit.. Valid values are `compliant|non_compliant|pending|revoked`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the permit fee.. Valid values are `^[A-Z]{3}$`',
    `document_storage_path` STRING COMMENT 'File system path or storage identifier for the permit document.',
    `document_url` STRING COMMENT 'Link to the digital copy of the permit document.',
    `effective_from` DATE COMMENT 'Date the permit becomes effective (usually approval date).',
    `effective_until` DATE COMMENT 'Date the permit ceases to be effective (expiration or revocation).',
    `expiration_date` DATE COMMENT 'Date the permit expires and must be renewed.',
    `fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the permit fee has been paid.',
    `fee_payment_date` DATE COMMENT 'Date the permit fee was paid.',
    `inspection_date` DATE COMMENT 'Date of the most recent inspection.',
    `inspection_due_date` DATE COMMENT 'Date by which the required inspection must be completed.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates if an inspection is required for this permit.',
    `inspection_result` STRING COMMENT 'Outcome of the most recent inspection.. Valid values are `pass|fail|conditional|pending`',
    `inspection_schedule` STRING COMMENT 'Scheduled date(s) or frequency for required inspections.',
    `issuing_authority` STRING COMMENT 'Governmental or municipal authority that issues the permit.',
    `last_inspection_comments` STRING COMMENT 'Comments recorded during the last inspection.',
    `last_inspection_observer` STRING COMMENT 'Name or identifier of the person/agency who performed the last inspection.',
    `notes` STRING COMMENT 'Free-text notes regarding the permit.',
    `permit_category` STRING COMMENT 'High-level category of the permit purpose.. Valid values are `construction|remodel|operation`',
    `permit_expiry_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the permit expires.',
    `permit_fee` DECIMAL(18,2) COMMENT 'Fee charged for the permit.',
    `permit_issue_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the permit was officially issued.',
    `permit_number` STRING COMMENT 'Official permit number assigned by the issuing authority.',
    `permit_status` STRING COMMENT 'Current processing status of the permit application.. Valid values are `applied|under_review|approved|issued|expired|revoked`',
    `permit_subtype` STRING COMMENT 'More specific subtype of the permit, if applicable.',
    `permit_type` STRING COMMENT 'Category of the permit.. Valid values are `building|electrical|plumbing|fire|health|signage`',
    `renewal_date` DATE COMMENT 'Date by which the permit must be renewed.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates if the permit requires renewal.',
    `revocation_date` DATE COMMENT 'Date the permit was revoked, if applicable.',
    `revocation_reason` STRING COMMENT 'Reason for permit revocation.',
    `site_permit_status` STRING COMMENT 'Overall lifecycle status of the permit record.. Valid values are `active|inactive|pending|closed|revoked`',
    `submission_date` DATE COMMENT 'Date the permit application was formally submitted to the authority.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    CONSTRAINT pk_site_permit PRIMARY KEY(`site_permit_id`)
) COMMENT 'Transactional record tracking each regulatory permit required for restaurant construction, remodel, or operation at a site, capturing permit type (building, electrical, plumbing, mechanical, fire, health department, signage, drive-thru, outdoor seating, liquor), issuing authority (municipality, county, state), application date, submission date, approval date, expiration date, permit number, permit fee, inspection schedule, and compliance status. Supports NRO critical path management and ongoing operational compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` (
    `trade_area_id` BIGINT COMMENT 'Unique system-generated identifier for each trade area record.',
    `site_id` BIGINT COMMENT 'add column site_id (BIGINT) with FK to realestate.site.site_id - trade areas are referenced by site but have no outbound FKs; adding geographic linkage improves navigability',
    `area_sq_miles` DECIMAL(18,2) COMMENT 'Surface area of the primary trade area measured in square miles.',
    `average_household_size` DECIMAL(18,2) COMMENT 'Mean number of individuals per household in the trade area.',
    `average_income_per_capita` DECIMAL(18,2) COMMENT 'Mean individual income within the trade area, expressed in US dollars.',
    `cannibalization_risk_score` DECIMAL(18,2) COMMENT 'Quantitative score (0‑100) estimating sales erosion risk due to nearby existing units.',
    `city` STRING COMMENT 'Municipality of the restaurant location.',
    `competition_count` STRING COMMENT 'Count of direct competitor locations inside the trade area.',
    `competition_names` STRING COMMENT 'Names of competing restaurant brands present in the trade area.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the trade area record was initially inserted into the system.',
    `data_vintage_date` DATE COMMENT 'Reference date indicating the snapshot date of the demographic and traffic data.',
    `daytime_population` STRING COMMENT 'Estimated total population present in the trade area during typical business hours.',
    `effective_from` DATE COMMENT 'Start date of the trade area’s validity period.',
    `effective_until` DATE COMMENT 'End date of the trade area’s validity period; null if open‑ended.',
    `employment_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of the working‑age population that is employed.',
    `geographic_region` STRING COMMENT 'Higher‑level region classification for reporting purposes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `market_share_score` DECIMAL(18,2) COMMENT 'Analyst‑derived score (0‑100) indicating the site’s potential market share.',
    `median_age` STRING COMMENT 'Median age of residents within the trade area.',
    `median_household_income` DECIMAL(18,2) COMMENT 'Median annual household income in US dollars for households within the trade area.',
    `methodology` STRING COMMENT 'Technique applied to generate the trade area boundaries (drive‑time, radius, or Voronoi).. Valid values are `drive_time|radius|voronoi`',
    `trade_area_name` STRING COMMENT 'Descriptive label used by analysts and planners to identify the trade area.',
    `notes` STRING COMMENT 'Additional remarks or observations entered by analysts.',
    `population_density_per_sq_mile` DECIMAL(18,2) COMMENT 'Number of people per square mile in the primary trade area.',
    `primary_boundary_drive_time_minutes` DECIMAL(18,2) COMMENT 'Maximum travel time in minutes for the primary trade area; null if not applicable.',
    `primary_boundary_geojson` STRING COMMENT 'GeoJSON representation of the primary trade‑area polygon.',
    `primary_boundary_radius_miles` DECIMAL(18,2) COMMENT 'Radius in miles for a circular primary trade area; null if not applicable.',
    `projected_auv` DECIMAL(18,2) COMMENT 'Forecasted annual sales for the restaurant location, expressed in US dollars.',
    `projected_cogs_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of sales that will be spent on food and beverage costs.',
    `projected_labor_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of sales allocated to labor expenses.',
    `residential_population` STRING COMMENT 'Count of people who reside in the trade area.',
    `secondary_boundary_drive_time_minutes` DECIMAL(18,2) COMMENT 'Maximum travel time in minutes for the secondary trade area; null if not applicable.',
    `secondary_boundary_geojson` STRING COMMENT 'GeoJSON representation of the secondary trade‑area polygon.',
    `secondary_boundary_radius_miles` DECIMAL(18,2) COMMENT 'Radius in miles for a circular secondary trade area; null if not applicable.',
    `state` STRING COMMENT 'Standard US state abbreviation (e.g., CA, NY).',
    `trade_area_status` STRING COMMENT 'Indicates whether the trade area is currently used for planning, retired, or archived.. Valid values are `active|inactive|archived`',
    `traffic_adt` STRING COMMENT 'Average number of vehicles passing per day on primary arteries within the trade area.',
    `traffic_peak_hour` STRING COMMENT 'Maximum vehicle count observed during the busiest hour of the day.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the trade area record.',
    `version` STRING COMMENT 'Incremental version used to track changes and resolve concurrent updates.',
    `zip_code` STRING COMMENT 'Five‑digit (or ZIP+4) postal code of the restaurant location.. Valid values are `^d{5}(-d{4})?$`',
    CONSTRAINT pk_trade_area PRIMARY KEY(`trade_area_id`)
) COMMENT 'Master record for trade area analysis and market development planning, serving both site-level evaluation and market-level strategic planning. Site level: captures trade area methodology (drive-time, radius, Voronoi), primary and secondary trade area boundaries, daytime and residential population, median household income, traffic count (ADT), competition count, cannibalization risk score, projected AUV, and data vintage date. Market level: captures market name, tier classification, total addressable restaurant count, current open unit count, pipeline unit count, whitespace unit count, development priority score, target opening cadence by year, franchise vs. company-owned split target, market development agreement reference, and plan approval date. Supports site selection scoring, market planning, portfolio optimization, NRO pipeline prioritization, franchise territory allocation, and strategic real estate portfolio planning.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`realestate_remodel_project` (
    `realestate_remodel_project_id` BIGINT COMMENT 'Unique identifier for the realestate_remodel_project data product (auto-inserted pre-linking).',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Each remodel project is executed under a procurement contract with a supplier; required for budgeting and regulatory audit.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Remodel projects are executed on a Facility; linking provides context and removes duplicate geolocation fields.',
    CONSTRAINT pk_realestate_remodel_project PRIMARY KEY(`realestate_remodel_project_id`)
) COMMENT 'Master record for each restaurant remodel or refresh project, capturing remodel type (full remodel, image refresh, drive-thru upgrade, digital menu board installation, accessibility upgrade), scope of work, CapEx budget reference, funding source (company-funded, franchisee-funded, co-investment), required completion date per brand standards, actual completion date, remodel generation/prototype version, before and after facility condition scores, franchisee consent status, and project milestone tracking. Distinct from NRO projects — remodels apply to existing operating restaurants. Supports brand image compliance, franchise agreement remodel obligations, and facility lifecycle management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` (
    `menu_item_site_offering_id` BIGINT COMMENT 'Primary key for the MenuItemSiteOffering association',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to the menu_item',
    `site_id` BIGINT COMMENT 'Foreign key linking to the site',
    `discontinue_date` DATE COMMENT 'Date the menu item is removed from the site menu',
    `is_lto` BOOLEAN COMMENT 'Indicates if the offering is a limited‑time promotion at the site',
    `launch_date` DATE COMMENT 'Date the menu item becomes available at the site',
    `lto_end_date` DATE COMMENT 'End date of the limited‑time offer for this site',
    `lto_start_date` DATE COMMENT 'Start date of the limited‑time offer for this site',
    CONSTRAINT pk_menu_item_site_offering PRIMARY KEY(`menu_item_site_offering_id`)
) COMMENT 'Represents the assignment of a menu_item to a site with site‑specific availability dates and limited‑time‑offer status. Each record links one menu_item to one site and captures attributes that exist only in the context of this relationship.. Existence Justification: A menu item can be sold at many restaurant sites, and each site serves many menu items. The business actively manages which items are offered at each site, tracking site‑specific launch and discontinue dates as well as limited‑time‑offer flags.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`realestate`.`tenant` (
    `tenant_id` BIGINT COMMENT 'Primary key for tenant',
    `parent_tenant_id` BIGINT COMMENT 'Self-referencing FK on tenant (parent_tenant_id)',
    `tax_id` BIGINT COMMENT 'Government‑issued tax identifier for the tenant (e.g., EIN for U.S. entities).',
    `address_line1` STRING COMMENT 'Primary street address of the tenants premises.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `annual_rent_amount` DECIMAL(18,2) COMMENT 'Annual rent payable by the tenant under the lease agreement.',
    `city` STRING COMMENT 'City component of the tenants address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the tenants location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the tenant record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for rent and financial amounts.',
    `is_primary_tenant` BOOLEAN COMMENT 'True if this tenant is the primary occupant of the property; false otherwise.',
    `lease_end_date` DATE COMMENT 'Date when the tenants lease agreement terminates or expires (nullable for open‑ended leases).',
    `lease_start_date` DATE COMMENT 'Date when the tenants lease agreement becomes effective.',
    `legal_name` STRING COMMENT 'Full legal name of the tenant as registered with governmental authorities.',
    `tenant_name` STRING COMMENT 'Commonly used name of the tenant (e.g., brand or operating name).',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or special conditions related to the tenant.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the tenants address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary tenant contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary person to contact for lease and property matters.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary tenant contact.',
    `square_feet` DECIMAL(18,2) COMMENT 'Total square footage of the space leased by the tenant.',
    `state_province` STRING COMMENT 'State or province component of the tenants address.',
    `tenant_status` STRING COMMENT 'Current operational status of the tenant relationship.',
    `tenant_type` STRING COMMENT 'Category describing the nature of the tenant entity.',
    CONSTRAINT pk_tenant PRIMARY KEY(`tenant_id`)
) COMMENT 'Master reference table for tenant. Referenced by tenant_id.';

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
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ADD CONSTRAINT `fk_realestate_cam_reconciliation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`lease`(`lease_id`);
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
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`realestate_remodel_project` ADD CONSTRAINT `fk_realestate_realestate_remodel_project_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ADD CONSTRAINT `fk_realestate_menu_item_site_offering_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`site`(`site_id`);
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ADD CONSTRAINT `fk_realestate_tenant_parent_tenant_id` FOREIGN KEY (`parent_tenant_id`) REFERENCES `vibe_restaurants_v1`.`realestate`.`tenant`(`tenant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`realestate` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_restaurants_v1`.`realestate` SET TAGS ('dbx_domain' = 'realestate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord Id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `landlord_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Entity Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `trade_area_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `trade_area_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `accessibility_score` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Score');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Site Acquisition Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `building_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Building Square Footage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Site Closure Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `daily_traffic_count` SET TAGS ('dbx_business_glossary_term' = 'Daily Traffic Count');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `drive_thru_capable` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Capable');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `lease_commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `lot_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Lot Square Footage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `market_classification` SET TAGS ('dbx_business_glossary_term' = 'Market Classification');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `market_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|highway|airport|campus');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `monthly_base_rent` SET TAGS ('dbx_business_glossary_term' = 'Monthly Base Rent');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `monthly_base_rent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `monthly_cam_charges` SET TAGS ('dbx_business_glossary_term' = 'Monthly Common Area Maintenance (CAM) Charges');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `monthly_cam_charges` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Site Opening Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'owned|leased|ground_lease|franchise_owned');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `parking_spaces` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `percentage_rent_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Rate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `percentage_rent_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `percentage_rent_threshold` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Threshold');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `percentage_rent_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `projected_auv` SET TAGS ('dbx_business_glossary_term' = 'Projected Average Unit Volume (AUV)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `projected_auv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `site_number` SET TAGS ('dbx_business_glossary_term' = 'Site Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `site_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `total_capex_investment` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Expenditure (CapEx) Investment');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `total_capex_investment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `visibility_score` SET TAGS ('dbx_business_glossary_term' = 'Visibility Score');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_business_glossary_term' = 'Zoning Classification');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `accounting_classification` SET TAGS ('dbx_business_glossary_term' = 'Accounting Classification (IFRS 16 / ASC 842)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `accounting_classification` SET TAGS ('dbx_value_regex' = 'operating_lease|finance_lease');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `base_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `base_rent_frequency` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Payment Frequency');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `base_rent_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `cam_charges_annual` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Charges (Annual)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `co_tenancy_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Tenancy Clause Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Incremental Borrowing Rate (Discount Rate) (%)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Lease Document URL');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `exclusive_use_rights` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Use Rights');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Execution Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `guarantor_entity` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Entity');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `insurance_annual` SET TAGS ('dbx_business_glossary_term' = 'Property Insurance (Annual)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `lease_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|renewed|pending_renewal');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'ground_lease|building_lease|sublease|license_agreement');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `liability_value` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Value');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `percentage_rent_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Rate (%)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `percentage_rent_threshold` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Threshold');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `permitted_use` SET TAGS ('dbx_business_glossary_term' = 'Permitted Use');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `property_tax_annual` SET TAGS ('dbx_business_glossary_term' = 'Property Tax (Annual)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `remaining_term_months` SET TAGS ('dbx_business_glossary_term' = 'Remaining Lease Term (Months)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `renewal_option_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Count');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `renewal_option_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Term (Months)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `rent_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate (%)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_percentage|cpi_indexed|fair_market_value|none');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `rou_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Value');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Lease Term (Months)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `termination_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Penalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord Identifier');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `cam_billing_method` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Billing Method');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `cam_billing_method` SET TAGS ('dbx_value_regex' = 'fixed|pro_rata|reconciliation|pass_through|none');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Landlord Entity Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'REIT|private_owner|developer|municipality|institutional_investor|family_trust');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `escalation_history_count` SET TAGS ('dbx_business_glossary_term' = 'Escalation History Count');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `insurance_certificate_frequency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Frequency');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `insurance_certificate_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|upon_renewal|not_required');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `insurance_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `landlord_status` SET TAGS ('dbx_business_glossary_term' = 'Landlord Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `landlord_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `last_escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Escalation Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Landlord Legal Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `negotiation_posture` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Posture');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `negotiation_posture` SET TAGS ('dbx_value_regex' = 'collaborative|firm|aggressive|flexible|unresponsive');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Landlord Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `portfolio_property_count` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Property Count');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|portal|mail|fax|in_person');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9][0-9]{1,14}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Health Score');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Relationship Tier');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|standard|limited|probationary');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `tax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `w9_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'W-9 Last Updated Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `w9_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'W-9 Form On File Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`landlord` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord Id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `landlord_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `rent_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `base_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `cam_amount` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `cam_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Reconciliation Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Escalation Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'fixed|cpi|percentage|stepped|none');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `interest_expense` SET TAGS ('dbx_business_glossary_term' = 'Interest Expense');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `lease_accounting_classification` SET TAGS ('dbx_business_glossary_term' = 'Lease Accounting Classification');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `lease_accounting_classification` SET TAGS ('dbx_value_regex' = 'operating|finance');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `lease_liability_reduction` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Reduction');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `occupancy_cost_percentage` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Cost Percentage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Charges Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'scheduled|paid|partial|overdue|waived|disputed');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `percentage_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `percentage_rent_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Rate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `percentage_rent_threshold` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Threshold');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `property_address` SET TAGS ('dbx_business_glossary_term' = 'Property Address');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `property_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `property_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `real_estate_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `rent_per_square_foot` SET TAGS ('dbx_business_glossary_term' = 'Rent Per Square Foot');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `reported_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Reported Sales Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `reported_sales_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `right_of_use_asset_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Depreciation');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `sales_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sales Reporting Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `tax_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reconciliation Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_schedule` ALTER COLUMN `total_occupancy_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Occupancy Cost');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `rent_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Payment ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `rent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `rent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `rent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `rent_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `base_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `cam_amount` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `days_late` SET TAGS ('dbx_business_glossary_term' = 'Days Late');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `late_fee_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Applied Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `lease_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `lease_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Charges Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire transfer|check|credit card|electronic funds transfer|cash');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|cancelled|reversed');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `payment_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `property_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|disputed|pending review|approved');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `scheduled_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`rent_payment` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant (Restaurant) ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User Identifier');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'CAM Adjustments Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'CAM Billed Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'CAM Cap Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'CAM Estimated Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_exclusions_amount` SET TAGS ('dbx_business_glossary_term' = 'CAM Exclusions Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_final_amount` SET TAGS ('dbx_business_glossary_term' = 'CAM Final Reconciled Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_itemization_flag` SET TAGS ('dbx_business_glossary_term' = 'CAM Itemization Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `cam_reconciliation_status` SET TAGS ('dbx_value_regex' = 'draft|pending|completed|disputed|closed');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'CAM Dispute Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'CAM Dispute Resolution Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'CAM Dispute Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|resolved|rejected|escalated');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `overpayment_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Credit Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'CAM Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'CAM Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|ad_hoc');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `underpayment_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Underpayment Due Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`cam_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_selection_id` SET TAGS ('dbx_business_glossary_term' = 'Site Selection Record ID (SSID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Evaluator Identifier (PRIMARY_EVAL_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Master Identifier (SITE_MASTER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_approval_authority_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Identifier (APPROVAL_AUTH_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_approval_authority_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_approval_authority_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (CREATED_BY_USER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Evaluator Identifier (PRIMARY_EVAL_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier (FRANCHISE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier (FRANCHISE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (MODIFIED_BY_USER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `tertiary_site_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (CREATED_BY_USER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `tertiary_site_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `tertiary_site_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `auv_projection` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume Projection (AUV_PROJ)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `cannibalization_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Cannibalization Risk Score (CANNIB_RISK_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Comments (EVAL_COMMENTS)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `competition_score` SET TAGS ('dbx_business_glossary_term' = 'Competition Proximity Score (COMP_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `compliance_haccp_flag` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Flag (HACCP_COMPL)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Decision Date (DECISION_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `demographic_score` SET TAGS ('dbx_business_glossary_term' = 'Demographic Score (DEMOG_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score (ENV_IMPACT_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `evaluation_code` SET TAGS ('dbx_business_glossary_term' = 'Site Selection Evaluation Code (SSEC)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `evaluation_stage` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Stage (EVAL_STAGE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `evaluation_stage` SET TAGS ('dbx_value_regex' = 'initial_screening|trade_area_analysis|financial_modeling|committee_review|final_decision');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `evaluation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Process Start Timestamp (EVAL_START_TS)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `expected_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Employee Count (EXP_EMP_COUNT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `expected_fte` SET TAGS ('dbx_business_glossary_term' = 'Expected Full-Time Equivalent (EXP_FTE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `lease_term_years` SET TAGS ('dbx_business_glossary_term' = 'Lease Term in Years (LEASE_TERM_YRS)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type (LEASE_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'gross|net|percentage|other');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `market_share_estimate_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Market Share Percent (MARKET_SHARE_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `overall_site_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Site Score (OVERALL_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period in Months (PAYBACK_MONTHS)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `projected_annual_sales` SET TAGS ('dbx_business_glossary_term' = 'Projected Annual Sales (PROJ_ANNUAL_SALES)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `projected_capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Projected Capital Expenditure Amount (PROJ_CAPEX_AMT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `projected_cogs_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Cost of Goods Sold Percent (PROJ_COGS_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `projected_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Projected Investment Amount (PROJ_INV_AMT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `projected_labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Labor Cost Percent (PROJ_LABOR_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `projected_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Return on Investment Percent (PROJ_ROI_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code (REJ_REASON_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = 'location_unviable|financial_unviable|strategic_mismatch|regulatory_issue|other');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LEVEL)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Site Area in Square Feet (SITE_AREA_SQFT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_selection_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status (EVAL_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `site_selection_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected|withdrawn');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `traffic_score` SET TAGS ('dbx_business_glossary_term' = 'Traffic Score (TRAFFIC_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_selection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `nro_project_id` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Project Identifier');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `nro_franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'General Contractor Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `actual_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Opening Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `architect_name` SET TAGS ('dbx_business_glossary_term' = 'Architect of Record Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `capex_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'CapEx Actual Spend Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `capex_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `capex_committed_amount` SET TAGS ('dbx_business_glossary_term' = 'CapEx Committed Spend Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `certificate_of_occupancy_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `nro_project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `ifr16_lease_asset_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease Asset Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `ifr16_lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `ifr16_lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `lease_obligation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Obligation End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `lease_obligation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Obligation Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `lease_term_years` SET TAGS ('dbx_business_glossary_term' = 'Lease Term (Years)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'gross|net|percentage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `nro_project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `nro_project_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_construction|completed|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `permitting_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Permitting Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `permitting_status` SET TAGS ('dbx_business_glossary_term' = 'Permitting Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `permitting_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'site_selection|design|permits|construction|fit_out|opening');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_phase_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project Phase End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_phase_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Phase Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type (New Build, Remodel, Relocation, Conversion)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_build|remodel|relocation|conversion');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Project Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `target_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Target Opening Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`nro_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Budget ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'CapEx Project ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_phase` SET TAGS ('dbx_business_glossary_term' = 'Budget Phase');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_phase` SET TAGS ('dbx_value_regex' = 'planning|execution|closed');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_revision_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type (New Build, Remodel, Relocation, Upgrade)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'new_build|remodel|relocation|upgrade');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `building_shell_cost` SET TAGS ('dbx_business_glossary_term' = 'Building Shell Cost');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `capex_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `capex_budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `capex_budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `ffe_cost` SET TAGS ('dbx_business_glossary_term' = 'Furniture, Fixtures & Equipment (FF&E) Cost');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `land_cost` SET TAGS ('dbx_business_glossary_term' = 'Land Cost');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `leasehold_improvements_cost` SET TAGS ('dbx_business_glossary_term' = 'Leasehold Improvements Cost');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `other_costs` SET TAGS ('dbx_business_glossary_term' = 'Other Costs');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `signage_cost` SET TAGS ('dbx_business_glossary_term' = 'Signage Cost');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `soft_costs` SET TAGS ('dbx_business_glossary_term' = 'Soft Costs');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `technology_cost` SET TAGS ('dbx_business_glossary_term' = 'Technology Cost');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`capex_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `ada_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'ADA Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `ada_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `building_material` SET TAGS ('dbx_business_glossary_term' = 'Building Material');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `cam_charges` SET TAGS ('dbx_business_glossary_term' = 'CAM Charges');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `capex_spent` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Spent');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `condition_score` SET TAGS ('dbx_business_glossary_term' = 'Facility Condition Score');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `construction_status` SET TAGS ('dbx_business_glossary_term' = 'Construction Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `construction_status` SET TAGS ('dbx_value_regex' = 'planned|under_construction|completed|on_hold');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `energy_rating` SET TAGS ('dbx_business_glossary_term' = 'Energy Rating');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `energy_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'restaurant|drive_thru|standalone|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `fire_safety_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `fire_safety_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Score');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `hvac_type` SET TAGS ('dbx_business_glossary_term' = 'HVAC Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `lease_rate` SET TAGS ('dbx_business_glossary_term' = 'Lease Rate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `maintenance_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `maintenance_next_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `property_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `r_and_m_status` SET TAGS ('dbx_business_glossary_term' = 'Repairs & Maintenance Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `r_and_m_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|deferred');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `remodel_date` SET TAGS ('dbx_business_glossary_term' = 'Last Remodel Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `remodel_type` SET TAGS ('dbx_business_glossary_term' = 'Remodel Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `remodel_type` SET TAGS ('dbx_value_regex' = 'full|partial|cosmetic');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `roof_type` SET TAGS ('dbx_business_glossary_term' = 'Roof Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity (FOH Covers)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage (SQFT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `tax_assessment_value` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Value');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Food Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`facility` ALTER COLUMN `zoning_type` SET TAGS ('dbx_business_glossary_term' = 'Zoning Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `maintenance_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `maintenance_technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `maintenance_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `maintenance_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `maintenance_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp (CT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `issue_category` SET TAGS ('dbx_business_glossary_term' = 'Issue Category (IC)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description (ID)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost (LC)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours (LH)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `maintenance_work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status (WOS)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `maintenance_work_order_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost (PC)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PL)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp (RT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes (RN)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date (SD)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost (TC)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag (WCF)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number (WON)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-d{6}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `applicable_restaurant_ids` SET TAGS ('dbx_business_glossary_term' = 'Applicable Restaurant IDs');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Email');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Phone');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'hvac_pm|hood_cleaning|grease_trap|pest_control|elevator|fire_suppression');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `equipment_covered` SET TAGS ('dbx_business_glossary_term' = 'Equipment Covered');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `insurance_certificate_url` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate URL');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `invoice_due_days` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Days');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `maintenance_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `maintenance_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending|draft');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|semi_annually|biweekly|weekly');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|net90|due_on_receipt|custom');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `regulatory_certifications` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Certifications');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_area` SET TAGS ('dbx_business_glossary_term' = 'Service Area');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|on_demand');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `service_provider_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `sla_description` SET TAGS ('dbx_business_glossary_term' = 'SLA Description');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (Hours)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `warranty_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`maintenance_contract` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `lease_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Amendment ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `amendment_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Reference');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `amendment_summary` SET TAGS ('dbx_business_glossary_term' = 'Amendment Summary');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `amendment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `co_tenancy_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Tenancy Waiver Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `free_rent_months` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Months');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `ifrs16_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS16 Impact Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `lease_amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `lease_amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending|executed|cancelled|rejected');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_review|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `net_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Financial Impact Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `permitted_use_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Permitted Use Change Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `rent_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Rent Change Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `rent_change_currency` SET TAGS ('dbx_business_glossary_term' = 'Rent Change Currency');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `rent_change_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `space_change_sqft` SET TAGS ('dbx_business_glossary_term' = 'Space Change Square Feet');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `space_change_type` SET TAGS ('dbx_business_glossary_term' = 'Space Change Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `space_change_type` SET TAGS ('dbx_value_regex' = 'increase|decrease|none');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `ti_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement Allowance Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `ti_allowance_currency` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement Allowance Currency');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`lease_amendment` ALTER COLUMN `ti_allowance_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `property_acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Property Acquisition ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Project ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_renamed_from' = 'legal_entity_id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `property_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `acquisition_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `acquisition_price` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Price');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `capitalization_rate` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `closing_costs` SET TAGS ('dbx_business_glossary_term' = 'Closing Costs');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `deed_recording_reference` SET TAGS ('dbx_business_glossary_term' = 'Deed Recording Reference');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `due_diligence_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `financing_structure` SET TAGS ('dbx_business_glossary_term' = 'Financing Structure');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `financing_structure` SET TAGS ('dbx_value_regex' = 'cash|mortgage|sale_leaseback|other');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `lease_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Obligation Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `lease_term_years` SET TAGS ('dbx_business_glossary_term' = 'Lease Term (Years)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `lender_code` SET TAGS ('dbx_business_glossary_term' = 'Lender ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `lender_name` SET TAGS ('dbx_business_glossary_term' = 'Lender Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `property_acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `property_acquisition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|closed|rejected');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Property Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `property_type` SET TAGS ('dbx_value_regex' = 'land|building|leasehold|mixed_use');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `title_company_code` SET TAGS ('dbx_business_glossary_term' = 'Title Company ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `title_company_name` SET TAGS ('dbx_business_glossary_term' = 'Title Company Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `title_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `total_acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Acquisition Cost');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`property_acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `site_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Site Permit ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|revoked');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Paid Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Due Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `inspection_schedule` SET TAGS ('dbx_business_glossary_term' = 'Inspection Schedule');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `last_inspection_comments` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Comments');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `last_inspection_observer` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Observer');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_business_glossary_term' = 'Permit Category');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_value_regex' = 'construction|remodel|operation');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_fee` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'applied|under_review|approved|issued|expired|revoked');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_subtype` SET TAGS ('dbx_business_glossary_term' = 'Permit Subtype');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'building|electrical|plumbing|fire|health|signage');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `site_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Record Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `site_permit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|revoked');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`site_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `trade_area_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Identifier');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `area_sq_miles` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Size (Square Miles)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `average_household_size` SET TAGS ('dbx_business_glossary_term' = 'Average Household Size');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `average_income_per_capita` SET TAGS ('dbx_business_glossary_term' = 'Per Capita Income (USD)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `cannibalization_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Cannibalization Risk Score');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `competition_count` SET TAGS ('dbx_business_glossary_term' = 'Competition Count');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `competition_names` SET TAGS ('dbx_business_glossary_term' = 'Competition Names');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `data_vintage_date` SET TAGS ('dbx_business_glossary_term' = 'Data Vintage Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `daytime_population` SET TAGS ('dbx_business_glossary_term' = 'Daytime Population');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `employment_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Employment Rate (Percent)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `market_share_score` SET TAGS ('dbx_business_glossary_term' = 'Market Share Score');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `median_age` SET TAGS ('dbx_business_glossary_term' = 'Median Age');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `median_household_income` SET TAGS ('dbx_business_glossary_term' = 'Median Household Income (USD)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Methodology');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'drive_time|radius|voronoi');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `trade_area_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `population_density_per_sq_mile` SET TAGS ('dbx_business_glossary_term' = 'Population Density (Per Sq Mile)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `primary_boundary_drive_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Primary Boundary Drive‑Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `primary_boundary_geojson` SET TAGS ('dbx_business_glossary_term' = 'Primary Trade Area Geometry (GeoJSON)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `primary_boundary_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Primary Boundary Radius (Miles)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `projected_auv` SET TAGS ('dbx_business_glossary_term' = 'Projected Average Unit Volume (AUV)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `projected_cogs_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected COGS Percent');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `projected_labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Labor Percent');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `residential_population` SET TAGS ('dbx_business_glossary_term' = 'Residential Population');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `secondary_boundary_drive_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Secondary Boundary Drive‑Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `secondary_boundary_geojson` SET TAGS ('dbx_business_glossary_term' = 'Secondary Trade Area Geometry (GeoJSON)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `secondary_boundary_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Secondary Boundary Radius (Miles)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `trade_area_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `trade_area_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `traffic_adt` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Traffic (ADT)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `traffic_peak_hour` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour Traffic');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`trade_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`realestate_remodel_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`realestate_remodel_project` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`realestate_remodel_project` ALTER COLUMN `realestate_remodel_project_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for realestate_remodel_project');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`realestate_remodel_project` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`realestate_remodel_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` SET TAGS ('dbx_subdomain' = 'site_development');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` SET TAGS ('dbx_association_edges' = 'menu.menu_item,realestate.site');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ALTER COLUMN `menu_item_site_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Menuitemsiteoffering - Menu Item Site Id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menuitemsiteoffering - Menu Item Id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Menuitemsiteoffering - Site Id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ALTER COLUMN `discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinue Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ALTER COLUMN `is_lto` SET TAGS ('dbx_business_glossary_term' = 'Limited‑Time Offer Flag');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ALTER COLUMN `lto_end_date` SET TAGS ('dbx_business_glossary_term' = 'LTO End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`menu_item_site_offering` ALTER COLUMN `lto_start_date` SET TAGS ('dbx_business_glossary_term' = 'LTO Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` SET TAGS ('dbx_subdomain' = 'lease_management');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `parent_tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tenant Id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `parent_tenant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tax_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Id');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `annual_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Rent Amount');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `is_primary_tenant` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Tenant');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tenant_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tenant_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tenant_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `square_feet` SET TAGS ('dbx_business_glossary_term' = 'Square Feet');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tenant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`realestate`.`tenant` ALTER COLUMN `tenant_type` SET TAGS ('dbx_business_glossary_term' = 'Tenant Type');
