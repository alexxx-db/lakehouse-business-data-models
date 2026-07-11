-- Schema for Domain: production | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`production` COMMENT 'Manages the end-to-end content production and post-production workflow — from greenlight and pre-production planning through principal photography, editing, VFX, color grading, audio mixing, transcoding, and final delivery. Tracks production budgets, crew assignments, shoot schedules, facility bookings, equipment allocation, and deliverable milestones. Integrates with Dalet Galaxy for ingest and workflow orchestration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Production projects bill clients/studios for production services, co-production arrangements, or facility rentals through billing accounts. Essential for production service invoicing, milestone billin',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Production projects are planned and budgeted against specific broadcast facilities for transmission/distribution. Real-world production planning requires facility assignment for capacity planning, tec',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Productions must operate under specific broadcast licenses for regulatory compliance, rights clearance, and distribution authorization. Essential for FCC compliance reporting and license renewal proce',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Branded content and product integration productions are commissioned for specific advertiser campaigns. Business process: sponsor deliverable tracking, advertiser-funded content production management, [FK namespace reconciled: points to sales.campaign]',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Projects are commissioned for specific broadcast channels/networks. Network commissioning process requires tracking which channel ordered the content. Essential for content planning, budget allocation',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Projects targeting children must have COPPA declarations on file before production begins. Required for greenlight approval and distribution planning for childrens programming.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Projects often have master license agreements governing distribution rights (co-production deals, pre-sales, output deals). Real business need: tracking which license agreements fund or govern a produ',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content licensing and syndication sales opportunities reference specific production projects to verify rights availability, establish cost basis for pricing, coordinate delivery schedules, and ensure ',
    `title_id` BIGINT COMMENT 'FK to content.title.title_id — Critical production-to-content traceability: must answer what content title does this production project produce? for scheduling, rights clearance, and financial reporting workflows.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Production projects are executed by or with external production companies (partners). Linking enables contract management, payment processing, co-production tracking, and rights negotiation. The `prod',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Projects must track which regulatory obligations apply based on content type, distribution channels, and target audience. Drives compliance planning and budget allocation for regulatory requirements.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Showrunner is a formal employment role in episodic production tracked in HR systems for compensation, guild reporting (WGA/DGA), and on-screen credits—critical for series content.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Productions are commissioned for specific streaming platforms (Netflix Originals, HBO Max Exclusives). Platform determines technical specs, content ratings, delivery windows. Real business process: pl',
    `actual_delivery_date` DATE COMMENT 'Date on which the final deliverable was actually delivered to the distribution or broadcast platform. Compared against target_delivery_date to measure on-time delivery performance and SLA compliance.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred against this production project to date, denominated in US Dollars. Sourced from SAP S/4HANA cost postings. Compared against approved_budget_usd for variance and financial reconciliation reporting.',
    `approved_budget_usd` DECIMAL(18,2) COMMENT 'Total production budget formally approved at greenlight, denominated in US Dollars. Represents the authorized spend ceiling for the project. Used for financial controlling, variance analysis, and EBITDA reporting in SAP S/4HANA.',
    `co_production_flag` BOOLEAN COMMENT 'Indicates whether this production project is a co-production involving one or more external production partners. Triggers co-production agreement workflows, shared rights structures, and split budget reporting in SAP S/4HANA.',
    `content_genre` STRING COMMENT 'Primary genre classification of the content being produced (e.g., drama, comedy, thriller, sports, news, reality). Used for audience targeting, scheduling, advertising sales, and rights windowing strategies. [ENUM-REF-CANDIDATE: drama|comedy|thriller|action|documentary|news|reality|sports|animation|horror — promote to reference product]',
    `content_rating` STRING COMMENT 'Official content rating assigned by the Motion Picture Association (MPA) or TV Parental Guidelines system. Governs broadcast scheduling, advertising eligibility, and platform distribution restrictions including COPPA compliance for childrens content. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product]',
    `coppa_applicable` BOOLEAN COMMENT 'Indicates whether this production is directed at children under 13 and therefore subject to COPPA compliance requirements. Affects data collection practices, advertising eligibility, and platform distribution restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production project record was first created in the lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget and spend amounts recorded on this project (e.g., USD, GBP, EUR). Supports multi-currency production environments for international co-productions.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'Integration reference identifier linking this production project to its corresponding workflow instance in Dalet Galaxy Media Asset Management and Workflow Orchestration system. Enables cross-system traceability for ingest, metadata, archive, and workflow operations.',
    `drm_required` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection must be applied to the delivered content assets. Drives technical delivery specifications for CDN, streaming platform configuration, and Akamai CDN security settings.',
    `eidr` STRING COMMENT 'Entertainment Identifier Registry (EIDR) identifier for this content project. Provides a universal, persistent identifier for the title across supply chain partners, distributors, and platforms.. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$`',
    `episode_count` STRING COMMENT 'Total number of episodes commissioned for this production project. Applicable to scripted and unscripted series. Used for budget modeling, scheduling, and rights licensing calculations. Null for single-title formats such as feature films.',
    `fcc_license_required` BOOLEAN COMMENT 'Indicates whether this production requires FCC broadcast licensing compliance review prior to linear broadcast distribution. Applicable to content intended for over-the-air or cable transmission in the United States.',
    `greenlight_date` DATE COMMENT 'Calendar date on which the production project received formal executive greenlight approval. Marks the official start of the production lifecycle and triggers budget release and resource mobilization.',
    `greenlight_status` STRING COMMENT 'Executive approval status of the production project. Indicates whether the project has received formal greenlight authorization to proceed, is pending approval, is on hold, or has been cancelled. Controls budget release and resource mobilization.. Valid values are `pending|greenlighted|on_hold|cancelled|completed`',
    `isan` STRING COMMENT 'Globally unique identifier assigned to this audiovisual work under the International Standard Audiovisual Number (ISAN) standard (ISO 15706). Used for rights management, royalty tracking, and cross-platform content identification.. Valid values are `^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `original_ip_flag` BOOLEAN COMMENT 'Indicates whether this production is based on original intellectual property owned by the organization, as opposed to licensed or adapted IP. Affects rights ownership, residuals obligations, and long-term asset valuation.',
    `post_production_start_date` DATE COMMENT 'Scheduled or actual date on which post-production activities commenced, including editing, VFX, color grading, audio mixing, and transcoding. Used for facility booking and deliverable milestone planning.',
    `pre_production_start_date` DATE COMMENT 'Scheduled or actual date on which pre-production activities commenced, including casting, location scouting, script breakdown, and crew hiring. Used for production planning and milestone tracking.',
    `primary_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code for the primary language in which the content is produced (e.g., en, es, fr). Drives localization, dubbing, subtitling, and distribution territory planning.. Valid values are `^[a-z]{2,3}$`',
    `principal_photography_end_date` DATE COMMENT 'Scheduled or actual date on which principal photography concluded (picture wrap). Triggers transition to post-production phase and initiates post-production resource scheduling.',
    `principal_photography_start_date` DATE COMMENT 'Scheduled or actual date on which principal photography (primary filming) commenced. A key production milestone used for crew scheduling, facility booking, and insurance activation.',
    `production_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country in which the production is being executed. Determines applicable regulatory frameworks, tax incentive eligibility, and co-production treaty benefits.. Valid values are `^[A-Z]{3}$`',
    `production_format` STRING COMMENT 'Primary technical production format and resolution specification (e.g., 4K UHD, HD 1080p, HDR10). Determines post-production pipeline, transcoding requirements, and delivery specifications for broadcast and streaming platforms. [ENUM-REF-CANDIDATE: 4K_UHD|HD_1080p|HD_720p|SD|HDR10|Dolby_Vision|IMAX — 7 candidates stripped; promote to reference product]',
    `production_phase` STRING COMMENT 'Current phase of the content production lifecycle. Tracks the projects progression from development through delivery. Used to gate workflow steps, resource allocation, and financial milestone releases.. Valid values are `development|pre_production|principal_photography|post_production|delivery|archived`',
    `project_type` STRING COMMENT 'Classification of the content production project by format and genre category. Drives production workflow templates, budget models, rights structures, and scheduling logic. [ENUM-REF-CANDIDATE: scripted_series|feature_film|documentary|live_event|news_segment|unscripted_series|short_form — promote to reference product]',
    `sap_wbs_element` STRING COMMENT 'SAP S/4HANA Work Breakdown Structure element code that maps this production project to the enterprise financial controlling hierarchy for budget tracking, cost allocation, and financial reconciliation.',
    `season_number` STRING COMMENT 'Season number within a series franchise. Used to link this production project to prior seasons for rights continuity, talent residuals, and audience analytics. Null for non-series formats.',
    `synopsis` STRING COMMENT 'Short narrative description of the content production projects story, subject matter, or editorial concept. Used for internal greenlight documentation, sales pitches, EPG metadata, and Dalet Galaxy asset metadata.',
    `target_delivery_date` DATE COMMENT 'Contractually committed or internally planned date by which the finished content must be delivered to distribution, broadcast, or streaming platforms. Drives post-production scheduling, windowing strategy, and SLA compliance.',
    `total_runtime_minutes` STRING COMMENT 'Total planned or delivered runtime of the production in minutes. For series, this is the aggregate runtime across all episodes. Used for scheduling, licensing, and royalty calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this production project record was most recently modified in the lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, incremental processing, and audit compliance.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master record for a content production project — the greenlit initiative that drives all production activity. Captures the project title, type (scripted series, feature film, documentary, live event, news segment), greenlight status, production phase (development, pre-production, principal photography, post-production, delivery), approved budget, actual spend, production company, showrunner or executive producer, target delivery date, ISAN identifier, and integration reference to Dalet Galaxy workflow. This is the top-level anchor entity for the entire production domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` (
    `shoot_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for a shoot schedule record in the production domain. Primary key for the shoot_schedule data product.',
    `location_id` BIGINT COMMENT 'Foreign key linking to production.location. Business justification: Normalization opportunity. Shoot schedule currently has location_name (STRING). FK to location table provides referential integrity and enables retrieving full location details (address, permits, safe',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Shoot days generate dailies (raw footage) ingested into MAM for editorial review. Role-prefixed as dailies_asset_id since shoot_schedule already has dalet_workflow_id. Essential for post-production wo',
    `employee_id` BIGINT COMMENT 'Reference to the director assigned to lead principal photography on this shoot day. Supports crew assignment and talent tracking.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this shoot schedule day belongs. Links the daily schedule to the overarching production entity.',
    `studio_facility_id` BIGINT COMMENT 'Reference to the studio or location facility booked for this shoot day. Supports integration with facility booking and resource coordination.',
    `actual_extras_count` STRING COMMENT 'The actual number of background performers (extras) who worked on this shoot day. Used for payroll reconciliation, SAG-AFTRA reporting, and production cost tracking.',
    `actual_shoot_hours` DECIMAL(18,2) COMMENT 'The actual number of hours spent in principal photography for the day. Used for budget reconciliation, overtime calculation, and production efficiency analysis.',
    `actual_wrap_time` TIMESTAMP COMMENT 'The actual time at which principal photography concluded for the day. Compared against scheduled wrap time to calculate overtime and assess schedule adherence.',
    `call_time` TIMESTAMP COMMENT 'The scheduled time at which cast and crew are required to report to set. Used for crew coordination, transport logistics, and facility readiness planning.',
    `cover_set_description` STRING COMMENT 'Description of the alternate interior or cover set designated for use if weather or other conditions prevent the primary shoot. Only applicable when weather_contingency_flag is True.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this shoot schedule record was first created in the system. Supports audit trail, data lineage, and compliance requirements.',
    `dalet_workflow_reference` STRING COMMENT 'The workflow instance identifier assigned by Dalet Galaxy for the ingest and orchestration workflow associated with this shoot days deliverables. Enables traceability between the shoot schedule and downstream media asset management processes.',
    `day_out_of_days_type` STRING COMMENT 'Industry-standard Day Out of Days (DOOD) designation indicating the cast/crew work status for this shoot day. SW=Start Work, W=Work, WF=Work Finish, F=Finish, H=Hold, D=Drop, SWF=Start Work Finish. Used for talent scheduling, residuals calculation, and SAG-AFTRA compliance. [ENUM-REF-CANDIDATE: SW|W|WF|F|H|D|SWF — 7 candidates stripped; promote to reference product]',
    `estimated_extras_count` STRING COMMENT 'The planned number of background performers (extras) required for this shoot day. Used for casting coordination, catering planning, and SAG-AFTRA background performer compliance.',
    `estimated_shoot_hours` DECIMAL(18,2) COMMENT 'The planned number of shooting hours for the day, used for budget forecasting, crew scheduling, and facility booking. Expressed in decimal hours (e.g., 10.50 = 10 hours 30 minutes).',
    `first_shot_time` TIMESTAMP COMMENT 'The scheduled or actual time at which the first camera roll of the day begins. A key production efficiency metric used to assess set readiness and pre-production effectiveness.',
    `is_overtime_day` BOOLEAN COMMENT 'Indicates whether this shoot day resulted in overtime hours for cast or crew, triggering additional compensation obligations under union agreements (SAG-AFTRA, DGA, IATSE). Derived operationally but stored for compliance and payroll audit purposes.',
    `meal_penalty_flag` BOOLEAN COMMENT 'Indicates whether a meal penalty was incurred on this shoot day due to failure to provide a meal break within the union-mandated interval (typically 6 hours). Triggers additional compensation obligations under SAG-AFTRA and IATSE agreements.',
    `page_count` DECIMAL(18,2) COMMENT 'The number of script pages scheduled for photography on this shoot day, expressed in eighths of a page per industry convention (e.g., 4.625 = 4 and 5/8 pages). A standard production efficiency metric used to assess daily output against industry benchmarks.',
    `production_notes` STRING COMMENT 'Free-text field capturing significant events, issues, or observations from the shoot day, including equipment failures, weather delays, cast illness, or creative changes. Sourced from the daily production report.',
    `production_unit` STRING COMMENT 'Identifies the filming unit responsible for this shoot day. Main unit is led by the principal director; second unit handles action sequences or supplemental footage; splinter unit shoots simultaneously with main unit on a separate set; insert unit captures close-up or detail shots.. Valid values are `main_unit|second_unit|splinter_unit|insert_unit`',
    `revision_date` DATE COMMENT 'The date on which the current revision of this shoot schedule was issued. Used to track the cadence of schedule changes and identify the most current approved version.',
    `revision_version` STRING COMMENT 'The version identifier of this shoot schedule revision (e.g., v1, v3-BLUE, Rev-7). Production schedules are revised frequently; tracking version enables audit of changes and comparison of planned vs. actual across revisions.',
    `scene_numbers` STRING COMMENT 'Comma-separated list of scene numbers from the production script scheduled for photography on this shoot day (e.g., 12, 13A, 14, 15B). Derived from the stripboard and used for script supervisor tracking and editorial planning.',
    `schedule_number` STRING COMMENT 'Externally-known alphanumeric identifier for this shoot schedule record, used in production paperwork, call sheets, and cross-system references (e.g., SS-2024-0042).',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the shoot schedule day. Drives workflow actions and reporting across production management. [ENUM-REF-CANDIDATE: draft|confirmed|in_progress|completed|cancelled|postponed — promote to reference product if additional states are required]. Valid values are `draft|confirmed|in_progress|completed|cancelled|postponed`',
    `scheduled_wrap_time` TIMESTAMP COMMENT 'The planned time at which principal photography is expected to conclude for the day. Used for facility booking, crew scheduling, and overtime cost estimation.',
    `shoot_date` DATE COMMENT 'The calendar date on which principal photography is scheduled or was executed. The primary business event date for this schedule record.',
    `shoot_day_number` STRING COMMENT 'Sequential shoot day number within the production (e.g., Day 1, Day 15, Day 42). Used to track production progress against the total approved shoot days and for budget burn-rate analysis.',
    `shoot_type` STRING COMMENT 'Classifies the nature of the shoot day environment. Distinguishes between controlled studio environments and on-location shoots, which have different logistical, permitting, and cost implications.. Valid values are `studio|location|exterior|interior|mixed`',
    `total_approved_shoot_days` STRING COMMENT 'The total number of principal photography days approved in the production greenlight. Used to calculate schedule completion percentage and identify overages requiring executive approval.',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'The minimum rest period in hours between the wrap of the previous shoot day and the call time of this shoot day. Union agreements (SAG-AFTRA, DGA, IATSE) mandate minimum turnaround periods; violations trigger penalty payments.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this shoot schedule record was most recently modified. Used for change detection, incremental data loading in the Databricks Silver Layer, and audit trail maintenance.',
    `weather_contingency_flag` BOOLEAN COMMENT 'Indicates whether this shoot day has a weather contingency plan in place. When True, an alternate interior or cover set is designated in case outdoor conditions prevent the primary shoot. Critical for location shoots and insurance risk management.',
    CONSTRAINT pk_shoot_schedule PRIMARY KEY(`shoot_schedule_id`)
) COMMENT 'Day-by-day principal photography schedule for a production project. Tracks shoot dates, call times, wrap times, location or studio facility, scene numbers, unit (main unit, second unit, splinter unit), director, first assistant director, estimated vs actual shoot hours, weather contingency flags, and schedule revision version. Integrates with facility booking and crew assignment to coordinate all on-set resources. Distinct from the EPG scheduling domain which governs broadcast playout.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`budget` (
    `budget_id` BIGINT COMMENT 'Primary key for budget',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Budget approvals require employee-level accountability for SOX compliance, audit trails, and financial controls—standard in production accounting systems. Replaces denormalized approved_by name field.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production budgets must be assigned to cost centers for financial consolidation, variance analysis, and departmental P&L reporting. Replaces denormalized sap_cost_center_code with proper FK for SAP in',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this budget record belongs to. Links the financial control baseline to the production entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production budgets must roll up to profit centers for segment reporting, EBITDA calculation, and covenant compliance. Media companies track production profitability by business unit/channel (profit ce',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Cumulative actual costs incurred to date for this cost category, sourced from SAP S/4HANA FI/CO actual postings. Represents real expenditure against the approved budget.',
    `approval_status` STRING COMMENT 'Current workflow approval status of this budget record. DRAFT = in preparation; PENDING_APPROVAL = submitted for sign-off; APPROVED = formally authorized; REJECTED = returned for revision; LOCKED = frozen for actuals comparison; CLOSED = production complete.. Valid values are `DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|LOCKED|CLOSED`',
    `approved_amount` DECIMAL(18,2) COMMENT 'The formally approved budget amount for this cost category and version, representing the financial control baseline authorized by the production greenlight committee.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget version was formally approved by the authorized signatory. Null if not yet approved.',
    `change_reason` STRING COMMENT 'Free-text narrative explaining the business justification for a budget revision (e.g., Schedule extension due to weather delays, Additional VFX shots approved by director). Mandatory for revised versions.',
    `change_request_reference` STRING COMMENT 'Reference number of the formal budget change request (BCR) document that authorized a revision to this budget line, traceable in the production finance approval workflow.',
    `budget_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this budget record within the production finance system. Used for cross-system reference and reporting.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of open purchase order commitments (obligations) for this cost category that have been raised but not yet invoiced. Represents encumbered funds in the SAP MM/CO commitment ledger.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'The absolute monetary value of the contingency reserve allocated for this cost category, derived from the contingency percentage applied to the approved budget amount.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The percentage of the approved budget allocated as contingency reserve for this cost category, representing the risk buffer approved by the production finance committee.',
    `cost_category_code` STRING COMMENT 'SAP cost element or cost category code classifying the type of production expenditure (e.g., ATL-TALENT, BTL-CREW, BTL-EQUIPMENT, POST-VFX, POST-AUDIO). [ENUM-REF-CANDIDATE: ATL-TALENT|ATL-RIGHTS|BTL-CREW|BTL-EQUIPMENT|BTL-FACILITIES|BTL-TRAVEL|POST-VFX|POST-AUDIO|POST-COLOR|CONTINGENCY — promote to reference product]',
    `cost_category_name` STRING COMMENT 'Human-readable name of the production cost category (e.g., Above-the-Line Talent, Below-the-Line Crew, Visual Effects, Audio Post-Production).',
    `cost_line_type` STRING COMMENT 'High-level classification of the cost line distinguishing above-the-line (ATL) creative costs (writers, directors, producers, talent) from below-the-line (BTL) technical and crew costs, post-production, contingency, and overhead.. Valid values are `ABOVE_THE_LINE|BELOW_THE_LINE|POST_PRODUCTION|CONTINGENCY|OVERHEAD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the source system or ingested into the Databricks Silver Layer. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this budget record are denominated (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert this budget records currency to the productions reporting currency at the time of budget approval or revision.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number 1–12 or 1–16 for special periods) within the fiscal year to which this budget line is assigned in SAP CO.',
    `fiscal_year` STRING COMMENT 'The four-digit fiscal year to which this budget record belongs in the SAP S/4HANA CO controlling area, used for annual financial planning and SOX reporting.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Latest estimate of the total cost expected to be incurred for this cost category by production completion, incorporating actuals to date and projected remaining spend.',
    `is_greenlight_budget` BOOLEAN COMMENT 'Indicates whether this budget record represents the original greenlight-approved budget for the production, as distinct from subsequent revisions. The greenlight budget is the primary financial authorization baseline.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget version has been locked and is no longer open for modification. A locked budget serves as the immutable financial baseline for variance reporting.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, assumptions, or clarifications associated with this budget record, entered by the production finance team.',
    `period_end_date` DATE COMMENT 'The end date of the fiscal or production period covered by this budget record. Defines the temporal boundary for cost accumulation and variance measurement.',
    `period_start_date` DATE COMMENT 'The start date of the fiscal or production period covered by this budget record, aligning to the SAP fiscal year/period structure.',
    `production_phase` STRING COMMENT 'The production lifecycle phase to which this budget line is attributed (e.g., Development, Pre-Production, Principal Photography, Post-Production, Delivery). Enables phase-level budget tracking.. Valid values are `DEVELOPMENT|PRE_PRODUCTION|PRINCIPAL_PHOTOGRAPHY|POST_PRODUCTION|DELIVERY|CLOSED`',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the currency to which all amounts are translated for consolidated financial reporting (e.g., USD for a US-headquartered broadcaster).. Valid values are `^[A-Z]{3}$`',
    `revised_amount` DECIMAL(18,2) COMMENT 'The most recently revised budget amount for this cost category following a formal budget change request. Null if no revision has been approved since the original budget.',
    `sap_cost_object_code` STRING COMMENT 'The SAP S/4HANA CO cost object identifier (Internal Order number or WBS Element ID) that anchors this budget record to the controlling module for financial reconciliation.',
    `sap_wbs_element` STRING COMMENT 'SAP Project System Work Breakdown Structure element code that maps this budget line to a specific phase or deliverable within the production project hierarchy (e.g., PRE-PROD, PRINCIPAL, POST-PROD).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this budget record in the source system or Silver Layer. Used for incremental load detection and change data capture.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the approved (or revised) budget amount and the sum of actual costs plus commitments. A negative value indicates an over-budget condition; positive indicates underspend.',
    `version` STRING COMMENT 'Version label of this budget record, distinguishing the original greenlight budget from subsequent revisions and the locked final version. Supports budget version history tracking.. Valid values are `ORIGINAL|REVISED_1|REVISED_2|REVISED_3|FINAL|LOCKED`',
    `version_number` STRING COMMENT 'Sequential integer version number of this budget record (e.g., 1 = original, 2 = first revision). Enables ordered version history and audit trail.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Detailed production budget record aligned to the SAP S/4HANA CO (Controlling) module. Captures above-the-line and below-the-line cost categories, approved budget amounts by cost category, revised budget amounts, actual costs to date, purchase order commitments, variance amounts, currency, budget version, and approval status. Serves as the financial control baseline for a production project. Links to SAP cost centers and WBS elements for financial reconciliation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual budget line item within a production budget. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Line-item budget approvals track authorization chain for production accounting variance analysis and audit compliance—required for financial controls. Replaces denormalized approved_by name.',
    `budget_id` BIGINT COMMENT 'Reference to the parent production budget document that contains this line item. A production may have multiple budget versions (e.g., greenlight, revised, final).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Budget lines track advertiser-funded production costs for branded content and product integrations. Business process: advertiser co-production cost allocation, campaign-funded production expense track [FK namespace reconciled: points to sales.campaign]',
    `content_episode_id` BIGINT COMMENT 'Reference to the specific episode or segment to which this budget line is allocated. Null for series-level or film-level lines that are not episode-specific.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual budget line items must post to cost centers for detailed expense tracking and actuals vs. budget variance reporting. Required for monthly financial close and departmental budget management.',
    `partner_id` BIGINT COMMENT 'Reference to the vendor, supplier, or payee associated with this budget line item (e.g., VFX house, location owner, equipment rental company, music licensor).',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this budget line belongs. Links the line item to its overarching production context.',
    `account_code` STRING COMMENT 'Industry-standard production account code identifying the cost category within the budget (e.g., 1100 for Above-the-Line Talent, 2200 for Camera Equipment). Follows standard production accounting chart of accounts (e.g., AICP, Producers Guild).. Valid values are `^[A-Z0-9]{2,10}$`',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Costs accrued for work performed or services received but not yet invoiced or formally committed. Supports period-end financial close and accurate cost-to-complete reporting.',
    `actual_amount` DECIMAL(18,2) COMMENT 'Total actual costs incurred and posted against this budget line to date, sourced from SAP FI invoice postings and payroll actuals. Used for variance analysis against budgeted and committed amounts.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was formally approved by the authorized approver. Provides an audit trail for financial governance and SOX compliance.',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'Original approved budget amount for this line item as established at greenlight or budget approval. Represents the planned cost baseline against which actuals and commitments are measured.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of purchase orders, contracts, or binding agreements raised against this budget line but not yet invoiced. Represents financial obligations that reduce available budget.',
    `contingency_pct` DECIMAL(18,2) COMMENT 'Contingency percentage applied to this budget line to cover unforeseen cost overruns. Typically 5–15% for production lines. Contributes to the overall production contingency reserve.',
    `contract_reference` STRING COMMENT 'Reference number of the underlying contract or deal memo associated with this budget line (e.g., talent agreement, location agreement, VFX services contract). Links to Rightsline or SAP contract management.',
    `cost_category` STRING COMMENT 'High-level cost category classifying the budget line within the production budget structure. Above-the-line covers creative talent (writers, directors, producers, cast); below-the-line covers crew, equipment, locations, and production services. [ENUM-REF-CANDIDATE: above_the_line|below_the_line|post_production|music_licensing|vfx|marketing|overhead|contingency|insurance|legal — promote to reference product]',
    `cost_sub_category` STRING COMMENT 'Granular sub-classification within the cost category (e.g., Cast Fees, Location Fees, Equipment Rental, VFX Compositing, Music Synchronization License, Post-Production Labor). Enables detailed variance analysis at the sub-category level.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system. Provides audit trail for record provenance and financial governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this budget line (e.g., USD, GBP, EUR). Supports multi-currency production budgets for international co-productions.. Valid values are `^[A-Z]{3}$`',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Estimate at Completion (EAC) for this budget line, representing the current best estimate of total cost when the line item is fully complete. Combines actuals to date with estimate to complete.',
    `fringe_rate_pct` DECIMAL(18,2) COMMENT 'Percentage applied to labor costs on this line to account for employer fringe benefits (payroll taxes, pension contributions, health insurance, residuals). Standard production accounting practice for above-the-line and below-the-line labor lines.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account number to which this budget line maps for financial reporting and cost center allocation. Enables reconciliation between production budgets and enterprise financial statements.. Valid values are `^[0-9]{6,10}$`',
    `is_above_the_line` BOOLEAN COMMENT 'Flag indicating whether this budget line is classified as above-the-line (ATL) cost, covering creative talent such as writers, directors, producers, and principal cast. False indicates below-the-line (BTL) cost.',
    `is_union_labor` BOOLEAN COMMENT 'Flag indicating whether this budget line involves union or guild labor subject to collective bargaining agreements (DGA, SAG-AFTRA, WGA, IATSE). Drives fringe rate calculations and residuals obligations.',
    `line_description` STRING COMMENT 'Free-text description of the specific cost item represented by this budget line (e.g., Lead Actor Day Rate — Week 3, Steadicam Rental — Principal Photography, Dolby Atmos Mix — Episode 4).',
    `line_number` STRING COMMENT 'Sequential line number within the parent budget document, used for ordering and referencing individual line items in budget reports and purchase orders.',
    `line_status` STRING COMMENT 'Current lifecycle status of the budget line item, tracking its progression from initial draft through approval, commitment, invoicing, and payment. Drives workflow routing and financial reporting. [ENUM-REF-CANDIDATE: draft|approved|committed|invoiced|paid|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the production accountant or line producer providing additional context, assumptions, or justification for this budget line item.',
    `production_phase` STRING COMMENT 'Phase of the production workflow during which this cost is incurred. Enables phase-based cost tracking and cash flow forecasting across the full production lifecycle from development through delivery.. Valid values are `development|pre_production|principal_photography|post_production|delivery|archive`',
    `purchase_order_number` STRING COMMENT 'SAP purchase order number raised against this budget line for vendor commitments. Links the budget line to the formal procurement document and enables three-way matching (PO, goods receipt, invoice).',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of units associated with this budget line (e.g., number of shoot days, number of crew members, number of VFX shots, hours of post-production labor). Combined with unit_rate to derive budgeted amount.',
    `revised_budgeted_amount` DECIMAL(18,2) COMMENT 'Most recent approved revision to the budgeted amount, reflecting approved change orders, scope changes, or budget transfers. Null if no revision has been approved since original budget.',
    `shoot_date_end` DATE COMMENT 'Planned or actual end date for the activity or service associated with this budget line. Used for scheduling, resource allocation, and cost accrual period determination.',
    `shoot_date_start` DATE COMMENT 'Planned or actual start date for the activity or service associated with this budget line (e.g., first day of location shoot, start of VFX work, commencement of post-production labor).',
    `tax_credit_eligible` BOOLEAN COMMENT 'Flag indicating whether this budget line qualifies for production tax credits or incentives (e.g., UK High-End TV Tax Relief, US state film tax credits). Enables automated calculation of eligible spend for tax credit claims.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., day, hour, week, flat_fee, shot, reel, license). Defines how the quantity is counted for rate-based cost calculations. [ENUM-REF-CANDIDATE: day|hour|week|flat_fee|shot|reel|license|unit — 8 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate per unit of measure for this budget line (e.g., daily rate for a crew member, hourly rate for facility hire, per-shot rate for VFX). Multiplied by quantity to derive the budgeted amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was most recently modified. Supports incremental data loading in the Databricks Silver Layer and change data capture from SAP S/4HANA.',
    `wbs_element` STRING COMMENT 'SAP Work Breakdown Structure element code that hierarchically positions this budget line within the production project plan (e.g., PRD-2024-001.3.2.1 for a specific post-production task).',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line-item within a production budget, representing a specific cost category or account code (e.g., cast fees, location fees, equipment rental, VFX, music licensing, post-production labor). Captures account code, cost category, sub-category, vendor or payee, budgeted amount, committed amount, actual amount, episode or segment allocation, and SAP G/L account reference. Enables granular cost tracking and variance analysis at the line-item level.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for a crew assignment record in the production domain. Primary key for the crew_assignment data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Crew labor costs must be assigned to cost centers for departmental expense tracking, labor cost allocation, union reporting, and departmental budget management. Essential for tracking above-the-line v',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Crew members often work through loan-out companies or talent agencies (partners). Linking enables tracking all crew supplied by that partner, payment processing to the loan-out entity, union/guild com',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Production crew hierarchies require tracking each crew members direct manager for time approval, scheduling conflict resolution, and union labor compliance reporting—standard in broadcast production ',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Crew can be assigned to specific episodes within a series production. Optional FK (nullable) — crew may be assigned at project level or episode level. Enables episode-specific crew tracking for episod',
    `project_id` BIGINT COMMENT 'Reference to the production project to which this crew member is assigned. Links the assignment to the master production record.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the crew members master record in the talent domain. Identifies the individual below-the-line crew member being assigned.',
    `assignment_number` STRING COMMENT 'Externally-known business identifier for this crew assignment, used in deal memos, call sheets, and payroll processing. Format: CA-{YEAR}-{SEQUENCE}.. Valid values are `^CA-[0-9]{4}-[0-9]{6}$`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the crew assignment. Drives payroll eligibility, call sheet inclusion, and production roster reporting. Values: pending (offer extended, not yet accepted), confirmed (deal memo signed), active (currently on set/in production), on_hold (temporarily suspended), completed (assignment concluded), cancelled (assignment terminated before start).. Valid values are `pending|confirmed|active|on_hold|completed|cancelled`',
    `background_check_status` STRING COMMENT 'Status of the crew members background check for this production assignment. Required for productions involving minors (COPPA compliance) or access to secure facilities. Values: not_required, pending, cleared, failed, expired.. Valid values are `not_required|pending|cleared|failed|expired`',
    `box_rental_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate paid to the crew member for the rental of their personal tool box or specialized equipment package (e.g., makeup artists kit, wardrobe supervisors supplies). Distinct from kit_rental_rate which covers technical equipment.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The agreed compensation rate for this crew assignment, expressed in the applicable deal_type unit (per day, per week, or flat total). Stored in the productions base currency. Used for budget tracking and payroll processing in SAP S/4HANA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was first created in the system. Used for audit trail, data lineage, and compliance reporting. Conforms to ISO 8601 format with timezone offset.',
    `credit_name` STRING COMMENT 'The name as it should appear in the productions end credits, which may differ from the crew members legal name (e.g., stage name, preferred professional name). Sourced from the deal memo credit clause.',
    `credit_position` STRING COMMENT 'Specifies where the crew members credit appears in the production: main_title (opening credits), end_title (closing credits), both, or none (no contractual credit obligation). Drives post-production credit sequence assembly.. Valid values are `main_title|end_title|both|none`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contracted_rate (e.g., USD, GBP, EUR). Required for international co-productions where crew may be contracted in local currencies.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'The workflow instance identifier in Dalet Galaxy that corresponds to this crew assignments production workflow. Enables traceability between the HR/payroll record and the media asset management workflow orchestration system.',
    `deal_type` STRING COMMENT 'The compensation structure type for this crew assignment. Daily = per-day rate; Weekly = per-week rate with guaranteed days; Flat = fixed total fee for the engagement; Run of Show = engaged for the full production duration; Episodic = per-episode rate for series production.. Valid values are `daily|weekly|flat|run_of_show|episodic`',
    `department` STRING COMMENT 'The production department to which the crew member belongs for this assignment (e.g., camera, grip, electric, art, wardrobe, hair/makeup, post-production, sound, VFX). Drives crew call sheet grouping and budget cost center allocation. [ENUM-REF-CANDIDATE: camera|grip|electric|art|wardrobe|hair_makeup|post_production|sound|vfx|production — 10 candidates stripped; promote to reference product]',
    `end_date` DATE COMMENT 'The contractually agreed last day of work for this crew assignment. Nullable for open-ended or rolling assignments. Used for wrap scheduling and final payroll processing.',
    `filming_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary filming location where this crew member will work. Determines applicable labor laws, tax treaties, work permit requirements, and per diem rates.. Valid values are `^[A-Z]{3}$`',
    `guaranteed_days` STRING COMMENT 'The minimum number of work days guaranteed to the crew member under this assignment deal, regardless of actual production schedule. Relevant for weekly and episodic deal types. Used for take-or-pay liability calculation.',
    `kit_rental_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate paid to the crew member for the rental of their personal professional equipment (kit) used on the production (e.g., camera operators lens kit, sound mixers equipment package). Common in below-the-line crew deals.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was most recently modified. Used for change data capture (CDC), audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    `meal_penalty_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to meal penalty payments if the production fails to provide a meal break within the contractually required interval (typically 6 hours under IATSE/DGA agreements). Drives production scheduling compliance.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is eligible for overtime pay under their union/guild agreement or applicable labor law. True = eligible for overtime; False = flat deal or exempt classification. Drives payroll calculation logic.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base contracted_rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Applicable only when overtime_eligible is True. Sourced from the applicable union/guild agreement.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily allowance paid to the crew member for meals and incidental expenses when working away from their home base location. Rate varies by filming location and union agreement. Used for production cost budgeting.',
    `production_company` STRING COMMENT 'The legal name of the production company or entity that is the employer of record for this crew assignment. Relevant for co-productions where multiple entities may employ different crew members. Used for payroll and tax reporting.',
    `residuals_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to residual payments when the production is reused, syndicated, or distributed on additional platforms (e.g., streaming, international broadcast). Residuals are governed by DGA, IATSE, and SAG-AFTRA agreements.',
    `role_title` STRING COMMENT 'The specific production role or job title assigned to the crew member (e.g., Director, Director of Photography, Gaffer, Script Supervisor, Editor, Colorist, VFX Supervisor, Sound Mixer, Key Grip, Best Boy). [ENUM-REF-CANDIDATE: director|director_of_photography|gaffer|script_supervisor|editor|colorist|vfx_supervisor|sound_mixer|key_grip|best_boy|production_designer|costume_designer — promote to reference product]',
    `safety_training_certified` BOOLEAN COMMENT 'Indicates whether the crew member has completed the required on-set safety training certification for this production (e.g., OSHA safety, COVID-19 protocols, stunt safety). Required for insurance compliance and production liability management.',
    `sap_personnel_action_code` STRING COMMENT 'The personnel action number in SAP S/4HANA HR that corresponds to this crew assignment. Used for payroll processing, benefits enrollment, and HR compliance reporting. Enables reconciliation between the production data product and the ERP system of record.',
    `scheduled_days` STRING COMMENT 'The total number of work days currently scheduled for this crew member on the production, as reflected in the current production schedule. May differ from guaranteed_days if the schedule changes.',
    `start_date` DATE COMMENT 'The contractually agreed first day of work for this crew assignment. Used for payroll calculation, permit verification, and production schedule alignment.',
    `travel_allowance` DECIMAL(18,2) COMMENT 'Fixed or estimated travel reimbursement amount for this crew assignment, covering transportation costs to and from the filming location. Distinct from per_diem_rate which covers daily living expenses.',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'The minimum number of hours required between the end of one work day and the start of the next for this crew member, as stipulated by their union/guild agreement (e.g., 10 hours for IATSE, 12 hours for DGA). Violation triggers turnaround penalty payments.',
    `union_guild_affiliation` STRING COMMENT 'The labor union or guild to which the crew member belongs for this assignment. Determines applicable minimum rates, working conditions, residuals obligations, and benefit fund contributions. DGA = Directors Guild of America; IATSE = International Alliance of Theatrical Stage Employees; SAG-AFTRA = Screen Actors Guild–American Federation of Television and Radio Artists; WGA = Writers Guild of America; NABET = National Association of Broadcast Employees and Technicians; Teamsters = International Brotherhood of Teamsters. [ENUM-REF-CANDIDATE: DGA|IATSE|SAG-AFTRA|WGA|NABET|Teamsters|non_union — 7 candidates stripped; promote to reference product]',
    `work_permit_expiry_date` DATE COMMENT 'The expiration date of the crew members work permit or visa authorization. Used to trigger renewal alerts and ensure continuous legal work authorization throughout the assignment period.',
    `work_permit_number` STRING COMMENT 'The official government-issued work permit or visa authorization number for the crew member in the production jurisdiction. Nullable when work_permit_required is False. Required for compliance audits and production insurance.',
    `work_permit_required` BOOLEAN COMMENT 'Indicates whether a work permit or visa authorization is required for this crew member to legally work on this production in the filming jurisdiction. True = permit required; False = no permit required (domestic/citizen crew). Triggers compliance workflow in HR.',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'Assignment of a crew member to a specific production project in a defined role and department. Captures crew role (director, DP, gaffer, script supervisor, editor, colorist, VFX supervisor, sound mixer), department (camera, grip, electric, art, wardrobe, hair/makeup, post-production), start date, end date, deal type (daily, weekly, flat), contracted rate, union or guild affiliation (DGA, IATSE, SAG-AFTRA), overtime eligibility, work permit status, and assignment status. References the talent domain for the crew members master record. Tracks the full below-the-line crew roster for a production.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` (
    `facility_booking_id` BIGINT COMMENT 'Unique surrogate identifier for each facility booking record in the production domain. Primary key for the facility_booking data product.',
    `content_episode_id` BIGINT COMMENT 'Identifier of the specific episode or segment within the production project that requires this facility booking. Nullable for feature films or non-episodic productions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Facility bookings must be assigned to cost centers for facility cost allocation and chargeback to production departments. Replaces denormalized cost_center_code. Required for studio utilization report',
    `partner_id` BIGINT COMMENT 'Identifier of the external facility vendor or studio lot operator when the booked facility is not company-owned. References the vendor master in SAP S/4HANA for procurement and payment processing.',
    `employee_id` BIGINT COMMENT 'Identifier of the production coordinator or scheduler who created this facility booking. Used for accountability, approval workflows, and audit trail purposes.',
    `project_id` BIGINT COMMENT 'Identifier of the production project for which this facility is being booked. Links the booking to the overarching content production initiative.',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Facility bookings are made for specific shoot schedule entries. Operational link — booking times align with shoot schedule. Optional FK (nullable) — facilities may also be booked for post-production o',
    `studio_facility_id` BIGINT COMMENT 'Identifier of the production facility being booked, referencing the master facility record that holds static attributes such as capacity and technical specifications.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The final invoiced or accrued cost of the facility booking after actual usage is confirmed. Includes any overtime charges or adjustments. Reconciled against estimated_cost for budget variance reporting in SAP S/4HANA CO.',
    `actual_end` TIMESTAMP COMMENT 'The actual date and time the facility usage concluded, as recorded by the facility operator or production coordinator. Used for overtime calculation, billing reconciliation, and schedule variance reporting.',
    `actual_start` TIMESTAMP COMMENT 'The actual date and time the facility usage commenced, as recorded by the facility operator or production coordinator. May differ from booking_start due to delays or early starts. Used for variance analysis and billing reconciliation.',
    `booking_end` TIMESTAMP COMMENT 'The scheduled date and time at which the facility booking period ends. Combined with booking_start to compute duration and detect scheduling conflicts across productions.',
    `booking_reference` STRING COMMENT 'Externally visible alphanumeric reference code assigned to this booking, used in communications with facility operators, vendors, and production coordinators. Corresponds to the booking order number in SAP S/4HANA MM module.. Valid values are `^BK-[A-Z0-9]{8,16}$`',
    `booking_start` TIMESTAMP COMMENT 'The scheduled date and time at which the facility booking period begins. Used for conflict detection, crew scheduling, and playout coordination. Stored in ISO 8601 format with timezone offset.',
    `booking_status` STRING COMMENT 'Current lifecycle state of the facility booking. tentative indicates a provisional hold pending confirmation; confirmed indicates a firm reservation; cancelled indicates the booking was withdrawn; completed indicates the facility usage has concluded; on_hold indicates a temporary pause pending decision.. Valid values are `tentative|confirmed|cancelled|completed|on_hold`',
    `cancellation_date` DATE COMMENT 'The date on which the facility booking was formally cancelled. Used to determine whether cancellation fees apply per the vendor contract terms and for financial accrual reversal in SAP S/4HANA.',
    `cancellation_fee` DECIMAL(18,2) COMMENT 'Monetary penalty charged by the facility vendor when a confirmed booking is cancelled within the contractual notice period. Recorded for financial reconciliation and budget variance reporting.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the booking was cancelled. Populated only when booking_status is cancelled. Used for production post-mortem analysis and vendor dispute resolution.',
    `capacity_persons` STRING COMMENT 'Maximum number of persons the facility can accommodate during the booking period. Used for crew planning, health and safety compliance, and resource allocation decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this facility booking record was first created in the system. Serves as the audit trail creation marker and is used for SLA compliance tracking and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the rate and total cost are denominated (e.g., USD, GBP, EUR). Required for multi-territory productions and financial reconciliation in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'Reference identifier of the associated workflow job in Dalet Galaxy Media Asset Management system. Enables traceability between the facility booking and the ingest, metadata, or archive workflow triggered by the production activity.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The projected total cost of the facility booking at the time of reservation, calculated from rate_amount and the planned booking duration. Used for production budget planning and greenlight approvals.',
    `facility_location` STRING COMMENT 'Physical location or campus of the facility (e.g., Burbank Studio Lot, London Soho Post). Used for logistics planning, travel coordination, and geographic cost allocation.',
    `facility_type` STRING COMMENT 'Classification of the production facility being booked. Drives resource conflict detection logic and cost allocation rules. [ENUM-REF-CANDIDATE: soundstage|editing_suite|dubbing_stage|color_grading_suite|adr_studio|screening_room|post_production_bay — promote to reference product]',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this booking grants exclusive use of the facility for the booked period, preventing any concurrent bookings by other productions. When False, the facility may be shared with other productions subject to capacity constraints.',
    `notes` STRING COMMENT 'Free-text field for production coordinators to capture special requirements, setup instructions, access arrangements, or other operational notes relevant to the facility booking.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours the facility was used beyond the originally booked end time. Drives overtime rate calculations and is a key input to actual_cost reconciliation and production schedule variance analysis.',
    `production_phase` STRING COMMENT 'The stage of the content production lifecycle during which this facility is being used. Enables cost allocation by production phase and supports milestone tracking. [ENUM-REF-CANDIDATE: pre_production|principal_photography|post_production|vfx|color_grading|audio_mix|delivery — promote to reference product]',
    `purchase_order_number` STRING COMMENT 'SAP S/4HANA MM purchase order number raised for this facility booking when the facility is provided by an external vendor. Required for accounts payable processing and three-way match (PO, goods receipt, invoice).',
    `rate_amount` DECIMAL(18,2) COMMENT 'The contracted rate charged for the facility per the applicable rate_type unit (e.g., cost per hour or cost per day). Sourced from the facility rate card or negotiated contract. Used for budget estimation and cost allocation.',
    `rate_type` STRING COMMENT 'The billing rate structure applied to this facility booking. Determines how the total cost is calculated — per hour, per day, half-day block, weekly block, or a negotiated flat fee.. Valid values are `hourly|daily|half_day|weekly|flat_fee`',
    `technical_specs` STRING COMMENT 'Free-text description of the technical capabilities and equipment configuration of the facility at the time of booking (e.g., Dolby Atmos 7.1.4 mixing console, Pro Tools HDX, 4K DI suite). Sourced from Dalet Galaxy facility metadata.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this facility booking record was most recently modified. Used for change detection in ETL pipelines, audit compliance, and conflict resolution in concurrent update scenarios.',
    `wbs_element` STRING COMMENT 'SAP S/4HANA Project System Work Breakdown Structure element code that identifies the specific production phase or deliverable to which this facility cost is charged. Enables granular project cost tracking.',
    CONSTRAINT pk_facility_booking PRIMARY KEY(`facility_booking_id`)
) COMMENT 'Reservation and usage record for a production facility — soundstage, editing suite, dubbing stage, color grading suite, ADR studio, screening room, or post-production bay. Captures facility name, facility type, location, booking start datetime, booking end datetime, booked production project, booked episode or segment, booking status (tentative, confirmed, cancelled), rate per hour or day, total cost, and technical specifications of the facility. Enables resource conflict detection and cost allocation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` (
    `equipment_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each equipment allocation record. Primary key for the equipment_allocation data product in the production domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment allocations must be tracked to cost centers for equipment cost tracking and departmental chargebacks. Replaces denormalized cost_centre_code (British spelling). Required for rental cost allo',
    `employee_id` BIGINT COMMENT 'Reference to the crew member accountable for the equipment during the allocation period. Used for loss, damage, and insurance claim attribution.',
    `equipment_item_id` BIGINT COMMENT 'Reference to the master equipment item record (camera body, lens, lighting rig, sound package, jib, drone, editing workstation, encoding hardware) being allocated.',
    `partner_id` BIGINT COMMENT 'Reference to the external rental vendor supplying the equipment. Null when the equipment is an owned asset. Used for vendor cost reconciliation in SAP S/4HANA.',
    `project_id` BIGINT COMMENT 'Reference to the production project or title to which this equipment is allocated. Links the allocation to the broader production workflow managed in Dalet Galaxy.',
    `shoot_day_id` BIGINT COMMENT 'Reference to the specific shoot day or production schedule entry for which the equipment is allocated. Enables day-level cost tracking and scheduling conflict detection.',
    `allocation_end_date` DATE COMMENT 'The date on which the equipment allocation ends — i.e., the last day the equipment is assigned to the production. Used for rental cost calculation and return scheduling.',
    `allocation_number` STRING COMMENT 'Externally-known business identifier for the allocation record, used in production paperwork, crew call sheets, and facility booking confirmations. Format: EQALLOC-{YYYY}-{NNNNNN}.. Valid values are `^EQALLOC-[0-9]{4}-[0-9]{6}$`',
    `allocation_start_date` DATE COMMENT 'The date on which the equipment allocation begins — i.e., the first day the equipment is available to the production. Used for rental rate calculation and scheduling conflict detection.',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the equipment allocation. Drives workflow routing in Dalet Galaxy and cost accrual in SAP S/4HANA. [ENUM-REF-CANDIDATE: requested|confirmed|checked_out|in_use|checked_in|cancelled|lost|damaged — promote to reference product]',
    `asset_tag_code` STRING COMMENT 'Internal asset tag or barcode label affixed to owned equipment for physical inventory tracking. Format: {CC}-{NNNNNN} where CC is category code. Null for rented equipment.. Valid values are `^[A-Z]{2}-[0-9]{6}$`',
    `checkout_condition` STRING COMMENT 'Assessed physical condition of the equipment at the time of checkout. Establishes the baseline condition for damage assessment upon return. Recorded by the equipment manager.. Valid values are `new|excellent|good|fair|poor`',
    `checkout_timestamp` TIMESTAMP COMMENT 'Exact date and time the equipment was physically checked out from the equipment room or rental house. Serves as the principal business event timestamp for the allocation lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment allocation record was first created in the system. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the rental rate and insurance value amounts (e.g., USD, GBP, EUR). Supports multi-currency productions and financial consolidation in SAP S/4HANA FI.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'Identifier of the associated Dalet Galaxy workflow instance that orchestrates the equipment allocation within the broader production ingest and post-production pipeline. Enables end-to-end workflow traceability.',
    `damage_claim_amount` DECIMAL(18,2) COMMENT 'Monetary value of the damage or loss claim raised against this allocation, in the currency specified by currency_code. Null when no damage claim exists. Used for financial reconciliation and insurance recovery.',
    `damage_description` STRING COMMENT 'Free-text description of any damage, loss, or malfunction identified at return. Null when equipment is returned in acceptable condition. Used to support insurance claims and vendor dispute resolution.',
    `equipment_category` STRING COMMENT 'High-level classification of the equipment type being allocated. Drives cost centre coding, insurance grouping, and crew department assignment. [ENUM-REF-CANDIDATE: camera|lens|lighting|sound|grip|drone|editing_workstation|encoding_hardware|other — promote to reference product]',
    `equipment_name` STRING COMMENT 'Human-readable name or model designation of the equipment item (e.g., ARRI ALEXA Mini LF, Cooke S4/i 32mm, Litepanels Astra 6X). Supports crew call sheets and production reports.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering this equipment allocation. Used for claims processing and compliance with production insurance requirements.',
    `insurance_value` DECIMAL(18,2) COMMENT 'Declared replacement value of the equipment for insurance purposes, in the currency specified by currency_code. Used to calculate insurance premiums and process loss/damage claims.',
    `is_insurance_required` BOOLEAN COMMENT 'Indicates whether specific insurance coverage must be arranged for this equipment allocation (True) or whether it falls under the productions blanket policy (False). Relevant for high-value or specialist equipment.',
    `is_owned_asset` BOOLEAN COMMENT 'Indicates whether the equipment is owned by the production company (True) or rented from an external vendor (False). Drives depreciation accounting vs. rental cost booking in SAP S/4HANA FI.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes related to the equipment allocation, such as special handling instructions, configuration requirements, or crew briefing notes.',
    `production_department` STRING COMMENT 'The production department responsible for the equipment allocation (e.g., camera, lighting, grip, sound). Used for departmental budget tracking and cost centre allocation in SAP S/4HANA CO. [ENUM-REF-CANDIDATE: camera|lighting|grip|sound|art|vfx|post_production|production_office|other — promote to reference product]',
    `purchase_order_number` STRING COMMENT 'SAP S/4HANA purchase order number raised for the equipment rental from an external vendor. Null for owned assets. Used for three-way match (PO, goods receipt, invoice) in accounts payable.',
    `quantity` STRING COMMENT 'Number of identical equipment units covered by this allocation record (e.g., 3 identical LED panels allocated as a single record). Defaults to 1 for individually serialised items.',
    `rental_rate_amount` DECIMAL(18,2) COMMENT 'The agreed rental rate per day or per week (per rental_rate_type) for the equipment, in the productions base currency. Used for production budget tracking and vendor cost reconciliation in SAP S/4HANA.',
    `rental_rate_type` STRING COMMENT 'Indicates whether the rental rate is charged on a daily, weekly, or flat-fee basis. Determines how the total rental cost is computed for budget tracking and vendor invoice reconciliation.. Valid values are `daily|weekly|flat_fee`',
    `return_condition` STRING COMMENT 'Assessed physical condition of the equipment at the time of return. Compared against checkout_condition to identify damage or deterioration. Triggers damage claim workflow if degraded. [ENUM-REF-CANDIDATE: new|excellent|good|fair|poor|damaged|lost — 7 candidates stripped; promote to reference product]',
    `return_timestamp` TIMESTAMP COMMENT 'Exact date and time the equipment was physically returned to the equipment room or rental house. Null until the equipment is returned. Used to calculate actual rental duration and late return penalties.',
    `serial_number` STRING COMMENT 'Manufacturer serial number of the specific equipment unit allocated. Used for asset tracking, insurance claims, and loss/damage investigations. Classified confidential as it identifies a specific high-value asset.',
    `shoot_location` STRING COMMENT 'Name or description of the physical location where the equipment will be used (e.g., Stage 4 - Pinewood Studios, Exterior - Canary Wharf, OB Van Unit 3). Supports logistics planning and insurance coverage verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment allocation record was last modified. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit compliance.',
    `wbs_element_code` STRING COMMENT 'SAP S/4HANA Work Breakdown Structure (WBS) element code identifying the specific production phase or deliverable to which this equipment cost is attributed (e.g., pre-production, principal photography, post-production).',
    CONSTRAINT pk_equipment_allocation PRIMARY KEY(`equipment_allocation_id`)
) COMMENT 'Allocation record tracking the assignment of production equipment (cameras, lenses, lighting rigs, sound packages, jibs, drones, editing workstations, encoding hardware) to a production project or shoot day. Captures equipment item, equipment category, serial number, rental vendor or owned asset flag, allocation start date, allocation end date, daily or weekly rental rate, insurance value, condition at checkout, condition at return, and responsible crew member. Supports equipment cost tracking and loss/damage management.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` (
    `production_episode_id` BIGINT COMMENT 'Unique surrogate identifier for the production episode record in the lakehouse Silver layer. Serves as the primary key for all downstream joins and lineage tracking.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Episodes require content ratings before broadcast/distribution. Core regulatory workflow linking production output to compliance certification. Drives scheduling decisions and parental control metadat',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Individual episodes may require COPPA declarations independent of project-level status when content varies by episode. Essential for mixed-audience series with occasional child-directed episodes.',
    `media_asset_id` BIGINT COMMENT 'Native asset identifier assigned by Dalet Galaxy Media Asset Management system for this episode. Used for direct lookup and workflow orchestration in the MAM system, ingest tracking, and archive retrieval.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project (series, mini-series, anthology, or episodic documentary) to which this episode belongs. Establishes the episode-to-project hierarchy.',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Episodes are released within specific distribution windows defining platform, territory, and timing. Real business process: episodic release scheduling, windowing strategy execution, and platform excl',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: Episodes are based on specific scripts. Strong content relationship — script is the source document for episode production. FK links episode to the locked script version used for production.',
    `season_id` BIGINT COMMENT 'Reference to the season record that groups this episode within a multi-season series. Null for mini-series or anthology formats that do not have a season structure.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Individual episodes may have separate syndication or international license agreements distinct from the series-level agreement. Real business need: episode-level rights tracking for syndication deals,',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production episodes generate content title records. While production_episode links to season, direct title linkage is needed for episodic content workflows, metadata delivery, and distribution schedul',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Total actual production cost incurred for this episode in US dollars, as recorded in SAP S/4HANA. Used for budget variance analysis, EBITDA reporting, and production cost per minute calculations.',
    `actual_delivery_date` DATE COMMENT 'Date on which the completed episode master was actually delivered to the distributor, broadcaster, or platform. Compared against scheduled_delivery_date for SLA compliance and penalty assessment.',
    `actual_running_time_sec` STRING COMMENT 'Final delivered running time of the episode in seconds as measured from the completed master file. May differ from target due to editorial decisions made during post-production. Used for playout scheduling reconciliation and delivery compliance verification.',
    `approved_budget_usd` DECIMAL(18,2) COMMENT 'Total approved production budget for this episode in US dollars, as sanctioned at greenlight. Used for budget vs. actual variance analysis in SAP S/4HANA CO and financial reporting under SOX compliance.',
    `audio_language_code` STRING COMMENT 'ISO 639-2 three-letter language code for the primary audio track of this episode. Used for distribution rights matching, subtitle/dubbing workflow triggering, and EPG metadata population.. Valid values are `^[a-z]{3}$`',
    `audio_mix_completion_date` DATE COMMENT 'Date on which the final audio mix (including dialogue, music, and effects) was completed and approved. Prerequisite for final mastering and delivery. Tracked as a post-production milestone in Dalet Galaxy.',
    `closed_captioning_compliant` BOOLEAN COMMENT 'Indicates whether this episode meets FCC closed captioning requirements (47 CFR Part 79) and Ofcom subtitling standards. Required for broadcast clearance and regulatory compliance reporting.',
    `color_grade_completion_date` DATE COMMENT 'Date on which color grading (digital color correction and finishing) was completed and approved. Required before final mastering and transcode for delivery. Tracked as a post-production milestone in Dalet Galaxy.',
    `content_rating` STRING COMMENT 'Audience content rating assigned to this episode per the TV Parental Guidelines system (US) or equivalent regulatory body. Required for EPG metadata, DAI ad targeting restrictions, and COPPA compliance for childrens content.. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `content_type` STRING COMMENT 'Broad classification of the episode content format. Determines applicable production workflows, rights frameworks, talent residual calculations, and compliance requirements (e.g., COPPA for childrens content). [ENUM-REF-CANDIDATE: scripted|unscripted|documentary|news|sports|animation|live_event — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production episode record was first created in the system. Used for audit trail, data lineage, and production workflow initiation tracking. Conforms to ISO 8601 extended format.',
    `delivery_date` DATE COMMENT 'Contractually committed or operationally planned date by which the completed episode master must be delivered to the distributor, broadcaster, or platform. Used for SLA tracking and rights window activation in Rightsline.',
    `director_name` STRING COMMENT 'Full name of the credited director for this episode. Used for DGA residuals calculation, talent contract compliance, and creative attribution in production records.',
    `eidr_code` STRING COMMENT 'EIDR content identifier for this episode, enabling interoperability across supply chain partners, distributors, and rights management systems. Registered with the Entertainment Identifier Registry.. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$`',
    `episode_code` STRING COMMENT 'Internal production code assigned by the production team to uniquely identify this episode within the production management system (e.g., Dalet Galaxy asset code). Used for workflow routing, asset tagging, and facility booking references.. Valid values are `^[A-Z0-9]{2,20}$`',
    `episode_number` STRING COMMENT 'Sequential production episode number within the season or series. Used for scheduling, EPG metadata, and audience tracking. Corresponds to the broadcast order number.',
    `first_air_date` DATE COMMENT 'Date on which this episode first aired or was made available to audiences on any platform (linear broadcast, VOD, OTT). Marks the start of the content windowing lifecycle and triggers residuals calculation in Rightsline.',
    `greenlight_date` DATE COMMENT 'Date on which executive approval (greenlight) was granted to proceed with production of this episode. Marks the official start of the production lifecycle and triggers budget release in SAP S/4HANA.',
    `isan` STRING COMMENT 'Globally unique identifier for this episode as registered with the ISAN International Agency. Used for rights clearance, royalty tracking, and cross-platform content identification. Conforms to ISO 15706-2.. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `master_format` STRING COMMENT 'Technical format specification of the delivered episode master file (e.g., UHD HDR, HD 1080p). Determines transcode profiles required for multi-platform distribution and CDN delivery via Akamai.. Valid values are `UHD_HDR|UHD_SDR|HD_1080p|HD_720p|SD`',
    `picture_lock_date` DATE COMMENT 'Date on which the final edited picture was locked, freezing all visual edits. Triggers downstream post-production workflows including VFX, color grading, and audio mixing. Critical milestone for delivery scheduling.',
    `production_company` STRING COMMENT 'Name of the production company or studio responsible for producing this episode. Used for co-production agreements, rights attribution, and financial reconciliation in SAP S/4HANA.',
    `production_status` STRING COMMENT 'Current lifecycle stage of the episode within the end-to-end production workflow. Drives workflow routing in Dalet Galaxy and milestone reporting to production management. [ENUM-REF-CANDIDATE: development|pre_production|principal_photography|post_production|picture_lock|delivered|archived — promote to reference product]',
    `script_lock_date` DATE COMMENT 'Date on which the final shooting script was locked, freezing all creative changes. Triggers pre-production scheduling, crew assignments, and facility bookings. Key milestone for production planning.',
    `shoot_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country where principal photography was conducted. Used for production tax credit eligibility, co-production treaty compliance, and content origin classification.. Valid values are `^[A-Z]{3}$`',
    `shoot_end_date` DATE COMMENT 'Scheduled or actual end date of principal photography (picture wrap) for this episode. Used to confirm transition to post-production and trigger post-production workflow initiation in Dalet Galaxy.',
    `shoot_location` STRING COMMENT 'Primary geographic location where principal photography for this episode was conducted. Used for production tax credit eligibility, location permit compliance, and production logistics reporting.',
    `shoot_start_date` DATE COMMENT 'Scheduled or actual start date of principal photography for this episode. Used for crew scheduling, facility booking, and production budget burn-rate tracking in SAP S/4HANA.',
    `showrunner_name` STRING COMMENT 'Full name of the showrunner (executive producer with creative oversight) responsible for this episode. Key accountability reference for production governance and editorial decisions.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 three-letter language codes for subtitle tracks available in the delivered master. Used for accessibility compliance (FCC closed captioning rules), distribution rights, and EPG metadata.',
    `target_running_time_sec` STRING COMMENT 'Planned editorial running time of the episode in seconds, excluding commercial breaks. Used for scheduling slot allocation, playout automation configuration in Ericsson MediaFirst, and delivery specification compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this production episode record. Used for incremental data pipeline processing, change data capture, and audit compliance in the Databricks Silver layer.',
    `vfx_completion_date` DATE COMMENT 'Date on which all visual effects shots were completed and approved for integration into the picture lock. Tracked as a post-production milestone. Null if the episode contains no VFX work.',
    `writer_name` STRING COMMENT 'Full name of the credited writer(s) for this episode. Used for residuals calculation, WGA/guild compliance reporting, and rights attribution in Rightsline.',
    CONSTRAINT pk_production_episode PRIMARY KEY(`production_episode_id`)
) COMMENT 'Master record for an individual episode, segment, or installment within a production project (series, mini-series, anthology, or episodic documentary). Captures episode number, episode title, season number, running time target, production status, writer, director, script lock date, picture lock date, audio mix completion date, delivery date, and ISAN episode identifier. Acts as the granular production unit below the project level for episodic content.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`script` (
    `script_id` BIGINT COMMENT 'Unique identifier for the production script or screenplay record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Scripts for branded content episodes and product integration scenes reference specific advertiser campaigns for approval and compliance. Business process: product placement script approval workflow, b [FK namespace reconciled: points to sales.campaign]',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode to which this script belongs.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Scripts are written for specific content titles. Essential for pre-production planning, rights clearance (script-based content analysis), and tracking script versions against final distributed content',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Scripts are often based on underlying IP owned by rights holders (novels, plays, life rights, true stories, existing franchises). Real business need: tracking the rights holder of the underlying IP be',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: When writers are staff employees (vs. freelance), tracking employment relationship is essential for WGA residuals calculation, benefits administration, and tax reporting—common in animation and daytim',
    `approval_date` DATE COMMENT 'The date on which the script was officially approved for production.',
    `approved_by` STRING COMMENT 'The name or identifier of the individual or role who approved the script for production.',
    `confidentiality_level` STRING COMMENT 'The confidentiality classification of the script document (public, internal, confidential, restricted).. Valid values are `public|internal|confidential|restricted`',
    `copyright_holder` STRING COMMENT 'The legal entity or individual who holds the copyright to the script.',
    `copyright_year` STRING COMMENT 'The year in which the script copyright was established or registered.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this script record was first created in the system.',
    `dalet_document_reference` STRING COMMENT 'The unique document identifier or reference in the Dalet Galaxy Media Asset Management (MAM) system linking this script record to the digital script file.',
    `distribution_restriction` STRING COMMENT 'Any restrictions or limitations on the distribution or sharing of the script (e.g., internal use only, NDA required).',
    `draft_type` STRING COMMENT 'The classification of the script draft stage (outline, first draft, revised draft, shooting script, post-production script, final draft).. Valid values are `outline|first draft|revised draft|shooting script|post-production script|final draft`',
    `estimated_runtime_minutes` STRING COMMENT 'The estimated runtime of the production in minutes based on the script length and pacing.',
    `file_format` STRING COMMENT 'The digital file format of the script document (PDF, DOCX, FDX, FOUNTAIN, TXT).. Valid values are `PDF|DOCX|FDX|FOUNTAIN|TXT`',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The size of the script file in megabytes.',
    `format` STRING COMMENT 'The production format for which the script is intended (feature film, television episode, miniseries, web series, documentary, commercial, short film). [ENUM-REF-CANDIDATE: feature film|television episode|miniseries|web series|documentary|commercial|short film — 7 candidates stripped; promote to reference product]',
    `genre` STRING COMMENT 'The genre or category of the script (e.g., drama, comedy, thriller, documentary).',
    `language` STRING COMMENT 'The primary language in which the script is written (e.g., English, Spanish, French).',
    `lock_date` DATE COMMENT 'The date on which the script was locked and finalized for production.',
    `lock_status` BOOLEAN COMMENT 'Indicates whether the script is locked for production (true) or still open for revisions (false).',
    `notes` STRING COMMENT 'General notes, comments, or annotations related to the script for production reference.',
    `page_count` STRING COMMENT 'The total number of pages in the script document.',
    `revision_date` DATE COMMENT 'The date of the most recent revision or update to the script.',
    `revision_notes` STRING COMMENT 'Notes or comments describing the changes made in the current revision of the script.',
    `rights_clearance_status` STRING COMMENT 'The status of rights clearance for the script (pending, cleared, restricted, expired).. Valid values are `pending|cleared|restricted|expired`',
    `scene_count` STRING COMMENT 'The total number of scenes defined in the script.',
    `script_number` STRING COMMENT 'The externally-known unique identifier or code assigned to this script for production tracking and reference purposes.',
    `script_status` STRING COMMENT 'Current lifecycle status of the script (draft, in review, approved, locked, archived, rejected).. Valid values are `draft|in review|approved|locked|archived|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this script record was last updated or modified.',
    `version_number` STRING COMMENT 'The version or revision number of the script (e.g., 1.0, 2.3, Final).',
    `wga_registration_number` STRING COMMENT 'The WGA registration number assigned to this script for copyright and intellectual property protection.',
    `writer_credits` STRING COMMENT 'The names and credits of the writer(s) who authored or contributed to the script.',
    CONSTRAINT pk_script PRIMARY KEY(`script_id`)
) COMMENT 'Master record for a production script or screenplay associated with a production project or episode. Captures script title, version number, draft type (outline, first draft, revised draft, shooting script, post-production script), writer credits, WGA registration number, page count, script lock status, lock date, language, and Dalet Galaxy document reference. Tracks the full script revision history and serves as the authoritative script record for production and rights purposes.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` (
    `post_production_task_id` BIGINT COMMENT 'Unique identifier for the post-production task within the Dalet Galaxy workflow orchestration pipeline.',
    `content_episode_id` BIGINT COMMENT 'Reference to the parent episode or content asset that this post-production task is associated with.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Post-production tasks (editing, color, audio mix) create specific content versions. Critical for tracking which production tasks generated which distributable versions, version lineage, and linking pr',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: Post-production tasks produce deliverables. Optional FK (nullable) — not all tasks produce final deliverables (intermediate tasks). When populated, links task output to contractual/operational deliver',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Post-production tasks (editing, color grading, audio mix) produce intermediate and final assets stored in MAM. Role-prefixed as output_asset_id to distinguish from source media. Critical for workflow ',
    `parent_task_post_production_task_id` BIGINT COMMENT 'Reference to the parent post-production task if this task is a sub-task or dependent task in a hierarchical workflow.',
    `partner_id` BIGINT COMMENT 'Reference to the external vendor or post-production facility assigned to perform this task, if outsourced.',
    `employee_id` BIGINT COMMENT 'Reference to the crew member or operator assigned to execute this post-production task.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project that this post-production task belongs to.',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: Post-production tasks reference scripts for scene/dialogue context. Optional FK (nullable) — provides editorial context for tasks. Enables linking task to script version for continuity.',
    `studio_facility_id` BIGINT COMMENT 'Reference to the post-production facility or studio where the task is being performed.',
    `vfx_shot_id` BIGINT COMMENT 'Foreign key linking to production.vfx_shot. Business justification: VFX-specific post-production tasks (compositing, rendering, etc.) are shot-specific. Optional FK (nullable) — only VFX tasks populate this. Enables linking Dalet workflow tasks to VFX shot tracking.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when the post-production task was completed and submitted for review or approval.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost incurred for completing this post-production task, used for budget variance analysis.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing the post-production task, used for cost tracking and performance analysis.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work on the post-production task commenced.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the task output was formally approved and authorized to proceed to the next workflow stage.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this post-production task record was first created in the workflow system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this task.. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_task_reference` STRING COMMENT 'External system identifier from Dalet Galaxy workflow orchestration system for this specific task instance.',
    `dependency_type` STRING COMMENT 'Type of scheduling dependency relationship this task has with its predecessor tasks in the workflow.. Valid values are `finish_to_start|start_to_start|finish_to_finish|start_to_finish|none`',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Budgeted cost for completing this post-production task, including labor, equipment, and vendor fees.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Planned number of hours required to complete the post-production task, used for resource planning and scheduling.',
    `output_media_path` STRING COMMENT 'File system path or MAM location where the completed output files or deliverables from this task are stored.',
    `priority` STRING COMMENT 'Business priority level assigned to the task, determining scheduling and resource allocation urgency.. Valid values are `critical|high|normal|low`',
    `qc_pass_flag` BOOLEAN COMMENT 'Indicator of whether the task output passed quality control review on first submission without requiring revisions.',
    `rejection_reason` STRING COMMENT 'Explanation of why the task output was rejected during review, requiring rework or revision.',
    `review_notes` STRING COMMENT 'Feedback, comments, or change requests provided by reviewers or approvers during the quality control or approval process.',
    `revision_number` STRING COMMENT 'Version number indicating how many times this task has been revised or reworked due to feedback or quality issues.',
    `scheduled_due_date` DATE COMMENT 'Target completion date for the post-production task as defined in the production schedule.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the post-production task is scheduled to begin.',
    `sequence_number` STRING COMMENT 'Ordering position of this task within the overall post-production workflow or within a parent task group.',
    `source_media_path` STRING COMMENT 'File system path or Media Asset Management (MAM) location of the source media files or assets for this task.',
    `task_notes` STRING COMMENT 'General operational notes, instructions, or context information related to the execution of this post-production task.',
    `task_number` STRING COMMENT 'Human-readable business identifier for the post-production task, often used for tracking and communication purposes.',
    `task_status` STRING COMMENT 'Current lifecycle status of the post-production task within the workflow pipeline. [ENUM-REF-CANDIDATE: queued|in_progress|review|approved|rejected|complete|on_hold|cancelled — 8 candidates stripped; promote to reference product]',
    `task_type` STRING COMMENT 'Classification of the post-production work task indicating the specific type of creative or technical operation being performed. [ENUM-REF-CANDIDATE: offline_edit|online_conform|vfx_composite|color_grade|audio_mix|adr_record|subtitle_burn_in|qc_review|transcode|archive_ingest|foley_record|sound_design|title_graphics|versioning — 14 candidates stripped; promote to reference product]',
    `technical_specification` STRING COMMENT 'Detailed technical requirements and parameters for the task output, such as resolution, frame rate, codec, color space, or audio format.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this post-production task record was last modified or updated.',
    `workstation_code` STRING COMMENT 'Identifier of the specific editing suite, color grading bay, or audio mixing console assigned for this task.',
    CONSTRAINT pk_post_production_task PRIMARY KEY(`post_production_task_id`)
) COMMENT 'Individual post-production work task within the Dalet Galaxy workflow orchestration pipeline. Captures task type (offline edit, online conform, VFX composite, color grade, audio mix, ADR record, subtitle burn-in, QC review, transcode, archive ingest), assigned operator or vendor, task status (queued, in-progress, review, approved, rejected, complete), priority, due date, actual completion date, parent episode or deliverable, and Dalet Galaxy workflow task ID. Enables end-to-end post-production workflow tracking.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` (
    `vfx_shot_id` BIGINT COMMENT 'Unique identifier for the VFX shot record. Primary key.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: VFX rendering and processing often occurs at specific broadcast facilities with render farms and high-performance workstations. Real-world VFX operations track facility assignment for resource allocat',
    `employee_id` BIGINT COMMENT 'Reference to the VFX supervisor responsible for overseeing the creative and technical execution of this shot.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: VFX shots produce rendered asset files stored in MAM for editorial integration. Role-prefixed as rendered_asset_id to distinguish from source plates. Critical for VFX delivery workflows and version co',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: VFX shots are episode-specific. Optional FK (nullable) — VFX may be project-level or episode-level. Enables episode-specific VFX tracking and cost allocation for episodic content.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project for which this VFX shot is being created.',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: VFX shots reference specific script scenes. FK links VFX shot to script for scene context and continuity. Enables tracking which script scenes require VFX work.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: VFX shots are created for specific content titles. Required for VFX cost allocation to distributed content, content-level VFX asset tracking, and post-production reporting by title. While vfx_shot lin',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: VFX shots are outsourced to external VFX vendors (partners). Linking enables bid comparison across vendors, delivery tracking, payment processing, vendor performance evaluation, and shot allocation op',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual incurred cost for the VFX shot upon completion, including all revisions and additional work. Used for budget reconciliation and variance analysis.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the final approved version of the VFX shot was delivered and accepted by the production team.',
    `approved_cost` DECIMAL(18,2) COMMENT 'Final approved budget allocation for the VFX shot after negotiation and production approval. This is the committed cost against which actual expenditure is tracked.',
    `approved_date` DATE COMMENT 'Date when the VFX shot received final creative and technical approval from the director, VFX supervisor, or production stakeholders.',
    `archive_location` STRING COMMENT 'Physical or logical storage location where the final approved VFX shot and associated project files are archived for long-term preservation and future retrieval.',
    `aspect_ratio` STRING COMMENT 'Aspect ratio of the VFX shot (e.g., 16:9, 2.39:1, 1.85:1), defining the width-to-height proportions of the frame.',
    `assigned_team_name` STRING COMMENT 'Name of the in-house VFX team or department assigned to execute this shot. Null if the shot is outsourced to an external vendor.',
    `bid_cost` DECIMAL(18,2) COMMENT 'Initial bid or estimated cost for the VFX shot as quoted by the vendor or estimated by the in-house team during pre-production planning. Expressed in the productions base currency.',
    `brief_issued_date` DATE COMMENT 'Date when the VFX shot brief and requirements were issued to the vendor or in-house team, marking the start of the VFX production timeline.',
    `color_space` STRING COMMENT 'Color space standard used for the VFX shot (e.g., Rec. 709, DCI-P3, ACEScg), ensuring color consistency across the production pipeline.',
    `complexity_tier` STRING COMMENT 'Classification of the VFX shot complexity level used for resource planning and cost estimation. Simple: basic compositing or cleanup. Moderate: multi-layer compositing or simple CGI. Complex: advanced CGI, multiple effects layers, or intricate integration. Hero: signature shots requiring top-tier artistry and extensive iteration.. Valid values are `simple|moderate|complex|hero`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VFX shot record was first created in the system, marking the initial entry into the production tracking database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this VFX shot (bid_cost, approved_cost, actual_cost).. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'Unique workflow identifier in the Dalet Galaxy Media Asset Management system, linking this VFX shot record to the orchestrated production workflow and asset metadata.',
    `delivery_version` STRING COMMENT 'Version number of the VFX shot delivery. Increments with each iteration submitted for review. Final approved version is recorded here.',
    `eidr_code` STRING COMMENT 'EIDR identifier for the VFX shot if registered as a distinct audiovisual asset, enabling global identification and rights management across the content supply chain.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `file_format` STRING COMMENT 'Digital file format of the delivered VFX shot (e.g., EXR, DPX, ProRes, DNxHD), specifying the codec and container used for delivery.',
    `final_frame_count` STRING COMMENT 'Total number of frames in the final approved VFX shot. Used for billing, workload estimation, and archival metadata.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of the VFX shot in frames per second (fps), typically 23.976, 24, 25, 29.97, or 30 fps depending on the production format.',
    `notes` STRING COMMENT 'Free-text field for production notes, creative direction, technical requirements, or any additional context relevant to the VFX shot execution and review.',
    `resolution` STRING COMMENT 'Pixel resolution of the VFX shot (e.g., 1920x1080, 3840x2160, 4096x2160), indicating the output format and quality tier.',
    `revision_count` STRING COMMENT 'Total number of revision iterations the VFX shot underwent from initial submission to final approval. Used for workload analysis and vendor performance evaluation.',
    `scene_reference` STRING COMMENT 'Reference to the scene number or identifier in the script or production schedule to which this VFX shot belongs.',
    `scheduled_delivery_date` DATE COMMENT 'Target date by which the final approved VFX shot is scheduled to be delivered, as agreed in the production schedule or vendor contract.',
    `shot_code` STRING COMMENT 'Unique business identifier for the VFX shot, typically following a hierarchical naming convention such as sequence_scene_shot (e.g., SQ010_SC020_0150). Used across production, post-production, and vendor communication.. Valid values are `^[A-Z0-9]{2,6}_[A-Z0-9]{3,6}_[0-9]{3,4}$`',
    `shot_name` STRING COMMENT 'Human-readable descriptive name or title for the VFX shot, providing context about the shot content (e.g., Hero flies over city, Explosion in warehouse).',
    `shot_status` STRING COMMENT 'Current lifecycle status of the VFX shot. Brief issued: initial requirements provided. In-progress: active work by vendor or team. Vendor review: internal QA at vendor. Client review: submitted to production for approval. Approved: final sign-off received. Archived: shot completed and archived.. Valid values are `brief_issued|in_progress|vendor_review|client_review|approved|archived`',
    `take_reference` STRING COMMENT 'Reference to the specific camera take or plate footage that serves as the base for this VFX shot.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this VFX shot record, capturing any modification to status, cost, delivery version, or other tracked attributes.',
    `vfx_category` STRING COMMENT 'Primary category of visual effects work required for this shot: compositing (layering multiple elements), CGI (computer-generated imagery), matte painting (digital background painting), motion capture (performance capture), de-aging (digital age reduction), or green screen key (chroma key extraction).. Valid values are `compositing|cgi|matte_painting|motion_capture|de_aging|green_screen_key`',
    CONSTRAINT pk_vfx_shot PRIMARY KEY(`vfx_shot_id`)
) COMMENT 'Master record for an individual VFX (Visual Effects) shot within a production. Captures shot code, scene and take reference, VFX category (compositing, CGI, matte painting, motion capture, de-aging, green screen key), complexity tier, assigned VFX vendor or in-house team, bid cost, approved cost, delivery version, shot status (brief issued, in-progress, vendor review, client review, approved, archived), and final frame count. Tracks the full VFX pipeline from brief to approved delivery.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` (
    `deliverable_id` BIGINT COMMENT 'Unique identifier for the production deliverable. Primary key.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Each deliverable conforms to specific ABR encoding profile for adaptive streaming distribution. Real business process: transcoding workflow configuration, encoding quality control, and streaming optim',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Deliverables must comply with specific accessibility obligations (closed captioning, audio description, emergency information access) based on distribution channel and regulatory jurisdiction.',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Deliverables must track closed captioning compliance for FCC accessibility regulations. Required for broadcast clearance and public inspection file documentation.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Deliverables must reference their content rating for distribution compliance verification. Required for platform submission, broadcast clearance, and international distribution workflows.',
    `content_delivery_order_id` BIGINT COMMENT 'Foreign key linking to distribution.content_delivery_order. Business justification: Deliverables fulfill specific content delivery orders to distribution partners. Real business process: fulfillment tracking, delivery confirmation, and partner order management.',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Deliverables require specific DRM protection policies based on content rights and platform requirements. Real business process: content protection enforcement, rights management, and secure delivery c',
    `encoder_config_id` BIGINT COMMENT 'Foreign key linking to technology.encoder_config. Business justification: Deliverables must be encoded using specific encoder configurations to meet platform technical requirements. Real-world delivery workflows track which encoder profile was used for compliance verificati',
    `format_spec_id` BIGINT COMMENT 'Foreign key linking to production.format_spec. Business justification: Normalization opportunity. Deliverable currently has target_format (STRING). FK to format_spec allows retrieving full technical specification (resolution, frame_rate, codec, etc.) and ensures delivera',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Branded content deliverables often ARE the ad creative asset delivered to advertisers. Business process: branded content asset delivery to advertisers, product integration segment handoff, advertiser  [FK namespace reconciled: points to sales.isci_creative]',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Deliverables are created to fulfill specific license agreement technical and format requirements (e.g., HD master for territory X, dubbed version for territory Y). Real business need: linking delivera',
    `media_asset_id` BIGINT COMMENT 'Reference to the digital media asset in the Media Asset Management (MAM) system that represents this deliverable. Links to Dalet Galaxy or other MAM upon delivery.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Deliverables can be episode-specific (e.g., episodic masters for series). Optional FK (nullable) — deliverables may be project-level or episode-level. Enables episode-specific deliverable tracking.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project that this deliverable belongs to.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Deliverables are sent to distribution partners, broadcasters, streaming platforms, and licensees. Linking enables delivery obligation tracking, SLA compliance monitoring, acceptance workflow managemen',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Deliverables must meet specific regulatory obligations before distribution. Links delivery workflow to compliance verification for broadcast standards, platform requirements, and international regulat',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Specific deliverable versions (HD, 4K, censored cuts) are scheduled for playout. Playout automation references exact deliverable file. Required for traffic/continuity operations, version control, and ',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Deliverables are delivered to specific streaming endpoints for CDN ingestion and distribution. Real business process: content delivery tracking, CDN ingestion workflow, and delivery confirmation.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Deliverables are formatted for specific platforms with platform-specific technical requirements (resolution, codec, DRM). Real business process: platform-specific asset preparation, transcoding, and d',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Deliverables are final production outputs that become content titles in the distribution system. Critical for asset-to-content mapping, delivery acceptance workflows, and tracking which production del',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the deliverable was successfully delivered or handed off.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video deliverable (e.g., 16:9, 4:3, 2.39:1, 1:1). Null for non-video deliverables.',
    `audio_channels` STRING COMMENT 'Audio channel configuration for the deliverable (e.g., Stereo, 5.1 Surround, 7.1 Surround, Mono, Dolby Atmos). Null for non-audio deliverables.',
    `audio_description_flag` BOOLEAN COMMENT 'Indicates whether an audio description track for visually impaired viewers is included. True = audio description present; False = no audio description.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the deliverable file for integrity verification during transfer and storage.. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_flag` BOOLEAN COMMENT 'Indicates whether closed captions for accessibility are included in this deliverable. True = closed captions present; False = no closed captions.',
    `compliance_certificate_flag` BOOLEAN COMMENT 'Indicates whether a regulatory compliance certificate (e.g., FCC, Ofcom, content rating) accompanies this deliverable. True = certificate included; False = no certificate.',
    `content_rating` STRING COMMENT 'Age or content rating assigned to this deliverable (e.g., TV-PG, TV-14, TV-MA, G, PG, PG-13, R, NC-17). Used for compliance and audience targeting.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the contract or agreement that mandates this deliverable.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to produce this deliverable, including labor, equipment, facilities, and post-production services.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deliverable record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_type` STRING COMMENT 'Category of deliverable output. Broadcast master = final linear transmission file; streaming master = OTT/VOD optimized file; promo cut = promotional excerpt; trailer = marketing preview; EPK = Electronic Press Kit; closed caption file = accessibility text; audio description track = visually impaired narration; subtitle file = translation text; M&E track = Music and Effects (no dialogue); textless version = graphics-free master; compliance certificate = regulatory approval document; QC report = Quality Control validation; as-run log = actual playout record. [ENUM-REF-CANDIDATE: broadcast_master|streaming_master|promo_cut|trailer|epk|closed_caption_file|audio_description_track|subtitle_file|me_track|textless_version|compliance_certificate|qc_report|as_run_log|other — 14 candidates stripped; promote to reference product]',
    `delivery_location` STRING COMMENT 'Physical address, URL, FTP path, or cloud storage location where the deliverable was sent or made available.',
    `delivery_method` STRING COMMENT 'Method or protocol used to deliver the deliverable to the recipient. Physical media = hard drive/tape shipment; FTP = File Transfer Protocol; Aspera = high-speed file transfer; Signiant = media transfer platform; AWS S3 = Amazon cloud storage; Akamai NetStorage = CDN storage; Google Drive/Dropbox = cloud file sharing. [ENUM-REF-CANDIDATE: physical_media|ftp|aspera|signiant|aws_s3|akamai_netstorage|google_drive|dropbox|other — 9 candidates stripped; promote to reference product]',
    `delivery_status` STRING COMMENT 'Current lifecycle state of the deliverable. Not started = work has not begun; in progress = actively being produced; QC pending = awaiting quality control review; QC failed = did not pass quality checks; QC passed = approved for delivery; ready for delivery = prepared and awaiting handoff; delivered = sent to recipient; accepted = recipient confirmed receipt and approval; rejected = recipient declined or returned; cancelled = deliverable no longer required. [ENUM-REF-CANDIDATE: not_started|in_progress|qc_pending|qc_failed|qc_passed|ready_for_delivery|delivered|accepted|rejected|cancelled — 10 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'Contractually or operationally required date by which this deliverable must be completed and handed off.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total runtime duration of the deliverable in seconds (for video/audio deliverables). Null for non-time-based deliverables like documents or images.',
    `eidr_code` STRING COMMENT 'Unique universal identifier for the audiovisual content assigned by the Entertainment Identifier Registry. Used for global content identification and rights management.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `file_size_bytes` BIGINT COMMENT 'Total file size of the deliverable in bytes. Used for storage planning, transfer time estimation, and CDN capacity management.',
    `language_code` STRING COMMENT 'Primary language of the deliverable content using ISO 639-1 or ISO 639-2 two or three-letter code, optionally followed by ISO 3166-1 alpha-2 country code (e.g., en, en-US, es-MX, fr-CA).. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `deliverable_name` STRING COMMENT 'Human-readable name or title of the deliverable (e.g., Broadcast Master HD, Promo Cut 30s, Closed Caption SRT File).',
    `qc_notes` STRING COMMENT 'Detailed notes from the quality control review, including any issues found, corrective actions taken, or validation comments.',
    `qc_operator_name` STRING COMMENT 'Name of the quality control technician or automated system that performed the QC validation.',
    `qc_pass_flag` BOOLEAN COMMENT 'Indicates whether the deliverable passed quality control validation. True = passed QC; False = failed QC or not yet tested.',
    `qc_performed_timestamp` TIMESTAMP COMMENT 'Date and time when quality control validation was completed for this deliverable.',
    `revision_notes` STRING COMMENT 'Description of changes made in this revision of the deliverable (e.g., Corrected audio sync issue, Updated end credits, Re-encoded for HDR).',
    `revision_number` STRING COMMENT 'Version or revision number of this deliverable. Increments when the deliverable is updated or redelivered after corrections.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time for delivery of this deliverable to the recipient or platform.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of language codes for subtitle tracks included in this deliverable (e.g., en,es,fr). Null if no subtitles are included.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this deliverable record was last modified.',
    CONSTRAINT pk_deliverable PRIMARY KEY(`deliverable_id`)
) COMMENT 'Contractually or operationally required output deliverable from a production project — the specific media asset or document that must be produced and handed off. Captures deliverable name, deliverable type (broadcast master, streaming master, promo cut, trailer, EPK, closed caption file, audio description track, subtitles, M&E track, textless version, compliance certificate), target format, target platform or recipient, due date, actual delivery date, delivery status, and QC pass/fail flag. Links to the digital asset management domain upon delivery.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` (
    `qc_review_id` BIGINT COMMENT 'Unique identifier for the quality control review record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: QC reviews verify compliance against specific accessibility obligations. Links quality control processes to regulatory requirements for CVAA, FCC accessibility rules, and international standards.',
    `employee_id` BIGINT COMMENT 'Reference to the person or role who provided final approval for the deliverable.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: QC review stations and infrastructure are located at specific broadcast facilities. Real-world quality control workflows require tracking which facility performed each review for compliance auditing, ',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: QC reviews verify closed captioning accuracy, synchronization, and completeness against FCC standards. Direct operational link between quality control and accessibility compliance verification.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: QC reviews validate specific content versions for distribution. Essential for version-level quality tracking, linking production QC to content version records, and ensuring only QC-passed versions are',
    `deliverable_id` BIGINT COMMENT 'Reference to the production deliverable or post-production output being reviewed.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Production QC reviews inspect specific media assets for technical compliance before delivery. Role-prefixed as reviewed_asset_id since qc_review already links to deliverable. Essential for broadcast c',
    `post_production_task_id` BIGINT COMMENT 'Foreign key linking to production.post_production_task. Business justification: QC reviews are performed on post-production task outputs. Optional FK (nullable) — QC may be on final deliverables or intermediate task outputs. When populated, links QC review to the specific Dalet w',
    `primary_qc_employee_id` BIGINT COMMENT 'Reference to the QC operator or technician who performed the review.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this QC review belongs to.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: QC reviews validate deliverables against target ABR profile specifications for distribution readiness. Real business process: quality assurance for streaming assets, technical compliance validation, a',
    `audio_channel_configuration` STRING COMMENT 'Audio channel layout (e.g., stereo, 5.1 surround, 7.1 surround, mono).',
    `audio_codec` STRING COMMENT 'Audio codec used in the deliverable (e.g., AAC, Dolby Digital, PCM).',
    `audio_description_compliance_flag` BOOLEAN COMMENT 'Indicates whether audio description track meets accessibility standards. True if compliant, False if missing or non-compliant.',
    `closed_caption_compliance_flag` BOOLEAN COMMENT 'Indicates whether closed captions meet accessibility and regulatory standards (FCC, CVAA). True if compliant, False if violations detected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC review record was first created in the system.',
    `dalet_workflow_reference` STRING COMMENT 'Identifier linking this QC review to the corresponding workflow instance in Dalet Galaxy MAM for ingest and workflow orchestration.',
    `error_codes` STRING COMMENT 'Comma-separated list of specific error codes identified during the review, aligned with EBU R128, ATSC A/85, and ITU-R BT.1788 standards (e.g., V001 for video freeze, A002 for loudness violation, C003 for closed caption sync error).',
    `final_approval_date` DATE COMMENT 'Date when the deliverable received final approval for distribution. Null if not yet approved.',
    `final_approval_status` STRING COMMENT 'Final approval status of the deliverable after QC review and any remediation: approved (ready for distribution), rejected (does not meet standards), pending approval (awaiting sign-off), or conditional approval (approved with minor caveats).. Valid values are `approved|rejected|pending_approval|conditional_approval`',
    `loudness_compliance_flag` BOOLEAN COMMENT 'Indicates whether the deliverable meets loudness standards (EBU R128 or ATSC A/85). True if compliant, False if violations detected.',
    `loudness_lufs` DECIMAL(18,2) COMMENT 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) per EBU R128 or ATSC A/85 standards. Target is typically -23 LUFS for broadcast.',
    `p1_critical_error_count` STRING COMMENT 'Number of P1 critical errors that prevent broadcast or distribution (e.g., audio dropout, video corruption, missing segments).',
    `p2_major_error_count` STRING COMMENT 'Number of P2 major errors that significantly impact quality but may not prevent distribution (e.g., color grading inconsistencies, audio sync issues).',
    `p3_minor_error_count` STRING COMMENT 'Number of P3 minor errors that have minimal impact on viewer experience (e.g., minor subtitle timing issues, cosmetic artifacts).',
    `qc_notes` STRING COMMENT 'Free-text notes and observations recorded by the QC operator during the review, including context for errors and recommendations.',
    `qc_platform` STRING COMMENT 'Name of the QC platform or tool used to perform the review (e.g., Dalet Galaxy QC module, Tektronix Sentry, Interra Baton).',
    `qc_result` STRING COMMENT 'Overall result of the QC review: pass (no issues), fail (critical issues preventing distribution), conditional pass (minor issues requiring remediation), or pending review (awaiting final approval).. Valid values are `pass|fail|conditional_pass|pending_review`',
    `qc_type` STRING COMMENT 'Type of quality control review performed: technical QC (video/audio quality), editorial QC (content accuracy), compliance QC (regulatory standards), accessibility QC (closed captions, audio description), loudness QC (EBU R128/ATSC A/85), or format QC (file format and codec validation).. Valid values are `technical_qc|editorial_qc|compliance_qc|accessibility_qc|loudness_qc|format_qc`',
    `re_qc_date` DATE COMMENT 'Date when the deliverable was re-reviewed after remediation. Null if no re-QC has been performed.',
    `remediation_notes` STRING COMMENT 'Detailed notes describing the remediation actions required to address identified errors and bring the deliverable into compliance.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether the deliverable requires remediation or correction before final approval. True if remediation needed, False if no action required.',
    `review_date` DATE COMMENT 'Date when the QC review was performed.',
    `review_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the QC review session in minutes.',
    `review_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC operator completed the review session.',
    `review_number` STRING COMMENT 'Business identifier for the QC review, typically formatted as a human-readable reference code.',
    `review_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC operator began the review session.',
    `review_status` STRING COMMENT 'Current lifecycle status of the QC review process.. Valid values are `scheduled|in_progress|completed|on_hold|cancelled`',
    `total_error_count` STRING COMMENT 'Total number of errors identified across all severity levels during the QC review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC review record was last modified.',
    `video_codec` STRING COMMENT 'Video codec used in the deliverable (e.g., H.264, H.265/HEVC, ProRes, MPEG-2).',
    `video_frame_rate` DECIMAL(18,2) COMMENT 'Measured video frame rate (e.g., 23.976, 25, 29.97, 50, 59.94 fps).',
    `video_resolution` STRING COMMENT 'Measured video resolution of the deliverable (e.g., 1920x1080, 3840x2160).',
    CONSTRAINT pk_qc_review PRIMARY KEY(`qc_review_id`)
) COMMENT 'Quality control review record for a production deliverable or post-production output. Captures QC type (technical QC, editorial QC, compliance QC, accessibility QC, loudness QC), QC operator, review date, pass/fail/conditional result, error count by severity (P1 critical, P2 major, P3 minor), specific error codes per EBU R128/ATSC A/85 loudness standards and ITU-R BT.1788 video quality standards, remediation required flag, re-QC date, and final approval status. Ensures all deliverables meet broadcast and platform technical specifications before distribution. Feeds the deliverable acceptance workflow.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` (
    `ingest_record_id` BIGINT COMMENT 'Unique identifier for the media ingest record in the Dalet Galaxy MAM system. Primary key.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Media ingest operations occur at specific broadcast facilities with dedicated ingest infrastructure. Real-world media operations require tracking which facility performed each ingest for asset locatio',
    `employee_id` BIGINT COMMENT 'System identifier for the operator who performed the ingest. Links to employee or contractor identity management system.',
    `media_asset_id` BIGINT COMMENT 'Unique asset identifier assigned by Dalet Galaxy MAM system upon successful ingest completion. This is the system-of-record identifier for the ingested media asset.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Normalization opportunity. Ingest record currently has episode_number (STRING). FK to production_episode provides referential integrity and enables linking ingested media to episode metadata (title, s',
    `project_id` BIGINT COMMENT 'Reference to the production project this ingest is associated with. Links to the parent production project entity.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production ingest records capture source material for specific content titles. Critical for production-to-content asset lineage, source material tracking, and linking production ingests to final distr',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video content. Standard values include 16:9, 4:3, 21:9, 2.39:1.. Valid values are `^[0-9]+:[0-9]+$|16:9|4:3|21:9|2.39:1|1.85:1`',
    `audio_channels` STRING COMMENT 'Number of audio channels in the ingested media. Common values include 1 (mono), 2 (stereo), 6 (5.1 surround), 8 (7.1 surround).',
    `audio_sample_rate` STRING COMMENT 'Audio sample rate in Hz. Common values include 44100, 48000, 96000.',
    `bit_depth` STRING COMMENT 'Bit depth of the video or audio content. Common values include 8, 10, 12, 16, 24.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the ingested file for integrity verification. Used to detect corruption during transfer and storage.. Valid values are `^[a-f0-9]{32}$`',
    `checksum_sha256` STRING COMMENT 'SHA-256 hash of the ingested file for enhanced integrity verification and compliance with modern security standards.. Valid values are `^[a-f0-9]{64}$`',
    `codec` STRING COMMENT 'Video or audio codec used in the source media. Examples include H.264, H.265/HEVC, ProRes 422, DNxHD, PCM, AAC.',
    `color_space` STRING COMMENT 'Color space of the video content. Examples include Rec.709, Rec.2020, DCI-P3, sRGB, Log-C.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ingest record was first created in the system. Used for audit trail and data lineage.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the ingested media in seconds. Null for still images or non-time-based media.',
    `error_code` STRING COMMENT 'System error code if the ingest operation failed. Used for troubleshooting and operational reporting.',
    `error_message` STRING COMMENT 'Human-readable error message describing the reason for ingest failure. Null if ingest was successful.',
    `file_size_bytes` BIGINT COMMENT 'Total file size of the ingested media in bytes. Used for storage capacity planning and transfer validation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frames per second of the video content. Common values include 23.976, 24, 25, 29.97, 30, 50, 59.94, 60.',
    `ingest_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the ingest operation completed successfully or failed. Null if still in progress.',
    `ingest_number` STRING COMMENT 'Human-readable business identifier for the ingest event, typically formatted as ING-YYYYMMDD-sequence for tracking and reference purposes.. Valid values are `^ING-[0-9]{6,10}$`',
    `ingest_operator_name` STRING COMMENT 'Name of the operator or technician who initiated the ingest operation. Used for accountability and workflow tracking.',
    `ingest_priority` STRING COMMENT 'Priority level assigned to the ingest operation. Determines processing queue order and resource allocation.. Valid values are `urgent|high|normal|low`',
    `ingest_status` STRING COMMENT 'Current lifecycle status of the ingest operation. Tracks progression from initiation through completion or failure.. Valid values are `pending|in-progress|complete|failed|cancelled|quarantined`',
    `ingest_timestamp` TIMESTAMP COMMENT 'Date and time when the ingest operation was initiated. This is the principal business event timestamp for the ingest record.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the ingest operator. May include special handling instructions, content observations, or technical issues.',
    `quality_check_status` STRING COMMENT 'Status of automated or manual quality control checks performed on the ingested media. Ensures technical compliance before downstream use.. Valid values are `pending|passed|failed|waived`',
    `resolution` STRING COMMENT 'Video resolution of the ingested media. Can be expressed as pixel dimensions (e.g., 1920x1080) or standard abbreviations (HD, 4K, 8K).. Valid values are `^[0-9]{3,4}x[0-9]{3,4}$|SD|HD|FHD|UHD|4K|8K`',
    `scene_numbers` STRING COMMENT 'Comma-separated list of scene numbers associated with this ingested media. Links the raw footage to the production script and shooting schedule.',
    `shoot_date` DATE COMMENT 'Date when the media was originally captured or recorded on set. Distinct from ingest date.',
    `source_device` STRING COMMENT 'Name or identifier of the camera, recorder, or device that captured the source media. Examples include camera model, recorder serial number, or external vendor name.',
    `source_format` STRING COMMENT 'Technical format of the source media file. Examples include RAW, ProRes, XAVC, MXF, WAV, MP4. [ENUM-REF-CANDIDATE: RAW|ProRes|ProRes422|ProRes4444|XAVC|XAVC-I|XAVC-L|MXF|DNxHD|DNxHR|WAV|AIFF|MP4|MOV|AVI — promote to reference product]',
    `source_media_type` STRING COMMENT 'Classification of the source media being ingested. Indicates the nature and origin of the content. [ENUM-REF-CANDIDATE: camera-footage|audio-recording|graphics|b-roll|stock-footage|archive|external-delivery — 7 candidates stripped; promote to reference product]',
    `source_tape_code` STRING COMMENT 'Identifier of the physical tape or media card from which content was ingested. Used for legacy tape-based workflows and physical media tracking.',
    `storage_location` STRING COMMENT 'Physical or logical storage location where the ingested media is stored. May include storage tier, volume, or path information.',
    `storage_tier` STRING COMMENT 'Storage tier classification indicating access speed and cost. Online for immediate access, nearline for frequent access, archive for long-term retention, deep-archive for compliance.. Valid values are `online|nearline|archive|deep-archive`',
    `timecode_end` STRING COMMENT 'Ending timecode of the ingested media in HH:MM:SS:FF format. Used for synchronization and editorial reference.. Valid values are `^[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{2}$`',
    `timecode_start` STRING COMMENT 'Starting timecode of the ingested media in HH:MM:SS:FF format. Used for synchronization and editorial reference.. Valid values are `^[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ingest record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_ingest_record PRIMARY KEY(`ingest_record_id`)
) COMMENT 'Record of a media ingest event into the Dalet Galaxy MAM system — capturing raw camera footage, audio recordings, graphics, or other source media arriving from set or external sources. Captures ingest date and time, source media type, source format (RAW, ProRes, XAVC, MXF, WAV), ingest operator, storage location, file size, checksum, ingest status (pending, in-progress, complete, failed), associated production project and episode, and Dalet Galaxy asset ID assigned upon successful ingest. The operational handoff record between production and digital asset management.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Primary key for milestone',
    `predecessor_milestone_id` BIGINT COMMENT 'Reference to another milestone that must be completed before this milestone can begin or be achieved.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Milestones can be episode-specific (e.g., picture lock for episode 3). Optional FK (nullable) — milestones may be project-level or episode-level. Enables episode-specific milestone tracking for episod',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode for which this milestone is tracked.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Production milestones assign accountability to specific employees for schedule management, escalation routing, and performance review metrics—standard in project management. Replaces denormalized resp',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production milestones track progress toward content title delivery. Essential for content delivery scheduling, windowing plan coordination, and tracking production progress against content distributio',
    `actual_date` DATE COMMENT 'The date on which the milestone was actually achieved or completed. Null if milestone has not yet been reached.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee authorized to approve this milestone (e.g., Executive Producer, Network Executive, Showrunner).',
    `approval_date` DATE COMMENT 'Date on which formal approval or sign-off was granted for this milestone. Null if approval is not yet obtained.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval or sign-off is required before this milestone can be marked as achieved.',
    `baseline_date` DATE COMMENT 'Approved baseline date for the milestone after initial project approval, used for variance tracking and performance measurement.',
    `budget_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact or cost associated with achieving this milestone, or cost of delay if milestone is missed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this milestone is on the critical path of the production schedule, meaning any delay directly impacts final delivery date.',
    `dalet_workflow_reference` STRING COMMENT 'External identifier linking this milestone to the corresponding workflow or task in Dalet Galaxy Media Asset Management system.',
    `deliverable_description` STRING COMMENT 'Detailed description of the tangible output or deliverable associated with this milestone (e.g., locked picture file, final audio mix stems, QC report).',
    `deliverable_format` STRING COMMENT 'Technical format or specification of the deliverable (e.g., ProRes 422 HQ, IMF package, DCP, broadcast master tape format).',
    `dependency_count` STRING COMMENT 'Number of other milestones or tasks that are dependent on the completion of this milestone.',
    `forecast_date` DATE COMMENT 'Current projected or estimated date for milestone completion based on latest production progress and risk assessment.',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone indicating whether it is pending, on track, delayed, completed, or no longer applicable.. Valid values are `upcoming|in_progress|at_risk|achieved|missed|cancelled`',
    `milestone_type` STRING COMMENT 'Categorical classification of the milestone within the production lifecycle. Defines the phase or gate this milestone represents. [ENUM-REF-CANDIDATE: greenlight|pre_production_start|principal_photography_start|principal_photography_end|picture_lock|audio_mix_complete|vfx_complete|color_grading_complete|final_qc_pass|delivery_to_broadcaster|archive_complete|post_production_start|rough_cut_complete|final_cut_complete|mastering_complete — promote to reference product]',
    `mitigation_plan` STRING COMMENT 'Description of actions or contingency plans in place to address identified risks and ensure milestone is achieved.',
    `milestone_name` STRING COMMENT 'Human-readable name or title of the milestone event (e.g., Greenlight Approval, Picture Lock, Final Delivery).',
    `notes` STRING COMMENT 'Free-form text field for additional context, comments, or observations related to this milestone event.',
    `planned_date` DATE COMMENT 'Originally scheduled or target date for achieving this milestone as defined during production planning.',
    `responsible_department` STRING COMMENT 'The production department or functional area responsible for delivering this milestone. [ENUM-REF-CANDIDATE: production|post_production|vfx|audio|editorial|color|qc|delivery|archive|legal|finance — 11 candidates stripped; promote to reference product]',
    `risk_description` STRING COMMENT 'Detailed explanation of identified risks, issues, or blockers that may prevent timely achievement of this milestone.',
    `risk_level` STRING COMMENT 'Assessment of the risk that this milestone will not be achieved on time, based on current production status and known issues.. Valid values are `low|medium|high|critical`',
    `sap_wbs_element` STRING COMMENT 'SAP project structure element code linking this milestone to the enterprise project management and financial tracking hierarchy.',
    `stakeholder_notification_flag` BOOLEAN COMMENT 'Indicates whether stakeholders (network executives, distributors, talent) must be notified when this milestone is achieved or at risk.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last modified or updated.',
    `variance_days` STRING COMMENT 'Number of days difference between planned date and actual date (positive indicates delay, negative indicates early completion). Calculated field for reporting purposes.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Key milestone event in the production lifecycle for a project or episode. Captures milestone type (greenlight, pre-production start, first day of photography, picture lock, audio mix complete, VFX complete, final QC pass, delivery to broadcaster, archive complete), planned date, actual date, milestone status (upcoming, at-risk, achieved, missed), responsible owner, and any associated approval or sign-off requirement. Enables production schedule tracking and stakeholder reporting against key delivery gates.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the production location. Primary key.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Location owners and management companies are partners who lease filming locations. Linking enables tracking all locations managed by that partner, payment processing for location fees, permit coordina',
    `address_line_1` STRING COMMENT 'Primary street address of the production location including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number.',
    `base_camp_capacity` STRING COMMENT 'Number of trailers or mobile units that can be accommodated at the base camp area near the location for cast, crew, wardrobe, makeup, and catering.',
    `city` STRING COMMENT 'City or municipality where the location is situated.',
    `location_code` STRING COMMENT 'Business identifier code for the location used in production schedules and call sheets. Typically assigned by the location manager or production coordinator.. Valid values are `^[A-Z0-9]{4,12}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the location is situated (e.g., USA, CAN, GBR, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was first created in the system.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fee paid to the location owner or manager for the right to film at this location. Excludes additional costs such as permits, insurance, or restoration.',
    `fee_currency` STRING COMMENT 'Three-letter ISO currency code for the location fee (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the location owner requires specific production insurance coverage or certificates of insurance before filming can commence.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the location in decimal degrees format, used for mapping, navigation, and sunrise/sunset calculations.',
    `location_status` STRING COMMENT 'Current lifecycle status of the location: scouted (identified by location scout), approved (approved for use by director/producer), contracted (agreement signed with owner), active (currently in use for shooting), wrapped (shooting completed), rejected (not suitable for production).. Valid values are `scouted|approved|contracted|active|wrapped|rejected`',
    `location_type` STRING COMMENT 'Classification of the location based on its physical characteristics and usage: practical interior (real indoor space), practical exterior (real outdoor space), backlot (studio-controlled outdoor set), remote (distant or hard-to-access site), international (foreign location), studio exterior (controlled outdoor studio space).. Valid values are `practical_interior|practical_exterior|backlot|remote|international|studio_exterior`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the location in decimal degrees format, used for mapping, navigation, and logistics planning.',
    `manager_notes` STRING COMMENT 'Free-text notes and observations from the location manager regarding access, restrictions, special requirements, or other relevant production considerations.',
    `location_name` STRING COMMENT 'Human-readable name or title of the production location (e.g., Downtown Warehouse District, Malibu Beach House, Historic City Hall).',
    `noise_assessment` STRING COMMENT 'Assessment of ambient noise levels at the location: quiet (minimal background noise, suitable for dialogue recording), moderate (some noise, may require sound treatment), noisy (significant noise, requires ADR or sound mitigation), unacceptable (excessive noise, unsuitable for production).. Valid values are `quiet|moderate|noisy|unacceptable`',
    `owner_contact_email` STRING COMMENT 'Primary email address for the location owner or authorized representative for contract and coordination communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_contact_phone` STRING COMMENT 'Primary phone number for the location owner or authorized representative for coordination and emergency contact during production.',
    `parking_capacity` STRING COMMENT 'Number of vehicle parking spaces available at or near the location for crew, cast, and equipment trucks.',
    `permit_authority` STRING COMMENT 'Name of the governmental or regulatory authority responsible for issuing filming permits for this location (e.g., Los Angeles Film Office, NYC Mayor Office of Media and Entertainment).',
    `permit_expiry_date` DATE COMMENT 'Date when the filming permit expires and is no longer valid for production use.',
    `permit_issue_date` DATE COMMENT 'Date when the filming permit was officially issued by the permitting authority.',
    `permit_number` STRING COMMENT 'Official permit or authorization number issued by the permitting authority for filming at this location.',
    `permit_status` STRING COMMENT 'Current status of filming permits required for this location: not required (no permit needed), pending (application submitted), approved (permit granted), denied (permit rejected), expired (permit validity lapsed).. Valid values are `not_required|pending|approved|denied|expired`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location address.',
    `power_availability` STRING COMMENT 'Assessment of electrical power availability at the location: grid (connected to utility power), generator required (no grid power, generators needed), limited (some power available but insufficient for full production), none (no power infrastructure).. Valid values are `grid|generator_required|limited|none`',
    `region` STRING COMMENT 'Broader geographic region or area classification (e.g., Southern California, Pacific Northwest, New England) used for production planning and logistics.',
    `restoration_required_flag` BOOLEAN COMMENT 'Indicates whether the production is contractually obligated to restore the location to its original condition after filming concludes.',
    `restroom_facilities` STRING COMMENT 'Assessment of restroom availability: on site (permanent facilities available), portable required (portable restrooms must be brought in), nearby (facilities within walking distance), none (no facilities available).. Valid values are `on_site|portable_required|nearby|none`',
    `safety_assessment_date` DATE COMMENT 'Date when the safety assessment was conducted by the production safety officer or third-party assessor.',
    `safety_assessment_status` STRING COMMENT 'Status of the safety and risk assessment conducted for this location: not assessed (no evaluation performed), in progress (assessment underway), passed (meets safety requirements), failed (does not meet safety standards), conditional (approved with specific safety measures required).. Valid values are `not_assessed|in_progress|passed|failed|conditional`',
    `scout_approval_status` STRING COMMENT 'Approval status from the location scout assessment: pending (awaiting review), approved (meets production requirements), rejected (does not meet requirements), conditional (approved with specific conditions or modifications).. Valid values are `pending|approved|rejected|conditional`',
    `state_province` STRING COMMENT 'State, province, or administrative region of the location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was last modified in the system.',
    `water_availability` STRING COMMENT 'Assessment of water access at the location: available (connected to water supply), limited (some water but insufficient for full crew), trucked in required (no water infrastructure, must be transported), none (no water access).. Valid values are `available|limited|trucked_in_required|none`',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master record for a physical production location — an on-location shoot site used for principal photography or second unit work. Captures location name, address, GPS coordinates, country, region, location type (practical interior, practical exterior, backlot, remote, international), location scout approval status, permit status, permit authority, permit expiry date, location fee, safety assessment status, noise assessment, sunrise/sunset data relevance, parking and base camp capacity, and contact details for the location owner or manager. Distinct from facility_booking which covers controlled studio and post-production facilities.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` (
    `cost_transaction_id` BIGINT COMMENT 'Primary key for cost_transaction',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Transaction-level approval tracking enables financial controls, segregation of duties, and audit compliance for production expenditures—standard accounting practice. Replaces denormalized approver_nam',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to production.budget_line. Business justification: Cost transactions are posted against specific budget line items. Currently uses budget_line_reference (STRING) — replacing with FK to budget_line.budget_line_id provides referential integrity and enab',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Cost transactions must reference the GL account structure for financial posting, trial balance generation, and financial statement preparation. Replaces denormalized gl_account_code with FK to enforce',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Every production cost transaction must be assigned to a cost center for GL posting, reconciliation, and audit trail. Mandatory for SAP integration and financial statement preparation. Replaces denorma',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Production cost transactions generate or reference journal entries in the financial GL. Required for reconciliation between production spend tracking and financial ledger, mandatory for month-end clos',
    `partner_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom goods or services were procured, if applicable.',
    `budget_id` BIGINT COMMENT 'Reference to the specific budget line or cost object this transaction is charged against.',
    `project_id` BIGINT COMMENT 'Reference to the production project against which this cost transaction is posted.',
    `approval_date` DATE COMMENT 'Date on which the transaction was approved for payment.',
    `cost_category_code` STRING COMMENT 'Code representing the cost category or expense type (e.g., talent, equipment, location, post-production).',
    `cost_category_name` STRING COMMENT 'Descriptive name of the cost category or expense classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `cost_transaction_description` STRING COMMENT 'Detailed description or narrative of the cost transaction, including purpose and context.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the transaction amount to the reporting currency.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year for this transaction.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the transaction was posted for financial reporting purposes.',
    `invoice_date` DATE COMMENT 'Date on the vendor invoice or billing document.',
    `invoice_number` STRING COMMENT 'Vendor invoice number or billing reference for this transaction.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net transaction amount excluding taxes and other adjustments.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this transaction.',
    `payee_name` STRING COMMENT 'Name of the individual or entity receiving payment for this transaction (e.g., crew member, contractor, petty cash recipient).',
    `payment_date` DATE COMMENT 'Date on which payment was made or is scheduled to be made for this transaction.',
    `payment_method` STRING COMMENT 'Method used for payment: wire transfer, check, credit card, petty cash, ACH, or payroll.. Valid values are `wire_transfer|check|credit_card|petty_cash|ach|payroll`',
    `payment_status` STRING COMMENT 'Current payment status of the transaction: pending, approved, paid, cancelled, on hold, or rejected.. Valid values are `pending|approved|paid|cancelled|on_hold|rejected`',
    `posting_date` DATE COMMENT 'The date on which the transaction was posted to the general ledger in SAP.',
    `production_phase` STRING COMMENT 'Phase of production during which this cost was incurred: pre-production, principal photography, post-production, delivery, or closed.. Valid values are `pre_production|principal_photography|post_production|delivery|closed`',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with this transaction, if applicable.',
    `reporting_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the standard reporting currency (typically USD) for consolidated financial reporting.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reporting currency.. Valid values are `^[A-Z]{3}$`',
    `sap_document_number` STRING COMMENT 'SAP S/4HANA financial document number (FI/CO posting document) associated with this transaction.',
    `sap_line_item_number` STRING COMMENT 'Line item number within the SAP document for granular traceability.',
    `sap_wbs_element` STRING COMMENT 'SAP WBS element representing the project structure node for this cost transaction.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount associated with this transaction, if applicable.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the cost transaction in the original transaction currency.',
    `transaction_date` DATE COMMENT 'The date on which the cost transaction was incurred or posted in the financial system.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or document reference for this cost entry.',
    `transaction_type` STRING COMMENT 'Classification of the cost transaction: purchase order, vendor invoice, petty cash disbursement, payroll charge, inter-company cost allocation, or credit memo.. Valid values are `purchase_order|vendor_invoice|petty_cash|payroll_charge|intercompany_allocation|credit_memo`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost transaction record was last updated or modified.',
    CONSTRAINT pk_cost_transaction PRIMARY KEY(`cost_transaction_id`)
) COMMENT 'Individual cost transaction record incurred during production — purchase orders, vendor invoices, petty cash disbursements, payroll charges, and inter-company cost allocations posted against a production project. Captures transaction date, transaction type, vendor or payee, cost category, budget line reference, amount, currency, SAP document number, payment status, and approver. Provides the granular financial audit trail for production spend reconciliation against the production budget.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` (
    `insurance_policy_id` BIGINT COMMENT 'Primary key for insurance_policy',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: When insurance brokers are internal employees (common in large media companies with in-house risk management), tracking for vendor management, compliance reporting, and contact continuity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Insurance premiums must be allocated to cost centers for insurance expense allocation across production departments. Required for production insurance cost tracking (E&O, general liability, equipment)',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Insurance carriers are partners providing production insurance (E&O, general liability, equipment). Linking enables tracking all policies with that carrier, claims history analysis, renewal negotiatio',
    `project_id` BIGINT COMMENT 'Reference to the production project covered by this insurance policy. Links to the production project entity.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Production insurance policies may require regulatory filings in certain jurisdictions for workers compensation, liability coverage, and bond requirements. Links insurance compliance to regulatory rep',
    `additional_insured_parties` STRING COMMENT 'List of additional parties named as insured under this policy, such as broadcasters, distributors, or co-production partners. Comma-separated list.',
    `broker_contact_email` STRING COMMENT 'Primary email address for the insurance broker handling this policy. Used for policy inquiries and claims coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `broker_contact_phone` STRING COMMENT 'Primary phone number for the insurance broker handling this policy.',
    `broker_name` STRING COMMENT 'The name of the insurance broker or agent who facilitated the policy placement.',
    `cancellation_date` DATE COMMENT 'The date when the policy was cancelled, if applicable. Null for active policies.',
    `cancellation_reason` STRING COMMENT 'The reason for policy cancellation, such as non-payment, production completion, or insured request.',
    `certificate_issue_date` DATE COMMENT 'The date when the Certificate of Insurance was issued for this policy.',
    `certificate_of_insurance_issued_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Insurance has been issued for this policy. Required for broadcaster delivery compliance and vendor contracts.',
    `claim_history_flag` BOOLEAN COMMENT 'Indicates whether any claims have been filed against this policy. True if claims exist, False if no claims.',
    `compliance_requirement_met_flag` BOOLEAN COMMENT 'Indicates whether this policy meets all broadcaster delivery and regulatory compliance requirements for the production. True if compliant, False if deficiencies exist.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'The maximum liability or coverage limit provided by this policy, expressed in the policy currency.',
    `coverage_territory` STRING COMMENT 'Geographic territory or jurisdictions where the insurance coverage applies. May be worldwide or limited to specific countries/regions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this insurance policy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this policy (coverage, deductible, premium).. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The deductible or excess amount that must be paid by the insured before the insurance coverage applies, expressed in the policy currency.',
    `exclusions_summary` STRING COMMENT 'Summary of key exclusions or limitations in the insurance coverage. Describes what is NOT covered by this policy.',
    `notes` STRING COMMENT 'Free-text notes or comments about this insurance policy, including special arrangements, negotiations, or internal observations.',
    `payment_date` DATE COMMENT 'The actual date when the insurance premium was paid.',
    `payment_due_date` DATE COMMENT 'The date by which the insurance premium payment is due to keep the policy in force.',
    `payment_status` STRING COMMENT 'Current status of the premium payment for this policy. Indicates whether the premium has been fully paid, is pending, or is overdue.. Valid values are `pending|paid|partial|overdue|refunded`',
    `policy_document_url` STRING COMMENT 'URL or file path to the digital copy of the full insurance policy document stored in the Media Asset Management (MAM) system or document repository.',
    `policy_effective_date` DATE COMMENT 'The date when the insurance coverage begins and the policy becomes active.',
    `policy_expiration_date` DATE COMMENT 'The date when the insurance coverage ends and the policy is no longer in force.',
    `policy_number` STRING COMMENT 'The unique policy number assigned by the insurance carrier. This is the externally-known identifier for the policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the insurance policy. Indicates whether the policy is in force, expired, or cancelled.. Valid values are `pending|active|expired|cancelled|suspended|renewed`',
    `policy_term_days` STRING COMMENT 'The total duration of the insurance policy coverage period, measured in days.',
    `policy_type` STRING COMMENT 'The category of insurance coverage provided by this policy. Defines the risk domain covered. [ENUM-REF-CANDIDATE: cast_insurance|errors_and_omissions|general_liability|equipment_coverage|negative_film_protection|workers_compensation|completion_bond — 7 candidates stripped; promote to reference product]',
    `premium_amount` DECIMAL(18,2) COMMENT 'The total premium cost paid for this insurance policy, expressed in the policy currency.',
    `prior_policy_number` STRING COMMENT 'The policy number of the previous insurance policy if this is a renewal. Null for new policies.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether this policy is a renewal of a previous policy. True if renewed, False if new policy.',
    `sap_policy_reference` STRING COMMENT 'Reference number or identifier for this insurance policy in the SAP S/4HANA ERP system, used for financial reconciliation and cost tracking.',
    `special_conditions` STRING COMMENT 'Any special conditions, endorsements, or riders attached to this policy that modify standard coverage terms.',
    `total_claims_filed` STRING COMMENT 'The total number of insurance claims filed against this policy to date.',
    `total_claims_paid_amount` DECIMAL(18,2) COMMENT 'The cumulative amount paid out by the insurer for all claims under this policy, expressed in the policy currency.',
    `underwriter_name` STRING COMMENT 'The name of the underwriter at the insurance carrier who approved and underwrote this policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this insurance policy record was last modified in the system.',
    CONSTRAINT pk_insurance_policy PRIMARY KEY(`insurance_policy_id`)
) COMMENT 'Insurance policy record covering a production project against production risks — cast insurance, errors and omissions (E&O), general liability, equipment, negative film, workers compensation, and completion bond. Captures policy type, insurer, policy number, coverage amount, deductible, premium, policy start date, policy end date, covered production project, broker, and claim history flag. Essential for production risk management and broadcaster delivery compliance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` (
    `production_clearance_id` BIGINT COMMENT 'Unique identifier for the production clearance record. Primary key for tracking rights clearance throughout the clearance lifecycle.',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to sales.advertiser. Business justification: Clearances required for advertiser brand usage, logos, trademarks, and product appearances in content. Business process: advertiser brand clearance management, trademark usage rights tracking, product [FK namespace reconciled: points to sales.advertiser]',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Clearance failures, rights disputes, or expired licenses trigger compliance incidents requiring investigation and remediation. Links rights management to incident tracking and regulatory risk manageme',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rights clearances incur costs that must be tracked to cost centers for rights expense tracking and amortization schedules. Essential for music licensing, talent rights, and IP clearance cost managemen',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Production clearances track the approval process for using content/music/talent in production. These clearances are often governed by license agreements that grant usage rights. The production_clearan',
    `project_id` BIGINT COMMENT 'Reference to the production project for which this clearance applies. Links clearance to the content being produced.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Rights clearances often require regulatory filings for music licensing (ASCAP/BMI), international distribution rights, and foreign content quotas. Links clearance workflow to regulatory reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rights clearance requests track requester employee for workflow routing, approval escalation, and audit trails—standard in legal/business affairs operations. Replaces denormalized requested_by name.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Rights clearances are obtained from IP owners, music publishers, stock footage libraries, and clearance agencies (partners). Linking enables tracking all clearances from that partner, payment processi',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production clearances (music, IP, location rights) are obtained for specific content titles. Critical for content distribution clearance workflows, rights management, and ensuring production-side clea',
    `approved_by` STRING COMMENT 'Name or identifier of the legal or business affairs representative who approved the clearance terms and authorized execution of the agreement.',
    `attribution_required_flag` BOOLEAN COMMENT 'Indicates whether the clearance agreement requires on-screen or end-credit attribution to the rights holder or original creator. True if attribution is mandatory; false if not required.',
    `attribution_text` STRING COMMENT 'Exact text required for on-screen or end-credit attribution as specified by the rights holder. Must be displayed verbatim to comply with clearance terms.',
    `clearance_date` DATE COMMENT 'Date on which the rights holder formally approved the clearance and the agreement became legally binding. Marks the start of the clearance validity period.',
    `clearance_number` STRING COMMENT 'Business-facing unique reference number for the clearance record, used in legal documentation and rights management correspondence.. Valid values are `^CLR-[0-9]{8}$`',
    `clearance_status` STRING COMMENT 'Current lifecycle state of the clearance request. Pending indicates initial submission; in_negotiation indicates active rights holder discussions; cleared indicates approved and legally binding; denied indicates rights holder refusal; expired indicates clearance period has lapsed; revoked indicates post-clearance withdrawal of rights.. Valid values are `pending|in_negotiation|cleared|denied|expired|revoked`',
    `clearance_type` STRING COMMENT 'Category of intellectual property clearance required. Sync license covers musical composition synchronization rights; master use covers sound recording rights; clip license covers third-party video footage; trademark clearance covers brand logos and marks; likeness release covers individual appearance rights; brand placement covers product integration; literary excerpt covers written content; archival footage covers historical video content. [ENUM-REF-CANDIDATE: sync_license|master_use_license|clip_license|trademark_clearance|likeness_release|brand_placement|literary_excerpt|archival_footage — 8 candidates stripped; promote to reference product]',
    `contract_reference` STRING COMMENT 'Reference number or identifier for the underlying legal contract or license agreement governing this clearance. Links to contract management system for full terms and conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clearance record was first created in the system. Audit field for data lineage and compliance tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the original clearance fee if negotiated in a currency other than USD. Used for financial reconciliation and foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    `duration_days` STRING COMMENT 'Total number of days for which the clearance is valid, calculated from effective_start_date to expiry_date. Used for rights management reporting and renewal planning.',
    `effective_start_date` DATE COMMENT 'Date from which the clearance becomes valid and the intellectual property may be used in production and distribution. May differ from clearance_date if agreement includes a future effective date.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the clearance grants exclusive rights to use the intellectual property within the specified territory and media types. True if exclusive; false if non-exclusive and rights holder may license to other parties.',
    `expiry_date` DATE COMMENT 'Date on which the clearance expires and the intellectual property may no longer be used without renewal or renegotiation. Null indicates perpetual clearance. Critical for compliance and content windowing.',
    `fee_usd` DECIMAL(18,2) COMMENT 'Total fee paid to the rights holder for clearance, expressed in US dollars. Includes all licensing costs, synchronization fees, master use fees, and any negotiated payments.',
    `ip_description` STRING COMMENT 'Detailed description of the third-party intellectual property being cleared, including title, artist, duration, usage context, and specific elements requiring clearance.',
    `isan` STRING COMMENT 'International Standard Audiovisual Number for audiovisual content being cleared, such as archival footage or clip licenses. Unique identifier for audiovisual works.. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]$`',
    `isrc` STRING COMMENT 'International Standard Recording Code for music recordings being cleared. Unique identifier for sound recordings used in music synchronization and master use clearances.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `iswc` STRING COMMENT 'International Standard Musical Work Code for musical compositions being cleared. Unique identifier for musical works used in synchronization license clearances.. Valid values are `^T-[0-9]{9}-[0-9]$`',
    `media_type_cleared` STRING COMMENT 'Distribution channels and platforms for which the clearance is valid, specified as comma-separated values (e.g., broadcast,SVOD,AVOD,theatrical,FAST,social_media). Defines the media formats and delivery methods authorized under this clearance.',
    `notes` STRING COMMENT 'Free-text field for additional context, negotiation history, special conditions, or internal comments related to the clearance process and agreement.',
    `priority` STRING COMMENT 'Business priority level for obtaining this clearance. Critical indicates production cannot proceed without clearance; high indicates significant creative or schedule impact; medium indicates moderate impact; low indicates optional or easily substitutable.. Valid values are `critical|high|medium|low`',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the clearance requires periodic renewal or renegotiation. True if the clearance has a fixed term and must be renewed; false if perpetual or automatically renewing.',
    `restrictions` STRING COMMENT 'Any usage restrictions, limitations, or conditions imposed by the rights holder, such as prohibited contexts, content rating requirements, editorial approval rights, or blackout periods.',
    `rights_holder_contact` STRING COMMENT 'Primary contact information for rights holder correspondence, including email, phone, or agent details for clearance negotiation and documentation.',
    `rightsline_clearance_reference` STRING COMMENT 'External identifier for this clearance record in the Rightsline rights and royalties management system. Used for cross-system reconciliation and audit trail.',
    `sap_cost_object_code` STRING COMMENT 'SAP cost object identifier (WBS element or internal order) to which the clearance fee is charged. Links clearance costs to production budget tracking in SAP S/4HANA.',
    `territory` STRING COMMENT 'Geographic territories for which the clearance is valid, specified as comma-separated ISO 3166-1 alpha-3 country codes or regional groupings (e.g., USA,CAN,MEX or worldwide). Defines where the content may be distributed with this cleared IP.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clearance record was last modified. Audit field for change tracking and data quality monitoring.',
    `usage_description` STRING COMMENT 'Detailed description of how the intellectual property will be used within the production, including scene context, duration, prominence, and creative treatment. Critical for rights holder approval and compliance verification.',
    CONSTRAINT pk_production_clearance PRIMARY KEY(`production_clearance_id`)
) COMMENT 'Rights clearance record for third-party intellectual property used within a production — music synchronization, archival footage, brand logos, literary excerpts, trademarks, and likeness rights. Captures clearance type (sync license, master use, clip license, trademark clearance, likeness release), rights holder, territory, media type cleared (broadcast, SVOD, AVOD, theatrical), clearance fee, clearance status (pending, cleared, denied, expired), clearance date, and expiry date. Ensures all third-party IP embedded in a production is legally cleared before broadcast or distribution.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` (
    `format_spec_id` BIGINT COMMENT 'Primary key for format_spec',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Production format specifications map to distribution ABR profiles for transcoding workflows. Real business process: format conversion pipeline configuration, encoding preset selection, and quality ass',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Channels define technical delivery specifications (resolution, codec, audio format) that productions must meet. Broadcast standards compliance requires format specs tied to target channel. Required fo',
    `abr_profile` STRING COMMENT 'The adaptive bitrate streaming profile or ladder configuration associated with this format specification.',
    `approval_date` DATE COMMENT 'The date on which this format specification was officially approved for use in production workflows.',
    `approved_by` STRING COMMENT 'The name or identifier of the person or role who approved this format specification for production use.',
    `aspect_ratio` STRING COMMENT 'The proportional relationship between width and height of the video frame (e.g., 16:9, 4:3, 2.39:1, 1.85:1).',
    `audio_bit_depth` STRING COMMENT 'The number of bits used to represent each audio sample (e.g., 16, 24, 32).',
    `audio_codec` STRING COMMENT 'The audio compression codec used for encoding (e.g., AAC, AC-3, E-AC-3, PCM, Dolby Digital Plus, Dolby Atmos).',
    `audio_configuration` STRING COMMENT 'The audio channel layout and configuration for this format specification.. Valid values are `mono|stereo|5.1|7.1|7.1.4|Atmos|immersive`',
    `audio_sample_rate_khz` DECIMAL(18,2) COMMENT 'The audio sampling frequency in kilohertz (e.g., 48, 96, 192).',
    `bit_depth` STRING COMMENT 'The number of bits used to represent color information per channel (e.g., 8, 10, 12, 16).',
    `broadcast_standard` STRING COMMENT 'The broadcast television standard applicable to this format specification.. Valid values are `ATSC|DVB|ISDB|NTSC|PAL|SECAM`',
    `chroma_subsampling` STRING COMMENT 'The chroma subsampling scheme defining color resolution relative to luminance (e.g., 4:2:0, 4:2:2, 4:4:4).',
    `closed_caption_standard` STRING COMMENT 'The closed captioning or subtitle standard supported by this format (e.g., CEA-608, CEA-708, DVB Subtitles, TTML).',
    `color_space` STRING COMMENT 'The color space standard defining the range and representation of colors in the video signal.. Valid values are `Rec.601|Rec.709|Rec.2020|DCI-P3|Adobe_RGB`',
    `compliance_requirements` STRING COMMENT 'List of regulatory or industry compliance requirements that this format specification satisfies (e.g., FCC broadcast standards, ATSC 3.0, DVB-T2).',
    `container_format` STRING COMMENT 'The file container or wrapper format used to package video, audio, and metadata streams (e.g., MXF, MOV, MP4, TS).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this format specification record was first created in the system.',
    `dalet_format_profile_reference` STRING COMMENT 'The corresponding format profile identifier in Dalet Galaxy MAM system used for workflow orchestration and transcoding.',
    `drm_compatibility` STRING COMMENT 'The DRM systems or encryption standards compatible with this format specification (e.g., Widevine, PlayReady, FairPlay).',
    `effective_end_date` DATE COMMENT 'The date on which this format specification is no longer valid for new production projects. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this format specification becomes effective and available for use in production projects.',
    `file_size_gb` DECIMAL(18,2) COMMENT 'The estimated or typical file size in gigabytes for content encoded in this format specification for a standard duration.',
    `format_code` STRING COMMENT 'Short alphanumeric code or identifier used to reference this format specification in production systems and workflows.',
    `format_name` STRING COMMENT 'Business name or label for this format specification (e.g., UHD 4K HDR10 Theatrical, HD 1080p Broadcast Standard).',
    `format_status` STRING COMMENT 'The current lifecycle status of this format specification within the production environment.. Valid values are `draft|approved|active|deprecated|retired`',
    `format_type` STRING COMMENT 'Classification of the format specification by its intended use in the production workflow.. Valid values are `capture|delivery|master|proxy|mezzanine|distribution`',
    `frame_rate` DECIMAL(18,2) COMMENT 'The number of frames per second for this format specification (e.g., 23.976, 24, 25, 29.97, 30, 50, 59.94, 60).',
    `hdr_standard` STRING COMMENT 'The HDR standard applied to this format specification, or SDR if standard dynamic range.. Valid values are `SDR|HDR10|HDR10_Plus|Dolby_Vision|HLG`',
    `is_default_format` BOOLEAN COMMENT 'Boolean flag indicating whether this format specification is the default or recommended format for its type and resolution class.',
    `resolution` STRING COMMENT 'The spatial resolution of the video format, defining the number of pixels and scan type (progressive or interlaced).. Valid values are `SD|HD_720p|HD_1080i|HD_1080p|UHD_4K|UHD_8K`',
    `streaming_protocol` STRING COMMENT 'The streaming delivery protocol supported by this format (e.g., HLS, MPEG-DASH, RTMP, SRT).',
    `technical_notes` STRING COMMENT 'Additional technical notes, specifications, or guidance for production teams using this format specification.',
    `timecode_format` STRING COMMENT 'The timecode standard and format used for frame-accurate synchronization and editing.. Valid values are `drop_frame|non_drop_frame|PAL|film`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this format specification record was last modified or updated.',
    `video_bitrate_mbps` DECIMAL(18,2) COMMENT 'The target or maximum video bitrate in megabits per second for this format specification.',
    `video_codec` STRING COMMENT 'The video compression codec used for encoding (e.g., H.264, H.265/HEVC, ProRes, DNxHD, AVC-Intra, XAVC).',
    CONSTRAINT pk_format_spec PRIMARY KEY(`format_spec_id`)
) COMMENT 'Reference record defining the technical production format specification for a project or deliverable — the agreed capture and delivery format standard. Captures format name, frame rate (23.976, 25, 29.97, 50, 59.94), resolution (HD 1080i, HD 1080p, UHD 4K, 8K), aspect ratio, color space (Rec.709, Rec.2020, P3), HDR standard (HDR10, Dolby Vision, HLG), audio configuration (5.1, 7.1, Atmos), codec, container format, and applicable broadcast standard (ATSC, DVB). Serves as the technical specification baseline for all production and post-production work.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` (
    `rating_submission_id` BIGINT COMMENT 'Primary key for rating_submission',
    `compliance_content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Rating submissions result in content ratings; this is the natural outcome link. Tracks the submission-to-certification workflow for MPAA, TV Parental Guidelines, and international rating authorities.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Rating rejections, appeals, or content rating disputes are tracked as compliance incidents. Links rating workflow to incident management for regulatory risk tracking and remediation.',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Rating submissions result in content ratings that must be tracked in the content domain. Essential for compliance workflows, distribution clearance, and linking production-side rating requests to cont',
    `employee_id` BIGINT COMMENT 'Identifier of the user or staff member who submitted the content for rating.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Rating submissions can be episode-specific (episodic content rated individually). Optional FK (nullable) — submissions may be project-level or episode-level. Enables episode-specific rating tracking.',
    `project_id` BIGINT COMMENT 'Reference to the production project for which content rating is being submitted.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Content ratings determine permissible scheduling windows (watershed compliance, childrens programming hours). FCC/Ofcom regulatory requirement links rating certificates to scheduled slots. Required f',
    `appeal_date` DATE COMMENT 'Date when the appeal was formally filed with the rating authority.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal was filed against the initial rating decision.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process. Upheld means original rating stands, overturned means rating was changed, modified means rating was adjusted.. Valid values are `upheld|overturned|modified|pending`',
    `broadcast_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether this rating is required for broadcast clearance and compliance with Federal Communications Commission (FCC) or equivalent regulatory requirements.',
    `certificate_expiry_date` DATE COMMENT 'Date when the rating certificate expires and content must be re-submitted for re-rating if applicable. Null if certificate does not expire.',
    `certificate_issue_date` DATE COMMENT 'Date when the rating certificate was officially issued by the rating authority.',
    `content_runtime_minutes` STRING COMMENT 'Total runtime of the submitted content in minutes.',
    `content_type` STRING COMMENT 'Classification of the content being submitted for rating. [ENUM-REF-CANDIDATE: feature_film|television_series|television_episode|short_film|documentary|music_video|commercial|trailer|web_series — 9 candidates stripped; promote to reference product]',
    `coppa_applicable_flag` BOOLEAN COMMENT 'Indicates whether the content is subject to COPPA regulations due to being directed at children under 13.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rating submission record was first created in the system.',
    `cuts_description` STRING COMMENT 'Detailed description of the cuts, edits, or modifications required by the rating authority. Includes timecodes, scene descriptions, and nature of changes.',
    `cuts_required_flag` BOOLEAN COMMENT 'Indicates whether the rating authority required editorial cuts or modifications to the content to achieve the assigned rating.',
    `dalet_workflow_reference` STRING COMMENT 'Reference to the Dalet Galaxy Media Asset Management workflow orchestration identifier associated with this rating submission process.',
    `distribution_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether this rating is required for distribution clearance across platforms (theatrical, OTT, SVOD, AVOD, linear broadcast).',
    `eidr` STRING COMMENT 'Entertainment Identifier Registry unique identifier for the content submitted for rating.',
    `isan` STRING COMMENT 'International Standard Audiovisual Number uniquely identifying the audiovisual work submitted for rating.',
    `notes` STRING COMMENT 'Additional free-form notes or comments regarding the rating submission, review process, or special circumstances.',
    `rating_authority` STRING COMMENT 'The governing body or ratings organization to which the content was submitted. Examples: MPA (Motion Picture Association), BBFC (British Board of Film Classification), FSK (Freiwillige Selbstkontrolle der Filmwirtschaft), CBFC (Central Board of Film Certification), ACB (Australian Classification Board), OFLC (Office of Film and Literature Classification), KMRB (Korea Media Rating Board), EIRIN (Film Classification and Rating Organization Japan), CSA (Conseil Supérieur de lAudiovisuel), DJCTQ (Departamento de Justiça Classificação Títulos e Qualificação), NICAM (Netherlands Institute for the Classification of Audiovisual Media), PEGI (Pan European Game Information), ESRB (Entertainment Software Rating Board), TV Parental Guidelines. [ENUM-REF-CANDIDATE: MPA|BBFC|FSK|CBFC|ACB|OFLC|KMRB|EIRIN|CSA|DJCTQ|NICAM|PEGI|ESRB|TV_PARENTAL_GUIDELINES — 14 candidates stripped; promote to reference product]',
    `rating_conditions` STRING COMMENT 'Any conditions, restrictions, or requirements imposed by the rating authority for the assigned rating. Examples: specific scenes must be cut, warning messages required, restricted broadcast hours.',
    `review_completion_date` DATE COMMENT 'Date when the rating authority completed its review and issued the final rating decision.',
    `reviewer_notes` STRING COMMENT 'Internal notes or feedback provided by the rating authority reviewers regarding the content evaluation. May include guidance for future submissions.',
    `submission_date` DATE COMMENT 'Date when the content rating submission was formally submitted to the rating authority.',
    `submission_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the rating authority for processing the rating submission.',
    `submission_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the submission fee.',
    `submission_reference_number` STRING COMMENT 'External reference number or tracking code assigned by the submitter or rating authority for this submission.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the rating submission. Tracks progression from draft through submission, review, and final decision. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|appealed|withdrawn — 7 candidates stripped; promote to reference product]',
    `submitted_content_title` STRING COMMENT 'The title of the content as submitted to the rating authority. May differ from production working title.',
    `submitted_content_version` STRING COMMENT 'Version identifier of the content submitted for rating (e.g., theatrical cut, directors cut, TV edit, unrated version).',
    `territory` STRING COMMENT 'Geographic territory or jurisdiction for which this rating is valid. Use 3-letter ISO country codes (e.g., USA, GBR, DEU, IND, AUS).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rating submission record was last updated in the system.',
    CONSTRAINT pk_rating_submission PRIMARY KEY(`rating_submission_id`)
) COMMENT 'Submission record for content rating classification by a governing body (MPA, BBFC, FSK, CBFC, or equivalent national ratings authority). Captures submission date, rating authority, submitted content title and version, rating received (G, PG, PG-13, R, NC-17, TV-Y, TV-14, TV-MA, etc.), rating descriptors (violence, language, sexual content), submission status, certificate number, certificate expiry, territory, and any conditions or cuts required for the rating. Required for broadcast compliance and distribution clearance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` (
    `daily_production_report_id` BIGINT COMMENT 'Unique identifier for the daily production report. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Daily production reports track actual spend that must reconcile to cost centers for daily cost tracking and variance alerts. Essential for production accounting to monitor burn rate and trigger budget',
    `location_id` BIGINT COMMENT 'Reference to the primary filming location for this shoot day.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Daily production reports reference dailies/footage assets generated that shoot day for editorial review. Role-prefixed as dailies_asset_id. Essential for linking production metadata (scenes shot, page',
    `previous_daily_production_report_id` BIGINT COMMENT 'Self-referencing FK on daily_production_report (previous_daily_production_report_id)',
    `employee_id` BIGINT COMMENT 'Reference to the director responsible for this shoot day.',
    `production_episode_id` BIGINT COMMENT 'Reference to the specific episode being shot on this day, if applicable.',
    `project_id` BIGINT COMMENT 'Reference to the production project for which this daily report was generated.',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Daily production report is generated FOR a specific shoot schedule entry. Strong operational link — the report captures actuals vs. the schedule. FK enables variance analysis (scheduled vs. actual tim',
    `tertiary_daily_submitted_by_user_employee_id` BIGINT COMMENT 'Reference to the user who submitted this daily production report for approval.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Daily production reports document shoot progress for specific content titles. Required for production cost allocation to titles, shoot day tracking by content, and linking production activity to final',
    `accidents_incidents_description` STRING COMMENT 'Detailed description of any accidents, injuries, or safety incidents that occurred, if applicable.',
    `accidents_incidents_flag` BOOLEAN COMMENT 'Indicates whether any accidents, injuries, or safety incidents occurred during this shoot day.',
    `ad_notes` STRING COMMENT 'Notes from the first assistant director regarding logistics, schedule adherence, crew performance, and operational issues.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this daily production report was approved and locked.',
    `background_actors_count` STRING COMMENT 'Number of background actors (extras) used on this shoot day.',
    `call_time` TIMESTAMP COMMENT 'Scheduled crew call time for the start of the shoot day.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this daily production report record was first created in the system.',
    `dalet_workflow_reference` STRING COMMENT 'Reference identifier to the corresponding workflow in Dalet Galaxy Media Asset Management system for ingest and post-production tracking.',
    `digital_media_consumed_tb` DECIMAL(18,2) COMMENT 'Total terabytes of digital media captured during the shoot day, if shooting digitally.',
    `director_notes` STRING COMMENT 'Notes and observations from the director regarding the shoot day, creative decisions, and performance.',
    `film_stock_consumed_feet` STRING COMMENT 'Total feet of film stock consumed during the shoot day, if shooting on film.',
    `first_shot_time` TIMESTAMP COMMENT 'Actual timestamp when the first shot of the day was captured.',
    `last_shot_time` TIMESTAMP COMMENT 'Actual timestamp when the final shot of the day was captured.',
    `meal_break_end` TIMESTAMP COMMENT 'Timestamp when the primary meal break ended and shooting resumed.',
    `meal_break_start` TIMESTAMP COMMENT 'Timestamp when the primary meal break began.',
    `meal_penalty_incurred_flag` BOOLEAN COMMENT 'Indicates whether a meal penalty was incurred due to late or missed meal breaks per union rules.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours incurred across all crew members on this shoot day.',
    `pages_shot` DECIMAL(18,2) COMMENT 'Number of script pages (in eighths) completed during this shoot day, the primary measure of production progress.',
    `production_unit` STRING COMMENT 'The production unit responsible for this shoot day (main unit, second unit, etc.).. Valid values are `main_unit|second_unit|splinter_unit|vfx_unit|stunt_unit`',
    `report_date` DATE COMMENT 'The shoot date for which this daily production report was generated. Principal business event timestamp for this transaction.',
    `report_number` STRING COMMENT 'Business identifier for the daily production report, typically sequential or formatted per production standards.',
    `report_status` STRING COMMENT 'Current lifecycle status of the daily production report in the approval workflow.. Valid values are `draft|submitted|approved|locked|revised`',
    `sap_cost_object_code` STRING COMMENT 'Reference to the SAP cost object (WBS element or internal order) for production accounting reconciliation.',
    `scenes_completed` STRING COMMENT 'Comma-separated list or range of scene numbers completed during this shoot day (e.g., 12, 14A, 15-17).',
    `schedule_variance_days` DECIMAL(18,2) COMMENT 'Number of days ahead or behind schedule after this shoot day. Positive values indicate ahead of schedule, negative values indicate behind schedule.',
    `setups_completed` STRING COMMENT 'Total number of camera setups completed during the shoot day.',
    `shoot_day_number` STRING COMMENT 'Sequential day number within the principal photography schedule (e.g., Day 1, Day 2, etc.).',
    `total_crew_hours` DECIMAL(18,2) COMMENT 'Aggregate crew hours worked across all crew members on this shoot day.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this daily production report record was last modified.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the shoot day, relevant for exterior shoots and schedule impact.',
    `wrap_time` TIMESTAMP COMMENT 'Actual wrap time when the shoot day concluded and crew was dismissed.',
    CONSTRAINT pk_daily_production_report PRIMARY KEY(`daily_production_report_id`)
) COMMENT 'Daily operational report generated at wrap each shoot day — the authoritative record of what was accomplished during principal photography. Captures report date, production project, episode, scenes completed, setups completed, pages shot, first shot time, last shot time, meal breaks, total crew hours, overtime hours, film stock or digital media consumed, accidents or incidents, weather conditions, director and AD notes, and schedule variance (ahead/behind). The DPR is the primary accountability document for production progress and the basis for production accounting reconciliation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` (
    `call_sheet_id` BIGINT COMMENT 'Unique identifier for the call sheet record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically the first assistant director or production coordinator) who issued this call sheet.',
    `location_id` BIGINT COMMENT 'Foreign key linking to production.location. Business justification: Normalization opportunity. Call sheet currently has denormalized location_name, location_address, location_type. Adding FK to location table allows retrieving authoritative location data via JOIN and ',
    `production_episode_id` BIGINT COMMENT 'Reference to the specific episode being shot on this call sheet date. Nullable for non-episodic productions.',
    `project_id` BIGINT COMMENT 'Reference to the production project for which this call sheet is issued.',
    `revised_call_sheet_id` BIGINT COMMENT 'Self-referencing FK on call_sheet (revised_call_sheet_id)',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Call sheet is issued FOR a specific shoot schedule entry. Strong operational relationship — the call sheet operationalizes the shoot schedule for that day. FK allows linking call sheet details to the ',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Call sheets schedule production for specific content titles. Essential for production planning by content, crew scheduling against content delivery dates, and tracking shoot schedules to final content',
    `advance_schedule_notes` STRING COMMENT 'Advance schedule information for the following shoot day, providing crew with next-day preparation details.',
    `base_camp_location` STRING COMMENT 'Location of the base camp where trailers, catering, and crew facilities are set up.',
    `call_sheet_number` STRING COMMENT 'The externally-known call sheet number or identifier issued by the assistant director department for this shoot day.',
    `call_sheet_status` STRING COMMENT 'Current lifecycle status of the call sheet document.. Valid values are `draft|issued|revised|cancelled|completed`',
    `cast_call_times` STRING COMMENT 'Structured list of individual cast member call times and pickup details (e.g., Actor Name: 05:30 - Pickup from hotel). Stored as formatted text.',
    `cover_set_description` STRING COMMENT 'Description of the cover set or alternative scenes to be shot if weather or other conditions prevent the primary schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this call sheet record was first created in the system.',
    `dalet_workflow_reference` STRING COMMENT 'Reference identifier linking this call sheet to the corresponding workflow task or document in Dalet Galaxy Media Asset Management system.',
    `department_call_times` STRING COMMENT 'Structured list of individual department call times (e.g., Hair/Makeup: 06:00, Camera: 07:00, Grip/Electric: 06:30). Stored as formatted text.',
    `director_name` STRING COMMENT 'Name of the director assigned to this shoot day.',
    `estimated_wrap_time` TIMESTAMP COMMENT 'Anticipated time for the shoot day to conclude and crew to wrap.',
    `first_ad_name` STRING COMMENT 'Name of the first assistant director responsible for issuing this call sheet and managing the shoot day.',
    `first_shot_time` TIMESTAMP COMMENT 'Scheduled time for the first camera shot or principal photography to begin.',
    `general_crew_call_time` TIMESTAMP COMMENT 'The default call time for general crew members to arrive on set or location.',
    `meal_times` STRING COMMENT 'Scheduled meal break times for the shoot day (e.g., Breakfast: 07:00, Lunch: 13:00).',
    `nearest_hospital` STRING COMMENT 'Name and address of the nearest hospital or emergency medical facility to the shoot location.',
    `notes` STRING COMMENT 'Additional notes, instructions, or important information for cast and crew regarding this shoot day.',
    `page_count` DECIMAL(18,2) COMMENT 'Total script page count scheduled to be shot on this call sheet date, measured in eighths of a page.',
    `parking_instructions` STRING COMMENT 'Parking location and instructions for crew and cast arriving at the shoot location.',
    `production_unit` STRING COMMENT 'The production unit or crew team assigned to this shoot day.. Valid values are `main_unit|second_unit|splinter_unit|vfx_unit`',
    `revision_date` DATE COMMENT 'Date when the current revision of the call sheet was issued.',
    `revision_number` STRING COMMENT 'Sequential revision number of the call sheet. Incremented each time the call sheet is revised and reissued.',
    `safety_notices` STRING COMMENT 'Safety notices, hazard warnings, and safety protocols for the shoot day (e.g., stunts, pyrotechnics, special effects).',
    `scene_descriptions` STRING COMMENT 'Brief descriptions of the scenes to be shot, providing context for cast and crew.',
    `scene_numbers` STRING COMMENT 'Comma-separated list of scene numbers scheduled to be shot on this call sheet date.',
    `shoot_date` DATE COMMENT 'The principal shoot date for which this call sheet is issued. This is the business event date for the production day.',
    `shoot_day_number` STRING COMMENT 'Sequential shoot day number within the production schedule (e.g., Day 1, Day 2, etc.).',
    `special_equipment_requirements` STRING COMMENT 'List of special equipment, vehicles, props, or technical gear required for this shoot day.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this call sheet record was last modified in the system.',
    `weather_contingency_flag` BOOLEAN COMMENT 'Indicates whether a weather contingency plan or cover set is in place for this shoot day.',
    `weather_forecast` STRING COMMENT 'Weather forecast for the shoot date and location, critical for outdoor shoots and contingency planning.',
    CONSTRAINT pk_call_sheet PRIMARY KEY(`call_sheet_id`)
) COMMENT 'Daily call sheet issued by the assistant director department for each shoot day. Captures call date, production project, episode, general crew call time, individual department call times, cast member call times and pickup details, scenes to be shot with brief descriptions, location or stage, special equipment requirements, advance schedule for following day, safety notices, and weather forecast. The call sheet is the primary communication and coordination document for all cast and crew on a production.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` (
    `broadcast_id` BIGINT COMMENT 'Primary key for the broadcast association',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to the production episode being broadcast in this slot',
    `rights_content_window_id` BIGINT COMMENT 'Reference to the specific rights window or license agreement governing this broadcast. Same episode may have different rights windows for different territories, platforms, or time periods.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to the schedule slot in which this episode is broadcast',
    `broadcast_date` DATE COMMENT 'The calendar date on which this specific broadcast of the episode occurred or is scheduled to occur. Enables tracking of original vs repeat airings over time.',
    `broadcast_status` STRING COMMENT 'Current lifecycle status of this specific broadcast event. Tracks whether the scheduled broadcast occurred as planned or was preempted/cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this broadcast assignment was created in the scheduling system. Audit trail for scheduling operations.',
    `edit_type` STRING COMMENT 'Classification of editorial modifications applied for this specific broadcast (content edits for standards, time compression, localization). Varies by territory and daypart.',
    `platform_type` STRING COMMENT 'Distribution platform on which this broadcast occurs. Same episode may be scheduled across linear TV, streaming simulcast, and VOD platforms with different rights and versions.',
    `repeat_number` STRING COMMENT 'Sequential count of how many times this episode has been broadcast on this channel/platform. 0 = original airing, 1+ = repeat. Critical for rights management and audience measurement.',
    `territory_code` STRING COMMENT 'ISO country or region code identifying the geographic territory for this broadcast. Same episode may be broadcast simultaneously in multiple territories with different versions or rights windows.',
    `transmission_version` STRING COMMENT 'The specific editorial version of the episode transmitted in this broadcast (e.g., theatrical cut, TV edit, international version). Different slots may air different versions of the same episode.',
    `created_by` STRING COMMENT 'User ID or name of the scheduler who created this broadcast assignment. Accountability for scheduling decisions.',
    CONSTRAINT pk_broadcast PRIMARY KEY(`broadcast_id`)
) COMMENT 'This association product represents the broadcast event linking a production episode to a specific schedule slot. It captures the operational details of each individual airing of an episode, including transmission version, territory, platform, repeat sequencing, and rights window. Each record represents one broadcast occurrence of one episode in one slot, enabling multi-territory, multi-platform scheduling with version control and repeat tracking.. Existence Justification: In media broadcasting operations, a single production episode is broadcast multiple times across different schedule slots (primetime, repeat slots, different channels, international feeds, streaming platforms). Conversely, each schedule slot contains exactly one episode at a time, but the same slot position (e.g., Monday 8pm) will host different episodes over time. The business actively manages broadcast events as operational records, tracking which version of which episode airs in which slot, for which territory, on which platform, with specific rights windows and repeat sequencing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` (
    `episode_sponsorship_id` BIGINT COMMENT 'Unique surrogate identifier for this episode-sponsorship placement record. Primary key.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to the specific episode receiving sponsorship placement',
    `sponsorship_id` BIGINT COMMENT 'Foreign key linking to the sponsorship deal being fulfilled through this episode',
    `employee_id` BIGINT COMMENT 'Reference to the employee who verified fulfillment of this specific episode-sponsorship placement.',
    `episode_production_episode_id` BIGINT COMMENT '',
    `actual_impressions` BIGINT COMMENT 'Actual number of impressions delivered for this specific episode-sponsorship placement across all distribution platforms.',
    `billboard_placement_timecode` STRING COMMENT 'SMPTE timecode indicating the exact placement location of the sponsor billboard within the episode master (e.g., opening, closing, mid-roll). Identified in detection phase.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this episode-sponsorship placement record was created in the system.',
    `end_date` DATE COMMENT 'Date when this specific sponsorship placement expires for this episode. Corresponds to sponsorship_end_date from detection phase.',
    `fulfillment_status` STRING COMMENT 'Current status of deliverable fulfillment for this specific episode-sponsorship placement. Tracks whether sponsor obligations have been met for this episode. Identified in detection phase.',
    `logo_display_duration_seconds` DECIMAL(18,2) COMMENT 'Duration in seconds that the sponsor logo is displayed during this episode placement. Used for fulfillment verification and sponsor reporting. Identified in detection phase.',
    `makegood_reason` STRING COMMENT 'Description of why a makegood is required for this placement (e.g., technical issue, audience under-delivery, incorrect placement).',
    `makegood_required_flag` BOOLEAN COMMENT 'Indicates whether a makegood (compensatory placement) is required due to under-delivery or quality issues with this specific episode-sponsorship placement.',
    `placement_type` STRING COMMENT 'Classification of the specific type of sponsorship placement within this episode (opening, closing, mid-roll, integration, etc.). Derived from billboard_placement_timecode and deliverables.',
    `product_integration_scene_numbers` STRING COMMENT 'Comma-separated list of scene numbers where product integration occurs for this sponsor within this episode. Used for production coordination and fulfillment tracking. Identified in detection phase.',
    `start_date` DATE COMMENT 'Date when this specific sponsorship placement becomes active for this episode. Corresponds to sponsorship_start_date from detection phase.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this episode-sponsorship placement record was last updated.',
    `verification_date` DATE COMMENT 'Date on which fulfillment of this episode-sponsorship placement was verified and approved.',
    CONSTRAINT pk_episode_sponsorship PRIMARY KEY(`episode_sponsorship_id`)
) COMMENT 'This association product represents the Contract between production_episode and sponsorship. It captures the specific placement, fulfillment, and integration details for each sponsorship deal applied to each episode. Each record links one production_episode to one sponsorship with attributes that exist only in the context of this relationship, including placement timecodes, fulfillment tracking, and integration scene references.. Existence Justification: In media broadcasting operations, a single episode can have multiple sponsorship deals (e.g., Brand A sponsors the opening billboard, Brand B sponsors the closing billboard, Brand C has product integration in scenes 5-7), and a single sponsorship deal (especially for series or season-level sponsorships) applies to multiple episodes across the season or series run. The business actively manages each episode-sponsorship placement as a distinct fulfillment obligation with specific timecodes, placement types, verification status, and impression tracking.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` (
    `project_sponsorship_id` BIGINT COMMENT 'Unique surrogate identifier for the project sponsorship record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Foreign key to advertising.advertiser. Links this sponsorship to the funding advertiser.',
    `project_id` BIGINT COMMENT 'Foreign key to production.project. Links this sponsorship to the content production project.',
    `approval_rights_level` STRING COMMENT 'Level of creative approval authority granted to the advertiser over content related to their sponsorship (e.g., none, consultation, approval required, creative control). Explicitly identified in detection phase relationship data.',
    `co_production_agreement_reference` STRING COMMENT 'External reference identifier or document number for the legal co-production or sponsorship agreement governing this partnership. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this sponsorship record was created.',
    `deliverable_requirements` STRING COMMENT 'Textual description of the specific deliverables the production team must provide to the advertiser (e.g., logo placement duration, product integration scenes, behind-the-scenes content, premiere tickets). Explicitly identified in detection phase relationship data.',
    `funding_amount` DECIMAL(18,2) COMMENT 'Total monetary contribution committed by the advertiser to this production project, denominated in the currency specified in funding_currency_code. Explicitly identified in detection phase relationship data.',
    `funding_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the funding amount (e.g., USD, EUR, GBP).',
    `funding_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total production budget contributed by this advertiser, expressed as a decimal (e.g., 25.00 for 25%). Explicitly identified in detection phase relationship data.',
    `logo_placement_seconds` STRING COMMENT 'Total duration in seconds of advertiser logo or brand placement within the content, as contractually committed.',
    `partnership_end_date` DATE COMMENT 'Expiration or completion date of the sponsorship partnership agreement.',
    `partnership_start_date` DATE COMMENT 'Effective start date of the sponsorship partnership agreement.',
    `partnership_status` STRING COMMENT 'Current lifecycle status of the sponsorship partnership (e.g., proposed, negotiating, active, fulfilled, terminated).',
    `partnership_type` STRING COMMENT 'Classification of the sponsorship arrangement indicating the level and nature of the advertisers involvement (e.g., title sponsor, co-production partner, product placement, branded content integration). Explicitly identified in detection phase relationship data.',
    `product_integration_flag` BOOLEAN COMMENT 'Boolean indicator of whether this sponsorship includes product integration or placement within the content narrative.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this sponsorship record was last modified.',
    CONSTRAINT pk_project_sponsorship PRIMARY KEY(`project_sponsorship_id`)
) COMMENT 'This association product represents the commercial partnership between a content production project and an advertising client who provides funding or co-production support. It captures the financial terms, partnership structure, and deliverable obligations that exist only in the context of this specific project-advertiser relationship. Each record links one production project to one advertiser with attributes governing the sponsorship arrangement.. Existence Justification: In media broadcasting, content production projects frequently secure funding from multiple advertising partners simultaneously (e.g., a documentary series with automotive, tech, and beverage sponsors), and advertisers invest in multiple production projects across their portfolio. The business actively manages these sponsorship partnerships as distinct operational entities with specific financial terms, deliverable obligations, approval rights, and partnership statuses that belong to neither the project nor the advertiser alone.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` (
    `shoot_day_id` BIGINT COMMENT 'Primary key for shoot_day',
    `location_id` BIGINT COMMENT 'Reference to the primary filming location for this shoot day.',
    `project_id` BIGINT COMMENT 'Reference to the parent production or project this shoot day belongs to.',
    `rescheduled_shoot_day_id` BIGINT COMMENT 'Self-referencing FK on shoot_day (rescheduled_shoot_day_id)',
    `employee_id` BIGINT COMMENT 'Reference to the cinematographer or director of photography assigned to this shoot day.',
    `shoot_employee_id` BIGINT COMMENT 'Reference to the director assigned to this shoot day.',
    `shoot_first_assistant_director_employee_id` BIGINT COMMENT 'Reference to the first assistant director managing the shoot day logistics.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost incurred for this shoot day, including crew, equipment, location fees, and other expenses.',
    `actual_date` DATE COMMENT 'The actual calendar date when the shoot day occurred. May differ from scheduled date due to weather, delays, or other factors.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'The budget amount allocated for this specific shoot day.',
    `call_time` TIMESTAMP COMMENT 'The time when crew members are required to arrive on set.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this shoot day record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this shoot day.',
    `dailies_delivered_flag` BOOLEAN COMMENT 'Indicates whether dailies (raw footage review copies) were delivered for this shoot day.',
    `dailies_delivery_timestamp` TIMESTAMP COMMENT 'The timestamp when dailies were delivered to post-production for this shoot day.',
    `footage_shot_minutes` DECIMAL(18,2) COMMENT 'Total duration of raw footage captured during this shoot day, measured in minutes.',
    `is_overtime_incurred` BOOLEAN COMMENT 'Indicates whether crew overtime was incurred on this shoot day.',
    `meal_penalty_count` STRING COMMENT 'Number of meal penalty violations incurred during this shoot day due to delayed meal breaks.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this shoot day record was last modified.',
    `notes` STRING COMMENT 'Free-text notes capturing important observations, issues, or highlights from this shoot day.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked by crew on this shoot day.',
    `safety_incidents_count` STRING COMMENT 'Number of safety incidents or accidents reported during this shoot day.',
    `scenes_completed_count` STRING COMMENT 'Number of scenes actually completed during this shoot day.',
    `scenes_scheduled_count` STRING COMMENT 'Number of scenes scheduled to be filmed on this shoot day.',
    `scheduled_date` DATE COMMENT 'The planned calendar date for this shoot day.',
    `script_pages_completed` DECIMAL(18,2) COMMENT 'Number of script pages actually completed during this shoot day, measured in eighths of a page.',
    `script_pages_scheduled` DECIMAL(18,2) COMMENT 'Number of script pages scheduled to be filmed on this shoot day, measured in eighths of a page.',
    `shoot_day_number` STRING COMMENT 'Sequential day number within the production schedule (e.g., Day 1, Day 2, Day 15).',
    `shoot_day_status` STRING COMMENT 'Current lifecycle status of the shoot day.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Average temperature during the shoot day in degrees Fahrenheit.',
    `total_cast_count` STRING COMMENT 'Total number of cast members (actors, extras) present on this shoot day.',
    `total_crew_count` STRING COMMENT 'Total number of crew members present on this shoot day.',
    `total_extras_count` STRING COMMENT 'Total number of background actors or extras present on this shoot day.',
    `total_setups_count` STRING COMMENT 'Total number of camera setups or shots completed during this shoot day.',
    `unit_type` STRING COMMENT 'The type of production unit filming on this shoot day.',
    `weather_condition` STRING COMMENT 'The predominant weather condition during this shoot day, relevant for continuity and scheduling.',
    `wrap_time` TIMESTAMP COMMENT 'The time when principal photography concluded and the shoot day was wrapped.',
    `shoot_production_episode_id` BIGINT COMMENT '',
    CONSTRAINT pk_shoot_day PRIMARY KEY(`shoot_day_id`)
) COMMENT 'Master reference table for shoot_day. Referenced by shoot_day_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` (
    `equipment_item_id` BIGINT COMMENT 'Primary key for equipment_item',
    `employee_id` BIGINT COMMENT 'Reference to the crew member who currently has custody or responsibility for this equipment item.',
    `equipment_type_id` BIGINT COMMENT 'Reference to the equipment type classification that defines the category and specifications of this equipment item.',
    `location_id` BIGINT COMMENT 'Reference to the facility, studio, or storage location where this equipment item is currently located.',
    `parent_equipment_item_id` BIGINT COMMENT 'Self-referencing FK on equipment_item (parent_equipment_item_id)',
    `project_id` BIGINT COMMENT 'Reference to the production project to which this equipment item is currently assigned, if applicable.',
    `rental_agreement_id` BIGINT COMMENT 'Reference to the rental agreement contract if this equipment item is rented rather than owned.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom this equipment item was purchased.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or acquisition cost of the equipment item in the organizations base currency.',
    `acquisition_date` DATE COMMENT 'Date when the equipment item was acquired or purchased by the organization.',
    `asset_tag` STRING COMMENT 'Externally-visible unique asset tag or barcode identifier affixed to the physical equipment for tracking and inventory purposes.',
    `assignment_start_date` DATE COMMENT 'Date when the current assignment of this equipment item to a production or crew member began.',
    `condition` STRING COMMENT 'Assessment of the physical condition and operational readiness of the equipment item.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment item record was first created in the system.',
    `current_value` DECIMAL(18,2) COMMENT 'Current estimated market or book value of the equipment item, reflecting depreciation and condition.',
    `daily_rental_rate` DECIMAL(18,2) COMMENT 'Daily rental cost for this equipment item if it is rented, in the organizations base currency.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation of this equipment item over its useful life.',
    `disposal_method` STRING COMMENT 'Method by which this equipment item was disposed of after retirement from service.',
    `expected_return_date` DATE COMMENT 'Scheduled date when the equipment item is expected to be returned from its current assignment.',
    `insurance_expiration_date` DATE COMMENT 'Date when the current insurance coverage for this equipment item expires.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance coverage protecting this equipment item against loss or damage.',
    `is_rental` BOOLEAN COMMENT 'Indicates whether this equipment item is rented from an external vendor rather than owned by the organization.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance, inspection, or service was performed on this equipment item.',
    `maintenance_interval_days` STRING COMMENT 'Standard number of days between scheduled maintenance activities for this equipment item.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured this equipment item.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for this equipment item.',
    `equipment_item_name` STRING COMMENT 'Human-readable name or title of the equipment item for identification and display purposes.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next required maintenance or inspection of this equipment item.',
    `notes` STRING COMMENT 'Free-form notes, comments, or special instructions related to this equipment item.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the acquisition of this equipment item.',
    `retirement_date` DATE COMMENT 'Date when this equipment item was retired from active service and removed from the available inventory.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number uniquely identifying this specific unit of equipment.',
    `equipment_item_status` STRING COMMENT 'Current operational status of the equipment item in its lifecycle.',
    `technical_specifications` STRING COMMENT 'Detailed technical specifications, capabilities, and features of this equipment item relevant to production use.',
    `total_usage_hours` DECIMAL(18,2) COMMENT 'Cumulative total hours of operational usage recorded for this equipment item since acquisition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment item record was most recently updated in the system.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the equipment item in years for depreciation and replacement planning purposes.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage for this equipment item expires.',
    CONSTRAINT pk_equipment_item PRIMARY KEY(`equipment_item_id`)
) COMMENT 'Master reference table for equipment_item. Referenced by equipment_item_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` (
    `equipment_type_id` BIGINT COMMENT 'Primary key for equipment_type',
    `parent_equipment_type_id` BIGINT COMMENT 'Self-referencing FK on equipment_type (parent_equipment_type_id)',
    `vendor_id` BIGINT COMMENT 'Reference to the primary vendor or supplier from whom this equipment type is typically procured or rented.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - equipment type catalog needs a maintainer for asset management',
    `average_lifespan_years` DECIMAL(18,2) COMMENT 'Expected operational lifespan of this equipment type in years under normal production usage conditions.',
    `equipment_type_category` STRING COMMENT 'High-level classification grouping equipment types by production function: camera, lighting, audio, grip, electric, or post_production.',
    `certification_requirements` STRING COMMENT 'Description of required certifications, licenses, or training credentials needed to operate this equipment type.',
    `compatible_accessories` STRING COMMENT 'List or description of standard accessories, attachments, or complementary equipment types that are compatible with or commonly used alongside this equipment type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment type record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values associated with this equipment type (e.g., USD, GBP, EUR).',
    `daily_rental_rate` DECIMAL(18,2) COMMENT 'Standard daily rental rate for this equipment type in the base currency. Used for production budgeting and cost allocation.',
    `equipment_type_description` STRING COMMENT 'Detailed narrative description of the equipment type, its capabilities, typical use cases, and production applications.',
    `dimensions` STRING COMMENT 'Physical dimensions of the equipment type in standard format (e.g., length x width x height in cm or inches). Used for storage and transport planning.',
    `discontinuation_date` DATE COMMENT 'Date on which this equipment type was or will be discontinued and removed from active inventory. Null if still active.',
    `effective_date` DATE COMMENT 'Date from which this equipment type became available for production use and allocation.',
    `insurance_category` STRING COMMENT 'Insurance classification for risk assessment and coverage determination: standard (routine equipment), high_value (premium items), specialized (unique/rare), hazardous (elevated risk).',
    `maintenance_interval_days` STRING COMMENT 'Recommended number of days between scheduled maintenance or inspection cycles for this equipment type.',
    `manufacturer` STRING COMMENT 'Name of the equipment manufacturer or brand (e.g., ARRI, Sony, Blackmagic, Sennheiser, Avid).',
    `model_designation` STRING COMMENT 'Specific model or product line designation from the manufacturer (e.g., ALEXA Mini LF, FX9, URSA Mini Pro 12K).',
    `power_requirements` STRING COMMENT 'Electrical power specifications including voltage, amperage, and connector type (e.g., 120V AC, 15A, Edison plug; V-Mount battery).',
    `replacement_cost` DECIMAL(18,2) COMMENT 'Estimated cost to replace or purchase a new unit of this equipment type. Used for insurance valuation and damage assessment.',
    `requires_certification` BOOLEAN COMMENT 'Indicates whether crew members must hold specific certifications or training credentials to operate this equipment type (e.g., drone pilot license, rigging certification).',
    `requires_operator` BOOLEAN COMMENT 'Indicates whether this equipment type requires a specialized operator or technician to be allocated alongside the equipment (e.g., Steadicam operator, crane operator).',
    `equipment_type_status` STRING COMMENT 'Current lifecycle status of this equipment type in the production inventory: active (available for use), deprecated (phasing out), discontinued (no longer supported), under_review (evaluation pending).',
    `storage_requirements` STRING COMMENT 'Special storage conditions or requirements for this equipment type (e.g., climate-controlled, shock-resistant case, vertical storage only).',
    `subcategory` STRING COMMENT 'Detailed classification within the category (e.g., Digital Cinema Camera, LED Panel, Boom Microphone, Dolly, Generator, Color Grading Suite).',
    `technical_specifications` STRING COMMENT 'Key technical specifications and performance characteristics (e.g., sensor size, resolution, power requirements, weight, connectivity).',
    `transport_case_required` BOOLEAN COMMENT 'Indicates whether this equipment type must be transported in a specialized protective case or container.',
    `type_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying this equipment type across production systems. Used for cataloging and cross-system reference.',
    `type_name` STRING COMMENT 'Human-readable name of the equipment type (e.g., Camera, Lighting Rig, Audio Mixer, Drone, Crane).',
    `unit_of_measure` STRING COMMENT 'Standard unit by which this equipment type is counted and allocated: each (individual item), set (matched group), kit (bundled components), system (integrated solution), package (complete configuration).',
    `updated_by` STRING COMMENT 'Username or identifier of the user who last modified this equipment type record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment type record was last modified.',
    `weekly_rental_rate` DECIMAL(18,2) COMMENT 'Standard weekly rental rate for this equipment type in the base currency. Typically discounted compared to 7x daily rate.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Standard weight of this equipment type in kilograms. Used for transportation planning, rigging calculations, and crew allocation.',
    `workflow_integration` STRING COMMENT 'Description of how this equipment type integrates with production workflow systems such as Dalet Galaxy, asset management platforms, or post-production pipelines.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this equipment type record.',
    CONSTRAINT pk_equipment_type PRIMARY KEY(`equipment_type_id`)
) COMMENT 'Master reference table for equipment_type. Referenced by equipment_type_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` (
    `rental_agreement_id` BIGINT COMMENT 'Primary key for rental_agreement',
    `cost_center_id` BIGINT COMMENT 'add column finance_cost_center_id (BIGINT) with FK to finance.cost_center.cost_center_id - rental costs must be allocated to cost centers for budget tracking',
    `project_id` BIGINT COMMENT 'Reference to the production project for which this rental agreement was created.',
    `renewed_rental_agreement_id` BIGINT COMMENT 'Self-referencing FK on rental_agreement (renewed_rental_agreement_id)',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier providing the rental equipment or facility.',
    `production_id` BIGINT COMMENT '',
    `actual_return_date` DATE COMMENT 'Actual date when the rented asset was returned, used to calculate overages or extensions.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the rental agreement, used in contracts and invoicing.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the rental agreement.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the rental agreement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rental agreement was approved.',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether the rental agreement automatically renews unless cancelled.',
    `cancellation_date` DATE COMMENT 'Date when the rental agreement was cancelled or terminated.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation or termination of the rental agreement, if applicable.',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed rental agreement contract document.',
    `cost_center_code` STRING COMMENT 'Financial cost center or budget code to which rental expenses are allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the rental agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rental rate and amounts.',
    `damage_waiver_fee` DECIMAL(18,2) COMMENT 'Optional fee paid to waive liability for minor damage to the rented asset.',
    `delivery_date` DATE COMMENT 'Scheduled date for delivery or availability of the rented asset.',
    `delivery_location` STRING COMMENT 'Physical location where the rented asset will be delivered or made available.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Security deposit or advance payment required to secure the rental agreement.',
    `deposit_paid_date` DATE COMMENT 'Date when the security deposit was paid to the vendor.',
    `effective_end_date` DATE COMMENT 'Date when the rental agreement ends and the asset must be returned. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the rental agreement becomes binding and the rental period begins.',
    `estimated_total_amount` DECIMAL(18,2) COMMENT 'Estimated total cost of the rental agreement over its full term, excluding taxes and fees.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance coverage for the rental, if applicable.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether insurance coverage is required for the rented asset or facility.',
    `late_fee_rate` DECIMAL(18,2) COMMENT 'Penalty rate charged per day or period for late return of the rented asset.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the rental agreement record was last modified.',
    `notes` STRING COMMENT 'Free-form notes or comments related to the rental agreement for internal reference.',
    `payment_terms` STRING COMMENT 'Contractual payment terms and conditions, including due dates and payment schedule.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with this rental agreement for procurement tracking.',
    `rate_frequency` STRING COMMENT 'The billing frequency or unit for the rental rate (e.g., daily, weekly, monthly).',
    `renewal_option` BOOLEAN COMMENT 'Indicates whether the rental agreement includes an option to renew or extend.',
    `rental_description` STRING COMMENT 'Detailed description of the equipment, facility, or service being rented under this agreement.',
    `rental_rate` DECIMAL(18,2) COMMENT 'The periodic rental rate charged for the asset or service.',
    `rental_type` STRING COMMENT 'Classification of the rental agreement by the type of asset or service being rented.',
    `return_date` DATE COMMENT 'Scheduled date for return of the rented asset to the vendor.',
    `return_location` STRING COMMENT 'Physical location where the rented asset must be returned at the end of the rental period.',
    `special_terms` STRING COMMENT 'Additional special terms, conditions, or clauses specific to this rental agreement.',
    CONSTRAINT pk_rental_agreement PRIMARY KEY(`rental_agreement_id`)
) COMMENT 'Master reference table for rental_agreement. Referenced by rental_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_equipment_item_id` FOREIGN KEY (`equipment_item_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`equipment_item`(`equipment_item_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_shoot_day_id` FOREIGN KEY (`shoot_day_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_day`(`shoot_day_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_parent_task_post_production_task_id` FOREIGN KEY (`parent_task_post_production_task_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`post_production_task`(`post_production_task_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_vfx_shot_id` FOREIGN KEY (`vfx_shot_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`vfx_shot`(`vfx_shot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_format_spec_id` FOREIGN KEY (`format_spec_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`format_spec`(`format_spec_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_post_production_task_id` FOREIGN KEY (`post_production_task_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`post_production_task`(`post_production_task_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_predecessor_milestone_id` FOREIGN KEY (`predecessor_milestone_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_previous_daily_production_report_id` FOREIGN KEY (`previous_daily_production_report_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`daily_production_report`(`daily_production_report_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_revised_call_sheet_id` FOREIGN KEY (`revised_call_sheet_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`call_sheet`(`call_sheet_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ADD CONSTRAINT `fk_production_broadcast_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ADD CONSTRAINT `fk_production_episode_sponsorship_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ADD CONSTRAINT `fk_production_episode_sponsorship_episode_production_episode_id` FOREIGN KEY (`episode_production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ADD CONSTRAINT `fk_production_project_sponsorship_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_rescheduled_shoot_day_id` FOREIGN KEY (`rescheduled_shoot_day_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_day`(`shoot_day_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_equipment_type_id` FOREIGN KEY (`equipment_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`location`(`location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_parent_equipment_item_id` FOREIGN KEY (`parent_equipment_item_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`equipment_item`(`equipment_item_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ADD CONSTRAINT `fk_production_equipment_type_parent_equipment_type_id` FOREIGN KEY (`parent_equipment_type_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`equipment_type`(`equipment_type_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ADD CONSTRAINT `fk_production_rental_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ADD CONSTRAINT `fk_production_rental_agreement_renewed_rental_agreement_id` FOREIGN KEY (`renewed_rental_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ADD CONSTRAINT `fk_production_rental_agreement_production_id` FOREIGN KEY (`production_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Production Company Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Showrunner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Spend (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Production Budget (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_business_glossary_term' = 'FCC Broadcast License Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_value_regex' = 'pending|greenlighted|on_hold|cancelled|completed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Intellectual Property (IP) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Production Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography End Date (Picture Wrap)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_business_glossary_term' = 'Primary Production Country');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_format` SET TAGS ('dbx_business_glossary_term' = 'Production Format / Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'development|pre_production|principal_photography|post_production|delivery|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Production Project Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_business_glossary_term' = 'Production Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Target Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime (Minutes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Dailies Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Director ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_extras_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Background Extras Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_shoot_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Shoot Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `actual_wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Wrap Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Call Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `cover_set_description` SET TAGS ('dbx_business_glossary_term' = 'Cover Set Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `day_out_of_days_type` SET TAGS ('dbx_business_glossary_term' = 'Day Out of Days (DOOD) Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_extras_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Background Extras Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `estimated_shoot_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Shoot Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `first_shot_time` SET TAGS ('dbx_business_glossary_term' = 'First Shot Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `is_overtime_day` SET TAGS ('dbx_business_glossary_term' = 'Overtime Day Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `meal_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Script Page Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Day Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_unit` SET TAGS ('dbx_value_regex' = 'main_unit|second_unit|splinter_unit|insert_unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Revision Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `revision_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Revision Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_business_glossary_term' = 'Scene Numbers');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|in_progress|completed|cancelled|postponed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `scheduled_wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Wrap Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_date` SET TAGS ('dbx_business_glossary_term' = 'Shoot Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_type` SET TAGS ('dbx_business_glossary_term' = 'Shoot Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_type` SET TAGS ('dbx_value_regex' = 'studio|location|exterior|interior|mixed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `total_approved_shoot_days` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Shoot Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Crew Turnaround Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `weather_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Contingency Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|LOCKED|CLOSED');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Request Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Commitment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_value_regex' = 'ABOVE_THE_LINE|BELOW_THE_LINE|POST_PRODUCTION|CONTINGENCY|OVERHEAD');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast to Complete Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Budget Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'DEVELOPMENT|PRE_PRODUCTION|PRINCIPAL_PHOTOGRAPHY|POST_PRODUCTION|DELIVERY|CLOSED');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Object ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'ORIGINAL|REVISED_1|REVISED_2|REVISED_3|FINAL|LOCKED');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor / Payee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'Production Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Sub-Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Amount (EAC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_business_glossary_term' = 'Above-the-Line (ATL) Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_business_glossary_term' = 'Union Labor Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'development|pre_production|principal_photography|post_production|delivery|archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budgeted Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_business_glossary_term' = 'Shoot End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_business_glossary_term' = 'Shoot Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligible Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'resource_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Out Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|failed|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Box Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_business_glossary_term' = 'Screen Credit Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Screen Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_value_regex' = 'main_title|end_title|both|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|flat|run_of_show|episodic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Production Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_business_glossary_term' = 'Filming Location Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Work Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Kit Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `meal_penalty_eligible` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Crew Role Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Certified Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `sap_personnel_action_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Personnel Action ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Work Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_business_glossary_term' = 'Travel Allowance');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union / Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` SET TAGS ('dbx_subdomain' = 'resource_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Booking ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Booked By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual End Datetime');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Datetime');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_end` SET TAGS ('dbx_business_glossary_term' = 'Booking End Datetime');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_reference` SET TAGS ('dbx_value_regex' = '^BK-[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_start` SET TAGS ('dbx_business_glossary_term' = 'Booking Start Datetime');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|cancelled|completed|on_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_fee` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `capacity_persons` SET TAGS ('dbx_business_glossary_term' = 'Facility Capacity (Persons)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_location` SET TAGS ('dbx_business_glossary_term' = 'Facility Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Use Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Booking Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|half_day|weekly|flat_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `technical_specs` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` SET TAGS ('dbx_subdomain' = 'resource_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Member ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Item ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Vendor ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `shoot_day_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^EQALLOC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `asset_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `asset_tag_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_condition` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition at Checkout');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_condition` SET TAGS ('dbx_value_regex' = 'new|excellent|good|fair|poor');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Equipment Checkout Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Damage Claim Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_claim_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Damage Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_business_glossary_term' = 'Equipment Insurance Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `is_insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `is_owned_asset` SET TAGS ('dbx_business_glossary_term' = 'Owned Asset Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `production_department` SET TAGS ('dbx_business_glossary_term' = 'Production Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Equipment Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `rental_rate_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|flat_fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition at Return');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `shoot_location` SET TAGS ('dbx_business_glossary_term' = 'Shoot Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_allocation` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_running_time_sec` SET TAGS ('dbx_business_glossary_term' = 'Actual Running Time (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Production Budget (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Audio Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_mix_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Audio Mix Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `closed_captioning_compliant` SET TAGS ('dbx_business_glossary_term' = 'Closed Captioning Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `color_grade_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Color Grading Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `director_name` SET TAGS ('dbx_business_glossary_term' = 'Director Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_business_glossary_term' = 'Episode Production Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `first_air_date` SET TAGS ('dbx_business_glossary_term' = 'First Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_business_glossary_term' = 'Master Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_value_regex' = 'UHD_HDR|UHD_SDR|HD_1080p|HD_720p|SD');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `picture_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Picture Lock Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_end_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_location` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_start_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `showrunner_name` SET TAGS ('dbx_business_glossary_term' = 'Showrunner Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `target_running_time_sec` SET TAGS ('dbx_business_glossary_term' = 'Target Running Time (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `vfx_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Visual Effects (VFX) Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `writer_name` SET TAGS ('dbx_business_glossary_term' = 'Writer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Writer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Script Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `dalet_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_business_glossary_term' = 'Distribution Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_business_glossary_term' = 'Draft Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_value_regex' = 'outline|first draft|revised draft|shooting script|post-production script|final draft');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `estimated_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Runtime in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Script File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|FDX|FOUNTAIN|TXT');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Script Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Script Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Script Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_status` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Script Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Script Page Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Script Revision Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_business_glossary_term' = 'Scene Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_business_glossary_term' = 'Script Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_business_glossary_term' = 'Script Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_value_regex' = 'draft|in review|approved|locked|archived|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Script Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Writers Guild of America (WGA) Registration Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `writer_credits` SET TAGS ('dbx_business_glossary_term' = 'Writer Credits');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` SET TAGS ('dbx_subdomain' = 'post_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Task Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Output Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `parent_task_post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Task Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Vendor Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Operator Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `studio_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `vfx_shot_id` SET TAGS ('dbx_business_glossary_term' = 'Vfx Shot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `dalet_workflow_task_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow Task Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `dependency_type` SET TAGS ('dbx_business_glossary_term' = 'Dependency Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `dependency_type` SET TAGS ('dbx_value_regex' = 'finish_to_start|start_to_start|finish_to_finish|start_to_finish|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `output_media_path` SET TAGS ('dbx_business_glossary_term' = 'Output Media Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `scheduled_due_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `source_media_path` SET TAGS ('dbx_business_glossary_term' = 'Source Media Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `task_notes` SET TAGS ('dbx_business_glossary_term' = 'Task Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `technical_specification` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `workstation_code` SET TAGS ('dbx_business_glossary_term' = 'Workstation Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` SET TAGS ('dbx_subdomain' = 'post_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `vfx_shot_id` SET TAGS ('dbx_business_glossary_term' = 'Visual Effects (VFX) Shot Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Render Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'VFX Supervisor Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Rendered Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Actual Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual VFX Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `approved_cost` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Approved Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `approved_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `assigned_team_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned In-House Team Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `bid_cost` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Bid Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `bid_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `brief_issued_date` SET TAGS ('dbx_business_glossary_term' = 'VFX Brief Issued Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `complexity_tier` SET TAGS ('dbx_business_glossary_term' = 'VFX Complexity Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `complexity_tier` SET TAGS ('dbx_value_regex' = 'simple|moderate|complex|hero');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `delivery_version` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Delivery Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `final_frame_count` SET TAGS ('dbx_business_glossary_term' = 'Final VFX Frame Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Production Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `revision_count` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Revision Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `scene_reference` SET TAGS ('dbx_business_glossary_term' = 'Scene Reference Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled VFX Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `shot_code` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `shot_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}_[A-Z0-9]{3,6}_[0-9]{3,4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `shot_name` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `shot_status` SET TAGS ('dbx_business_glossary_term' = 'VFX Shot Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `shot_status` SET TAGS ('dbx_value_regex' = 'brief_issued|in_progress|vendor_review|client_review|approved|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `take_reference` SET TAGS ('dbx_business_glossary_term' = 'Take Reference Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `vfx_category` SET TAGS ('dbx_business_glossary_term' = 'VFX Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`vfx_shot` ALTER COLUMN `vfx_category` SET TAGS ('dbx_value_regex' = 'compositing|cgi|matte_painting|motion_capture|de_aging|green_screen_key');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `encoder_config_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `format_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Production Format Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certificate Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Operator Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Performed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` SET TAGS ('dbx_subdomain' = 'post_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Post Production Task Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `primary_qc_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Operator ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `primary_qc_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `primary_qc_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Target Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Error Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending_approval|conditional_approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Loudness Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Loudness Level (LUFS)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 1 (P1) Critical Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 2 (P2) Major Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 3 (P3) Minor Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_value_regex' = 'technical_qc|editorial_qc|compliance_qc|accessibility_qc|loudness_qc|format_qc');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Quality Control (Re-QC) Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Duration (Minutes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_business_glossary_term' = 'Total Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` SET TAGS ('dbx_subdomain' = 'post_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_record_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Record ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Operator ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '^[0-9]+:[0-9]+$|16:9|4:3|21:9|2.39:1|1.85:1');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `audio_sample_rate` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Bit Depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum MD5');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum SHA-256');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Completion Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_number` SET TAGS ('dbx_business_glossary_term' = 'Ingest Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_number` SET TAGS ('dbx_value_regex' = '^ING-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Ingest Operator Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_priority` SET TAGS ('dbx_business_glossary_term' = 'Ingest Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_status` SET TAGS ('dbx_business_glossary_term' = 'Ingest Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_status` SET TAGS ('dbx_value_regex' = 'pending|in-progress|complete|failed|cancelled|quarantined');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}x[0-9]{3,4}$|SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_business_glossary_term' = 'Scene Numbers');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `shoot_date` SET TAGS ('dbx_business_glossary_term' = 'Shoot Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `source_device` SET TAGS ('dbx_business_glossary_term' = 'Source Device');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `source_format` SET TAGS ('dbx_business_glossary_term' = 'Source Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `source_media_type` SET TAGS ('dbx_business_glossary_term' = 'Source Media Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `source_tape_code` SET TAGS ('dbx_business_glossary_term' = 'Source Tape ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'online|nearline|archive|deep-archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `timecode_end` SET TAGS ('dbx_business_glossary_term' = 'Timecode End');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `timecode_end` SET TAGS ('dbx_value_regex' = '^[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `timecode_start` SET TAGS ('dbx_business_glossary_term' = 'Timecode Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `timecode_start` SET TAGS ('dbx_value_regex' = '^[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`ingest_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact in United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_format` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_business_glossary_term' = 'Dependency Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'upcoming|in_progress|at_risk|achieved|missed|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notification Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` SET TAGS ('dbx_subdomain' = 'resource_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `base_camp_capacity` SET TAGS ('dbx_business_glossary_term' = 'Base Camp Capacity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Location Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Location Fee Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'scouted|approved|contracted|active|wrapped|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'practical_interior|practical_exterior|backlot|remote|international|studio_exterior');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `manager_notes` SET TAGS ('dbx_business_glossary_term' = 'Location Manager Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_business_glossary_term' = 'Noise Assessment');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `noise_assessment` SET TAGS ('dbx_value_regex' = 'quiet|moderate|noisy|unacceptable');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_authority` SET TAGS ('dbx_business_glossary_term' = 'Permit Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_business_glossary_term' = 'Power Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `power_availability` SET TAGS ('dbx_value_regex' = 'grid|generator_required|limited|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restoration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Restoration Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_business_glossary_term' = 'Restroom Facilities');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `restroom_facilities` SET TAGS ('dbx_value_regex' = 'on_site|portable_required|nearby|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `safety_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_value_regex' = 'not_assessed|in_progress|passed|failed|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `scout_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Scout Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `scout_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_business_glossary_term' = 'Water Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`location` ALTER COLUMN `water_availability` SET TAGS ('dbx_value_regex' = 'available|limited|trucked_in_required|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Transaction Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|credit_card|petty_cash|ach|payroll');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|cancelled|on_hold|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'pre_production|principal_photography|post_production|delivery|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Line Item Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase_order|vendor_invoice|petty_cash|payroll_charge|intercompany_allocation|credit_memo');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `insurance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `additional_insured_parties` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Parties');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Cancellation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Cancellation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `certificate_of_insurance_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Issued Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `claim_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim History Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `compliance_requirement_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Met Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `coverage_territory` SET TAGS ('dbx_business_glossary_term' = 'Coverage Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Deductible Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `exclusions_summary` SET TAGS ('dbx_business_glossary_term' = 'Policy Exclusions Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|partial|overdue|refunded');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `policy_document_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Document URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `policy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `policy_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'pending|active|expired|cancelled|suspended|renewed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `policy_term_days` SET TAGS ('dbx_business_glossary_term' = 'Policy Term Duration (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `prior_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `sap_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Policy Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Policy Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `total_claims_filed` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Filed Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `total_claims_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Paid Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `underwriter_name` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`insurance_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `production_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Production Clearance Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Clearance Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `attribution_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attribution Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `attribution_text` SET TAGS ('dbx_business_glossary_term' = 'Attribution Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `clearance_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `clearance_number` SET TAGS ('dbx_value_regex' = '^CLR-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|in_negotiation|cleared|denied|expired|revoked');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `clearance_type` SET TAGS ('dbx_business_glossary_term' = 'Clearance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Clearance Duration in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Clearance Fee in United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `ip_description` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `isrc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `isrc` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `iswc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Musical Work Code (ISWC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `iswc` SET TAGS ('dbx_value_regex' = '^T-[0-9]{9}-[0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `media_type_cleared` SET TAGS ('dbx_business_glossary_term' = 'Media Type Cleared');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Clearance Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Clearance Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `rights_holder_contact` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Contact Information');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `rights_holder_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `rights_holder_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `rightsline_clearance_reference` SET TAGS ('dbx_business_glossary_term' = 'Rightsline Clearance Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Object Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Clearance Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_clearance` ALTER COLUMN `usage_description` SET TAGS ('dbx_business_glossary_term' = 'Usage Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `format_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Format Spec Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `abr_profile` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Audio Bit Depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_value_regex' = 'mono|stereo|5.1|7.1|7.1.4|Atmos|immersive');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate (Kilohertz)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Color Bit Depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_value_regex' = 'ATSC|DVB|ISDB|NTSC|PAL|SECAM');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `chroma_subsampling` SET TAGS ('dbx_business_glossary_term' = 'Chroma Subsampling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `closed_caption_standard` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'Rec.601|Rec.709|Rec.2020|DCI-P3|Adobe_RGB');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `container_format` SET TAGS ('dbx_business_glossary_term' = 'Container Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `dalet_format_profile_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Format Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `drm_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Estimated File Size (Gigabytes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `format_status` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `format_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|deprecated|retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Format Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'capture|delivery|master|proxy|mezzanine|distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10_Plus|Dolby_Vision|HLG');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `is_default_format` SET TAGS ('dbx_business_glossary_term' = 'Is Default Format Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'SD|HD_720p|HD_1080i|HD_1080p|UHD_4K|UHD_8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `technical_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `timecode_format` SET TAGS ('dbx_business_glossary_term' = 'Timecode Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `timecode_format` SET TAGS ('dbx_value_regex' = 'drop_frame|non_drop_frame|PAL|film');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `video_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Video Bitrate (Megabits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`format_spec` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `rating_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Submission Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `compliance_content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `broadcast_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Clearance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `content_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Content Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `cuts_description` SET TAGS ('dbx_business_glossary_term' = 'Cuts Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `cuts_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cuts Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `distribution_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Distribution Clearance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `rating_authority` SET TAGS ('dbx_business_glossary_term' = 'Rating Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `rating_conditions` SET TAGS ('dbx_business_glossary_term' = 'Rating Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `submission_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `submission_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `submitted_content_title` SET TAGS ('dbx_business_glossary_term' = 'Submitted Content Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `submitted_content_version` SET TAGS ('dbx_business_glossary_term' = 'Submitted Content Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rating_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `daily_production_report_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Production Report (DPR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Dailies Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `previous_daily_production_report_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Daily Production Report Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `previous_daily_production_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Director ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `tertiary_daily_submitted_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `tertiary_daily_submitted_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `tertiary_daily_submitted_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `accidents_incidents_description` SET TAGS ('dbx_business_glossary_term' = 'Accidents or Incidents Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `accidents_incidents_flag` SET TAGS ('dbx_business_glossary_term' = 'Accidents or Incidents Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `ad_notes` SET TAGS ('dbx_business_glossary_term' = 'Assistant Director (AD) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `background_actors_count` SET TAGS ('dbx_business_glossary_term' = 'Background Actors Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Call Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `digital_media_consumed_tb` SET TAGS ('dbx_business_glossary_term' = 'Digital Media Consumed (Terabytes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `director_notes` SET TAGS ('dbx_business_glossary_term' = 'Director Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `film_stock_consumed_feet` SET TAGS ('dbx_business_glossary_term' = 'Film Stock Consumed (Feet)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `first_shot_time` SET TAGS ('dbx_business_glossary_term' = 'First Shot Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `last_shot_time` SET TAGS ('dbx_business_glossary_term' = 'Last Shot Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `meal_break_end` SET TAGS ('dbx_business_glossary_term' = 'Meal Break End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `meal_break_start` SET TAGS ('dbx_business_glossary_term' = 'Meal Break Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `meal_penalty_incurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Incurred Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `pages_shot` SET TAGS ('dbx_business_glossary_term' = 'Script Pages Shot');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `production_unit` SET TAGS ('dbx_value_regex' = 'main_unit|second_unit|splinter_unit|vfx_unit|stunt_unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Daily Production Report (DPR) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|revised');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Object ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `scenes_completed` SET TAGS ('dbx_business_glossary_term' = 'Scenes Completed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `setups_completed` SET TAGS ('dbx_business_glossary_term' = 'Setups Completed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `total_crew_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Crew Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`daily_production_report` ALTER COLUMN `wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Wrap Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `call_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Call Sheet ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `revised_call_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Call Sheet Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `revised_call_sheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `advance_schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Advance Schedule Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `base_camp_location` SET TAGS ('dbx_business_glossary_term' = 'Base Camp Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `call_sheet_number` SET TAGS ('dbx_business_glossary_term' = 'Call Sheet Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `call_sheet_status` SET TAGS ('dbx_business_glossary_term' = 'Call Sheet Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `call_sheet_status` SET TAGS ('dbx_value_regex' = 'draft|issued|revised|cancelled|completed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `cast_call_times` SET TAGS ('dbx_business_glossary_term' = 'Cast Call Times');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `cover_set_description` SET TAGS ('dbx_business_glossary_term' = 'Cover Set Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `department_call_times` SET TAGS ('dbx_business_glossary_term' = 'Department Call Times');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `director_name` SET TAGS ('dbx_business_glossary_term' = 'Director Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `estimated_wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Wrap Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `first_ad_name` SET TAGS ('dbx_business_glossary_term' = 'First Assistant Director (AD) Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `first_shot_time` SET TAGS ('dbx_business_glossary_term' = 'First Shot Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `general_crew_call_time` SET TAGS ('dbx_business_glossary_term' = 'General Crew Call Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `meal_times` SET TAGS ('dbx_business_glossary_term' = 'Meal Times');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `nearest_hospital` SET TAGS ('dbx_business_glossary_term' = 'Nearest Hospital');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `parking_instructions` SET TAGS ('dbx_business_glossary_term' = 'Parking Instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `production_unit` SET TAGS ('dbx_value_regex' = 'main_unit|second_unit|splinter_unit|vfx_unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `safety_notices` SET TAGS ('dbx_business_glossary_term' = 'Safety Notices');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `scene_descriptions` SET TAGS ('dbx_business_glossary_term' = 'Scene Descriptions');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `scene_numbers` SET TAGS ('dbx_business_glossary_term' = 'Scene Numbers');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `shoot_date` SET TAGS ('dbx_business_glossary_term' = 'Shoot Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `special_equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `weather_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Contingency Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`call_sheet` ALTER COLUMN `weather_forecast` SET TAGS ('dbx_business_glossary_term' = 'Weather Forecast');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` SET TAGS ('dbx_subdomain' = 'post_operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` SET TAGS ('dbx_association_edges' = 'production.production_episode,scheduling.schedule_slot');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `broadcast_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast - Broadcast Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast - Production Episode Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Window Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast - Schedule Slot Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `broadcast_date` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `broadcast_status` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `edit_type` SET TAGS ('dbx_business_glossary_term' = 'Edit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `repeat_number` SET TAGS ('dbx_business_glossary_term' = 'Repeat Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `transmission_version` SET TAGS ('dbx_business_glossary_term' = 'Transmission Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`broadcast` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` SET TAGS ('dbx_subdomain' = 'sponsorship_commercials');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` SET TAGS ('dbx_association_edges' = 'production.production_episode,advertising.sponsorship');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `episode_sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Sponsorship Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Sponsorship - Production Episode Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Sponsorship - Sponsorship Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Employee');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `episode_production_episode_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `actual_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `billboard_placement_timecode` SET TAGS ('dbx_business_glossary_term' = 'Billboard Placement Timecode');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Fulfillment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `logo_display_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Logo Display Duration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `makegood_reason` SET TAGS ('dbx_business_glossary_term' = 'Makegood Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `makegood_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Required Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Placement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `product_integration_scene_numbers` SET TAGS ('dbx_business_glossary_term' = 'Product Integration Scene References');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`episode_sponsorship` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` SET TAGS ('dbx_subdomain' = 'sponsorship_commercials');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` SET TAGS ('dbx_association_edges' = 'production.project,advertising.advertiser');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `project_sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Project Sponsorship Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `approval_rights_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Rights Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `co_production_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Agreement Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `deliverable_requirements` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `funding_percentage` SET TAGS ('dbx_business_glossary_term' = 'Funding Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `logo_placement_seconds` SET TAGS ('dbx_business_glossary_term' = 'Logo Placement Duration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `partnership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `partnership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `product_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Integration Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project_sponsorship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_day_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `rescheduled_shoot_day_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled Shoot Day Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `rescheduled_shoot_day_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Director Of Photography Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_first_assistant_director_employee_id` SET TAGS ('dbx_business_glossary_term' = 'First Assistant Director Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_first_assistant_director_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_first_assistant_director_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Call Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `dailies_delivered_flag` SET TAGS ('dbx_business_glossary_term' = 'Dailies Delivered Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `dailies_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dailies Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `footage_shot_minutes` SET TAGS ('dbx_business_glossary_term' = 'Footage Shot Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `is_overtime_incurred` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime Incurred');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `meal_penalty_count` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `safety_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incidents Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `scenes_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Scenes Completed Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `scenes_scheduled_count` SET TAGS ('dbx_business_glossary_term' = 'Scenes Scheduled Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `script_pages_completed` SET TAGS ('dbx_business_glossary_term' = 'Script Pages Completed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `script_pages_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Script Pages Scheduled');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_day_number` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_day_status` SET TAGS ('dbx_business_glossary_term' = 'Shoot Day Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Fahrenheit');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `total_cast_count` SET TAGS ('dbx_business_glossary_term' = 'Total Cast Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `total_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Total Crew Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `total_extras_count` SET TAGS ('dbx_business_glossary_term' = 'Total Extras Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `total_setups_count` SET TAGS ('dbx_business_glossary_term' = 'Total Setups Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Wrap Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_day` ALTER COLUMN `shoot_production_episode_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` SET TAGS ('dbx_subdomain' = 'resource_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `equipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Item Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `equipment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `parent_equipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Equipment Item Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `parent_equipment_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Condition');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `current_value` SET TAGS ('dbx_business_glossary_term' = 'Current Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `current_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `daily_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `daily_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `is_rental` SET TAGS ('dbx_business_glossary_term' = 'Is Rental');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `equipment_item_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `equipment_item_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `technical_specifications` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `total_usage_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Usage Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_item` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` SET TAGS ('dbx_subdomain' = 'resource_scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `equipment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `parent_equipment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Equipment Type Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `parent_equipment_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `average_lifespan_years` SET TAGS ('dbx_business_glossary_term' = 'Average Lifespan Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `equipment_type_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `compatible_accessories` SET TAGS ('dbx_business_glossary_term' = 'Compatible Accessories');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `daily_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `daily_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `equipment_type_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Dimensions');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `insurance_category` SET TAGS ('dbx_business_glossary_term' = 'Insurance Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `model_designation` SET TAGS ('dbx_business_glossary_term' = 'Model Designation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `power_requirements` SET TAGS ('dbx_business_glossary_term' = 'Power Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `requires_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Certification');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `requires_operator` SET TAGS ('dbx_business_glossary_term' = 'Requires Operator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `equipment_type_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `technical_specifications` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `transport_case_required` SET TAGS ('dbx_business_glossary_term' = 'Transport Case Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Type Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Type Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `weekly_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Weekly Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `weekly_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `workflow_integration` SET TAGS ('dbx_business_glossary_term' = 'Workflow Integration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`equipment_type` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `renewed_rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Rental Agreement Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `renewed_rental_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Url');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `damage_waiver_fee` SET TAGS ('dbx_business_glossary_term' = 'Damage Waiver Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `deposit_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Paid Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `estimated_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `late_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `rate_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rate Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `rental_description` SET TAGS ('dbx_business_glossary_term' = 'Rental Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `rental_type` SET TAGS ('dbx_business_glossary_term' = 'Rental Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `return_location` SET TAGS ('dbx_business_glossary_term' = 'Return Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`rental_agreement` ALTER COLUMN `special_terms` SET TAGS ('dbx_business_glossary_term' = 'Special Terms');
