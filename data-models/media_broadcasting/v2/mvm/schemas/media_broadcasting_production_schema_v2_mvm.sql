-- Schema for Domain: production | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`production` COMMENT 'Manages the end-to-end content production and post-production workflow — from greenlight and pre-production planning through principal photography, editing, VFX, color grading, audio mixing, transcoding, and final delivery. Tracks production budgets, crew assignments, shoot schedules, facility bookings, equipment allocation, and deliverable milestones. Integrates with Dalet Galaxy for ingest and workflow orchestration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project | Column project_id (BIGINT) in production.project',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Projects are commissioned for specific broadcast channels/networks. Network commissioning process requires tracking which channel ordered the content. Essential for content planning, budget allocation | Column channel_id (BIGINT) in scheduling.project',
    `deal_id` BIGINT COMMENT 'Foreign key linking to distribution.deal. Business justification: Production projects are greenlit against specific distribution deals (e.g., a streaming platform commissions a series). The deal defines content scope, territory, and revenue model that drives the pro',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Projects often have master license agreements governing distribution rights (co-production deals, pre-sales, output deals). Real business need: tracking which license agreements fund or govern a produ | Column master_license_agreement_id (BIGINT) in rights.project',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: A production project maps to a specific season for season-level budget approval, greenlight reporting, and rights clearance. project.season_number is a denormalized plain attribute; replacing with FK ',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series production tracking and greenlight decisions require linking a production project to its parent content series. Enables series-level budget rollup, rights management, and production portfolio r',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Greenlight and development decisions in media broadcasting explicitly target a demographic segment (e.g., A18-49, W25-54). This FK enables greenlight committee reporting, sales alignment, and content ',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Productions are commissioned for specific streaming platforms (Netflix Originals, HBO Max Exclusives). Platform determines technical specs, content ratings, delivery windows. Real business process: pl | Column target_ott_platform_id (BIGINT) in distribution.project',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.project',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.project',
    `actual_delivery_date` DATE COMMENT 'Date on which the final deliverable was actually delivered to the distribution or broadcast platform. Compared against target_delivery_date to measure on-time delivery performance and SLA compliance. | Column actual_delivery_date (DATE) in production.project',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred against this production project to date, denominated in US Dollars. Sourced from SAP S/4HANA cost postings. Compared against approved_budget_usd for variance and financial reconciliation reporting. | Column actual_spend_usd (DECIMAL(18,2)) in production.project',
    `approved_budget_usd` DECIMAL(18,2) COMMENT 'Total production budget formally approved at greenlight, denominated in US Dollars. Represents the authorized spend ceiling for the project. Used for financial controlling, variance analysis, and EBITDA reporting in SAP S/4HANA. | Column approved_budget_usd (DECIMAL(18,2)) in production.project',
    `co_production_flag` BOOLEAN COMMENT 'Indicates whether this production project is a co-production involving one or more external production partners. Triggers co-production agreement workflows, shared rights structures, and split budget reporting in SAP S/4HANA. | Column co_production_flag (BOOLEAN) in production.project',
    `content_genre` STRING COMMENT 'Primary genre classification of the content being produced (e.g., drama, comedy, thriller, sports, news, reality). Used for audience targeting, scheduling, advertising sales, and rights windowing strategies. [ENUM-REF-CANDIDATE: drama|comedy|thriller|action|documentary|news|reality|sports|animation|horror — promote to reference product] | Column content_genre (STRING) in production.project',
    `content_rating` STRING COMMENT 'Official content rating assigned by the Motion Picture Association (MPA) or TV Parental Guidelines system. Governs broadcast scheduling, advertising eligibility, and platform distribution restrictions including COPPA compliance for childrens content. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product] | Column content_rating (STRING) in production.project',
    `coppa_applicable` BOOLEAN COMMENT 'Indicates whether this production is directed at children under 13 and therefore subject to COPPA compliance requirements. Affects data collection practices, advertising eligibility, and platform distribution restrictions. | Column coppa_applicable (BOOLEAN) in production.project',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.project',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production project record was first created in the lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage tracking. | Column created_timestamp (TIMESTAMP) in production.project',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget and spend amounts recorded on this project (e.g., USD, GBP, EUR). Supports multi-currency production environments for international co-productions. | Column currency_code (STRING) in production.project. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'Integration reference identifier linking this production project to its corresponding workflow instance in Dalet Galaxy Media Asset Management and Workflow Orchestration system. Enables cross-system traceability for ingest, metadata, archive, and workflow operations. | Column dalet_workflow_reference (STRING) in production.project',
    `drm_required` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection must be applied to the delivered content assets. Drives technical delivery specifications for CDN, streaming platform configuration, and Akamai CDN security settings. | Column drm_required (BOOLEAN) in production.project',
    `eidr` STRING COMMENT 'Entertainment Identifier Registry (EIDR) identifier for this content project. Provides a universal, persistent identifier for the title across supply chain partners, distributors, and platforms. | Column eidr (STRING) in production.project. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$`',
    `episode_count` STRING COMMENT 'Total number of episodes commissioned for this production project. Applicable to scripted and unscripted series. Used for budget modeling, scheduling, and rights licensing calculations. Null for single-title formats such as feature films. | Column episode_count (INT) in production.project',
    `fcc_license_required` BOOLEAN COMMENT 'Indicates whether this production requires FCC broadcast licensing compliance review prior to linear broadcast distribution. Applicable to content intended for over-the-air or cable transmission in the United States. | Column fcc_license_required (BOOLEAN) in production.project',
    `greenlight_date` DATE COMMENT 'Calendar date on which the production project received formal executive greenlight approval. Marks the official start of the production lifecycle and triggers budget release and resource mobilization. | Column greenlight_date (DATE) in production.project',
    `greenlight_status` STRING COMMENT 'Executive approval status of the production project. Indicates whether the project has received formal greenlight authorization to proceed, is pending approval, is on hold, or has been cancelled. Controls budget release and resource mobilization. | Column greenlight_status (STRING) in production.project. Valid values are `pending|greenlighted|on_hold|cancelled|completed`',
    `isan` STRING COMMENT 'Globally unique identifier assigned to this audiovisual work under the International Standard Audiovisual Number (ISAN) standard (ISO 15706). Used for rights management, royalty tracking, and cross-platform content identification. | Column isan (STRING) in production.project. Valid values are `^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `original_ip_flag` BOOLEAN COMMENT 'Indicates whether this production is based on original intellectual property owned by the organization, as opposed to licensed or adapted IP. Affects rights ownership, residuals obligations, and long-term asset valuation. | Column original_ip_flag (BOOLEAN) in production.project',
    `post_production_start_date` DATE COMMENT 'Scheduled or actual date on which post-production activities commenced, including editing, VFX, color grading, audio mixing, and transcoding. Used for facility booking and deliverable milestone planning. | Column post_production_start_date (DATE) in production.project',
    `pre_production_start_date` DATE COMMENT 'Scheduled or actual date on which pre-production activities commenced, including casting, location scouting, script breakdown, and crew hiring. Used for production planning and milestone tracking. | Column pre_production_start_date (DATE) in production.project',
    `primary_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code for the primary language in which the content is produced (e.g., en, es, fr). Drives localization, dubbing, subtitling, and distribution territory planning. | Column primary_language (STRING) in production.project. Valid values are `^[a-z]{2,3}$`',
    `principal_photography_end_date` DATE COMMENT 'Scheduled or actual date on which principal photography concluded (picture wrap). Triggers transition to post-production phase and initiates post-production resource scheduling. | Column principal_photography_end_date (DATE) in production.project',
    `principal_photography_start_date` DATE COMMENT 'Scheduled or actual date on which principal photography (primary filming) commenced. A key production milestone used for crew scheduling, facility booking, and insurance activation. | Column principal_photography_start_date (DATE) in production.project',
    `production_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country in which the production is being executed. Determines applicable regulatory frameworks, tax incentive eligibility, and co-production treaty benefits. | Column production_country (STRING) in production.project. Valid values are `^[A-Z]{3}$`',
    `production_format` STRING COMMENT 'Primary technical production format and resolution specification (e.g., 4K UHD, HD 1080p, HDR10). Determines post-production pipeline, transcoding requirements, and delivery specifications for broadcast and streaming platforms. [ENUM-REF-CANDIDATE: 4K_UHD|HD_1080p|HD_720p|SD|HDR10|Dolby_Vision|IMAX — 7 candidates stripped; promote to reference product] | Column production_format (STRING) in production.project',
    `production_phase` STRING COMMENT 'Current phase of the content production lifecycle. Tracks the projects progression from development through delivery. Used to gate workflow steps, resource allocation, and financial milestone releases. | Column production_phase (STRING) in production.project. Valid values are `development|pre_production|principal_photography|post_production|delivery|archived`',
    `project_type` STRING COMMENT 'Classification of the content production project by format and genre category. Drives production workflow templates, budget models, rights structures, and scheduling logic. [ENUM-REF-CANDIDATE: scripted_series|feature_film|documentary|live_event|news_segment|unscripted_series|short_form — promote to reference product] | Column project_type (STRING) in production.project',
    `sap_wbs_element` STRING COMMENT 'SAP S/4HANA Work Breakdown Structure element code that maps this production project to the enterprise financial controlling hierarchy for budget tracking, cost allocation, and financial reconciliation. | Column sap_wbs_element (STRING) in production.project',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.project',
    `synopsis` STRING COMMENT 'Short narrative description of the content production projects story, subject matter, or editorial concept. Used for internal greenlight documentation, sales pitches, EPG metadata, and Dalet Galaxy asset metadata. | Column synopsis (STRING) in production.project',
    `target_delivery_date` DATE COMMENT 'Contractually committed or internally planned date by which the finished content must be delivered to distribution, broadcast, or streaming platforms. Drives post-production scheduling, windowing strategy, and SLA compliance. | Column target_delivery_date (DATE) in production.project',
    `total_runtime_minutes` STRING COMMENT 'Total planned or delivered runtime of the production in minutes. For series, this is the aggregate runtime across all episodes. Used for scheduling, licensing, and royalty calculations. | Column total_runtime_minutes (INT) in production.project',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.project',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this production project record was most recently modified in the lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, incremental processing, and audit compliance. | Column updated_timestamp (TIMESTAMP) in production.project',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master record for a content production project — the greenlit initiative that drives all production activity. Captures the project title, type (scripted series, feature film, documentary, live event, news segment), greenlight status, production phase (development, pre-production, principal photography, post-production, delivery), approved budget, actual spend, production company, showrunner or executive producer, target delivery date, ISAN identifier, and integration reference to Dalet Galaxy workflow. This is the top-level anchor entity for the entire production domain. | Unity Catalog table: media_broadcasting_ecm.production.project';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`budget` (
    `budget_id` BIGINT COMMENT 'Primary key for budget | Column budget_id (BIGINT) in production.budget',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this budget record belongs to. Links the financial control baseline to the production entity. | Column production_project_id (BIGINT) in production.budget',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.budget',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.budget',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Cumulative actual costs incurred to date for this cost category, sourced from SAP S/4HANA FI/CO actual postings. Represents real expenditure against the approved budget. | Column actual_cost_amount (DECIMAL(18,2)) in production.budget',
    `approval_status` STRING COMMENT 'Current workflow approval status of this budget record. DRAFT = in preparation; PENDING_APPROVAL = submitted for sign-off; APPROVED = formally authorized; REJECTED = returned for revision; LOCKED = frozen for actuals comparison; CLOSED = production complete. | Column approval_status (STRING) in production.budget. Valid values are `DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|LOCKED|CLOSED`',
    `approved_amount` DECIMAL(18,2) COMMENT 'The formally approved budget amount for this cost category and version, representing the financial control baseline authorized by the production greenlight committee. | Column approved_amount (DECIMAL(18,2)) in production.budget',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget version was formally approved by the authorized signatory. Null if not yet approved. | Column approved_timestamp (TIMESTAMP) in production.budget',
    `change_reason` STRING COMMENT 'Free-text narrative explaining the business justification for a budget revision (e.g., Schedule extension due to weather delays, Additional VFX shots approved by director). Mandatory for revised versions. | Column change_reason (STRING) in production.budget',
    `change_request_reference` STRING COMMENT 'Reference number of the formal budget change request (BCR) document that authorized a revision to this budget line, traceable in the production finance approval workflow. | Column change_request_reference (STRING) in production.budget',
    `budget_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this budget record within the production finance system. Used for cross-system reference and reporting. | Column budget_code (STRING) in production.budget. Valid values are `^[A-Z0-9-]{4,20}$`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of open purchase order commitments (obligations) for this cost category that have been raised but not yet invoiced. Represents encumbered funds in the SAP MM/CO commitment ledger. | Column committed_amount (DECIMAL(18,2)) in production.budget',
    `contingency_amount` DECIMAL(18,2) COMMENT 'The absolute monetary value of the contingency reserve allocated for this cost category, derived from the contingency percentage applied to the approved budget amount. | Column contingency_amount (DECIMAL(18,2)) in production.budget',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The percentage of the approved budget allocated as contingency reserve for this cost category, representing the risk buffer approved by the production finance committee. | Column contingency_percentage (DECIMAL(5,2)) in production.budget',
    `cost_category_code` STRING COMMENT 'SAP cost element or cost category code classifying the type of production expenditure (e.g., ATL-TALENT, BTL-CREW, BTL-EQUIPMENT, POST-VFX, POST-AUDIO). [ENUM-REF-CANDIDATE: ATL-TALENT|ATL-RIGHTS|BTL-CREW|BTL-EQUIPMENT|BTL-FACILITIES|BTL-TRAVEL|POST-VFX|POST-AUDIO|POST-COLOR|CONTINGENCY — promote to reference product] | Column cost_category_code (STRING) in production.budget',
    `cost_category_name` STRING COMMENT 'Human-readable name of the production cost category (e.g., Above-the-Line Talent, Below-the-Line Crew, Visual Effects, Audio Post-Production). | Column cost_category_name (STRING) in production.budget',
    `cost_line_type` STRING COMMENT 'High-level classification of the cost line distinguishing above-the-line (ATL) creative costs (writers, directors, producers, talent) from below-the-line (BTL) technical and crew costs, post-production, contingency, and overhead. | Column cost_line_type (STRING) in production.budget. Valid values are `ABOVE_THE_LINE|BELOW_THE_LINE|POST_PRODUCTION|CONTINGENCY|OVERHEAD`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.budget',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the source system or ingested into the Databricks Silver Layer. Supports audit trail and data lineage. | Column created_timestamp (TIMESTAMP) in production.budget',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this budget record are denominated (e.g., USD, GBP, EUR). | Column currency_code (STRING) in production.budget. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert this budget records currency to the productions reporting currency at the time of budget approval or revision. | Column exchange_rate (DECIMAL(12,6)) in production.budget',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number 1–12 or 1–16 for special periods) within the fiscal year to which this budget line is assigned in SAP CO. | Column fiscal_period (INT) in production.budget',
    `fiscal_year` STRING COMMENT 'The four-digit fiscal year to which this budget record belongs in the SAP S/4HANA CO controlling area, used for annual financial planning and SOX reporting. | Column fiscal_year (INT) in production.budget',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Latest estimate of the total cost expected to be incurred for this cost category by production completion, incorporating actuals to date and projected remaining spend. | Column forecast_amount (DECIMAL(18,2)) in production.budget',
    `is_greenlight_budget` BOOLEAN COMMENT 'Indicates whether this budget record represents the original greenlight-approved budget for the production, as distinct from subsequent revisions. The greenlight budget is the primary financial authorization baseline. | Column is_greenlight_budget (BOOLEAN) in production.budget',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this budget version has been locked and is no longer open for modification. A locked budget serves as the immutable financial baseline for variance reporting. | Column is_locked (BOOLEAN) in production.budget',
    `notes` STRING COMMENT 'Free-text field for additional commentary, assumptions, or clarifications associated with this budget record, entered by the production finance team. | Column notes (STRING) in production.budget',
    `period_end_date` DATE COMMENT 'The end date of the fiscal or production period covered by this budget record. Defines the temporal boundary for cost accumulation and variance measurement. | Column period_end_date (DATE) in production.budget',
    `period_start_date` DATE COMMENT 'The start date of the fiscal or production period covered by this budget record, aligning to the SAP fiscal year/period structure. | Column period_start_date (DATE) in production.budget',
    `production_phase` STRING COMMENT 'The production lifecycle phase to which this budget line is attributed (e.g., Development, Pre-Production, Principal Photography, Post-Production, Delivery). Enables phase-level budget tracking. | Column production_phase (STRING) in production.budget. Valid values are `DEVELOPMENT|PRE_PRODUCTION|PRINCIPAL_PHOTOGRAPHY|POST_PRODUCTION|DELIVERY|CLOSED`',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the group reporting currency to which all amounts are translated for consolidated financial reporting (e.g., USD for a US-headquartered broadcaster). | Column reporting_currency_code (STRING) in production.budget. Valid values are `^[A-Z]{3}$`',
    `revised_amount` DECIMAL(18,2) COMMENT 'The most recently revised budget amount for this cost category following a formal budget change request. Null if no revision has been approved since the original budget. | Column revised_amount (DECIMAL(18,2)) in production.budget',
    `sap_cost_object_code` STRING COMMENT 'The SAP S/4HANA CO cost object identifier (Internal Order number or WBS Element ID) that anchors this budget record to the controlling module for financial reconciliation. | Column sap_cost_object_code (STRING) in production.budget',
    `sap_wbs_element` STRING COMMENT 'SAP Project System Work Breakdown Structure element code that maps this budget line to a specific phase or deliverable within the production project hierarchy (e.g., PRE-PROD, PRINCIPAL, POST-PROD). | Column sap_wbs_element (STRING) in production.budget',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.budget',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.budget',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this budget record in the source system or Silver Layer. Used for incremental load detection and change data capture. | Column updated_timestamp (TIMESTAMP) in production.budget',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the approved (or revised) budget amount and the sum of actual costs plus commitments. A negative value indicates an over-budget condition; positive indicates underspend. | Column variance_amount (DECIMAL(18,2)) in production.budget',
    `version` STRING COMMENT 'Version label of this budget record, distinguishing the original greenlight budget from subsequent revisions and the locked final version. Supports budget version history tracking. | Column version (STRING) in production.budget. Valid values are `ORIGINAL|REVISED_1|REVISED_2|REVISED_3|FINAL|LOCKED`',
    `version_number` STRING COMMENT 'Sequential integer version number of this budget record (e.g., 1 = original, 2 = first revision). Enables ordered version history and audit trail. | Column version_number (INT) in production.budget',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Detailed production budget record aligned to the SAP S/4HANA CO (Controlling) module. Captures above-the-line and below-the-line cost categories, approved budget amounts by cost category, revised budget amounts, actual costs to date, purchase order commitments, variance amounts, currency, budget version, and approval status. Serves as the financial control baseline for a production project. Links to SAP cost centers and WBS elements for financial reconciliation. | Unity Catalog table: media_broadcasting_ecm.production.budget';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual budget line item within a production budget. Primary key for this entity. | Column budget_line_id (BIGINT) in production.budget_line',
    `budget_id` BIGINT COMMENT 'Reference to the parent production budget document that contains this line item. A production may have multiple budget versions (e.g., greenlight, revised, final). | Column budget_id (BIGINT) in production.budget_line',
    `content_episode_id` BIGINT COMMENT 'Reference to the specific episode or segment to which this budget line is allocated. Null for series-level or film-level lines that are not episode-specific. | Column content_episode_id (BIGINT) in content.budget_line',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Above-the-line budget lines (is_above_the_line flag) map directly to talent contracts for cost reconciliation and SAG-AFTRA/DGA compliance reporting. Finance teams must reconcile each talent cost line',
    `project_id` BIGINT COMMENT 'Reference to the parent production project to which this budget line belongs. Links the line item to its overarching production context. | Column production_project_id (BIGINT) in production.budget_line',
    `sales_campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Budget lines track advertiser-funded production costs for branded content and product integrations. Business process: advertiser co-production cost allocation, campaign-funded production expense track | Column campaign_id (BIGINT) in sales.budget_line',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.budget_line',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.budget_line',
    `account_code` STRING COMMENT 'Industry-standard production account code identifying the cost category within the budget (e.g., 1100 for Above-the-Line Talent, 2200 for Camera Equipment). Follows standard production accounting chart of accounts (e.g., AICP, Producers Guild). | Column account_code (STRING) in production.budget_line. Valid values are `^[A-Z0-9]{2,10}$`',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Costs accrued for work performed or services received but not yet invoiced or formally committed. Supports period-end financial close and accurate cost-to-complete reporting. | Column accrued_amount (DECIMAL(18,2)) in production.budget_line',
    `actual_amount` DECIMAL(18,2) COMMENT 'Total actual costs incurred and posted against this budget line to date, sourced from SAP FI invoice postings and payroll actuals. Used for variance analysis against budgeted and committed amounts. | Column actual_amount (DECIMAL(18,2)) in production.budget_line',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line was formally approved by the authorized approver. Provides an audit trail for financial governance and SOX compliance. | Column approved_timestamp (TIMESTAMP) in production.budget_line',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'Original approved budget amount for this line item as established at greenlight or budget approval. Represents the planned cost baseline against which actuals and commitments are measured. | Column budgeted_amount (DECIMAL(18,2)) in production.budget_line',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of purchase orders, contracts, or binding agreements raised against this budget line but not yet invoiced. Represents financial obligations that reduce available budget. | Column committed_amount (DECIMAL(18,2)) in production.budget_line',
    `contingency_pct` DECIMAL(18,2) COMMENT 'Contingency percentage applied to this budget line to cover unforeseen cost overruns. Typically 5–15% for production lines. Contributes to the overall production contingency reserve. | Column contingency_pct (DECIMAL(7,4)) in production.budget_line',
    `cost_category` STRING COMMENT 'High-level cost category classifying the budget line within the production budget structure. Above-the-line covers creative talent (writers, directors, producers, cast); below-the-line covers crew, equipment, locations, and production services. [ENUM-REF-CANDIDATE: above_the_line|below_the_line|post_production|music_licensing|vfx|marketing|overhead|contingency|insurance|legal — promote to reference product] | Column cost_category (STRING) in production.budget_line',
    `cost_sub_category` STRING COMMENT 'Granular sub-classification within the cost category (e.g., Cast Fees, Location Fees, Equipment Rental, VFX Compositing, Music Synchronization License, Post-Production Labor). Enables detailed variance analysis at the sub-category level. | Column cost_sub_category (STRING) in production.budget_line',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.budget_line',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system. Provides audit trail for record provenance and financial governance. | Column created_timestamp (TIMESTAMP) in production.budget_line',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this budget line (e.g., USD, GBP, EUR). Supports multi-currency production budgets for international co-productions. | Column currency_code (STRING) in production.budget_line. Valid values are `^[A-Z]{3}$`',
    `forecast_amount` DECIMAL(18,2) COMMENT 'Estimate at Completion (EAC) for this budget line, representing the current best estimate of total cost when the line item is fully complete. Combines actuals to date with estimate to complete. | Column forecast_amount (DECIMAL(18,2)) in production.budget_line',
    `fringe_rate_pct` DECIMAL(18,2) COMMENT 'Percentage applied to labor costs on this line to account for employer fringe benefits (payroll taxes, pension contributions, health insurance, residuals). Standard production accounting practice for above-the-line and below-the-line labor lines. | Column fringe_rate_pct (DECIMAL(7,4)) in production.budget_line',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account number to which this budget line maps for financial reporting and cost center allocation. Enables reconciliation between production budgets and enterprise financial statements. | Column gl_account_code (STRING) in production.budget_line. Valid values are `^[0-9]{6,10}$`',
    `is_above_the_line` BOOLEAN COMMENT 'Flag indicating whether this budget line is classified as above-the-line (ATL) cost, covering creative talent such as writers, directors, producers, and principal cast. False indicates below-the-line (BTL) cost. | Column is_above_the_line (BOOLEAN) in production.budget_line',
    `is_union_labor` BOOLEAN COMMENT 'Flag indicating whether this budget line involves union or guild labor subject to collective bargaining agreements (DGA, SAG-AFTRA, WGA, IATSE). Drives fringe rate calculations and residuals obligations. | Column is_union_labor (BOOLEAN) in production.budget_line',
    `line_description` STRING COMMENT 'Free-text description of the specific cost item represented by this budget line (e.g., Lead Actor Day Rate — Week 3, Steadicam Rental — Principal Photography, Dolby Atmos Mix — Episode 4). | Column line_description (STRING) in production.budget_line',
    `line_number` STRING COMMENT 'Sequential line number within the parent budget document, used for ordering and referencing individual line items in budget reports and purchase orders. | Column line_number (INT) in production.budget_line',
    `line_status` STRING COMMENT 'Current lifecycle status of the budget line item, tracking its progression from initial draft through approval, commitment, invoicing, and payment. Drives workflow routing and financial reporting. [ENUM-REF-CANDIDATE: draft|approved|committed|invoiced|paid|cancelled|on_hold — 7 candidates stripped; promote to reference product] | Column line_status (STRING) in production.budget_line',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the production accountant or line producer providing additional context, assumptions, or justification for this budget line item. | Column notes (STRING) in production.budget_line',
    `production_phase` STRING COMMENT 'Phase of the production workflow during which this cost is incurred. Enables phase-based cost tracking and cash flow forecasting across the full production lifecycle from development through delivery. | Column production_phase (STRING) in production.budget_line. Valid values are `development|pre_production|principal_photography|post_production|delivery|archive`',
    `purchase_order_number` STRING COMMENT 'SAP purchase order number raised against this budget line for vendor commitments. Links the budget line to the formal procurement document and enables three-way matching (PO, goods receipt, invoice). | Column purchase_order_number (STRING) in production.budget_line',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of units associated with this budget line (e.g., number of shoot days, number of crew members, number of VFX shots, hours of post-production labor). Combined with unit_rate to derive budgeted amount. | Column quantity (DECIMAL(12,4)) in production.budget_line',
    `revised_budgeted_amount` DECIMAL(18,2) COMMENT 'Most recent approved revision to the budgeted amount, reflecting approved change orders, scope changes, or budget transfers. Null if no revision has been approved since original budget. | Column revised_budgeted_amount (DECIMAL(18,2)) in production.budget_line',
    `shoot_date_end` DATE COMMENT 'Planned or actual end date for the activity or service associated with this budget line. Used for scheduling, resource allocation, and cost accrual period determination. | Column shoot_date_end (DATE) in production.budget_line',
    `shoot_date_start` DATE COMMENT 'Planned or actual start date for the activity or service associated with this budget line (e.g., first day of location shoot, start of VFX work, commencement of post-production labor). | Column shoot_date_start (DATE) in production.budget_line',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.budget_line',
    `tax_credit_eligible` BOOLEAN COMMENT 'Flag indicating whether this budget line qualifies for production tax credits or incentives (e.g., UK High-End TV Tax Relief, US state film tax credits). Enables automated calculation of eligible spend for tax credit claims. | Column tax_credit_eligible (BOOLEAN) in production.budget_line',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., day, hour, week, flat_fee, shot, reel, license). Defines how the quantity is counted for rate-based cost calculations. [ENUM-REF-CANDIDATE: day|hour|week|flat_fee|shot|reel|license|unit — 8 candidates stripped; promote to reference product] | Column unit_of_measure (STRING) in production.budget_line',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate per unit of measure for this budget line (e.g., daily rate for a crew member, hourly rate for facility hire, per-shot rate for VFX). Multiplied by quantity to derive the budgeted amount. | Column unit_rate (DECIMAL(18,4)) in production.budget_line',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.budget_line',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was most recently modified. Supports incremental data loading in the Databricks Silver Layer and change data capture from SAP S/4HANA. | Column updated_timestamp (TIMESTAMP) in production.budget_line',
    `wbs_element` STRING COMMENT 'SAP Work Breakdown Structure element code that hierarchically positions this budget line within the production project plan (e.g., PRD-2024-001.3.2.1 for a specific post-production task). | Column wbs_element (STRING) in production.budget_line',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line-item within a production budget, representing a specific cost category or account code (e.g., cast fees, location fees, equipment rental, VFX, music licensing, post-production labor). Captures account code, cost category, sub-category, vendor or payee, budgeted amount, committed amount, actual amount, episode or segment allocation, and SAP G/L account reference. Enables granular cost tracking and variance analysis at the line-item level. | Unity Catalog table: media_broadcasting_ecm.production.budget_line';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for a crew assignment record in the production domain. Primary key for the crew_assignment data product. | Column crew_assignment_id (BIGINT) in production.crew_assignment',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Crew assignments are executed under a specific talent contract governing rate, overtime eligibility, and residual terms. Payroll processing and union compliance audits require linking each assignment ',
    `deal_memo_id` BIGINT COMMENT 'Foreign key linking to talent.deal_memo. Business justification: In episodic production, crew assignments are frequently executed under a deal memo before the long-form contract is finalized. Production coordinators need this link to confirm deal memo coverage for ',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Crew can be assigned to specific episodes within a series production. Optional FK (nullable) — crew may be assigned at project level or episode level. Enables episode-specific crew tracking for episod | Column production_episode_id (BIGINT) in production.crew_assignment',
    `project_id` BIGINT COMMENT 'Reference to the production project to which this crew member is assigned. Links the assignment to the master production record. | Column production_project_id (BIGINT) in production.crew_assignment',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: Role defines the contractual character/function; crew_assignment is the operational scheduling execution of that role on set. Linking them enables cast call sheets, screen-time tracking against role.s',
    `talent_profile_id` BIGINT COMMENT 'Reference to the crew members master record in the talent domain. Identifies the individual below-the-line crew member being assigned. | Column talent_profile_id (BIGINT) in talent.crew_assignment',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.crew_assignment',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.crew_assignment',
    `assignment_number` STRING COMMENT 'Externally-known business identifier for this crew assignment, used in deal memos, call sheets, and payroll processing. Format: CA-{YEAR}-{SEQUENCE}. | Column assignment_number (STRING) in production.crew_assignment. Valid values are `^CA-[0-9]{4}-[0-9]{6}$`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the crew assignment. Drives payroll eligibility, call sheet inclusion, and production roster reporting. Values: pending (offer extended, not yet accepted), confirmed (deal memo signed), active (currently on set/in production), on_hold (temporarily suspended), completed (assignment concluded), cancelled (assignment terminated before start). | Column assignment_status (STRING) in production.crew_assignment. Valid values are `pending|confirmed|active|on_hold|completed|cancelled`',
    `background_check_status` STRING COMMENT 'Status of the crew members background check for this production assignment. Required for productions involving minors (COPPA compliance) or access to secure facilities. Values: not_required, pending, cleared, failed, expired. | Column background_check_status (STRING) in production.crew_assignment. Valid values are `not_required|pending|cleared|failed|expired`',
    `box_rental_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate paid to the crew member for the rental of their personal tool box or specialized equipment package (e.g., makeup artists kit, wardrobe supervisors supplies). Distinct from kit_rental_rate which covers technical equipment. | Column box_rental_rate (DECIMAL(18,4)) in production.crew_assignment',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The agreed compensation rate for this crew assignment, expressed in the applicable deal_type unit (per day, per week, or flat total). Stored in the productions base currency. Used for budget tracking and payroll processing in SAP S/4HANA. | Column contracted_rate (DECIMAL(18,4)) in production.crew_assignment',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.crew_assignment',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was first created in the system. Used for audit trail, data lineage, and compliance reporting. Conforms to ISO 8601 format with timezone offset. | Column created_timestamp (TIMESTAMP) in production.crew_assignment',
    `credit_name` STRING COMMENT 'The name as it should appear in the productions end credits, which may differ from the crew members legal name (e.g., stage name, preferred professional name). Sourced from the deal memo credit clause. | Column credit_name (STRING) in production.crew_assignment',
    `credit_position` STRING COMMENT 'Specifies where the crew members credit appears in the production: main_title (opening credits), end_title (closing credits), both, or none (no contractual credit obligation). Drives post-production credit sequence assembly. | Column credit_position (STRING) in production.crew_assignment. Valid values are `main_title|end_title|both|none`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contracted_rate (e.g., USD, GBP, EUR). Required for international co-productions where crew may be contracted in local currencies. | Column currency_code (STRING) in production.crew_assignment. Valid values are `^[A-Z]{3}$`',
    `dalet_workflow_reference` STRING COMMENT 'The workflow instance identifier in Dalet Galaxy that corresponds to this crew assignments production workflow. Enables traceability between the HR/payroll record and the media asset management workflow orchestration system. | Column dalet_workflow_reference (STRING) in production.crew_assignment',
    `deal_type` STRING COMMENT 'The compensation structure type for this crew assignment. Daily = per-day rate; Weekly = per-week rate with guaranteed days; Flat = fixed total fee for the engagement; Run of Show = engaged for the full production duration; Episodic = per-episode rate for series production. | Column deal_type (STRING) in production.crew_assignment. Valid values are `daily|weekly|flat|run_of_show|episodic`',
    `department` STRING COMMENT 'The production department to which the crew member belongs for this assignment (e.g., camera, grip, electric, art, wardrobe, hair/makeup, post-production, sound, VFX). Drives crew call sheet grouping and budget cost center allocation. [ENUM-REF-CANDIDATE: camera|grip|electric|art|wardrobe|hair_makeup|post_production|sound|vfx|production — 10 candidates stripped; promote to reference product] | Column department (STRING) in production.crew_assignment',
    `end_date` DATE COMMENT 'The contractually agreed last day of work for this crew assignment. Nullable for open-ended or rolling assignments. Used for wrap scheduling and final payroll processing. | Column end_date (DATE) in production.crew_assignment',
    `filming_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary filming location where this crew member will work. Determines applicable labor laws, tax treaties, work permit requirements, and per diem rates. | Column filming_location_country (STRING) in production.crew_assignment. Valid values are `^[A-Z]{3}$`',
    `guaranteed_days` STRING COMMENT 'The minimum number of work days guaranteed to the crew member under this assignment deal, regardless of actual production schedule. Relevant for weekly and episodic deal types. Used for take-or-pay liability calculation. | Column guaranteed_days (INT) in production.crew_assignment',
    `kit_rental_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate paid to the crew member for the rental of their personal professional equipment (kit) used on the production (e.g., camera operators lens kit, sound mixers equipment package). Common in below-the-line crew deals. | Column kit_rental_rate (DECIMAL(18,4)) in production.crew_assignment',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was most recently modified. Used for change data capture (CDC), audit trail, and Silver layer incremental processing in the Databricks Lakehouse. | Column last_updated_timestamp (TIMESTAMP) in production.crew_assignment',
    `meal_penalty_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to meal penalty payments if the production fails to provide a meal break within the contractually required interval (typically 6 hours under IATSE/DGA agreements). Drives production scheduling compliance. | Column meal_penalty_eligible (BOOLEAN) in production.crew_assignment',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is eligible for overtime pay under their union/guild agreement or applicable labor law. True = eligible for overtime; False = flat deal or exempt classification. Drives payroll calculation logic. | Column overtime_eligible (BOOLEAN) in production.crew_assignment',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base contracted_rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Applicable only when overtime_eligible is True. Sourced from the applicable union/guild agreement. | Column overtime_rate_multiplier (DECIMAL(5,2)) in production.crew_assignment',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily allowance paid to the crew member for meals and incidental expenses when working away from their home base location. Rate varies by filming location and union agreement. Used for production cost budgeting. | Column per_diem_rate (DECIMAL(18,4)) in production.crew_assignment',
    `production_company` STRING COMMENT 'The legal name of the production company or entity that is the employer of record for this crew assignment. Relevant for co-productions where multiple entities may employ different crew members. Used for payroll and tax reporting. | Column production_company (STRING) in production.crew_assignment',
    `residuals_eligible` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to residual payments when the production is reused, syndicated, or distributed on additional platforms (e.g., streaming, international broadcast). Residuals are governed by DGA, IATSE, and SAG-AFTRA agreements. | Column residuals_eligible (BOOLEAN) in production.crew_assignment',
    `role_title` STRING COMMENT 'The specific production role or job title assigned to the crew member (e.g., Director, Director of Photography, Gaffer, Script Supervisor, Editor, Colorist, VFX Supervisor, Sound Mixer, Key Grip, Best Boy). [ENUM-REF-CANDIDATE: director|director_of_photography|gaffer|script_supervisor|editor|colorist|vfx_supervisor|sound_mixer|key_grip|best_boy|production_designer|costume_designer — promote to reference product] | Column role_title (STRING) in production.crew_assignment',
    `safety_training_certified` BOOLEAN COMMENT 'Indicates whether the crew member has completed the required on-set safety training certification for this production (e.g., OSHA safety, COVID-19 protocols, stunt safety). Required for insurance compliance and production liability management. | Column safety_training_certified (BOOLEAN) in production.crew_assignment',
    `sap_personnel_action_code` STRING COMMENT 'The personnel action number in SAP S/4HANA HR that corresponds to this crew assignment. Used for payroll processing, benefits enrollment, and HR compliance reporting. Enables reconciliation between the production data product and the ERP system of record. | Column sap_personnel_action_code (STRING) in production.crew_assignment',
    `scheduled_days` STRING COMMENT 'The total number of work days currently scheduled for this crew member on the production, as reflected in the current production schedule. May differ from guaranteed_days if the schedule changes. | Column scheduled_days (INT) in production.crew_assignment',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.crew_assignment',
    `start_date` DATE COMMENT 'The contractually agreed first day of work for this crew assignment. Used for payroll calculation, permit verification, and production schedule alignment. | Column start_date (DATE) in production.crew_assignment',
    `travel_allowance` DECIMAL(18,2) COMMENT 'Fixed or estimated travel reimbursement amount for this crew assignment, covering transportation costs to and from the filming location. Distinct from per_diem_rate which covers daily living expenses. | Column travel_allowance (DECIMAL(18,4)) in production.crew_assignment',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'The minimum number of hours required between the end of one work day and the start of the next for this crew member, as stipulated by their union/guild agreement (e.g., 10 hours for IATSE, 12 hours for DGA). Violation triggers turnaround penalty payments. | Column turnaround_hours (DECIMAL(5,2)) in production.crew_assignment',
    `union_guild_affiliation` STRING COMMENT 'The labor union or guild to which the crew member belongs for this assignment. Determines applicable minimum rates, working conditions, residuals obligations, and benefit fund contributions. DGA = Directors Guild of America; IATSE = International Alliance of Theatrical Stage Employees; SAG-AFTRA = Screen Actors Guild–American Federation of Television and Radio Artists; WGA = Writers Guild of America; NABET = National Association of Broadcast Employees and Technicians; Teamsters = International Brotherhood of Teamsters. [ENUM-REF-CANDIDATE: DGA|IATSE|SAG-AFTRA|WGA|NABET|Teamsters|non_union — 7 candidates stripped; promote to reference product] | Column union_guild_affiliation (STRING) in production.crew_assignment',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.crew_assignment',
    `work_permit_expiry_date` DATE COMMENT 'The expiration date of the crew members work permit or visa authorization. Used to trigger renewal alerts and ensure continuous legal work authorization throughout the assignment period. | Column work_permit_expiry_date (DATE) in production.crew_assignment',
    `work_permit_number` STRING COMMENT 'The official government-issued work permit or visa authorization number for the crew member in the production jurisdiction. Nullable when work_permit_required is False. Required for compliance audits and production insurance. | Column work_permit_number (STRING) in production.crew_assignment',
    `work_permit_required` BOOLEAN COMMENT 'Indicates whether a work permit or visa authorization is required for this crew member to legally work on this production in the filming jurisdiction. True = permit required; False = no permit required (domestic/citizen crew). Triggers compliance workflow in HR. | Column work_permit_required (BOOLEAN) in production.crew_assignment',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'Assignment of a crew member to a specific production project in a defined role and department. Captures crew role (director, DP, gaffer, script supervisor, editor, colorist, VFX supervisor, sound mixer), department (camera, grip, electric, art, wardrobe, hair/makeup, post-production), start date, end date, deal type (daily, weekly, flat), contracted rate, union or guild affiliation (DGA, IATSE, SAG-AFTRA), overtime eligibility, work permit status, and assignment status. References the talent domain for the crew members master record. Tracks the full below-the-line crew roster for a production. | Unity Catalog table: media_broadcasting_ecm.production.crew_assignment';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` (
    `production_episode_id` BIGINT COMMENT 'Unique surrogate identifier for the production episode record in the lakehouse Silver layer. Serves as the primary key for all downstream joins and lineage tracking. | Column production_episode_id (BIGINT) in production.production_episode',
    `deal_id` BIGINT COMMENT 'Foreign key linking to distribution.deal. Business justification: Episodic content is frequently licensed per-episode under distribution deals. Linking production_episode to deal enables per-episode deal compliance tracking, residuals calculation, and episodic deliv',
    `media_asset_id` BIGINT COMMENT 'Native asset identifier assigned by Dalet Galaxy Media Asset Management system for this episode. Used for direct lookup and workflow orchestration in the MAM system, ingest tracking, and archive retrieval. | Column media_asset_id (BIGINT) in mediaasset.production_episode',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Production delivery deadlines are set against a committed program schedule (broadcast date/channel). Operations teams track episode readiness — QC pass, rights clearance, picture lock — relative to th',
    `project_id` BIGINT COMMENT 'Reference to the parent production project (series, mini-series, anthology, or episodic documentary) to which this episode belongs. Establishes the episode-to-project hierarchy. | Column project_id (BIGINT) in production.production_episode',
    `script_id` BIGINT COMMENT 'Foreign key linking to production.script. Business justification: Episodes are based on specific scripts. Strong content relationship — script is the source document for episode production. FK links episode to the locked script version used for production. | Column script_id (BIGINT) in production.production_episode',
    `season_id` BIGINT COMMENT 'Reference to the season record that groups this episode within a multi-season series. Null for mini-series or anthology formats that do not have a season structure. | Column season_id (BIGINT) in content.production_episode',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Individual episodes may have separate syndication or international license agreements distinct from the series-level agreement. Real business need: episode-level rights tracking for syndication deals, | Column syndication_license_agreement_id (BIGINT) in rights.production_episode',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Individual episodes are produced targeting specific demographic cells distinct from the series-level target (e.g., a holiday special targeting K2-11 within an otherwise A18-49 series). Showrunners and',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.production_episode',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.production_episode',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Total actual production cost incurred for this episode in US dollars, as recorded in SAP S/4HANA. Used for budget variance analysis, EBITDA reporting, and production cost per minute calculations. | Column actual_cost_usd (DECIMAL(18,2)) in production.production_episode',
    `actual_delivery_date` DATE COMMENT 'Date on which the completed episode master was actually delivered to the distributor, broadcaster, or platform. Compared against scheduled_delivery_date for SLA compliance and penalty assessment. | Column actual_delivery_date (DATE) in production.production_episode',
    `actual_running_time_sec` STRING COMMENT 'Final delivered running time of the episode in seconds as measured from the completed master file. May differ from target due to editorial decisions made during post-production. Used for playout scheduling reconciliation and delivery compliance verification. | Column actual_running_time_sec (INT) in production.production_episode',
    `approved_budget_usd` DECIMAL(18,2) COMMENT 'Total approved production budget for this episode in US dollars, as sanctioned at greenlight. Used for budget vs. actual variance analysis in SAP S/4HANA CO and financial reporting under SOX compliance. | Column approved_budget_usd (DECIMAL(18,2)) in production.production_episode',
    `audio_language_code` STRING COMMENT 'ISO 639-2 three-letter language code for the primary audio track of this episode. Used for distribution rights matching, subtitle/dubbing workflow triggering, and EPG metadata population. | Column audio_language_code (STRING) in production.production_episode. Valid values are `^[a-z]{3}$`',
    `audio_mix_completion_date` DATE COMMENT 'Date on which the final audio mix (including dialogue, music, and effects) was completed and approved. Prerequisite for final mastering and delivery. Tracked as a post-production milestone in Dalet Galaxy. | Column audio_mix_completion_date (DATE) in production.production_episode',
    `closed_captioning_compliant` BOOLEAN COMMENT 'Indicates whether this episode meets FCC closed captioning requirements (47 CFR Part 79) and Ofcom subtitling standards. Required for broadcast clearance and regulatory compliance reporting. | Column closed_captioning_compliant (BOOLEAN) in production.production_episode',
    `color_grade_completion_date` DATE COMMENT 'Date on which color grading (digital color correction and finishing) was completed and approved. Required before final mastering and transcode for delivery. Tracked as a post-production milestone in Dalet Galaxy. | Column color_grade_completion_date (DATE) in production.production_episode',
    `content_rating` STRING COMMENT 'Audience content rating assigned to this episode per the TV Parental Guidelines system (US) or equivalent regulatory body. Required for EPG metadata, DAI ad targeting restrictions, and COPPA compliance for childrens content. | Column content_rating (STRING) in production.production_episode. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `content_type` STRING COMMENT 'Broad classification of the episode content format. Determines applicable production workflows, rights frameworks, talent residual calculations, and compliance requirements (e.g., COPPA for childrens content). [ENUM-REF-CANDIDATE: scripted|unscripted|documentary|news|sports|animation|live_event — promote to reference product] | Column content_type (STRING) in production.production_episode',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.production_episode',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production episode record was first created in the system. Used for audit trail, data lineage, and production workflow initiation tracking. Conforms to ISO 8601 extended format. | Column created_timestamp (TIMESTAMP) in production.production_episode',
    `delivery_date` DATE COMMENT 'Contractually committed or operationally planned date by which the completed episode master must be delivered to the distributor, broadcaster, or platform. Used for SLA tracking and rights window activation in Rightsline. | Column delivery_date (DATE) in production.production_episode',
    `director_name` STRING COMMENT 'Full name of the credited director for this episode. Used for DGA residuals calculation, talent contract compliance, and creative attribution in production records. | Column director_name (STRING) in production.production_episode',
    `eidr_code` STRING COMMENT 'EIDR content identifier for this episode, enabling interoperability across supply chain partners, distributors, and rights management systems. Registered with the Entertainment Identifier Registry. | Column eidr_code (STRING) in production.production_episode. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$`',
    `episode_code` STRING COMMENT 'Internal production code assigned by the production team to uniquely identify this episode within the production management system (e.g., Dalet Galaxy asset code). Used for workflow routing, asset tagging, and facility booking references. | Column episode_code (STRING) in production.production_episode. Valid values are `^[A-Z0-9]{2,20}$`',
    `episode_number` STRING COMMENT 'Sequential production episode number within the season or series. Used for scheduling, EPG metadata, and audience tracking. Corresponds to the broadcast order number. | Column episode_number (INT) in production.production_episode',
    `first_air_date` DATE COMMENT 'Date on which this episode first aired or was made available to audiences on any platform (linear broadcast, VOD, OTT). Marks the start of the content windowing lifecycle and triggers residuals calculation in Rightsline. | Column first_air_date (DATE) in production.production_episode',
    `greenlight_date` DATE COMMENT 'Date on which executive approval (greenlight) was granted to proceed with production of this episode. Marks the official start of the production lifecycle and triggers budget release in SAP S/4HANA. | Column greenlight_date (DATE) in production.production_episode',
    `isan` STRING COMMENT 'Globally unique identifier for this episode as registered with the ISAN International Agency. Used for rights clearance, royalty tracking, and cross-platform content identification. Conforms to ISO 15706-2. | Column isan (STRING) in production.production_episode. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$`',
    `master_format` STRING COMMENT 'Technical format specification of the delivered episode master file (e.g., UHD HDR, HD 1080p). Determines transcode profiles required for multi-platform distribution and CDN delivery via Akamai. | Column master_format (STRING) in production.production_episode. Valid values are `UHD_HDR|UHD_SDR|HD_1080p|HD_720p|SD`',
    `picture_lock_date` DATE COMMENT 'Date on which the final edited picture was locked, freezing all visual edits. Triggers downstream post-production workflows including VFX, color grading, and audio mixing. Critical milestone for delivery scheduling. | Column picture_lock_date (DATE) in production.production_episode',
    `production_company` STRING COMMENT 'Name of the production company or studio responsible for producing this episode. Used for co-production agreements, rights attribution, and financial reconciliation in SAP S/4HANA. | Column production_company (STRING) in production.production_episode',
    `production_status` STRING COMMENT 'Current lifecycle stage of the episode within the end-to-end production workflow. Drives workflow routing in Dalet Galaxy and milestone reporting to production management. [ENUM-REF-CANDIDATE: development|pre_production|principal_photography|post_production|picture_lock|delivered|archived — promote to reference product] | Column production_status (STRING) in production.production_episode',
    `script_lock_date` DATE COMMENT 'Date on which the final shooting script was locked, freezing all creative changes. Triggers pre-production scheduling, crew assignments, and facility bookings. Key milestone for production planning. | Column script_lock_date (DATE) in production.production_episode',
    `shoot_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country where principal photography was conducted. Used for production tax credit eligibility, co-production treaty compliance, and content origin classification. | Column shoot_country_code (STRING) in production.production_episode. Valid values are `^[A-Z]{3}$`',
    `shoot_end_date` DATE COMMENT 'Scheduled or actual end date of principal photography (picture wrap) for this episode. Used to confirm transition to post-production and trigger post-production workflow initiation in Dalet Galaxy. | Column shoot_end_date (DATE) in production.production_episode',
    `shoot_location` STRING COMMENT 'Primary geographic location where principal photography for this episode was conducted. Used for production tax credit eligibility, location permit compliance, and production logistics reporting. | Column shoot_location (STRING) in production.production_episode',
    `shoot_start_date` DATE COMMENT 'Scheduled or actual start date of principal photography for this episode. Used for crew scheduling, facility booking, and production budget burn-rate tracking in SAP S/4HANA. | Column shoot_start_date (DATE) in production.production_episode',
    `showrunner_name` STRING COMMENT 'Full name of the showrunner (executive producer with creative oversight) responsible for this episode. Key accountability reference for production governance and editorial decisions. | Column showrunner_name (STRING) in production.production_episode',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.production_episode',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639-2 three-letter language codes for subtitle tracks available in the delivered master. Used for accessibility compliance (FCC closed captioning rules), distribution rights, and EPG metadata. | Column subtitle_languages (STRING) in production.production_episode',
    `target_running_time_sec` STRING COMMENT 'Planned editorial running time of the episode in seconds, excluding commercial breaks. Used for scheduling slot allocation, playout automation configuration in Ericsson MediaFirst, and delivery specification compliance. | Column target_running_time_sec (INT) in production.production_episode',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.production_episode',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this production episode record. Used for incremental data pipeline processing, change data capture, and audit compliance in the Databricks Silver layer. | Column updated_timestamp (TIMESTAMP) in production.production_episode',
    `vfx_completion_date` DATE COMMENT 'Date on which all visual effects shots were completed and approved for integration into the picture lock. Tracked as a post-production milestone. Null if the episode contains no VFX work. | Column vfx_completion_date (DATE) in production.production_episode',
    `writer_name` STRING COMMENT 'Full name of the credited writer(s) for this episode. Used for residuals calculation, WGA/guild compliance reporting, and rights attribution in Rightsline. | Column writer_name (STRING) in production.production_episode',
    CONSTRAINT pk_production_episode PRIMARY KEY(`production_episode_id`)
) COMMENT 'Master record for an individual episode, segment, or installment within a production project (series, mini-series, anthology, or episodic documentary). Captures episode number, episode title, season number, running time target, production status, writer, director, script lock date, picture lock date, audio mix completion date, delivery date, and ISAN episode identifier. Acts as the granular production unit below the project level for episodic content. | Unity Catalog table: media_broadcasting_ecm.production.production_episode';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`script` (
    `script_id` BIGINT COMMENT 'Unique identifier for the production script or screenplay record. Primary key. | Column script_id (BIGINT) in production.script',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Scripts are digital files (PDF/FDX) ingested into MAM systems like Dalet. Linking script to its media_asset record enables script asset lifecycle management, version control, and retrieval workflows —',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode to which this script belongs. | Column production_project_id (BIGINT) in production.script',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Scripts are often based on underlying IP owned by rights holders (novels, plays, life rights, true stories, existing franchises). Real business need: tracking the rights holder of the underlying IP be | Column underlying_rights_holder_id (BIGINT) in rights.script',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Writer contracts govern script delivery schedules, revision obligations, WGA minimums, and separation-of-rights provisions. Linking each script to its governing writer contract enables contractual del',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Scripts are authored by writers who are registered talent. WGA compliance, residual eligibility determination, and writer credit management require linking each script to the writers talent_profile. ',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.script',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.script',
    `approval_date` DATE COMMENT 'The date on which the script was officially approved for production. | Column approval_date (DATE) in production.script',
    `approved_by` STRING COMMENT 'The name or identifier of the individual or role who approved the script for production. | Column approved_by (STRING) in production.script',
    `confidentiality_level` STRING COMMENT 'The confidentiality classification of the script document (public, internal, confidential, restricted). | Column confidentiality_level (STRING) in production.script. Valid values are `public|internal|confidential|restricted`',
    `copyright_holder` STRING COMMENT 'The legal entity or individual who holds the copyright to the script. | Column copyright_holder (STRING) in production.script',
    `copyright_year` STRING COMMENT 'The year in which the script copyright was established or registered. | Column copyright_year (INT) in production.script',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.script',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this script record was first created in the system. | Column created_timestamp (TIMESTAMP) in production.script',
    `dalet_document_reference` STRING COMMENT 'The unique document identifier or reference in the Dalet Galaxy Media Asset Management (MAM) system linking this script record to the digital script file. | Column dalet_document_reference (STRING) in production.script',
    `distribution_restriction` STRING COMMENT 'Any restrictions or limitations on the distribution or sharing of the script (e.g., internal use only, NDA required). | Column distribution_restriction (STRING) in production.script',
    `draft_type` STRING COMMENT 'The classification of the script draft stage (outline, first draft, revised draft, shooting script, post-production script, final draft). | Column draft_type (STRING) in production.script. Valid values are `outline|first draft|revised draft|shooting script|post-production script|final draft`',
    `estimated_runtime_minutes` STRING COMMENT 'The estimated runtime of the production in minutes based on the script length and pacing. | Column estimated_runtime_minutes (INT) in production.script',
    `file_format` STRING COMMENT 'The digital file format of the script document (PDF, DOCX, FDX, FOUNTAIN, TXT). | Column file_format (STRING) in production.script. Valid values are `PDF|DOCX|FDX|FOUNTAIN|TXT`',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The size of the script file in megabytes. | Column file_size_mb (DECIMAL(10,2)) in production.script',
    `format` STRING COMMENT 'The production format for which the script is intended (feature film, television episode, miniseries, web series, documentary, commercial, short film). [ENUM-REF-CANDIDATE: feature film|television episode|miniseries|web series|documentary|commercial|short film — 7 candidates stripped; promote to reference product] | Column format (STRING) in production.script',
    `genre` STRING COMMENT 'The genre or category of the script (e.g., drama, comedy, thriller, documentary). | Column genre (STRING) in production.script',
    `language` STRING COMMENT 'The primary language in which the script is written (e.g., English, Spanish, French). | Column language (STRING) in production.script',
    `lock_date` DATE COMMENT 'The date on which the script was locked and finalized for production. | Column lock_date (DATE) in production.script',
    `lock_status` BOOLEAN COMMENT 'Indicates whether the script is locked for production (true) or still open for revisions (false). | Column lock_status (BOOLEAN) in production.script',
    `notes` STRING COMMENT 'General notes, comments, or annotations related to the script for production reference. | Column notes (STRING) in production.script',
    `page_count` STRING COMMENT 'The total number of pages in the script document. | Column page_count (INT) in production.script',
    `revision_date` DATE COMMENT 'The date of the most recent revision or update to the script. | Column revision_date (DATE) in production.script',
    `revision_notes` STRING COMMENT 'Notes or comments describing the changes made in the current revision of the script. | Column revision_notes (STRING) in production.script',
    `rights_clearance_status` STRING COMMENT 'The status of rights clearance for the script (pending, cleared, restricted, expired). | Column rights_clearance_status (STRING) in production.script. Valid values are `pending|cleared|restricted|expired`',
    `scene_count` STRING COMMENT 'The total number of scenes defined in the script. | Column scene_count (INT) in production.script',
    `script_number` STRING COMMENT 'The externally-known unique identifier or code assigned to this script for production tracking and reference purposes. | Column script_number (STRING) in production.script',
    `script_status` STRING COMMENT 'Current lifecycle status of the script (draft, in review, approved, locked, archived, rejected). | Column script_status (STRING) in production.script. Valid values are `draft|in review|approved|locked|archived|rejected`',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.script',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.script',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this script record was last updated or modified. | Column updated_timestamp (TIMESTAMP) in production.script',
    `version_number` STRING COMMENT 'The version or revision number of the script (e.g., 1.0, 2.3, Final). | Column version_number (STRING) in production.script',
    `wga_registration_number` STRING COMMENT 'The WGA registration number assigned to this script for copyright and intellectual property protection. | Column wga_registration_number (STRING) in production.script',
    CONSTRAINT pk_script PRIMARY KEY(`script_id`)
) COMMENT 'Master record for a production script or screenplay associated with a production project or episode. Captures script title, version number, draft type (outline, first draft, revised draft, shooting script, post-production script), writer credits, WGA registration number, page count, script lock status, lock date, language, and Dalet Galaxy document reference. Tracks the full script revision history and serves as the authoritative script record for production and rights purposes. | Unity Catalog table: media_broadcasting_ecm.production.script';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` (
    `deliverable_id` BIGINT COMMENT 'Unique identifier for the production deliverable. Primary key. | Column deliverable_id (BIGINT) in production.deliverable',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: Branded content fulfillment tracking: ad orders for sponsored/branded content contractually require specific production deliverables. Operations and finance teams reconcile deliverable completion agai',
    `carriage_agreement_id` BIGINT COMMENT 'Foreign key linking to distribution.carriage_agreement. Business justification: Carriage agreements specify exact technical delivery requirements that production deliverables must satisfy. Linking deliverable to carriage_agreement enables carriage compliance reporting, technical ',
    `clearance_id` BIGINT COMMENT 'Foreign key linking to talent.talent_clearance. Business justification: Deliverables cannot be released without confirmed talent clearance (likeness, name, performance rights). Distribution operations require a clearance-gated delivery workflow where each deliverable refe',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: A deliverable fulfills a specific content version (resolution, language, format spec). QC sign-off and distribution workflows require knowing which content version a deliverable satisfies. deliverable',
    `creative_id` BIGINT COMMENT 'Foreign key linking to advertising.creative. Business justification: Ad trafficking workflow: a QC-approved production deliverable (finished ad spot or branded content unit) is registered as an advertising creative for campaign trafficking. Broadcast operations teams n',
    `deal_id` BIGINT COMMENT 'Foreign key linking to distribution.deal. Business justification: Deliverables are fulfilled against specific distribution deals — deal terms define deliverable specs, deadlines, and acceptance criteria. Deal fulfillment tracking and deliverable compliance reporting',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Deliverables are prepared to meet the technical requirements of a specific delivery channel (FAST, OTT, linear). Channel-specific deliverable preparation — including bitrate, resolution, and format — ',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Deliverables are produced to fulfill specific rights grants (platform window, territory, media type). Deliverable fulfillment reporting and rights exploitation tracking require knowing which grant win',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Deliverables are created to fulfill specific license agreement technical and format requirements (e.g., HD master for territory X, dubbed version for territory Y). Real business need: linking delivera | Column license_agreement_id (BIGINT) in rights.deliverable',
    `media_asset_id` BIGINT COMMENT 'Reference to the digital media asset in the Media Asset Management (MAM) system that represents this deliverable. Links to Dalet Galaxy or other MAM upon delivery. | Column media_asset_id (BIGINT) in mediaasset.deliverable',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Deliverables can be episode-specific (e.g., episodic masters for series). Optional FK (nullable) — deliverables may be project-level or episode-level. Enables episode-specific deliverable tracking. | Column production_episode_id (BIGINT) in production.deliverable',
    `project_id` BIGINT COMMENT 'Reference to the parent production project that this deliverable belongs to. | Column production_project_id (BIGINT) in production.deliverable',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Deliverables are formatted for specific platforms with platform-specific technical requirements (resolution, codec, DRM). Real business process: platform-specific asset preparation, transcoding, and d | Column target_ott_platform_id (BIGINT) in distribution.deliverable',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.deliverable',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.deliverable',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the deliverable was successfully delivered or handed off. | Column actual_delivery_timestamp (TIMESTAMP) in production.deliverable',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video deliverable (e.g., 16:9, 4:3, 2.39:1, 1:1). Null for non-video deliverables. | Column aspect_ratio (NUMERIC) in production.deliverable',
    `audio_channels` STRING COMMENT 'Audio channel configuration for the deliverable (e.g., Stereo, 5.1 Surround, 7.1 Surround, Mono, Dolby Atmos). Null for non-audio deliverables. | Column audio_channels (STRING) in production.deliverable',
    `audio_description_flag` BOOLEAN COMMENT 'Indicates whether an audio description track for visually impaired viewers is included. True = audio description present; False = no audio description. | Column audio_description_flag (BOOLEAN) in production.deliverable',
    `checksum_md5` STRING COMMENT 'MD5 hash of the deliverable file for integrity verification during transfer and storage. | Column checksum_md5 (STRING) in production.deliverable. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_flag` BOOLEAN COMMENT 'Indicates whether closed captions for accessibility are included in this deliverable. True = closed captions present; False = no closed captions. | Column closed_caption_flag (BOOLEAN) in production.deliverable',
    `compliance_certificate_flag` BOOLEAN COMMENT 'Indicates whether a regulatory compliance certificate (e.g., FCC, Ofcom, content rating) accompanies this deliverable. True = certificate included; False = no certificate. | Column compliance_certificate_flag (BOOLEAN) in production.deliverable',
    `content_rating` STRING COMMENT 'Age or content rating assigned to this deliverable (e.g., TV-PG, TV-14, TV-MA, G, PG, PG-13, R, NC-17). Used for compliance and audience targeting. | Column content_rating (STRING) in production.deliverable',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the contract or agreement that mandates this deliverable. | Column contract_reference (STRING) in production.deliverable',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to produce this deliverable, including labor, equipment, facilities, and post-production services. | Column cost_amount (DECIMAL(15,2)) in production.deliverable',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.deliverable',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deliverable record was first created in the system. | Column created_timestamp (TIMESTAMP) in production.deliverable',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP). | Column currency_code (STRING) in production.deliverable. Valid values are `^[A-Z]{3}$`',
    `deliverable_type` STRING COMMENT 'Category of deliverable output. Broadcast master = final linear transmission file; streaming master = OTT/VOD optimized file; promo cut = promotional excerpt; trailer = marketing preview; EPK = Electronic Press Kit; closed caption file = accessibility text; audio description track = visually impaired narration; subtitle file = translation text; M&E track = Music and Effects (no dialogue); textless version = graphics-free master; compliance certificate = regulatory approval document; QC report = Quality Control validation; as-run log = actual playout record. [ENUM-REF-CANDIDATE: broadcast_master|streaming_master|promo_cut|trailer|epk|closed_caption_file|audio_description_track|subtitle_file|me_track|textless_version|compliance_certificate|qc_report|as_run_log|other — 14 candidates stripped; promote to reference product] | Column deliverable_type (STRING) in production.deliverable',
    `delivery_location` STRING COMMENT 'Physical address, URL, FTP path, or cloud storage location where the deliverable was sent or made available. | Column delivery_location (STRING) in production.deliverable',
    `delivery_method` STRING COMMENT 'Method or protocol used to deliver the deliverable to the recipient. Physical media = hard drive/tape shipment; FTP = File Transfer Protocol; Aspera = high-speed file transfer; Signiant = media transfer platform; AWS S3 = Amazon cloud storage; Akamai NetStorage = CDN storage; Google Drive/Dropbox = cloud file sharing. [ENUM-REF-CANDIDATE: physical_media|ftp|aspera|signiant|aws_s3|akamai_netstorage|google_drive|dropbox|other — 9 candidates stripped; promote to reference product] | Column delivery_method (STRING) in production.deliverable',
    `delivery_status` STRING COMMENT 'Current lifecycle state of the deliverable. Not started = work has not begun; in progress = actively being produced; QC pending = awaiting quality control review; QC failed = did not pass quality checks; QC passed = approved for delivery; ready for delivery = prepared and awaiting handoff; delivered = sent to recipient; accepted = recipient confirmed receipt and approval; rejected = recipient declined or returned; cancelled = deliverable no longer required. [ENUM-REF-CANDIDATE: not_started|in_progress|qc_pending|qc_failed|qc_passed|ready_for_delivery|delivered|accepted|rejected|cancelled — 10 candidates stripped; promote to reference product] | Column delivery_status (STRING) in production.deliverable',
    `due_date` DATE COMMENT 'Contractually or operationally required date by which this deliverable must be completed and handed off. | Column due_date (DATE) in production.deliverable',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total runtime duration of the deliverable in seconds (for video/audio deliverables). Null for non-time-based deliverables like documents or images. | Column duration_seconds (DECIMAL(10,3)) in production.deliverable',
    `eidr_code` STRING COMMENT 'Unique universal identifier for the audiovisual content assigned by the Entertainment Identifier Registry. Used for global content identification and rights management. | Column eidr_code (STRING) in production.deliverable. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `file_size_bytes` BIGINT COMMENT 'Total file size of the deliverable in bytes. Used for storage planning, transfer time estimation, and CDN capacity management. | Column file_size_bytes (BIGINT) in production.deliverable',
    `language_code` STRING COMMENT 'Primary language of the deliverable content using ISO 639-1 or ISO 639-2 two or three-letter code, optionally followed by ISO 3166-1 alpha-2 country code (e.g., en, en-US, es-MX, fr-CA). | Column language_code (STRING) in production.deliverable. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `deliverable_name` STRING COMMENT 'Human-readable name or title of the deliverable (e.g., Broadcast Master HD, Promo Cut 30s, Closed Caption SRT File). | Column deliverable_name (STRING) in production.deliverable',
    `qc_notes` STRING COMMENT 'Detailed notes from the quality control review, including any issues found, corrective actions taken, or validation comments. | Column qc_notes (STRING) in production.deliverable',
    `qc_operator_name` STRING COMMENT 'Name of the quality control technician or automated system that performed the QC validation. | Column qc_operator_name (STRING) in production.deliverable',
    `qc_pass_flag` BOOLEAN COMMENT 'Indicates whether the deliverable passed quality control validation. True = passed QC; False = failed QC or not yet tested. | Column qc_pass_flag (BOOLEAN) in production.deliverable',
    `qc_performed_timestamp` TIMESTAMP COMMENT 'Date and time when quality control validation was completed for this deliverable. | Column qc_performed_timestamp (TIMESTAMP) in production.deliverable',
    `revision_notes` STRING COMMENT 'Description of changes made in this revision of the deliverable (e.g., Corrected audio sync issue, Updated end credits, Re-encoded for HDR). | Column revision_notes (STRING) in production.deliverable',
    `revision_number` STRING COMMENT 'Version or revision number of this deliverable. Increments when the deliverable is updated or redelivered after corrections. | Column revision_number (INT) in production.deliverable',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time for delivery of this deliverable to the recipient or platform. | Column scheduled_delivery_timestamp (TIMESTAMP) in production.deliverable',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.deliverable',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of language codes for subtitle tracks included in this deliverable (e.g., en,es,fr). Null if no subtitles are included. | Column subtitle_languages (STRING) in production.deliverable',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.deliverable',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this deliverable record was last modified. | Column updated_timestamp (TIMESTAMP) in production.deliverable',
    CONSTRAINT pk_deliverable PRIMARY KEY(`deliverable_id`)
) COMMENT 'Contractually or operationally required output deliverable from a production project — the specific media asset or document that must be produced and handed off. Captures deliverable name, deliverable type (broadcast master, streaming master, promo cut, trailer, EPK, closed caption file, audio description track, subtitles, M&E track, textless version, compliance certificate), target format, target platform or recipient, due date, actual delivery date, delivery status, and QC pass/fail flag. Links to the digital asset management domain upon delivery. | Unity Catalog table: media_broadcasting_ecm.production.deliverable';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` (
    `qc_review_id` BIGINT COMMENT 'Unique identifier for the quality control review record. Primary key. | Column qc_review_id (BIGINT) in production.qc_review',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Production QC reviews target a specific asset version (e.g., a particular transcode rendition). Without this FK, QC results cannot be tied to the exact version reviewed — critical for compliance repor',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: QC reviews validate specific content versions for distribution. Essential for version-level quality tracking, linking production QC to content version records, and ensuring only QC-passed versions are | Column content_version_id (BIGINT) in content.qc_review',
    `deliverable_id` BIGINT COMMENT 'Reference to the production deliverable or post-production output being reviewed. | Column deliverable_id (BIGINT) in production.qc_review',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: QC reviews validate content against delivery channel technical specs (resolution, loudness, codec, bitrate). Channel-specific QC compliance reporting — e.g., FAST channel vs. OTT vs. linear — requires',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Production QC reviews inspect specific media assets for technical compliance before delivery. Role-prefixed as reviewed_asset_id since qc_review already links to deliverable. Essential for broadcast c | Column media_asset_id (BIGINT) in mediaasset.qc_review',
    `project_id` BIGINT COMMENT 'Reference to the parent production project this QC review belongs to. | Column production_project_id (BIGINT) in production.qc_review',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.qc_review',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.qc_review',
    `audio_channel_configuration` STRING COMMENT 'Audio channel layout (e.g., stereo, 5.1 surround, 7.1 surround, mono). | Column audio_channel_configuration (STRING) in production.qc_review',
    `audio_codec` STRING COMMENT 'Audio codec used in the deliverable (e.g., AAC, Dolby Digital, PCM). | Column audio_codec (STRING) in production.qc_review',
    `audio_description_compliance_flag` BOOLEAN COMMENT 'Indicates whether audio description track meets accessibility standards. True if compliant, False if missing or non-compliant. | Column audio_description_compliance_flag (BOOLEAN) in production.qc_review',
    `closed_caption_compliance_flag` BOOLEAN COMMENT 'Indicates whether closed captions meet accessibility and regulatory standards (FCC, CVAA). True if compliant, False if violations detected. | Column closed_caption_compliance_flag (BOOLEAN) in production.qc_review',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.qc_review',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC review record was first created in the system. | Column created_timestamp (TIMESTAMP) in production.qc_review',
    `dalet_workflow_reference` STRING COMMENT 'Identifier linking this QC review to the corresponding workflow instance in Dalet Galaxy MAM for ingest and workflow orchestration. | Column dalet_workflow_reference (STRING) in production.qc_review',
    `error_codes` STRING COMMENT 'Comma-separated list of specific error codes identified during the review, aligned with EBU R128, ATSC A/85, and ITU-R BT.1788 standards (e.g., V001 for video freeze, A002 for loudness violation, C003 for closed caption sync error). | Column error_codes (STRING) in production.qc_review',
    `final_approval_date` DATE COMMENT 'Date when the deliverable received final approval for distribution. Null if not yet approved. | Column final_approval_date (DATE) in production.qc_review',
    `final_approval_status` STRING COMMENT 'Final approval status of the deliverable after QC review and any remediation: approved (ready for distribution), rejected (does not meet standards), pending approval (awaiting sign-off), or conditional approval (approved with minor caveats). | Column final_approval_status (STRING) in production.qc_review. Valid values are `approved|rejected|pending_approval|conditional_approval`',
    `loudness_compliance_flag` BOOLEAN COMMENT 'Indicates whether the deliverable meets loudness standards (EBU R128 or ATSC A/85). True if compliant, False if violations detected. | Column loudness_compliance_flag (BOOLEAN) in production.qc_review',
    `loudness_lufs` DECIMAL(18,2) COMMENT 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) per EBU R128 or ATSC A/85 standards. Target is typically -23 LUFS for broadcast. | Column loudness_lufs (DECIMAL(6,2)) in production.qc_review',
    `p1_critical_error_count` STRING COMMENT 'Number of P1 critical errors that prevent broadcast or distribution (e.g., audio dropout, video corruption, missing segments). | Column p1_critical_error_count (INT) in production.qc_review',
    `p2_major_error_count` STRING COMMENT 'Number of P2 major errors that significantly impact quality but may not prevent distribution (e.g., color grading inconsistencies, audio sync issues). | Column p2_major_error_count (INT) in production.qc_review',
    `p3_minor_error_count` STRING COMMENT 'Number of P3 minor errors that have minimal impact on viewer experience (e.g., minor subtitle timing issues, cosmetic artifacts). | Column p3_minor_error_count (INT) in production.qc_review',
    `qc_notes` STRING COMMENT 'Free-text notes and observations recorded by the QC operator during the review, including context for errors and recommendations. | Column qc_notes (STRING) in production.qc_review',
    `qc_platform` STRING COMMENT 'Name of the QC platform or tool used to perform the review (e.g., Dalet Galaxy QC module, Tektronix Sentry, Interra Baton). | Column qc_platform (STRING) in production.qc_review',
    `qc_result` STRING COMMENT 'Overall result of the QC review: pass (no issues), fail (critical issues preventing distribution), conditional pass (minor issues requiring remediation), or pending review (awaiting final approval). | Column qc_result (STRING) in production.qc_review. Valid values are `pass|fail|conditional_pass|pending_review`',
    `qc_type` STRING COMMENT 'Type of quality control review performed: technical QC (video/audio quality), editorial QC (content accuracy), compliance QC (regulatory standards), accessibility QC (closed captions, audio description), loudness QC (EBU R128/ATSC A/85), or format QC (file format and codec validation). | Column qc_type (STRING) in production.qc_review. Valid values are `technical_qc|editorial_qc|compliance_qc|accessibility_qc|loudness_qc|format_qc`',
    `re_qc_date` DATE COMMENT 'Date when the deliverable was re-reviewed after remediation. Null if no re-QC has been performed. | Column re_qc_date (DATE) in production.qc_review',
    `remediation_notes` STRING COMMENT 'Detailed notes describing the remediation actions required to address identified errors and bring the deliverable into compliance. | Column remediation_notes (STRING) in production.qc_review',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether the deliverable requires remediation or correction before final approval. True if remediation needed, False if no action required. | Column remediation_required_flag (BOOLEAN) in production.qc_review',
    `review_date` DATE COMMENT 'Date when the QC review was performed. | Column review_date (DATE) in production.qc_review',
    `review_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the QC review session in minutes. | Column review_duration_minutes (DECIMAL(10,2)) in production.qc_review',
    `review_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC operator completed the review session. | Column review_end_timestamp (TIMESTAMP) in production.qc_review',
    `review_number` STRING COMMENT 'Business identifier for the QC review, typically formatted as a human-readable reference code. | Column review_number (STRING) in production.qc_review',
    `review_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC operator began the review session. | Column review_start_timestamp (TIMESTAMP) in production.qc_review',
    `review_status` STRING COMMENT 'Current lifecycle status of the QC review process. | Column review_status (STRING) in production.qc_review. Valid values are `scheduled|in_progress|completed|on_hold|cancelled`',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.qc_review',
    `total_error_count` STRING COMMENT 'Total number of errors identified across all severity levels during the QC review. | Column total_error_count (INT) in production.qc_review',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.qc_review',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC review record was last modified. | Column updated_timestamp (TIMESTAMP) in production.qc_review',
    `video_codec` STRING COMMENT 'Video codec used in the deliverable (e.g., H.264, H.265/HEVC, ProRes, MPEG-2). | Column video_codec (STRING) in production.qc_review',
    `video_frame_rate` DECIMAL(18,2) COMMENT 'Measured video frame rate (e.g., 23.976, 25, 29.97, 50, 59.94 fps). | Column video_frame_rate (DECIMAL(18,2)) in production.qc_review',
    `video_resolution` STRING COMMENT 'Measured video resolution of the deliverable (e.g., 1920x1080, 3840x2160). | Column video_resolution (STRING) in production.qc_review',
    CONSTRAINT pk_qc_review PRIMARY KEY(`qc_review_id`)
) COMMENT 'Quality control review record for a production deliverable or post-production output. Captures QC type (technical QC, editorial QC, compliance QC, accessibility QC, loudness QC), QC operator, review date, pass/fail/conditional result, error count by severity (P1 critical, P2 major, P3 minor), specific error codes per EBU R128/ATSC A/85 loudness standards and ITU-R BT.1788 video quality standards, remediation required flag, re-QC date, and final approval status. Ensures all deliverables meet broadcast and platform technical specifications before distribution. Feeds the deliverable acceptance workflow. | Unity Catalog table: media_broadcasting_ecm.production.qc_review';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Primary key for milestone | Column milestone_id (BIGINT) in production.milestone',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: Production milestones (script lock, picture lock, delivery) are gated on rights clearance completion. Production scheduling and greenlight reporting require tracking which clearance_request must be re',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Production milestones (script delivery, picture lock, greenlight) are contractual trigger events for pay-or-play payments, step-up fees, and option exercise deadlines in talent contracts. Linking mile',
    `deal_id` BIGINT COMMENT 'Foreign key linking to distribution.deal. Business justification: Production milestones (picture lock, delivery, greenlight) are contractually tied to distribution deal deadlines. Deal milestone compliance tracking — including variance reporting and penalty exposure',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: Milestones in production are frequently tied to specific deliverable outputs (e.g., Picture Lock deliverable, Final Mix deliverable). The milestone table currently carries deliverable_description ',
    `predecessor_milestone_id` BIGINT COMMENT 'Reference to another milestone that must be completed before this milestone can begin or be achieved. | Column predecessor_milestone_id (BIGINT) in production.milestone',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Milestones can be episode-specific (e.g., picture lock for episode 3). Optional FK (nullable) — milestones may be project-level or episode-level. Enables episode-specific milestone tracking for episod | Column production_episode_id (BIGINT) in production.milestone',
    `project_id` BIGINT COMMENT 'Reference to the parent production project or episode for which this milestone is tracked. | Column production_project_id (BIGINT) in production.milestone',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Production milestones (picture lock, QC pass, final delivery) are planned backward from a committed program schedule air date. Broadcast operations teams use this link to calculate critical-path dates',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Production milestones track progress toward content title delivery. Essential for content delivery scheduling, windowing plan coordination, and tracking production progress against content distributio | Column title_id (BIGINT) in content.milestone',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.milestone',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.milestone',
    `actual_date` DATE COMMENT 'The date on which the milestone was actually achieved or completed. Null if milestone has not yet been reached. | Column actual_date (DATE) in production.milestone',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee authorized to approve this milestone (e.g., Executive Producer, Network Executive, Showrunner). | Column approval_authority (STRING) in production.milestone',
    `approval_date` DATE COMMENT 'Date on which formal approval or sign-off was granted for this milestone. Null if approval is not yet obtained. | Column approval_date (DATE) in production.milestone',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval or sign-off is required before this milestone can be marked as achieved. | Column approval_required_flag (BOOLEAN) in production.milestone',
    `baseline_date` DATE COMMENT 'Approved baseline date for the milestone after initial project approval, used for variance tracking and performance measurement. | Column baseline_date (DATE) in production.milestone',
    `budget_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact or cost associated with achieving this milestone, or cost of delay if milestone is missed. | Column budget_impact_usd (DECIMAL(15,2)) in production.milestone',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.milestone',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system. | Column created_timestamp (TIMESTAMP) in production.milestone',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this milestone is on the critical path of the production schedule, meaning any delay directly impacts final delivery date. | Column critical_path_flag (BOOLEAN) in production.milestone',
    `dalet_workflow_reference` STRING COMMENT 'External identifier linking this milestone to the corresponding workflow or task in Dalet Galaxy Media Asset Management system. | Column dalet_workflow_reference (STRING) in production.milestone',
    `dependency_count` STRING COMMENT 'Number of other milestones or tasks that are dependent on the completion of this milestone. | Column dependency_count (INT) in production.milestone',
    `forecast_date` DATE COMMENT 'Current projected or estimated date for milestone completion based on latest production progress and risk assessment. | Column forecast_date (DATE) in production.milestone',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone indicating whether it is pending, on track, delayed, completed, or no longer applicable. | Column milestone_status (STRING) in production.milestone. Valid values are `upcoming|in_progress|at_risk|achieved|missed|cancelled`',
    `milestone_type` STRING COMMENT 'Categorical classification of the milestone within the production lifecycle. Defines the phase or gate this milestone represents. [ENUM-REF-CANDIDATE: greenlight|pre_production_start|principal_photography_start|principal_photography_end|picture_lock|audio_mix_complete|vfx_complete|color_grading_complete|final_qc_pass|delivery_to_broadcaster|archive_complete|post_production_start|rough_cut_complete|final_cut_complete|mastering_complete — promote to reference product] | Column milestone_type (STRING) in production.milestone',
    `mitigation_plan` STRING COMMENT 'Description of actions or contingency plans in place to address identified risks and ensure milestone is achieved. | Column mitigation_plan (STRING) in production.milestone',
    `milestone_name` STRING COMMENT 'Human-readable name or title of the milestone event (e.g., Greenlight Approval, Picture Lock, Final Delivery). | Column milestone_name (STRING) in production.milestone',
    `notes` STRING COMMENT 'Free-form text field for additional context, comments, or observations related to this milestone event. | Column notes (STRING) in production.milestone',
    `planned_date` DATE COMMENT 'Originally scheduled or target date for achieving this milestone as defined during production planning. | Column planned_date (DATE) in production.milestone',
    `responsible_department` STRING COMMENT 'The production department or functional area responsible for delivering this milestone. [ENUM-REF-CANDIDATE: production|post_production|vfx|audio|editorial|color|qc|delivery|archive|legal|finance — 11 candidates stripped; promote to reference product] | Column responsible_department (STRING) in production.milestone',
    `risk_description` STRING COMMENT 'Detailed explanation of identified risks, issues, or blockers that may prevent timely achievement of this milestone. | Column risk_description (STRING) in production.milestone',
    `risk_level` STRING COMMENT 'Assessment of the risk that this milestone will not be achieved on time, based on current production status and known issues. | Column risk_level (STRING) in production.milestone. Valid values are `low|medium|high|critical`',
    `sap_wbs_element` STRING COMMENT 'SAP project structure element code linking this milestone to the enterprise project management and financial tracking hierarchy. | Column sap_wbs_element (STRING) in production.milestone',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.milestone',
    `stakeholder_notification_flag` BOOLEAN COMMENT 'Indicates whether stakeholders (network executives, distributors, talent) must be notified when this milestone is achieved or at risk. | Column stakeholder_notification_flag (BOOLEAN) in production.milestone',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.milestone',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last modified or updated. | Column updated_timestamp (TIMESTAMP) in production.milestone',
    `variance_days` STRING COMMENT 'Number of days difference between planned date and actual date (positive indicates delay, negative indicates early completion). Calculated field for reporting purposes. | Column variance_days (INT) in production.milestone',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Key milestone event in the production lifecycle for a project or episode. Captures milestone type (greenlight, pre-production start, first day of photography, picture lock, audio mix complete, VFX complete, final QC pass, delivery to broadcaster, archive complete), planned date, actual date, milestone status (upcoming, at-risk, achieved, missed), responsible owner, and any associated approval or sign-off requirement. Enables production schedule tracking and stakeholder reporting against key delivery gates. | Unity Catalog table: media_broadcasting_ecm.production.milestone';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` (
    `cost_transaction_id` BIGINT COMMENT 'Primary key for cost_transaction | Column cost_transaction_id (BIGINT) in production.cost_transaction',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to production.budget_line. Business justification: Cost transactions are posted against specific budget line items. Currently uses budget_line_reference (STRING) — replacing with FK to budget_line.budget_line_id provides referential integrity and enab | Column budget_line_id (BIGINT) in production.cost_transaction',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Talent contract payments (episode fees, step-ups, pay-or-play) generate cost transactions in production accounting. AP teams and auditors must reconcile each talent cost transaction against the govern',
    `crew_assignment_id` BIGINT COMMENT 'Foreign key linking to production.crew_assignment. Business justification: Cost transactions in production include crew-related costs such as payroll, per diem, overtime, kit rentals, and travel allowances — all of which are defined on the crew_assignment record. Linking cos',
    `budget_id` BIGINT COMMENT 'Reference to the specific budget line or cost object this transaction is charged against. | Column production_budget_id (BIGINT) in production.cost_transaction',
    `project_id` BIGINT COMMENT 'Reference to the production project against which this cost transaction is posted. | Column production_project_id (BIGINT) in production.cost_transaction',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in production.cost_transaction',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in production.cost_transaction',
    `approval_date` DATE COMMENT 'Date on which the transaction was approved for payment. | Column approval_date (DATE) in production.cost_transaction',
    `cost_category_code` STRING COMMENT 'Code representing the cost category or expense type (e.g., talent, equipment, location, post-production). | Column cost_category_code (STRING) in production.cost_transaction',
    `cost_category_name` STRING COMMENT 'Descriptive name of the cost category or expense classification. | Column cost_category_name (STRING) in production.cost_transaction',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in production.cost_transaction',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost transaction record was first created in the system. | Column created_timestamp (TIMESTAMP) in production.cost_transaction',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount. | Column currency_code (STRING) in production.cost_transaction. Valid values are `^[A-Z]{3}$`',
    `cost_transaction_description` STRING COMMENT 'Detailed description or narrative of the cost transaction, including purpose and context. | Column cost_transaction_description (STRING) in production.cost_transaction',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the transaction amount to the reporting currency. | Column exchange_rate (DECIMAL(12,6)) in production.cost_transaction',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year for this transaction. | Column fiscal_period (STRING) in production.cost_transaction',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the transaction was posted for financial reporting purposes. | Column fiscal_year (STRING) in production.cost_transaction',
    `invoice_date` DATE COMMENT 'Date on the vendor invoice or billing document. | Column invoice_date (DATE) in production.cost_transaction',
    `invoice_number` STRING COMMENT 'Vendor invoice number or billing reference for this transaction. | Column invoice_number (STRING) in production.cost_transaction',
    `net_amount` DECIMAL(18,2) COMMENT 'Net transaction amount excluding taxes and other adjustments. | Column net_amount (DECIMAL(18,2)) in production.cost_transaction',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this transaction. | Column notes (STRING) in production.cost_transaction',
    `payee_name` STRING COMMENT 'Name of the individual or entity receiving payment for this transaction (e.g., crew member, contractor, petty cash recipient). | Column payee_name (STRING) in production.cost_transaction',
    `payment_date` DATE COMMENT 'Date on which payment was made or is scheduled to be made for this transaction. | Column payment_date (DATE) in production.cost_transaction',
    `payment_method` STRING COMMENT 'Method used for payment: wire transfer, check, credit card, petty cash, ACH, or payroll. | Column payment_method (STRING) in production.cost_transaction. Valid values are `wire_transfer|check|credit_card|petty_cash|ach|payroll`',
    `payment_status` STRING COMMENT 'Current payment status of the transaction: pending, approved, paid, cancelled, on hold, or rejected. | Column payment_status (STRING) in production.cost_transaction. Valid values are `pending|approved|paid|cancelled|on_hold|rejected`',
    `posting_date` DATE COMMENT 'The date on which the transaction was posted to the general ledger in SAP. | Column posting_date (DATE) in production.cost_transaction',
    `production_phase` STRING COMMENT 'Phase of production during which this cost was incurred: pre-production, principal photography, post-production, delivery, or closed. | Column production_phase (STRING) in production.cost_transaction. Valid values are `pre_production|principal_photography|post_production|delivery|closed`',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with this transaction, if applicable. | Column purchase_order_number (STRING) in production.cost_transaction',
    `reporting_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the standard reporting currency (typically USD) for consolidated financial reporting. | Column reporting_currency_amount (DECIMAL(18,2)) in production.cost_transaction',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reporting currency. | Column reporting_currency_code (STRING) in production.cost_transaction. Valid values are `^[A-Z]{3}$`',
    `sap_document_number` STRING COMMENT 'SAP S/4HANA financial document number (FI/CO posting document) associated with this transaction. | Column sap_document_number (STRING) in production.cost_transaction',
    `sap_line_item_number` STRING COMMENT 'Line item number within the SAP document for granular traceability. | Column sap_line_item_number (STRING) in production.cost_transaction',
    `sap_wbs_element` STRING COMMENT 'SAP WBS element representing the project structure node for this cost transaction. | Column sap_wbs_element (STRING) in production.cost_transaction',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in production.cost_transaction',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount associated with this transaction, if applicable. | Column tax_amount (DECIMAL(18,2)) in production.cost_transaction',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the cost transaction in the original transaction currency. | Column transaction_amount (DECIMAL(18,2)) in production.cost_transaction',
    `transaction_date` DATE COMMENT 'The date on which the cost transaction was incurred or posted in the financial system. | Column transaction_date (DATE) in production.cost_transaction',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or document reference for this cost entry. | Column transaction_number (STRING) in production.cost_transaction',
    `transaction_type` STRING COMMENT 'Classification of the cost transaction: purchase order, vendor invoice, petty cash disbursement, payroll charge, inter-company cost allocation, or credit memo. | Column transaction_type (STRING) in production.cost_transaction. Valid values are `purchase_order|vendor_invoice|petty_cash|payroll_charge|intercompany_allocation|credit_memo`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in production.cost_transaction',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost transaction record was last updated or modified. | Column updated_timestamp (TIMESTAMP) in production.cost_transaction',
    CONSTRAINT pk_cost_transaction PRIMARY KEY(`cost_transaction_id`)
) COMMENT 'Individual cost transaction record incurred during production — purchase orders, vendor invoices, petty cash disbursements, payroll charges, and inter-company cost allocations posted against a production project. Captures transaction date, transaction type, vendor or payee, cost category, budget line reference, amount, currency, SAP document number, payment status, and approver. Provides the granular financial audit trail for production spend reconciliation against the production budget. | Unity Catalog table: media_broadcasting_ecm.production.cost_transaction';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_script_id` FOREIGN KEY (`script_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`script`(`script_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_predecessor_milestone_id` FOREIGN KEY (`predecessor_milestone_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`budget`(`budget_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.master_license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.master_license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Production Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.target_ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.target_ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.actual_delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.actual_delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Spend (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.actual_spend_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.actual_spend_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Production Budget (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.approved_budget_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.approved_budget_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.co_production_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `co_production_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.co_production_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.content_genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_genre` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.content_genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.coppa_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `coppa_applicable` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.coppa_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.dalet_workflow_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.dalet_workflow_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.drm_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `drm_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.drm_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `eidr` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.eidr');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.episode_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `episode_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.episode_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_business_glossary_term' = 'FCC Broadcast License Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.fcc_license_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `fcc_license_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.fcc_license_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.greenlight_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.greenlight_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_value_regex' = 'pending|greenlighted|on_hold|cancelled|completed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.greenlight_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.greenlight_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `greenlight_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `isan` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Intellectual Property (IP) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.original_ip_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `original_ip_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.original_ip_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Production Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.post_production_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `post_production_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.post_production_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.pre_production_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `pre_production_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.pre_production_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Production Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.primary_language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `primary_language` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography End Date (Picture Wrap)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.principal_photography_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.principal_photography_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.principal_photography_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `principal_photography_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.principal_photography_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_business_glossary_term' = 'Primary Production Country');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.production_country');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_regex' = '^[A-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_3}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_country` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.production_country');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_format` SET TAGS ('dbx_business_glossary_term' = 'Production Format / Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.production_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.production_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'development|pre_production|principal_photography|post_production|delivery|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.production_phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `production_phase` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.production_phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Production Project Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.project_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.project_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.sap_wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.sap_wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_business_glossary_term' = 'Production Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `synopsis` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Target Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.target_delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.target_delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime (Minutes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.total_runtime_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.total_runtime_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.project.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.project.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.budget_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.budget_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.actual_cost_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.actual_cost_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|LOCKED|CLOSED');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.approved_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.approved_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.change_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.change_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Request Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.change_request_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.change_request_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.budget_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.budget_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Commitment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.committed_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.committed_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.contingency_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.contingency_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.contingency_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.contingency_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.cost_category_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.cost_category_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.cost_category_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.cost_category_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_value_regex' = 'ABOVE_THE_LINE|BELOW_THE_LINE|POST_PRODUCTION|CONTINGENCY|OVERHEAD');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.cost_line_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.cost_line_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `cost_line_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.exchange_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.exchange_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.fiscal_period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.fiscal_period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.fiscal_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.fiscal_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast to Complete Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.forecast_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.forecast_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Budget Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.is_greenlight_budget');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_greenlight_budget` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.is_greenlight_budget');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.is_locked');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.is_locked');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.period_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.period_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.period_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.period_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'DEVELOPMENT|PRE_PRODUCTION|PRINCIPAL_PHOTOGRAPHY|POST_PRODUCTION|DELIVERY|CLOSED');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.production_phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `production_phase` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.production_phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.reporting_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.reporting_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.revised_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `revised_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.revised_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Object ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.sap_cost_object_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.sap_cost_object_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_cost_object_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.sap_wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.sap_wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.variance_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.variance_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'ORIGINAL|REVISED_1|REVISED_2|REVISED_3|FINAL|LOCKED');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.version');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.budget_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.budget_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.budget_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.budget_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.content_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.content_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'Production Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.account_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.account_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `account_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.accrued_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.accrued_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.actual_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `actual_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.actual_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.budgeted_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.budgeted_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.committed_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `committed_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.committed_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.contingency_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.contingency_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.cost_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.cost_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Sub-Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.cost_sub_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.cost_sub_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `cost_sub_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Amount (EAC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.forecast_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.forecast_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.fringe_rate_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `fringe_rate_pct` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.fringe_rate_pct');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.gl_account_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.gl_account_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_business_glossary_term' = 'Above-the-Line (ATL) Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.is_above_the_line');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_above_the_line` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.is_above_the_line');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_business_glossary_term' = 'Union Labor Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.is_union_labor');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `is_union_labor` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.is_union_labor');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.line_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.line_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.line_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.line_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.line_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.line_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `line_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'development|pre_production|principal_photography|post_production|delivery|archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.production_phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `production_phase` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.production_phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.purchase_order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.purchase_order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budgeted Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.revised_budgeted_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `revised_budgeted_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.revised_budgeted_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_business_glossary_term' = 'Shoot End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.shoot_date_end');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_end` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.shoot_date_end');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_business_glossary_term' = 'Shoot Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.shoot_date_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `shoot_date_start` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.shoot_date_start');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligible Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.tax_credit_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.tax_credit_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.unit_of_measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.unit_of_measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.unit_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.unit_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.budget_line.wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.budget_line.wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.crew_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.crew_assignment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.production_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.production_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.assignment_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.assignment_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.assignment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.assignment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|failed|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.background_check_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.background_check_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Box Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.box_rental_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `box_rental_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.box_rental_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.contracted_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.contracted_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_business_glossary_term' = 'Screen Credit Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.credit_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.credit_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Screen Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_value_regex' = 'main_title|end_title|both|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.credit_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `credit_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.credit_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.dalet_workflow_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.dalet_workflow_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|flat|run_of_show|episodic');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.deal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.deal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `deal_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Production Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `department` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_business_glossary_term' = 'Filming Location Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.filming_location_country');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_regex' = '^[A-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_3}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `filming_location_country` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.filming_location_country');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Work Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.guaranteed_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `guaranteed_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.guaranteed_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_business_glossary_term' = 'Kit Rental Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.kit_rental_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `kit_rental_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.kit_rental_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.last_updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.last_updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `meal_penalty_eligible` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `meal_penalty_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `meal_penalty_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.meal_penalty_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `meal_penalty_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.meal_penalty_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.overtime_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.overtime_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.overtime_rate_multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.overtime_rate_multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.per_diem_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.per_diem_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.production_company');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `production_company` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.production_company');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.residuals_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `residuals_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.residuals_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Crew Role Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.role_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.role_title');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Certified Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.safety_training_certified');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `safety_training_certified` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.safety_training_certified');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `sap_personnel_action_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Personnel Action ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `sap_personnel_action_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `sap_personnel_action_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.sap_personnel_action_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `sap_personnel_action_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.sap_personnel_action_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `sap_personnel_action_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Work Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.scheduled_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `scheduled_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.scheduled_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_business_glossary_term' = 'Travel Allowance');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.travel_allowance');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `travel_allowance` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.travel_allowance');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.turnaround_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.turnaround_hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union / Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.union_guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `union_guild_affiliation` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.union_guild_affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.work_permit_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.work_permit_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.work_permit_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.work_permit_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.crew_assignment.work_permit_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.crew_assignment.work_permit_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.production_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.production_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.script_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.script_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.season_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.season_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.syndication_license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.syndication_license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.actual_cost_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.actual_cost_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.actual_delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.actual_delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_running_time_sec` SET TAGS ('dbx_business_glossary_term' = 'Actual Running Time (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_running_time_sec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_running_time_sec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.actual_running_time_sec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `actual_running_time_sec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.actual_running_time_sec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Production Budget (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.approved_budget_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `approved_budget_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.approved_budget_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Audio Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_validation_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.audio_language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.audio_language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_language_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_mix_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Audio Mix Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_mix_completion_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_mix_completion_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.audio_mix_completion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `audio_mix_completion_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.audio_mix_completion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `closed_captioning_compliant` SET TAGS ('dbx_business_glossary_term' = 'Closed Captioning Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `closed_captioning_compliant` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `closed_captioning_compliant` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.closed_captioning_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `closed_captioning_compliant` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.closed_captioning_compliant');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `color_grade_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Color Grading Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `color_grade_completion_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `color_grade_completion_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.color_grade_completion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `color_grade_completion_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.color_grade_completion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.content_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `content_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `delivery_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `delivery_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `delivery_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.delivery_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `director_name` SET TAGS ('dbx_business_glossary_term' = 'Director Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `director_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `director_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `director_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.director_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `director_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.director_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `eidr_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_business_glossary_term' = 'Episode Production Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.episode_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.episode_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.episode_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `first_air_date` SET TAGS ('dbx_business_glossary_term' = 'First Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `first_air_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `first_air_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.first_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `first_air_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.first_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_business_glossary_term' = 'Greenlight Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.greenlight_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `greenlight_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.greenlight_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{1}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `isan` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.isan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_business_glossary_term' = 'Master Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_value_regex' = 'UHD_HDR|UHD_SDR|HD_1080p|HD_720p|SD');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.master_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.master_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `master_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `picture_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Picture Lock Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `picture_lock_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `picture_lock_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.picture_lock_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `picture_lock_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.picture_lock_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_company` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_company` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.production_company');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_company` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.production_company');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.production_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.production_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `production_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_lock_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_lock_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.script_lock_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `script_lock_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.script_lock_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.shoot_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.shoot_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_country_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_end_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.shoot_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.shoot_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_location` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.shoot_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.shoot_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_start_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Photography Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.shoot_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `shoot_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.shoot_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `showrunner_name` SET TAGS ('dbx_business_glossary_term' = 'Showrunner Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `showrunner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `showrunner_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `showrunner_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.showrunner_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `showrunner_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.showrunner_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Language Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.subtitle_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.subtitle_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `target_running_time_sec` SET TAGS ('dbx_business_glossary_term' = 'Target Running Time (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `target_running_time_sec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `target_running_time_sec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.target_running_time_sec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `target_running_time_sec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.target_running_time_sec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `vfx_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Visual Effects (VFX) Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `vfx_completion_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `vfx_completion_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.vfx_completion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `vfx_completion_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.vfx_completion_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `writer_name` SET TAGS ('dbx_business_glossary_term' = 'Writer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `writer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `writer_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `writer_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.production_episode.writer_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`production_episode` ALTER COLUMN `writer_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.production_episode.writer_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_business_glossary_term' = 'Script Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.script_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.script_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Script Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.underlying_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `holder_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.underlying_rights_holder_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Writer Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Writer Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Script Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approval_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approved_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approved_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `approved_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.approved_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.confidentiality_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.confidentiality_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.copyright_holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.copyright_holder');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_year` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_year` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.copyright_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `copyright_year` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.copyright_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `dalet_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `dalet_document_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `dalet_document_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.dalet_document_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `dalet_document_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.dalet_document_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_business_glossary_term' = 'Distribution Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.distribution_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `distribution_restriction` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.distribution_restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_business_glossary_term' = 'Draft Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_value_regex' = 'outline|first draft|revised draft|shooting script|post-production script|final draft');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.draft_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.draft_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `draft_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `estimated_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Runtime in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `estimated_runtime_minutes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `estimated_runtime_minutes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.estimated_runtime_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `estimated_runtime_minutes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.estimated_runtime_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Script File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|FDX|FOUNTAIN|TXT');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.file_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.file_format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_format` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.file_size_mb');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.file_size_mb');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Script Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `format` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.format');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Script Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `genre` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Script Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `language` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.language');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.lock_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.lock_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_status` SET TAGS ('dbx_business_glossary_term' = 'Script Lock Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.lock_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `lock_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.lock_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Script Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Script Page Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.page_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `page_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.page_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Script Revision Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.revision_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.revision_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.revision_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `revision_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.revision_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.rights_clearance_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_business_glossary_term' = 'Scene Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.scene_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `scene_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.scene_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_business_glossary_term' = 'Script Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.script_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.script_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_business_glossary_term' = 'Script Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_value_regex' = 'draft|in review|approved|locked|archived|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.script_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.script_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `script_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Script Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `version_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.version_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Writers Guild of America (WGA) Registration Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.script.wga_registration_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ALTER COLUMN `wga_registration_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.script.wga_registration_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.deliverable_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.deliverable_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Clearance Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.production_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.production_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.target_ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.target_ott_platform_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.actual_delivery_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.actual_delivery_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.aspect_ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.audio_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_channels` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.audio_channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.audio_description_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `audio_description_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.audio_description_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_validation_regex' = '^[a-fA-F0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.checksum_md5');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.checksum_md5');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.closed_caption_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `closed_caption_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.closed_caption_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certificate Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.compliance_certificate_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `compliance_certificate_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.compliance_certificate_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `contract_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `contract_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.contract_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `contract_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.contract_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.cost_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `cost_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.cost_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.deliverable_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.deliverable_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.delivery_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_location` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.delivery_location');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.delivery_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.delivery_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.delivery_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.delivery_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `delivery_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.due_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.due_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.eidr_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `eidr_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.file_size_bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_validation_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.language_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `language_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.deliverable_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.deliverable_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.qc_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.qc_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Operator Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.qc_operator_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_operator_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.qc_operator_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.qc_pass_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.qc_pass_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Performed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.qc_performed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `qc_performed_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.qc_performed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.revision_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.revision_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.revision_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.revision_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.scheduled_delivery_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.scheduled_delivery_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.subtitle_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.subtitle_languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.deliverable.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.deliverable.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.qc_review_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_review_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.qc_review_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.content_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `version_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.content_version_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.deliverable_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.deliverable_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.audio_channel_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.audio_channel_configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.audio_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.audio_description_compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `audio_description_compliance_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.audio_description_compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.closed_caption_compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `closed_caption_compliance_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.closed_caption_compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.dalet_workflow_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.dalet_workflow_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Error Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.error_codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `error_codes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.error_codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.final_approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.final_approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending_approval|conditional_approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.final_approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.final_approval_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Loudness Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.loudness_compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_compliance_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.loudness_compliance_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Loudness Level (LUFS)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.loudness_lufs');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.loudness_lufs');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 1 (P1) Critical Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.p1_critical_error_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p1_critical_error_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.p1_critical_error_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 2 (P2) Major Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.p2_major_error_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p2_major_error_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.p2_major_error_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_business_glossary_term' = 'Priority 3 (P3) Minor Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.p3_minor_error_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `p3_minor_error_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.p3_minor_error_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.qc_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.qc_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.qc_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_platform` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.qc_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.qc_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_result` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.qc_result');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_value_regex' = 'technical_qc|editorial_qc|compliance_qc|accessibility_qc|loudness_qc|format_qc');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.qc_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.qc_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `qc_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Quality Control (Re-QC) Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.re_qc_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `re_qc_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.re_qc_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.remediation_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.remediation_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.remediation_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.remediation_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.review_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.review_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Duration (Minutes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.review_duration_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.review_duration_minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.review_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_end_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.review_end_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.review_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.review_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.review_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.review_start_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.review_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.review_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `review_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_business_glossary_term' = 'Total Error Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.total_error_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `total_error_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.total_error_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.video_codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_codec` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.video_frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_frame_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.video_frame_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.qc_review.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.qc_review.video_resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ALTER COLUMN `video_resolution` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.milestone_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.milestone_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.predecessor_milestone_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.predecessor_milestone_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.production_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.production_episode_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.actual_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.actual_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.approval_authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.approval_authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.approval_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.approval_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.baseline_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.baseline_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact in United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.budget_impact_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `budget_impact_usd` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.budget_impact_usd');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.critical_path_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.critical_path_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Workflow Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.dalet_workflow_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dalet_workflow_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.dalet_workflow_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_business_glossary_term' = 'Dependency Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.dependency_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.dependency_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.forecast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.forecast_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'upcoming|in_progress|at_risk|achieved|missed|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.milestone_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.milestone_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.milestone_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.milestone_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.mitigation_plan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.mitigation_plan');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.milestone_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.milestone_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.planned_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.planned_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.responsible_department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.responsible_department');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.risk_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.risk_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.risk_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.risk_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.sap_wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.sap_wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notification Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.stakeholder_notification_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `stakeholder_notification_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.stakeholder_notification_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.milestone.variance_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.milestone.variance_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Transaction Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.cost_transaction_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.cost_transaction_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.budget_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.budget_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.production_budget_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `budget_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.production_budget_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `project_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `project_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `project_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.production_project_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.approval_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.cost_category_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.cost_category_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.cost_category_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_category_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.cost_category_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.cost_transaction_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.cost_transaction_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.exchange_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.exchange_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.fiscal_period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.fiscal_period');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.fiscal_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.fiscal_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.invoice_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.invoice_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.invoice_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.invoice_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.net_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.net_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.payee_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.payee_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payee_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.payment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.payment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|credit_card|petty_cash|ach|payroll');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.payment_method');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|cancelled|on_hold|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.payment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.payment_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.posting_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.posting_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_business_glossary_term' = 'Production Phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_value_regex' = 'pre_production|principal_photography|post_production|delivery|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.production_phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `production_phase` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.production_phase');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.purchase_order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.purchase_order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.reporting_currency_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.reporting_currency_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.reporting_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.reporting_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.sap_document_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.sap_document_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Line Item Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.sap_line_item_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.sap_line_item_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.sap_wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.sap_wbs_element');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.tax_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.tax_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.transaction_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.transaction_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.transaction_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.transaction_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.transaction_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.transaction_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase_order|vendor_invoice|petty_cash|payroll_charge|intercompany_allocation|credit_memo');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.transaction_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.transaction_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.production.cost_transaction.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.production.cost_transaction.updated_timestamp');
