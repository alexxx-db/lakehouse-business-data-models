-- Schema for Domain: research | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`research` COMMENT 'Owns research and development, innovation pipeline, and NPD data. Manages R&D project portfolios, formulation development records, lab testing, clinical/consumer test results, prototype development, patent filings, INCI ingredient libraries, sensory evaluation, regulatory dossiers, and stage-gate milestone tracking for new product launches from concept to commercialization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` (
    `rd_project_id` BIGINT COMMENT 'Unique identifier for the R&D or NPD project in the innovation pipeline.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: ESG commitments drive R&D project prioritisation and reporting; linking enables project‑level ESG tracking in project portfolio dashboards.',
    `innovation_brief_id` BIGINT COMMENT 'The innovation brief id of the rd project record',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand under which this product will be launched, linking to the brand master.',
    `employee_id` BIGINT COMMENT 'Identifier of the executive or business leader sponsoring this R&D project, linking to the employee or workforce master.',
    `category_id` BIGINT COMMENT 'Identifier of the product category or segment this project targets, linking to the product taxonomy.',
    `rd_project_lead_employee_id` BIGINT COMMENT 'The rd project lead employee id of the rd project record',
    `segment_id` BIGINT COMMENT 'Foreign key linking to consumer.consumer_segment. Business justification: Project planning uses a defined consumer segment; FK enables segment‑level reporting and budget alignment.',
    `actual_launch_date` DATE COMMENT 'Actual date the product was launched commercially, if the project has reached commercialization.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total budget allocated to this R&D project for all phases, including formulation, testing, regulatory, and scale-up activities.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the rd project record',
    `budget_spent` DECIMAL(18,2) COMMENT 'Cumulative budget spent to date on this R&D project across all cost categories.',
    `business_opportunity_context` STRING COMMENT 'Description of the originating business opportunity, market gap, or consumer insight that triggered this R&D project.',
    `cancellation_reason` STRING COMMENT 'Business rationale for project cancellation if the project was terminated before completion (e.g., technical infeasibility, market shift, portfolio prioritization).',
    `rd_project_code` STRING COMMENT 'The rd project code of the rd project record',
    `competitive_benchmark` STRING COMMENT 'Description of key competitive products or market benchmarks this innovation is designed to compete against or differentiate from.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this R&D project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for target COGS and RSP (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_milestone` STRING COMMENT 'Description of the current stage-gate milestone or deliverable the project team is working toward.',
    `current_stage` STRING COMMENT 'The current stage of the rd project record',
    `rd_project_description` STRING COMMENT 'The rd project description of the rd project record',
    `desired_benefits` STRING COMMENT 'Key consumer benefits or product claims the innovation aims to deliver (e.g., moisturizing, long-lasting, eco-friendly, allergen-free).',
    `effective_from` DATE COMMENT 'The effective from of the rd project record',
    `effective_until` DATE COMMENT 'The effective until of the rd project record',
    `key_performance_indicators` STRING COMMENT 'List of key performance indicators defined in the innovation brief to measure project success (e.g., consumer acceptance score, margin target, time-to-market).',
    `lessons_learned` STRING COMMENT 'Summary of key learnings, best practices, and insights captured from this project for future R&D initiatives.',
    `milestone_due_date` DATE COMMENT 'Target completion date for the current milestone in the project timeline.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this R&D project record was last updated in the system.',
    `rd_project_name` STRING COMMENT 'The rd project name of the rd project record',
    `notes` STRING COMMENT 'The notes of the rd project record',
    `patent_filing_status` STRING COMMENT 'Status of intellectual property protection for this innovation: not applicable, planned, filed, granted, or rejected.. Valid values are `not_applicable|planned|filed|granted|rejected`',
    `patent_number` STRING COMMENT 'Patent application or grant number if intellectual property protection has been filed or granted for this innovation.',
    `portfolio_category` STRING COMMENT 'The portfolio category of the rd project record',
    `priority` STRING COMMENT 'The priority of the rd project record',
    `project_code` STRING COMMENT 'Business-assigned alphanumeric code for the R&D project, used for external communication and cross-functional reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `project_completion_date` DATE COMMENT 'Date the R&D project was completed, either through successful commercialization or formal closure.',
    `project_name` STRING COMMENT 'Human-readable name or title of the R&D project, typically reflecting the innovation brief or product concept.',
    `project_start_date` DATE COMMENT 'Date the R&D project was officially initiated and entered the innovation pipeline.',
    `project_status` STRING COMMENT 'Current lifecycle status of the R&D project: active, on hold, cancelled, completed, or archived.. Valid values are `active|on_hold|cancelled|completed|archived`',
    `project_type` STRING COMMENT 'Classification of the R&D project by innovation category: new product development, reformulation, line extension, cost optimization, packaging innovation, or sustainability initiative.. Valid values are `new_product|reformulation|line_extension|cost_optimization|packaging_innovation|sustainability_initiative`',
    `rd_project_status` STRING COMMENT 'The rd project status of the rd project record',
    `regulatory_pathway` STRING COMMENT 'Description of the regulatory approval pathway required for this product (e.g., FDA OTC monograph, EU cosmetics notification, EPA registration).',
    `risk_assessment` STRING COMMENT 'Overall risk level assessment for the project considering technical feasibility, regulatory complexity, market acceptance, and supply chain readiness.. Valid values are `low|medium|high|critical`',
    `risk_level` STRING COMMENT 'The risk level of the rd project record',
    `source_system_code` STRING COMMENT 'The source system code of the rd project record',
    `stage_gate_phase` STRING COMMENT 'Current stage-gate phase of the project in the NPD process: ideation, concept, feasibility, development, validation, scale-up, launch, or post-launch review. [ENUM-REF-CANDIDATE: ideation|concept|feasibility|development|validation|scale_up|launch|post_launch — 8 candidates stripped; promote to reference product]',
    `start_date` DATE COMMENT 'The start date of the rd project record',
    `strategic_fit_rationale` STRING COMMENT 'Business justification explaining how this project aligns with corporate strategy, brand positioning, and portfolio objectives.',
    `strategic_priority_tier` STRING COMMENT 'Strategic importance classification of the project: tier 1 (critical/flagship), tier 2 (important), tier 3 (standard), or exploratory (research).. Valid values are `tier_1|tier_2|tier_3|exploratory`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Quantitative sustainability assessment score for this project, measuring environmental impact, renewable sourcing, and circular economy alignment.',
    `target_cogs` DECIMAL(18,2) COMMENT 'Target cost of goods sold per unit for the product, as specified in the innovation brief to ensure profitability.',
    `target_consumer_segment` STRING COMMENT 'Description of the target consumer demographic, psychographic, or behavioral segment for this innovation, as defined in the innovation brief.',
    `target_launch_date` DATE COMMENT 'Planned date for commercial launch of the product resulting from this R&D project.',
    `target_rsp` DECIMAL(18,2) COMMENT 'Target recommended selling price per unit for the product at retail, as specified in the innovation brief.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the rd project record',
    CONSTRAINT pk_rd_project PRIMARY KEY(`rd_project_id`)
) COMMENT 'Master record for all R&D and NPD projects in the innovation pipeline, from initial business opportunity through commercialization. Captures project identity, innovation brief details (target consumer, desired benefits, cost/RSP targets, competitive benchmarks, strategic fit rationale, key performance indicators), stage-gate phase, project type (new product, reformulation, line extension, cost optimization), target launch date, project sponsor, brand alignment, strategic priority tier, budget allocation, resource assignment, current milestone status, and the originating business opportunity context. Serves as the backbone of the R&D portfolio management function and links all downstream formulation, testing, regulatory, and scale-up activities. Subsumes the innovation brief as the project inception record.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` (
    `stage_gate_milestone_id` BIGINT COMMENT 'Unique identifier for the stage gate milestone record. Primary key.',
    `employee_id` BIGINT COMMENT 'The approver employee id of the stage gate milestone record',
    `primary_stage_employee_id` BIGINT COMMENT 'Identifier of the executive or senior leader responsible for chairing the gate review and making the final gate decision.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the R&D project to which this stage gate milestone belongs.',
    `tertiary_stage_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified this stage gate milestone record, used for audit and accountability purposes.',
    `action_items` STRING COMMENT 'Summary of key action items, conditions, and follow-up tasks assigned during the gate review that must be completed before proceeding or for the next gate.',
    `actual_date` DATE COMMENT 'The actual date of the stage gate milestone record',
    `stage_gate_milestone_code` STRING COMMENT 'The stage gate milestone code of the stage gate milestone record',
    `consumer_acceptance_score` DECIMAL(18,2) COMMENT 'Quantitative score from consumer testing and sensory evaluation reflecting target consumer acceptance, purchase intent, and preference versus competitive products.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stage gate milestone record was first created in the system, used for audit trail and data lineage tracking.',
    `decision` STRING COMMENT 'The decision of the stage gate milestone record',
    `decision_date` DATE COMMENT 'The decision date of the stage gate milestone record',
    `decision_rationale` STRING COMMENT 'Detailed explanation of the business reasoning, risk assessment, and strategic considerations that led to the gate decision outcome.',
    `delay_reason` STRING COMMENT 'Explanation of the root cause for any delay in the gate review milestone, such as incomplete deliverables, resource constraints, technical challenges, or regulatory issues.',
    `deliverables_checklist_status` STRING COMMENT 'Overall completion status of the mandatory deliverables checklist required for this gate. Complete indicates all deliverables met, incomplete indicates gaps, partial indicates some deliverables met.. Valid values are `complete|incomplete|partial|not_applicable`',
    `deliverables_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of mandatory gate deliverables that have been completed and approved at the time of review, expressed as a value between 0.00 and 100.00.',
    `stage_gate_milestone_description` STRING COMMENT 'The stage gate milestone description of the stage gate milestone record',
    `effective_from` DATE COMMENT 'The effective from of the stage gate milestone record',
    `effective_until` DATE COMMENT 'The effective until of the stage gate milestone record',
    `gate_attendees` STRING COMMENT 'Comma-separated list of names or identifiers of executives and stakeholders who attended the gate review meeting.',
    `gate_criteria` STRING COMMENT 'The gate criteria of the stage gate milestone record',
    `gate_criteria_met_count` STRING COMMENT 'Number of mandatory gate criteria that were successfully met and approved during the review process.',
    `gate_criteria_total_count` STRING COMMENT 'Total number of mandatory gate criteria defined for this stage gate review, used to calculate criteria fulfillment rate.',
    `gate_decision` STRING COMMENT 'The formal decision outcome of the stage gate review. Go indicates approval to proceed to next stage, kill terminates the project, hold pauses for additional information, recycle returns to previous stage for rework.. Valid values are `go|kill|hold|recycle`',
    `gate_duration_days` STRING COMMENT 'Number of calendar days between the previous gate review date and this gate review date, used to track stage cycle time and NPD velocity.',
    `gate_name` STRING COMMENT 'Descriptive name of the stage gate milestone (e.g., Concept Review, Business Case Approval, Launch Readiness).',
    `gate_number` STRING COMMENT 'The formal stage gate identifier in the NPD (New Product Development) process. G0 represents concept ideation, G1 scoping, G2 business case, G3 development, G4 testing and validation, G5 launch.. Valid values are `G0|G1|G2|G3|G4|G5`',
    `gate_status` STRING COMMENT 'Current lifecycle status of the stage gate milestone. Scheduled indicates future gate, in_review indicates active review in progress, completed indicates decision made, cancelled indicates gate no longer required.. Valid values are `scheduled|in_review|completed|cancelled`',
    `investment_approved_amount` DECIMAL(18,2) COMMENT 'The financial investment amount approved by the gate review committee to fund activities in the next stage of the project, expressed in the companys reporting currency.',
    `investment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved investment amount.. Valid values are `^[A-Z]{3}$`',
    `is_milestone_delayed` BOOLEAN COMMENT 'Boolean flag indicating whether this gate milestone was delayed beyond its originally scheduled review date. True indicates delay occurred, False indicates on-time or early completion.',
    `market_attractiveness_score` DECIMAL(18,2) COMMENT 'Quantitative score reflecting the commercial attractiveness of the target market, considering market size, growth rate, competitive intensity, and strategic fit.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stage gate milestone record was last modified, used for audit trail and change tracking.',
    `stage_gate_milestone_name` STRING COMMENT 'The stage gate milestone name of the stage gate milestone record',
    `next_gate_target_date` DATE COMMENT 'The planned target date for the next stage gate review milestone in the project lifecycle, used for forward planning and resource allocation.',
    `notes` STRING COMMENT 'The notes of the stage gate milestone record',
    `npv_estimate` DECIMAL(18,2) COMMENT 'The estimated net present value of the project calculated at this gate, used for portfolio prioritization and go/kill decision making.',
    `planned_date` DATE COMMENT 'The planned date of the stage gate milestone record',
    `regulatory_compliance_status` STRING COMMENT 'Assessment of the projects compliance with applicable regulatory requirements (FDA, EPA, REACH, etc.) at this gate. Compliant indicates all requirements met, non_compliant indicates gaps, pending_review indicates assessment in progress.. Valid values are `compliant|non_compliant|pending_review|not_assessed`',
    `review_date` DATE COMMENT 'The date on which the formal stage gate review meeting was conducted and the gate decision was made.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned during the gate review, reflecting technical, commercial, regulatory, and operational risks associated with proceeding to the next stage.',
    `roi_estimate_percentage` DECIMAL(18,2) COMMENT 'The estimated return on investment percentage for the project at this gate, calculated as expected return divided by investment cost.',
    `scheduled_review_date` DATE COMMENT 'The originally planned date for the stage gate review, used to track schedule adherence and milestone slippage.',
    `source_system_code` STRING COMMENT 'The source system code of the stage gate milestone record',
    `stage_gate_milestone_status` STRING COMMENT 'The stage gate milestone status of the stage gate milestone record',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Quantitative score reflecting the environmental and social sustainability profile of the project, considering carbon footprint, sustainable sourcing, packaging recyclability, and social impact.',
    `technical_feasibility_score` DECIMAL(18,2) COMMENT 'Quantitative score assessing the technical feasibility of the project, considering R&D capability, technology maturity, formulation complexity, and manufacturing readiness.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the stage gate milestone record',
    CONSTRAINT pk_stage_gate_milestone PRIMARY KEY(`stage_gate_milestone_id`)
) COMMENT 'Tracks each formal stage-gate review milestone within an R&D project lifecycle. Records gate number (G0 concept through G5 launch), gate decision (go/kill/hold/recycle), review date, gate owner, decision rationale, deliverables checklist completion status, and next gate target date. Enables portfolio governance and NPD pipeline velocity tracking across all active projects.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` (
    `research_formulation_id` BIGINT COMMENT 'Unique identifier for the product formulation record. Primary key for the research formulation entity.',
    `rd_project_id` BIGINT COMMENT 'Identifier linking this formulation to the parent R&D project portfolio. Enables tracking of formulations within broader innovation initiatives.',
    `employee_id` BIGINT COMMENT 'The research formulator employee id of the research formulation record',
    `research_responsible_employee_id` BIGINT COMMENT 'Identifier of the principal scientist or formulation chemist responsible for developing this formulation.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to consumer.consumer_segment. Business justification: Formulation development targets a specific consumer segment; linking ensures alignment with market research insights.',
    `product_formulation_id` BIGINT COMMENT 'FK to authoritative SSOT table product.product_formulation (cross-domain duplicate resolution).',
    `allergen_declaration` STRING COMMENT 'List of known allergens present in the formulation requiring declaration per regulatory requirements (e.g., EU Allergen List).',
    `approved_date` DATE COMMENT 'Date when the formulation received final approval for commercialization from the stage-gate review committee.',
    `batch_size_kg` DECIMAL(18,2) COMMENT 'Standard production batch size in kilograms for manufacturing scale-up planning. Based on pilot plant or commercial production capacity.',
    `claim_support_required` BOOLEAN COMMENT 'Indicates whether the formulation requires clinical or consumer testing to substantiate marketing claims (e.g., anti-aging, moisturizing efficacy).',
    `research_formulation_code` STRING COMMENT 'The research formulation code of the research formulation record',
    `consumer_test_score` DECIMAL(18,2) COMMENT 'Average consumer acceptance score from home-use testing or clinical trials. Scale typically 0-10 or 0-100 depending on protocol.',
    `cooling_rate_celsius_per_min` DECIMAL(18,2) COMMENT 'Controlled cooling rate in degrees Celsius per minute after mixing. Important for emulsion stability and crystal formation control.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost target (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_target_per_unit` DECIMAL(18,2) COMMENT 'Target manufacturing cost per unit for the formulation. Used for feasibility assessment and margin analysis during NPD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the formulation record was first created in the R&D system. Audit trail for record lifecycle.',
    `cruelty_free_flag` BOOLEAN COMMENT 'Indicates whether the formulation and its ingredients have not been tested on animals, meeting cruelty-free certification standards.',
    `research_formulation_description` STRING COMMENT 'The research formulation description of the research formulation record',
    `development_status` STRING COMMENT 'Current stage of the formulation in the R&D lifecycle. Tracks progression through stage-gate process from ideation to commercialization approval. [ENUM-REF-CANDIDATE: concept|experimental|prototype|pilot|validation|approved|discontinued|on_hold — 8 candidates stripped; promote to reference product]',
    `discontinued_date` DATE COMMENT 'Date when the formulation was discontinued or archived. Null if still active in the development pipeline.',
    `effective_from` DATE COMMENT 'The effective from of the research formulation record',
    `effective_until` DATE COMMENT 'The effective until of the research formulation record',
    `formulation_code` STRING COMMENT 'Unique business identifier assigned to the formulation in the R&D system. Used for cross-referencing across lab notebooks, pilot batches, and regulatory submissions.. Valid values are `^[A-Z0-9]{6,12}$`',
    `formulation_description` STRING COMMENT 'Detailed technical description of the formulation including intended use, key benefits, and distinguishing characteristics. Used for internal documentation and regulatory submissions.',
    `formulation_name` STRING COMMENT 'Descriptive name of the formulation assigned by the R&D team. May include project codename or working title.',
    `formulation_type` STRING COMMENT 'Physical form and application method of the formulation. Critical for manufacturing process design and packaging selection. [ENUM-REF-CANDIDATE: leave_on|rinse_off|solid|liquid|aerosol|gel|cream|powder|emulsion|suspension — 10 candidates stripped; promote to reference product]',
    `fragrance_type` STRING COMMENT 'Classification of fragrance used in the formulation. Important for allergen labeling and consumer preference targeting.. Valid values are `fragrance_free|hypoallergenic|standard|premium|custom`',
    `inci_declaration` STRING COMMENT 'The inci declaration of the research formulation record',
    `is_cruelty_free` BOOLEAN COMMENT 'The is cruelty free of the research formulation record',
    `is_vegan` BOOLEAN COMMENT 'The is vegan of the research formulation record',
    `lab_notebook_reference` STRING COMMENT 'The lab notebook reference of the research formulation record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the formulation record. Tracks version history and change management.',
    `lifecycle_stage` STRING COMMENT 'The lifecycle stage of the research formulation record',
    `microbiological_challenge_test_passed` BOOLEAN COMMENT 'Indicates whether the formulation passed preservative efficacy testing (challenge test) demonstrating adequate antimicrobial protection.',
    `mixing_temperature_celsius` DECIMAL(18,2) COMMENT 'Optimal mixing temperature in degrees Celsius for formulation processing. Affects ingredient solubility and stability.',
    `mixing_time_minutes` STRING COMMENT 'Required mixing duration in minutes to achieve homogeneous formulation. Critical process parameter for manufacturing instructions.',
    `research_formulation_name` STRING COMMENT 'The research formulation name of the research formulation record',
    `natural_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of ingredients derived from natural sources per ISO 16128 standard. Used for natural/organic product claims.',
    `notes` STRING COMMENT 'The notes of the research formulation record',
    `patent_filed_flag` BOOLEAN COMMENT 'Indicates whether a patent application has been filed for this formulation or its novel components.',
    `patent_number` STRING COMMENT 'Patent application or grant number if applicable. Confidential intellectual property reference.',
    `ph_max` DECIMAL(18,2) COMMENT 'The ph max of the research formulation record',
    `ph_min` DECIMAL(18,2) COMMENT 'The ph min of the research formulation record',
    `preservative_system` STRING COMMENT 'Description of the antimicrobial preservative system used in the formulation. Critical for microbial stability and regulatory compliance.',
    `product_category` STRING COMMENT 'High-level product category classification for the formulation. Aligns with the companys product portfolio segmentation. [ENUM-REF-CANDIDATE: skin_care|hair_care|oral_care|personal_hygiene|household_cleaning|baby_care|cosmetics|fragrance|other — 9 candidates stripped; promote to reference product]',
    `regulatory_classification` STRING COMMENT 'Regulatory category classification for the formulation. Determines applicable compliance requirements and approval pathways.. Valid values are `cosmetic|otc_drug|medical_device|biocide|food_contact|general_consumer_product`',
    `research_formulation_status` STRING COMMENT 'The research formulation status of the research formulation record',
    `safety_assessment_status` STRING COMMENT 'Status of toxicological safety assessment and risk evaluation for the formulation. Required for regulatory compliance.. Valid values are `not_started|in_progress|approved|rejected|pending_data`',
    `sensory_evaluation_score` DECIMAL(18,2) COMMENT 'Composite score from trained panel sensory evaluation assessing appearance, texture, fragrance, and application properties. Scale typically 0-10.',
    `shelf_life_target_months` STRING COMMENT 'Target shelf life duration in months from manufacturing date. Based on stability testing and regulatory requirements for the product category.',
    `source_system_code` STRING COMMENT 'The source system code of the research formulation record',
    `stability_test_status` STRING COMMENT 'Current status of accelerated and real-time stability testing program for the formulation. Required for shelf-life validation.. Valid values are `not_started|in_progress|passed|failed|conditional`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Composite sustainability rating for the formulation based on ingredient sourcing, biodegradability, and environmental impact. Scale typically 0-100.',
    `target_consumer_segment` STRING COMMENT 'Intended consumer demographic or market segment for the formulation (e.g., sensitive skin, anti-aging, professional use, mass market).',
    `target_ph_max` DECIMAL(18,2) COMMENT 'Maximum acceptable pH value for the formulation. Defines upper bound of acceptable pH range for quality control.',
    `target_ph_min` DECIMAL(18,2) COMMENT 'Minimum acceptable pH value for the formulation. Critical for product stability, efficacy, and skin compatibility.',
    `target_viscosity_cps` DECIMAL(18,2) COMMENT 'Target viscosity measurement in centipoise (cps) for the formulation. Critical quality parameter for product consistency and manufacturing processability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research formulation record',
    `vegan_compliant_flag` BOOLEAN COMMENT 'Indicates whether the formulation contains no animal-derived ingredients and meets vegan certification criteria.',
    `version_number` STRING COMMENT 'Version identifier for the formulation following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Incremented with each iteration or modification during development.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `viscosity_cps` DECIMAL(18,2) COMMENT 'The viscosity cps of the research formulation record',
    CONSTRAINT pk_research_formulation PRIMARY KEY(`research_formulation_id`)
) COMMENT 'Master record for product formulations developed in R&D labs. Captures formulation code, version number, formulation name, product category, formulation type (leave-on, rinse-off, solid, liquid, aerosol), development status (experimental, prototype, pilot, approved), target viscosity, pH range, shelf-life target, and the R&D project it belongs to. Serves as the SSOT for all formulation development records across the CPG/FMCG portfolio. [SSOT] Superseded by authoritative table product.product_formulation for concept formulation. SSOT: canonical table is product.product_formulation. [SSOT: authoritative table is product.product_formulation; this is a deprecated duplicate for concept formulation.] [SSOT for concept formulation.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` (
    `research_formulation_ingredient_id` BIGINT COMMENT 'Unique identifier for each ingredient line within a formulation. Primary key for the formulation bill of materials (BOM) at ingredient level.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ingredient approval workflow records which employee approved the ingredient, needed for traceability and GMP compliance.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the parent formulation record. Links this ingredient line to the overall formulation BOM.',
    `raw_material_spec_id` BIGINT COMMENT 'Foreign key linking to research.raw_material_spec. Business justification: Each formulation ingredient references a raw material; linking to raw_material_spec centralises material data and removes duplicated raw_material_code and supplier_code.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the research formulation ingredient record',
    `product_formulation_ingredient_id` BIGINT COMMENT 'FK to authoritative SSOT table product.product_formulation_ingredient (cross-domain duplicate resolution).',
    `addition_order` STRING COMMENT 'Order in which the ingredient is added within its assigned phase. Critical for process control and product quality.',
    `allergen_declaration` STRING COMMENT 'The allergen declaration of the research formulation ingredient record',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is a known or potential allergen requiring special labeling or disclosure. True if allergen.',
    `approval_date` DATE COMMENT 'Date when the ingredient was approved for use in this formulation by R&D and regulatory teams.',
    `asean_maximum_concentration_percent` DECIMAL(18,2) COMMENT 'Maximum allowable concentration percentage for this ingredient under ASEAN regulations. Null if no ASEAN-specific restriction applies.',
    `asean_restricted_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is subject to restrictions or prohibitions under ASEAN cosmetic regulations. True if restricted or prohibited.',
    `cas_number` STRING COMMENT 'Unique CAS registry number for the chemical substance. Used for regulatory submissions, safety data sheets, and global ingredient identification.. Valid values are `^d{2,7}-d{2}-d$`',
    `research_formulation_ingredient_code` STRING COMMENT 'The research formulation ingredient code of the research formulation ingredient record',
    `concentration_nominal_pct` DECIMAL(18,2) COMMENT 'The concentration nominal pct of the research formulation ingredient record',
    `concentration_pct` DECIMAL(18,2) COMMENT 'The concentration pct of the research formulation ingredient record',
    `concentration_uom` STRING COMMENT 'The concentration uom of the research formulation ingredient record',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the ingredient cost. Enables multi-currency cost management.. Valid values are `^[A-Z]{3}$`',
    `cost_per_kg` DECIMAL(18,2) COMMENT 'Standard cost per kilogram for the ingredient. Used for formulation cost analysis and NPD financial modeling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ingredient line record was first created in the system. Used for audit trail and data lineage.',
    `research_formulation_ingredient_description` STRING COMMENT 'The research formulation ingredient description of the research formulation ingredient record',
    `effective_from` DATE COMMENT 'The effective from of the research formulation ingredient record',
    `effective_until` DATE COMMENT 'The effective until of the research formulation ingredient record',
    `einecs_number` STRING COMMENT 'EINECS registry number for substances marketed in the European Union before September 1981. Required for EU regulatory compliance.. Valid values are `^d{3}-d{3}-d$`',
    `eu_maximum_concentration_percent` DECIMAL(18,2) COMMENT 'Maximum allowable concentration percentage for this ingredient under EU regulations. Null if no EU-specific restriction applies.',
    `eu_restricted_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is subject to restrictions or prohibitions under EU cosmetics regulations. True if restricted or prohibited.',
    `function_class` STRING COMMENT 'Functional classification of the ingredient within the formulation (e.g., emulsifier, preservative, fragrance, active, colorant). Used for regulatory categorization and formulation analysis. [ENUM-REF-CANDIDATE: emulsifier|preservative|fragrance|active|colorant|solvent|thickener|surfactant — 8 candidates stripped; promote to reference product]',
    `inci_name` STRING COMMENT 'Standardized INCI nomenclature name for the ingredient. Required for regulatory labeling and compliance across jurisdictions.',
    `inclusion_basis` STRING COMMENT 'Unit basis for ingredient concentration measurement (w/w = weight/weight, w/v = weight/volume, v/v = volume/volume, ppm = parts per million, ppb = parts per billion). Critical for accurate formulation and manufacturing.. Valid values are `w/w|w/v|v/v|ppm|ppb`',
    `ingredient_function` STRING COMMENT 'The ingredient function of the research formulation ingredient record',
    `ingredient_name` STRING COMMENT 'The ingredient name of the research formulation ingredient record',
    `ingredient_sequence_number` STRING COMMENT 'Sequential ordering of ingredients within the formulation BOM. Used for manufacturing process order and documentation.',
    `ingredient_status` STRING COMMENT 'Current lifecycle status of the ingredient within the formulation. Tracks approval state and usability for manufacturing.. Valid values are `active|under_review|restricted|discontinued|approved|pending_approval`',
    `is_active_ingredient` BOOLEAN COMMENT 'The is active ingredient of the research formulation ingredient record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ingredient line record was last modified. Used for change tracking and audit trail.',
    `line_number` STRING COMMENT 'The line number of the research formulation ingredient record',
    `maximum_concentration_percent` DECIMAL(18,2) COMMENT 'Maximum allowable concentration percentage for the ingredient. Defines upper bound for manufacturing tolerance and regulatory compliance.',
    `minimum_concentration_percent` DECIMAL(18,2) COMMENT 'Minimum allowable concentration percentage for the ingredient. Defines lower bound for manufacturing tolerance and quality control.',
    `research_formulation_ingredient_name` STRING COMMENT 'The research formulation ingredient name of the research formulation ingredient record',
    `natural_origin_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is derived from natural sources. Used for natural and organic product claims and certifications.',
    `notes` STRING COMMENT 'Free-text notes capturing special handling instructions, formulation rationale, or regulatory considerations for this ingredient.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the ingredient holds organic certification (e.g., USDA Organic, COSMOS). Used for organic product claims.',
    `palm_oil_derivative_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is derived from palm oil. Used for sustainability tracking and RSPO compliance.',
    `phase_assignment` STRING COMMENT 'Manufacturing phase in which the ingredient is added during production (e.g., aqueous phase, oil phase, emulsion phase). Guides manufacturing process execution.. Valid values are `aqueous|oil|emulsion|powder|fragrance|preservative`',
    `research_formulation_ingredient_status` STRING COMMENT 'The research formulation ingredient status of the research formulation ingredient record',
    `source_system_code` STRING COMMENT 'The source system code of the research formulation ingredient record',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether alternative ingredients may be substituted for this ingredient during manufacturing. True if substitution is permitted.',
    `target_concentration_percent` DECIMAL(18,2) COMMENT 'Target concentration percentage of the ingredient in the formulation. Represents the intended formulation specification.',
    `trade_name` STRING COMMENT 'Commercial or supplier-specific trade name for the ingredient. Used for procurement and supplier communication.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research formulation ingredient record',
    `us_fda_maximum_concentration_percent` DECIMAL(18,2) COMMENT 'Maximum allowable concentration percentage for this ingredient under US FDA regulations. Null if no FDA-specific restriction applies.',
    `us_fda_restricted_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is subject to restrictions or prohibitions under US FDA regulations. True if restricted or prohibited.',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is free from animal-derived substances. Used for vegan product claims and certifications.',
    CONSTRAINT pk_research_formulation_ingredient PRIMARY KEY(`research_formulation_ingredient_id`)
) COMMENT 'Line-level record of each ingredient within a formulation, representing the formulation bill of materials (BOM). Captures INCI name, trade name, supplier code, concentration percentage (min/max/target), function class (emulsifier, preservative, fragrance, active, colorant), raw material reference, inclusion basis (w/w, w/v), and regulatory restriction flags per jurisdiction (EU, US FDA, ASEAN). Enables ingredient-level traceability and regulatory compliance checking. [SSOT] Superseded by authoritative table product.product_formulation_ingredient for concept formulation_ingredient. SSOT: canonical table is product.product_formulation_ingredient. [SSOT: authoritative table is product.product_formulation_ingredient; this is a deprecated duplicate for concept formulation_ingredient.] [SSOT for concept formulation_ingredient.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` (
    `inci_library_id` BIGINT COMMENT 'Unique identifier for the INCI ingredient library record. Primary key for the enterprise master reference library of all INCI ingredients and raw materials used across R&D formulations.',
    `raw_material_spec_id` BIGINT COMMENT 'add column raw_material_spec_id (BIGINT) with FK to research.raw_material_spec.raw_material_spec_id - INCI entries map to raw material specs',
    `supplier_id` BIGINT COMMENT 'FK to procurement.supplier',
    `allergen_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient is a known or potential allergen requiring special labeling or formulation considerations. True indicates allergen status.',
    `approval_date` DATE COMMENT 'Date when the ingredient was approved for use in R&D formulations by the internal review committee. Null if not yet approved.',
    `approved_concentration_max_percentage` DECIMAL(18,2) COMMENT 'Maximum approved concentration level for use in formulations, expressed as a percentage. Based on safety assessments, regulatory limits, and stability considerations.',
    `approved_concentration_min_percentage` DECIMAL(18,2) COMMENT 'Minimum approved concentration level for use in formulations, expressed as a percentage. Based on efficacy requirements and regulatory guidance.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance. Used for precise identification of chemical compounds in regulatory filings and safety documentation.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `chemical_family` STRING COMMENT 'Broad chemical classification grouping of the ingredient (e.g., surfactants, emollients, polymers, preservatives, colorants, fragrances, botanical extracts, minerals, vitamins). Used for formulation planning and ingredient substitution analysis.',
    `inci_library_code` STRING COMMENT 'The inci library code of the inci library record',
    `color_specification` STRING COMMENT 'Acceptable color range or specification for the raw material, often described using visual standards, Lovibond scale, or spectrophotometric values. Important for maintaining product appearance consistency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this INCI library record was first created in the system. Used for audit trail and data lineage tracking.',
    `inci_library_description` STRING COMMENT 'The inci library description of the inci library record',
    `ec_number` STRING COMMENT 'Seven-digit identifier assigned to chemical substances for regulatory purposes within the European Union. Also known as EINECS, ELINCS, or NLP number depending on the list.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `effective_from` DATE COMMENT 'The effective from of the inci library record',
    `effective_until` DATE COMMENT 'The effective until of the inci library record',
    `function_category` STRING COMMENT 'The function category of the inci library record',
    `function_class` STRING COMMENT 'Primary functional role of the ingredient in formulations (e.g., emulsifier, thickener, moisturizer, active ingredient, pH adjuster, antioxidant, UV filter, fragrance component). Multiple functions may be comma-separated.',
    `grade_quality_level` STRING COMMENT 'Quality grade designation of the raw material (e.g., cosmetic grade, pharmaceutical grade, technical grade, food grade, USP, NF, BP, EP). Indicates purity level and intended application.',
    `halal_certified_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient has been certified as Halal-compliant for use in products targeting Muslim consumers. True indicates Halal certification.',
    `inci_library_status` STRING COMMENT 'The inci library status of the inci library record',
    `inci_name` STRING COMMENT 'The standardized INCI name of the ingredient as defined by the International Nomenclature Committee. This is the globally recognized ingredient name used on product labels and regulatory submissions.',
    `ingredient_function` STRING COMMENT 'The ingredient function of the inci library record',
    `is_prohibited` BOOLEAN COMMENT 'The is prohibited of the inci library record',
    `is_restricted` BOOLEAN COMMENT 'The is restricted of the inci library record',
    `kosher_certified_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient has been certified as Kosher-compliant for use in products targeting Jewish consumers. True indicates Kosher certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this INCI library record was last updated. Used for audit trail, change tracking, and data currency verification.',
    `last_review_date` DATE COMMENT 'Date of the most recent regulatory or technical review of the ingredient specifications and approval status. Used to track review currency and trigger periodic re-evaluation.',
    `maximum_permitted_concentration_percentage` DECIMAL(18,2) COMMENT 'The most restrictive maximum concentration limit imposed by any regulatory authority across all jurisdictions. Used as the global ceiling for formulation development.',
    `moisture_content_max_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable moisture content expressed as a percentage. Excess moisture can affect stability, microbial growth, and formulation performance.',
    `inci_library_name` STRING COMMENT 'The inci library name of the inci library record',
    `natural_origin_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient is derived from natural sources (plant, mineral, animal) as opposed to synthetic origin. Used for natural and organic product claims.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the ingredient specifications, regulatory status, and approval. Ensures ongoing compliance and specification currency.',
    `notes` STRING COMMENT 'Free-text field for additional technical notes, formulation guidance, handling precautions, compatibility information, or special considerations for R&D use.',
    `odor_specification` STRING COMMENT 'Acceptable odor characteristics of the raw material (e.g., characteristic, mild, odorless, specific odor profile). Critical for fragrance-sensitive formulations and consumer acceptance.',
    `origin_type` STRING COMMENT 'The origin type of the inci library record',
    `particle_size_specification` STRING COMMENT 'Specification for particle size distribution, typically expressed as a range in microns or mesh size. Critical for powder ingredients affecting texture, dispersion, and sensory properties.',
    `patent_protected_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient or its specific grade/formulation is protected by active patents. True indicates patent protection exists, requiring licensing or IP clearance.',
    `physical_form` STRING COMMENT 'Physical state and form of the raw material at standard storage conditions. Critical for handling, storage, and processing requirements in manufacturing. [ENUM-REF-CANDIDATE: solid|liquid|powder|gel|paste|granule|flake|wax|oil|emulsion|suspension — 11 candidates stripped; promote to reference product]',
    `prohibited_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient is prohibited for use in cosmetic or personal care products in any major jurisdiction. True indicates prohibition exists.',
    `purity_percentage` DECIMAL(18,2) COMMENT 'Minimum purity level of the active ingredient expressed as a percentage. Critical specification parameter for quality control and formulation accuracy.',
    `raw_material_code` STRING COMMENT 'Internal enterprise code used to identify and track the raw material in procurement, inventory, and manufacturing systems. Links to ERP material master records.',
    `rd_approval_status` STRING COMMENT 'Current approval status of the ingredient for use in R&D formulation development. Approved ingredients are cleared for use in new product development projects.. Valid values are `approved|conditional|under_review|rejected|obsolete`',
    `regulatory_status` STRING COMMENT 'The regulatory status of the inci library record',
    `regulatory_status_asean` STRING COMMENT 'Current regulatory approval status of the ingredient for use in cosmetic and personal care products within ASEAN member countries under the ASEAN Cosmetic Directive.. Valid values are `approved|restricted|prohibited|pending_review|not_evaluated`',
    `regulatory_status_canada` STRING COMMENT 'Current regulatory approval status of the ingredient for use in cosmetic and personal care products within Canada under Health Canada Cosmetic Ingredient Hotlist and regulations.. Valid values are `approved|restricted|prohibited|pending_review|not_evaluated`',
    `regulatory_status_eu` STRING COMMENT 'Current regulatory approval status of the ingredient for use in cosmetic and personal care products within the European Union under REACH and Cosmetics Regulation.. Valid values are `approved|restricted|prohibited|pending_review|not_evaluated`',
    `regulatory_status_usa` STRING COMMENT 'Current regulatory approval status of the ingredient for use in cosmetic and personal care products within the United States under FDA regulations and GRAS status where applicable.. Valid values are `approved|restricted|prohibited|pending_review|not_evaluated`',
    `restricted_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient has any regulatory restrictions, concentration limits, or usage conditions in any major jurisdiction. True indicates restrictions apply.',
    `sds_reference_number` STRING COMMENT 'Reference number or document identifier for the Safety Data Sheet associated with this raw material. Links to the detailed safety, handling, and hazard information document.',
    `source_system_code` STRING COMMENT 'The source system code of the inci library record',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the raw material including temperature range, humidity control, light protection, and special handling requirements (e.g., store in cool dry place, refrigerate, protect from light, inert atmosphere).',
    `sustainable_sourcing_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient is sourced through certified sustainable practices (e.g., FSC, RSPO, Rainforest Alliance). True indicates sustainable sourcing certification.',
    `svhc_flag` BOOLEAN COMMENT 'The svhc flag of the inci library record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the inci library record',
    `vegan_compliant_flag` BOOLEAN COMMENT 'Boolean indicator whether the ingredient is free from animal-derived components and suitable for vegan product formulations. True indicates vegan compliance.',
    CONSTRAINT pk_inci_library PRIMARY KEY(`inci_library_id`)
) COMMENT 'Enterprise master reference library and technical specification repository for all INCI ingredients and raw materials used across R&D formulations. Captures INCI name, CAS number, EC number, chemical family, function class, physical form, raw material code, supplier name, grade/quality level, specification parameters (purity, moisture content, particle size, color, odor), approved concentration range, regulatory status per major jurisdiction (EU REACH, FDA, Health Canada, ASEAN), restricted/prohibited flag, maximum permitted concentration, approved supplier grades, storage conditions, SDS reference, and R&D approval status. Serves as the single authoritative ingredient dictionary and raw material specification record for formulation development, regulatory compliance, and supplier qualification within R&D.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` (
    `lab_test_id` BIGINT COMMENT 'Unique identifier for the laboratory test record. Primary key for the lab test entity.',
    `employee_id` BIGINT COMMENT 'The lab technician employee id of the lab test record',
    `original_test_lab_test_id` BIGINT COMMENT 'Reference to the original laboratory test record if this is a retest. Links retest results back to the initial test for investigation tracking.',
    `primary_lab_employee_id` BIGINT COMMENT 'Reference to the employee or analyst who conducted the laboratory test.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the formulation or prototype being tested in this laboratory test.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project under which this laboratory test was conducted.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the lab test record',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the employee who reviewed and approved the laboratory test results.',
    `research_sample_id` BIGINT COMMENT 'Unique identifier for the physical sample or specimen submitted for testing. Links test results to the specific batch or prototype sample.',
    `analyst_name` STRING COMMENT 'Name of the laboratory analyst or technician who performed the test. Used for accountability and quality assurance purposes.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration of the test equipment used. Ensures test results are obtained using properly calibrated instruments per ISO 17025 requirements.',
    `lab_test_code` STRING COMMENT 'The lab test code of the lab test record',
    `comments` STRING COMMENT 'Free-text field for analyst comments, observations, deviations, or special notes related to the test execution or results. Captures contextual information not covered by structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory test record was first created in the system. Part of the audit trail for data governance and compliance.',
    `lab_test_description` STRING COMMENT 'The lab test description of the lab test record',
    `effective_from` DATE COMMENT 'The effective from of the lab test record',
    `effective_until` DATE COMMENT 'The effective until of the lab test record',
    `lab_location` STRING COMMENT 'Physical location or facility where the laboratory test was conducted. May reference internal R&D labs or external contract testing laboratories.',
    `lab_test_status` STRING COMMENT 'The lab test status of the lab test record',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory test record was last updated or modified. Tracks data lineage and change history for audit and compliance purposes.',
    `lab_test_name` STRING COMMENT 'The lab test name of the lab test record',
    `notes` STRING COMMENT 'The notes of the lab test record',
    `oos_flag` BOOLEAN COMMENT 'Boolean indicator that the test result is out of specification and requires investigation per Good Manufacturing Practice (GMP) requirements. True indicates OOS condition.',
    `pass_fail` STRING COMMENT 'The pass fail of the lab test record',
    `pass_fail_status` STRING COMMENT 'Determination of whether the test result meets the specified acceptance criteria. Pass indicates compliance, fail indicates non-compliance, conditional indicates marginal results requiring review, and pending indicates awaiting final determination.. Valid values are `pass|fail|conditional|pending`',
    `regulatory_flag` BOOLEAN COMMENT 'Boolean indicator that this test result is required for regulatory submission or compliance purposes (FDA, EPA, EU REACH, etc.). True indicates regulatory significance.',
    `result_status` STRING COMMENT 'The result status of the lab test record',
    `result_text` STRING COMMENT 'Qualitative or descriptive result for tests that do not produce numeric values, such as visual observations, color assessments, odor evaluations, or pass/fail determinations.',
    `result_unit` STRING COMMENT 'Unit of measurement for the test result value, such as pH units, cP (centipoise) for viscosity, CFU/g (colony forming units per gram) for microbial count, percentage, ppm (parts per million), or other industry-standard units.',
    `result_uom` STRING COMMENT 'The result uom of the lab test record',
    `result_value` DECIMAL(18,2) COMMENT 'Numeric result value obtained from the laboratory test. Represents the measured quantity or concentration of the test parameter.',
    `retest_flag` BOOLEAN COMMENT 'Boolean indicator that this test is a retest of a previous test, typically performed due to out-of-specification results or quality investigation. True indicates this is a retest.',
    `review_date` DATE COMMENT 'Date on which the test results were reviewed and approved by quality assurance personnel.',
    `reviewer_name` STRING COMMENT 'Name of the quality assurance reviewer or supervisor who verified and approved the test results. Part of the quality control review process.',
    `source_system_code` STRING COMMENT 'The source system code of the lab test record',
    `specification_limit` STRING COMMENT 'The specification limit of the lab test record',
    `specification_max` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the test parameter as defined in the product specification or regulatory requirement. Used to determine pass/fail status.',
    `specification_min` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the test parameter as defined in the product specification or regulatory requirement. Used to determine pass/fail status.',
    `specification_target` DECIMAL(18,2) COMMENT 'Target or ideal value for the test parameter as defined in the formulation design or product development goals.',
    `stability_timepoint` STRING COMMENT 'Timepoint designation for stability testing, such as initial, 1 month, 3 months, 6 months, 12 months, 24 months, or 36 months. Critical for tracking product stability over time.',
    `storage_condition` STRING COMMENT 'Environmental conditions under which the sample was stored prior to or during testing, such as room temperature, refrigerated, accelerated (40°C/75% RH), or stressed conditions. Critical for stability and shelf-life studies.',
    `test_code` STRING COMMENT 'The test code of the lab test record',
    `test_completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the laboratory test execution was completed and results were recorded.',
    `test_date` DATE COMMENT 'Date on which the laboratory test was performed. Critical for stability studies and time-dependent analyses.',
    `test_equipment` STRING COMMENT 'Identification of the laboratory equipment or instrument used to perform the test, such as pH meter, viscometer, spectrophotometer, or microbiological incubator. Used for equipment calibration tracking and audit purposes.',
    `test_method` STRING COMMENT 'Standardized test method or protocol used to conduct the laboratory test. References industry standards such as ISO, ASTM, OECD, IFRA, or internal validated methods.',
    `test_number` STRING COMMENT 'Business identifier for the laboratory test, typically assigned by the Laboratory Information Management System (LIMS) or Quality Management (QM) module.. Valid values are `^[A-Z0-9]{6,20}$`',
    `test_parameter` STRING COMMENT 'Specific parameter or property being measured in the test, such as pH, viscosity, microbial count, irritation index, color stability, fragrance retention, or active ingredient concentration.',
    `test_priority` STRING COMMENT 'Priority classification for the laboratory test. Determines scheduling and resource allocation. Critical and regulatory tests receive highest priority.. Valid values are `routine|urgent|critical|regulatory`',
    `test_result` STRING COMMENT 'The test result of the lab test record',
    `test_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the laboratory test execution began. Used for time-sensitive tests and audit trail purposes.',
    `test_status` STRING COMMENT 'Current lifecycle status of the laboratory test. Tracks the test from scheduling through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `test_type` STRING COMMENT 'Category of laboratory test performed. Defines the nature of the test such as stability testing, efficacy testing, microbiological testing, compatibility testing, sensory evaluation, safety assessment, physical property testing, or chemical analysis. [ENUM-REF-CANDIDATE: stability|efficacy|microbiological|compatibility|sensory|safety|physical|chemical — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the lab test record',
    CONSTRAINT pk_lab_test PRIMARY KEY(`lab_test_id`)
) COMMENT 'Records individual laboratory tests conducted on formulations or prototypes during R&D. Captures test type (stability, efficacy, microbiological, compatibility, pH, viscosity, irritation), test method reference (ISO, ASTM, internal), sample ID, test date, lab location, analyst, result value, result unit, pass/fail determination, and out-of-specification (OOS) flag. Provides the primary test execution record linking formulations to their performance data.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` (
    `research_stability_study_id` BIGINT COMMENT 'Unique identifier for the stability study record. Primary key for the research stability study entity.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the formulation or finished product prototype being tested in this stability study.',
    `quality_stability_study_id` BIGINT COMMENT 'FK to SSOT owner quality.quality_stability_study.quality_stability_study_id (cross-domain duplicate entity stability_study references the designated SSOT).',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the research stability study record',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory stability study report requires linking the principal investigator (lead scientist) to an employee for audit and compliance tracking.',
    `research_study_lead_employee_id` BIGINT COMMENT 'The research study lead employee id of the research stability study record',
    `approved_by` STRING COMMENT 'Name or identifier of the quality assurance manager or regulatory affairs lead who approved the final stability report.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number of the formulation being tested. Links stability data to production records.. Valid values are `^[A-Z0-9]{6,12}$`',
    `chamber_code` STRING COMMENT 'Identifier of the stability chamber or environmental room where samples are stored. Used for equipment qualification tracking and data integrity.. Valid values are `^STAB-[A-Z0-9]{3,8}$`',
    `research_stability_study_code` STRING COMMENT 'The research stability study code of the research stability study record',
    `color_stability_method` STRING COMMENT 'Analytical method used to assess color stability. Visual for subjective assessment; colorimeter for L*a*b* values; spectrophotometer for detailed spectral analysis.. Valid values are `visual|colorimeter|spectrophotometer`',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or contextual information about the stability study (e.g., unusual environmental events, protocol amendments, special handling).',
    `container_closure_system` STRING COMMENT 'Description of the primary packaging system used for the stability samples (e.g., HDPE bottle with PP cap, glass jar with aluminum seal, tube with flip-top cap). Critical for assessing product-package interaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stability study record was first created in the system. Used for audit trail and data lineage.',
    `data_source_system` STRING COMMENT 'Operational system of record from which this stability study data originated. Veeva Vault for regulatory documents; SAP QM for quality management; LIMS for laboratory data; PLM for product development; manual_entry for legacy data.. Valid values are `veeva_vault|sap_qm|lims|plm|manual_entry`',
    `research_stability_study_description` STRING COMMENT 'The research stability study description of the research stability study record',
    `deviation_count` STRING COMMENT 'Number of out-of-specification results or protocol deviations recorded during the study. Used for quality metrics and risk assessment.',
    `duration_months` STRING COMMENT 'The duration months of the research stability study record',
    `effective_from` DATE COMMENT 'The effective from of the research stability study record',
    `effective_until` DATE COMMENT 'The effective until of the research stability study record',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether the study was conducted under GMP conditions per ISO 22716 or FDA 21 CFR Part 211. Required for regulatory submissions.',
    `humidity_pct` DECIMAL(18,2) COMMENT 'The humidity pct of the research stability study record',
    `ich_condition` STRING COMMENT 'Standardized storage condition per ICH guidelines. 25°C/60%RH is long-term for temperate climates; 30°C/65%RH for subtropical; 40°C/75%RH for accelerated testing; 5°C for refrigerated; -20°C for frozen; light_exposure for photostability; cycling for freeze-thaw. [ENUM-REF-CANDIDATE: 25C_60RH|30C_65RH|40C_75RH|5C|minus_20C|light_exposure|cycling — 7 candidates stripped; promote to reference product]',
    `inci_ingredient_list` STRING COMMENT 'Comma-separated list of key active ingredients using INCI nomenclature. Used to assess ingredient stability and degradation pathways.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the stability study record was last updated. Used for audit trail and change tracking.',
    `microbial_limit_cfu_per_g` STRING COMMENT 'Maximum acceptable microbial count in colony-forming units per gram as defined in the product specification. Used to evaluate microbiological stability.',
    `research_stability_study_name` STRING COMMENT 'The research stability study name of the research stability study record',
    `notes` STRING COMMENT 'The notes of the research stability study record',
    `overall_stability_conclusion` STRING COMMENT 'Final assessment of product stability based on all time-point data. Stable indicates all parameters within specification; unstable indicates failure; marginally_stable indicates borderline performance; pending for incomplete studies.. Valid values are `stable|unstable|marginally_stable|pending|not_evaluated`',
    `ph_target_range` STRING COMMENT 'Acceptable pH range for the formulation as defined in the product specification (e.g., 5.0-6.0). Used to evaluate pH stability over time.. Valid values are `^[0-9]{1,2}.[0-9]-[0-9]{1,2}.[0-9]$`',
    `planned_duration_months` STRING COMMENT 'Total planned duration of the stability study in months. Typical values: 6 months for accelerated, 12-36 months for real-time studies.',
    `preservative_system` STRING COMMENT 'Description of the antimicrobial preservative system used in the formulation. Critical for microbial stability assessment.',
    `product_category` STRING COMMENT 'High-level classification of the product type being tested. Determines applicable regulatory frameworks and testing requirements. [ENUM-REF-CANDIDATE: skincare|haircare|oral_care|personal_hygiene|household_cleaning|food_contact|pharmaceutical — 7 candidates stripped; promote to reference product]',
    `recommended_shelf_life_months` STRING COMMENT 'Shelf life recommendation in months based on stability study results. Derived from trend analysis and specification compliance across time points.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this stability study is intended for regulatory submission (FDA, EU REACH, etc.). True for registration dossiers; false for internal development studies.',
    `report_approval_date` DATE COMMENT 'Date when the stability study report was reviewed and approved by quality assurance. Marks official closure and data lock.',
    `report_number` STRING COMMENT 'Unique identifier for the final stability study report. Used for document management and regulatory traceability.. Valid values are `^RPT-STB-[0-9]{4}-[0-9]{4}$`',
    `research_stability_study_status` STRING COMMENT 'The research stability study status of the research stability study record',
    `sample_orientation` STRING COMMENT 'Physical orientation of samples during storage. Inverted orientation tests product contact with closure; horizontal tests side-wall contact; as_marketed mimics consumer storage.. Valid values are `upright|inverted|horizontal|as_marketed`',
    `source_system_code` STRING COMMENT 'The source system code of the research stability study record',
    `specification_reference` STRING COMMENT 'Reference to the product specification document or quality standard used to evaluate pass/fail criteria for each test parameter.',
    `storage_condition` STRING COMMENT 'The storage condition of the research stability study record',
    `storage_condition_description` STRING COMMENT 'Detailed description of storage conditions including temperature range, humidity range, light exposure, and any special handling requirements beyond standard ICH conditions.',
    `study_code` STRING COMMENT 'The study code of the research stability study record',
    `study_completion_date` DATE COMMENT 'Date when the final time point was tested and the study was closed. Null for in-progress studies.',
    `study_duration_months` STRING COMMENT 'The study duration months of the research stability study record',
    `study_end_date` DATE COMMENT 'The study end date of the research stability study record',
    `study_objective` STRING COMMENT 'Business purpose and scientific objective of the stability study (e.g., shelf-life determination for new product launch, package compatibility assessment, reformulation validation, regulatory submission support).',
    `study_protocol_number` STRING COMMENT 'Unique business identifier for the stability study protocol. Used for regulatory submissions and cross-referencing.. Valid values are `^STB-[0-9]{4}-[0-9]{4}$`',
    `study_start_date` DATE COMMENT 'Date when the stability study was initiated and samples were placed on stability. Marks T=0 time point.',
    `study_status` STRING COMMENT 'Current lifecycle status of the stability study. In_progress indicates active testing; on_hold for paused studies; completed when all time points are tested; terminated for early stoppage due to failure; cancelled for administrative closure.. Valid values are `planned|in_progress|on_hold|completed|terminated|cancelled`',
    `study_type` STRING COMMENT 'Classification of the stability study type. Accelerated studies use elevated temperature/humidity to predict shelf life; real-time studies use recommended storage conditions; intermediate studies bridge accelerated and real-time; freeze-thaw tests temperature cycling; photostability tests light exposure; in-use tests consumer usage conditions.. Valid values are `accelerated|real_time|intermediate|freeze_thaw|photostability|in_use`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'The temperature celsius of the research stability study record',
    `test_parameters` STRING COMMENT 'Comma-separated list of quality attributes measured at each time point (e.g., appearance, color, odor, pH, viscosity, specific gravity, assay, microbial count, preservative efficacy). Defines the analytical scope of the study.',
    `time_point_schedule` STRING COMMENT 'Planned sampling schedule for the study (e.g., T=0, 1M, 2M, 3M, 6M, 9M, 12M, 18M, 24M). Defines when samples will be pulled and tested.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research stability study record',
    `viscosity_target_range_cps` STRING COMMENT 'Acceptable viscosity range in centipoise (cPs) as defined in the product specification. Used to evaluate rheological stability.. Valid values are `^[0-9]+-[0-9]+$`',
    CONSTRAINT pk_research_stability_study PRIMARY KEY(`research_stability_study_id`)
) COMMENT 'Master record for formal stability studies conducted on formulations and finished product prototypes, including all time-point measurement data. Captures study type (accelerated, real-time, freeze-thaw, photostability), ICH condition (25°C/60%RH, 40°C/75%RH, etc.), study start date, planned duration, container-closure system, orientation, study status, overall stability conclusion, and individual time-point measurements (T=0 through T=24M) with test parameters (appearance, pH, viscosity, assay, microbial count), measured values, specification limits, pass/fail status, and analyst sign-off. Supports trend analysis, shelf-life determination, and regulatory dossier preparation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` (
    `stability_timepoint_id` BIGINT COMMENT 'Unique identifier for the stability timepoint measurement record.',
    `employee_id` BIGINT COMMENT 'The unique identifier of the laboratory analyst or technician who performed this measurement. Used for accountability and audit trail purposes.',
    `research_stability_study_id` BIGINT COMMENT 'Foreign key linking to research.research_stability_study. Business justification: Stability timepoints belong to a specific research stability study; adding the FK creates the parent‑child relationship and removes the orphaned status.',
    `reviewer_employee_id` BIGINT COMMENT 'The unique identifier of the quality assurance reviewer or supervisor who verified and approved this measurement result.',
    `sample_id` BIGINT COMMENT 'The unique identifier of the physical sample or specimen tested at this timepoint. Links to sample management and chain-of-custody records.',
    `stability_result_id` BIGINT COMMENT 'add column stability_result_id (BIGINT) with FK to quality.stability_result.stability_result_id - research timepoints feed stability results',
    `actual_date` DATE COMMENT 'The actual date of the stability timepoint record',
    `analyst_name` STRING COMMENT 'The full name of the laboratory analyst who performed this measurement. Supports traceability and quality assurance review.',
    `appearance` STRING COMMENT 'The appearance of the stability timepoint record',
    `batch_number` STRING COMMENT 'The manufacturing batch or lot number of the product being tested in this stability study. Critical for traceability and regulatory dossier preparation.',
    `stability_timepoint_code` STRING COMMENT 'The stability timepoint code of the stability timepoint record',
    `color` STRING COMMENT 'The color of the stability timepoint record',
    `comments` STRING COMMENT 'Free-text field for analyst or reviewer observations, notes, or contextual information relevant to this timepoint measurement (e.g., sample appearance anomalies, testing conditions, procedural deviations).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this timepoint measurement record was first created in the system. Supports audit trail and data lineage.',
    `data_integrity_hash` STRING COMMENT 'A cryptographic hash or checksum of the measurement record to ensure data integrity and detect unauthorized modifications. Supports 21 CFR Part 11 compliance for electronic records.',
    `stability_timepoint_description` STRING COMMENT 'The stability timepoint description of the stability timepoint record',
    `deviation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this measurement result triggered a deviation or out-of-specification (OOS) event requiring investigation.',
    `deviation_reference_number` STRING COMMENT 'The unique identifier of the deviation or OOS investigation record if this measurement triggered a quality event. Null if no deviation occurred.',
    `effective_from` DATE COMMENT 'The effective from of the stability timepoint record',
    `effective_until` DATE COMMENT 'The effective until of the stability timepoint record',
    `instrument_code` STRING COMMENT 'The unique identifier of the laboratory instrument or equipment used to perform this measurement (e.g., pH meter serial number, viscometer ID, HPLC system ID).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this timepoint measurement record was last updated or modified. Critical for change tracking and audit compliance.',
    `measured_value` DECIMAL(18,2) COMMENT 'The observed result or reading obtained from the test at this timepoint. May be numeric, qualitative, or descriptive depending on the test parameter (e.g., 5.8 for pH, white for color, 3500 cP for viscosity).',
    `measurement_date` DATE COMMENT 'The actual calendar date on which this timepoint measurement was performed in the laboratory.',
    `stability_timepoint_name` STRING COMMENT 'The stability timepoint name of the stability timepoint record',
    `notes` STRING COMMENT 'The notes of the stability timepoint record',
    `odor` STRING COMMENT 'The odor of the stability timepoint record',
    `pass_fail` STRING COMMENT 'The pass fail of the stability timepoint record',
    `pass_fail_status` STRING COMMENT 'The compliance result indicating whether the measured value meets the specification limits (pass, fail, inconclusive, pending review, not applicable).. Valid values are `pass|fail|inconclusive|pending|not_applicable`',
    `ph_value` DECIMAL(18,2) COMMENT 'The ph value of the stability timepoint record',
    `record_status` STRING COMMENT 'The current lifecycle status of this timepoint measurement record (draft, pending review, approved, rejected, archived). Governs workflow and data release.. Valid values are `draft|pending_review|approved|rejected|archived`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this measurement result must be included in regulatory submissions or stability dossiers for product registration or renewal.',
    `retest_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this measurement was a retest or repeat analysis due to initial inconclusive or failed results.',
    `retest_reason` STRING COMMENT 'The documented justification or root cause for performing a retest of this measurement (e.g., instrument malfunction, analyst error, out-of-specification result requiring confirmation).',
    `review_date` DATE COMMENT 'The date on which the measurement result was reviewed and approved by the quality assurance reviewer.',
    `reviewer_name` STRING COMMENT 'The full name of the quality assurance reviewer who verified and approved this measurement result.',
    `scheduled_date` DATE COMMENT 'The scheduled date of the stability timepoint record',
    `source_system_code` STRING COMMENT 'The source system code of the stability timepoint record',
    `specification_lower_limit` STRING COMMENT 'The minimum acceptable value for this test parameter as defined in the product specification or stability protocol. Null if no lower limit applies.',
    `specification_target` STRING COMMENT 'The ideal or target value for this test parameter as defined in the product development specification. Used for trend analysis and quality control.',
    `specification_upper_limit` STRING COMMENT 'The maximum acceptable value for this test parameter as defined in the product specification or stability protocol. Null if no upper limit applies.',
    `stability_timepoint_status` STRING COMMENT 'The stability timepoint status of the stability timepoint record',
    `storage_condition` STRING COMMENT 'The environmental condition under which the sample was stored prior to this timepoint measurement (e.g., 25°C/60% RH, 40°C/75% RH, refrigerated, frozen, accelerated, long-term). Aligns with ICH stability testing guidelines. [ENUM-REF-CANDIDATE: 25C_60RH|30C_65RH|40C_75RH|5C|refrigerated|frozen|accelerated|long_term — 8 candidates stripped; promote to reference product]',
    `storage_humidity_pct` DECIMAL(18,2) COMMENT 'The relative humidity percentage at which the sample was stored during the stability study interval. Critical for hygroscopic products.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'The actual storage temperature in degrees Celsius at which the sample was maintained during the stability study interval.',
    `test_method_code` STRING COMMENT 'The standardized code or identifier of the analytical method or procedure used to perform this measurement (e.g., USP method, ASTM standard, internal SOP number).',
    `test_method_version` STRING COMMENT 'The version or revision number of the test method used, ensuring traceability and compliance with the correct procedure at the time of testing.',
    `test_parameter` STRING COMMENT 'The specific quality attribute or characteristic being measured at this timepoint (e.g., appearance, color, odor, pH, viscosity, assay, microbial count, preservative efficacy, active ingredient concentration). [ENUM-REF-CANDIDATE: appearance|color|odor|pH|viscosity|assay|microbial_count|preservative_efficacy|active_concentration|moisture_content|dissolution_rate|hardness|friability — promote to reference product]. Valid values are `appearance|color|odor|pH|viscosity|assay`',
    `timepoint_interval` STRING COMMENT 'The scheduled time interval at which this measurement was taken within the stability study lifecycle (e.g., T=0 for initial, T=1M for one month, T=3M for three months, T=6M for six months, T=12M for twelve months, T=24M for twenty-four months). [ENUM-REF-CANDIDATE: T=0|T=1W|T=2W|T=1M|T=2M|T=3M|T=6M|T=9M|T=12M|T=18M|T=24M|T=36M — promote to reference product]',
    `timepoint_label` STRING COMMENT 'The timepoint label of the stability timepoint record',
    `timepoint_months` DECIMAL(18,2) COMMENT 'The timepoint months of the stability timepoint record',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed (e.g., pH units, cP for viscosity, % for assay, CFU/g for microbial count, mg/mL for concentration).',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the stability timepoint record',
    `viscosity_cps` DECIMAL(18,2) COMMENT 'The viscosity cps of the stability timepoint record',
    CONSTRAINT pk_stability_timepoint PRIMARY KEY(`stability_timepoint_id`)
) COMMENT 'Individual time-point measurement records within a stability study. Captures time-point interval (T=0, T=1M, T=3M, T=6M, T=12M, T=24M), test parameter (appearance, pH, viscosity, assay, microbial count), measured value, specification limit, pass/fail status, and analyst sign-off. Enables trend analysis across the stability study lifecycle and supports shelf-life determination and regulatory dossier preparation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` (
    `consumer_test_id` BIGINT COMMENT 'Unique identifier for the consumer or clinical test record. Primary key for the consumer test entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Consumer test oversight mandates assigning a principal investigator (employee) to ensure scientific integrity and regulatory documentation.',
    `rd_project_id` BIGINT COMMENT 'The rd project id of the consumer test record',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the consumer test record',
    `sku_id` BIGINT COMMENT 'Identifier of the product being tested. Links to the product master record.',
    `study_protocol_id` BIGINT COMMENT 'External protocol number or code assigned to the study by the research team or regulatory body.',
    `respondent_id` BIGINT COMMENT 'Anonymized or pseudonymized identifier for individual test participants to enable respondent-level analysis while protecting privacy.',
    `adverse_event_description` STRING COMMENT 'Detailed description of any adverse events reported during the consumer test, including symptoms and severity.',
    `adverse_event_reported` BOOLEAN COMMENT 'Boolean flag indicating whether any adverse events (skin irritation, allergic reaction, etc.) were reported by the respondent during the test.',
    `agency_name` STRING COMMENT 'The agency name of the consumer test record',
    `claim_substantiation_outcome` STRING COMMENT 'Outcome of claim validation for this specific respondent or data point, indicating whether the claim was supported by the results.. Valid values are `substantiated|not_substantiated|partially_substantiated|pending_review`',
    `consumer_test_code` STRING COMMENT 'The consumer test code of the consumer test record',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level used in the study analysis, typically expressed as a percentage (e.g., 95.00 for 95% confidence).',
    `consumer_test_status` STRING COMMENT 'The consumer test status of the consumer test record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer test record was first created in the system.',
    `consumer_test_description` STRING COMMENT 'The consumer test description of the consumer test record',
    `effective_from` DATE COMMENT 'The effective from of the consumer test record',
    `effective_until` DATE COMMENT 'The effective until of the consumer test record',
    `efficacy_perception_rating` DECIMAL(18,2) COMMENT 'Consumer rating of perceived product efficacy or performance on a standardized scale (e.g., 1.00 to 5.00).',
    `end_date` DATE COMMENT 'The end date of the consumer test record',
    `ethics_committee_approval` BOOLEAN COMMENT 'Boolean flag indicating whether the study received ethics committee or institutional review board (IRB) approval.',
    `fragrance_rating` DECIMAL(18,2) COMMENT 'Consumer rating of product fragrance appeal on a standardized scale (e.g., 1.00 to 5.00).',
    `lather_rating` DECIMAL(18,2) COMMENT 'Consumer rating of product lather quality on a standardized scale (e.g., 1.00 to 5.00).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer test record was last modified or updated.',
    `consumer_test_name` STRING COMMENT 'The consumer test name of the consumer test record',
    `notes` STRING COMMENT 'The notes of the consumer test record',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) indicating respondent likelihood to recommend the product, typically on a 0-10 scale.',
    `open_text_verbatim` STRING COMMENT 'Free-text consumer feedback or comments captured during the test, providing qualitative insights.',
    `overall_satisfaction_rating` DECIMAL(18,2) COMMENT 'Consumer overall satisfaction rating with the product on a standardized scale (e.g., 1.00 to 5.00).',
    `overall_study_outcome` STRING COMMENT 'Summary outcome of the consumer test indicating whether the primary claim was successfully validated.. Valid values are `claim_substantiated|claim_not_substantiated|inconclusive|study_terminated`',
    `p_value` DECIMAL(18,2) COMMENT 'Statistical p-value from hypothesis testing, indicating the probability that observed results occurred by chance.',
    `panel_size` STRING COMMENT 'The panel size of the consumer test record',
    `primary_claim_tested` STRING COMMENT 'The main product claim or benefit being validated through this consumer test (e.g., reduces wrinkles in 4 weeks, long-lasting fragrance).',
    `prototype_code` STRING COMMENT 'Internal code for the prototype or formulation variant tested, used during New Product Development (NPD) before commercial SKU assignment.',
    `purchase_intent_score` STRING COMMENT 'Consumer purchase intent rating indicating likelihood to buy the product after testing, typically on a standardized scale.',
    `rating_scale_max` DECIMAL(18,2) COMMENT 'Maximum value of the rating scale used in the study (e.g., 5.00 for a 1-5 scale).',
    `rating_scale_min` DECIMAL(18,2) COMMENT 'Minimum value of the rating scale used in the study (e.g., 1.00 for a 1-5 scale).',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval or review for the consumer test study, if required by governing bodies.. Valid values are `approved|pending|not_required|rejected`',
    `sample_size` STRING COMMENT 'Total number of respondents or participants enrolled in the consumer test study.',
    `secondary_claims_tested` STRING COMMENT 'Additional product claims or benefits evaluated during the test, stored as comma-separated list.',
    `skin_feel_rating` DECIMAL(18,2) COMMENT 'Consumer rating of product skin feel or texture on a standardized scale (e.g., 1.00 to 5.00).',
    `source_system_code` STRING COMMENT 'The source system code of the consumer test record',
    `start_date` DATE COMMENT 'The start date of the consumer test record',
    `statistical_significance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the test results achieved statistical significance (True) or not (False) based on predefined confidence levels.',
    `study_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the consumer test study, including participant compensation, facility fees, and analysis costs.',
    `study_cost_currency` STRING COMMENT 'Currency code for the study cost amount, using ISO 4217 3-letter currency codes.. Valid values are `USD|EUR|GBP|JPY|CNY|INR`',
    `study_design` STRING COMMENT 'Methodological design of the study including blinding and control structure.. Valid values are `single_blind|double_blind|open_label|randomized_controlled|crossover|parallel`',
    `study_status` STRING COMMENT 'Current lifecycle status of the consumer test study.. Valid values are `planned|recruiting|in_progress|completed|terminated|cancelled`',
    `study_type` STRING COMMENT 'Type of consumer or clinical test conducted. HUT = Home Use Test, CLT = Central Location Test.. Valid values are `HUT|CLT|clinical_efficacy|dermatologist_test|sensory_evaluation|claim_substantiation`',
    `target_consumer_segment` STRING COMMENT 'Demographic or psychographic segment targeted for the test (e.g., women 25-45, sensitive skin, premium buyers).',
    `test_code` STRING COMMENT 'The test code of the consumer test record',
    `test_duration_days` STRING COMMENT 'Total duration of the consumer test in days, representing the period participants used or evaluated the product.',
    `test_end_date` DATE COMMENT 'Date when the consumer test study concluded and final data collection was completed.',
    `test_facility_name` STRING COMMENT 'Name of the laboratory, clinic, or research facility where the consumer test was conducted.',
    `test_geography` STRING COMMENT 'Geographic region or country where the consumer test was conducted, using 3-letter ISO country codes (e.g., USA, GBR, DEU).',
    `test_location` STRING COMMENT 'The test location of the consumer test record',
    `test_methodology` STRING COMMENT 'The test methodology of the consumer test record',
    `test_name` STRING COMMENT 'The test name of the consumer test record',
    `test_panel` STRING COMMENT 'Panel or cohort assignment for the respondent (e.g., control group, test group A, test group B) used in comparative studies.',
    `test_start_date` DATE COMMENT 'Date when the consumer test study commenced and participants began product usage or evaluation.',
    `test_status` STRING COMMENT 'The test status of the consumer test record',
    `test_type` STRING COMMENT 'The test type of the consumer test record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the consumer test record',
    CONSTRAINT pk_consumer_test PRIMARY KEY(`consumer_test_id`)
) COMMENT 'Master record for consumer and clinical use tests conducted to validate product performance, safety, and consumer acceptance. Captures study type (HUT, CLT, clinical efficacy, dermatologist test), study design, sample size, target consumer segment, test geography, test dates, primary claim being validated, overall study outcome, and individual respondent-level results including anonymized respondent ID, test panel, attribute ratings (lather, fragrance, skin feel, efficacy perception), rating scale values, open-text verbatims, claim substantiation outcomes, statistical significance flags, and net promoter intent scores. Enables claim validation, consumer insight generation, and NPD decision-making across the full test lifecycle.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` (
    `consumer_test_result_id` BIGINT COMMENT 'Unique identifier for the consumer test result record. Primary key.',
    `consumer_test_id` BIGINT COMMENT 'Unique identifier for the consumer test panel or study cohort.',
    `prototype_id` BIGINT COMMENT 'Identifier for the product prototype or formulation being tested.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project under which this consumer test was conducted.',
    `respondent_id` BIGINT COMMENT 'Anonymized unique identifier for the individual respondent or test subject participating in the consumer test.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to consumer.shopper. Business justification: Each test result must be attributed to the responding shopper for compliance and analytics.',
    `adverse_event_description` STRING COMMENT 'Detailed description of any adverse event or safety concern reported during the test.',
    `adverse_event_reported` BOOLEAN COMMENT 'Boolean flag indicating whether an adverse event (e.g., skin irritation, allergic reaction) was reported by the respondent (True) or not (False).',
    `attribute_measured` STRING COMMENT 'The attribute measured of the consumer test result record',
    `attribute_name` STRING COMMENT 'The attribute name of the consumer test result record',
    `attribute_tested` STRING COMMENT 'Specific product attribute or characteristic being evaluated (e.g., lather, fragrance, skin feel, efficacy perception, texture, absorption, irritation).',
    `benchmark_comparison` STRING COMMENT 'Comparison of test result to a benchmark or control product (e.g., better than benchmark, equal to benchmark, worse than benchmark, no benchmark).. Valid values are `better_than_benchmark|equal_to_benchmark|worse_than_benchmark|no_benchmark`',
    `claim_substantiation_outcome` STRING COMMENT 'Outcome of claim substantiation analysis based on test results (e.g., substantiated, not substantiated, inconclusive, pending review).. Valid values are `substantiated|not_substantiated|inconclusive|pending_review`',
    `consumer_test_result_code` STRING COMMENT 'The consumer test result code of the consumer test result record',
    `compliance_rate` DECIMAL(18,2) COMMENT 'Percentage indicating respondent adherence to the test protocol (e.g., 95.00 for 95% compliance).',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level for the test result, expressed as a percentage (e.g., 95.00 for 95% confidence).',
    `consumer_test_result_status` STRING COMMENT 'The consumer test result status of the consumer test result record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer test result record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Flag indicating the quality or validity of the test result data (e.g., valid, invalid, suspect, missing data).. Valid values are `valid|invalid|suspect|missing_data`',
    `consumer_test_result_description` STRING COMMENT 'The consumer test result description of the consumer test result record',
    `effective_from` DATE COMMENT 'The effective from of the consumer test result record',
    `effective_until` DATE COMMENT 'The effective until of the consumer test result record',
    `ethics_approval_number` STRING COMMENT 'Ethics committee or institutional review board (IRB) approval number for the consumer test study.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer test result record was last modified or updated.',
    `consumer_test_result_name` STRING COMMENT 'The consumer test result name of the consumer test result record',
    `notes` STRING COMMENT 'The notes of the consumer test result record',
    `nps_category` STRING COMMENT 'Classification of respondent based on NPS score (promoter: 9-10, passive: 7-8, detractor: 0-6).. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'Net Promoter Score indicating respondent likelihood to recommend the product, typically on a 0-10 scale.',
    `p_value` DECIMAL(18,2) COMMENT 'Statistical p-value indicating the probability that the observed result occurred by chance.',
    `principal_investigator` STRING COMMENT 'Name or identifier of the principal investigator or lead researcher responsible for the consumer test.',
    `purchase_intent` STRING COMMENT 'Respondent stated intention to purchase the product after testing.. Valid values are `definitely_would_buy|probably_would_buy|might_or_might_not_buy|probably_would_not_buy|definitely_would_not_buy`',
    `rank_position` STRING COMMENT 'The rank position of the consumer test result record',
    `rating_label` STRING COMMENT 'Qualitative label corresponding to the rating value (e.g., strongly agree, neutral, dislike extremely).',
    `rating_scale_type` STRING COMMENT 'Type of rating scale used for the evaluation (e.g., Likert 5-point, Likert 7-point, numeric 0-10, hedonic 9-point, binary yes/no, visual analog scale).. Valid values are `likert_5_point|likert_7_point|numeric_0_10|hedonic_9_point|binary_yes_no|visual_analog_scale`',
    `rating_value` DECIMAL(18,2) COMMENT 'Numeric rating value provided by the respondent for the tested attribute.',
    `recorded_date` DATE COMMENT 'The recorded date of the consumer test result record',
    `regulatory_submission_included` BOOLEAN COMMENT 'Boolean flag indicating whether this test result is included in regulatory submission dossiers (True) or not (False).',
    `respondent_demographic_segment` STRING COMMENT 'Demographic segment or profile of the respondent (e.g., age group, gender, skin type, hair type) relevant to the test.',
    `score_scale` STRING COMMENT 'The score scale of the consumer test result record',
    `score_value` DECIMAL(18,2) COMMENT 'The score value of the consumer test result record',
    `severity_level` STRING COMMENT 'Severity classification of any adverse event reported (e.g., none, mild, moderate, severe, life-threatening).. Valid values are `none|mild|moderate|severe|life_threatening`',
    `source_system_code` STRING COMMENT 'The source system code of the consumer test result record',
    `statistical_significance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the test result is statistically significant (True) or not (False).',
    `test_date` DATE COMMENT 'Date on which the consumer test or evaluation was conducted.',
    `test_duration_days` STRING COMMENT 'Duration of the consumer test in days (e.g., for home use tests).',
    `test_facility_name` STRING COMMENT 'Name of the laboratory or facility that conducted the consumer test.',
    `test_location` STRING COMMENT 'Geographic location or facility where the consumer test was conducted (e.g., lab, home, central location).',
    `test_protocol_code` STRING COMMENT 'Standardized code identifying the test protocol or methodology used.',
    `test_status` STRING COMMENT 'Current status of the consumer test result record (e.g., completed, in progress, cancelled, pending analysis).. Valid values are `completed|in_progress|cancelled|pending_analysis`',
    `test_type` STRING COMMENT 'Category of consumer or clinical test conducted (e.g., clinical use test, consumer use test, home use test, central location test, sensory evaluation, claim substantiation, safety assessment). [ENUM-REF-CANDIDATE: clinical_use_test|consumer_use_test|home_use_test|central_location_test|sensory_evaluation|claim_substantiation|safety_assessment — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the consumer test result record',
    `usage_frequency` STRING COMMENT 'Frequency with which the respondent used the product during the test period (e.g., once daily, twice daily, as needed).',
    `verbatim_comment` STRING COMMENT 'Open-text verbatim feedback or comment provided by the respondent about the product or attribute.',
    CONSTRAINT pk_consumer_test_result PRIMARY KEY(`consumer_test_result_id`)
) COMMENT 'Individual respondent-level or aggregate result records from consumer and clinical use tests. Captures respondent ID (anonymized), test panel, attribute being rated (lather, fragrance, skin feel, efficacy perception), rating scale value, open-text verbatim, claim substantiation outcome, statistical significance flag, and net promoter intent score. Enables claim validation and consumer insight generation for NPD decision-making.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` (
    `sensory_evaluation_id` BIGINT COMMENT 'Unique identifier for the sensory evaluation record. Primary key.',
    `panel_session_id` BIGINT COMMENT 'Identifier for the specific panel session, used to group multiple evaluations conducted in the same session.',
    `employee_id` BIGINT COMMENT 'Identifier of the sensory scientist or lead evaluator responsible for conducting and overseeing the evaluation session.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project under which this sensory evaluation was conducted.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the sensory evaluation record',
    `after_feel_score` DECIMAL(18,2) COMMENT 'Numerical score for the after-feel attribute, measuring the sensation after product use (e.g., moisturization, residue, stickiness).',
    `approval_status` STRING COMMENT 'Approval status of the sensory evaluation results: pending review (awaiting review by R&D leadership), approved (results accepted for decision-making), rejected (results deemed invalid), or requires retest (evaluation must be repeated).. Valid values are `pending_review|approved|rejected|requires_retest`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the sensory evaluation results were formally approved.',
    `attribute` STRING COMMENT 'The attribute of the sensory evaluation record',
    `attribute_name` STRING COMMENT 'The attribute name of the sensory evaluation record',
    `attributes_assessed` STRING COMMENT 'Comma-separated list of sensory attributes evaluated during the session (e.g., color, odor, texture, spreadability, rinse-off feel, after-feel, viscosity, foam quality, fragrance intensity).',
    `benchmark_product_code` STRING COMMENT 'Code identifying the benchmark or competitive product used for comparison in the evaluation, if applicable.',
    `blinding_method` STRING COMMENT 'Method used to prevent bias: single-blind (panelists do not know product identity), double-blind (neither panelists nor administrators know), or open-label (product identity known).. Valid values are `single_blind|double_blind|open_label`',
    `sensory_evaluation_code` STRING COMMENT 'The sensory evaluation code of the sensory evaluation record',
    `color_score` DECIMAL(18,2) COMMENT 'Numerical score for the color attribute, typically on a scale defined by the evaluation methodology (e.g., 1-9 scale).',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the sensory evaluation session was completed and results finalized.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level of the evaluation results, expressed as a percentage (e.g., 95.00 for 95% confidence).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sensory evaluation record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score assessing the reliability and validity of the evaluation data, based on factors such as panelist consistency, response completeness, and adherence to protocol.',
    `sensory_evaluation_description` STRING COMMENT 'The sensory evaluation description of the sensory evaluation record',
    `effective_from` DATE COMMENT 'The effective from of the sensory evaluation record',
    `effective_until` DATE COMMENT 'The effective until of the sensory evaluation record',
    `evaluation_code` STRING COMMENT 'Unique business identifier for the sensory evaluation session, typically formatted as SE-NNNNNN.. Valid values are `^SE-[0-9]{6}$`',
    `evaluation_date` DATE COMMENT 'The date on which the sensory evaluation panel session was conducted.',
    `evaluation_methodology` STRING COMMENT 'Sensory testing methodology used: QDA (Quantitative Descriptive Analysis), hedonic scale (liking/preference), JAR scale (Just About Right), duo-trio test, triangle test, ranking, or descriptive analysis. [ENUM-REF-CANDIDATE: qda|hedonic_scale|jar_scale|duo_trio|triangle_test|ranking|descriptive_analysis|paired_comparison|acceptance_test|discrimination_test — promote to reference product]',
    `evaluation_notes` STRING COMMENT 'Free-text notes capturing qualitative observations, panelist comments, unexpected findings, or contextual information from the evaluation session.',
    `evaluation_status` STRING COMMENT 'Current status of the sensory evaluation: scheduled (planned but not started), in progress (currently being conducted), completed (finished and results recorded), cancelled (not conducted), or on hold (temporarily paused).. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `evaluation_type` STRING COMMENT 'The evaluation type of the sensory evaluation record',
    `evaluator_count` STRING COMMENT 'The evaluator count of the sensory evaluation record',
    `formulation_version` STRING COMMENT 'Version identifier of the product formulation being tested, used to track iterations and changes.',
    `intensity_score` DECIMAL(18,2) COMMENT 'The intensity score of the sensory evaluation record',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the sensory evaluation record was last modified or updated.',
    `sensory_evaluation_name` STRING COMMENT 'The sensory evaluation name of the sensory evaluation record',
    `notes` STRING COMMENT 'The notes of the sensory evaluation record',
    `odor_score` DECIMAL(18,2) COMMENT 'Numerical score for the odor/fragrance attribute.',
    `overall_liking_score` DECIMAL(18,2) COMMENT 'Overall hedonic score representing panelists overall liking or preference for the product sample.',
    `panel_type` STRING COMMENT 'Type of sensory panel used for the evaluation: trained expert panel (highly trained sensory experts), consumer panel (target consumers), QC panel (quality control team), internal panel (company employees), or external panel (third-party evaluators).. Valid values are `trained_expert_panel|consumer_panel|qc_panel|internal_panel|external_panel`',
    `panelist_count` STRING COMMENT 'Number of panelists who participated in this sensory evaluation session.',
    `product_category` STRING COMMENT 'Category of the product being evaluated (e.g., skincare, haircare, oral care, household cleaning).',
    `product_sample_code` STRING COMMENT 'Unique code identifying the product prototype or formulation sample being evaluated. May be blinded to prevent bias.',
    `purchase_intent_score` DECIMAL(18,2) COMMENT 'Score indicating panelists likelihood to purchase the product, typically measured on a scale (e.g., 1-5 or 1-9).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sensory evaluation was conducted in compliance with applicable regulatory guidelines (e.g., FDA, EU cosmetics regulations, GMP).',
    `rinse_off_feel_score` DECIMAL(18,2) COMMENT 'Numerical score for the rinse-off feel attribute, relevant for products that are washed off (e.g., shampoos, body washes).',
    `score_scale` STRING COMMENT 'The score scale of the sensory evaluation record',
    `sensory_evaluation_status` STRING COMMENT 'The sensory evaluation status of the sensory evaluation record',
    `sensory_profile_outcome` STRING COMMENT 'Overall outcome classification of the sensory evaluation: acceptable (meets standards), unacceptable (fails standards), needs improvement (requires reformulation), exceeds expectations (superior performance), or benchmark equivalent (matches competitive standard).. Valid values are `acceptable|unacceptable|needs_improvement|exceeds_expectations|benchmark_equivalent`',
    `source_system_code` STRING COMMENT 'The source system code of the sensory evaluation record',
    `spreadability_score` DECIMAL(18,2) COMMENT 'Numerical score for the spreadability attribute, measuring ease of application.',
    `statistical_significance` STRING COMMENT 'Indication of whether the evaluation results are statistically significant based on predefined confidence levels (e.g., p<0.05).. Valid values are `significant|not_significant|inconclusive`',
    `test_conditions` STRING COMMENT 'Description of environmental and procedural conditions under which the evaluation was conducted (e.g., temperature, lighting, sample presentation order).',
    `test_location` STRING COMMENT 'Physical location or facility where the sensory evaluation was conducted (e.g., central lab, regional facility, third-party lab).',
    `texture_score` DECIMAL(18,2) COMMENT 'Numerical score for the texture attribute (e.g., smoothness, creaminess, grittiness).',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sensory evaluation record',
    CONSTRAINT pk_sensory_evaluation PRIMARY KEY(`sensory_evaluation_id`)
) COMMENT 'Records formal sensory panel evaluations of product prototypes and formulations. Captures panel type (trained expert panel, consumer panel, QC panel), evaluation date, product sample code, sensory attributes assessed (color, odor, texture, spreadability, rinse-off feel, after-feel), scoring methodology (QDA, hedonic scale, JAR scale), panelist count, and overall sensory profile outcome. Sensory evaluation is a distinct R&D sub-function with its own workflow and data structure.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`prototype` (
    `prototype_id` BIGINT COMMENT 'Unique identifier for the physical product prototype. Primary key.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Prototype packaging decisions require reference to a packaging profile for LCA, recyclability and carbon‑footprint data; link supports sustainability assessment during prototype validation.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the formulation version used in this prototype. Links the physical prototype to its chemical/ingredient composition.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project under which this prototype was developed.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the prototype record',
    `superseded_by_prototype_id` BIGINT COMMENT 'Reference to the newer prototype that supersedes this one, if applicable. Used to track prototype evolution and version history.',
    `build_date` DATE COMMENT 'The build date of the prototype record',
    `closure_type` STRING COMMENT 'Type of closure mechanism used to seal the primary container. Critical for product integrity, user experience, and safety compliance. [ENUM-REF-CANDIDATE: screw_cap|flip_top|pump_dispenser|spray|dropper|twist_off|press_on|child_resistant — 8 candidates stripped; promote to reference product]',
    `prototype_code` STRING COMMENT 'Unique business identifier for the prototype, used for tracking and reference across R&D systems and documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `compatibility_test_completion_date` DATE COMMENT 'Date when formulation-packaging compatibility testing was completed.',
    `consumer_test_eligible_flag` BOOLEAN COMMENT 'Indicates whether the prototype has been approved for consumer testing based on safety, stability, and quality criteria.',
    `container_capacity_ml` DECIMAL(18,2) COMMENT 'Total volumetric capacity of the primary container, measured in milliliters.',
    `container_diameter_mm` DECIMAL(18,2) COMMENT 'Diameter dimension of the primary container, measured in millimeters. Applicable to cylindrical containers.',
    `container_height_mm` DECIMAL(18,2) COMMENT 'Height dimension of the primary container, measured in millimeters.',
    `container_weight_grams` DECIMAL(18,2) COMMENT 'Weight of the empty primary container, measured in grams. Used for packaging cost analysis and sustainability metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prototype record was first created in the system. Used for audit trail and data lineage.',
    `decoration_method` STRING COMMENT 'Method used to apply branding, graphics, and regulatory information to the packaging. [ENUM-REF-CANDIDATE: screen_print|label|heat_transfer|in_mold_label|embossing|direct_print|sleeve — 7 candidates stripped; promote to reference product]',
    `prototype_description` STRING COMMENT 'The prototype description of the prototype record',
    `effective_from` DATE COMMENT 'The effective from of the prototype record',
    `effective_until` DATE COMMENT 'The effective until of the prototype record',
    `estimated_packaging_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of the packaging configuration per unit, including all components and decoration. Used for target COGS analysis.',
    `fill_volume_ml` DECIMAL(18,2) COMMENT 'Net volume of the product formulation filled into the prototype packaging, measured in milliliters.',
    `fill_weight` DECIMAL(18,2) COMMENT 'Net weight of the product formulation filled into the prototype packaging, measured in grams.',
    `formulation_compatibility_test_status` STRING COMMENT 'Status of compatibility testing between the formulation and packaging materials to ensure no chemical interaction, leaching, or degradation occurs.. Valid values are `not_started|in_progress|passed|failed|conditional_pass`',
    `generation` STRING COMMENT 'Generation or iteration number of the prototype (e.g., P1 for first generation, P2 for second, etc.). Indicates the stage of prototype refinement.. Valid values are `P1|P2|P3|P4|P5|P6`',
    `manufacturing_scale` STRING COMMENT 'Scale at which the prototype was manufactured, indicating the production environment and batch size capability.. Valid values are `bench|pilot|scale_up|production`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this prototype record was last modified in the system. Used for audit trail and change tracking.',
    `prototype_name` STRING COMMENT 'Descriptive name assigned to the prototype for identification and communication purposes.',
    `notes` STRING COMMENT 'General free-text notes and observations about the prototype, including development challenges, learnings, and recommendations for future iterations.',
    `packaging_approval_date` DATE COMMENT 'Date when the packaging configuration received R&D approval.',
    `packaging_approved_by` STRING COMMENT 'Name or identifier of the R&D team member who approved the packaging configuration.',
    `packaging_configuration_code` STRING COMMENT 'Unique identifier for the complete packaging configuration used in this prototype, including all components and assembly specifications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `packaging_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated packaging cost.. Valid values are `^[A-Z]{3}$`',
    `primary_container_material` STRING COMMENT 'Material composition of the primary container. Critical for compatibility testing, recyclability assessment, and regulatory compliance. [ENUM-REF-CANDIDATE: HDPE|PET|PETG|PP|glass|aluminum|paperboard|biodegradable_plastic|recycled_PET — 9 candidates stripped; promote to reference product]',
    `primary_container_type` STRING COMMENT 'Type of primary packaging component that directly contains the product formulation. [ENUM-REF-CANDIDATE: bottle|jar|tube|pouch|sachet|can|aerosol|pump|stick|compact — 10 candidates stripped; promote to reference product]',
    `prototype_status` STRING COMMENT 'Current lifecycle status of the prototype indicating its approval state and usability for further testing or production.. Valid values are `active|superseded|approved_for_consumer_test|approved_for_scale_up|rejected|archived`',
    `prototype_type` STRING COMMENT 'Classification of the prototype based on its purpose and fidelity level in the development process.. Valid values are `concept|functional|visual|pre-production|production_trial`',
    `quantity_produced` DECIMAL(18,2) COMMENT 'The quantity produced of the prototype record',
    `quantity_uom` STRING COMMENT 'The quantity uom of the prototype record',
    `rd_packaging_approval_status` STRING COMMENT 'Approval status from the R&D team indicating whether the packaging configuration meets technical and functional requirements for the prototype.. Valid values are `pending|approved|rejected|conditional_approval`',
    `recyclability_classification` STRING COMMENT 'Classification of the packaging recyclability based on material composition and local recycling infrastructure availability. Critical for sustainability reporting.. Valid values are `widely_recyclable|limited_recyclability|not_recyclable|compostable|biodegradable`',
    `recycled_content_percent` DECIMAL(18,2) COMMENT 'Percentage of recycled material content in the packaging. Used for sustainability metrics and regulatory reporting.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text notes documenting regulatory considerations, compliance requirements, and any special handling or labeling requirements for the prototype.',
    `safety_assessment_status` STRING COMMENT 'Status of safety assessment and toxicological evaluation for the prototype, ensuring compliance with regulatory requirements.. Valid values are `not_started|in_progress|passed|failed|conditional_pass`',
    `secondary_packaging_type` STRING COMMENT 'Type of secondary packaging used to protect and display the primary container at retail.. Valid values are `carton|blister|shrink_wrap|clamshell|none`',
    `source_system_code` STRING COMMENT 'The source system code of the prototype record',
    `stability_test_status` STRING COMMENT 'Status of stability testing to assess the prototypes shelf life, performance under various environmental conditions, and formulation integrity over time.. Valid values are `not_started|in_progress|passed|failed`',
    `superseded_date` DATE COMMENT 'Date when this prototype was superseded by a newer version.',
    `sustainable_material_flag` BOOLEAN COMMENT 'Indicates whether the packaging uses sustainable materials such as recycled content, bio-based plastics, or FSC-certified paperboard.',
    `target_launch_market` STRING COMMENT 'Three-letter ISO country code representing the primary geographic market for which this prototype is being developed.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the prototype record',
    `version` STRING COMMENT 'The version of the prototype record',
    `version_number` STRING COMMENT 'The version number of the prototype record',
    `creation_date` DATE COMMENT 'Date when the physical prototype was created or manufactured. Represents the principal business event timestamp for this entity.',
    CONSTRAINT pk_prototype PRIMARY KEY(`prototype_id`)
) COMMENT 'Master record for physical product prototypes developed during the NPD process, including associated packaging component specifications. Captures prototype code, prototype generation (P1, P2, P3), associated formulation version, packaging configuration with component-level detail (component type, material type — HDPE, PET, glass, aluminum, paperboard — dimensions, weight, closure type, decoration method, compatibility test status with formulation, recyclability classification), fill weight/volume, manufacturing scale (bench, pilot, scale-up), prototype creation date, prototype status (active, superseded, approved for consumer test), R&D packaging approval status, and the R&D project it belongs to. Prototypes are distinct from formulations — they represent the physical product iteration including packaging.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` (
    `patent_filing_id` BIGINT COMMENT 'Unique identifier for the patent filing record. Primary key for the patent filing entity.',
    `patent_family_id` BIGINT COMMENT 'Identifier linking related patent applications filed in multiple jurisdictions claiming the same priority. Used to track global patent family coverage.',
    `employee_id` BIGINT COMMENT 'The patent inventor employee id of the patent filing record',
    `primary_patent_employee_id` BIGINT COMMENT 'User identifier of the person who created this patent filing record in the system. Used for audit trail and data stewardship accountability.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the specific formulation or composition of matter that is the subject of this patent filing. Links patent to the proprietary formula being protected.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project that generated this patent filing. Links the patent to the originating innovation initiative.',
    `abstract` STRING COMMENT 'Brief technical summary of the invention as filed with the patent office. Typically 150-250 words describing the problem solved, the solution, and key technical features.',
    `application_number` STRING COMMENT 'Official application number assigned by the patent office upon filing. Unique identifier used for tracking prosecution status with the patent authority.',
    `assignee_country_code` STRING COMMENT 'Three-letter ISO country code of the assignees country of incorporation or residence. Used for IP portfolio geographic analysis. [ENUM-REF-CANDIDATE: USA|GBR|DEU|FRA|JPN|CHN|KOR|CAN|AUS|BRA|IND|MEX — 12 candidates stripped; promote to reference product]',
    `assignee_name` STRING COMMENT 'Legal entity that owns the patent rights, typically the employer of the inventors. For Consumer Goods patents, this is usually the company name or a subsidiary.',
    `backward_citations_count` STRING COMMENT 'Number of prior art patents and publications cited by this patent application. Indicates the breadth of prior art landscape and novelty assessment complexity.',
    `claims_count` STRING COMMENT 'Total number of claims in the patent application. Claims define the legal scope of protection. Higher claim counts typically indicate broader or more complex inventions.',
    `patent_filing_code` STRING COMMENT 'The patent filing code of the patent filing record',
    `commercial_value_tier` STRING COMMENT 'Internal assessment of the patents commercial importance to the business. Strategic patents protect core technologies or blockbuster products. High-value patents have clear revenue impact. Low-value or exploratory patents may be defensive or speculative.. Valid values are `strategic|high|medium|low|exploratory`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated annual maintenance cost. Typically USD for global IP portfolio reporting. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|KRW|CAD|AUD|BRL|INR|MXN — 11 candidates stripped; promote to reference product]',
    `cpc_class` STRING COMMENT 'Primary CPC classification code. CPC is a joint classification system developed by EPO and USPTO, providing more granular technology classification than IPC.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patent filing record was first created in the system. Used for data lineage and audit trail purposes.',
    `patent_filing_description` STRING COMMENT 'The patent filing description of the patent filing record',
    `effective_from` DATE COMMENT 'The effective from of the patent filing record',
    `effective_until` DATE COMMENT 'The effective until of the patent filing record',
    `estimated_annual_maintenance_cost` DECIMAL(18,2) COMMENT 'Projected annual cost to maintain the patent in force, including official fees, agent fees, and translation costs across all jurisdictions. Used for IP portfolio cost-benefit analysis.',
    `expiry_date` DATE COMMENT 'Date the patent protection expires, typically 20 years from filing date for utility patents. After this date, the invention enters the public domain.',
    `filing_date` DATE COMMENT 'Date the patent application was officially filed with the patent office. Establishes priority date for novelty and non-obviousness assessment.',
    `filing_number` STRING COMMENT 'The filing number of the patent filing record',
    `filing_status` STRING COMMENT 'The filing status of the patent filing record',
    `forward_citations_count` STRING COMMENT 'Number of times this patent has been cited by subsequent patent applications. High forward citation count indicates influential or foundational technology.',
    `freedom_to_operate_status` STRING COMMENT 'Assessment of whether the patented technology can be commercialized without infringing third-party patents. Cleared indicates no blocking patents found. Risk identified or blocked indicates potential infringement issues requiring licensing or design-around.. Valid values are `cleared|risk identified|under review|blocked|not assessed`',
    `grant_date` DATE COMMENT 'Date the patent was officially granted by the patent office. Marks the beginning of enforceable patent rights. Null if patent has not yet been granted.',
    `grant_number` STRING COMMENT 'The grant number of the patent filing record',
    `independent_claims_count` STRING COMMENT 'Number of independent claims in the patent. Independent claims stand alone and define the broadest scope of protection. Typically 1-5 independent claims per patent.',
    `internal_reference_code` STRING COMMENT 'Company-specific internal tracking code or docket number for the patent filing. Used for cross-referencing with R&D project records and financial systems.',
    `inventors_list` STRING COMMENT 'Semicolon-separated list of inventors named on the patent application. Inventors are the individuals who conceived the invention. Format: LastName, FirstName; LastName, FirstName.',
    `jurisdiction` STRING COMMENT 'The jurisdiction of the patent filing record',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code identifying the patent office jurisdiction where the patent was filed. US=United States, EP=European Patent Office, JP=Japan, CN=China, KR=South Korea, CA=Canada, AU=Australia, BR=Brazil, IN=India, MX=Mexico, RU=Russia, ZA=South Africa, PCT=Patent Cooperation Treaty (international application). [ENUM-REF-CANDIDATE: US|EP|JP|CN|KR|CA|AU|BR|IN|MX|RU|ZA|PCT — 13 candidates stripped; promote to reference product]',
    `legal_status` STRING COMMENT 'Current legal standing of the granted patent. Active indicates patent is in force and enforceable. Lapsed indicates failure to pay maintenance fees. Revoked or invalidated indicates patent rights have been terminated by legal action.. Valid values are `active|lapsed|revoked|invalidated|maintained`',
    `licensing_status` STRING COMMENT 'Indicates whether the patent is subject to licensing agreements. Licensed out means the company has granted rights to third parties. Licensed in means the company has acquired rights from others. Cross-licensed indicates mutual licensing with another party.. Valid values are `not licensed|licensed out|licensed in|cross-licensed|available for licensing`',
    `maintenance_fee_due_date` DATE COMMENT 'Next scheduled date for payment of patent maintenance or renewal fees to keep the patent in force. Failure to pay results in patent lapse. Applicable only to granted patents in jurisdictions requiring periodic fees.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this patent filing record was last updated in the system. Tracks the most recent change to any field in the record.',
    `patent_filing_name` STRING COMMENT 'The patent filing name of the patent filing record',
    `notes` STRING COMMENT 'The notes of the patent filing record',
    `patent_attorney_firm` STRING COMMENT 'Name of the external law firm or patent agent representing the company for this patent filing. Used for managing outside counsel relationships and costs.',
    `patent_filing_status` STRING COMMENT 'The patent filing status of the patent filing record',
    `patent_number` STRING COMMENT 'Official patent number assigned upon grant by the patent office. Null until patent is granted. Used for citation and enforcement purposes.',
    `patent_status` STRING COMMENT 'The patent status of the patent filing record',
    `patent_title` STRING COMMENT 'Official title of the patent as filed with the patent office. Describes the invention in concise legal language.',
    `patent_type` STRING COMMENT 'Classification of the patent by legal type. Utility patents cover functional inventions, design patents cover ornamental designs, composition of matter covers chemical formulations, process covers manufacturing methods, plant covers new plant varieties, and reissue covers corrections to previously granted patents.. Valid values are `utility|design|composition of matter|process|plant|reissue`',
    `pct_application_flag` BOOLEAN COMMENT 'Indicates whether this filing was made under the Patent Cooperation Treaty, which allows a single international application to seek protection in multiple countries simultaneously.',
    `pct_application_number` STRING COMMENT 'PCT international application number if this filing was made under PCT. Format: PCT/CC/YYYY/NNNNNN where CC is country code, YYYY is year, NNNNNN is serial number.',
    `primary_ipc_class` STRING COMMENT 'Primary IPC classification code assigned to the patent. IPC is a hierarchical system for classifying patents by technology area. Format: Section-Class-Subclass-Group (e.g., A61K-008/00 for cosmetic preparations).',
    `priority_date` DATE COMMENT 'Earliest filing date claimed for priority purposes, typically from a provisional application or foreign filing. Used to establish prior art cutoff date.',
    `product_category` STRING COMMENT 'Consumer goods product category that the patented invention applies to. Aligns with business product portfolio structure. [ENUM-REF-CANDIDATE: skincare|haircare|oral care|personal hygiene|household cleaning|laundry|baby care|cosmetics|fragrances|wellness — 10 candidates stripped; promote to reference product]',
    `prosecution_status` STRING COMMENT 'Current status of the patent application in the prosecution process. Tracks the lifecycle from drafting through grant or abandonment. Office action pending indicates examiner has issued objections requiring response. [ENUM-REF-CANDIDATE: draft|filed|published|under examination|office action pending|allowed|granted|abandoned|expired|withdrawn — 10 candidates stripped; promote to reference product]',
    `publication_date` DATE COMMENT 'Date the patent application was published by the patent office, typically 18 months after filing. Makes the invention publicly disclosed.',
    `publication_number` STRING COMMENT 'The publication number of the patent filing record',
    `secondary_ipc_classes` STRING COMMENT 'Semicolon-separated list of additional IPC classification codes applicable to the patent. Used when invention spans multiple technology domains.',
    `source_system_code` STRING COMMENT 'The source system code of the patent filing record',
    `technology_domain` STRING COMMENT 'High-level categorization of the patents technology area within consumer goods. Used for portfolio management and strategic IP planning. [ENUM-REF-CANDIDATE: formulation|packaging|manufacturing process|delivery system|ingredient|fragrance|preservation|sustainability|biotechnology — 9 candidates stripped; promote to reference product]',
    `title` STRING COMMENT 'The title of the patent filing record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the patent filing record',
    CONSTRAINT pk_patent_filing PRIMARY KEY(`patent_filing_id`)
) COMMENT 'Master record for patent applications and granted patents arising from R&D innovation activities. Captures patent application number, patent title, filing date, jurisdiction (US, EU, JP, CN, global PCT), patent type (utility, design, composition of matter, process), inventors list, assignee, prosecution status (filed, published, granted, abandoned, expired), grant date, expiry date, and linked R&D project or formulation. Supports IP portfolio management and freedom-to-operate analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` (
    `regulatory_dossier_id` BIGINT COMMENT 'Unique identifier for the regulatory submission dossier record. Primary key for the regulatory dossier entity.',
    `employee_id` BIGINT COMMENT 'Reference to the regulatory affairs manager who is accountable for the preparation, submission, and management of this dossier.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the product formulation that is the subject of this regulatory submission dossier.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project for which this regulatory dossier is being prepared.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the regulatory dossier record',
    `sku_id` BIGINT COMMENT 'Reference to the finished product for which regulatory approval is being sought. May be null if dossier is prepared before final product definition.',
    `actual_approval_date` DATE COMMENT 'Actual date when the regulatory authority granted approval for the product. Null if not yet approved.',
    `actual_submission_date` DATE COMMENT 'Actual date when the dossier was submitted to the regulatory authority. Null if not yet submitted.',
    `additional_information_due_date` DATE COMMENT 'Deadline date by which additional information requested by the regulatory authority must be submitted to avoid rejection or withdrawal.',
    `additional_information_requested` BOOLEAN COMMENT 'Boolean flag indicating whether the regulatory authority has requested additional information or clarification on the submitted dossier.',
    `allergen_declaration_complete` BOOLEAN COMMENT 'Boolean flag indicating whether all allergen declarations required by the target market regulations have been completed and included in the dossier.',
    `animal_testing_statement` STRING COMMENT 'Declaration regarding animal testing status for the product and ingredients, required for compliance with EU and other market regulations.. Valid values are `No Animal Testing|Animal Testing Conducted|Not Applicable`',
    `approval_date` DATE COMMENT 'The approval date of the regulatory dossier record',
    `authority_reference_number` STRING COMMENT 'Official reference or tracking number assigned by the regulatory authority upon receipt of the submission.',
    `claim_substantiation_status` STRING COMMENT 'Status of the claim substantiation documentation and testing required to support product claims in the regulatory submission.. Valid values are `Not Started|In Progress|Completed|Approved|Insufficient`',
    `cmr_substance_present` BOOLEAN COMMENT 'Boolean flag indicating whether the formulation contains any CMR (Carcinogenic, Mutagenic, or Reprotoxic) substances that require special regulatory attention.',
    `regulatory_dossier_code` STRING COMMENT 'The regulatory dossier code of the regulatory dossier record',
    `cpnp_reference_number` STRING COMMENT 'Unique reference number assigned by the EU CPNP system for cosmetic product notifications. Applicable only for EU submissions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory dossier record was first created in the system.',
    `regulatory_dossier_description` STRING COMMENT 'The regulatory dossier description of the regulatory dossier record',
    `dossier_code` STRING COMMENT 'The dossier code of the regulatory dossier record',
    `dossier_reference_number` STRING COMMENT 'Business identifier for the regulatory dossier, used for tracking and communication with regulatory authorities and internal stakeholders.',
    `dossier_status` STRING COMMENT 'Current lifecycle status of the regulatory dossier indicating its progress through the submission and approval process. [ENUM-REF-CANDIDATE: In Preparation|Ready for Review|Submitted|Under Review|Additional Information Requested|Approved|Rejected|Withdrawn — 8 candidates stripped; promote to reference product]',
    `dossier_type` STRING COMMENT 'Classification of the regulatory submission dossier based on the regulatory framework and authority requirements.. Valid values are `CPNP EU Notification|FDA OTC Monograph|ASEAN Cosmetic Directive|Health Canada Notification|China NMPA Registration|Australia TGA Listing`',
    `dossier_version` STRING COMMENT 'Version number or identifier for the dossier document, tracking revisions and updates throughout the preparation and submission process.',
    `effective_from` DATE COMMENT 'The effective from of the regulatory dossier record',
    `effective_until` DATE COMMENT 'The effective until of the regulatory dossier record',
    `expected_approval_date` DATE COMMENT 'Estimated date for receiving regulatory approval based on standard review timelines and authority guidance.',
    `gmp_compliance_status` STRING COMMENT 'Status indicating whether the manufacturing facility and processes meet GMP requirements for the target market.. Valid values are `Compliant|Non-Compliant|Under Review|Not Applicable`',
    `inci_listing_complete` BOOLEAN COMMENT 'Boolean flag indicating whether the complete INCI ingredient listing has been prepared and verified for regulatory compliance.',
    `intended_use_description` STRING COMMENT 'Detailed description of the intended use, application, and consumer benefits of the product as stated in the regulatory submission.',
    `label_compliance_status` STRING COMMENT 'Status indicating whether the product labeling meets all regulatory requirements for the target market, including INCI listing, warnings, and claims.. Valid values are `Compliant|Non-Compliant|Under Review|Pending Approval`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory dossier record was last updated or modified in the system.',
    `regulatory_dossier_name` STRING COMMENT 'The regulatory dossier name of the regulatory dossier record',
    `nanomaterial_present` BOOLEAN COMMENT 'Boolean flag indicating whether the product formulation contains nanomaterials, which require special regulatory notification and safety assessment.',
    `notes` STRING COMMENT 'Free-text field for capturing additional notes, observations, or context related to the dossier preparation, submission, or review process.',
    `pif_document_reference` STRING COMMENT 'Reference identifier for the Product Information File document that contains all supporting documentation for the regulatory submission.',
    `preparation_start_date` DATE COMMENT 'Date when the preparation of the regulatory dossier was initiated by the R&D or regulatory affairs team.',
    `preservative_system_approved` BOOLEAN COMMENT 'Boolean flag indicating whether the preservative system used in the formulation has been approved for use in the target market.',
    `product_category` STRING COMMENT 'High-level product category classification (e.g., Skin Care, Hair Care, Oral Care, Personal Hygiene) for the product covered by this dossier.',
    `regulatory_affairs_contact_email` STRING COMMENT 'Primary email address for the regulatory affairs contact responsible for this dossier, used for communication with regulatory authorities.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_authority_name` STRING COMMENT 'Name of the regulatory body or agency to which this dossier is submitted (e.g., FDA, European Commission, Health Canada, NMPA).',
    `regulatory_body` STRING COMMENT 'The regulatory body of the regulatory dossier record',
    `regulatory_dossier_status` STRING COMMENT 'The regulatory dossier status of the regulatory dossier record',
    `regulatory_framework` STRING COMMENT 'The regulatory framework of the regulatory dossier record',
    `rejection_date` DATE COMMENT 'Date when the regulatory authority rejected the dossier submission. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the regulatory authority for rejecting the dossier submission, including specific deficiencies or non-compliance issues.',
    `review_start_date` DATE COMMENT 'Date when the regulatory authority officially began their review of the submitted dossier.',
    `safety_assessment_status` STRING COMMENT 'Status of the product safety assessment report required for regulatory compliance, typically prepared by a qualified safety assessor.. Valid values are `Not Started|In Progress|Completed|Approved|Requires Revision`',
    `safety_assessor_name` STRING COMMENT 'Name of the qualified safety assessor who prepared or reviewed the product safety assessment for this dossier.',
    `source_system_code` STRING COMMENT 'The source system code of the regulatory dossier record',
    `submission_category` STRING COMMENT 'Category of regulatory submission indicating whether this is a new product, modification, renewal, or other type of regulatory filing.. Valid values are `New Product Registration|Product Modification|Renewal|Post-Market Notification|Safety Update`',
    `submission_date` DATE COMMENT 'The submission date of the regulatory dossier record',
    `submission_jurisdiction` STRING COMMENT 'The submission jurisdiction of the regulatory dossier record',
    `submission_status` STRING COMMENT 'The submission status of the regulatory dossier record',
    `target_market_country_code` STRING COMMENT 'Three-letter ISO country code representing the primary target market jurisdiction for this regulatory submission.. Valid values are `^[A-Z]{3}$`',
    `target_market_region` STRING COMMENT 'Geographic region or regulatory zone for the submission (e.g., European Union, ASEAN, North America).',
    `target_submission_date` DATE COMMENT 'Planned date for submitting the completed dossier to the regulatory authority, aligned with project milestones and launch timelines.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the regulatory dossier record',
    `withdrawal_date` DATE COMMENT 'Date when the company voluntarily withdrew the dossier from regulatory review. Null if not withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Internal business reason for voluntarily withdrawing the dossier from regulatory review (e.g., formulation change, market strategy shift, cost considerations).',
    CONSTRAINT pk_regulatory_dossier PRIMARY KEY(`regulatory_dossier_id`)
) COMMENT 'Master record for regulatory submission dossiers prepared for new product registrations and notifications. Captures dossier type (CPNP EU notification, FDA OTC monograph, ASEAN ASEAN Cosmetic Directive, Health Canada), target market, submission date, regulatory authority reference number, dossier status (in preparation, submitted, under review, approved, rejected), responsible regulatory affairs manager, and linked product/formulation. Distinct from the regulatory domains product registration — this is the R&D-owned dossier preparation record.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` (
    `claim_substantiation_id` BIGINT COMMENT 'Unique identifier for the claim substantiation record. Primary key.',
    `consumer_test_id` BIGINT COMMENT 'Reference to the consumer test record that provides supporting evidence for this claim.',
    `lab_test_id` BIGINT COMMENT 'The lab test id of the claim substantiation record',
    `employee_id` BIGINT COMMENT 'Reference to the business owner (typically from marketing or brand management) responsible for this claim and its usage.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the specific formulation version tested to substantiate this claim.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project that generated the evidence for this claim.',
    `regulatory_claim_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_claim. Business justification: Each claim substantiation feeds a regulatory claim filing; linking provides the Claim Approval Dashboard that maps substantiation evidence to claim approval status.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the claim substantiation record',
    `sku_id` BIGINT COMMENT 'Reference to the finished product for which this claim is substantiated.',
    `study_protocol_id` BIGINT COMMENT 'Reference to the formal study protocol document that defines the testing methodology used for substantiation.',
    `tertiary_claim_regulatory_reviewer_employee_id` BIGINT COMMENT 'Reference to the regulatory affairs specialist who reviewed this claim for compliance with applicable regulations.',
    `advertising_standard_compliance` STRING COMMENT 'Comma-separated list of advertising standards and self-regulatory bodies that this claim complies with (e.g., NAD,ASA,ASRC,CARU).',
    `approval_date` DATE COMMENT 'The approval date of the claim substantiation record',
    `challenge_history` STRING COMMENT 'Summary of any historical challenges, complaints, or disputes related to this claim from regulatory bodies, competitors, or consumer advocacy groups.',
    `channel_applicability` STRING COMMENT 'Comma-separated list of marketing and sales channels where this claim is approved for use (e.g., packaging,digital,print,broadcast,retail_pos).',
    `claim_approval_status` STRING COMMENT 'Current approval status of the claim substantiation within the internal governance process. [ENUM-REF-CANDIDATE: draft|under_review|approved|rejected|conditional_approval|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `claim_category` STRING COMMENT 'Broader categorization of the claim for organizational and reporting purposes.. Valid values are `product_performance|ingredient_benefit|safety_assurance|sustainability|quality_certification|expert_endorsement`',
    `claim_code` STRING COMMENT 'Unique business identifier or code assigned to this claim substantiation record for tracking and reference purposes.',
    `claim_effective_date` DATE COMMENT 'Date from which this claim substantiation becomes valid and the claim may be used in marketing materials.',
    `claim_expiry_date` DATE COMMENT 'Date when this claim substantiation expires and the claim must be re-substantiated or withdrawn from use.',
    `claim_substantiation_status` STRING COMMENT 'The claim substantiation status of the claim substantiation record',
    `claim_text` STRING COMMENT 'The exact wording of the marketing or product performance claim being substantiated (e.g., 48-hour moisturization, clinically proven to reduce wrinkles, dermatologist tested).',
    `claim_type` STRING COMMENT 'Classification of the claim based on its nature: efficacy (performance), safety (non-irritating, hypoallergenic), environmental (sustainability, eco-friendly), comparative (vs. competitor), sensory (fragrance, texture), or nutritional (for food/beverage products).. Valid values are `efficacy|safety|environmental|comparative|sensory|nutritional`',
    `clinical_study_reference` STRING COMMENT 'Citation or reference number for the clinical study that substantiates this claim (e.g., internal study ID, ClinicalTrials.gov identifier, published journal article DOI).',
    `claim_substantiation_code` STRING COMMENT 'The claim substantiation code of the claim substantiation record',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level of the study results expressed as a percentage (e.g., 95.00 for 95% confidence).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim substantiation record was first created in the system.',
    `claim_substantiation_description` STRING COMMENT 'The claim substantiation description of the claim substantiation record',
    `effective_from` DATE COMMENT 'The effective from of the claim substantiation record',
    `effective_until` DATE COMMENT 'The effective until of the claim substantiation record',
    `efficacy_result_summary` STRING COMMENT 'Brief summary of the key efficacy findings from the substantiation study (e.g., 87% of users reported smoother skin after 4 weeks).',
    `evidence_reference` STRING COMMENT 'The evidence reference of the claim substantiation record',
    `evidence_type` STRING COMMENT 'The evidence type of the claim substantiation record',
    `expiry_date` DATE COMMENT 'The expiry date of the claim substantiation record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim substantiation record was last updated or modified.',
    `legal_review_date` DATE COMMENT 'Date when the legal review was completed and the claim was approved or rejected by legal counsel.',
    `legal_review_status` STRING COMMENT 'Status of legal department review to ensure the claim is defensible and compliant with advertising standards.. Valid values are `not_started|in_progress|approved|rejected|conditional_approval`',
    `market_applicability` STRING COMMENT 'Comma-separated list of geographic markets or regions where this claim is approved for use (e.g., USA,CAN,GBR,DEU,FRA using ISO 3166-1 alpha-3 country codes).',
    `claim_substantiation_name` STRING COMMENT 'The claim substantiation name of the claim substantiation record',
    `next_renewal_date` DATE COMMENT 'Scheduled date for the next renewal or re-substantiation of this claim.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this claim substantiation, including any special conditions or limitations on claim usage.',
    `p_value` DECIMAL(18,2) COMMENT 'Statistical p-value from hypothesis testing, indicating the probability that the observed results occurred by chance.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory review and approval for this claim, if required by governing authorities.. Valid values are `not_required|pending|approved|rejected|conditional`',
    `regulatory_review_date` DATE COMMENT 'Date when the regulatory review was completed.',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals or re-substantiation cycles for this claim.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this claim substantiation requires periodic renewal or re-validation.',
    `risk_assessment` STRING COMMENT 'Assessment of the legal and regulatory risk associated with using this claim, based on strength of evidence and potential for challenge.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of subjects, panelists, or test units included in the substantiation study.',
    `source_system_code` STRING COMMENT 'The source system code of the claim substantiation record',
    `statistical_significance_flag` BOOLEAN COMMENT 'Indicates whether the study results achieved statistical significance at the predefined confidence level.',
    `substantiation_code` STRING COMMENT 'The substantiation code of the claim substantiation record',
    `substantiation_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to substantiate this claim, including study costs, testing fees, and expert consultation fees.',
    `substantiation_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the substantiation cost amount.. Valid values are `^[A-Z]{3}$`',
    `substantiation_method` STRING COMMENT 'The primary methodology used to generate evidence supporting the claim (e.g., clinical study, consumer perception test, instrumental lab measurement, expert panel review, published literature). [ENUM-REF-CANDIDATE: clinical_study|consumer_test|instrumental_measurement|expert_endorsement|literature_review|in_vitro_test|in_vivo_test|historical_data — 8 candidates stripped; promote to reference product]',
    `substantiation_status` STRING COMMENT 'The substantiation status of the claim substantiation record',
    `supporting_document_references` STRING COMMENT 'Comma-separated list of document IDs, file paths, or references to all supporting evidence documents (test reports, certificates, expert opinions, published papers) that substantiate this claim.',
    `test_duration_days` STRING COMMENT 'Duration of the substantiation study or test period measured in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the claim substantiation record',
    CONSTRAINT pk_claim_substantiation PRIMARY KEY(`claim_substantiation_id`)
) COMMENT 'Records the evidence package assembled to substantiate specific marketing and product performance claims for regulatory and legal defense. Captures claim text (e.g., 48-hour moisturization, clinically proven, dermatologist tested), claim type (efficacy, safety, environmental, comparative), substantiation method (clinical study, consumer test, instrumental measurement, expert endorsement), supporting study references, claim approval status, legal review sign-off, market applicability, and expiry/renewal date. Bridges R&D evidence to marketing claim usage and ensures claims are defensible under advertising standards (NAD, ASA) and regulatory requirements.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` (
    `innovation_brief_id` BIGINT COMMENT 'Unique identifier for the innovation brief document. Primary key.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Innovation briefs must align with corporate ESG commitments; linking ensures new concepts are evaluated against ESG targets in the innovation pipeline.',
    `employee_id` BIGINT COMMENT 'The innovation requestor employee id of the innovation brief record',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand under which the proposed product will be marketed.',
    `primary_innovation_employee_id` BIGINT COMMENT 'Reference to the commercial or marketing leader who is sponsoring the innovation brief and will champion it through the approval process.',
    `category_id` BIGINT COMMENT 'Reference to the product category or sub-category that this innovation brief targets.',
    `tertiary_innovation_approved_by_employee_id` BIGINT COMMENT 'Reference to the executive or committee member who granted final approval for the innovation brief.',
    `tertiary_quinary_innovation_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the innovation brief record.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project that was created as a result of this approved innovation brief, establishing traceability from commercial trigger to execution.',
    `approval_date` DATE COMMENT 'Date when the innovation brief was officially approved, triggering the creation of an R&D project and allocation of resources.',
    `attachments_reference` STRING COMMENT 'Reference or URI to supporting documents attached to the innovation brief (market research reports, consumer insights, competitive analysis, financial models).',
    `brief_code` STRING COMMENT 'Externally-known unique business identifier for the innovation brief, typically following a standardized format for tracking and reference across commercial and R&D teams.. Valid values are `^IB-[0-9]{4}-[A-Z0-9]{6}$`',
    `brief_status` STRING COMMENT 'Current lifecycle status of the innovation brief document in the approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|on_hold|cancelled — 7 candidates stripped; promote to reference product]',
    `brief_title` STRING COMMENT 'Descriptive title of the innovation brief that summarizes the product concept or business opportunity being proposed.',
    `brief_type` STRING COMMENT 'Classification of the innovation brief based on the nature of the NPD initiative (new product development, line extension, reformulation, etc.).. Valid values are `new_product|line_extension|reformulation|cost_reduction|sustainability_initiative|regulatory_compliance`',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated development budget.. Valid values are `^[A-Z]{3}$`',
    `business_opportunity_description` STRING COMMENT 'Detailed narrative describing the market opportunity, consumer need gap, competitive landscape, and strategic rationale for pursuing this innovation.',
    `innovation_brief_code` STRING COMMENT 'The innovation brief code of the innovation brief record',
    `competitive_benchmark_products` STRING COMMENT 'List of key competitor products that serve as performance, sensory, and pricing benchmarks for the proposed innovation.',
    `consumer_insight` STRING COMMENT 'The consumer insight of the innovation brief record',
    `consumer_need` STRING COMMENT 'The consumer need of the innovation brief record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the innovation brief record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for target COGS and RSP financial figures.. Valid values are `^[A-Z]{3}$`',
    `innovation_brief_description` STRING COMMENT 'The innovation brief description of the innovation brief record',
    `desired_product_benefits` STRING COMMENT 'List of key functional, emotional, and sensory benefits that the product must deliver to meet consumer needs and differentiate from competitors.',
    `effective_from` DATE COMMENT 'The effective from of the innovation brief record',
    `effective_until` DATE COMMENT 'The effective until of the innovation brief record',
    `estimated_development_budget` DECIMAL(18,2) COMMENT 'Estimated total budget required for R&D, formulation development, testing, regulatory submission, and pilot production to bring the innovation to market.',
    `estimated_market_size` DECIMAL(18,2) COMMENT 'Estimated total addressable market size in monetary value for the target category and consumer segment.',
    `estimated_npv` DECIMAL(18,2) COMMENT 'Estimated net present value of the innovation project, representing the discounted future cash flows minus the initial investment.',
    `estimated_roi_percent` DECIMAL(18,2) COMMENT 'Projected return on investment percentage for the innovation project over a defined time horizon, used for financial justification and prioritization.',
    `innovation_brief_status` STRING COMMENT 'The innovation brief status of the innovation brief record',
    `innovation_priority_tier` STRING COMMENT 'Strategic priority classification assigned to the innovation brief, determining resource allocation and executive sponsorship level.. Valid values are `tier_1_strategic|tier_2_growth|tier_3_maintenance|tier_4_exploratory`',
    `key_performance_indicators` STRING COMMENT 'List of measurable success criteria and KPIs that will be used to evaluate the innovation project (e.g., market share target, NPS score, repeat purchase rate).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the innovation brief record was last updated or modified.',
    `market_size_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated market size figure.. Valid values are `^[A-Z]{3}$`',
    `innovation_brief_name` STRING COMMENT 'The innovation brief name of the innovation brief record',
    `notes` STRING COMMENT 'The notes of the innovation brief record',
    `npv_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated NPV figure.. Valid values are `^[A-Z]{3}$`',
    `priority` STRING COMMENT 'The priority of the innovation brief record',
    `regulatory_pathway` STRING COMMENT 'Expected regulatory approval pathway required for the product based on category, claims, and jurisdiction (e.g., FDA notification, EU cosmetic registration).. Valid values are `standard|expedited|notification|registration|pre_market_approval|exempt`',
    `rejection_date` DATE COMMENT 'Date when the innovation brief was rejected or declined by the review committee.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the review committee for rejecting the innovation brief, including strategic, financial, or technical rationale.',
    `risk_assessment_summary` STRING COMMENT 'Summary of key risks identified for the innovation (technical feasibility, regulatory, supply chain, competitive response) and proposed mitigation strategies.',
    `source_system_code` STRING COMMENT 'The source system code of the innovation brief record',
    `strategic_fit_rationale` STRING COMMENT 'Explanation of how this innovation aligns with corporate strategy, brand positioning, portfolio gaps, and long-term business objectives.',
    `submission_date` DATE COMMENT 'Date when the innovation brief was formally submitted for review and approval by the stage-gate committee or innovation board.',
    `sustainability_target_score` DECIMAL(18,2) COMMENT 'Target sustainability score or rating that the product must achieve, based on corporate sustainability commitments (e.g., carbon footprint, recyclability, natural content).',
    `target_cogs` DECIMAL(18,2) COMMENT 'Target manufacturing cost per unit that R&D must achieve to meet profitability objectives. Critical constraint for formulation development.',
    `target_consumer_segment` STRING COMMENT 'Description of the primary consumer demographic, psychographic, or behavioral segment that the proposed product is designed to serve.',
    `target_gross_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage calculated from target RSP and COGS, representing the profitability threshold for project approval.',
    `target_launch_date` DATE COMMENT 'Desired commercial launch date for the product in the market, driving the R&D project timeline and stage-gate milestones.',
    `target_launch_geography` STRING COMMENT 'Geographic markets or regions where the product is intended to launch initially (e.g., USA, EUR, APAC).',
    `target_rsp` DECIMAL(18,2) COMMENT 'Target retail selling price that the product is expected to command in the market, used to calculate margin and assess commercial viability.',
    `target_segment` STRING COMMENT 'The target segment of the innovation brief record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the innovation brief record',
    CONSTRAINT pk_innovation_brief PRIMARY KEY(`innovation_brief_id`)
) COMMENT 'Formal innovation brief document that initiates an NPD project, capturing the business opportunity, target consumer, desired product benefits, cost target (COGS), RSP target, competitive benchmarks, key performance indicators, and strategic fit rationale. Serves as the contract between marketing/commercial and R&D at project inception. Distinct from the R&D project master — the brief is the upstream commercial trigger that precedes project creation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` (
    `raw_material_spec_id` BIGINT COMMENT 'Unique identifier for the raw material specification record. Primary key for R&D-owned technical specifications governing formulation use.',
    `employee_id` BIGINT COMMENT 'Identifier of the R&D scientist or manager who approved this raw material specification.',
    `supplier_id` BIGINT COMMENT 'The supplier id of the raw material spec record',
    `inci_library_id` BIGINT COMMENT 'Foreign key linking to research.inci_library. Business justification: Raw material specifications share many attributes with the INCI library; linking consolidates ingredient master data and eliminates duplicated INCI fields.',
    `material_id` BIGINT COMMENT 'The material id of the raw material spec record',
    `approval_date` DATE COMMENT 'Date when the raw material specification was approved by R&D for use in formulations.',
    `approved_concentration_max_percent` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of this raw material in formulations as approved by R&D and regulatory for safety and compliance.',
    `approved_concentration_min_percent` DECIMAL(18,2) COMMENT 'Minimum allowable concentration of this raw material in formulations as approved by R&D for efficacy and safety.',
    `cas_number` STRING COMMENT 'The cas number of the raw material spec record',
    `raw_material_spec_code` STRING COMMENT 'The raw material spec code of the raw material spec record',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per kilogram (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_per_kg` DECIMAL(18,2) COMMENT 'Standard cost of the raw material per kilogram for R&D costing and formulation budget estimation. Used for target COGS calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the raw material specification record was first created in the system.',
    `raw_material_spec_description` STRING COMMENT 'The raw material spec description of the raw material spec record',
    `effective_from` DATE COMMENT 'The effective from of the raw material spec record',
    `effective_until` DATE COMMENT 'The effective until of the raw material spec record',
    `einecs_number` STRING COMMENT 'European regulatory identifier for chemical substances marketed in the EU before September 1981. Required for EU REACH compliance.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `eu_maximum_concentration_percent` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of this raw material in finished products as mandated by EU regulations. Null if no EU restriction applies.',
    `eu_restricted_flag` BOOLEAN COMMENT 'Indicates whether the raw material is subject to restrictions or prohibitions under EU cosmetics regulations.',
    `grade` STRING COMMENT 'The grade of the raw material spec record',
    `hazard_classification` STRING COMMENT 'GHS hazard classification codes for the raw material indicating physical, health, and environmental hazards (e.g., H302, H315, H317). Used for SDS and safety compliance.',
    `hazardous_flag` BOOLEAN COMMENT 'The hazardous flag of the raw material spec record',
    `inci_name` STRING COMMENT 'The inci name of the raw material spec record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the raw material specification record was last updated or modified.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Maximum allowable moisture content expressed as a percentage. Important for stability and shelf life of formulations.',
    `raw_material_spec_name` STRING COMMENT 'The raw material spec name of the raw material spec record',
    `notes` STRING COMMENT 'Additional notes, comments, or special handling instructions for the raw material specification. May include formulation tips, compatibility warnings, or sourcing notes.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the raw material has organic certification from a recognized certifying body (e.g., USDA Organic, ECOCERT, COSMOS).',
    `palm_oil_derivative_flag` BOOLEAN COMMENT 'Indicates whether the raw material is derived from palm oil. Important for sustainability tracking and RSPO compliance.',
    `particle_size_microns` DECIMAL(18,2) COMMENT 'Average or target particle size measured in microns. Relevant for powders and solid materials affecting texture and performance.',
    `physical_form` STRING COMMENT 'The physical form of the raw material spec record',
    `purity_pct` DECIMAL(18,2) COMMENT 'The purity pct of the raw material spec record',
    `purity_percent` DECIMAL(18,2) COMMENT 'Minimum purity level of the active ingredient or material expressed as a percentage. Critical specification parameter for formulation consistency.',
    `raw_material_code` STRING COMMENT 'Unique alphanumeric code assigned to the raw material by R&D for internal identification and formulation reference. Distinct from procurement supplier material codes.. Valid values are `^[A-Z0-9]{6,12}$`',
    `raw_material_spec_status` STRING COMMENT 'The raw material spec status of the raw material spec record',
    `rd_approval_status` STRING COMMENT 'Current approval status of the raw material specification for use in R&D formulations. Approved materials are cleared for inclusion in new product development.. Valid values are `approved|pending_review|conditional|rejected|obsolete`',
    `regulatory_classification` STRING COMMENT 'Regulatory category or classification of the raw material (e.g., cosmetic ingredient, OTC active, food additive, fragrance component, colorant) determining applicable regulatory pathways.',
    `sds_available_flag` BOOLEAN COMMENT 'Indicates whether a current Safety Data Sheet is available for this raw material in the document management system.',
    `shelf_life_months` STRING COMMENT 'Expected shelf life of the raw material in months under specified storage conditions before quality degradation.',
    `source_system_code` STRING COMMENT 'The source system code of the raw material spec record',
    `spec_code` STRING COMMENT 'The spec code of the raw material spec record',
    `specification_version` STRING COMMENT 'Version number of the raw material specification document. Incremented when specification parameters are updated.. Valid values are `^[0-9]+.[0-9]+$`',
    `storage_condition` STRING COMMENT 'The storage condition of the raw material spec record',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius to prevent degradation or safety hazards.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius required to maintain raw material stability and quality.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the raw material spec record',
    `us_fda_maximum_concentration_percent` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of this raw material in finished products as mandated by US FDA regulations. Null if no FDA restriction applies.',
    `us_fda_restricted_flag` BOOLEAN COMMENT 'Indicates whether the raw material is subject to restrictions or prohibitions under US FDA regulations for cosmetics or OTC drugs.',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether the raw material is free from animal-derived ingredients and suitable for vegan product formulations.',
    CONSTRAINT pk_raw_material_spec PRIMARY KEY(`raw_material_spec_id`)
) COMMENT 'R&D-owned specification records for raw materials and ingredients used in formulation development. Captures raw material code, material name, INCI name, supplier name, grade/quality level, physical form, specification parameters (purity, moisture content, particle size, color, odor), approved concentration range, storage conditions, and R&D approval status. Distinct from procurements supplier material master — this is the R&D technical specification that governs formulation use.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` (
    `research_packaging_spec_id` BIGINT COMMENT 'Unique identifier for the R&D packaging specification record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the R&D team member or manager who approved this packaging specification for use in prototypes or production.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project under which this packaging specification was developed or evaluated.',
    `supplier_id` BIGINT COMMENT 'The supplier id of the research packaging spec record',
    `product_packaging_spec_id` BIGINT COMMENT 'FK to authoritative SSOT table product.product_packaging_spec (cross-domain duplicate resolution).',
    `approval_date` DATE COMMENT 'Date when the packaging specification received R&D approval for use in the NPD project.',
    `barrier_properties` STRING COMMENT 'Description of the packaging materials barrier characteristics, including oxygen barrier, moisture barrier, light barrier, or UV protection properties critical for product stability.',
    `capacity_ml` DECIMAL(18,2) COMMENT 'Nominal fill capacity of the packaging component in milliliters, representing the target product volume for primary containers.',
    `child_resistant_certified` BOOLEAN COMMENT 'Indicates whether the packaging component has been certified as child-resistant per regulatory requirements for hazardous products.',
    `closure_type` STRING COMMENT 'Type of closure mechanism for the packaging component, such as screw cap, pump dispenser, flip-top, spray nozzle, or child-resistant closure.',
    `research_packaging_spec_code` STRING COMMENT 'The research packaging spec code of the research packaging spec record',
    `color_specification` STRING COMMENT 'Color designation for the packaging component, typically using Pantone codes or descriptive color names for brand consistency.',
    `compatibility_test_date` DATE COMMENT 'Date when the formulation-packaging compatibility testing was completed or last reviewed.',
    `compatibility_test_result` STRING COMMENT 'Summary of the compatibility test findings, including any observed interactions, leaching, discoloration, or structural changes.',
    `component_height_mm` DECIMAL(18,2) COMMENT 'Height dimension of the packaging component in millimeters, measured per the specification drawing.',
    `component_length_mm` DECIMAL(18,2) COMMENT 'Length dimension of the packaging component in millimeters, measured per the specification drawing.',
    `component_type` STRING COMMENT 'Classification of the packaging component within the packaging hierarchy: primary (direct product contact), secondary (outer carton/box), tertiary (pallet/shipper), closure (cap/pump/dispenser), label, or insert.. Valid values are `primary|secondary|tertiary|closure|label|insert`',
    `component_weight_grams` DECIMAL(18,2) COMMENT 'Weight of the empty packaging component in grams, used for sustainability calculations and shipping cost estimation.',
    `component_width_mm` DECIMAL(18,2) COMMENT 'Width dimension of the packaging component in millimeters, measured per the specification drawing.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the cost per unit value.. Valid values are `^[A-Z]{3}$`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Estimated or quoted cost per unit of the packaging component, used for NPD cost modeling and target COGS calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging specification record was first created in the R&D system.',
    `decoration_method` STRING COMMENT 'Method used to apply graphics, branding, or regulatory information to the packaging component. [ENUM-REF-CANDIDATE: screen_print|pad_print|label|heat_transfer|in_mold_label|direct_print|embossing|none — 8 candidates stripped; promote to reference product]',
    `research_packaging_spec_description` STRING COMMENT 'The research packaging spec description of the research packaging spec record',
    `effective_from` DATE COMMENT 'The effective from of the research packaging spec record',
    `effective_until` DATE COMMENT 'The effective until of the research packaging spec record',
    `eu_reach_compliant` BOOLEAN COMMENT 'Indicates whether the packaging material complies with EU REACH regulation for chemical substance registration and restriction.',
    `fda_food_contact_approved` BOOLEAN COMMENT 'Indicates whether the packaging material is approved for direct food contact per FDA regulations.',
    `formulation_compatibility_status` STRING COMMENT 'Status of compatibility testing between the packaging material and the product formulation, indicating whether the packaging is suitable for the intended product.. Valid values are `compatible|incompatible|testing_in_progress|not_tested|conditional`',
    `height_mm` DECIMAL(18,2) COMMENT 'The height mm of the research packaging spec record',
    `is_recyclable` BOOLEAN COMMENT 'The is recyclable of the research packaging spec record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging specification record was last updated, tracking iterative design changes and review cycles.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from order placement to delivery for this packaging component, critical for project timeline planning.',
    `length_mm` DECIMAL(18,2) COMMENT 'The length mm of the research packaging spec record',
    `material_composition` STRING COMMENT 'The material composition of the research packaging spec record',
    `material_grade` STRING COMMENT 'Specific grade or quality designation of the material, including food-grade, pharmaceutical-grade, or recycled content specifications.',
    `material_type` STRING COMMENT 'Primary material composition of the packaging component, using standard polymer abbreviations and material classifications. [ENUM-REF-CANDIDATE: HDPE|PET|PETG|PP|glass|aluminum|paperboard|corrugated|LDPE|PVC|bioplastic|composite — 12 candidates stripped; promote to reference product]',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity required by the supplier for this packaging component, impacting prototype and pilot production planning.',
    `research_packaging_spec_name` STRING COMMENT 'The research packaging spec name of the research packaging spec record',
    `notes` STRING COMMENT 'Free-text notes capturing additional technical details, design rationale, testing observations, or special handling requirements for the packaging specification.',
    `pcr_content_pct` DECIMAL(18,2) COMMENT 'The pcr content pct of the research packaging spec record',
    `prototype_batch_number` STRING COMMENT 'Batch or lot number of the prototype packaging samples produced for evaluation, linking to physical samples in R&D inventory.',
    `rd_approval_status` STRING COMMENT 'Current approval status of the packaging specification within the R&D stage-gate process, indicating readiness for prototype or production use.. Valid values are `draft|under_review|approved|rejected|on_hold|obsolete`',
    `recyclability_classification` STRING COMMENT 'Classification of the packaging components recyclability based on material type and local recycling infrastructure availability.. Valid values are `widely_recyclable|limited_recyclability|not_recyclable|check_locally|store_drop_off`',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of post-consumer or post-industrial recycled material content in the packaging component, supporting sustainability goals.',
    `regulatory_compliance_status` STRING COMMENT 'Overall regulatory compliance status of the packaging specification against applicable FDA, EU, and regional packaging regulations.. Valid values are `compliant|non_compliant|pending_review|not_applicable|conditional`',
    `research_packaging_spec_status` STRING COMMENT 'The research packaging spec status of the research packaging spec record',
    `source_system_code` STRING COMMENT 'The source system code of the research packaging spec record',
    `spec_code` STRING COMMENT 'The spec code of the research packaging spec record',
    `spec_name` STRING COMMENT 'The spec name of the research packaging spec record',
    `spec_status` STRING COMMENT 'The spec status of the research packaging spec record',
    `specification_code` STRING COMMENT 'Unique business identifier for the packaging specification, used for cross-referencing in R&D documentation and prototype builds.. Valid values are `^PKG-[A-Z0-9]{6,12}$`',
    `specification_name` STRING COMMENT 'Descriptive name of the packaging specification, typically including component type and material summary.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Composite sustainability score for the packaging specification, considering recyclability, recycled content, material weight reduction, and renewable material usage.',
    `tamper_evident_feature` BOOLEAN COMMENT 'Indicates whether the packaging includes tamper-evident features such as breakable seals, shrink bands, or induction seals.',
    `technical_drawing_reference` STRING COMMENT 'Reference identifier or file path to the detailed technical drawing or CAD file for the packaging component.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research packaging spec record',
    `version_number` STRING COMMENT 'Version identifier for the packaging specification, following major.minor versioning convention to track iterative design changes.. Valid values are `^[0-9]+.[0-9]+$`',
    `width_mm` DECIMAL(18,2) COMMENT 'The width mm of the research packaging spec record',
    CONSTRAINT pk_research_packaging_spec PRIMARY KEY(`research_packaging_spec_id`)
) COMMENT 'R&D-owned technical specification records for packaging components developed or evaluated during NPD. Captures component type (primary, secondary, tertiary), material type (HDPE, PET, glass, aluminum, paperboard), component dimensions, weight, closure type, decoration method, compatibility test status with formulation, recyclability classification, and R&D approval status. Distinct from procurement packaging master — this is the R&D technical specification driving prototype and launch packaging decisions. [SSOT] Superseded by authoritative table product.product_packaging_spec for concept packaging_spec. SSOT: canonical table is product.product_packaging_spec. [SSOT: authoritative table is product.product_packaging_spec; this is a deprecated duplicate for concept packaging_spec.] [SSOT for concept packaging_spec.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` (
    `safety_assessment_id` BIGINT COMMENT 'Primary key for safety_assessment',
    `product_formulation_id` BIGINT COMMENT 'Reference to the formulation being assessed for safety.',
    `rd_project_id` BIGINT COMMENT 'Reference to the R&D project under which this safety assessment was conducted.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the safety assessment record',
    `employee_id` BIGINT COMMENT 'The safety assessor employee id of the safety assessment record',
    `safety_responsible_employee_id` BIGINT COMMENT 'Reference to the user who approved the safety assessment for regulatory submission.',
    `sku_id` BIGINT COMMENT 'Reference to the finished product being assessed, if applicable. May be null for formulation-only assessments.',
    `supersedes_assessment_safety_assessment_id` BIGINT COMMENT 'Reference to the previous safety assessment record that this version supersedes, maintaining audit trail of assessment history.',
    `allergen_declaration` STRING COMMENT 'List of allergenic substances present in the formulation that must be declared on the label per regulatory requirements (e.g., EU Allergen List per Regulation 1223/2009 Annex III).',
    `application_frequency` STRING COMMENT 'Recommended frequency of product application (e.g., once daily, twice daily, as needed, weekly).',
    `application_site` STRING COMMENT 'Body site(s) where the product is intended to be applied (e.g., face, hands, scalp, body, mucous membranes).',
    `approval_date` DATE COMMENT 'Date on which the safety assessment was formally approved for use in regulatory submissions and product commercialization.',
    `assessment_code` STRING COMMENT 'Unique business identifier for the safety assessment, used for external reference and regulatory submissions.',
    `assessment_date` DATE COMMENT 'Date on which the safety assessment was completed and signed off by the assessor.',
    `assessment_result` STRING COMMENT 'The assessment result of the safety assessment record',
    `assessment_start_date` DATE COMMENT 'Date on which the safety assessment work commenced.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the safety assessment record.. Valid values are `draft|in_review|approved|rejected|superseded`',
    `assessment_type` STRING COMMENT 'Type of safety assessment conducted. CPSR (Cosmetic Product Safety Report) per EU Regulation 1223/2009, toxicological risk assessment, dermal sensitization, HRIPT (Human Repeat Insult Patch Test), ocular irritation, or mutagenicity assessment. [ENUM-REF-CANDIDATE: cosmetic_product_safety_report|toxicological_risk_assessment|dermal_sensitization_assessment|hript|ocular_irritation_assessment|mutagenicity_assessment|phototoxicity_assessment|reproductive_toxicity_assessment — promote to reference product]. Valid values are `cosmetic_product_safety_report|toxicological_risk_assessment|dermal_sensitization_assessment|hript|ocular_irritation_assessment|mutagenicity_assessment`',
    `assessor_name` STRING COMMENT 'Full name of the qualified safety assessor who conducted the evaluation.',
    `assessor_qualification` STRING COMMENT 'Professional qualifications and credentials of the safety assessor (e.g., PhD Toxicology, Registered Pharmacist, Diploma in Pharmaceutical Medicine).',
    `assessor_registration_number` STRING COMMENT 'Professional registration or license number of the safety assessor, as required by regulatory authorities.',
    `safety_assessment_code` STRING COMMENT 'The safety assessment code of the safety assessment record',
    `conclusion` STRING COMMENT 'The conclusion of the safety assessment record',
    `conditions_of_use` STRING COMMENT 'Specific conditions under which the product is deemed safe, including application site, frequency, duration, and target population (e.g., adults only, rinse-off only, not for use on damaged skin).',
    `contraindications` STRING COMMENT 'Specific conditions or populations for which the product should not be used (e.g., not for use on broken skin, avoid if allergic to fragrance, not suitable for children under 3).',
    `cpnp_notification_required` BOOLEAN COMMENT 'Flag indicating whether this assessment supports a product requiring notification in the EU CPNP system.',
    `cpnp_reference_number` STRING COMMENT 'CPNP notification reference number if the product has been notified in the EU portal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety assessment record was first created in the system.',
    `safety_assessment_description` STRING COMMENT 'The safety assessment description of the safety assessment record',
    `document_location` STRING COMMENT 'File path or document management system reference where the full safety assessment report is stored (e.g., Veeva Vault document ID).',
    `effective_from` DATE COMMENT 'The effective from of the safety assessment record',
    `effective_until` DATE COMMENT 'The effective until of the safety assessment record',
    `exposure_duration` STRING COMMENT 'Duration of product contact with skin or mucous membranes (e.g., rinse-off, leave-on, brief contact).',
    `fda_registration_required` BOOLEAN COMMENT 'Flag indicating whether this assessment supports a product requiring FDA registration or notification in the United States.',
    `label_warnings_required` STRING COMMENT 'Mandatory label warnings and precautionary statements required based on the safety assessment (e.g., avoid contact with eyes, for external use only, keep out of reach of children).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety assessment record was last modified.',
    `margin_of_safety` DECIMAL(18,2) COMMENT 'Calculated margin of safety ratio (NOAEL/SED), indicating the safety buffer between the no observed adverse effect level and systemic exposure dose.',
    `safety_assessment_name` STRING COMMENT 'The safety assessment name of the safety assessment record',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic review of the safety assessment, typically required every 3-5 years or when formulation changes occur.',
    `noael_value` DECIMAL(18,2) COMMENT 'No Observed Adverse Effect Level in mg/kg body weight/day, derived from toxicological studies.',
    `notes` STRING COMMENT 'The notes of the safety assessment record',
    `regulatory_market_scope` STRING COMMENT 'Geographic markets and regulatory jurisdictions for which this safety assessment is intended (e.g., EU, USA, ASEAN, China, Brazil).',
    `restricted_substances_compliance` BOOLEAN COMMENT 'Flag indicating whether the formulation complies with all restricted substance regulations (EU Annexes II-VI, FDA prohibited ingredients).',
    `restricted_substances_findings` STRING COMMENT 'Details of any restricted substances identified in the formulation and their compliance status with maximum concentration limits.',
    `review_date` DATE COMMENT 'Date on which the safety assessment was last reviewed or updated to reflect new data or regulatory changes.',
    `safety_assessment_status` STRING COMMENT 'The safety assessment status of the safety assessment record',
    `safety_conclusion` STRING COMMENT 'Overall safety conclusion reached by the assessor: safe for intended use, unsafe, conditionally safe (with restrictions), or insufficient data to conclude.. Valid values are `safe|unsafe|conditionally_safe|insufficient_data`',
    `source_system_code` STRING COMMENT 'The source system code of the safety assessment record',
    `supporting_studies_summary` STRING COMMENT 'Summary of key toxicological and clinical studies used to support the safety assessment, including study types and outcomes.',
    `systemic_exposure_estimate` DECIMAL(18,2) COMMENT 'Estimated systemic exposure dose in mg/kg body weight/day, calculated from dermal absorption and usage patterns.',
    `target_population` STRING COMMENT 'Intended consumer population for the product (e.g., adults, children over 3 years, infants, pregnant women, general population).',
    `toxicological_endpoints_evaluated` STRING COMMENT 'List of toxicological endpoints assessed (e.g., acute toxicity, skin irritation, eye irritation, skin sensitization, repeated dose toxicity, mutagenicity, carcinogenicity, reproductive toxicity).',
    `toxicology_summary` STRING COMMENT 'The toxicology summary of the safety assessment record',
    `undesirable_effects_reported` STRING COMMENT 'Description of any undesirable effects observed in toxicological studies or post-market surveillance that are relevant to the safety assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the safety assessment record',
    `version_number` STRING COMMENT 'Version number of the safety assessment document, incremented with each revision or update.',
    CONSTRAINT pk_safety_assessment PRIMARY KEY(`safety_assessment_id`)
) COMMENT 'Formal product safety assessment records required for regulatory compliance and consumer safety. Captures assessment type (cosmetic product safety report per EU Regulation 1223/2009, toxicological risk assessment, dermal sensitization assessment, HRIPT), assessor name and qualification, assessment date, product/formulation assessed, safety conclusion (safe/unsafe/conditionally safe), conditions of use, and any required label warnings. Mandatory for EU CPSR and other market registrations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` (
    `scale_up_trial_id` BIGINT COMMENT 'Unique identifier for the manufacturing scale-up trial record. Primary key for the scale-up trial entity.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Technology‑transfer records require the specific manufacturing facility where the scale‑up trial is performed for capacity planning.',
    `employee_id` BIGINT COMMENT 'Reference to the manufacturing manager or technical authority who signed off on the scale-up trial and manufacturing readiness.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the R&D formulation being scaled up from bench scale to pilot or commercial production scale.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Scale‑up trials are scheduled on a particular production line; linking enables line utilization reporting and OEE tracking.',
    `rd_project_id` BIGINT COMMENT 'Reference to the parent R&D project under which this scale-up trial is conducted.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the scale up trial record',
    `actual_output_kg` DECIMAL(18,2) COMMENT 'Actual quantity of finished product produced during the scale-up trial measured in kilograms.',
    `appearance_assessment` STRING COMMENT 'Visual evaluation of product appearance including texture, homogeneity, and any defects observed during the trial.',
    `batch_size` DECIMAL(18,2) COMMENT 'The batch size of the scale up trial record',
    `batch_size_kg` DECIMAL(18,2) COMMENT 'Total batch size produced during the scale-up trial measured in kilograms, representing the scale of production tested.',
    `batch_size_uom` STRING COMMENT 'The batch size uom of the scale up trial record',
    `scale_up_trial_code` STRING COMMENT 'The scale up trial code of the scale up trial record',
    `color_measurement` STRING COMMENT 'Objective color measurement of the scaled-up batch using colorimetry or visual assessment against standard.',
    `cooling_rate_celsius_per_min` DECIMAL(18,2) COMMENT 'Rate at which the batch was cooled after processing, critical for product texture and stability.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions implemented during or after the trial to address deviations or quality issues.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the trial cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the scale-up trial record was first created in the data system.',
    `scale_up_trial_description` STRING COMMENT 'The scale up trial description of the scale up trial record',
    `deviation_description` STRING COMMENT 'Detailed description of any process deviations, non-conformances, or unexpected observations during the scale-up trial.',
    `deviation_impact_assessment` STRING COMMENT 'Assessment of the impact of observed deviations on product quality, safety, and manufacturing readiness.',
    `deviation_observed_flag` BOOLEAN COMMENT 'Boolean indicator of whether any process deviations from the standard manufacturing procedure were observed during the trial.',
    `effective_from` DATE COMMENT 'The effective from of the scale up trial record',
    `effective_until` DATE COMMENT 'The effective until of the scale up trial record',
    `equipment_configuration` STRING COMMENT 'Description of the manufacturing equipment setup used during the trial, including mixer type, vessel capacity, and auxiliary equipment.',
    `heating_rate_celsius_per_min` DECIMAL(18,2) COMMENT 'Rate at which the batch was heated during processing, important for thermal-sensitive formulations.',
    `in_process_test_results` STRING COMMENT 'Summary of all in-process quality control tests performed during the scale-up trial, including pass/fail status for each checkpoint.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the scale-up trial record was most recently updated or modified.',
    `lessons_learned` STRING COMMENT 'Key insights, learnings, and recommendations captured from the scale-up trial for future technology transfers and process improvements.',
    `manufacturing_readiness_level` STRING COMMENT 'Assessment of manufacturing readiness for commercial production based on trial outcomes and technology transfer completion.. Valid values are `not_ready|pilot_ready|scale_up_ready|commercial_ready`',
    `manufacturing_sign_off_date` DATE COMMENT 'Date when manufacturing operations formally approved the scale-up trial results and confirmed readiness for commercial production.',
    `manufacturing_site_code` STRING COMMENT 'Code identifying the manufacturing facility or plant where the scale-up trial was executed.',
    `mixing_speed_rpm` STRING COMMENT 'Rotational speed of the mixing equipment during the trial, critical process parameter for scale-up consistency.',
    `mixing_time_minutes` STRING COMMENT 'Total duration of the mixing phase during the scale-up trial, key parameter for process reproducibility.',
    `scale_up_trial_name` STRING COMMENT 'The scale up trial name of the scale up trial record',
    `next_steps` STRING COMMENT 'Documented next actions required following the scale-up trial, such as additional trials, process optimization, or commercial launch preparation.',
    `notes` STRING COMMENT 'The notes of the scale up trial record',
    `odor_assessment` STRING COMMENT 'Sensory evaluation of the product fragrance and odor profile compared to bench-scale formulation.',
    `order_of_addition` STRING COMMENT 'Documented sequence in which raw materials and ingredients were added during the manufacturing process, critical for formulation reproducibility.',
    `outcome` STRING COMMENT 'The outcome of the scale up trial record',
    `pass_fail_rationale` STRING COMMENT 'Detailed justification for the trial status decision, including quality assessment, process performance, and readiness for commercial production.',
    `ph_value` DECIMAL(18,2) COMMENT 'Measured pH of the scaled-up batch, critical quality parameter for product stability and skin compatibility.',
    `process_temperature_celsius` DECIMAL(18,2) COMMENT 'Target processing temperature maintained during the scale-up trial, critical for formulation stability and quality.',
    `quality_sign_off_date` DATE COMMENT 'Date when quality assurance formally approved the scale-up trial results and confirmed product quality meets specifications.',
    `scale_factor` DECIMAL(18,2) COMMENT 'Multiplication factor representing the scale-up ratio from bench scale to pilot or commercial scale (e.g., 10x, 100x, 1000x).',
    `scale_up_trial_status` STRING COMMENT 'The scale up trial status of the scale up trial record',
    `source_system_code` STRING COMMENT 'The source system code of the scale up trial record',
    `technology_transfer_checklist_status` STRING COMMENT 'Completion status of the formal technology transfer checklist documenting all required activities and sign-offs.. Valid values are `not_started|in_progress|completed|approved`',
    `trial_code` STRING COMMENT 'Business identifier code assigned to the scale-up trial for external reference and tracking across R&D and manufacturing systems.',
    `trial_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the scale-up trial including raw materials, labor, equipment time, and testing.',
    `trial_date` DATE COMMENT 'The date on which the scale-up trial was conducted at the manufacturing facility.',
    `trial_status` STRING COMMENT 'Overall outcome status of the scale-up trial: pass (successful), fail (unsuccessful), conditional_pass (passed with minor issues), in_progress (ongoing), or cancelled.. Valid values are `pass|fail|conditional_pass|in_progress|cancelled`',
    `trial_type` STRING COMMENT 'Classification of the scale-up trial based on production scale: pilot (small-scale test), semi-commercial (intermediate scale), commercial (full production scale), or validation (qualification run).. Valid values are `pilot|semi_commercial|commercial|validation`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the scale up trial record',
    `viscosity_cps` STRING COMMENT 'Measured viscosity of the scaled-up batch, key quality attribute for product consistency and consumer experience.',
    `yield_pct` DECIMAL(18,2) COMMENT 'The yield pct of the scale up trial record',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Actual production yield as a percentage of theoretical yield, indicating manufacturing efficiency and material loss.',
    CONSTRAINT pk_scale_up_trial PRIMARY KEY(`scale_up_trial_id`)
) COMMENT 'Records manufacturing scale-up trials conducted to transfer formulations from R&D bench scale to pilot or commercial production scale, serving as the formal technology transfer record. Captures trial date, manufacturing site, batch size, equipment used, process parameters (mixing speed, temperature, time, order of addition), yield, in-process test results, deviation observations, scale-up status (pass/fail/conditional), technology transfer checklist completion, and manufacturing readiness sign-off. Bridges R&D formulation development with manufacturing operations and commercial launch readiness.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` (
    `study_protocol_id` BIGINT COMMENT 'Primary key for study_protocol',
    `amended_study_protocol_id` BIGINT COMMENT 'Self-referencing FK on study_protocol (amended_study_protocol_id)',
    `rd_project_id` BIGINT COMMENT 'The rd project id of the study protocol record',
    `employee_id` BIGINT COMMENT 'The study author employee id of the study protocol record',
    `study_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the sponsor entity.',
    `amendment_date` DATE COMMENT 'Date on which the amendment became effective.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment applied to the protocol.',
    `approval_date` DATE COMMENT 'The approval date of the study protocol record',
    `approval_status` STRING COMMENT 'The approval status of the study protocol record',
    `blinding` STRING COMMENT 'Degree of masking applied in the study.',
    `study_protocol_code` STRING COMMENT 'The study protocol code of the study protocol record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the study protocol record',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the protocol record was first created in the system.',
    `data_retention_period` STRING COMMENT 'Number of days the study data must be retained after completion.',
    `data_sharing_policy` STRING COMMENT 'Policy governing external sharing of study data.',
    `study_protocol_description` STRING COMMENT 'Free‑text description summarizing the study protocol.',
    `design_type` STRING COMMENT 'Structural design of the study.',
    `effective_end_date` DATE COMMENT 'Date when the protocol ceases to be effective (null if open‑ended).',
    `effective_from` DATE COMMENT 'The effective from of the study protocol record',
    `effective_start_date` DATE COMMENT 'Date when the protocol becomes operationally effective.',
    `effective_until` DATE COMMENT 'The effective until of the study protocol record',
    `ethics_approval_date` DATE COMMENT 'Date when the ethics committee granted approval.',
    `ethics_approval_number` STRING COMMENT 'Identifier of the ethics committee approval.',
    `exclusion_criteria` STRING COMMENT 'Conditions that disqualify participants.',
    `inclusion_criteria` STRING COMMENT 'Conditions participants must meet to be eligible.',
    `indication` STRING COMMENT 'Specific medical condition or consumer need addressed by the study.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the protocol contains confidential information.',
    `study_protocol_name` STRING COMMENT 'The study protocol name of the study protocol record',
    `notes` STRING COMMENT 'The notes of the study protocol record',
    `objective` STRING COMMENT 'The objective of the study protocol record',
    `primary_endpoint` STRING COMMENT 'Main outcome measure used to assess study success.',
    `protocol_code` STRING COMMENT 'Business code or alphanumeric identifier assigned to the protocol by the sponsor or R&D organization.',
    `protocol_name` STRING COMMENT 'Human‑readable name of the study protocol.',
    `protocol_status` STRING COMMENT 'The protocol status of the study protocol record',
    `protocol_title` STRING COMMENT 'The protocol title of the study protocol record',
    `protocol_type` STRING COMMENT 'Category describing the overall nature of the protocol.',
    `protocol_version` STRING COMMENT 'The protocol version of the study protocol record',
    `randomization_method` STRING COMMENT 'Method used to assign participants to study arms.',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval was granted.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory authority approval.',
    `sample_size` BIGINT COMMENT 'Target number of participants or units to be enrolled.',
    `secondary_endpoints` STRING COMMENT 'Additional outcome measures, stored as a delimited list.',
    `source_system_code` STRING COMMENT 'The source system code of the study protocol record',
    `sponsor_name` STRING COMMENT 'Legal name of the organization sponsoring the study.',
    `statistical_analysis_plan` STRING COMMENT 'Reference to the detailed statistical methodology document.',
    `study_phase` STRING COMMENT 'Regulatory phase of the study (if applicable).',
    `study_protocol_status` STRING COMMENT 'Current lifecycle status of the protocol.',
    `therapeutic_area` STRING COMMENT 'Broad therapeutic domain (e.g., dermatology, oral care).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the protocol record.',
    `version_number` STRING COMMENT 'Version identifier for the protocol (e.g., v1.0, v2.1).',
    CONSTRAINT pk_study_protocol PRIMARY KEY(`study_protocol_id`)
) COMMENT 'Master reference table for study_protocol. Referenced by study_protocol_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`respondent` (
    `respondent_id` BIGINT COMMENT 'Primary key for respondent',
    `consumer_test_id` BIGINT COMMENT 'The consumer test id of the respondent record',
    `panel_id` BIGINT COMMENT 'Identifier of the panel or source group the respondent belongs to.',
    `referring_respondent_id` BIGINT COMMENT 'Self-referencing FK on respondent (referring_respondent_id)',
    `shopper_id` BIGINT COMMENT 'The shopper id of the respondent record',
    `address_line1` STRING COMMENT 'First line of respondents mailing address.',
    `address_line2` STRING COMMENT 'Second line of respondents mailing address.',
    `age` STRING COMMENT 'The age of the respondent record',
    `age_band` STRING COMMENT 'The age band of the respondent record',
    `city` STRING COMMENT 'City of residence.',
    `respondent_code` STRING COMMENT 'The respondent code of the respondent record',
    `consent_flag` BOOLEAN COMMENT 'The consent flag of the respondent record',
    `consent_given_date` DATE COMMENT 'Date when the respondent gave consent for participation.',
    `consent_revoked_flag` BOOLEAN COMMENT 'Indicates if the respondent has revoked consent.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of respondent.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the respondent record was first created.',
    `date_of_birth` DATE COMMENT 'Birth date of the respondent.',
    `respondent_description` STRING COMMENT 'The respondent description of the respondent record',
    `device_type` STRING COMMENT 'Primary device type used for online surveys.',
    `education_level` STRING COMMENT 'Highest education level attained by the respondent.',
    `effective_from` DATE COMMENT 'The effective from of the respondent record',
    `effective_until` DATE COMMENT 'The effective until of the respondent record',
    `email` STRING COMMENT 'Primary email address for contacting the respondent.',
    `ethnicity` STRING COMMENT 'Self‑reported ethnicity of the respondent.',
    `external_code` STRING COMMENT 'External identifier from third‑party panel provider.',
    `full_name` STRING COMMENT 'Legal full name of the respondent.',
    `gender` STRING COMMENT 'Self‑reported gender of the respondent.',
    `household_size` STRING COMMENT 'Number of individuals in the respondents household.',
    `income_bracket` STRING COMMENT 'Income bracket category of the respondent.',
    `ip_address` STRING COMMENT 'Last known IP address used during survey participation.',
    `language_preference` STRING COMMENT 'Preferred language for survey communications.',
    `last_participation_date` DATE COMMENT 'Date of the most recent survey completed by the respondent.',
    `marital_status` STRING COMMENT 'Marital status of the respondent.',
    `respondent_name` STRING COMMENT 'The respondent name of the respondent record',
    `notes` STRING COMMENT 'The notes of the respondent record',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates if the respondent opted out of future research contact.',
    `phone_number` STRING COMMENT 'Primary phone number of the respondent.',
    `postal_code` STRING COMMENT 'Postal code of the respondents address.',
    `preferred_contact_method` STRING COMMENT 'Preferred method for contacting the respondent.',
    `recruitment_source` STRING COMMENT 'Source through which the respondent was recruited (e.g., online panel, social media, referral).',
    `region` STRING COMMENT 'Broad geographic region of the respondent.',
    `respondent_status` STRING COMMENT 'Current lifecycle status of the respondent.',
    `respondent_type` STRING COMMENT 'Category of respondent based on role in research.',
    `segment` STRING COMMENT 'The segment of the respondent record',
    `source_system_code` STRING COMMENT 'The source system code of the respondent record',
    `state_province` STRING COMMENT 'State or province of residence.',
    `survey_participation_count` STRING COMMENT 'Total number of surveys the respondent has completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the respondent record.',
    CONSTRAINT pk_respondent PRIMARY KEY(`respondent_id`)
) COMMENT 'Master reference table for respondent. Referenced by respondent_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` (
    `research_sample_id` BIGINT COMMENT 'Primary key for sample',
    `prototype_id` BIGINT COMMENT 'The prototype id of the research sample record',
    `rd_project_id` BIGINT COMMENT 'Identifier of the R&D project to which the sample belongs.',
    `research_formulation_id` BIGINT COMMENT 'The research formulation id of the research sample record',
    `research_stability_study_id` BIGINT COMMENT 'The research stability study id of the research sample record',
    `sample_id` BIGINT COMMENT 'The secondary quality sample id of the research sample record',
    `supplier_id` BIGINT COMMENT 'Identifier of the external supplier providing the raw material.',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier associated with the sample.',
    `batch_reference` STRING COMMENT 'The batch reference of the research sample record',
    `collected_by` STRING COMMENT 'Name of the person who collected the sample.',
    `collection_date` DATE COMMENT 'The collection date of the research sample record',
    `collection_location` STRING COMMENT 'Lab or facility where the sample was collected.',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was collected.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the sample meets all applicable compliance requirements.',
    `concentration_percent` DECIMAL(18,2) COMMENT 'Concentration of active ingredient expressed as a percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research sample record',
    `effective_from` DATE COMMENT 'The effective from of the research sample record',
    `effective_until` DATE COMMENT 'The effective until of the research sample record',
    `expiry_date` DATE COMMENT 'Date after which the sample is considered expired for testing.',
    `hazard_classification` STRING COMMENT 'Safety hazard level associated with the sample.',
    `is_control` BOOLEAN COMMENT 'True if the sample is a control/reference specimen used for assay validation.',
    `material_category` STRING COMMENT 'Broad classification of the material type of the sample.',
    `notes` STRING COMMENT 'Additional observations or comments recorded by lab personnel.',
    `quality_status` STRING COMMENT 'Result of quality assessment performed on the sample.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the research sample record',
    `quantity_uom` STRING COMMENT 'The quantity uom of the research sample record',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sample record.',
    `regulatory_status` STRING COMMENT 'Regulatory review outcome for the sample.',
    `sample_description` STRING COMMENT 'Free‑text description of the sample, including purpose and key characteristics.',
    `sample_status` STRING COMMENT 'Current state of the sample within the development workflow.',
    `sample_type` STRING COMMENT 'Category of the sample indicating its role in the R&D process.',
    `source_system_code` STRING COMMENT 'The source system code of the research sample record',
    `storage_condition` STRING COMMENT 'Environmental condition required for sample storage.',
    `storage_location` STRING COMMENT 'The storage location of the research sample record',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the sample is stored, expressed in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research sample record',
    `volume_ml` DECIMAL(18,2) COMMENT 'Physical volume of the sample in milliliters.',
    `weight_g` DECIMAL(18,2) COMMENT 'Weight of the sample in grams.',
    CONSTRAINT pk_research_sample PRIMARY KEY(`research_sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` (
    `patent_family_id` BIGINT COMMENT 'Primary key for patent_family',
    `employee_id` BIGINT COMMENT 'Identifier of the lead inventor.',
    `parent_patent_family_id` BIGINT COMMENT 'Self-referencing FK on patent_family (parent_patent_family_id)',
    `rd_project_id` BIGINT COMMENT 'The rd project id of the patent family record',
    `assignee_code` BIGINT COMMENT 'Identifier of the assignee organization.',
    `assignee_name` STRING COMMENT 'Name of the organization owning the patent family.',
    `patent_family_code` STRING COMMENT 'The patent family code of the patent family record',
    `confidentiality_expiry_date` DATE COMMENT 'Date when confidentiality ends.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `patent_family_description` STRING COMMENT 'Narrative description of the patent family.',
    `effective_from` DATE COMMENT 'The effective from of the patent family record',
    `effective_until` DATE COMMENT 'The effective until of the patent family record',
    `expiration_date` DATE COMMENT 'Date when the patent family expires.',
    `family_code` STRING COMMENT 'Unique business identifier/code for the patent family.',
    `family_name` STRING COMMENT 'Human readable name of the patent family.',
    `family_status` STRING COMMENT 'The family status of the patent family record',
    `family_title` STRING COMMENT 'The family title of the patent family record',
    `family_type` STRING COMMENT 'Category of patents in the family.',
    `filing_date` DATE COMMENT 'Date of the earliest filing within the family.',
    `grant_date` DATE COMMENT 'Date of the earliest grant within the family.',
    `ipc_classification` STRING COMMENT 'IPC code representing the technical field.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the patent family details are confidential.',
    `jurisdiction` STRING COMMENT 'Country code of the primary jurisdiction for the family.',
    `keywords` STRING COMMENT 'Comma-separated keywords describing the family.',
    `licensing_status` STRING COMMENT 'Current licensing status of the patent family.',
    `market_region` STRING COMMENT 'Primary market region for the patented products.',
    `member_count` STRING COMMENT 'The member count of the patent family record',
    `patent_family_name` STRING COMMENT 'The patent family name of the patent family record',
    `notes` STRING COMMENT 'The notes of the patent family record',
    `number_of_patents` STRING COMMENT 'Total count of individual patents within the family.',
    `patent_family_status` STRING COMMENT 'Current lifecycle status of the patent family.',
    `primary_inventor_name` STRING COMMENT 'Name of the lead inventor for the family.',
    `priority_date` DATE COMMENT 'Date of the priority filing.',
    `priority_number` STRING COMMENT 'Priority filing number for the family.',
    `related_product_codes` STRING COMMENT 'Identifiers of consumer goods linked to the patent family.',
    `royalty_currency` STRING COMMENT 'Currency code for royalty payments.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Royalty rate applicable to licensed patents (percentage).',
    `source_system_code` STRING COMMENT 'The source system code of the patent family record',
    `strategic_importance_score` DECIMAL(18,2) COMMENT 'Score (0-100) indicating strategic value of the family.',
    `technology_area` STRING COMMENT 'Broad technology domain of the patent family (e.g., cosmetics, cleaning).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_patent_family PRIMARY KEY(`patent_family_id`)
) COMMENT 'Master reference table for patent_family. Referenced by patent_family_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` (
    `panel_session_id` BIGINT COMMENT 'Primary key for panel_session',
    `consumer_test_id` BIGINT COMMENT 'The consumer test id of the panel session record',
    `followup_panel_session_id` BIGINT COMMENT 'Self-referencing FK on panel_session (followup_panel_session_id)',
    `employee_id` BIGINT COMMENT 'The moderator employee id of the panel session record',
    `panel_id` BIGINT COMMENT 'Identifier of the consumer panel participating in the session.',
    `panel_rd_project_id` BIGINT COMMENT 'The panel rd project id of the panel session record',
    `rd_project_id` BIGINT COMMENT 'Identifier of the research project to which the session belongs.',
    `panel_session_code` STRING COMMENT 'The panel session code of the panel session record',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the session.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was first created.',
    `data_collection_method` STRING COMMENT 'Method(s) used to capture data during the session.',
    `panel_session_description` STRING COMMENT 'Free‑form description of the session purpose and design.',
    `device_type` STRING COMMENT 'Type of device participants used to join the session.',
    `duration_minutes` STRING COMMENT 'Planned length of the session in minutes.',
    `effective_from` DATE COMMENT 'The effective from of the panel session record',
    `effective_until` DATE COMMENT 'The effective until of the panel session record',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the session ended.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary incentive offered to each participant.',
    `language` STRING COMMENT 'Primary language used during the session.',
    `location` STRING COMMENT 'Physical or virtual location where the session took place.',
    `moderator_name` STRING COMMENT 'Name of the moderator or facilitator leading the session.',
    `panel_session_name` STRING COMMENT 'The panel session name of the panel session record',
    `notes` STRING COMMENT 'Additional free‑form notes captured by researchers.',
    `panel_session_status` STRING COMMENT 'Current lifecycle status of the session.',
    `panelist_count` STRING COMMENT 'The panelist count of the panel session record',
    `recruitment_method` STRING COMMENT 'Method used to recruit participants for the session.',
    `sample_size` STRING COMMENT 'Number of participants scheduled for the session.',
    `session_code` STRING COMMENT 'External or legacy code used to reference the session.',
    `session_date` DATE COMMENT 'The session date of the panel session record',
    `session_duration_minutes` STRING COMMENT 'The session duration minutes of the panel session record',
    `session_name` STRING COMMENT 'Human‑readable name of the panel session.',
    `session_status` STRING COMMENT 'The session status of the panel session record',
    `session_type` STRING COMMENT 'Category of the research session.',
    `source_system_code` STRING COMMENT 'The source system code of the panel session record',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the session started.',
    `updated_by` STRING COMMENT 'User or system that last updated the session record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the session record.',
    `created_by` STRING COMMENT 'User or system that created the session record.',
    CONSTRAINT pk_panel_session PRIMARY KEY(`panel_session_id`)
) COMMENT 'Master reference table for panel_session. Referenced by panel_session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_innovation_brief_id` FOREIGN KEY (`innovation_brief_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`innovation_brief`(`innovation_brief_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ADD CONSTRAINT `fk_research_stage_gate_milestone_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ADD CONSTRAINT `fk_research_research_formulation_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ADD CONSTRAINT `fk_research_research_formulation_ingredient_raw_material_spec_id` FOREIGN KEY (`raw_material_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`raw_material_spec`(`raw_material_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ADD CONSTRAINT `fk_research_research_formulation_ingredient_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ADD CONSTRAINT `fk_research_inci_library_raw_material_spec_id` FOREIGN KEY (`raw_material_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`raw_material_spec`(`raw_material_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_original_test_lab_test_id` FOREIGN KEY (`original_test_lab_test_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`lab_test`(`lab_test_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_research_sample_id` FOREIGN KEY (`research_sample_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_sample`(`research_sample_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ADD CONSTRAINT `fk_research_research_stability_study_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ADD CONSTRAINT `fk_research_stability_timepoint_research_stability_study_id` FOREIGN KEY (`research_stability_study_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_stability_study`(`research_stability_study_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_study_protocol_id` FOREIGN KEY (`study_protocol_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`study_protocol`(`study_protocol_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_respondent_id` FOREIGN KEY (`respondent_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`respondent`(`respondent_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ADD CONSTRAINT `fk_research_consumer_test_result_consumer_test_id` FOREIGN KEY (`consumer_test_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`consumer_test`(`consumer_test_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ADD CONSTRAINT `fk_research_consumer_test_result_prototype_id` FOREIGN KEY (`prototype_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`prototype`(`prototype_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ADD CONSTRAINT `fk_research_consumer_test_result_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ADD CONSTRAINT `fk_research_consumer_test_result_respondent_id` FOREIGN KEY (`respondent_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`respondent`(`respondent_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ADD CONSTRAINT `fk_research_sensory_evaluation_panel_session_id` FOREIGN KEY (`panel_session_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`panel_session`(`panel_session_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ADD CONSTRAINT `fk_research_sensory_evaluation_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ADD CONSTRAINT `fk_research_sensory_evaluation_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ADD CONSTRAINT `fk_research_prototype_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ADD CONSTRAINT `fk_research_prototype_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ADD CONSTRAINT `fk_research_prototype_superseded_by_prototype_id` FOREIGN KEY (`superseded_by_prototype_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`prototype`(`prototype_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`patent_family`(`patent_family_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ADD CONSTRAINT `fk_research_regulatory_dossier_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ADD CONSTRAINT `fk_research_regulatory_dossier_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_consumer_test_id` FOREIGN KEY (`consumer_test_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`consumer_test`(`consumer_test_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_lab_test_id` FOREIGN KEY (`lab_test_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`lab_test`(`lab_test_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_study_protocol_id` FOREIGN KEY (`study_protocol_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`study_protocol`(`study_protocol_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ADD CONSTRAINT `fk_research_raw_material_spec_inci_library_id` FOREIGN KEY (`inci_library_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`inci_library`(`inci_library_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ADD CONSTRAINT `fk_research_research_packaging_spec_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_supersedes_assessment_safety_assessment_id` FOREIGN KEY (`supersedes_assessment_safety_assessment_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`safety_assessment`(`safety_assessment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ADD CONSTRAINT `fk_research_study_protocol_amended_study_protocol_id` FOREIGN KEY (`amended_study_protocol_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`study_protocol`(`study_protocol_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ADD CONSTRAINT `fk_research_study_protocol_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ADD CONSTRAINT `fk_research_respondent_consumer_test_id` FOREIGN KEY (`consumer_test_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`consumer_test`(`consumer_test_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ADD CONSTRAINT `fk_research_respondent_referring_respondent_id` FOREIGN KEY (`referring_respondent_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`respondent`(`respondent_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ADD CONSTRAINT `fk_research_research_sample_prototype_id` FOREIGN KEY (`prototype_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`prototype`(`prototype_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ADD CONSTRAINT `fk_research_research_sample_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ADD CONSTRAINT `fk_research_research_sample_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ADD CONSTRAINT `fk_research_research_sample_research_stability_study_id` FOREIGN KEY (`research_stability_study_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_stability_study`(`research_stability_study_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ADD CONSTRAINT `fk_research_patent_family_parent_patent_family_id` FOREIGN KEY (`parent_patent_family_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`patent_family`(`patent_family_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ADD CONSTRAINT `fk_research_patent_family_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ADD CONSTRAINT `fk_research_panel_session_consumer_test_id` FOREIGN KEY (`consumer_test_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`consumer_test`(`consumer_test_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ADD CONSTRAINT `fk_research_panel_session_followup_panel_session_id` FOREIGN KEY (`followup_panel_session_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`panel_session`(`panel_session_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ADD CONSTRAINT `fk_research_panel_session_panel_rd_project_id` FOREIGN KEY (`panel_rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ADD CONSTRAINT `fk_research_panel_session_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`research` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_consumer_goods_v1`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` SET TAGS ('dbx_subdomain' = 'innovation_pipeline');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `innovation_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Sponsor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `rd_project_lead_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Lead Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `rd_project_lead_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `rd_project_lead_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `budget_spent` SET TAGS ('dbx_business_glossary_term' = 'Budget Spent');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `budget_spent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `business_opportunity_context` SET TAGS ('dbx_business_glossary_term' = 'Business Opportunity Context');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `rd_project_code` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `competitive_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `current_milestone` SET TAGS ('dbx_business_glossary_term' = 'Current Milestone');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `current_stage` SET TAGS ('dbx_business_glossary_term' = 'Current Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `rd_project_description` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `desired_benefits` SET TAGS ('dbx_business_glossary_term' = 'Desired Benefits');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `key_performance_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicators (KPIs)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `milestone_due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `rd_project_name` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `patent_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `patent_filing_status` SET TAGS ('dbx_value_regex' = 'not_applicable|planned|filed|granted|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `portfolio_category` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Project Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_product|reformulation|line_extension|cost_optimization|packaging_innovation|sustainability_initiative');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `rd_project_status` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `stage_gate_phase` SET TAGS ('dbx_business_glossary_term' = 'Stage-Gate Phase');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `strategic_fit_rationale` SET TAGS ('dbx_business_glossary_term' = 'Strategic Fit Rationale');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|exploratory');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `target_cogs` SET TAGS ('dbx_business_glossary_term' = 'Target Cost of Goods Sold (COGS)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `target_cogs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `target_consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `target_rsp` SET TAGS ('dbx_business_glossary_term' = 'Target Recommended Selling Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `target_rsp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` SET TAGS ('dbx_subdomain' = 'innovation_pipeline');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `stage_gate_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Milestone ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `primary_stage_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `primary_stage_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `primary_stage_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `tertiary_stage_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `tertiary_stage_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `tertiary_stage_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `action_items` SET TAGS ('dbx_business_glossary_term' = 'Gate Action Items');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `stage_gate_milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Milestone Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `consumer_acceptance_score` SET TAGS ('dbx_business_glossary_term' = 'Consumer Acceptance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision Rationale');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `delay_reason` SET TAGS ('dbx_business_glossary_term' = 'Milestone Delay Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `deliverables_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Checklist Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `deliverables_checklist_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|partial|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `deliverables_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Completion Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `stage_gate_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Milestone Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_attendees` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Attendees');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_criteria` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_criteria_met_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria Met Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_criteria_total_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria Total Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_decision` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_decision` SET TAGS ('dbx_value_regex' = 'go|kill|hold|recycle');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Gate Duration Days');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_name` SET TAGS ('dbx_business_glossary_term' = 'Gate Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_number` SET TAGS ('dbx_business_glossary_term' = 'Gate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_number` SET TAGS ('dbx_value_regex' = 'G0|G1|G2|G3|G4|G5');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_status` SET TAGS ('dbx_business_glossary_term' = 'Gate Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `gate_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_review|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `investment_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Investment Approved Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `investment_approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `investment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Investment Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `investment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `is_milestone_delayed` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Delayed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `market_attractiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Market Attractiveness Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `market_attractiveness_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `stage_gate_milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Milestone Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `next_gate_target_date` SET TAGS ('dbx_business_glossary_term' = 'Next Gate Target Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `npv_estimate` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `npv_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_assessed');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `roi_estimate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Estimate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `roi_estimate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `scheduled_review_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Gate Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `stage_gate_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Milestone Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `technical_feasibility_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Feasibility Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `technical_feasibility_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_subdomain' = 'formulation_science');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_ssot_authoritative' = 'product.product_formulation');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_ssot_alias_of' = 'product.product_formulation');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_ssot_canonical' = 'product.product_formulation');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_deprecated_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_ssot_concept' = 'formulation');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'R&D (Research and Development) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Formulator Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Scientist ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `claim_support_required` SET TAGS ('dbx_business_glossary_term' = 'Claim Support Required');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `consumer_test_score` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `cooling_rate_celsius_per_min` SET TAGS ('dbx_business_glossary_term' = 'Cooling Rate (Celsius Per Minute)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `cost_target_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Target Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `cost_target_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `cruelty_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Cruelty Free Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_description` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `development_status` SET TAGS ('dbx_business_glossary_term' = 'Development Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `discontinued_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinued Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Formulation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_description` SET TAGS ('dbx_business_glossary_term' = 'Formulation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_business_glossary_term' = 'Formulation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_business_glossary_term' = 'Formulation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `fragrance_type` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `fragrance_type` SET TAGS ('dbx_value_regex' = 'fragrance_free|hypoallergenic|standard|premium|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `inci_declaration` SET TAGS ('dbx_business_glossary_term' = 'Inci Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `is_cruelty_free` SET TAGS ('dbx_business_glossary_term' = 'Is Cruelty Free');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Is Vegan');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `lab_notebook_reference` SET TAGS ('dbx_business_glossary_term' = 'Lab Notebook Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `microbiological_challenge_test_passed` SET TAGS ('dbx_business_glossary_term' = 'Microbiological Challenge Test Passed');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `mixing_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Mixing Temperature (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `mixing_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mixing Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_name` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `natural_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Natural Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `patent_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Filed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `patent_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `ph_max` SET TAGS ('dbx_business_glossary_term' = 'Ph Max');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `ph_min` SET TAGS ('dbx_business_glossary_term' = 'Ph Min');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `preservative_system` SET TAGS ('dbx_business_glossary_term' = 'Preservative System');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'cosmetic|otc_drug|medical_device|biocide|food_contact|general_consumer_product');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_status` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `research_formulation_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|rejected|pending_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `sensory_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Sensory Evaluation Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `shelf_life_target_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Target (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `stability_test_status` SET TAGS ('dbx_business_glossary_term' = 'Stability Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `stability_test_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `target_consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `target_ph_max` SET TAGS ('dbx_business_glossary_term' = 'Target pH (Potential of Hydrogen) Maximum');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `target_ph_min` SET TAGS ('dbx_business_glossary_term' = 'Target pH (Potential of Hydrogen) Minimum');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `target_viscosity_cps` SET TAGS ('dbx_business_glossary_term' = 'Target Viscosity (Centipoise)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `vegan_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ALTER COLUMN `viscosity_cps` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Cps');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_subdomain' = 'formulation_science');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_ssot_authoritative' = 'product.product_formulation_ingredient');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_ssot_alias_of' = 'product.product_formulation_ingredient');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_ssot_canonical' = 'product.product_formulation_ingredient');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_deprecated_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_ssot_concept' = 'formulation_ingredient');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Ingredient ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `raw_material_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `product_formulation_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Ingredient Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `product_formulation_ingredient_id` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `product_formulation_ingredient_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `product_formulation_ingredient_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `addition_order` SET TAGS ('dbx_business_glossary_term' = 'Addition Order');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `asean_maximum_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'Association of Southeast Asian Nations (ASEAN) Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `asean_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Association of Southeast Asian Nations (ASEAN) Restricted Ingredient Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_code` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Ingredient Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `concentration_nominal_pct` SET TAGS ('dbx_business_glossary_term' = 'Concentration Nominal Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Concentration Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `concentration_uom` SET TAGS ('dbx_business_glossary_term' = 'Concentration Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `cost_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Kilogram');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `cost_per_kg` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_description` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Ingredient Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `einecs_number` SET TAGS ('dbx_business_glossary_term' = 'European Inventory of Existing Commercial Chemical Substances (EINECS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `einecs_number` SET TAGS ('dbx_value_regex' = '^d{3}-d{3}-d$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `eu_maximum_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `eu_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) Restricted Ingredient Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `function_class` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Function Class');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `inclusion_basis` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `inclusion_basis` SET TAGS ('dbx_value_regex' = 'w/w|w/v|v/v|ppm|ppb');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `ingredient_function` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Function');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `ingredient_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_value_regex' = 'active|under_review|restricted|discontinued|approved|pending_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `is_active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Is Active Ingredient');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `maximum_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `minimum_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Ingredient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `natural_origin_flag` SET TAGS ('dbx_business_glossary_term' = 'Natural Origin Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `palm_oil_derivative_flag` SET TAGS ('dbx_business_glossary_term' = 'Palm Oil Derivative Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `phase_assignment` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Phase Assignment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `phase_assignment` SET TAGS ('dbx_value_regex' = 'aqueous|oil|emulsion|powder|fragrance|preservative');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_status` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Ingredient Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `research_formulation_ingredient_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `target_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Trade Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `us_fda_maximum_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'United States Food and Drug Administration (US FDA) Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `us_fda_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'United States Food and Drug Administration (US FDA) Restricted Ingredient Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` SET TAGS ('dbx_subdomain' = 'formulation_science');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `inci_library_id` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Library Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `supplier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'R&D Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `approved_concentration_max_percentage` SET TAGS ('dbx_business_glossary_term' = 'Approved Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `approved_concentration_min_percentage` SET TAGS ('dbx_business_glossary_term' = 'Approved Minimum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `chemical_family` SET TAGS ('dbx_business_glossary_term' = 'Chemical Family Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `inci_library_code` SET TAGS ('dbx_business_glossary_term' = 'Inci Library Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `color_specification` SET TAGS ('dbx_business_glossary_term' = 'Color Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `inci_library_description` SET TAGS ('dbx_business_glossary_term' = 'Inci Library Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `function_category` SET TAGS ('dbx_business_glossary_term' = 'Function Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `function_class` SET TAGS ('dbx_business_glossary_term' = 'Functional Class');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `grade_quality_level` SET TAGS ('dbx_business_glossary_term' = 'Grade and Quality Level');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `inci_library_status` SET TAGS ('dbx_business_glossary_term' = 'Inci Library Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `ingredient_function` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Function');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `is_prohibited` SET TAGS ('dbx_business_glossary_term' = 'Is Prohibited');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `is_restricted` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `maximum_permitted_concentration_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maximum Permitted Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `moisture_content_max_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maximum Moisture Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `inci_library_name` SET TAGS ('dbx_business_glossary_term' = 'Inci Library Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `natural_origin_flag` SET TAGS ('dbx_business_glossary_term' = 'Natural Origin Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `odor_specification` SET TAGS ('dbx_business_glossary_term' = 'Odor Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `origin_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `particle_size_specification` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `patent_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Protected Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `physical_form` SET TAGS ('dbx_business_glossary_term' = 'Physical Form');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `prohibited_flag` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Ingredient Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `purity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `raw_material_code` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `rd_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `rd_approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|under_review|rejected|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_asean` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status - Association of Southeast Asian Nations (ASEAN)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_asean` SET TAGS ('dbx_value_regex' = 'approved|restricted|prohibited|pending_review|not_evaluated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_asean` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_asean` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_canada` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status - Canada');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_canada` SET TAGS ('dbx_value_regex' = 'approved|restricted|prohibited|pending_review|not_evaluated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_canada` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_canada` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_eu` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status - European Union (EU)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_eu` SET TAGS ('dbx_value_regex' = 'approved|restricted|prohibited|pending_review|not_evaluated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_eu` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_eu` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_usa` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status - United States of America (USA)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_usa` SET TAGS ('dbx_value_regex' = 'approved|restricted|prohibited|pending_review|not_evaluated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_usa` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `regulatory_status_usa` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Ingredient Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `sustainable_sourcing_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Sourcing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `svhc_flag` SET TAGS ('dbx_business_glossary_term' = 'Svhc Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ALTER COLUMN `vegan_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` SET TAGS ('dbx_subdomain' = 'safety_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `lab_test_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `original_test_lab_test_id` SET TAGS ('dbx_business_glossary_term' = 'Original Laboratory Test Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `primary_lab_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analyst Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `primary_lab_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `primary_lab_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Reviewer Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `research_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analyst Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `analyst_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Calibration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `lab_test_code` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Test Comments and Observations');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `lab_test_description` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `lab_test_status` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `lab_test_name` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `result_text` SET TAGS ('dbx_business_glossary_term' = 'Test Result Text Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Test Result Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `result_uom` SET TAGS ('dbx_business_glossary_term' = 'Result Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Test Result Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Test Result Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Test Result Reviewer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `specification_max` SET TAGS ('dbx_business_glossary_term' = 'Specification Maximum Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `specification_min` SET TAGS ('dbx_business_glossary_term' = 'Specification Minimum Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `specification_target` SET TAGS ('dbx_business_glossary_term' = 'Specification Target Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `stability_timepoint` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Timepoint');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Test Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Execution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_equipment` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_parameter` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical|regulatory');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` SET TAGS ('dbx_subdomain' = 'safety_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Stability Study ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_study_lead_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Study Lead Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_study_lead_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_study_lead_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `chamber_code` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `chamber_code` SET TAGS ('dbx_value_regex' = '^STAB-[A-Z0-9]{3,8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_stability_study_code` SET TAGS ('dbx_business_glossary_term' = 'Research Stability Study Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `color_stability_method` SET TAGS ('dbx_business_glossary_term' = 'Color Stability Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `color_stability_method` SET TAGS ('dbx_value_regex' = 'visual|colorimeter|spectrophotometer');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `container_closure_system` SET TAGS ('dbx_business_glossary_term' = 'Container Closure System');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'veeva_vault|sap_qm|lims|plm|manual_entry');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_stability_study_description` SET TAGS ('dbx_business_glossary_term' = 'Research Stability Study Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Duration Months');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'GMP (Good Manufacturing Practice) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Humidity Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `ich_condition` SET TAGS ('dbx_business_glossary_term' = 'ICH (International Council for Harmonisation) Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `inci_ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'INCI (International Nomenclature of Cosmetic Ingredients) Ingredient List');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `microbial_limit_cfu_per_g` SET TAGS ('dbx_business_glossary_term' = 'Microbial Limit (CFU per gram)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_stability_study_name` SET TAGS ('dbx_business_glossary_term' = 'Research Stability Study Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `overall_stability_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Overall Stability Conclusion');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `overall_stability_conclusion` SET TAGS ('dbx_value_regex' = 'stable|unstable|marginally_stable|pending|not_evaluated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `ph_target_range` SET TAGS ('dbx_business_glossary_term' = 'pH Target Range');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `ph_target_range` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}.[0-9]-[0-9]{1,2}.[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `planned_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `preservative_system` SET TAGS ('dbx_business_glossary_term' = 'Preservative System');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `recommended_shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Recommended Shelf Life (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `report_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^RPT-STB-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `research_stability_study_status` SET TAGS ('dbx_business_glossary_term' = 'Research Stability Study Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `sample_orientation` SET TAGS ('dbx_business_glossary_term' = 'Sample Orientation');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `sample_orientation` SET TAGS ('dbx_value_regex' = 'upright|inverted|horizontal|as_marketed');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `storage_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Study Duration Months');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_objective` SET TAGS ('dbx_business_glossary_term' = 'Study Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_protocol_number` SET TAGS ('dbx_value_regex' = '^STB-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|on_hold|completed|terminated|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'accelerated|real_time|intermediate|freeze_thaw|photostability|in_use');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `test_parameters` SET TAGS ('dbx_business_glossary_term' = 'Test Parameters');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `time_point_schedule` SET TAGS ('dbx_business_glossary_term' = 'Time Point Schedule');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `viscosity_target_range_cps` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Target Range (cPs)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ALTER COLUMN `viscosity_target_range_cps` SET TAGS ('dbx_value_regex' = '^[0-9]+-[0-9]+$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` SET TAGS ('dbx_subdomain' = 'safety_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `stability_timepoint_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Timepoint ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `research_stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Stability Study Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `analyst_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `appearance` SET TAGS ('dbx_business_glossary_term' = 'Appearance');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `stability_timepoint_code` SET TAGS ('dbx_business_glossary_term' = 'Stability Timepoint Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Color');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `data_integrity_hash` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Hash');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `stability_timepoint_description` SET TAGS ('dbx_business_glossary_term' = 'Stability Timepoint Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `deviation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `stability_timepoint_name` SET TAGS ('dbx_business_glossary_term' = 'Stability Timepoint Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `odor` SET TAGS ('dbx_business_glossary_term' = 'Odor');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive|pending|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'Ph Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `retest_reason` SET TAGS ('dbx_business_glossary_term' = 'Retest Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `specification_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `specification_target` SET TAGS ('dbx_business_glossary_term' = 'Specification Target');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `specification_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `stability_timepoint_status` SET TAGS ('dbx_business_glossary_term' = 'Stability Timepoint Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `storage_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity Percentage (%)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `test_method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `test_method_version` SET TAGS ('dbx_business_glossary_term' = 'Test Method Version');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `test_parameter` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `test_parameter` SET TAGS ('dbx_value_regex' = 'appearance|color|odor|pH|viscosity|assay');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `timepoint_interval` SET TAGS ('dbx_business_glossary_term' = 'Timepoint Interval');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `timepoint_label` SET TAGS ('dbx_business_glossary_term' = 'Timepoint Label');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `timepoint_months` SET TAGS ('dbx_business_glossary_term' = 'Timepoint Months');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ALTER COLUMN `viscosity_cps` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Cps');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `consumer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `respondent_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `respondent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `respondent_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `adverse_event_reported` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reported');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `claim_substantiation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `claim_substantiation_outcome` SET TAGS ('dbx_value_regex' = 'substantiated|not_substantiated|partially_substantiated|pending_review');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `claim_substantiation_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `consumer_test_code` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `consumer_test_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `consumer_test_description` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `efficacy_perception_rating` SET TAGS ('dbx_business_glossary_term' = 'Efficacy Perception Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `ethics_committee_approval` SET TAGS ('dbx_business_glossary_term' = 'Ethics Committee Approval');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `fragrance_rating` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `lather_rating` SET TAGS ('dbx_business_glossary_term' = 'Lather Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `lather_rating` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `lather_rating` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `consumer_test_name` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `open_text_verbatim` SET TAGS ('dbx_business_glossary_term' = 'Open Text Verbatim');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `open_text_verbatim` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `overall_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Satisfaction Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `overall_study_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Study Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `overall_study_outcome` SET TAGS ('dbx_value_regex' = 'claim_substantiated|claim_not_substantiated|inconclusive|study_terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `overall_study_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `panel_size` SET TAGS ('dbx_business_glossary_term' = 'Panel Size');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `primary_claim_tested` SET TAGS ('dbx_business_glossary_term' = 'Primary Claim Tested');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `primary_claim_tested` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `prototype_code` SET TAGS ('dbx_business_glossary_term' = 'Prototype Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `prototype_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `purchase_intent_score` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `rating_scale_max` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Maximum');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `rating_scale_min` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Minimum');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|not_required|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `secondary_claims_tested` SET TAGS ('dbx_business_glossary_term' = 'Secondary Claims Tested');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `secondary_claims_tested` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `skin_feel_rating` SET TAGS ('dbx_business_glossary_term' = 'Skin Feel Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `statistical_significance_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Study Cost Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|INR');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_design` SET TAGS ('dbx_business_glossary_term' = 'Study Design');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_design` SET TAGS ('dbx_value_regex' = 'single_blind|double_blind|open_label|randomized_controlled|crossover|parallel');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|recruiting|in_progress|completed|terminated|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'HUT|CLT|clinical_efficacy|dermatologist_test|sensory_evaluation|claim_substantiation');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `target_consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Test Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Test Duration Days');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Test Facility Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_facility_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_geography` SET TAGS ('dbx_business_glossary_term' = 'Test Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_methodology` SET TAGS ('dbx_business_glossary_term' = 'Test Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_panel` SET TAGS ('dbx_business_glossary_term' = 'Test Panel');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `consumer_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Result ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `consumer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Test Panel Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `prototype_id` SET TAGS ('dbx_business_glossary_term' = 'Product Prototype Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `respondent_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Identifier (Anonymized)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `respondent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `respondent_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `adverse_event_reported` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reported Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `attribute_measured` SET TAGS ('dbx_business_glossary_term' = 'Attribute Measured');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `attribute_name` SET TAGS ('dbx_business_glossary_term' = 'Attribute Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `attribute_tested` SET TAGS ('dbx_business_glossary_term' = 'Attribute Tested');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `benchmark_comparison` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Comparison');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `benchmark_comparison` SET TAGS ('dbx_value_regex' = 'better_than_benchmark|equal_to_benchmark|worse_than_benchmark|no_benchmark');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `claim_substantiation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `claim_substantiation_outcome` SET TAGS ('dbx_value_regex' = 'substantiated|not_substantiated|inconclusive|pending_review');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `consumer_test_result_code` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Result Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `consumer_test_result_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Result Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|invalid|suspect|missing_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `consumer_test_result_description` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Result Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `ethics_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Ethics Approval Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `consumer_test_result_name` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Result Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `nps_category` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `nps_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `purchase_intent` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `purchase_intent` SET TAGS ('dbx_value_regex' = 'definitely_would_buy|probably_would_buy|might_or_might_not_buy|probably_would_not_buy|definitely_would_not_buy');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `rank_position` SET TAGS ('dbx_business_glossary_term' = 'Rank Position');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `rating_label` SET TAGS ('dbx_business_glossary_term' = 'Rating Label');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_value_regex' = 'likert_5_point|likert_7_point|numeric_0_10|hedonic_9_point|binary_yes_no|visual_analog_scale');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `rating_value` SET TAGS ('dbx_business_glossary_term' = 'Rating Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `recorded_date` SET TAGS ('dbx_business_glossary_term' = 'Recorded Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `regulatory_submission_included` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `regulatory_submission_included` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `regulatory_submission_included` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `respondent_demographic_segment` SET TAGS ('dbx_business_glossary_term' = 'Respondent Demographic Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `score_scale` SET TAGS ('dbx_business_glossary_term' = 'Score Scale');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `score_value` SET TAGS ('dbx_business_glossary_term' = 'Score Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'none|mild|moderate|severe|life_threatening');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `statistical_significance_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `test_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `test_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Test Facility Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `test_protocol_code` SET TAGS ('dbx_business_glossary_term' = 'Test Protocol Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled|pending_analysis');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `usage_frequency` SET TAGS ('dbx_business_glossary_term' = 'Usage Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `sensory_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Sensory Evaluation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `panel_session_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Session ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Lead ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `after_feel_score` SET TAGS ('dbx_business_glossary_term' = 'After-Feel Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|requires_retest');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `attribute` SET TAGS ('dbx_business_glossary_term' = 'Attribute');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `attribute_name` SET TAGS ('dbx_business_glossary_term' = 'Attribute Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `attributes_assessed` SET TAGS ('dbx_business_glossary_term' = 'Attributes Assessed');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `benchmark_product_code` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Product Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `blinding_method` SET TAGS ('dbx_business_glossary_term' = 'Blinding Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `blinding_method` SET TAGS ('dbx_value_regex' = 'single_blind|double_blind|open_label');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `sensory_evaluation_code` SET TAGS ('dbx_business_glossary_term' = 'Sensory Evaluation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `color_score` SET TAGS ('dbx_business_glossary_term' = 'Color Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `sensory_evaluation_description` SET TAGS ('dbx_business_glossary_term' = 'Sensory Evaluation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluation_code` SET TAGS ('dbx_business_glossary_term' = 'Sensory Evaluation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluation_code` SET TAGS ('dbx_value_regex' = '^SE-[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `evaluator_count` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `formulation_version` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `formulation_version` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Intensity Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `sensory_evaluation_name` SET TAGS ('dbx_business_glossary_term' = 'Sensory Evaluation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `odor_score` SET TAGS ('dbx_business_glossary_term' = 'Odor Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `overall_liking_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Liking Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `panel_type` SET TAGS ('dbx_business_glossary_term' = 'Panel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `panel_type` SET TAGS ('dbx_value_regex' = 'trained_expert_panel|consumer_panel|qc_panel|internal_panel|external_panel');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `panelist_count` SET TAGS ('dbx_business_glossary_term' = 'Panelist Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `product_sample_code` SET TAGS ('dbx_business_glossary_term' = 'Product Sample Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `purchase_intent_score` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `rinse_off_feel_score` SET TAGS ('dbx_business_glossary_term' = 'Rinse-Off Feel Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `score_scale` SET TAGS ('dbx_business_glossary_term' = 'Score Scale');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `sensory_evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Sensory Evaluation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `sensory_profile_outcome` SET TAGS ('dbx_business_glossary_term' = 'Sensory Profile Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `sensory_profile_outcome` SET TAGS ('dbx_value_regex' = 'acceptable|unacceptable|needs_improvement|exceeds_expectations|benchmark_equivalent');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `spreadability_score` SET TAGS ('dbx_business_glossary_term' = 'Spreadability Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `statistical_significance` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `statistical_significance` SET TAGS ('dbx_value_regex' = 'significant|not_significant|inconclusive');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `test_conditions` SET TAGS ('dbx_business_glossary_term' = 'Test Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `texture_score` SET TAGS ('dbx_business_glossary_term' = 'Texture Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` SET TAGS ('dbx_subdomain' = 'innovation_pipeline');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_id` SET TAGS ('dbx_business_glossary_term' = 'Prototype ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `superseded_by_prototype_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Prototype ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `build_date` SET TAGS ('dbx_business_glossary_term' = 'Build Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `closure_type` SET TAGS ('dbx_business_glossary_term' = 'Closure Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_code` SET TAGS ('dbx_business_glossary_term' = 'Prototype Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `compatibility_test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Test Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `consumer_test_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `container_capacity_ml` SET TAGS ('dbx_business_glossary_term' = 'Container Capacity (Milliliters)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `container_capacity_ml` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `container_capacity_ml` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `container_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Container Diameter (Millimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `container_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Container Height (Millimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `container_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Container Weight (Grams)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `decoration_method` SET TAGS ('dbx_business_glossary_term' = 'Decoration Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_description` SET TAGS ('dbx_business_glossary_term' = 'Prototype Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `estimated_packaging_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Packaging Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `estimated_packaging_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `fill_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Fill Volume (Milliliters)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `fill_weight` SET TAGS ('dbx_business_glossary_term' = 'Fill Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `formulation_compatibility_test_status` SET TAGS ('dbx_business_glossary_term' = 'Formulation Compatibility Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `formulation_compatibility_test_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|conditional_pass');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `formulation_compatibility_test_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `formulation_compatibility_test_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `generation` SET TAGS ('dbx_business_glossary_term' = 'Prototype Generation');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `generation` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4|P5|P6');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `manufacturing_scale` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Scale');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `manufacturing_scale` SET TAGS ('dbx_value_regex' = 'bench|pilot|scale_up|production');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_name` SET TAGS ('dbx_business_glossary_term' = 'Prototype Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prototype Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `packaging_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Packaging Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `packaging_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Packaging Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `packaging_configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `packaging_configuration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `packaging_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `packaging_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `primary_container_material` SET TAGS ('dbx_business_glossary_term' = 'Primary Container Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `primary_container_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Container Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_status` SET TAGS ('dbx_business_glossary_term' = 'Prototype Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_status` SET TAGS ('dbx_value_regex' = 'active|superseded|approved_for_consumer_test|approved_for_scale_up|rejected|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_type` SET TAGS ('dbx_business_glossary_term' = 'Prototype Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `prototype_type` SET TAGS ('dbx_value_regex' = 'concept|functional|visual|pre-production|production_trial');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `quantity_produced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Produced');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `rd_packaging_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Packaging Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `rd_packaging_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `recyclability_classification` SET TAGS ('dbx_business_glossary_term' = 'Recyclability Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `recyclability_classification` SET TAGS ('dbx_value_regex' = 'widely_recyclable|limited_recyclability|not_recyclable|compostable|biodegradable');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `recycled_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|conditional_pass');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `secondary_packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Secondary Packaging Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `secondary_packaging_type` SET TAGS ('dbx_value_regex' = 'carton|blister|shrink_wrap|clamshell|none');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `stability_test_status` SET TAGS ('dbx_business_glossary_term' = 'Stability Test Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `stability_test_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `sustainable_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `target_launch_market` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Market');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `target_launch_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Prototype Creation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inventor Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `primary_patent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `primary_patent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `primary_patent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Patent Abstract');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `abstract` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `assignee_country_code` SET TAGS ('dbx_business_glossary_term' = 'Assignee Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `assignee_name` SET TAGS ('dbx_business_glossary_term' = 'Patent Assignee Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `backward_citations_count` SET TAGS ('dbx_business_glossary_term' = 'Backward Citations Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `claims_count` SET TAGS ('dbx_business_glossary_term' = 'Patent Claims Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_filing_code` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `commercial_value_tier` SET TAGS ('dbx_business_glossary_term' = 'Commercial Value Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `commercial_value_tier` SET TAGS ('dbx_value_regex' = 'strategic|high|medium|low|exploratory');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `commercial_value_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `cpc_class` SET TAGS ('dbx_business_glossary_term' = 'Cooperative Patent Classification (CPC) Class');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_filing_description` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `estimated_annual_maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Maintenance Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `estimated_annual_maintenance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `forward_citations_count` SET TAGS ('dbx_business_glossary_term' = 'Forward Citations Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `freedom_to_operate_status` SET TAGS ('dbx_business_glossary_term' = 'Freedom to Operate (FTO) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `freedom_to_operate_status` SET TAGS ('dbx_value_regex' = 'cleared|risk identified|under review|blocked|not assessed');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `freedom_to_operate_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Grant Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `independent_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Independent Claims Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `internal_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Patent Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `inventors_list` SET TAGS ('dbx_business_glossary_term' = 'Inventors List');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `inventors_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Patent Jurisdiction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `legal_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Legal Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `legal_status` SET TAGS ('dbx_value_regex' = 'active|lapsed|revoked|invalidated|maintained');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Licensing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'not licensed|licensed out|licensed in|cross-licensed|available for licensing');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `licensing_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `maintenance_fee_due_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Maintenance Fee Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_filing_name` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_attorney_firm` SET TAGS ('dbx_business_glossary_term' = 'Patent Attorney Firm');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Granted Patent Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_title` SET TAGS ('dbx_business_glossary_term' = 'Patent Title');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_type` SET TAGS ('dbx_business_glossary_term' = 'Patent Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `patent_type` SET TAGS ('dbx_value_regex' = 'utility|design|composition of matter|process|plant|reissue');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `pct_application_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Cooperation Treaty (PCT) Application Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `pct_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Cooperation Treaty (PCT) Application Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `primary_ipc_class` SET TAGS ('dbx_business_glossary_term' = 'Primary International Patent Classification (IPC) Class');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `prosecution_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Publication Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `publication_number` SET TAGS ('dbx_business_glossary_term' = 'Publication Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `secondary_ipc_classes` SET TAGS ('dbx_business_glossary_term' = 'Secondary International Patent Classification (IPC) Classes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Dossier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Regulatory Manager ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `actual_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `additional_information_due_date` SET TAGS ('dbx_business_glossary_term' = 'Additional Information Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `additional_information_requested` SET TAGS ('dbx_business_glossary_term' = 'Additional Information Requested Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `allergen_declaration_complete` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Complete Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `animal_testing_statement` SET TAGS ('dbx_business_glossary_term' = 'Animal Testing Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `animal_testing_statement` SET TAGS ('dbx_value_regex' = 'No Animal Testing|Animal Testing Conducted|Not Applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `authority_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Authority Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `claim_substantiation_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `claim_substantiation_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Approved|Insufficient');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `cmr_substance_present` SET TAGS ('dbx_business_glossary_term' = 'Carcinogenic Mutagenic Reprotoxic (CMR) Substance Present Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Dossier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `cpnp_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Cosmetic Product Notification Portal (CPNP) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Dossier Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `dossier_code` SET TAGS ('dbx_business_glossary_term' = 'Dossier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `dossier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dossier Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_business_glossary_term' = 'Dossier Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `dossier_type` SET TAGS ('dbx_business_glossary_term' = 'Dossier Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `dossier_type` SET TAGS ('dbx_value_regex' = 'CPNP EU Notification|FDA OTC Monograph|ASEAN Cosmetic Directive|Health Canada Notification|China NMPA Registration|Australia TGA Listing');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `dossier_version` SET TAGS ('dbx_business_glossary_term' = 'Dossier Version');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `expected_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Under Review|Not Applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `inci_listing_complete` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Listing Complete Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `intended_use_description` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `label_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Label Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `label_compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Under Review|Pending Approval');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Dossier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `nanomaterial_present` SET TAGS ('dbx_business_glossary_term' = 'Nanomaterial Present Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dossier Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `pif_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Information File (PIF) Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `preparation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `preservative_system_approved` SET TAGS ('dbx_business_glossary_term' = 'Preservative System Approved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_affairs_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Affairs Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_affairs_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_affairs_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_affairs_contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_affairs_contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Dossier Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_dossier_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Approved|Requires Revision');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `safety_assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `submission_category` SET TAGS ('dbx_business_glossary_term' = 'Submission Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `submission_category` SET TAGS ('dbx_value_regex' = 'New Product Registration|Product Modification|Renewal|Post-Market Notification|Safety Update');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `submission_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Submission Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `target_market_country_code` SET TAGS ('dbx_business_glossary_term' = 'Target Market Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `target_market_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `target_market_region` SET TAGS ('dbx_business_glossary_term' = 'Target Market Region');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `target_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Target Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` SET TAGS ('dbx_subdomain' = 'safety_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_substantiation_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `consumer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `lab_test_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `study_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `tertiary_claim_regulatory_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reviewer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `tertiary_claim_regulatory_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `tertiary_claim_regulatory_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `tertiary_claim_regulatory_reviewer_employee_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `tertiary_claim_regulatory_reviewer_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `advertising_standard_compliance` SET TAGS ('dbx_business_glossary_term' = 'Advertising Standard Compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `challenge_history` SET TAGS ('dbx_business_glossary_term' = 'Challenge History');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_category` SET TAGS ('dbx_business_glossary_term' = 'Claim Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_category` SET TAGS ('dbx_value_regex' = 'product_performance|ingredient_benefit|safety_assurance|sustainability|quality_certification|expert_endorsement');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_substantiation_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Claim Text');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'efficacy|safety|environmental|comparative|sensory|nutritional');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `clinical_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Clinical Study Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_substantiation_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level (Percent)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_substantiation_description` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `efficacy_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Efficacy Result Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|rejected|conditional_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `market_applicability` SET TAGS ('dbx_business_glossary_term' = 'Market Applicability');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `claim_substantiation_name` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_review_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_review_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `regulatory_review_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `statistical_significance_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `substantiation_code` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `substantiation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `substantiation_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Cost Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `substantiation_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `substantiation_method` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `substantiation_status` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `supporting_document_references` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document References');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `test_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` SET TAGS ('dbx_subdomain' = 'innovation_pipeline');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `innovation_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `primary_innovation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Sponsor Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `primary_innovation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `primary_innovation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `tertiary_innovation_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `tertiary_innovation_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `tertiary_innovation_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `tertiary_quinary_innovation_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `tertiary_quinary_innovation_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `tertiary_quinary_innovation_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `attachments_reference` SET TAGS ('dbx_business_glossary_term' = 'Attachments Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `brief_code` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `brief_code` SET TAGS ('dbx_value_regex' = '^IB-[0-9]{4}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `brief_status` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `brief_title` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Title');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `brief_type` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `brief_type` SET TAGS ('dbx_value_regex' = 'new_product|line_extension|reformulation|cost_reduction|sustainability_initiative|regulatory_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `business_opportunity_description` SET TAGS ('dbx_business_glossary_term' = 'Business Opportunity Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `innovation_brief_code` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `competitive_benchmark_products` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Products');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `consumer_insight` SET TAGS ('dbx_business_glossary_term' = 'Consumer Insight');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `consumer_need` SET TAGS ('dbx_business_glossary_term' = 'Consumer Need');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `innovation_brief_description` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `desired_product_benefits` SET TAGS ('dbx_business_glossary_term' = 'Desired Product Benefits');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `estimated_development_budget` SET TAGS ('dbx_business_glossary_term' = 'Estimated Development Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `estimated_development_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `estimated_market_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Market Size');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `estimated_market_size` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `estimated_npv` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Present Value (NPV)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `estimated_npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `estimated_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `estimated_roi_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `innovation_brief_status` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `innovation_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Innovation Priority Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `innovation_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1_strategic|tier_2_growth|tier_3_maintenance|tier_4_exploratory');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `key_performance_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicators (KPIs)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `market_size_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Market Size Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `market_size_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `innovation_brief_name` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `npv_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `npv_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_value_regex' = 'standard|expedited|notification|registration|pre_market_approval|exempt');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `strategic_fit_rationale` SET TAGS ('dbx_business_glossary_term' = 'Strategic Fit Rationale');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `sustainability_target_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_cogs` SET TAGS ('dbx_business_glossary_term' = 'Target Cost of Goods Sold (COGS)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_cogs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_gross_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_launch_geography` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_launch_geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_launch_geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_rsp` SET TAGS ('dbx_business_glossary_term' = 'Target Recommended Selling Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_rsp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` SET TAGS ('dbx_subdomain' = 'formulation_science');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `raw_material_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `inci_library_id` SET TAGS ('dbx_business_glossary_term' = 'Inci Library Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `approved_concentration_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Approved Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `approved_concentration_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Approved Minimum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Cas Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `raw_material_spec_code` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Spec Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `cost_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Kilogram');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `cost_per_kg` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `raw_material_spec_description` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Spec Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `einecs_number` SET TAGS ('dbx_business_glossary_term' = 'European Inventory of Existing Commercial Chemical Substances (EINECS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `einecs_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `eu_maximum_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `eu_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) Restricted Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `hazardous_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'Inci Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `raw_material_spec_name` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Spec Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `palm_oil_derivative_flag` SET TAGS ('dbx_business_glossary_term' = 'Palm Oil Derivative Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `particle_size_microns` SET TAGS ('dbx_business_glossary_term' = 'Particle Size in Microns');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `physical_form` SET TAGS ('dbx_business_glossary_term' = 'Physical Form');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `purity_pct` SET TAGS ('dbx_business_glossary_term' = 'Purity Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `raw_material_code` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `raw_material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `raw_material_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Spec Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `rd_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `rd_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_review|conditional|rejected|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `sds_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Available Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Months');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Spec Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `specification_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum in Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum in Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `us_fda_maximum_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'United States Food and Drug Administration (US FDA) Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `us_fda_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'United States Food and Drug Administration (US FDA) Restricted Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_subdomain' = 'formulation_science');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_ssot_authoritative' = 'product.product_packaging_spec');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_ssot_alias_of' = 'product.product_packaging_spec');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_ssot_canonical' = 'product.product_packaging_spec');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_deprecated_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_ssot_concept' = 'packaging_spec');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `research_packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Research Packaging Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `product_packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `product_packaging_spec_id` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `barrier_properties` SET TAGS ('dbx_business_glossary_term' = 'Barrier Properties Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `capacity_ml` SET TAGS ('dbx_business_glossary_term' = 'Packaging Capacity in Milliliters (ml)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `capacity_ml` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `capacity_ml` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `child_resistant_certified` SET TAGS ('dbx_business_glossary_term' = 'Child Resistant Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `closure_type` SET TAGS ('dbx_business_glossary_term' = 'Closure Type Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `research_packaging_spec_code` SET TAGS ('dbx_business_glossary_term' = 'Research Packaging Spec Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `color_specification` SET TAGS ('dbx_business_glossary_term' = 'Color Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `compatibility_test_date` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Test Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `compatibility_test_result` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Test Result Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `component_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Height in Millimeters (mm)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `component_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Length in Millimeters (mm)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Component Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|closure|label|insert');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `component_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Component Weight in Grams');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `component_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Width in Millimeters (mm)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `decoration_method` SET TAGS ('dbx_business_glossary_term' = 'Decoration Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `research_packaging_spec_description` SET TAGS ('dbx_business_glossary_term' = 'Research Packaging Spec Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `eu_reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `fda_food_contact_approved` SET TAGS ('dbx_business_glossary_term' = 'FDA Food Contact Approved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `formulation_compatibility_status` SET TAGS ('dbx_business_glossary_term' = 'Formulation Compatibility Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `formulation_compatibility_status` SET TAGS ('dbx_value_regex' = 'compatible|incompatible|testing_in_progress|not_tested|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `formulation_compatibility_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `formulation_compatibility_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Height Mm');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `is_recyclable` SET TAGS ('dbx_business_glossary_term' = 'Is Recyclable');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `length_mm` SET TAGS ('dbx_business_glossary_term' = 'Length Mm');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `research_packaging_spec_name` SET TAGS ('dbx_business_glossary_term' = 'Research Packaging Spec Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `pcr_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Pcr Content Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `prototype_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Prototype Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `rd_approval_status` SET TAGS ('dbx_business_glossary_term' = 'R&D Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `rd_approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|on_hold|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `recyclability_classification` SET TAGS ('dbx_business_glossary_term' = 'Recyclability Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `recyclability_classification` SET TAGS ('dbx_value_regex' = 'widely_recyclable|limited_recyclability|not_recyclable|check_locally|store_drop_off');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `research_packaging_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Research Packaging Spec Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Spec Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Spec Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Spec Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `specification_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `specification_code` SET TAGS ('dbx_value_regex' = '^PKG-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `tamper_evident_feature` SET TAGS ('dbx_business_glossary_term' = 'Tamper Evident Feature Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `technical_drawing_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Drawing Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Width Mm');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` SET TAGS ('dbx_subdomain' = 'safety_testing');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `supersedes_assessment_safety_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Assessment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `application_frequency` SET TAGS ('dbx_business_glossary_term' = 'Application Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `application_site` SET TAGS ('dbx_business_glossary_term' = 'Application Site');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'cosmetic_product_safety_report|toxicological_risk_assessment|dermal_sensitization_assessment|hript|ocular_irritation_assessment|mutagenicity_assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessor_qualification` SET TAGS ('dbx_business_glossary_term' = 'Assessor Qualification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessor_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Assessor Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `assessor_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `conclusion` SET TAGS ('dbx_business_glossary_term' = 'Conclusion');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `conditions_of_use` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Use');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `contraindications` SET TAGS ('dbx_business_glossary_term' = 'Contraindications');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `cpnp_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Cosmetic Products Notification Portal (CPNP) Notification Required');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `cpnp_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Cosmetic Products Notification Portal (CPNP) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_assessment_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `document_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `exposure_duration` SET TAGS ('dbx_business_glossary_term' = 'Exposure Duration');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `fda_registration_required` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Registration Required');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `label_warnings_required` SET TAGS ('dbx_business_glossary_term' = 'Label Warnings Required');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `margin_of_safety` SET TAGS ('dbx_business_glossary_term' = 'Margin of Safety (MoS)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `noael_value` SET TAGS ('dbx_business_glossary_term' = 'No Observed Adverse Effect Level (NOAEL) Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `regulatory_market_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Market Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `regulatory_market_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `regulatory_market_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `restricted_substances_compliance` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substances Compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `restricted_substances_findings` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substances Findings');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Safety Conclusion');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `safety_conclusion` SET TAGS ('dbx_value_regex' = 'safe|unsafe|conditionally_safe|insufficient_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `supporting_studies_summary` SET TAGS ('dbx_business_glossary_term' = 'Supporting Studies Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `systemic_exposure_estimate` SET TAGS ('dbx_business_glossary_term' = 'Systemic Exposure Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `target_population` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `target_population` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `toxicological_endpoints_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Toxicological Endpoints Evaluated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `toxicology_summary` SET TAGS ('dbx_business_glossary_term' = 'Toxicology Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `undesirable_effects_reported` SET TAGS ('dbx_business_glossary_term' = 'Undesirable Effects Reported');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` SET TAGS ('dbx_subdomain' = 'innovation_pipeline');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `scale_up_trial_id` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Trial Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Approver Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `actual_output_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Output in Kilograms (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `appearance_assessment` SET TAGS ('dbx_business_glossary_term' = 'Appearance Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Size in Kilograms (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `scale_up_trial_code` SET TAGS ('dbx_business_glossary_term' = 'Scale Up Trial Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `color_measurement` SET TAGS ('dbx_business_glossary_term' = 'Color Measurement');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `cooling_rate_celsius_per_min` SET TAGS ('dbx_business_glossary_term' = 'Cooling Rate in Celsius Per Minute');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `scale_up_trial_description` SET TAGS ('dbx_business_glossary_term' = 'Scale Up Trial Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `deviation_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Deviation Impact Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `deviation_observed_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Observed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `equipment_configuration` SET TAGS ('dbx_business_glossary_term' = 'Equipment Configuration');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `heating_rate_celsius_per_min` SET TAGS ('dbx_business_glossary_term' = 'Heating Rate in Celsius Per Minute');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `in_process_test_results` SET TAGS ('dbx_business_glossary_term' = 'In-Process Test Results');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `manufacturing_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Readiness Level (MRL)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `manufacturing_readiness_level` SET TAGS ('dbx_value_regex' = 'not_ready|pilot_ready|scale_up_ready|commercial_ready');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `manufacturing_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Sign-Off Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `mixing_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Mixing Speed in Revolutions Per Minute (RPM)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `mixing_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mixing Time in Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `scale_up_trial_name` SET TAGS ('dbx_business_glossary_term' = 'Scale Up Trial Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `next_steps` SET TAGS ('dbx_business_glossary_term' = 'Next Steps');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `odor_assessment` SET TAGS ('dbx_business_glossary_term' = 'Odor Assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `order_of_addition` SET TAGS ('dbx_business_glossary_term' = 'Order of Addition');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `pass_fail_rationale` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Rationale');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `process_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature in Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `quality_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Sign-Off Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `scale_factor` SET TAGS ('dbx_business_glossary_term' = 'Scale Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `scale_up_trial_status` SET TAGS ('dbx_business_glossary_term' = 'Scale Up Trial Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `technology_transfer_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Checklist Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `technology_transfer_checklist_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `trial_code` SET TAGS ('dbx_business_glossary_term' = 'Trial Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `trial_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Trial Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `trial_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `trial_date` SET TAGS ('dbx_business_glossary_term' = 'Trial Execution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `trial_status` SET TAGS ('dbx_business_glossary_term' = 'Trial Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `trial_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|in_progress|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `trial_type` SET TAGS ('dbx_business_glossary_term' = 'Trial Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `trial_type` SET TAGS ('dbx_value_regex' = 'pilot|semi_commercial|commercial|validation');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `viscosity_cps` SET TAGS ('dbx_business_glossary_term' = 'Viscosity in Centipoise (cPs)');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Yield Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `amended_study_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Amended Study Protocol Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `amended_study_protocol_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `blinding` SET TAGS ('dbx_business_glossary_term' = 'Blinding');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_protocol_code` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `data_retention_period` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `data_sharing_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Policy');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_protocol_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Design Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `ethics_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Ethics Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `ethics_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Ethics Approval Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_protocol_name` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `primary_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Primary Endpoint');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `protocol_code` SET TAGS ('dbx_business_glossary_term' = 'Protocol Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_business_glossary_term' = 'Protocol Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `protocol_status` SET TAGS ('dbx_business_glossary_term' = 'Protocol Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `protocol_title` SET TAGS ('dbx_business_glossary_term' = 'Protocol Title');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `protocol_type` SET TAGS ('dbx_business_glossary_term' = 'Protocol Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `randomization_method` SET TAGS ('dbx_business_glossary_term' = 'Randomization Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `secondary_endpoints` SET TAGS ('dbx_business_glossary_term' = 'Secondary Endpoints');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `statistical_analysis_plan` SET TAGS ('dbx_business_glossary_term' = 'Statistical Analysis Plan');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_phase` SET TAGS ('dbx_business_glossary_term' = 'Study Phase');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `study_protocol_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `respondent_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `consumer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `panel_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `referring_respondent_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Respondent Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `referring_respondent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `age` SET TAGS ('dbx_business_glossary_term' = 'Age');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `age_band` SET TAGS ('dbx_business_glossary_term' = 'Age Band');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `respondent_code` SET TAGS ('dbx_business_glossary_term' = 'Respondent Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `consent_given_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `consent_revoked_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date Of Birth');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `respondent_description` SET TAGS ('dbx_business_glossary_term' = 'Respondent Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `ethnicity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `gender` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Income Bracket');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Ip Address');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `last_participation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Participation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `marital_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `respondent_name` SET TAGS ('dbx_business_glossary_term' = 'Respondent Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt Out Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `recruitment_source` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Source');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `respondent_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `respondent_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `survey_participation_count` SET TAGS ('dbx_business_glossary_term' = 'Survey Participation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `research_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `prototype_id` SET TAGS ('dbx_business_glossary_term' = 'Prototype Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `research_stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Stability Study Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `collected_by` SET TAGS ('dbx_business_glossary_term' = 'Collected By');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `collection_location` SET TAGS ('dbx_business_glossary_term' = 'Collection Location');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'Concentration Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `is_control` SET TAGS ('dbx_business_glossary_term' = 'Is Control');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `sample_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature C');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Volume Ml');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ALTER COLUMN `weight_g` SET TAGS ('dbx_business_glossary_term' = 'Weight G');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `parent_patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Patent Family Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `parent_patent_family_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `assignee_code` SET TAGS ('dbx_business_glossary_term' = 'Assignee Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `assignee_name` SET TAGS ('dbx_business_glossary_term' = 'Assignee Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `patent_family_code` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `confidentiality_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `patent_family_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `family_code` SET TAGS ('dbx_business_glossary_term' = 'Family Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `family_status` SET TAGS ('dbx_business_glossary_term' = 'Family Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `family_title` SET TAGS ('dbx_business_glossary_term' = 'Family Title');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Family Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `ipc_classification` SET TAGS ('dbx_business_glossary_term' = 'Ipc Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `patent_family_name` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `patent_family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `patent_family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `number_of_patents` SET TAGS ('dbx_business_glossary_term' = 'Number Of Patents');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `patent_family_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `primary_inventor_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `primary_inventor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `primary_inventor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `priority_number` SET TAGS ('dbx_business_glossary_term' = 'Priority Number');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `related_product_codes` SET TAGS ('dbx_business_glossary_term' = 'Related Product Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `related_product_codes` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `related_product_codes` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `royalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Royalty Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `strategic_importance_score` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` SET TAGS ('dbx_subdomain' = 'consumer_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `panel_session_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Session Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `consumer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `followup_panel_session_id` SET TAGS ('dbx_business_glossary_term' = 'Followup Panel Session Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `followup_panel_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Moderator Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `panel_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `panel_rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_role' = 'related_rd_project');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `panel_session_code` SET TAGS ('dbx_business_glossary_term' = 'Panel Session Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `panel_session_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `moderator_name` SET TAGS ('dbx_business_glossary_term' = 'Moderator Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `panel_session_name` SET TAGS ('dbx_business_glossary_term' = 'Panel Session Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `panel_session_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `panelist_count` SET TAGS ('dbx_business_glossary_term' = 'Panelist Count');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `recruitment_method` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `session_date` SET TAGS ('dbx_business_glossary_term' = 'Session Date');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `session_name` SET TAGS ('dbx_business_glossary_term' = 'Session Name');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
