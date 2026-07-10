-- Schema for Domain: production | Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`production` COMMENT 'Manages the end-to-end content production and post-production workflow — from greenlight and pre-production planning through principal photography, editing, VFX, color grading, audio mixing, transcoding, and final delivery. Tracks production budgets, crew assignments, shoot schedules, facility bookings, equipment allocation, and deliverable milestones. Integrates with Dalet Galaxy for ingest and workflow orchestration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Productions must operate under specific broadcast licenses for regulatory compliance, rights clearance, and distribution authorization. Essential for FCC compliance reporting and license renewal proce',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Projects are commissioned for specific broadcast channels/networks. Network commissioning process requires tracking which channel ordered the content. Essential for content planning, budget allocation',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Production projects are executed by or with external production companies (partners). Linking enables contract management, payment processing, co-production tracking, and rights negotiation. The `prod',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content licensing and syndication sales opportunities reference specific production projects to verify rights availability, establish cost basis for pricing, coordinate delivery schedules, and ensure ',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Productions are commissioned for specific streaming platforms (Netflix Originals, HBO Max Exclusives). Platform determines technical specs, content ratings, delivery windows. Real business process: pl',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Production projects are planned and budgeted against specific broadcast facilities for transmission/distribution. Real-world production planning requires facility assignment for capacity planning, tec',
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
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: A shoot schedule day is typically tied to filming a specific episode in a series production. Adding production_episode_id to shoot_schedule allows direct episode-level scheduling queries and links the',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this shoot schedule day belongs. Links the daily schedule to the overarching production entity.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: For live broadcasts (news, sports, live events), the shoot schedule must align with the program schedule air date/time. Production coordinators use this link to enforce on-air deadlines and coordinate',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: For live studio productions, the shoot schedule maps directly to the on-air schedule slot. Live production coordinators align shoot call times and wrap times with the slots planned_start_time and pla',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: A shoot schedule day references specific script scenes (captured in scene_numbers STRING). Adding script_id to shoot_schedule formalizes the relationship between the daily shooting schedule and the sc',
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
    `project_id` BIGINT COMMENT 'Reference to the parent production project this budget record belongs to. Links the financial control baseline to the production entity.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Production budgets allocate funds to satisfy specific regulatory obligations (captioning budget for FCC obligations, public file maintenance budget for inspection file obligations). Broadcasters track',
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
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the group reporting currency to which all amounts are translated for consolidated financial reporting (e.g., USD for a US-headquartered broadcaster).. Valid values are `^[A-Z]{3}$`',
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
    `budget_id` BIGINT COMMENT 'Reference to the parent production budget document that contains this line item. A production may have multiple budget versions (e.g., greenlight, revised, final).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Budget lines track advertiser-funded production costs for branded content and product integrations. Business process: advertiser co-production cost allocation, campaign-funded production expense track; FK references sales domain entity; namespace reconciled from advertising context',
    `partner_id` BIGINT COMMENT 'Reference to the vendor, supplier, or payee associated with this budget line item (e.g., VFX house, location owner, equipment rental company, music licensor).',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Budget lines can be episode-specific in series productions (e.g., VFX costs for Episode 3). budget_line already has a cross-domain content_episode_id → content.content_episode, but a direct in-domain ',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this budget line belongs. Links the line item to its overarching production context.',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Residuals budgeting process: budget lines for SAG/WGA residuals and talent royalties are calculated directly from royalty rules. Finance teams must link each royalty cost line to its governing royalty',
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
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Crew members often work through loan-out companies or talent agencies (partners). Linking enables tracking all crew supplied by that partner, payment processing to the loan-out entity, union/guild com',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Crew can be assigned to specific episodes within a series production. Optional FK (nullable) — crew may be assigned at project level or episode level. Enables episode-specific crew tracking for episod',
    `project_id` BIGINT COMMENT 'Reference to the production project to which this crew member is assigned. Links the assignment to the master production record.',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Crew assignments are made for specific shoot days — a crew members call time, turnaround hours, and meal penalty eligibility are all tied to a specific shoot schedule day. Adding shoot_schedule_id to',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` (
    `production_episode_id` BIGINT COMMENT 'Unique surrogate identifier for the production episode record in the lakehouse Silver layer. Serves as the primary key for all downstream joins and lineage tracking.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Episodes must satisfy specific accessibility obligations based on air date, daypart, and network (prime-time episodes require FCC captioning, childrens episodes require CVAA descriptive video). Broad',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Episodes are produced under specific broadcast licenses (local news episode authorized by station license, network show references originating station license). Broadcasters track which license covers',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Episodes require content ratings before broadcast/distribution. Core regulatory workflow linking production output to compliance certification. Drives scheduling decisions and parental control metadat',
    `content_episode_id` BIGINT COMMENT '',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Each production episode is mastered to a specific delivery channels technical specifications (resolution, audio format, aspect ratio, bitrate). Operations teams use this link to pull channel delivery',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Episode-level rights grant tracking: each production episode is produced to fulfill a specific exploitation rights grant (theatrical, SVOD, broadcast). This link supports residuals calculation, exploi',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Individual episodes may require COPPA declarations independent of project-level status when content varies by episode. Essential for mixed-audience series with occasional child-directed episodes.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project (series, mini-series, anthology, or episodic documentary) to which this episode belongs. Establishes the episode-to-project hierarchy.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Episodes trigger specific regulatory filings (childrens programming reports reference specific episodes, political programming disclosures reference candidate appearances, quarterly programming repor',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: Episodes are based on specific scripts. Strong content relationship — script is the source document for episode production. FK links episode to the locked script version used for production.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Episodes may have product placement, sponsorship integrations, or branded content campaigns. Broadcasting requires tracking sponsorship obligations, disclosure requirements, and campaign-specific cont',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Episodes are designated as sweeps programming (stunting) for specific sweeps periods. Programming and production teams track which episodes are slated for sweeps to coordinate scheduling, ratings stra',
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
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Each TV episode script maps to a specific content episode for WGA registration, script lock tracking, and revision management per episode. script→title exists but does not identify the episode. Produc',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode to which this script belongs.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Scripts must comply with specific regulatory obligations (FCC indecency rules, COPPA childrens programming requirements, political content disclosure rules). Broadcasters track which obligations appl',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Scripts are often based on underlying IP owned by rights holders (novels, plays, life rights, true stories, existing franchises). Real business need: tracking the rights holder of the underlying IP be',
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
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Specific post-production tasks implement accessibility obligations (closed captioning task satisfies FCC captioning obligation, audio description task satisfies CVAA obligation). Broadcasters track wh',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to production.budget_line. Business justification: Post-production tasks incur costs (estimated_cost_amount, actual_cost_amount on the task record) that should be traceable to a specific budget line for financial control. Adding budget_line_id to post',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Post-production tasks create campaign-specific deliverables: promotional cuts, trailers, teasers, social media clips, advertiser-approved versions. Workflow management requires linking tasks to the ca',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: Post-production clearance tracking: post-production tasks involving music sync, archive footage, VFX stock elements, and third-party content require rights clearance. Linking post_production_task to c',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Post-production tasks (editing, color, audio mix) create specific content versions. Critical for tracking which production tasks generated which distributable versions, version lineage, and linking pr',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: Post-production tasks produce deliverables. Optional FK (nullable) — not all tasks produce final deliverables (intermediate tasks). When populated, links task output to contractual/operational deliver',
    `parent_task_post_production_task_id` BIGINT COMMENT 'Reference to the parent post-production task if this task is a sub-task or dependent task in a hierarchical workflow.',
    `partner_id` BIGINT COMMENT 'Reference to the external vendor or post-production facility assigned to perform this task, if outsourced.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.vfx_shot. Business justification: VFX-specific post-production tasks (compositing, rendering, etc.) are shot-specific. Optional FK (nullable) — only VFX tasks populate this. Enables linking Dalet workflow tasks to VFX shot tracking.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project that this post-production task belongs to.',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: Post-production tasks reference scripts for scene/dialogue context. Optional FK (nullable) — provides editorial context for tasks. Enables linking task to script version for continuity.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` (
    `deliverable_id` BIGINT COMMENT 'Unique identifier for the production deliverable. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Deliverables must comply with specific accessibility obligations (closed captioning, audio description, emergency information access) based on distribution channel and regulatory jurisdiction.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Production deliverables include promotional spots, trailers, branded content, and campaign-specific cuts created for advertising campaigns. Trafficking and delivery workflows require tracking which ca',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Deliverables must be encoded using specific encoder configurations to meet platform technical requirements. Real-world delivery workflows track which encoder profile was used for compliance verificati',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Deliverables must track closed captioning compliance for FCC accessibility regulations. Required for broadcast clearance and public inspection file documentation.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Deliverables must reference their content rating for distribution compliance verification. Required for platform submission, broadcast clearance, and international distribution workflows.',
    `content_delivery_order_id` BIGINT COMMENT 'Foreign key linking to distribution.content_delivery_order. Business justification: Deliverables fulfill specific content delivery orders to distribution partners. Real business process: fulfillment tracking, delivery confirmation, and partner order management.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Deliverables are physically routed to a specific delivery channel (FAST, linear, SVOD, MVPD). Media ops teams track which delivery channel each deliverable targets to enforce format specs, SLA deadlin',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Rights clearance for delivery: each deliverable fulfills a specific rights grant (e.g., SVOD North America, linear broadcast UK). Linking deliverable to grant enables rights clearance verification bef',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Deliverables can be episode-specific (e.g., episodic masters for series). Optional FK (nullable) — deliverables may be project-level or episode-level. Enables episode-specific deliverable tracking.',
    `project_id` BIGINT COMMENT 'Reference to the parent production project that this deliverable belongs to.',
    `program_rundown_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_rundown. Business justification: For live and news productions, deliverables (packages, VOs, pre-produced segments) are assigned to specific program rundowns. The rundown defines the segments position and timing. Production and traf',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Deliverables have hard due dates driven by the program schedule air date. Traffic and operations teams track deliverable receipt against program schedule to confirm on-air readiness. This link drives ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Deliverables are sent to distribution partners, broadcasters, streaming platforms, and licensees. Linking enables delivery obligation tracking, SLA compliance monitoring, acceptance workflow managemen',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Deliverables must meet specific regulatory obligations before distribution. Links delivery workflow to compliance verification for broadcast standards, platform requirements, and international regulat',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Deliverables are formatted for specific platforms with platform-specific technical requirements (resolution, codec, DRM). Real business process: platform-specific asset preparation, transcoding, and d',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Territory-specific delivery specification: deliverables are prepared per territory (PAL/NTSC format, subtitle language, content rating compliance, DRM requirements). Operations teams require a direct ',
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
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: QC reviews verify closed captioning accuracy, synchronization, and completeness against FCC standards. Direct operational link between quality control and accessibility compliance verification.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: QC reviews validate specific content versions for distribution. Essential for version-level quality tracking, linking production QC to content version records, and ensuring only QC-passed versions are',
    `deliverable_id` BIGINT COMMENT 'Reference to the production deliverable or post-production output being reviewed.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: QC reviews are performed against delivery channel-specific technical specifications (loudness standards, resolution requirements, closed caption formats differ between linear broadcast, OTT, and FAST ',
    `delivery_obligation_id` BIGINT COMMENT 'Foreign key linking to partner.delivery_obligation. Business justification: QC reviews validate deliverables against partner technical specifications defined in delivery obligations (resolution, codec, audio channels, closed captions). QC pass/fail status determines obligatio',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Rights-compliant QC verification: QC reviews validate that content meets grant-specific technical requirements (DRM enforcement, resolution caps, language versions, run count limits). Rights and QC te',
    `post_production_task_id` BIGINT COMMENT 'Foreign key linking to production.post_production_task. Business justification: QC reviews are performed on post-production task outputs. Optional FK (nullable) — QC may be on final deliverables or intermediate task outputs. When populated, links QC review to the specific Dalet w',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: QC reviews are performed on episode-level deliverables and post-production outputs. While qc_review links to deliverable and post_production_task (which link to production_episode), a direct productio',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this QC review belongs to.',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: QC certification is window-specific: theatrical DCP, SVOD H.264, and linear broadcast each have distinct loudness, resolution, and accessibility compliance requirements. QC managers track which releas',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: QC reviews must be completed before the scheduled air slot. Operations teams track QC pass/fail status against the slots broadcast date to confirm on-air clearance. This link drives QC deadline manag',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: QC failures that violate broadcast standards, accessibility requirements, or content ratings trigger compliance incidents. Links quality control to incident management and corrective action workflows.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Primary key for milestone',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: Milestones in production are frequently tied to specific deliverables (e.g., Picture Lock, Final Delivery, QC Pass milestones reference a specific deliverable). Adding deliverable_id normalizes ',
    `predecessor_milestone_id` BIGINT COMMENT 'Reference to another milestone that must be completed before this milestone can begin or be achieved.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Milestones can be episode-specific (e.g., picture lock for episode 3). Optional FK (nullable) — milestones may be project-level or episode-level. Enables episode-specific milestone tracking for episod',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode for which this milestone is tracked.',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Production milestones (picture lock, audio mix complete, QC pass, delivery) are contractually tied to release window open dates. Missing a milestone triggers window date slippage and contractual penal',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-level milestones (season premiere delivery, season finale picture lock, season delivery to affiliate) are a core broadcast production tracking concept. milestone→title exists but season is the ',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Production milestones (picture lock, delivery, air-ready) are explicitly scheduled around sweeps periods. Production management teams set critical-path milestones to meet sweeps air dates. This named ',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` (
    `cost_transaction_id` BIGINT COMMENT 'Primary key for cost_transaction',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Costs incurred for accessibility compliance (captioning vendor invoices, audio description production costs) must be tracked against specific accessibility obligations for regulatory cost reporting, t',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Every production cost transaction must be assigned to a cost center for GL posting, reconciliation, and audit trail. Mandatory for SAP integration and financial statement preparation. Replaces denorma',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to production.budget_line. Business justification: Cost transactions are posted against specific budget line items. Currently uses budget_line_reference (STRING) — replacing with FK to budget_line.budget_line_id provides referential integrity and enab',
    `partner_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom goods or services were procured, if applicable.',
    `budget_id` BIGINT COMMENT 'Reference to the specific budget line or cost object this transaction is charged against.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Cost transactions (vendor invoices, POs, payroll) are often incurred at the episode level in series production. Adding production_episode_id enables direct episode-level cost reporting and actuals tra',
    `project_id` BIGINT COMMENT 'Reference to the production project against which this cost transaction is posted.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Production cost transactions generate or reference journal entries in the financial GL. Required for reconciliation between production spend tracking and financial ledger, mandatory for month-end clos',
    `royalty_statement_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_statement. Business justification: Royalty payment reconciliation: actual royalty payments posted as cost transactions in SAP must be reconciled against issued royalty statements. This link enables finance and rights teams to match pay',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Cost transactions are frequently incurred on specific shoot days — location fees, catering, equipment rentals, and overtime costs are all tied to a specific shoot date. Adding shoot_schedule_id to cos',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_parent_task_post_production_task_id` FOREIGN KEY (`parent_task_post_production_task_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`post_production_task`(`post_production_task_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_post_production_task_id` FOREIGN KEY (`post_production_task_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`post_production_task`(`post_production_task_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_predecessor_milestone_id` FOREIGN KEY (`predecessor_milestone_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`shoot_schedule`(`shoot_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Production Company Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor / Payee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Out Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Rights Holder Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_business_glossary_term' = 'Scene Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_business_glossary_term' = 'Script Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_business_glossary_term' = 'Script Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_value_regex' = 'draft|in review|approved|locked|archived|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Script Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Writers Guild of America (WGA) Registration Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `writer_credits` SET TAGS ('dbx_business_glossary_term' = 'Writer Credits');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Task Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `parent_task_post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Task Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Vendor Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Vfx Shot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`post_production_task` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Encoder Config Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_business_glossary_term' = 'Program Rundown Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` SET TAGS ('dbx_subdomain' = 'content_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `delivery_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `post_production_task_id` SET TAGS ('dbx_business_glossary_term' = 'Post Production Task Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Transaction Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
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
