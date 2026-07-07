-- Schema for Domain: research | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`research` COMMENT 'R&D for next-generation process nodes, novel device architectures (FinFET, GAA, CFET), advanced packaging technologies, materials research, and new IP core development. Manages technology roadmaps, proof-of-concept projects, experimental wafer lots, IP filing records, and collaboration with research institutions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`research_program` (
    `research_program_id` BIGINT COMMENT 'Primary key for program',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Program‑level budgeting consolidates expenses under a cost center, required for finances program cost roll‑up reports.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: PROGRAM TARGETING: Technology program focuses on a product family; needed for budgeting, KPI tracking, and strategic alignment.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Program budgeting reports tie each program to the sponsoring org unit for financial governance.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary research program director employee record within the research program research entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Program financial performance is tracked via a profit center to allocate licensing and product revenue.',
    `research_director_employee_id` BIGINT COMMENT 'Employee identifier for the program director, linking to HR systems for organizational reporting.',
    `actual_completion_date` DATE COMMENT 'Actual date when the program was completed or terminated. Null if program is still active.',
    `actual_start_date` DATE COMMENT 'Actual date when the program commenced execution. Null if program has not yet started.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for budget amounts (typically USD for semiconductor R&D programs).. Valid values are `^[A-Z]{3}$`',
    `budget_envelope_amount` DECIMAL(18,2) COMMENT 'Total approved budget allocation for the program across all fiscal years, in USD. Includes NRE, capital equipment, materials, and labor costs.',
    `charter_description` STRING COMMENT 'Detailed charter describing program scope, deliverables, success criteria, and boundaries. Defines what is in-scope and out-of-scope for the program.',
    `chips_act_award_number` STRING COMMENT 'Official award or grant number assigned by the US Department of Commerce for CHIPS Act funded programs. Null if not a CHIPS Act program.. Valid values are `^CHIPS-[A-Z0-9]{8,16}$`',
    `chips_act_program_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) whether this program is funded or governed under the US CHIPS and Science Act, requiring specific compliance reporting.',
    `collaboration_partners` STRING COMMENT 'Comma-separated list of external research institutions, universities, consortia, or industry partners collaborating on this program (e.g., MIT, IMEC, Stanford University).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this program record was first created in the system.',
    `current_phase` STRING COMMENT 'Current execution phase of the program: concept (initial research), feasibility (proof of concept), development (engineering), integration (system-level), qualification (reliability testing), production_ramp (volume manufacturing readiness), closed (program complete). [ENUM-REF-CANDIDATE: concept|feasibility|development|integration|qualification|production_ramp|closed — 7 candidates stripped; promote to reference product]',
    `experimental_wafer_lot_count` STRING COMMENT 'Total number of experimental wafer lots processed for this program across all process splits and iterations.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) classification code (ECCN) or ITAR category for technologies developed in this program. Null if not export-controlled.',
    `gate_review_stage` STRING COMMENT 'Current stage-gate review checkpoint: gate_0 (concept approval), gate_1 (feasibility), gate_2 (development authorization), gate_3 (integration readiness), gate_4 (qualification approval), gate_5 (production release), post_program_review (lessons learned). [ENUM-REF-CANDIDATE: gate_0|gate_1|gate_2|gate_3|gate_4|gate_5|post_program_review — 7 candidates stripped; promote to reference product]',
    `ip_filing_count` STRING COMMENT 'Total number of patent applications filed as a result of this R&D program. Key metric for innovation output.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) whether this program involves ITAR-controlled defense articles or technical data requiring export control compliance.',
    `key_performance_indicators` STRING COMMENT 'Comma-separated list of quantitative success metrics for the program (e.g., PPA improvement: 30% power reduction, 20% area reduction, Yield target: >85% at qualification).',
    `last_gate_review_date` DATE COMMENT 'Date of the most recent formal gate review conducted for this program.',
    `last_gate_review_outcome` STRING COMMENT 'Decision outcome from the most recent gate review: approved (proceed to next phase), conditional_approval (proceed with conditions), deferred (additional work required), rejected (program termination recommended).. Valid values are `approved|conditional_approval|deferred|rejected`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this program record was last updated.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the research program record in the research domain.',
    `next_gate_review_date` DATE COMMENT 'Scheduled date for the next formal gate review. Null if program is completed or no review scheduled.',
    `notes` STRING COMMENT 'Free-text field for additional context, lessons learned, or special considerations not captured in structured fields.',
    `planned_completion_date` DATE COMMENT 'Target date for program completion and achievement of all strategic objectives.',
    `planned_start_date` DATE COMMENT 'Planned date when the program is scheduled to begin execution (charter approval and resource allocation).',
    `priority_rank` STRING COMMENT 'Relative priority ranking of this program within the R&D portfolio (1=highest priority). Used for resource allocation and executive attention.',
    `program_code` STRING COMMENT 'Externally-known unique business identifier for the R&D program, used in roadmaps, budgets, and executive reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `program_name` STRING COMMENT 'Full descriptive name of the R&D program (e.g., 2nm Gate-All-Around Technology Development, 1.4nm CFET Process Node Program).',
    `program_status` STRING COMMENT 'Current lifecycle status of the R&D program: planning (charter development), active (execution underway), on_hold (temporarily suspended), completed (objectives achieved), cancelled (terminated before completion), archived (historical record).. Valid values are `planning|active|on_hold|completed|cancelled|archived`',
    `program_type` STRING COMMENT 'Classification of the R&D program by technology domain: process node development (e.g., 2nm, 1.4nm), device architecture (FinFET, GAA, CFET), advanced packaging (CoWoS, InFO), materials research, IP core development, or design methodology.. Valid values are `process_node_development|device_architecture|advanced_packaging|materials_research|ip_core_development|design_methodology`',
    `research_program_status` STRING COMMENT 'The status of the research program record in the research domain.',
    `risk_level` STRING COMMENT 'Overall program risk assessment based on technical complexity, schedule pressure, resource constraints, and external dependencies: low (routine execution), medium (manageable challenges), high (significant obstacles), critical (jeopardy to success).. Valid values are `low|medium|high|critical`',
    `sponsoring_business_unit` STRING COMMENT 'Name of the business unit or division sponsoring and funding the R&D program (e.g., Advanced Logic Technology, Foundry Services, Memory Solutions).',
    `strategic_objective` STRING COMMENT 'High-level strategic goal and business rationale for the program (e.g., Enable 30% power reduction for mobile SoC applications, Achieve 2x density improvement for AI accelerators).',
    `tapeout_milestone_count` STRING COMMENT 'Number of design tapeouts (GDSII submissions for mask fabrication) completed within this program for test chips, proof-of-concept designs, or qualification vehicles.',
    `target_application_domain` STRING COMMENT 'Primary market or application domain this technology targets (e.g., Mobile SoC, High-Performance Computing, AI/ML Accelerators, Automotive, IoT Edge Devices).',
    `technical_lead_name` STRING COMMENT 'Full name of the principal engineer or scientist responsible for technical execution and engineering decisions.',
    `technology_generation_target` STRING COMMENT 'Target technology node or generation for this program (e.g., 2nm, 1.4nm, N3, N2). For non-node programs, describes the technology generation (e.g., Gen 5 CoWoS, 3rd Gen GAA).',
    `technology_platform` STRING COMMENT 'Underlying technology platform or architecture family this program targets (e.g., FinFET, GAA Nanosheet, CFET, FDSOI, Hybrid Bonding).',
    `technology_readiness_level` STRING COMMENT 'Current TRL score (1-9) indicating maturity: 1=basic principles, 3=proof of concept, 5=validation in relevant environment, 7=prototype demonstration, 9=actual system proven in production. Aligned with NASA/DOD TRL framework.',
    CONSTRAINT pk_research_program PRIMARY KEY(`research_program_id`)
) COMMENT 'Master record for R&D programs representing major multi-year technology development initiatives such as next-generation process node development (e.g., 2nm GAA, 1.4nm CFET), advanced packaging platforms, or novel device architecture programs. Captures program charter, technology generation target, strategic objectives, budget envelope, timeline with detailed milestone tracking (milestone name, type, planned/actual dates, completion criteria, gate review outcomes, action items, approving authority), milestone types (technical gates, management reviews, customer demos, tapeout milestones, silicon return, qualification gates), sponsoring business unit, program director, technology readiness level (TRL), and program lifecycle status. SSOT for all R&D program identity, governance, milestone, and gate review data. Supports technology roadmap execution tracking and CHIPS Act program reporting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: CHIPS Act funding ties obligations (domestic production, workforce training) directly to funded research projects for reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project cost accounting requires linking each R&D project to its primary cost center for budgeting and expense reporting.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export Control process requires each research project using controlled technology to be linked to its approved export license for audit and reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: PROJECT PRODUCT FOCUS: Research project develops a primary product; essential for milestone reporting and cost allocation.',
    `employee_id` BIGINT COMMENT 'User identifier or username of the person who last modified the research project record, for audit trail purposes.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Project profitability analysis assigns each R&D project to a profit center for revenue attribution and performance reporting.',
    `research_program_id` BIGINT COMMENT 'FK to research.program.program_id — Every research project is executed under an R&D program. This is the fundamental hierarchical relationship in R&D portfolio management — without it, you cannot roll up project status to program level ',
    `tertiary_project_principal_investigator_employee_id` BIGINT COMMENT 'Employee identifier of the principal investigator responsible for the research project, linking to Workday Human Capital Management (HCM) system.',
    `actual_completion_date` DATE COMMENT 'The actual completion date associated with the project research record.',
    `actual_end_date` DATE COMMENT 'Actual completion date when the research project was closed or terminated, in yyyy-MM-dd format. Null if project is still active.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the project record in the research domain.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the project budget (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `project_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the research project for tracking and reference across Product Lifecycle Management (PLM) systems including Siemens Teamcenter and Oracle Agile PLM.. Valid values are `^[A-Z0-9]{6,20}$`',
    `collaboration_partner_name` STRING COMMENT 'Name of the external organization, university, or consortium partner collaborating on the research project, if applicable.',
    `collaboration_type` STRING COMMENT 'Nature of collaboration for the research project: internal (within company), university partnership, industry consortium, government-funded program, or Original Equipment Manufacturer (OEM) partner collaboration.. Valid values are `internal|university|consortium|government|oem_partner`',
    `confidentiality_level` STRING COMMENT 'Data confidentiality classification level for the research project information: public (no restrictions), internal (company-only), confidential (restricted access), or highly confidential (executive/need-to-know only).. Valid values are `public|internal|confidential|highly_confidential`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the research project record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `device_architecture_focus` STRING COMMENT 'Primary device architecture or transistor technology being researched, such as FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), CFET (Complementary FET), or other novel structures.',
    `experimental_wafer_lot_count` STRING COMMENT 'Total number of experimental wafer lots processed as part of this research project for proof-of-concept or feasibility testing.',
    `export_control_classification` STRING COMMENT 'Export control classification code or designation for the research project under International Traffic in Arms Regulations (ITAR) or Export Administration Regulations (EAR), if applicable.',
    `funding_source` STRING COMMENT 'Primary source of funding for the research project: internal Research and Development (R&D) budget, government grant (e.g., CHIPS Act), industry consortium funding, customer Non-Recurring Engineering (NRE) investment, or venture capital.. Valid values are `internal_r_and_d|government_grant|consortium|customer_nre|venture_capital`',
    `ip_filing_count` STRING COMMENT 'Number of patent or Intellectual Property (IP) applications filed as a result of this research project.',
    `ip_filing_planned` BOOLEAN COMMENT 'Boolean flag indicating whether patent or Intellectual Property (IP) filing is planned as an outcome of this research project.',
    `itar_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether the research project involves technology or data subject to International Traffic in Arms Regulations (ITAR) export controls.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the research project record was last updated or modified, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the project record in the research domain.',
    `mpw_shuttle_participation` BOOLEAN COMMENT 'Boolean flag indicating whether this research project participated in a Multi-Project Wafer (MPW) shuttle run to share fabrication costs with other projects.',
    `project_name` STRING COMMENT 'Human-readable name or title of the research and development project, describing the focus area or objective.',
    `notes` STRING COMMENT 'The notes of the project record in the research domain.',
    `nre_budget_allocated` DECIMAL(18,2) COMMENT 'Total Non-Recurring Engineering (NRE) budget amount allocated to the research project in US dollars, covering design, prototyping, tooling, and development costs.',
    `nre_budget_spent` DECIMAL(18,2) COMMENT 'Cumulative Non-Recurring Engineering (NRE) budget amount spent to date on the research project in US dollars.',
    `phase` STRING COMMENT 'Current lifecycle phase of the research project: exploratory (initial concept), feasibility (viability assessment), development (active R&D), qualification (validation and testing), or closed (completed or terminated).. Valid values are `exploratory|feasibility|development|qualification|closed`',
    `planned_completion_date` DATE COMMENT 'The planned completion date associated with the project research record.',
    `planned_end_date` DATE COMMENT 'Originally planned or target completion date for the research project, in yyyy-MM-dd format.',
    `planned_start_date` DATE COMMENT 'The planned start date associated with the project research record.',
    `plm_system_reference` STRING COMMENT 'External reference identifier or link to the corresponding project record in Product Lifecycle Management (PLM) systems such as Siemens Teamcenter or Oracle Agile PLM.',
    `project_status` STRING COMMENT 'Current operational status of the research project indicating whether it is actively progressing, temporarily on hold, successfully completed, cancelled, or awaiting management approval to proceed.. Valid values are `active|on_hold|completed|cancelled|pending_approval`',
    `project_type` STRING COMMENT 'Classification of the research project by its primary objective: proof-of-concept (PoC) demonstration, feasibility study, process integration experiment, materials research, Intellectual Property (IP) development initiative, or novel device architecture exploration.. Valid values are `proof_of_concept|feasibility_study|process_integration|materials_research|ip_development|device_architecture`',
    `research_domain` STRING COMMENT 'Primary technical domain or area of focus for the research project: next-generation process node development, novel device architecture, advanced packaging technologies, materials research, Intellectual Property (IP) core development, lithography techniques, or interconnect technologies. [ENUM-REF-CANDIDATE: process_node|device_architecture|advanced_packaging|materials|ip_core|lithography|interconnect — 7 candidates stripped; promote to reference product]',
    `risk_level` STRING COMMENT 'Overall risk assessment level for the research project based on technical complexity, resource requirements, and probability of success: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed textual description of the research project scope, objectives, technical goals, and expected deliverables.',
    `start_date` DATE COMMENT 'Official start date when the research project was initiated and work began, in yyyy-MM-dd format.',
    `strategic_priority` STRING COMMENT 'Strategic importance and priority level assigned to the research project by executive management: critical (top priority), high, medium, or low.. Valid values are `critical|high|medium|low`',
    `technical_objectives` STRING COMMENT 'Specific technical objectives and success criteria for the research project, including performance targets, yield goals, or proof-of-concept milestones.',
    `technology_node_target` STRING COMMENT 'Target process technology node for the research project, expressed in nanometers (e.g., 3nm, 2nm, 1.4nm) or next-generation architecture designation (e.g., Gate-All-Around (GAA), Complementary FET (CFET)).',
    `technology_readiness_level` STRING COMMENT 'Technology Readiness Level (TRL) assessment of the research project outcome, ranging from TRL1 (basic principles observed) to TRL9 (actual system proven in operational environment), following NASA/DoD TRL framework. [ENUM-REF-CANDIDATE: TRL1|TRL2|TRL3|TRL4|TRL5|TRL6|TRL7|TRL8|TRL9 — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Individual research and development project records within an R&D program. Represents discrete proof-of-concept (PoC) projects, feasibility studies, process integration experiments, materials research efforts, and IP development initiatives. Tracks project scope, objectives, assigned principal investigator, start/end dates, project phase (exploratory, feasibility, development, qualification), funding source, NRE budget allocation, collaboration type (internal, university, consortium), and current project status. Supports PLM integration with Siemens Teamcenter and Oracle Agile PLM.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` (
    `research_technology_node_id` BIGINT COMMENT 'Unique identifier for the semiconductor process technology node record.',
    `fab_site_id` BIGINT COMMENT 'FK to fabrication.fab_site',
    `process_technology_node_id` BIGINT COMMENT 'Cross-domain SSOT reference to authoritative owner process.process_technology_node.process_technology_node_id',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: TECH NODE ALIGNMENT: Research node is mapped to a manufacturing process node for technology road‑mapping and capacity planning.',
    `research_program_id` BIGINT COMMENT 'FK to research.research_program',
    `technology_roadmap_id` BIGINT COMMENT 'Foreign key linking to research.technology_roadmap. Business justification: A research technology node is defined within a technology roadmap; linking provides hierarchy and eliminates redundant roadmap attributes in the node table.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this technology node record is currently active and available for use in design and manufacturing systems. False indicates archived or obsolete status.',
    `authoritative_fabrication_technology_node_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `collaboration_partners` STRING COMMENT 'Names of external research institutions, universities, consortia, or industry partners collaborating on the development of this technology node (e.g., IMEC, SEMATECH, university research labs).',
    `cost_per_wafer_usd` DECIMAL(18,2) COMMENT 'Estimated or actual manufacturing cost per wafer for this technology node, measured in US dollars. Used for economic analysis and pricing decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was first created in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `design_rule_manual_version` STRING COMMENT 'Version identifier of the design rule manual (DRM) document that specifies layout constraints, spacing rules, and design-for-manufacturability (DFM) guidelines for this technology node.',
    `device_architecture_type` STRING COMMENT 'The transistor architecture employed at this technology node. Planar for older nodes, FinFET (Fin Field-Effect Transistor) for 22nm-7nm, GAA (Gate-All-Around) for 3nm and below, CFET (Complementary FET) for future nodes. [ENUM-REF-CANDIDATE: planar|FinFET|GAA|CFET|nanowire|nanosheet|other — 7 candidates stripped; promote to reference product]',
    `environmental_compliance_status` STRING COMMENT 'Compliance status of this technology node with environmental regulations including RoHS (Restriction of Hazardous Substances), REACH (Registration, Evaluation, Authorization and Restriction of Chemicals), and other environmental standards.. Valid values are `compliant|non_compliant|under_review|not_applicable`',
    `eol_announcement_date` DATE COMMENT 'Date when the technology node was officially announced as end-of-life, indicating phase-out of new design starts and eventual manufacturing discontinuation.',
    `export_control_classification` STRING COMMENT 'Export control classification for this technology node under ITAR (International Traffic in Arms Regulations), EAR (Export Administration Regulations), or other trade control regimes. Determines export licensing requirements.',
    `fabrication_technology_node_id` BIGINT COMMENT 'SSOT reference to authoritative owner fabrication.fabrication_technology_node for concept technology_node',
    `first_tapeout_date` DATE COMMENT 'Date of the first design tapeout (final design submission for manufacturing) using this technology node. Marks transition from development to production readiness.',
    `foundry_name` STRING COMMENT 'Name of the semiconductor foundry or fabrication facility that developed or manufactures this technology node (e.g., TSMC, Samsung, Intel, GlobalFoundries).',
    `gate_pitch_nm` DECIMAL(18,2) COMMENT 'Distance between adjacent transistor gates, measured in nanometers. Critical dimension for density and performance characterization.',
    `ip_filing_count` STRING COMMENT 'Number of patent applications or IP disclosures filed related to innovations developed for this technology node. Tracks innovation output.',
    `irds_roadmap_alignment` STRING COMMENT 'Reference to the corresponding IRDS (formerly ITRS) roadmap generation or year that this technology node aligns with. Used for industry benchmarking and planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was last updated or modified, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lithography_generation` STRING COMMENT 'Primary lithography technology used for patterning at this node. DUV (Deep Ultraviolet) for 28nm and above, EUV (Extreme Ultraviolet) for 7nm and below, hybrid for transitional nodes.. Valid values are `DUV|EUV|hybrid|next_gen`',
    `mask_count` STRING COMMENT 'Total number of photomask layers required to manufacture a complete wafer at this technology node. Increases with node complexity and multi-patterning requirements.',
    `maturity_status` STRING COMMENT 'The maturity status of the research technology node record in the research domain.',
    `metal_layer_count` STRING COMMENT 'Number of metal interconnect layers available in the BEOL (Back End of Line) stack for this technology node. Typically ranges from 6 to 15+ layers for advanced nodes.',
    `metal_pitch_nm` DECIMAL(18,2) COMMENT 'Minimum spacing between metal interconnect lines in the first metal layer, measured in nanometers. Defines routing density.',
    `minimum_feature_size_nm` DECIMAL(18,2) COMMENT 'The smallest feature dimension that can be reliably manufactured at this technology node, measured in nanometers. Critical metric for node classification.',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `multi_patterning_technique` STRING COMMENT 'Advanced lithography technique used to achieve sub-wavelength patterning (e.g., LELE - Litho-Etch-Litho-Etch, SADP - Self-Aligned Double Patterning, SAQP - Self-Aligned Quadruple Patterning). Required for nodes below 20nm with DUV lithography.',
    `node_code` STRING COMMENT 'Standardized alphanumeric code for the technology node used across design, fabrication, and research systems (e.g., N7, N5, N3, N2).',
    `node_generation` STRING COMMENT 'The node generation of the research technology node record in the research domain.',
    `node_maturity_status` STRING COMMENT 'Current lifecycle stage of the technology node. Research: early exploration; Development: process definition; Pilot: qualification runs; Production: volume manufacturing; Mature: stable high-volume; EOL (End of Life): phase-out.. Valid values are `research|development|pilot|production|mature|EOL`',
    `node_name` STRING COMMENT 'Human-readable name of the process technology node (e.g., 28nm, 16nm FinFET, 7nm EUV, 5nm, 3nm GAA, 2nm CFET). This is the primary business identifier for the node.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about this technology node, including special characteristics, limitations, or historical information.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'Total non-recurring engineering cost invested in developing this technology node, including R&D, tooling, mask sets, and qualification. Measured in US dollars.',
    `pdk_version` STRING COMMENT 'Version identifier of the PDK (Process Design Kit) associated with this technology node. PDK contains design rules, device models, and libraries required for IC design.',
    `process_flow_complexity_score` STRING COMMENT 'Numerical score representing the manufacturing complexity of this technology node based on number of process steps, critical layers, and advanced techniques required. Higher scores indicate greater complexity.',
    `production_qualification_date` DATE COMMENT 'Date when this technology node achieved production qualification status, meaning it met all yield, reliability, and performance targets for volume manufacturing.',
    `reliability_qualification_status` STRING COMMENT 'Status of reliability testing and qualification for this technology node, including stress tests, accelerated life testing, and failure analysis. Qualified status indicates the node meets long-term reliability requirements.. Valid values are `not_started|in_progress|qualified|failed`',
    `research_technology_node_status` STRING COMMENT 'The status of the research technology node record in the research domain.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the technology_node concept (fabrication.fabrication_technology_node)',
    `supply_voltage_v` DECIMAL(18,2) COMMENT 'Nominal core supply voltage for digital logic at this technology node, measured in volts. Decreases with node scaling to reduce power consumption.',
    `target_area_scaling_factor` DECIMAL(18,2) COMMENT 'Expected die area reduction factor compared to the previous technology node generation (e.g., 0.5 represents 50% area reduction). Part of PPA (Power-Performance-Area) characterization.',
    `target_performance_metric_ghz` DECIMAL(18,2) COMMENT 'Target maximum operating frequency for standard cells at this technology node, measured in gigahertz. Part of PPA (Power-Performance-Area) characterization.',
    `target_power_metric_mw_per_mhz` DECIMAL(18,2) COMMENT 'Target power consumption metric for this technology node, measured in milliwatts per megahertz. Part of PPA (Power-Performance-Area) characterization.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target manufacturing yield (percentage of good dies per wafer) for production-qualified wafers at this technology node. Typically 70-95% for mature nodes.',
    `technology_readiness_level` STRING COMMENT 'The technology readiness level of the research technology node record in the research domain.',
    `transistor_architecture` STRING COMMENT 'The transistor architecture of the research technology node record in the research domain.',
    `transistor_density_mtransistors_per_mm2` DECIMAL(18,2) COMMENT 'Number of transistors that can be integrated per square millimeter of silicon at this technology node, measured in millions. Key metric for node capability.',
    `wafer_size_mm` STRING COMMENT 'Diameter of silicon wafers used for this technology node, measured in millimeters. Standard sizes are 200mm (8-inch) or 300mm (12-inch). Advanced nodes typically use 300mm.',
    CONSTRAINT pk_research_technology_node PRIMARY KEY(`research_technology_node_id`)
) COMMENT 'Reference master for semiconductor process technology nodes and generations (e.g., 28nm, 16nm FinFET, 7nm EUV, 3nm GAA, 2nm CFET). Captures node name, lithography generation (DUV/EUV), device architecture type (planar, FinFET, GAA, CFET), minimum feature size, target PPA (Power-Performance-Area) metrics, process design kit (PDK) version, foundry/fab association, node maturity status (research, development, production, EOL), and ITRS/IRDS roadmap alignment. SSOT for technology node classification used across design, fabrication, and research domains.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` (
    `technology_roadmap_id` BIGINT COMMENT 'Unique identifier for the technology roadmap record. Primary key.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the technology roadmap research entity.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Roadmap planning defines target package types; FK provides traceability from roadmap to the definitive package definition.',
    `process_technology_node_id` BIGINT COMMENT 'add column process_technology_node_id (BIGINT) with FK to process.process_technology_node.process_technology_node_id - roadmaps reference technology nodes',
    `research_program_id` BIGINT COMMENT 'Unique identifier for the research program record within the technology roadmap research entity.',
    `research_technology_node_id` BIGINT COMMENT 'FK to research.research_technology_node.research_technology_node_id — Technology roadmaps reference target technology nodes for each milestone. Essential for roadmap-to-execution traceability.',
    `approval_date` DATE COMMENT 'Date when the technology roadmap was formally approved by executive leadership or steering committee.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or committee that approved this technology roadmap.',
    `area_improvement_target_percent` DECIMAL(18,2) COMMENT 'Target die area reduction percentage or transistor density improvement compared to previous generation, part of PPA (Power Performance Area) metrics.',
    `benchmark_confidence_level` STRING COMMENT 'Confidence level in the accuracy and reliability of the competitive benchmark data.. Valid values are `high|medium|low|estimated`',
    `benchmark_date` DATE COMMENT 'Date when the competitive benchmark data was collected or published.',
    `benchmark_methodology` STRING COMMENT 'Detailed description of the methodology used to collect and analyze competitive benchmark data.',
    `chips_act_compliance_flag` BOOLEAN COMMENT 'Indicates whether this roadmap is aligned with CHIPS and Science Act compliance reporting requirements for federal funding eligibility.',
    `competitive_benchmark_source` STRING COMMENT 'Source type of competitive benchmarking data used for strategic positioning analysis.. Valid values are `public_disclosure|teardown_analysis|published_paper|industry_report|conference_presentation|patent_filing`',
    `competitor_drive_current` DECIMAL(18,2) COMMENT 'Benchmarked competitor transistor drive current in microamperes per micrometer (µA/µm), indicating performance capability.',
    `competitor_frequency_ghz` DECIMAL(18,2) COMMENT 'Benchmarked competitor maximum operating frequency in gigahertz (GHz).',
    `competitor_leakage_current` DECIMAL(18,2) COMMENT 'Benchmarked competitor transistor leakage current in nanoamperes per micrometer (nA/µm), indicating power efficiency.',
    `competitor_name` STRING COMMENT 'Name of competitor or foundry being benchmarked for comparative technology performance analysis.',
    `competitor_power_consumption` DECIMAL(18,2) COMMENT 'Benchmarked competitor power consumption in watts (W) or milliwatts per megahertz (mW/MHz).',
    `competitor_transistor_density` DECIMAL(18,2) COMMENT 'Benchmarked competitor transistor density in millions of transistors per square millimeter (MTr/mm²).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology roadmap record was first created in the system.',
    `device_architecture_type` STRING COMMENT 'Target device architecture technology (e.g., FinFET, GAA (Gate All Around), CFET (Complementary FET), Nanosheet, Nanowire). Nullable for non-architecture-specific roadmaps.',
    `estimated_nre_cost` DECIMAL(18,2) COMMENT 'Estimated total non-recurring engineering cost in USD required to achieve roadmap milestones.',
    `horizon_end_year` STRING COMMENT 'The horizon end year of the technology roadmap record in the research domain.',
    `horizon_start_year` STRING COMMENT 'The horizon start year of the technology roadmap record in the research domain.',
    `investment_priority_level` STRING COMMENT 'Priority level for capital and R&D investment allocation to support this roadmap execution.. Valid values are `critical|high|medium|low|deferred`',
    `key_enabling_technologies` STRING COMMENT 'Comma-separated list of critical enabling technologies required for roadmap execution (e.g., EUV (Extreme Ultraviolet Lithography), High-NA EUV, ALD (Atomic Layer Deposition), Selective Etch).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology roadmap record was last modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent executive review or update of this technology roadmap.',
    `milestone_description` STRING COMMENT 'Detailed description of key technology milestones and deliverables planned within this roadmap.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the technology roadmap record in the research domain.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next executive review or update cycle of this technology roadmap.',
    `notes` STRING COMMENT 'The notes of the technology roadmap record in the research domain.',
    `performance_improvement_target_percent` DECIMAL(18,2) COMMENT 'Target performance improvement percentage (frequency, speed) compared to previous generation, part of PPA (Power Performance Area) metrics.',
    `planning_horizon_end_date` DATE COMMENT 'End date of the multi-year planning horizon covered by this roadmap.',
    `planning_horizon_start_date` DATE COMMENT 'Start date of the multi-year planning horizon covered by this roadmap.',
    `power_improvement_target_percent` DECIMAL(18,2) COMMENT 'Target power consumption reduction percentage compared to previous generation, part of PPA (Power Performance Area) metrics.',
    `risk_assessment_summary` STRING COMMENT 'Summary of key technical, market, and execution risks identified for this technology roadmap.',
    `roadmap_name` STRING COMMENT 'Descriptive name of the technology roadmap (e.g., Advanced Node Progression 2024-2030, GAA Transition Roadmap).',
    `roadmap_references_nodes` BIGINT COMMENT 'FK to research.technology_node.technology_node_id — Technology roadmaps plan the progression through technology nodes. Each roadmap milestone references target nodes for introduction.',
    `roadmap_status` STRING COMMENT 'Current lifecycle status of the technology roadmap.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `roadmap_targets_node` BIGINT COMMENT 'FK to research.technology_node.technology_node_id — Technology roadmaps plan the progression through technology nodes. Essential for strategic planning alignment.',
    `roadmap_version` STRING COMMENT 'Version identifier for the technology roadmap, following semantic versioning convention (e.g., 1.0, 2.1, 3.0.1).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `strategic_implication_assessment` STRING COMMENT 'Executive assessment of strategic implications from competitive benchmarking, including positioning recommendations and investment priorities.',
    `target_introduction_date` DATE COMMENT 'Planned date for technology introduction to production or market availability.',
    `target_process_node` STRING COMMENT 'Target semiconductor process node for this roadmap generation (e.g., 3nm, 2nm, 1.4nm, A14). Nullable for non-node-specific roadmaps.',
    `technology_focus_area` STRING COMMENT 'Primary technology domain focus of this roadmap (e.g., process node progression, device architecture evolution, advanced packaging capability).. Valid values are `process_node|device_architecture|advanced_packaging|materials|ip_core|integration`',
    `technology_roadmap_status` STRING COMMENT 'The status of the technology roadmap record in the research domain.',
    `transistor_density_target` DECIMAL(18,2) COMMENT 'Target transistor density in millions of transistors per square millimeter (MTr/mm²) for this technology generation.',
    CONSTRAINT pk_technology_roadmap PRIMARY KEY(`technology_roadmap_id`)
) COMMENT 'Technology roadmap records defining the multi-year strategic plan for process node progression, device architecture evolution, and advanced packaging capability development. Captures roadmap version, planning horizon, technology milestones, target introduction dates, PPA improvement targets per node generation, key enabling technologies, and roadmap approval status. Includes integrated competitive benchmarking: competitor/foundry performance comparisons (transistor density, drive current, leakage, frequency, power), benchmark sources (public disclosure, teardown analysis, published papers, industry reports), benchmark methodology, confidence levels, benchmark dates, and strategic implication assessments. Supports executive technology strategy, competitive positioning, investment prioritization, and CHIPS Act compliance reporting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` (
    `experimental_lot_id` BIGINT COMMENT 'Unique identifier for the experimental wafer lot. Primary key for research and development lot tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Experimental lot expenses are charged to a cost center to enable detailed R&D cost tracking in finance.',
    `project_id` BIGINT COMMENT 'Unique identifier for the experimental project record within the experimental lot research entity.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Reference to the non-standard, research-grade process flow recipe defining the sequence of fabrication steps for this lot. Distinct from production process flows due to exploratory parameters and novel techniques.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: PROTOTYPE TRACKING: Experimental lot is fabricated for a specific product; needed for yield and performance reporting.',
    `org_unit_id` BIGINT COMMENT 'Reference to the research team or organizational unit conducting this experiment. Links to workforce management and resource allocation systems.',
    `primary_experimental_project_id` BIGINT COMMENT 'FK to research.project.project_id — Experimental lots are created to execute specific research projects. This FK is essential for tracing which lots belong to which project, enabling project-level cost tracking and outcome assessment.',
    `research_technology_node_id` BIGINT COMMENT 'Unique identifier for the research technology node record within the experimental lot research entity.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Material Procurement Process assigns a supplier to each experimental wafer lot; experts track supplier_id on experimental_lot for sourcing traceability.',
    `actual_completion_date` DATE COMMENT 'Actual date when all fabrication and testing activities for this experimental lot were completed. Null if lot is still in process.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual total cost in US Dollars incurred for processing this experimental lot, captured after completion. Business-confidential financial data.',
    `actual_start_date` DATE COMMENT 'Actual date when this experimental lot began fabrication processing. Captured from MES system when lot is released to the fab floor.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Measured yield percentage achieved after lot completion and testing. Calculated as the ratio of good dies to total dies, expressed as a percentage.',
    `collaboration_partner` STRING COMMENT 'Name of external research institution, university, or industry partner collaborating on this experimental lot. Null if internal-only research. Business-confidential due to competitive and IP considerations.',
    `completion_date` DATE COMMENT 'The completion date associated with the experimental lot research record.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this experimental lot record. Audit trail for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this experimental lot record was first created in the system. Audit trail for data lineage and compliance.',
    `data_collection_plan` STRING COMMENT 'Description of the metrology, inspection, and test data collection strategy for this experimental lot. Defines what measurements will be taken, at which process steps, and with what frequency to support research objectives.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in US Dollars for processing this experimental lot, including materials, equipment time, labor, and overhead. Business-confidential financial data.',
    `experimental_lot_status` STRING COMMENT 'The status of the experimental lot record in the research domain.',
    `experimental_outcome_status` STRING COMMENT 'Assessment of the experimental lot results: pending (evaluation not yet complete), successful (met all research objectives), partially successful (met some objectives), failed (did not meet objectives), or inconclusive (results require further investigation).. Valid values are `pending|successful|partially_successful|failed|inconclusive`',
    `export_control_classification` STRING COMMENT 'Export control classification for the technology and data associated with this experimental lot: EAR99 (Export Administration Regulations standard), ECCN (Export Control Classification Number for controlled items), ITAR-controlled (International Traffic in Arms Regulations), or not controlled. Restricted due to national security and compliance requirements.. Valid values are `ear99|eccn|itar_controlled|not_controlled`',
    `fab_line_assignment` STRING COMMENT 'Identifier of the fabrication line or pilot line where this experimental lot is processed. Research lots often use dedicated R&D fab lines or pilot production facilities separate from high-volume manufacturing.',
    `hold_reason` STRING COMMENT 'Description of the reason why this experimental lot is on hold, if applicable. Examples: equipment failure, material shortage, process excursion, awaiting test results, or engineering review. Null if lot is not on hold.',
    `ip_filing_reference` STRING COMMENT 'Reference number or identifier for any patent application, invention disclosure, or IP filing associated with the innovations tested in this experimental lot. Restricted due to pre-publication IP sensitivity.',
    `is_archived` BOOLEAN COMMENT 'Boolean flag indicating whether this experimental lot record has been archived for historical reference. True if archived and no longer actively referenced in operational systems; False if active or recently completed.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this experimental lot record. Audit trail for accountability and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this experimental lot record was last updated. Audit trail for data lineage and change tracking.',
    `lot_number` STRING COMMENT 'Human-readable business identifier for the experimental lot, typically assigned by the Manufacturing Execution System (MES). Used for tracking and referencing in fab operations.. Valid values are `^[A-Z0-9]{8,16}$`',
    `lot_purpose` STRING COMMENT 'The lot purpose of the experimental lot record in the research domain.',
    `lot_status` STRING COMMENT 'Current lifecycle state of the experimental lot: planned (scheduled but not started), released (authorized for fab processing), in-process (actively being processed), on-hold (temporarily suspended), completed (all processing finished), scrapped (terminated due to failure or obsolescence), or archived (historical record). [ENUM-REF-CANDIDATE: planned|released|in_process|on_hold|completed|scrapped|archived — 7 candidates stripped; promote to reference product]',
    `lot_to_project` BIGINT COMMENT 'FK to research.research_project.research_project_id — Every experimental lot is created for a specific research project. This links physical fabrication activity to the project that authorized and funded it.',
    `lot_type` STRING COMMENT 'Classification of the experimental lot purpose: process development for new manufacturing steps, device validation for novel architectures, materials research for new substrates or films, split-lot for comparative studies, design of experiments (DOE) for statistical optimization, or proof-of-concept for feasibility assessment.. Valid values are `process_development|device_validation|materials_research|split_lot|doe_experiment|proof_of_concept`',
    `mes_system_reference` STRING COMMENT 'Reference identifier linking this experimental lot record to the corresponding lot record in the Camstar MES system for wafer tracking and real-time fab operations integration.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the experimental lot record in the research domain.',
    `notes` STRING COMMENT 'The notes of the experimental lot record in the research domain.',
    `planned_completion_date` DATE COMMENT 'Target date for completing all fabrication and testing activities for this experimental lot. Used for project milestone tracking and Time-To-Market (TTM) planning.',
    `planned_start_date` DATE COMMENT 'Scheduled date when this experimental lot is planned to begin fabrication processing. Used for capacity planning and resource allocation.',
    `principal_investigator_name` STRING COMMENT 'Name of the lead researcher or engineer responsible for this experimental lot and its associated research objectives. Business-confidential to protect internal R&D organization structure.',
    `priority_level` STRING COMMENT 'Processing priority assigned to this experimental lot relative to other research and production lots. Critical priority for time-sensitive proof-of-concept or customer commitments; high for strategic roadmap projects; normal for standard R&D; low for exploratory research.. Valid values are `critical|high|normal|low`',
    `research_notes` STRING COMMENT 'Free-text field for capturing detailed research observations, experimental conditions, anomalies, and insights discovered during lot processing. Business-confidential to protect proprietary research findings.',
    `scrap_reason` STRING COMMENT 'Description of the reason why this experimental lot was scrapped, if applicable. Examples: catastrophic process failure, contamination, equipment damage, or project cancellation. Null if lot was not scrapped.',
    `split_condition_description` STRING COMMENT 'Detailed description of split-lot experimental conditions where different wafers within the lot receive different process parameters, materials, or sequences to enable comparative analysis. Null if lot is not split.',
    `split_count` STRING COMMENT 'Number of distinct experimental splits or conditions applied within this lot. Value of 1 indicates uniform processing; values greater than 1 indicate split-lot design.',
    `start_date` DATE COMMENT 'The start date associated with the experimental lot research record.',
    `substrate_type` STRING COMMENT 'Base material type of the wafers in this lot: silicon (standard CMOS), Silicon-On-Insulator (SOI), Gallium Arsenide (GaAs) for RF applications, Gallium Nitride (GaN) for power devices, Silicon Carbide (SiC) for high-temperature applications, sapphire for LED/optoelectronics, glass for display technologies, or other experimental materials. [ENUM-REF-CANDIDATE: silicon|soi|gaas|gan|sic|sapphire|glass|other — 8 candidates stripped; promote to reference product]',
    `target_device_structure` STRING COMMENT 'Description of the novel device architecture or structure being developed in this experimental lot. Examples: FinFET (Fin Field-Effect Transistor), GAA (Gate-All-Around), CFET (Complementary FET), MRAM (Magnetoresistive RAM), or other emerging device types.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Expected or target yield percentage for this experimental lot based on research objectives. May be lower than production yield targets due to exploratory nature of the process.',
    `technology_node_nm` STRING COMMENT 'Target process technology node in nanometers representing the minimum feature size or generation. Examples include 7nm, 5nm, 3nm, 2nm for advanced nodes, or larger nodes for mature process research.',
    `wafer_count` STRING COMMENT 'Total number of wafers included in this experimental lot. Typically smaller than production lots due to research constraints and cost considerations.',
    `wafer_diameter_mm` STRING COMMENT 'Diameter of the wafers in millimeters. Common sizes include 200mm (8-inch) and 300mm (12-inch) for mainstream production, or 150mm (6-inch) for specialized research.',
    CONSTRAINT pk_experimental_lot PRIMARY KEY(`experimental_lot_id`)
) COMMENT 'Experimental wafer lot records created specifically for R&D process development, device architecture validation, and materials research. Distinct from production wafer lots — these are research-grade lots with non-standard process flows, split-lot experimental conditions, and exploratory process parameters. Captures lot ID, associated research project, wafer count, substrate type, experimental process flow ID, split conditions, target device structures, fab line assignment, lot priority, and experimental outcome status. Integrates with Camstar MES for wafer tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` (
    `process_integration_run_id` BIGINT COMMENT 'Unique identifier for the process integration experiment run. Primary key for tracking individual experimental runs through the complete lifecycle from flow definition to results analysis.',
    `experimental_lot_id` BIGINT COMMENT 'FK to research.experimental_lot.experimental_lot_id — Process integration runs are executed on experimental lots. This is the core operational link between the experiment definition and the physical wafers being processed.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Reference to the process flow definition that specifies the complete sequence of FEOL, MOL, and BEOL fabrication steps executed in this integration run.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the target technology node (e.g., 7nm, 5nm, 3nm) for which this process integration experiment is being developed.',
    `pdk_id` BIGINT COMMENT 'Reference to the PDK that this integration run supports or contributes to. Links experimental results to design enablement.',
    `employee_id` BIGINT COMMENT 'Reference to the process integration engineer responsible for designing, executing, and analyzing this experimental run.',
    `primary_process_experimental_lot_id` BIGINT COMMENT 'FK to research.experimental_lot.experimental_lot_id — Process integration runs are executed on experimental lots. This is the core traceability link between process experiments and physical wafers.',
    `process_engineer_employee_id` BIGINT COMMENT 'Unique identifier for the process engineer employee record within the process integration run research entity.',
    `project_id` BIGINT COMMENT 'Unique identifier for the project record within the process integration run research entity.',
    `approval_status` STRING COMMENT 'Approval status of the process integration run results and conclusions by technical leadership or review board.. Valid values are `pending|approved|rejected|revision_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the process integration run results were formally approved.',
    `beol_step_count` STRING COMMENT 'Number of BEOL process steps in the integration flow, covering metal interconnect layers and passivation.',
    `collaboration_partner` STRING COMMENT 'External research institution, university, or industry partner collaborating on this process integration experiment, if applicable.',
    `completion_date` DATE COMMENT 'The completion date associated with the process integration run research record.',
    `contact_resistance_ohm` DECIMAL(18,2) COMMENT 'Measured contact resistance in ohms. Critical for device performance and interconnect reliability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this process integration run record was first created in the system.',
    `device_architecture_type` STRING COMMENT 'Target device architecture being developed in this integration run. FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), CFET (Complementary FET), Planar, Nanowire, or Nanosheet structures.. Valid values are `FinFET|GAA|CFET|Planar|Nanowire|Nanosheet`',
    `doe_design_type` STRING COMMENT 'Statistical experimental design methodology applied to this integration run. Defines the split condition strategy for systematic parameter variation and analysis.. Valid values are `full_factorial|fractional_factorial|taguchi|response_surface|one_factor_at_a_time|custom`',
    `drive_current_ua` DECIMAL(18,2) COMMENT 'Measured on-state drive current in microamperes. Key performance metric for transistor switching speed and circuit performance.',
    `electrical_test_structure_type` STRING COMMENT 'Type of test structures fabricated for electrical characterization (e.g., ring oscillators, SRAM arrays, parametric test structures, scribe line monitors).',
    `electrical_test_timestamp` TIMESTAMP COMMENT 'Date and time when electrical testing was performed on the processed wafers.',
    `experiment_name` STRING COMMENT 'Business-friendly name assigned to this process integration experiment for identification and tracking purposes.',
    `feol_step_count` STRING COMMENT 'Number of FEOL process steps in the integration flow, covering transistor formation from substrate preparation through source/drain formation.',
    `gate_oxide_thickness_nm` DECIMAL(18,2) COMMENT 'Measured or target gate dielectric thickness in nanometers. Critical parameter for device electrostatics and reliability.',
    `ip_filing_reference` STRING COMMENT 'Reference number or identifier for any patent or IP filing associated with innovations discovered in this integration run.',
    `key_findings_summary` STRING COMMENT 'Executive summary of the key technical findings, insights, and learnings from this process integration run.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this process integration run record was most recently updated.',
    `leakage_current_na` DECIMAL(18,2) COMMENT 'Measured off-state leakage current in nanoamperes. Critical for power consumption and device reliability.',
    `learning_cycle_number` STRING COMMENT 'Sequential number indicating which iteration of the learning cycle this run represents for the given process development objective.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the process integration run record in the research domain.',
    `mol_step_count` STRING COMMENT 'Number of MOL process steps in the integration flow, covering contact formation and local interconnect layers.',
    `next_action_recommendation` STRING COMMENT 'Recommended next steps based on the results of this integration run (e.g., proceed to next phase, repeat with modifications, halt development).',
    `notes` STRING COMMENT 'The notes of the process integration run record in the research domain.',
    `pass_fail_determination` STRING COMMENT 'Overall assessment of whether the process integration run met its success criteria based on electrical results and yield targets.. Valid values are `pass|fail|conditional_pass|under_review`',
    `pdk_contribution_flag` BOOLEAN COMMENT 'Indicates whether results from this integration run contributed data to PDK development or updates. True if data was incorporated into PDK.',
    `process_flow_version` STRING COMMENT 'Version identifier of the process flow used in this run, enabling tracking of flow evolution and experiment reproducibility across flow revisions.',
    `process_integration_run_status` STRING COMMENT 'The status of the process integration run record in the research domain.',
    `research_program_name` STRING COMMENT 'Name of the broader research program or technology development initiative that this integration run supports.',
    `run_code` STRING COMMENT 'Coded value representing the run code of the process integration run research record.',
    `run_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the process integration run execution completed (last wafer finished all process steps and electrical testing).',
    `run_date` DATE COMMENT 'The run date associated with the process integration run research record.',
    `run_number` STRING COMMENT 'The run number of the process integration run record in the research domain.',
    `run_objective` STRING COMMENT 'The run objective of the process integration run record in the research domain.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the process integration run execution began (first wafer entered the flow).',
    `run_status` STRING COMMENT 'Current lifecycle status of the process integration run. Tracks progression from planning through execution to completion or termination.. Valid values are `planned|in_progress|completed|failed|on_hold|cancelled`',
    `run_targets_node` BIGINT COMMENT 'FK to research.technology_node.technology_node_id — Process integration experiments target specific technology nodes. This enables filtering and analysis of all experiments for a given node generation.',
    `split_condition_count` STRING COMMENT 'Number of experimental split conditions (parameter variations) included in this DOE design for systematic process learning.',
    `start_date` DATE COMMENT 'The start date associated with the process integration run research record.',
    `subthreshold_slope_mv_per_decade` DECIMAL(18,2) COMMENT 'Measured subthreshold slope in mV/decade. Indicates how sharply the transistor switches between on and off states.',
    `target_device_structure` STRING COMMENT 'Detailed description of the target device structure being fabricated, including layer stack, materials, and critical dimensions.',
    `tcad_correlation_accuracy_percentage` DECIMAL(18,2) COMMENT 'Percentage accuracy of TCAD simulation predictions compared to actual electrical test results. Measures predictive model quality.',
    `tcad_simulation_correlation_flag` BOOLEAN COMMENT 'Indicates whether TCAD simulation data was correlated with experimental results for this run. True if correlation analysis was performed.',
    `threshold_voltage_mv` DECIMAL(18,2) COMMENT 'Measured threshold voltage of the fabricated devices in millivolts. Critical parameter for device performance and power consumption.',
    `wafer_count` STRING COMMENT 'Total number of wafers processed in this integration run across all split conditions.',
    `yield_percent` DECIMAL(18,2) COMMENT 'The yield percent of the process integration run record in the research domain.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of functional devices or test structures that passed electrical specifications. Key metric for process integration success.',
    CONSTRAINT pk_process_integration_run PRIMARY KEY(`process_integration_run_id`)
) COMMENT 'Records of process integration experiments including experimental process flow definition, execution, and results. Captures the complete experiment lifecycle: process flow sequence definition (FEOL/MOL/BEOL steps with per-step parameters and tool types), split conditions for DOE (Design of Experiments) designs, flow versioning and approval, key process parameters, equipment set used, integration engineer, run date, electrical test results, yield outcome, pass/fail determination, and TCAD simulation inputs/correlation data. Includes full experimental flow management: flow version control, step-by-step parameter specification, target device structures, and flow authorship tracking. Supports systematic process development learning cycles, feeds PDK development, and enables correlation between process conditions and device performance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` (
    `device_architecture_id` BIGINT COMMENT 'Unique identifier for the device or packaging architecture under research and development. Primary key for the device architecture catalog.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - device architectures target specific technology nodes',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: ARCHITECTURE DEFINITION: Device architecture is associated with a product family; required for portfolio management and roadmap.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Design review requires each device architecture to reference the selected package type for DFM, reliability, and compliance analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the principal investigator or lead researcher responsible for this architecture development.',
    `project_id` BIGINT COMMENT 'Unique identifier for the project record within the device architecture research entity.',
    `research_program_id` BIGINT COMMENT 'Foreign key reference to the parent research program or project under which this architecture is being developed.',
    `research_technology_node_id` BIGINT COMMENT 'Unique identifier for the research technology node record within the device architecture research entity.',
    `architecture_code` STRING COMMENT 'Unique alphanumeric code or designation assigned to the architecture for internal tracking and reference in research documentation.',
    `architecture_maturity_level` STRING COMMENT 'Technical maturity classification: concept (paper design), simulated (TCAD/EDA validated), fabricated (physical samples exist), characterized (electrical/physical data collected), or qualified (reliability and performance validated for target application).. Valid values are `concept|simulated|fabricated|characterized|qualified`',
    `architecture_name` STRING COMMENT 'Human-readable name of the device or packaging architecture (e.g., 3nm GAA FET, CoWoS-S 2.5D Integration, InFO-AiP).',
    `architecture_status` STRING COMMENT 'Current lifecycle status of the architecture research project: active (ongoing R&D), on hold (paused), cancelled (discontinued), completed (research concluded), or transferred to production (handed off to manufacturing).. Valid values are `active|on_hold|cancelled|completed|transferred_to_production`',
    `architecture_targets_node` BIGINT COMMENT 'FK to research.technology_node.technology_node_id — Device architectures are developed for target technology nodes. Essential for tracking which architectures apply to which process generations.',
    `architecture_type` STRING COMMENT 'Classification of the architecture as either device-level (transistor/gate structures) or packaging-level (chip integration and interconnect).. Valid values are `device|packaging`',
    `associated_experimental_lot_ids` STRING COMMENT 'Comma-separated list of experimental wafer lot IDs or MPW shuttle IDs used to fabricate and test this architecture.',
    `channel_length_nm` DECIMAL(18,2) COMMENT 'For device architectures, the effective channel length of the transistor in nanometers, critical for electrical performance and short-channel effects.',
    `channel_material` STRING COMMENT 'The channel material of the device architecture record in the research domain.',
    `collaboration_partner` STRING COMMENT 'Name of external research institution, university, consortium, or industry partner collaborating on the development of this architecture.',
    `concept_date` DATE COMMENT 'Date when the architecture concept was first proposed or documented in the research pipeline.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this device architecture record was first created in the R&D data system.',
    `development_maturity_stage` STRING COMMENT 'Current stage in the research and development lifecycle: concept (ideation), simulation (modeling), proof-of-concept (lab demonstration), prototype (experimental wafer), pilot (limited production), qualification (reliability testing), or production-ready (transfer to manufacturing). [ENUM-REF-CANDIDATE: concept|simulation|proof_of_concept|prototype|pilot|qualification|production_ready — promote to reference product]',
    `device_architecture_status` STRING COMMENT 'The status of the device architecture record in the research domain.',
    `device_structure_category` STRING COMMENT 'For device architectures, the fundamental transistor or gate structure type: FinFET (Fin Field-Effect Transistor), GAA (Gate-All-Around), CFET (Complementary FET), FDSOI (Fully Depleted Silicon on Insulator), planar, or other novel structures.. Valid values are `FinFET|GAA|CFET|FDSOI|planar|other`',
    `device_type` STRING COMMENT 'The device type of the device architecture record in the research domain.',
    `estimated_time_to_market_months` STRING COMMENT 'Estimated number of months from current maturity stage to production readiness and market introduction, based on R&D project plan.',
    `fabrication_complexity_rating` STRING COMMENT 'Qualitative assessment of the manufacturing complexity and process control requirements: low, medium, high, very high, or extreme, based on number of critical layers, process steps, and yield risk.. Valid values are `low|medium|high|very_high|extreme`',
    `fin_width_nm` DECIMAL(18,2) COMMENT 'For FinFET or GAA device architectures, the width of the fin or nanosheet structure in nanometers.',
    `first_fabrication_date` DATE COMMENT 'Date when the first experimental wafer lot incorporating this architecture was started in the fabrication facility or foundry.',
    `gate_length_nm` DECIMAL(18,2) COMMENT 'The gate length nm of the device architecture record in the research domain.',
    `gate_pitch_nm` DECIMAL(18,2) COMMENT 'For device architectures, the gate pitch (distance between adjacent gates) in nanometers, a key dimensional parameter for transistor density.',
    `integration_approach` STRING COMMENT 'For packaging architectures, the dimensional integration strategy: 2.5D (side-by-side on interposer), 3D (vertical stacking), fan-out (redistribution layer), chiplet (modular die integration), monolithic, or hybrid approaches.. Valid values are `2.5D|3D|fan_out|chiplet|monolithic|hybrid`',
    `interconnect_density_target` STRING COMMENT 'For packaging architectures, the target interconnect density specification (e.g., bump pitch, TSV density, redistribution layer line/space) expressed as a dimensional or density metric.',
    `ip_ownership_status` STRING COMMENT 'Ownership and licensing status of the intellectual property associated with this architecture: proprietary (fully owned), joint (co-developed), licensed (from third party), open (non-proprietary), or pending (patent application in progress).. Valid values are `proprietary|joint|licensed|open|pending`',
    `key_technical_challenges` STRING COMMENT 'Narrative description of the primary technical challenges and risks associated with this architecture, such as process variability, defect density, thermal management, electromigration, or integration yield.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this device architecture record was last updated, reflecting changes to technical parameters, maturity stage, or status.',
    `materials_innovation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this architecture incorporates novel materials research (e.g., high-k dielectrics, 2D materials, new interconnect metals, advanced substrates).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the device architecture record in the research domain.',
    `notes` STRING COMMENT 'The notes of the device architecture record in the research domain.',
    `patent_filing_reference` STRING COMMENT 'Reference number or identifier for associated patent filings or IP disclosures related to this architecture.',
    `power_performance_area_target` STRING COMMENT 'Composite target specification for Power, Performance, and Area trade-offs, expressed as a qualitative or quantitative goal (e.g., 30% power reduction at iso-performance, 2x density improvement).',
    `qualification_completion_date` DATE COMMENT 'Date when the architecture successfully completed reliability qualification testing and was approved for production transfer. Null if not yet qualified.',
    `structural_description` STRING COMMENT 'Detailed technical description of the architectures physical structure, layer composition, material stack, gate configuration, interconnect topology, or integration methodology.',
    `target_application_domains` STRING COMMENT 'Comma-separated list of intended application domains for this architecture (e.g., HPC, AI accelerator, mobile SoC, automotive, IoT, edge computing, data center).',
    `target_technology_node_nm` STRING COMMENT 'The target process technology node in nanometers (e.g., 3, 5, 7, 10) for which this device architecture is being developed. Null for packaging architectures not tied to a specific node.',
    `technology_roadmap_alignment` STRING COMMENT 'Reference to the internal technology roadmap phase or milestone that this architecture supports (e.g., N3 Roadmap, Advanced Packaging Phase 2, Next-Gen AI Platform).',
    `thermal_performance_target_w_cm2` DECIMAL(18,2) COMMENT 'Target thermal dissipation capability or power density handling in watts per square centimeter, critical for high-performance and AI accelerator applications.',
    `transistor_type` STRING COMMENT 'The transistor type of the device architecture record in the research domain.',
    CONSTRAINT pk_device_architecture PRIMARY KEY(`device_architecture_id`)
) COMMENT 'Master catalog of novel device architectures and advanced packaging architectures under research and development. Covers device architectures (FinFET, GAA, CFET, FDSOI) and advanced packaging architectures (CoWoS, InFO, TSV-based 3D-IC, WLCSP, chiplet integration, heterogeneous integration platforms). Captures architecture name, type (device/packaging), structural description, key dimensional/performance parameters, target technology node or application, integration approach (2.5D, 3D, fan-out, chiplet), fabrication complexity rating, thermal performance targets, interconnect density targets, key technical challenges, target application domains (HPC, AI accelerator, mobile, automotive), associated experimental lots, IP ownership, development maturity stage, and architecture maturity level (concept, simulated, fabricated, characterized, qualified). SSOT for all research architecture definitions including both device-level and package-level innovation.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`materials_research` (
    `materials_research_id` BIGINT COMMENT 'Unique identifier for the materials research record.',
    `experimental_lot_id` BIGINT COMMENT 'The lot identifier for experimental wafer runs using this material. Links research records to fabrication test lots for traceability.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - materials research targets specific nodes',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory compliance and PI accountability need a direct employee reference for material research projects.',
    `materials_researcher_employee_id` BIGINT COMMENT 'Unique identifier for the materials researcher employee record within the materials research research entity.',
    `project_id` BIGINT COMMENT 'Unique identifier for the project record within the materials research research entity.',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Materials research uses specific chemicals tracked in substance inventory to satisfy REACH/TSCA compliance and safety reporting.',
    `bandgap_energy_ev` DECIMAL(18,2) COMMENT 'The energy bandgap of the material measured in electron volts (eV). Critical for semiconductor channel materials and determines electrical conductivity characteristics.',
    `breakdown_voltage_mv_cm` DECIMAL(18,2) COMMENT 'The dielectric breakdown field strength measured in MV/cm. Critical reliability metric for gate dielectrics and insulating layers.',
    `characterization_method` STRING COMMENT 'The primary analytical or metrology technique used to characterize the materials properties (e.g., XRD, TEM, XPS, ellipsometry, C-V measurement, Hall effect).',
    `chemical_composition` STRING COMMENT 'The chemical formula or elemental composition of the material (e.g., HfO2, MoS2, GaN, Cu-Co alloy). Includes stoichiometry and doping elements where applicable.',
    `compatibility_assessment` STRING COMMENT 'Assessment of the materials compatibility with existing fabrication process flows (FEOL, MOL, BEOL). Evaluates integration challenges, contamination risks, and thermal budget constraints.. Valid values are `fully_compatible|minor_integration_issues|major_integration_challenges|incompatible|under_evaluation`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this materials research record was first created in the system. Audit trail for data lineage.',
    `deposition_method` STRING COMMENT 'The primary thin-film deposition technique used to apply the material during research (e.g., ALD for Atomic Layer Deposition, CVD for Chemical Vapor Deposition, PVD for Physical Vapor Deposition, MBE for Molecular Beam Epitaxy). [ENUM-REF-CANDIDATE: ald|cvd|pvd|mbe|epitaxy|spin_coating|other — 7 candidates stripped; promote to reference product]',
    `dielectric_constant` DECIMAL(18,2) COMMENT 'The relative permittivity (k-value) of the material, a key electrical property for dielectric materials. High-k materials have k > 10; low-k materials have k < 3.9.',
    `electron_mobility_cm2_vs` DECIMAL(18,2) COMMENT 'The electron mobility of the material measured in cm²/(V·s). Key performance metric for channel materials; higher mobility enables faster transistor switching.',
    `etch_rate_nm_min` DECIMAL(18,2) COMMENT 'The etch rate of the material in a standard etchant or plasma chemistry, measured in nm/min. Important for process integration and patterning compatibility.',
    `film_thickness_nm` DECIMAL(18,2) COMMENT 'The typical or target film thickness of the deposited material measured in nanometers. Critical dimension for device scaling and performance modeling.',
    `last_evaluation_date` DATE COMMENT 'The date of the most recent experimental evaluation or characterization run for this material. Indicates currency of research data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this materials research record was last updated. Audit trail for data currency and change tracking.',
    `material_category` STRING COMMENT 'The material category of the materials research record in the research domain.',
    `material_class` STRING COMMENT 'The broad category of semiconductor material being researched. Classifies materials by their functional role in device structures.. Valid values are `high_k_dielectric|low_k_ild|2d_material|iii_v_compound|advanced_metallization|other`',
    `material_cost_per_gram_usd` DECIMAL(18,2) COMMENT 'The estimated or actual cost of the raw material per gram in USD. Critical for cost-of-ownership analysis and commercialization feasibility.',
    `material_name` STRING COMMENT 'The common or trade name of the novel semiconductor material under investigation (e.g., Hafnium Oxide, Graphene, Gallium Nitride).',
    `materials_research_status` STRING COMMENT 'The status of the materials research record in the research domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the materials research record in the research domain.',
    `notes` STRING COMMENT 'Free-text field for additional observations, experimental notes, integration challenges, or recommendations from the research team. Captures qualitative insights not covered by structured fields.',
    `patent_filing_reference` STRING COMMENT 'Reference number or identifier for any patent applications or IP (Intellectual Property) filings related to this material or its application. Links research to IP portfolio.',
    `process_temperature_c` DECIMAL(18,2) COMMENT 'The deposition or processing temperature required for the material in degrees Celsius. Critical for assessing compatibility with existing thermal budgets in FEOL and BEOL processes.',
    `reach_compliance_status` STRING COMMENT 'Compliance status of the material under EU REACH regulation. Identifies if the material contains Substances of Very High Concern (SVHC) or restricted substances.. Valid values are `compliant|restricted|svhc_candidate|under_review|not_assessed`',
    `research_institution_partner` STRING COMMENT 'The name of any external research institution, university, or consortium collaborating on this material investigation (e.g., IMEC, MIT, Stanford).',
    `research_maturity_stage` STRING COMMENT 'The current stage of research maturity for the material. Tracks progression from initial concept through pilot integration into manufacturing processes.. Valid values are `concept|feasibility|proof_of_concept|optimization|pilot_integration|pre_production`',
    `research_objective` STRING COMMENT 'The research objective of the materials research record in the research domain.',
    `research_project_code` STRING COMMENT 'The internal project code or identifier for the R&D program under which this material is being investigated. Links to broader technology roadmap initiatives.',
    `research_start_date` DATE COMMENT 'The date when research activities for this material officially began. Tracks project timeline and duration.',
    `research_status` STRING COMMENT 'The current operational status of the materials research effort. Tracks whether investigation is ongoing, paused, completed, or discontinued.. Valid values are `active|on_hold|completed|discontinued|transferred`',
    `resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'The electrical resistivity of the material measured in ohm-centimeters. Key property for metallization and interconnect materials; lower values indicate better conductivity.',
    `rohs_compliance_status` STRING COMMENT 'Compliance status of the material under EU RoHS directive. Identifies presence of restricted hazardous substances (lead, mercury, cadmium, hexavalent chromium, etc.).. Valid values are `compliant|non_compliant|exempt|under_review|not_assessed`',
    `safety_classification` STRING COMMENT 'The hazard classification of the material based on GHS (Globally Harmonized System) criteria. Determines handling, storage, and disposal requirements. [ENUM-REF-CANDIDATE: non_hazardous|irritant|corrosive|toxic|highly_toxic|carcinogenic|pyrophoric — 7 candidates stripped; promote to reference product]',
    `stress_mpa` DECIMAL(18,2) COMMENT 'The intrinsic mechanical stress in the deposited film measured in megapascals (MPa). Positive values indicate tensile stress; negative values indicate compressive stress. Critical for wafer warpage and reliability.',
    `supplier_vendor_name` STRING COMMENT 'The name of the external supplier, vendor, or research partner providing the material or precursor chemicals for evaluation.',
    `surface_roughness_nm` DECIMAL(18,2) COMMENT 'The root mean square (RMS) surface roughness of the deposited film measured in nanometers. Smooth surfaces are critical for device performance and reliability.',
    `target_application` STRING COMMENT 'The intended functional application of the material in semiconductor device architecture (e.g., gate dielectric for FinFET, interconnect for BEOL, channel material for transistor). [ENUM-REF-CANDIDATE: gate_dielectric|interconnect|channel|substrate|barrier_layer|etch_stop|other — 7 candidates stripped; promote to reference product]',
    `technology_node_target` STRING COMMENT 'The target process technology node for which this material is being developed (e.g., 3nm, 2nm, 1.4nm, sub-1nm). Aligns material research with roadmap milestones.',
    `test_structure_type` STRING COMMENT 'The type of test structure or device used to evaluate the material (e.g., MOS capacitor, van der Pauw structure, transistor test device, blanket film).',
    `thermal_conductivity_w_mk` DECIMAL(18,2) COMMENT 'The thermal conductivity of the material measured in W/(m·K). Important for heat dissipation in high-performance devices and packaging applications.',
    `tsca_compliance_status` STRING COMMENT 'Compliance status of the material under US TSCA regulation. Identifies if the material is on the TSCA inventory and any use restrictions.. Valid values are `compliant|restricted|requires_notification|under_review|not_assessed`',
    CONSTRAINT pk_materials_research PRIMARY KEY(`materials_research_id`)
) COMMENT 'Research records for novel semiconductor materials under investigation including high-k dielectrics, low-k ILD materials, 2D materials (graphene, MoS2), III-V compound semiconductors, and advanced metallization materials. Captures material name, material class, chemical composition, target application (gate dielectric, interconnect, channel, substrate), key electrical/physical properties measured, deposition method (ALD, CVD, PVD), compatibility assessment with existing process flows, safety/REACH compliance status, and research maturity stage.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` (
    `ip_core_development_id` BIGINT COMMENT 'Unique identifier for the IP core development project record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: IP core development tracks lead architect for design ownership and performance reviews.',
    `ip_lead_employee_id` BIGINT COMMENT 'Unique identifier for the ip lead employee record within the ip core development research entity.',
    `project_id` BIGINT COMMENT 'Unique identifier for the ip project record within the ip core development research entity.',
    `primary_ip_project_id` BIGINT COMMENT 'FK to research.project.project_id — IP core development efforts are organized as research projects. Essential for tracking development lifecycle and resource allocation.',
    `product_ip_core_id` BIGINT COMMENT 'Foreign key linking to product.product_ip_core. Business justification: IP CORE DEVELOPMENT: Effort is linked to a concrete IP core record; essential for licensing, royalty, and integration tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: IP core licensing revenue and cost are booked against a profit center for accurate profit reporting.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: An IP core development effort is owned by a specific R&D program; the FK creates the parent‑child relationship needed for budgeting and reporting.',
    `actual_nre_cost_usd` DECIMAL(18,2) COMMENT 'Actual cumulative non-recurring engineering cost incurred to date for this IP core development, in US dollars.',
    `collaboration_partner` STRING COMMENT 'Name of external research institution, university, or industry partner collaborating on this IP core development, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP core development record was first created in the system.',
    `design_complexity_score` STRING COMMENT 'Quantitative score representing the design complexity of the IP core, based on gate count, number of interfaces, and architectural sophistication (scale 1-10).',
    `design_for_testability_coverage` DECIMAL(18,2) COMMENT 'Percentage of design for testability coverage achieved, indicating the proportion of the design that can be tested using scan chains and ATPG (0.00 to 100.00).',
    `design_specification_version` STRING COMMENT 'Version identifier of the design specification document governing this IP core development (e.g., v1.0, v2.3-draft).',
    `development_stage` STRING COMMENT 'The development stage of the ip core development record in the research domain.',
    `development_status` STRING COMMENT 'Current lifecycle status of the IP core development project: concept, specification, RTL development, verification, silicon validation, production ready, or archived. [ENUM-REF-CANDIDATE: concept|specification|rtl_development|verification|silicon_validation|production_ready|archived — 7 candidates stripped; promote to reference product]',
    `development_team_size` STRING COMMENT 'Number of engineers and designers assigned to this IP core development project.',
    `documentation_completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of required design documentation completed, including specifications, user guides, and integration manuals (0.00 to 100.00).',
    `eda_tool_suite` STRING COMMENT 'Primary EDA tool suite used for this IP core development (e.g., Cadence Virtuoso, Synopsys Design Compiler, Mentor Graphics).',
    `estimated_nre_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total non-recurring engineering cost for developing this IP core, in US dollars. Includes design, verification, and validation expenses.',
    `export_control_classification` STRING COMMENT 'Export control classification code (ECCN or USML category) for the IP core, indicating any restrictions under ITAR or EAR regulations.',
    `first_silicon_target_date` DATE COMMENT 'Planned date for first silicon fabrication and testing of the IP core on a test chip or MPW shuttle.',
    `ip_category` STRING COMMENT 'Functional category of the IP core: processor core, memory controller, PHY interface, analog IP, standard cell library, or other specialized function.. Valid values are `processor_core|memory_controller|phy_interface|analog_ip|standard_cell_library|other`',
    `ip_core_development_status` STRING COMMENT 'The status of the ip core development record in the research domain.',
    `ip_core_name` STRING COMMENT 'The ip core name of the ip core development record in the research domain.',
    `ip_portfolio_classification` STRING COMMENT 'Strategic classification of the IP core within the company portfolio: strategic (core business), commercial (for licensing revenue), experimental (research), or legacy (maintenance mode).. Valid values are `strategic|commercial|experimental|legacy`',
    `ip_type` STRING COMMENT 'Classification of the IP core by implementation type: hard IP (physical layout fixed), soft IP (synthesizable RTL), or firm IP (netlist with some physical constraints).. Valid values are `hard_ip|soft_ip|firm_ip`',
    `last_milestone_achieved` STRING COMMENT 'Description of the most recent development milestone achieved (e.g., RTL freeze, verification signoff, tapeout).',
    `last_milestone_date` DATE COMMENT 'Date when the last development milestone was achieved.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP core development record was last updated.',
    `licensing_model` STRING COMMENT 'Business model for IP core usage: internal use only, licensable with royalty, licensable royalty-free, or open source.. Valid values are `internal_use_only|licensable_royalty|licensable_royalty_free|open_source`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the ip core development record in the research domain.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this IP core development record.',
    `notes` STRING COMMENT 'The notes of the ip core development record in the research domain.',
    `patent_filing_count` STRING COMMENT 'Number of patent applications filed related to innovations in this IP core development project.',
    `pdk_version` STRING COMMENT 'Version of the Process Design Kit used for this IP core development, specifying the foundry technology files and design rules.',
    `production_release_target_date` DATE COMMENT 'Planned date for production release of the IP core, when it becomes available for integration into customer SoC designs.',
    `project_start_date` DATE COMMENT 'Date when the IP core development project was officially initiated.',
    `reuse_percentage` DECIMAL(18,2) COMMENT 'Percentage of the IP core design that reuses existing verified IP blocks or standard cells (0.00 to 100.00), indicating design efficiency.',
    `risk_level` STRING COMMENT 'Overall risk assessment for the IP core development project: low, medium, high, or critical, based on technical complexity, schedule, and resource constraints.. Valid values are `low|medium|high|critical`',
    `rtl_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of RTL design completion for the IP core, representing progress in the hardware description language implementation (0.00 to 100.00).',
    `silicon_validation_status` STRING COMMENT 'Status of silicon validation testing on fabricated test chips: not started, in progress, passed, failed, or waived (if validation not required for this IP type).. Valid values are `not_started|in_progress|passed|failed|waived`',
    `target_node` STRING COMMENT 'The target node of the ip core development record in the research domain.',
    `target_ppa_area_mm2` DECIMAL(18,2) COMMENT 'Target silicon area specification for the IP core in square millimeters, part of the PPA design goals.',
    `target_ppa_performance_mhz` DECIMAL(18,2) COMMENT 'Target operating frequency or performance specification for the IP core in megahertz, part of the PPA design goals.',
    `target_ppa_power_mw` DECIMAL(18,2) COMMENT 'Target power consumption specification for the IP core in milliwatts, part of the PPA (Power, Performance, Area) design goals.',
    `target_process_node` STRING COMMENT 'Target semiconductor process technology node for the IP core (e.g., 7nm, 5nm, 3nm FinFET, 2nm GAA). Specifies the fabrication technology the IP is designed for.',
    `technology_readiness_level` STRING COMMENT 'Technology Readiness Level (TRL) score from 1 (basic research) to 9 (production deployment), indicating maturity of the IP core technology.',
    `verification_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of functional verification coverage achieved through simulation and formal verification (0.00 to 100.00). Indicates completeness of design validation.',
    CONSTRAINT pk_ip_core_development PRIMARY KEY(`ip_core_development_id`)
) COMMENT 'Master records for intellectual property (IP) core development projects within R&D. Tracks development of new silicon IP blocks including processor cores, memory controllers, PHY interfaces, analog IP, and standard cell libraries. Captures IP name, IP type (hard IP, soft IP, firm IP), target process node, design specification version, RTL completion status, verification coverage, silicon validation status, licensing model (internal use, licensable), estimated NRE cost, and IP portfolio classification. Distinct from production IP catalog — this tracks the development lifecycle.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` (
    `patent_filing_id` BIGINT COMMENT 'Unique identifier for the patent filing record. Primary key for the patent filing entity.',
    `invention_disclosure_id` BIGINT COMMENT 'Business identifier for the initial invention disclosure submission that initiated this patent filing. Links to the upstream invention disclosure record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the inventor employee record within the patent filing research entity.',
    `project_id` BIGINT COMMENT 'FK to research.project.project_id — Inventions arise from research projects. This link enables IP portfolio analysis by research area and supports CHIPS Act IP reporting requirements.',
    `abandonment_date` DATE COMMENT 'Date the patent application was formally abandoned or withdrawn. Null if application is active or granted.',
    `actual_filing_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for filing and prosecuting this patent application to date. Updated as costs are incurred. Business-confidential financial data.',
    `application_number` STRING COMMENT 'Official patent application number assigned by the patent office upon filing. Format varies by jurisdiction (e.g., US: 16/123456, EP: EP3123456, CN: CN202110123456).. Valid values are `^[A-Z]{2}[0-9]{6,12}$`',
    `assigned_patent_counsel` STRING COMMENT 'Name of the patent attorney or agent assigned to prosecute this application. May be internal counsel or external law firm attorney.',
    `business_value_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) assessing the commercial value and competitive advantage provided by this invention. Used for portfolio prioritization and maintenance decisions.',
    `chips_act_reportable` BOOLEAN COMMENT 'Indicates whether this patent filing must be reported under CHIPS and Science Act IP reporting requirements. True if invention relates to CHIPS-funded R&D.',
    `claims_allowed` STRING COMMENT 'Number of claims allowed by the examiner for grant. Null if application not yet allowed. May be fewer than filed claims due to examiner rejections.',
    `claims_filed` STRING COMMENT 'Total number of claims included in the patent application as filed. Independent and dependent claims define the scope of protection sought.',
    `cpc_classification` STRING COMMENT 'Cooperative Patent Classification code used by USPTO and EPO for more granular technical categorization. Extension of IPC with additional subclasses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patent filing record was first created in the system. Audit trail for data lineage.',
    `disclosure_submission_date` DATE COMMENT 'Date the initial invention disclosure was submitted to the IP department for review. Precedes filing decision and application preparation.',
    `estimated_filing_cost` DECIMAL(18,2) COMMENT 'Estimated total cost for filing and prosecuting this patent application, including attorney fees, filing fees, and prosecution costs. Business-confidential financial data.',
    `expiration_date` DATE COMMENT 'Calculated expiration date of the patent term (typically 20 years from filing date for utility patents). Null if not yet granted.',
    `export_control_classification` STRING COMMENT 'Export control classification for the technology disclosed in the patent. ECCN (Export Control Classification Number) for dual-use items under EAR, or ITAR designation for defense articles.. Valid values are `EAR99|ECCN_[0-9][A-Z][0-9]{3}|ITAR`',
    `filing_date` DATE COMMENT 'Official date the patent application was filed with the patent office. Establishes priority date for prior art evaluation and patent term calculation.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the patent filing. Tracks progression from initial draft through final disposition (grant or abandonment). [ENUM-REF-CANDIDATE: draft|filed|pending|under_examination|allowed|granted|abandoned|withdrawn — 8 candidates stripped; promote to reference product]',
    `grant_date` DATE COMMENT 'Date the patent was officially granted by the patent office. Null if application is still pending or was abandoned.',
    `independent_claims` STRING COMMENT 'Count of independent claims in the application. Independent claims define the broadest scope of protection; more independent claims increase filing fees.',
    `invention_title` STRING COMMENT 'Official title of the invention as stated in the patent application. Concise description of the technical innovation being protected.',
    `inventor_count` STRING COMMENT 'Total count of named inventors on the patent application. Semiconductor inventions often have multiple co-inventors from cross-functional R&D teams.',
    `inventors` STRING COMMENT 'Comma-separated list of inventor names as listed on the patent application. Individuals who contributed to the conception of the invention. Business-confidential during pre-filing and prosecution.',
    `ipc_classification` STRING COMMENT 'International Patent Classification code assigned to categorize the invention by technical field. Semiconductor inventions typically fall under H01L (semiconductor devices) or H01C (resistors).. Valid values are `^[A-H][0-9]{2}[A-Z][0-9]{1,4}/[0-9]{2,6}$`',
    `jurisdiction` STRING COMMENT 'ISO country or regional code for the patent office jurisdiction where this application was filed (e.g., USA, CHN, JPN, KOR, TWN, EPO for European Patent Office, PCT for international).. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the patent filing record in the research domain.',
    `last_office_action_date` DATE COMMENT 'Date of the most recent office action received from the patent examiner. Null if no office actions received yet.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this patent filing record was most recently modified. Tracks data currency for prosecution status updates.',
    `law_firm` STRING COMMENT 'Name of the external law firm handling prosecution, if applicable. Null if handled by internal counsel.',
    `maintenance_fee_due_date` DATE COMMENT 'Next due date for maintenance fee payment to keep the granted patent in force. Applicable to granted patents only; null if not yet granted.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the patent filing record in the research domain.',
    `national_phase_entry_date` DATE COMMENT 'Date of entry into national phase for PCT applications. Deadline for entering individual country jurisdictions after international phase. Null if not a PCT application.',
    `notes` STRING COMMENT 'The notes of the patent filing record in the research domain.',
    `novelty_assessment` STRING COMMENT 'Assessment of the inventions novelty and non-obviousness based on prior art search. Highly novel inventions have strong patentability; questionable novelty may lead to trade secret strategy.. Valid values are `highly_novel|novel|incremental|questionable`',
    `office_action_count` STRING COMMENT 'Total number of office actions (examiner rejections or objections) received during prosecution. Higher counts indicate more complex prosecution.',
    `patent_filing_status` STRING COMMENT 'The status of the patent filing record in the research domain.',
    `patent_number` STRING COMMENT 'Official patent number assigned upon grant by the patent office. Null if application is still pending or abandoned.',
    `patent_status` STRING COMMENT 'The patent status of the patent filing record in the research domain.',
    `patent_title` STRING COMMENT 'The patent title of the patent filing record in the research domain.',
    `patent_to_project` BIGINT COMMENT 'FK to research.research_project.research_project_id — Patent filings arise from research project activities. Essential for tracking IP output per project and for CHIPS Act reporting.',
    `patent_type` STRING COMMENT 'Type of patent application filed. Utility patents cover functional inventions (most semiconductor IP), design patents cover ornamental designs, provisional applications establish priority date. [ENUM-REF-CANDIDATE: utility|design|provisional|plant|continuation|divisional|continuation_in_part — 7 candidates stripped; promote to reference product]',
    `pct_application_number` STRING COMMENT 'International application number if filed under the Patent Cooperation Treaty. Enables streamlined filing in multiple jurisdictions. Null if not a PCT application.. Valid values are `^PCT/[A-Z]{2}[0-9]{4}/[0-9]{6}$`',
    `primary_inventor` STRING COMMENT 'Name of the lead or primary inventor who initiated the invention disclosure. First-named inventor on the application.',
    `prior_art_references` STRING COMMENT 'Comma-separated list of key prior art references (patent numbers, publications) identified during search that are most relevant to patentability assessment.',
    `prior_art_search_completed` BOOLEAN COMMENT 'Indicates whether a formal prior art search was conducted before filing. True if search completed; false if filing proceeded without comprehensive search.',
    `priority_date` DATE COMMENT 'Earliest filing date claimed for priority purposes. May reference a provisional application, foreign application, or parent application filing date.',
    `prosecution_stage` STRING COMMENT 'Current stage in the patent prosecution process. Tracks progress through examination, office action responses, allowance, and final disposition. [ENUM-REF-CANDIDATE: not_started|application_preparation|filed_awaiting_examination|office_action_response|allowance|grant|appeal|abandoned — 8 candidates stripped; promote to reference product]',
    `protection_strategy` STRING COMMENT 'Recommended IP protection strategy determined during disclosure review. Patent filing is pursued when strategy is patent; trade secret or defensive publication may be chosen for certain inventions.. Valid values are `patent|trade_secret|defensive_publication|open_source|no_protection`',
    `publication_date` DATE COMMENT 'Date the patent application was published by the patent office (typically 18 months after filing). Null if not yet published or if publication was avoided.',
    `related_applications` STRING COMMENT 'Comma-separated list of related application numbers (parent, continuation, divisional, CIP). Tracks patent family relationships.',
    `response_due_date` DATE COMMENT 'Deadline for responding to the most recent office action. Critical date for prosecution timeline management. Null if no pending office action.',
    `strategic_value` DECIMAL(18,2) COMMENT 'Business assessment of the strategic value of this patent to the companys IP portfolio. Critical patents protect core differentiators; high-value patents support key product lines.',
    `technology_domain` STRING COMMENT 'Primary technology domain or technical area of the invention. Aligns with semiconductor R&D focus areas (process nodes, device structures, packaging, materials science, EDA). [ENUM-REF-CANDIDATE: process_technology|device_architecture|packaging|materials|eda_tools|testing|lithography|deposition|etching|doping|interconnect|memory|logic|analog|power|rf — 16 candidates stripped; promote to reference product]',
    CONSTRAINT pk_patent_filing PRIMARY KEY(`patent_filing_id`)
) COMMENT 'IP protection lifecycle records tracking inventions from initial disclosure through patent grant or disposition. Captures the full pipeline: invention disclosure submission (inventor names, technical description, novelty assessment, prior art search results, business value assessment, recommended protection strategy, submission date, assigned IP counsel, disposition decision), IP protection strategy decision, patent application filing, prosecution across jurisdictions (US, EU, CN, JP, KR, TW), and grant/abandonment outcome. Tracks disclosure ID, patent application number, filing date, jurisdiction, patent type (utility, design, provisional), invention title, inventors, technology domain classification, filing status, prosecution timeline, assigned patent counsel, strategic IP value classification, and final disposition. SSOT for all invention-to-patent lifecycle data. Supports IP portfolio management, competitive intelligence, trade secret decisions, and CHIPS Act IP reporting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` (
    `invention_disclosure_id` BIGINT COMMENT 'Unique identifier for the invention disclosure record. Primary key for the invention disclosure entity.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Invention disclosures that are export‑controlled must reference the specific export license to ensure compliance before filing patents.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: INVENTION DISCLOSURE: Disclosure documents inventions tied to a specific product; needed for IP strategy and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the invention inventor employee record within the invention disclosure research entity.',
    `project_id` BIGINT COMMENT 'Unique identifier for the invention project record within the invention disclosure research entity.',
    `invention_research_project_id` BIGINT COMMENT 'Identifier of the R&D project or research program that generated this invention. Links disclosure to the originating research initiative.',
    `primary_inventor_employee_id` BIGINT COMMENT 'Employee identifier of the primary inventor for internal tracking and inventor compensation programs.',
    `assigned_ip_counsel` STRING COMMENT 'Name of the IP attorney or patent agent assigned to review the disclosure and manage patent prosecution if filing proceeds.',
    `business_value_assessment` STRING COMMENT 'Assessment of the inventions potential business value and commercial impact: High (significant competitive advantage or revenue potential), Medium (moderate value), Low (limited impact), Pending (assessment in progress).. Valid values are `high|medium|low|pending`',
    `co_inventors` STRING COMMENT 'Comma-separated list of co-inventor names who contributed to the conception of the invention. Empty if single inventor.',
    `collaboration_partner` STRING COMMENT 'Name of external research institution, university, or partner organization involved in the invention development. Null if purely internal invention.',
    `competitive_advantage_description` STRING COMMENT 'Description of how the invention provides competitive advantage in the market, including performance improvements, cost reductions, or enabling capabilities.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the invention disclosure content: Highly Confidential (trade secret, restricted access), Confidential (internal only), Internal (general employee access), Public (published or non-sensitive).. Valid values are `highly_confidential|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invention disclosure record was first created in the system.',
    `decision_date` DATE COMMENT 'Date when the IP review committee made the final disposition decision on the disclosure. Null if decision pending.',
    `decision_rationale` STRING COMMENT 'Explanation of the review committees decision rationale, including factors considered such as novelty, business value, prior art, and strategic alignment.',
    `device_architecture_type` STRING COMMENT 'Specific device architecture type if applicable: FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), CFET (Complementary FET), Planar, Other, or Not Applicable.. Valid values are `finfet|gaa|cfet|planar|other|not_applicable`',
    `disclosure_date` DATE COMMENT 'The disclosure date associated with the invention disclosure research record.',
    `disclosure_number` STRING COMMENT 'Business identifier for the invention disclosure, formatted as ID-YYYY-NNNNN where YYYY is year and NNNNN is sequential number. Used for external reference and tracking.. Valid values are `^ID-[0-9]{4}-[0-9]{5}$`',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the invention disclosure: Submitted (initial submission), Under Review (technical and business review in progress), Approved for Filing (approved to proceed with patent application), Rejected (not proceeding with IP protection), Withdrawn (inventor withdrew disclosure), Patent Filed (patent application submitted), Published (defensively published), Closed (final disposition completed). [ENUM-REF-CANDIDATE: submitted|under_review|approved_for_filing|rejected|withdrawn|patent_filed|published|closed — 8 candidates stripped; promote to reference product]',
    `disclosure_title` STRING COMMENT 'The disclosure title of the invention disclosure record in the research domain.',
    `experimental_wafer_lot` STRING COMMENT 'Wafer lot number(s) used for proof-of-concept or experimental validation of the invention. Comma-separated if multiple lots.',
    `export_control_classification` STRING COMMENT 'Export control classification of the invention technology: EAR99 (not controlled), ECCN (Export Control Classification Number assigned), ITAR Controlled (subject to International Traffic in Arms Regulations), Not Applicable, Pending Review.. Valid values are `ear99|eccn|itar_controlled|not_applicable|pending_review`',
    `funding_source` STRING COMMENT 'Primary funding source for the research that led to the invention: Internal R&D, Government Grant, Industry Consortium, Joint Development, Other.. Valid values are `internal_r_and_d|government_grant|industry_consortium|joint_development|other`',
    `government_contract_number` STRING COMMENT 'Government contract or grant number if the invention was developed under government funding. May trigger special IP rights or reporting requirements under CHIPS Act or similar programs.',
    `invention_disclosure_status` STRING COMMENT 'The status of the invention disclosure record in the research domain.',
    `invention_title` STRING COMMENT 'Concise title of the invention describing the technical innovation or discovery.',
    `inventor_organization` STRING COMMENT 'Business unit, division, or research group of the primary inventor at time of disclosure submission.',
    `ip_counsel_contact` STRING COMMENT 'Email address of the assigned IP counsel for communication regarding the disclosure.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `ip_protection_strategy` STRING COMMENT 'Recommended intellectual property protection strategy: Patent (file patent application), Trade Secret (maintain as confidential), Defensive Publication (publish to prevent others from patenting), No Protection (disclose publicly), Pending Decision (under review).. Valid values are `patent|trade_secret|defensive_publication|no_protection|pending_decision`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the invention disclosure record was last updated or modified.',
    `market_application` STRING COMMENT 'Target market applications or product segments where the invention would be deployed (e.g., mobile processors, automotive chips, AI accelerators, IoT devices).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the invention disclosure record in the research domain.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the disclosure record.',
    `notes` STRING COMMENT 'The notes of the invention disclosure record in the research domain.',
    `novelty_assessment` STRING COMMENT 'Initial assessment of the inventions novelty and non-obviousness by technical reviewers: High (clearly novel), Medium (potentially novel), Low (incremental), Pending (assessment in progress).. Valid values are `high|medium|low|pending`',
    `patent_application_number` STRING COMMENT 'Patent application number assigned by the patent office if a patent application was filed. Null if no application filed yet.',
    `patent_filing_date` DATE COMMENT 'Date when the patent application was officially filed with the patent office. Null if not yet filed.',
    `patent_filing_recommendation` BOOLEAN COMMENT 'Boolean flag indicating whether IP counsel recommends filing a patent application for this invention. True if patent filing is recommended, False otherwise.',
    `patent_jurisdiction` STRING COMMENT 'Recommended patent filing jurisdictions or regions (e.g., US, EP, CN, JP, KR, PCT). Comma-separated list of ISO 3166-1 alpha-2 country codes or regional designations.',
    `primary_inventor_name` STRING COMMENT 'Full name of the primary or lead inventor who conceived the invention. First inventor listed on the disclosure.',
    `prior_art_references` STRING COMMENT 'List of relevant prior art references identified during search, including patent numbers, publication citations, or public disclosure references.',
    `prior_art_search_date` DATE COMMENT 'Date when the prior art search was completed. Null if search not yet completed.',
    `prior_art_search_status` STRING COMMENT 'Status of prior art search to identify existing patents, publications, or public disclosures related to the invention.. Valid values are `not_started|in_progress|completed|not_required`',
    `process_node_target` STRING COMMENT 'Target process node or technology generation for the invention (e.g., 3nm, 2nm, 1.4nm, or next-generation node designation).',
    `publication_number` STRING COMMENT 'Publication number if the invention was defensively published in a technical journal or defensive publication service. Null if not published.',
    `review_committee_decision` STRING COMMENT 'Decision outcome from the IP review committee: Approved (proceed with recommended IP strategy), Rejected (do not pursue IP protection), Deferred (requires additional information or analysis), Pending (decision not yet made).. Valid values are `approved|rejected|deferred|pending`',
    `submission_date` DATE COMMENT 'Date when the invention disclosure was formally submitted by the inventor(s) to the IP management office.',
    `technical_description` STRING COMMENT 'Detailed technical description of the invention including the problem solved, technical approach, novel features, and implementation details. Contains proprietary technical information.',
    `technology_domain` STRING COMMENT 'Primary technology domain or area of the invention within semiconductor R&D (IC Design, Wafer Fabrication, Process Engineering, Packaging, Materials, Device Architecture, Lithography, Testing, Other). [ENUM-REF-CANDIDATE: ic_design|wafer_fabrication|process_engineering|packaging|materials|device_architecture|lithography|testing|other — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_invention_disclosure PRIMARY KEY(`invention_disclosure_id`)
) COMMENT 'Invention disclosure records submitted by R&D engineers and scientists documenting novel technical discoveries, process innovations, and device concepts prior to patent filing. Captures disclosure ID, submission date, inventor names, invention title, technical description, novelty assessment, prior art search status, business value assessment, recommended IP protection strategy (patent, trade secret, publication), assigned IP counsel, and disposition decision. Feeds the patent filing pipeline and IP portfolio strategy.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`collaboration` (
    `collaboration_id` BIGINT COMMENT 'Primary key for collaboration',
    `account_id` BIGINT COMMENT 'Unique identifier for the partner account record within the collaboration research entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Collaboration agreements require a designated employee contact for technical coordination and reporting.',
    `project_id` BIGINT COMMENT 'FK to research.project.project_id — External collaborations are typically scoped to specific research projects. This link enables tracking which external partners contribute to which research outcomes.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: A research collaboration agreement is scoped to an R&D program; the FK ties the collaboration to its sponsoring program for governance and funding.',
    `background_ip_included_flag` BOOLEAN COMMENT 'Indicates whether the collaboration agreement includes access to or licensing of pre-existing background intellectual property from either party.',
    `collaboration_code` STRING COMMENT 'Unique business identifier or reference code for the collaboration agreement used in external communications and internal tracking systems.',
    `collaboration_status` STRING COMMENT 'Current lifecycle state of the research collaboration agreement.. Valid values are `draft|active|on_hold|completed|terminated|expired`',
    `collaboration_type` STRING COMMENT 'Classification of the research collaboration arrangement. Defines the nature of the partnership relationship.. Valid values are `joint_development|sponsored_research|consortium_membership|cro_engagement|technology_licensing|material_transfer`',
    `confidentiality_classification` STRING COMMENT 'Data classification level governing information sharing and disclosure restrictions under the collaboration agreement.. Valid values are `public|internal|confidential|restricted|proprietary`',
    `consortium_name` STRING COMMENT 'Name of the research consortium if the collaboration is conducted through a multi-party consortium (e.g., imec, SEMATECH, Fraunhofer). Nullable for bilateral collaborations.',
    `contract_reference_number` STRING COMMENT 'Legal contract or master agreement reference number for the collaboration. Links to the formal legal document repository.',
    `cost_sharing_percentage` DECIMAL(18,2) COMMENT 'Percentage of total research costs borne by the company under cost-sharing arrangements. Expressed as a percentage (0.00 to 100.00).',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the collaboration record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collaboration record was first created in the system.',
    `deliverables_schedule` STRING COMMENT 'Structured description or reference to the timeline and milestones for research deliverables, reports, prototypes, or technology transfer activities defined in the collaboration agreement.',
    `dispute_resolution_mechanism` STRING COMMENT 'Contractual mechanism for resolving disputes arising from the collaboration agreement.. Valid values are `negotiation|mediation|arbitration|litigation`',
    `end_date` DATE COMMENT 'Scheduled or actual end date when the research collaboration agreement terminates. Nullable for open-ended or evergreen agreements.',
    `export_control_classification` STRING COMMENT 'Export control classification indicating whether the research collaboration involves controlled technologies subject to ITAR, EAR, or other export regulations.. Valid values are `none|ear|itar|dual_use|controlled`',
    `funding_contribution_amount` DECIMAL(18,2) COMMENT 'Total financial contribution committed by the company to the research collaboration, expressed in the companys reporting currency.',
    `funding_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the funding contribution amount.. Valid values are `^[A-Z]{3}$`',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law specified in the collaboration agreement for contract interpretation and enforcement.',
    `government_program_name` STRING COMMENT 'Name of the government research program or funding initiative if the collaboration is part of a public-sector research program (e.g., CHIPS Act funded research). Nullable for private collaborations.',
    `ip_ownership_terms` STRING COMMENT 'Contractual terms defining ownership, licensing rights, and usage rights for intellectual property generated through the collaboration. Critical for patent filing and technology commercialization decisions.',
    `joint_patent_filing_terms` STRING COMMENT 'Terms governing joint patent filing procedures, cost allocation, and prosecution responsibilities for inventions arising from the collaboration.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the collaboration record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the collaboration record was last updated or modified.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the collaboration record in the research domain.',
    `collaboration_name` STRING COMMENT 'Official name or title of the research collaboration agreement.',
    `nda_reference_number` STRING COMMENT 'Reference number or identifier for the associated non-disclosure agreement governing confidential information exchange under the collaboration.',
    `notes` STRING COMMENT 'The notes of the collaboration record in the research domain.',
    `partner_institution_name` STRING COMMENT 'Name of the external research partner organization (university, national laboratory, research consortium, or government research program).',
    `partner_name` STRING COMMENT 'The partner name of the collaboration record in the research domain.',
    `partner_technical_contact_email` STRING COMMENT 'Email address of the external partners primary technical contact for the collaboration.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `partner_technical_contact_name` STRING COMMENT 'Name of the external partners technical lead or principal investigator responsible for the collaboration.',
    `publication_rights` STRING COMMENT 'Terms governing the right to publish research findings, present at conferences, or disclose results publicly. Defines pre-publication review requirements and embargo periods.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the collaboration agreement includes an option for renewal or extension beyond the initial term.',
    `research_scope` STRING COMMENT 'Detailed description of the research objectives, technical focus areas, and deliverables covered by the collaboration agreement. May include process node development, device architecture research, packaging technologies, or materials research.',
    `start_date` DATE COMMENT 'Effective start date when the research collaboration agreement becomes active and research activities may commence.',
    `technology_focus_area` STRING COMMENT 'Primary technology domain or research area targeted by the collaboration. Aligns with semiconductor technology roadmap categories. [ENUM-REF-CANDIDATE: process_node_development|finfet_architecture|gaa_architecture|cfet_architecture|advanced_packaging|materials_research|ip_core_development|euv_lithography|beol_interconnect|feol_device|other — 11 candidates stripped; promote to reference product]',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required for either party to terminate the collaboration agreement.',
    CONSTRAINT pk_collaboration PRIMARY KEY(`collaboration_id`)
) COMMENT 'Master records for external research collaboration agreements with universities, national laboratories, research consortia (e.g., imec, SEMATECH, Fraunhofer), and government research programs. Captures collaboration name, partner institution, collaboration type (joint development, sponsored research, consortium membership, CRO engagement), research scope, funding contribution, IP ownership terms, confidentiality classification, start/end dates, key technical contacts, deliverables schedule, and collaboration status. Distinct from commercial supplier contracts managed in supply domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` (
    `tapeout_experiment_id` BIGINT COMMENT 'Unique identifier for the experimental tapeout submission record. Primary key for research tapeout tracking.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Identifier of the process technology node (e.g., 7nm, 5nm, 3nm, FinFET, GAA) used for this experimental tapeout.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: TAPEOUT PLANNING: Tapeout experiment creates a silicon version of a defined product; required for release schedule and cost analysis.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Tapeout specifications include packaging technology; FK ensures consistency with manufacturing package capabilities.',
    `photomask_id` BIGINT COMMENT 'Unique identifier for the photomask set generated for this tapeout. Critical for traceability to fabrication results.',
    `primary_tapeout_project_id` BIGINT COMMENT 'FK to research.project.project_id — Experimental tapeouts are submitted as part of research projects. This link enables tracking which test chips were produced for which research initiative.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tapeout experiments need PI employee ID for responsibility tracking and export‑control reporting.',
    `project_id` BIGINT COMMENT 'Unique identifier for the primary project record within the tapeout experiment research entity.',
    `research_technology_node_id` BIGINT COMMENT 'Unique identifier for the research technology node record within the tapeout experiment research entity.',
    `research_test_plan_id` BIGINT COMMENT 'Identifier of the characterization and test plan that will be executed on returned silicon. Links to test methodology documentation.',
    `actual_return_date` DATE COMMENT 'Actual date when fabricated wafers or packaged dies were received back from the foundry. Null if not yet returned.',
    `chip_name` STRING COMMENT 'Name of the test chip, process characterization vehicle (PCV), or technology demonstrator being taped out.',
    `collaboration_partner` STRING COMMENT 'Name of external research institution, university, or industry partner collaborating on this experimental tapeout. Null if internal-only.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this experimental tapeout record was first created in the system.',
    `data_retention_years` STRING COMMENT 'Required retention period in years for all design files, test data, and documentation associated with this experimental tapeout.',
    `design_team` STRING COMMENT 'Name or identifier of the design team or research group that executed the chip design for this tapeout.',
    `device_architecture_type` STRING COMMENT 'Novel device architecture being tested (e.g., FinFET, GAA, CFET, nanowire, FDSOI). Captures the experimental transistor or device structure.',
    `die_size_mm2` DECIMAL(18,2) COMMENT 'Physical die area in square millimeters. Critical for yield modeling and cost estimation.',
    `drc_completion_date` DATE COMMENT 'Date when DRC verification was completed and signed off.',
    `drc_status` STRING COMMENT 'Status of the design rule check verification. Indicates whether the layout complies with foundry design rules.. Valid values are `passed|failed|waived|in_progress|not_started`',
    `eda_tool_suite` STRING COMMENT 'Primary EDA tool suite used for design, verification, and layout (e.g., Cadence, Synopsys, Mentor/Siemens). Captures toolchain for reproducibility.',
    `expected_return_date` DATE COMMENT 'Anticipated date when fabricated wafers or packaged dies will be returned from the foundry for testing and characterization.',
    `experiment_code` STRING COMMENT 'Coded value representing the experiment code of the tapeout experiment research record.',
    `experiment_status` STRING COMMENT 'Current lifecycle status of the experimental tapeout from planning through completion or cancellation. [ENUM-REF-CANDIDATE: planned|design_in_progress|drc_lvs_verification|submitted|in_fabrication|returned|testing|completed|cancelled — 9 candidates stripped; promote to reference product]',
    `export_control_classification` STRING COMMENT 'Export control classification (e.g., EAR, ITAR) applicable to this experimental technology. Critical for compliance with US export regulations.',
    `foundry_fab_target` STRING COMMENT 'Name or identifier of the foundry or internal fab facility where this experimental tapeout will be manufactured.',
    `funding_source` STRING COMMENT 'Source of funding for this experimental tapeout (e.g., internal R&D budget, government grant, CHIPS Act funding, joint development agreement).',
    `gds_submission_date` DATE COMMENT 'Date when the final GDS or GDSII design file was submitted to the foundry or fab for mask generation.',
    `ip_core_under_test` STRING COMMENT 'Name or identifier of the IP core being validated in this tapeout (e.g., CPU core, GPU block, memory controller, analog IP). Null if not IP-focused.',
    `ip_filing_reference` STRING COMMENT 'Reference number or identifier for any patent applications or IP disclosures associated with this experimental tapeout. Null if no IP filing.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this experimental tapeout record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this experimental tapeout record was last updated. Tracks the most recent change to any field.',
    `lvs_completion_date` DATE COMMENT 'Date when LVS verification was completed and signed off.',
    `lvs_status` STRING COMMENT 'Status of the layout versus schematic verification. Confirms that the physical layout matches the intended circuit schematic.. Valid values are `passed|failed|waived|in_progress|not_started`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tapeout experiment record in the research domain.',
    `mpw_slot_allocation` STRING COMMENT 'MPW shuttle slot identifier or allocation code if this tapeout is part of a shared multi-project wafer run. Null if dedicated wafer.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, lessons learned, or special considerations related to this experimental tapeout.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'Total non-recurring engineering cost in US dollars for this experimental tapeout, including mask set, MPW fees, and design services.',
    `number_of_dies_per_wafer` STRING COMMENT 'Estimated or actual count of dies that can be produced per wafer for this design, based on die size and wafer diameter.',
    `pdk_version` STRING COMMENT 'Version identifier of the process design kit used for this tapeout. Critical for design rule compliance and reproducibility.',
    `principal_investigator` STRING COMMENT 'Name or employee identifier of the lead researcher or principal investigator responsible for this experimental tapeout.',
    `shuttle_name` STRING COMMENT 'The shuttle name of the tapeout experiment record in the research domain.',
    `tapeout_date` DATE COMMENT 'The tapeout date associated with the tapeout experiment research record.',
    `tapeout_experiment_status` STRING COMMENT 'The status of the tapeout experiment record in the research domain.',
    `tapeout_name` STRING COMMENT 'Human-readable name or designation for this experimental tapeout, typically reflecting the research objective or chip codename.',
    `tapeout_purpose` STRING COMMENT 'Primary research objective for this experimental tapeout: process validation, device characterization, IP core validation, yield learning, architecture proof-of-concept, or advanced packaging test.. Valid values are `process_validation|device_characterization|ip_validation|yield_learning|architecture_proof|packaging_test`',
    `tapeout_to_project` BIGINT COMMENT 'FK to research.research_project.research_project_id — Experimental tapeouts are submitted as part of a research project. Links design experiments to their parent project for tracking and funding.',
    `wafer_allocation_type` STRING COMMENT 'Type of wafer allocation for this experimental tapeout: MPW shuttle, dedicated wafer lot, shared research lot, or pilot production run.. Valid values are `mpw|dedicated|shared_lot|pilot_run`',
    `wafer_quantity` STRING COMMENT 'Number of wafers allocated or fabricated for this experimental tapeout.',
    `created_by` STRING COMMENT 'User identifier or system account that created this experimental tapeout record.',
    CONSTRAINT pk_tapeout_experiment PRIMARY KEY(`tapeout_experiment_id`)
) COMMENT 'Records of experimental tapeout submissions for research test chips, process characterization vehicles (PCVs), and technology demonstrators. Captures tapeout ID, associated research project, chip name, technology node, GDS/GDSII submission date, MPW (Multi-Project Wafer) slot or dedicated wafer allocation, mask set ID, design rule check (DRC) status, LVS status, foundry/fab target, expected return date, and tapeout purpose (process validation, device characterization, IP validation, yield learning). Distinct from production tapeouts managed in design domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` (
    `characterization_result_id` BIGINT COMMENT 'Unique identifier for the characterization result record. Primary key for R&D electrical and physical characterization measurement results from research test structures, Process Control Vehicles (PCVs), and experimental devices.',
    `employee_id` BIGINT COMMENT 'Identifier for the R&D engineer responsible for analyzing the characterization results and driving yield learning activities. Links to workforce or employee entity.',
    `characterization_engineer_employee_id` BIGINT COMMENT 'Unique identifier for the characterization engineer employee record within the characterization result research entity.',
    `experimental_lot_id` BIGINT COMMENT 'FK to research.experimental_lot.experimental_lot_id — Characterization measurements are taken from experimental lot wafers. Essential for tracing measurement data back to the physical material.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) under development. Examples include 7nm, 5nm, 3nm, or advanced nodes with FinFET, Gate-All-Around (GAA), or Complementary FET (CFET) architectures.',
    `primary_experimental_lot_id` BIGINT COMMENT 'FK to research.experimental_lot.experimental_lot_id — Characterization measurements are performed on wafers from experimental lots. Without this link, you cannot trace measurement results back to the process conditions that produced them — breaking the f',
    `process_flow_experiment_id` BIGINT COMMENT 'Identifier for the R&D experiment or proof-of-concept project to which this characterization belongs. Links characterization results to broader research initiatives and technology roadmap milestones.',
    `process_integration_run_id` BIGINT COMMENT 'FK to research.process_integration_run.process_integration_run_id — Characterization results validate process integration run outcomes. This link enables the learn-iterate cycle that is core to semiconductor R&D.',
    `process_split_id` BIGINT COMMENT 'Identifier for the specific process split or experimental condition being evaluated. Used in Design of Experiments (DOE) to track variations in materials, recipes, or process sequences.',
    `test_structure_id` BIGINT COMMENT 'Identifier for the specific test structure or device under test (DUT) on the wafer. May reference Process Control Vehicle (PCV) structures, experimental device patterns, or dedicated characterization sites.',
    `wafer_id` BIGINT COMMENT 'Reference to the experimental wafer on which the characterization was performed. Links to the wafer entity in the fabrication domain.',
    `analysis_software` STRING COMMENT 'Name and version of the software tool used for data analysis and parameter extraction. Examples include MATLAB, Python scripts, proprietary EDA (Electronic Design Automation) tools, or equipment vendor analysis packages.',
    `characterization_result_status` STRING COMMENT 'The status of the characterization result record in the research domain.',
    `comments` STRING COMMENT 'Free-text field for additional observations, anomalies, or contextual information about the characterization result. Used by engineers to document unusual behavior, equipment issues, or interpretation notes.',
    `corrective_action_proposed` STRING COMMENT 'Proposed corrective actions to address identified yield limiters or parametric issues. May include process recipe changes, equipment maintenance, design rule modifications, or material substitutions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this characterization result record was first created in the system. Part of audit trail for data lineage and compliance.',
    `data_file_path` STRING COMMENT 'File system path or object storage location of the raw measurement data file. For curve measurements (IV, CV) or imaging data (TEM, AFM), points to the detailed data set for further analysis.',
    `defect_density` DECIMAL(18,2) COMMENT 'Measured defect density expressed as defects per unit area (typically defects per square centimeter). Critical metric for yield prediction and process quality assessment.',
    `defect_type` STRING COMMENT 'Classification of defect observed during characterization. Includes particle defects, pattern defects (lithography-related), electrical defects (opens, shorts, leakage), and physical defects (voids, hillocks, contamination). [ENUM-REF-CANDIDATE: particle|pattern|electrical|crystallographic|contamination|void|hillock|scratch|residue|bridging|open_circuit|short_circuit — 12 candidates stripped; promote to reference product]',
    `device_architecture` STRING COMMENT 'Type of transistor or device architecture being characterized. Includes planar CMOS, FinFET (Fin Field-Effect Transistor), GAA (Gate-All-Around), CFET (Complementary FET), nanowire, nanosheet, and other advanced device structures. [ENUM-REF-CANDIDATE: planar|finfet|gaa|cfet|nanowire|nanosheet|vertical_fet|tunnel_fet — 8 candidates stripped; promote to reference product]',
    `die_yield_percent` DECIMAL(18,2) COMMENT 'Percentage of functional dies on the wafer that pass all characterization tests. Represents the ratio of Known Good Die (KGD) to total dies tested.',
    `dominant_yield_detractor` STRING COMMENT 'Primary defect type or failure mode contributing most significantly to yield loss. Identified through Pareto analysis of defect types and failure modes.',
    `functional_yield_percent` DECIMAL(18,2) COMMENT 'Percentage of dies that pass functional testing, demonstrating correct logical operation. Subset of die yield focusing on functional correctness rather than parametric performance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the characterization result record in the research domain.',
    `learning_cycle_number` STRING COMMENT 'Sequential number identifying the learning cycle or iteration in which this characterization was performed. Tracks progression through Design of Experiments (DOE) and process optimization cycles.',
    `measured_value` DECIMAL(18,2) COMMENT 'The measured value of the characterization result record in the research domain.',
    `measurement_condition` STRING COMMENT 'Environmental and operational conditions under which the measurement was performed. Includes temperature, voltage bias, frequency, ambient conditions, and test mode settings that affect measurement results.',
    `measurement_date` DATE COMMENT 'The measurement date associated with the characterization result research record.',
    `measurement_equipment_code` STRING COMMENT 'Identifier for the Automatic Test Equipment (ATE) or characterization tool used to perform the measurement. Includes parametric testers, probe stations, analytical microscopes, and metrology systems.',
    `measurement_status` STRING COMMENT 'Pass/fail status of the measurement against specification limits or expected behavior. Indicates whether the measured parameter meets design targets and process control limits.. Valid values are `pass|fail|marginal|incomplete|invalid|retest_required`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the characterization measurement was performed. Critical for tracking measurement sequence, equipment drift, and temporal correlation with process conditions.',
    `measurement_type` STRING COMMENT 'Type of electrical or physical characterization measurement performed. Includes IV (Current-Voltage) curves, CV (Capacitance-Voltage) curves, SIMS (Secondary Ion Mass Spectrometry), TEM (Transmission Electron Microscopy), XRD (X-Ray Diffraction), AFM (Atomic Force Microscopy), and key electrical parameters. [ENUM-REF-CANDIDATE: iv_curve|cv_curve|sims|tem|xrd|afm|sheet_resistance|threshold_voltage|leakage_current|breakdown_voltage|capacitance|mobility|contact_resistance|gate_oxide_integrity|stress_migration|electromigration — 16 candidates stripped; promote to reference product]',
    `measurement_unit` STRING COMMENT 'Unit of measure for the measurement value. Examples include volts (V), amperes (A), ohms (Ω), farads (F), ohms per square (Ω/sq), atoms per cubic centimeter (atoms/cm³), nanometers (nm).',
    `measurement_value` DECIMAL(18,2) COMMENT 'Primary numerical result of the characterization measurement. For scalar measurements (threshold voltage, sheet resistance, leakage current), this is the measured value. For curve measurements (IV, CV), this may represent a key extracted parameter.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the characterization result record in the research domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this characterization result record was last modified. Tracks updates to analysis findings, corrective actions, or data corrections.',
    `notes` STRING COMMENT 'The notes of the characterization result record in the research domain.',
    `parameter_name` STRING COMMENT 'The parameter name of the characterization result record in the research domain.',
    `parametric_yield_percent` DECIMAL(18,2) COMMENT 'Percentage of dies that meet all parametric specifications (timing, power, voltage, current). Subset of die yield focusing on performance parameters within specification limits.',
    `pdk_calibration_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this characterization result is used for Process Design Kit (PDK) model calibration. PDK calibration data feeds SPICE models and design rules for IC design tools.',
    `reliability_stress_type` STRING COMMENT 'Type of reliability stress testing applied before or during characterization. Includes HTOL (High Temperature Operating Life), LTOL (Low Temperature Operating Life), HAST (Highly Accelerated Stress Test), THB (Temperature Humidity Bias), TC (Temperature Cycling), HCI (Hot Carrier Injection), NBTI (Negative Bias Temperature Instability), PBTI (Positive Bias Temperature Instability), TDDB (Time-Dependent Dielectric Breakdown), EM (Electromigration), SM (Stress Migration). [ENUM-REF-CANDIDATE: none|htol|ltol|hast|thb|tc|hci|nbti|pbti|tddb|em|sm — 12 candidates stripped; promote to reference product]',
    `root_cause_analysis` STRING COMMENT 'Detailed findings from root cause analysis investigation. Documents the systematic investigation using techniques such as Failure Mode and Effects Analysis (FMEA), fishbone diagrams, and 5-Why analysis to identify underlying causes of yield loss or parametric deviation.',
    `specification_lower_limit` DECIMAL(18,2) COMMENT 'Lower control limit or specification limit for the measured parameter. Used to determine pass/fail status and process capability. Part of Statistical Process Control (SPC) framework.',
    `specification_upper_limit` DECIMAL(18,2) COMMENT 'Upper control limit or specification limit for the measured parameter. Used to determine pass/fail status and process capability. Part of Statistical Process Control (SPC) framework.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the characterization result record in the research domain.',
    `yield_improvement_delta` DECIMAL(18,2) COMMENT 'Measured improvement in yield percentage achieved after implementing corrective actions. Quantifies the effectiveness of yield learning and process optimization efforts.',
    `yield_limiting_mechanism` STRING COMMENT 'Identified root cause or mechanism that is limiting yield performance. Examples include random defects, systematic pattern issues, parametric drift, edge exclusion, or specific process step failures.',
    CONSTRAINT pk_characterization_result PRIMARY KEY(`characterization_result_id`)
) COMMENT 'Electrical and physical characterization measurement results from research test structures, PCVs, and experimental devices, including comprehensive yield learning and defect analysis records. Captures measurement data (IV/CV curves, SIMS, TEM, XRD, AFM, sheet resistance, threshold voltage, leakage current), measurement equipment, measurement conditions, pass/fail status, defect analysis (particle, pattern, electrical defect types, defect density), yield measurements (die yield, functional yield, parametric yield), yield limiting mechanisms, dominant yield detractors, root cause analysis findings, corrective process actions proposed, yield improvement deltas achieved, learning engineer, and learning cycle tracking. SSOT for all R&D characterization and yield learning data. Feeds process integration learning, device model development, PDK calibration, and production yield ramp planning.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` (
    `pdk_development_id` BIGINT COMMENT 'Unique identifier for the PDK development record. Primary key for tracking PDK creation, versioning, and release lifecycle.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process geometry) for which this PDK is developed, such as 5nm, 3nm, or 2nm.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the lead employee record within the pdk development research entity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: PDK development costs and licensing income are allocated to a profit center for financial consolidation.',
    `research_technology_node_id` BIGINT COMMENT 'FK to research.research_technology_node.research_technology_node_id — Every PDK is developed for a specific technology node. This is the fundamental association between design enablement and process technology.',
    `cadence_virtuoso_compatible` BOOLEAN COMMENT 'Flag indicating whether this PDK is compatible with Cadence Virtuoso EDA tool suite for analog and custom IC design.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PDK development record was first created in the system.',
    `critical_issues_count` STRING COMMENT 'Number of critical severity issues in this PDK version that may block design activities or cause silicon failures.',
    `deprecation_date` DATE COMMENT 'Date when this PDK version was marked as deprecated and no longer recommended for new designs.',
    `development_stage` STRING COMMENT 'The development stage of the pdk development record in the research domain.',
    `development_start_date` DATE COMMENT 'Date when development activities for this PDK version were initiated.',
    `development_status` STRING COMMENT 'The development status of the pdk development record in the research domain.',
    `development_team` STRING COMMENT 'Name of the R&D team or organizational unit responsible for developing this PDK.',
    `device_architecture_type` STRING COMMENT 'Transistor architecture supported by this PDK. FinFET for fin field-effect transistor, GAA for gate-all-around, CFET for complementary FET, planar for traditional planar transistors.. Valid values are `planar|finfet|gaa|cfet|hybrid`',
    `documentation_url` STRING COMMENT 'URL link to the comprehensive PDK documentation repository including design manuals, release notes, and technical specifications.',
    `end_of_support_date` DATE COMMENT 'Date when technical support and updates for this PDK version will cease, aligned with technology node EOL planning.',
    `includes_design_rule_manual` BOOLEAN COMMENT 'Flag indicating whether this PDK version includes comprehensive design rule documentation and guidelines.',
    `includes_drc_rules` BOOLEAN COMMENT 'Flag indicating whether this PDK version includes DRC rule decks for physical verification of IC layouts.',
    `includes_io_libraries` BOOLEAN COMMENT 'Flag indicating whether this PDK version includes IO pad libraries for chip-to-package interface design.',
    `includes_lvs_rules` BOOLEAN COMMENT 'Flag indicating whether this PDK version includes LVS rule decks for verifying layout-to-schematic correspondence.',
    `includes_memory_compilers` BOOLEAN COMMENT 'Flag indicating whether this PDK version includes memory compiler tools for generating SRAM, ROM, or other memory blocks.',
    `includes_spice_models` BOOLEAN COMMENT 'Flag indicating whether this PDK version includes SPICE device models for circuit simulation and analysis.',
    `includes_standard_cell_libraries` BOOLEAN COMMENT 'Flag indicating whether this PDK version includes pre-characterized standard cell libraries for digital design.',
    `is_customer_accessible` BOOLEAN COMMENT 'Flag indicating whether this PDK version is available for external customer access or restricted to internal use only.',
    `known_issues_count` STRING COMMENT 'Number of documented known issues, limitations, or bugs in this PDK version that design teams should be aware of.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PDK development record was last updated, tracking the most recent change to any field.',
    `lifecycle_status` STRING COMMENT 'Current state of the PDK in its development and operational lifecycle. Tracks progression from initial development through validation, release, active use, and eventual retirement.. Valid values are `in_development|under_validation|released|active|suspended|retired`',
    `mentor_compatible` BOOLEAN COMMENT 'Flag indicating whether this PDK is compatible with Mentor Graphics (Siemens EDA) tool suite.',
    `metal_layers_count` STRING COMMENT 'Number of metal interconnect layers available in this PDK for routing, typically ranging from 5 to 15+ layers for advanced nodes.',
    `minimum_feature_size_nm` DECIMAL(18,2) COMMENT 'Smallest manufacturable feature dimension in nanometers, representing the technology nodes resolution capability.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the pdk development record in the research domain.',
    `notes` STRING COMMENT 'The notes of the pdk development record in the research domain.',
    `pdk_code` STRING COMMENT 'Business identifier for the PDK. Externally-known unique code used across design teams and EDA tool integrations.. Valid values are `^PDK-[A-Z0-9]{6,12}$`',
    `pdk_custodian_email` STRING COMMENT 'Email contact for the PDK custodian for technical support and escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `pdk_custodian_name` STRING COMMENT 'Name of the individual or team responsible for maintaining and supporting this PDK version.',
    `pdk_development_status` STRING COMMENT 'The status of the pdk development record in the research domain.',
    `pdk_for_node` BIGINT COMMENT 'FK to research.technology_node.technology_node_id — PDKs are developed for specific technology nodes. This is the fundamental organizing principle for PDK work.',
    `pdk_name` STRING COMMENT 'Human-readable name of the PDK, typically including technology node and variant information.',
    `pdk_targets_node` BIGINT COMMENT 'FK to research.technology_node.technology_node_id — Every PDK is developed for a specific technology node. This is the fundamental classification link that determines which design rules, SPICE models, and libraries are included.',
    `pdk_version` STRING COMMENT 'Version number of the PDK following semantic versioning convention (e.g., 1.0, 2.1.3). Tracks iterative improvements and updates.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `planned_release_date` DATE COMMENT 'Target date for releasing this PDK version, used for roadmap planning and customer commitments.',
    `predecessor_pdk_version` STRING COMMENT 'Version number of the previous PDK release that this version supersedes or builds upon.',
    `process_type` STRING COMMENT 'Semiconductor process technology type. CMOS for complementary metal-oxide-semiconductor, BiCMOS for bipolar CMOS, SOI for silicon-on-insulator, FDSOI for fully-depleted SOI, GaN for gallium nitride, SiGe for silicon-germanium.. Valid values are `cmos|bicmos|soi|fdsoi|gan|sige`',
    `release_date` DATE COMMENT 'Date when this PDK version was officially released to design teams or customers.',
    `release_notes` STRING COMMENT 'Summary of changes, enhancements, bug fixes, and known issues for this PDK version release.',
    `release_type` STRING COMMENT 'Classification of the PDK release maturity level. Alpha for early internal testing, beta for limited customer access, production for general availability, maintenance for updates, deprecated for end-of-life.. Valid values are `alpha|beta|production|maintenance|deprecated`',
    `supports_euv_lithography` BOOLEAN COMMENT 'Flag indicating whether this PDK supports EUV lithography for critical layers, typically required for advanced nodes below 7nm.',
    `synopsys_compatible` BOOLEAN COMMENT 'Flag indicating whether this PDK is compatible with Synopsys EDA tool suite including Design Compiler and PrimeTime.',
    `target_application` STRING COMMENT 'Primary application domain or market segment this PDK is optimized for, such as high-performance computing, mobile, automotive, IoT, or AI accelerators.',
    `validation_completion_date` DATE COMMENT 'Date when all validation activities for this PDK version were completed and signed off.',
    `validation_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of validation test cases completed successfully, ranging from 0.00 to 100.00.',
    `validation_start_date` DATE COMMENT 'Date when formal validation and verification activities for this PDK version began.',
    `validation_status` STRING COMMENT 'Current status of PDK validation activities including DRC/LVS rule verification, SPICE model correlation, and design flow testing.. Valid values are `not_started|in_progress|partial|complete|failed|waived`',
    CONSTRAINT pk_pdk_development PRIMARY KEY(`pdk_development_id`)
) COMMENT 'Process Design Kit (PDK) development records tracking the creation, versioning, and release of PDKs for new technology nodes. Captures PDK ID, associated technology node, PDK version, release type (alpha, beta, production), included components (DRC rules, LVS rules, SPICE models, standard cell libraries, design rule manual), EDA tool compatibility (Cadence Virtuoso, Synopsys), validation status, known issues log, release date, and PDK custodian. Critical interface between process R&D and IC design teams.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` (
    `research_milestone_id` BIGINT COMMENT 'Unique identifier for the research milestone record. Primary key for milestone tracking in R&D programs and projects.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the research milestone research entity.',
    `primary_research_approving_authority_employee_id` BIGINT COMMENT 'Employee identifier of the approving authority for audit trail and accountability purposes.',
    `primary_research_project_id` BIGINT COMMENT 'Reference to the parent research project or program to which this milestone belongs.',
    `project_id` BIGINT COMMENT 'Unique identifier for the primary project record within the research milestone research entity.',
    `research_program_id` BIGINT COMMENT 'Unique identifier for the research program record within the research milestone research entity.',
    `authoritative_design_milestone_id` BIGINT COMMENT 'Authoritative single-source-of-truth reference to owning entity design.design_milestone resolving the cross-domain SSOT duplicate with design.research_milestone.',
    `design_milestone_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner design.design_milestone (resolves MVM SSOT duplicate).',
    `action_items` STRING COMMENT 'List of follow-up actions, corrective measures, or conditions that must be addressed following the gate review. Particularly important for conditional pass outcomes.',
    `actual_completion_date` DATE COMMENT 'Actual date when the milestone was completed. Null if milestone is not yet completed. Used for schedule variance analysis and roadmap tracking.',
    `actual_date` DATE COMMENT 'The actual date associated with the research milestone research record.',
    `approving_authority_name` STRING COMMENT 'Name of the individual or committee responsible for approving the milestone completion and gate review outcome.',
    `baseline_date` DATE COMMENT 'Baseline date established at project approval or last formal re-baseline. Used to measure schedule performance against the approved plan.',
    `budget_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact or variance associated with this milestone, such as cost overruns, savings, or additional Non-Recurring Engineering (NRE) investment required.',
    `budget_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget impact amount.. Valid values are `^[A-Z]{3}$`',
    `chips_act_report_date` DATE COMMENT 'Date when the milestone completion was reported to CHIPS Act oversight authorities, if applicable.',
    `chips_act_reportable` BOOLEAN COMMENT 'Flag indicating whether this milestone must be reported to government authorities under CHIPS and Science Act compliance requirements for federally funded semiconductor research programs.',
    `collaboration_partner_involved` BOOLEAN COMMENT 'Flag indicating whether external collaboration partners (universities, research institutions, or industry partners) were involved in achieving this milestone.',
    `completion_criteria` STRING COMMENT 'Detailed description of the technical, business, or quality criteria that must be met for the milestone to be considered complete. Defines success conditions for gate reviews.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system.',
    `critical_path_indicator` BOOLEAN COMMENT 'Flag indicating whether this milestone is on the critical path of the project schedule. True if any delay to this milestone will delay the overall project completion.',
    `deliverable_description` STRING COMMENT 'Detailed description of the tangible deliverable or output associated with this milestone, such as design documentation, test results, prototype hardware, or qualification reports.',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number (ECCN) or ITAR category assigned to the milestone deliverables, if applicable.',
    `export_control_review_required` BOOLEAN COMMENT 'Flag indicating whether the milestone deliverables require export control review under International Traffic in Arms Regulations (ITAR) or Export Administration Regulations (EAR) before dissemination.',
    `gate_review_date` DATE COMMENT 'Date when the formal gate review was conducted and outcome was determined.',
    `gate_review_outcome` STRING COMMENT 'Result of the milestone gate review. Pass indicates all criteria met and project proceeds, conditional pass requires specific actions before proceeding, fail stops the project or phase, deferred postpones the decision, not reviewed indicates the review has not yet occurred.. Valid values are `pass|conditional_pass|fail|deferred|not_reviewed`',
    `ip_filing_triggered` BOOLEAN COMMENT 'Flag indicating whether this milestone triggered or enabled intellectual property filing activities, such as patent applications or trade secret documentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last updated, reflecting the most recent change to any field.',
    `milestone_code` STRING COMMENT 'Business identifier code for the milestone, typically following organizational naming conventions for gate reviews and technical milestones.. Valid values are `^[A-Z0-9]{4,20}$`',
    `milestone_name` STRING COMMENT 'Human-readable name of the milestone describing the key deliverable or gate review event.',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone indicating whether it is planned, actively being worked on, completed, deferred to a later date, or cancelled.. Valid values are `planned|in_progress|completed|deferred|cancelled`',
    `milestone_to_program` BIGINT COMMENT 'FK to research.rd_program.rd_program_id — Milestones track progress of R&D programs. Without this link, milestone tracking is disconnected from program governance.',
    `milestone_to_project` BIGINT COMMENT 'FK to research.research_project.research_project_id — Milestones can also track individual project progress. Projects have their own gate reviews independent of program-level milestones.',
    `milestone_type` STRING COMMENT 'Classification of the milestone indicating the nature of the review or deliverable. Technical gates assess technology readiness, management reviews evaluate business viability, customer demos validate market fit, tapeout marks design completion, silicon return confirms fabrication success, and qualification verifies production readiness.. Valid values are `technical_gate|management_review|customer_demo|tapeout|silicon_return|qualification`',
    `model_lineage_source` STRING COMMENT 'Indicates this product is a referrer in SSOT resolution; authoritative data lives in the owner product',
    `notes` STRING COMMENT 'The notes of the research milestone record in the research domain.',
    `planned_date` DATE COMMENT 'Originally scheduled date for milestone completion as defined in the project plan or technology roadmap.',
    `plm_system_reference` STRING COMMENT 'Reference identifier linking this milestone to the corresponding record in the Product Lifecycle Management system (Siemens Teamcenter PLM or Oracle Agile PLM) for traceability and document management.',
    `research_milestone_status` STRING COMMENT 'The status of the research milestone record in the research domain.',
    `review_meeting_minutes_url` STRING COMMENT 'URL or document management system path to the formal meeting minutes or review documentation for the gate review.',
    `risk_assessment` STRING COMMENT 'Summary of technical, schedule, and business risks identified at the milestone review, including mitigation strategies and residual risk levels.',
    `schedule_variance_days` STRING COMMENT 'Number of days the milestone completion deviated from the planned date. Positive values indicate delay, negative values indicate early completion.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the milestone concept (design.design_milestone)',
    `stakeholder_notification_sent` BOOLEAN COMMENT 'Flag indicating whether stakeholder notifications have been sent regarding the milestone completion or gate review outcome.',
    `technology_readiness_level` STRING COMMENT 'NASA Technology Readiness Level assessment at the time of milestone completion, ranging from 1 (basic principles observed) to 9 (actual system proven in operational environment). Critical for CHIPS Act reporting and technology maturity tracking.',
    CONSTRAINT pk_research_milestone PRIMARY KEY(`research_milestone_id`)
) COMMENT 'Milestone tracking records for R&D programs and projects capturing key technical and business gate reviews. Captures milestone ID, associated program or project, milestone name, milestone type (technical gate, management review, customer demo, tapeout, silicon return, qualification), planned date, actual completion date, completion criteria, gate review outcome (pass, conditional pass, fail, deferred), action items, and approving authority. Supports technology roadmap execution tracking and CHIPS Act program reporting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`publication` (
    `publication_id` BIGINT COMMENT 'Primary key for publication',
    `invention_disclosure_id` BIGINT COMMENT 'Identifier of the internal technology disclosure or invention disclosure associated with this publication.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the lead or corresponding author responsible for the publication.',
    `primary_publication_project_id` BIGINT COMMENT 'FK to research.project.project_id — Publications document results from specific research projects. This link supports IP strategy decisions and technology disclosure management.',
    `project_id` BIGINT COMMENT 'Unique identifier for the primary project record within the publication research entity.',
    `publication_author_employee_id` BIGINT COMMENT 'Unique identifier for the author employee record within the publication research entity.',
    `abstract` STRING COMMENT 'Summary or abstract of the publication content describing the research objectives, methods, and findings.',
    `acceptance_date` DATE COMMENT 'Date when the publication was accepted by the venue for publication or presentation.',
    `authors` STRING COMMENT 'Comma-separated list of authors who contributed to the publication, in citation order.',
    `citation_count` STRING COMMENT 'Number of times this publication has been cited by other research works, tracked for impact measurement.',
    `co_author_count` STRING COMMENT 'Total number of co-authors listed on the publication.',
    `publication_code` STRING COMMENT 'Business identifier or tracking code assigned to the publication for internal reference and cataloging.',
    `collaboration_partner_name` STRING COMMENT 'Name of external research institution, university, or industry partner involved in the collaborative research.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to the publication content.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the publication record was first created in the system.',
    `device_architecture_focus` STRING COMMENT 'Novel device architecture or structure discussed in the publication (e.g., FinFET, GAA, CFET, nanowire, nanosheet).',
    `doi` STRING COMMENT 'Digital Object Identifier assigned to the publication for permanent citation and retrieval.',
    `export_control_classification` STRING COMMENT 'Export control classification code (ECCN or USML category) assigned to the publication content.',
    `export_control_review_status` STRING COMMENT 'Status of export control review to ensure compliance with ITAR, EAR, and other export regulations before publication.. Valid values are `pending|cleared|restricted|denied`',
    `funding_source` STRING COMMENT 'Source of funding or sponsorship for the research work (e.g., internal R&D budget, government grant, CHIPS Act, industry consortium).',
    `internal_document_reference` STRING COMMENT 'Reference identifier or file path to the internal document repository where the publication manuscript is stored.',
    `isbn` STRING COMMENT 'ISBN assigned to the publication if applicable (for books or book chapters).',
    `issn` STRING COMMENT 'ISSN assigned to the journal or serial publication if applicable.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether the publication content is subject to ITAR export control restrictions.',
    `keywords` STRING COMMENT 'Comma-separated list of technical keywords or index terms associated with the publication for search and categorization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the publication record was last updated or modified.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the publication record in the research domain.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the publication, review feedback, or special considerations.',
    `open_access_flag` BOOLEAN COMMENT 'Indicates whether the publication is available as open access to the public.',
    `peer_review_status` STRING COMMENT 'Status of external peer review process for the publication.. Valid values are `not_applicable|pending|in_review|completed|approved|rejected`',
    `plm_system_reference` STRING COMMENT 'Reference identifier linking the publication to the PLM system for traceability to product development lifecycle.',
    `publication_date` DATE COMMENT 'Date when the publication was officially published or presented at the venue.',
    `publication_status` STRING COMMENT 'Current lifecycle status of the publication in the submission and review process. [ENUM-REF-CANDIDATE: draft|submitted|under_review|accepted|published|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `publication_type` STRING COMMENT 'Classification of the publication format and venue type. [ENUM-REF-CANDIDATE: conference_paper|journal_article|invited_talk|white_paper|poster|patent_disclosure|technical_report — 7 candidates stripped; promote to reference product]',
    `strategic_priority` STRING COMMENT 'Strategic importance level assigned to the publication for IP strategy and talent branding.. Valid values are `critical|high|medium|low`',
    `submission_date` DATE COMMENT 'Date when the publication was submitted to the venue for review.',
    `technology_disclosure_clearance_status` STRING COMMENT 'Status of internal IP clearance review to ensure publication does not disclose proprietary or patentable information prematurely.. Valid values are `pending|cleared|restricted|denied`',
    `technology_domain` STRING COMMENT 'Primary technology area or research domain covered by the publication (e.g., FinFET, GAA, CFET, advanced packaging, materials research).',
    `technology_node_focus` STRING COMMENT 'Process node or technology generation that is the focus of the publication (e.g., 3nm, 2nm, sub-1nm).',
    `title` STRING COMMENT 'Full title of the technical publication, conference paper, journal article, or white paper.',
    `url` STRING COMMENT 'Web URL or hyperlink to the published article or conference proceedings.',
    `venue` STRING COMMENT 'Name of the conference, journal, symposium, or publication outlet (e.g., IEEE IEDM, VLSI Symposium, Nature Electronics, ECTC).',
    `venue_type` STRING COMMENT 'Classification of the publication venue category.. Valid values are `conference|journal|symposium|workshop|webinar|internal`',
    CONSTRAINT pk_publication PRIMARY KEY(`publication_id`)
) COMMENT 'Records of technical publications, conference papers, and journal articles authored by R&D staff. Captures publication ID, title, authors, publication venue (IEEE IEDM, VLSI Symposium, Nature Electronics, ECTC), publication type (conference paper, journal article, invited talk, white paper), submission date, acceptance date, publication date, associated research project, technology disclosure clearance status, export control review status (ITAR/EAR), and citation tracking. Supports IP strategy, talent branding, and regulatory disclosure management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` (
    `budget_allocation_id` BIGINT COMMENT 'Primary key for budget_allocation',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record within the budget allocation research entity.',
    `employee_id` BIGINT COMMENT 'The employee identifier of the principal investigator responsible for the funded work.',
    `research_program_id` BIGINT COMMENT 'Reference to the R&D program receiving this budget allocation.',
    `project_id` BIGINT COMMENT 'Reference to the specific research project receiving this budget allocation, if applicable.',
    `tertiary_budget_employee_id` BIGINT COMMENT 'The user identifier of the person who last modified this budget allocation record.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the budget allocation record in the research domain.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'The allocation amount of the budget allocation record in the research domain.',
    `allocation_code` STRING COMMENT 'Business-readable unique code for the budget allocation, used for tracking and reporting purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `allocation_date` DATE COMMENT 'The date on which the budget allocation was officially recorded and assigned.',
    `allocation_name` STRING COMMENT 'Descriptive name of the budget allocation identifying the purpose or initiative being funded.',
    `allocation_status` STRING COMMENT 'The current lifecycle status of the budget allocation (e.g., draft, approved, active, on hold, completed, cancelled).. Valid values are `draft|approved|active|on_hold|completed|cancelled`',
    `approval_date` DATE COMMENT 'The date on which the budget allocation was approved by the approving authority.',
    `approving_authority_name` STRING COMMENT 'The name of the individual or committee that approved this budget allocation.',
    `award_amount` DECIMAL(18,2) COMMENT 'The total monetary amount awarded or allocated for this budget allocation.',
    `award_date` DATE COMMENT 'The date on which the funding award was officially granted or approved.',
    `budget_allocation_status` STRING COMMENT 'The status of the budget allocation record in the research domain.',
    `budget_category` STRING COMMENT 'The primary budget category for this allocation (e.g., headcount, equipment, materials, external services, fab costs, IP licensing).. Valid values are `headcount|equipment|materials|external_services|fab_costs|ip_licensing`',
    `budget_for_program` BIGINT COMMENT 'FK to research.program.program_id — Budget allocations fund R&D programs. Critical for financial tracking, CHIPS Act compliance reporting, and program cost management.',
    `budget_funds_program` BIGINT COMMENT 'FK to research.program.program_id — Budget allocations are assigned to R&D programs (and their constituent projects). This is essential for financial tracking and CHIPS Act compliance reporting.',
    `budget_period_end_date` DATE COMMENT 'The end date of the budget allocation period.',
    `budget_period_start_date` DATE COMMENT 'The start date of the budget allocation period.',
    `chips_act_award_number` STRING COMMENT 'The official CHIPS Act award number assigned by the granting agency, if applicable.. Valid values are `^CHIPS-[A-Z0-9]{8,16}$`',
    `chips_act_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget allocation is subject to CHIPS Act compliance requirements.',
    `collaboration_partner_name` STRING COMMENT 'The name of external collaboration partners (universities, research institutions, consortia) involved in the funded work, if applicable.',
    `compliance_obligations_description` STRING COMMENT 'Description of compliance obligations associated with this funding, including CHIPS Act requirements, ITAR, EAR, and other regulatory constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the award amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `deliverables_description` STRING COMMENT 'Description of the expected deliverables and milestones associated with this budget allocation.',
    `export_control_classification` STRING COMMENT 'The export control classification for the technology or research covered by this allocation (e.g., EAR99, ECCN, ITAR, NLR).. Valid values are `^(EAR99|ECCN [0-9][A-Z][0-9]{3}|ITAR|NLR)$`',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget allocation applies.',
    `funding_source_type` STRING COMMENT 'The type of funding source for this budget allocation.. Valid values are `government_grant|internal_rd_budget|consortium_contribution|customer_funded_nre|venture_capital|strategic_partnership`',
    `grant_program_name` STRING COMMENT 'The specific name of the grant program under which funding is provided (e.g., CHIPS for America R&D Program, DARPA ERI).',
    `grant_type` STRING COMMENT 'The type of government grant or funding mechanism (e.g., direct funding, tax credit, matching fund, equipment grant).. Valid values are `direct_funding|tax_credit|matching_fund|equipment_grant|research_contract|cooperative_agreement`',
    `granting_agency_name` STRING COMMENT 'The name of the government or external agency providing the grant funding, if applicable (e.g., DARPA, NSF, DOE, CHIPS Act office).',
    `itar_controlled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget allocation involves ITAR-controlled technology or data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget allocation record was last modified.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the budget allocation record in the research domain.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this budget allocation.',
    `performance_period_end_date` DATE COMMENT 'The end date of the performance period during which the funded work must be completed.',
    `performance_period_start_date` DATE COMMENT 'The start date of the performance period during which the funded work must be completed.',
    `reporting_requirements_description` STRING COMMENT 'Description of the reporting requirements and frequency mandated by the funding source or internal governance.',
    `risk_level` STRING COMMENT 'The assessed risk level associated with this budget allocation and the funded work.. Valid values are `low|medium|high|critical`',
    `spent_amount` DECIMAL(18,2) COMMENT 'The spent amount of the budget allocation record in the research domain.',
    `strategic_priority_level` STRING COMMENT 'The strategic priority level assigned to this budget allocation by executive leadership.. Valid values are `critical|high|medium|low`',
    `technical_scope_description` STRING COMMENT 'Detailed description of the technical scope and objectives covered by this budget allocation.',
    CONSTRAINT pk_budget_allocation PRIMARY KEY(`budget_allocation_id`)
) COMMENT 'R&D funding and budget allocation records tracking all approved funding assignments to R&D programs, projects, and collaborations — including government grants (CHIPS Act awards, DARPA contracts, NSF grants, DOE funding, international government R&D subsidies), internal R&D budgets, consortium contributions, and customer-funded NRE. Captures allocation ID, fiscal year, budget period, associated program or project, cost center, funding source and type, granting agency (for government funds), grant program name, grant type (direct funding, tax credit, matching fund, equipment grant), award amount, currency, award date, performance period, budget category (headcount, equipment, materials, external services, fab costs), technical scope, deliverables and reporting requirements, compliance obligations (CHIPS Act, ITAR, EAR), principal investigator, grant status, allocation date, and approving authority. SSOT for all R&D funding planning, tracking, government grant management, and compliance reporting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` (
    `packaging_research_id` BIGINT COMMENT 'Unique identifier for the advanced packaging technology research record.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - packaging research targets specific nodes',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: R&D tracks development of specific package types; linking to master package_type enables BOM, cost, and compliance traceability.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the packaging principal investigator employee record within the packaging research research entity.',
    `packaging_researcher_employee_id` BIGINT COMMENT 'Unique identifier for the packaging researcher employee record within the packaging research research entity.',
    `primary_packaging_principal_investigator_employee_id` BIGINT COMMENT 'Employee identifier of the principal investigator leading the packaging research.',
    `project_id` BIGINT COMMENT 'Unique identifier for the project record within the packaging research research entity.',
    `research_program_id` BIGINT COMMENT 'Reference to the parent R&D program under which this packaging research is conducted.',
    `actual_completion_date` DATE COMMENT 'Actual date when the packaging research project was completed or transitioned to production.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the NRE budget amounts.. Valid values are `^[A-Z]{3}$`',
    `chips_act_program_flag` BOOLEAN COMMENT 'Indicates whether this packaging research is funded or supported under the US CHIPS and Science Act program.',
    `collaboration_partner_name` STRING COMMENT 'Name of external collaboration partner (university, research institute, OSAT, foundry) involved in this packaging research.',
    `collaboration_type` STRING COMMENT 'Type of collaboration arrangement for the packaging research (internal, university partnership, OSAT joint development, foundry collaboration, industry consortium). [ENUM-REF-CANDIDATE: Internal|University|Research Institute|OSAT|Foundry|Joint Development|Consortium — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging research record was first created in the system.',
    `development_maturity_stage` STRING COMMENT 'Technology Readiness Level indicating the maturity stage of the packaging technology from basic research (TRL-1) to production-ready (TRL-9). [ENUM-REF-CANDIDATE: TRL-1|TRL-2|TRL-3|TRL-4|TRL-5|TRL-6|TRL-7|TRL-8|TRL-9 — 9 candidates stripped; promote to reference product]',
    `die_stack_count` STRING COMMENT 'Number of die layers in the vertical stack for 3D packaging architectures.',
    `experimental_lot_count` STRING COMMENT 'Number of experimental wafer or packaging lots processed as part of this research program.',
    `export_control_classification` STRING COMMENT 'Export control classification number (ECCN) or designation under EAR or other export regulations.',
    `integration_approach` STRING COMMENT 'The integration architecture approach for the packaging technology (2.5D interposer, 3D stacking, fan-out, chiplet-based heterogeneous integration).. Valid values are `2.5D|3D|Fan-Out|Chiplet|Heterogeneous|Monolithic`',
    `interconnect_density_target` DECIMAL(18,2) COMMENT 'Target interconnect density in connections per square millimeter for the packaging technology.',
    `interconnect_pitch_um` DECIMAL(18,2) COMMENT 'Target or achieved interconnect pitch in micrometers for bump, pillar, or TSV connections.',
    `ip_filing_count` STRING COMMENT 'Number of patent applications or IP disclosures filed related to this packaging research.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether this packaging research is subject to ITAR export control restrictions.',
    `key_technical_challenges` STRING COMMENT 'Description of the primary technical challenges and barriers being addressed in this packaging research (e.g., thermal management, warpage control, interconnect reliability, yield optimization).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging research record was last modified.',
    `metal_layer_count` STRING COMMENT 'Number of metal redistribution layers (RDL) in the packaging structure.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the packaging research record in the research domain.',
    `notes` STRING COMMENT 'The notes of the packaging research record in the research domain.',
    `nre_budget_allocated` DECIMAL(18,2) COMMENT 'Total non-recurring engineering budget allocated for this packaging research project.',
    `nre_budget_spent` DECIMAL(18,2) COMMENT 'Total non-recurring engineering budget spent to date on this packaging research project.',
    `package_size_x_mm` DECIMAL(18,2) COMMENT 'Package dimension in the X-axis in millimeters.',
    `package_size_y_mm` DECIMAL(18,2) COMMENT 'Package dimension in the Y-axis in millimeters.',
    `package_technology` STRING COMMENT 'The package technology of the packaging research record in the research domain.',
    `package_thickness_mm` DECIMAL(18,2) COMMENT 'Total package thickness in millimeters including all die, substrate, and encapsulation layers.',
    `packaging_research_status` STRING COMMENT 'The status of the packaging research record in the research domain.',
    `packaging_technology_name` STRING COMMENT 'Name of the advanced packaging technology under research (e.g., CoWoS-S, InFO-AiP, TSV-3D Stack).',
    `packaging_technology_type` STRING COMMENT 'Classification of the packaging technology platform being researched. [ENUM-REF-CANDIDATE: CoWoS|InFO|TSV|WLCSP|Chiplet|Fan-Out|Fan-In|Flip-Chip — 8 candidates stripped; promote to reference product]',
    `planned_completion_date` DATE COMMENT 'Planned date for completion of the packaging research project.',
    `reliability_qualification_status` STRING COMMENT 'Status of reliability qualification testing (HTOL, HAST, TC, etc.) for the packaging technology.. Valid values are `Not Started|In Progress|Passed|Failed|Waived`',
    `research_code` STRING COMMENT 'Coded value representing the research code of the packaging research research record.',
    `research_name` STRING COMMENT 'The research name of the packaging research record in the research domain.',
    `research_objective` STRING COMMENT 'The research objective of the packaging research record in the research domain.',
    `research_record_code` STRING COMMENT 'Business identifier code for the packaging research record, used for external reference and tracking.. Valid values are `^PKG-[A-Z0-9]{6,12}$`',
    `research_start_date` DATE COMMENT 'Date when the packaging research project officially started.',
    `research_status` STRING COMMENT 'Current lifecycle status of the packaging research project. [ENUM-REF-CANDIDATE: Concept|Feasibility|Proof-of-Concept|Development|Validation|Pilot|Qualified|On-Hold|Cancelled — 9 candidates stripped; promote to reference product]',
    `research_topic` STRING COMMENT 'The research topic of the packaging research record in the research domain.',
    `strategic_priority_level` STRING COMMENT 'Strategic importance ranking of this packaging research to the organizations technology roadmap.. Valid values are `Critical|High|Medium|Low`',
    `substrate_type` STRING COMMENT 'Type of substrate material used in the packaging technology (e.g., organic, silicon interposer, glass, ceramic).',
    `target_application` STRING COMMENT 'Primary application domain targeted by this packaging technology (High-Performance Computing, AI accelerator, mobile, automotive, IoT, networking).. Valid values are `HPC|AI Accelerator|Mobile|Automotive|IoT|Networking`',
    `test_vehicle_design_count` STRING COMMENT 'Number of test vehicle designs created and fabricated to validate the packaging technology.',
    `thermal_performance_target_w_per_cm2` DECIMAL(18,2) COMMENT 'Target thermal dissipation capability in watts per square centimeter for the packaging solution.',
    `thermal_resistance_target_c_per_w` DECIMAL(18,2) COMMENT 'Target junction-to-ambient thermal resistance in degrees Celsius per watt.',
    `warpage_target_um` DECIMAL(18,2) COMMENT 'Maximum allowable warpage in micrometers for the packaged assembly to ensure assembly yield and reliability.',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target assembly and packaging yield percentage for production readiness.',
    CONSTRAINT pk_packaging_research PRIMARY KEY(`packaging_research_id`)
) COMMENT 'Advanced packaging technology research records covering development of next-generation packaging architectures including CoWoS (Chip on Wafer on Substrate), InFO (Integrated Fan-Out), TSV-based 3D-IC stacking, WLCSP, and heterogeneous integration platforms. Captures research record ID, packaging technology name, integration approach (2.5D, 3D, fan-out, chiplet), target application (HPC, AI accelerator, mobile, automotive), key technical challenges, interconnect density targets, thermal performance targets, associated experimental lots, and development maturity stage.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` (
    `yield_learning_record_id` BIGINT COMMENT 'Unique identifier for the yield learning record. Primary key for this entity.',
    `experimental_lot_id` BIGINT COMMENT 'Identifier of the experimental wafer lot from which yield learning data was captured. Links to research fabrication lot tracking systems.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: YIELD ANALYSIS: Learning record captures yield data per product; supports continuous improvement and production planning.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Yield learning analyses are performed per package type; linking enables targeted process improvement actions.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the learning engineer responsible for this yield learning record.',
    `process_integration_run_id` BIGINT COMMENT 'Unique identifier for the process integration run record within the yield learning record research entity.',
    `research_program_id` BIGINT COMMENT 'Unique identifier for the research program record within the yield learning record research entity.',
    `project_id` BIGINT COMMENT 'Identifier of the research project under which this yield learning activity was conducted.',
    `tapeout_id` BIGINT COMMENT 'Identifier of the research tapeout associated with this yield learning record. References the design submission event.',
    `yield_engineer_employee_id` BIGINT COMMENT 'Unique identifier for the yield engineer employee record within the yield learning record research entity.',
    `analysis_date` DATE COMMENT 'Date on which the yield learning analysis was completed and findings were documented.',
    `baseline_yield_percent` DECIMAL(18,2) COMMENT 'The baseline yield percent of the yield learning record record in the research domain.',
    `baseline_yield_percentage` DECIMAL(18,2) COMMENT 'Yield percentage measured before corrective actions were implemented, used as the reference point for improvement calculations.',
    `collaboration_partner_involved` STRING COMMENT 'Name of external research institution, foundry, or equipment vendor involved in the yield learning activity, if applicable.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this yield learning record based on sensitivity and intellectual property considerations.. Valid values are `Public|Internal|Confidential|Restricted`',
    `corrective_action_proposed` STRING COMMENT 'Detailed description of the corrective process actions or improvements proposed to address the identified yield detractors.',
    `corrective_action_status` STRING COMMENT 'Current status of the proposed corrective action in the implementation lifecycle. [ENUM-REF-CANDIDATE: Proposed|Approved|In Progress|Implemented|Validated|Closed|Rejected — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this yield learning record was first created in the system.',
    `critical_defect_count` STRING COMMENT 'Number of defects classified as critical (yield-limiting) based on size, location, and impact on device functionality.',
    `current_yield_percent` DECIMAL(18,2) COMMENT 'The current yield percent of the yield learning record record in the research domain.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Average number of defects per square centimeter of wafer surface area, calculated from inspection data.',
    `defect_type_primary` STRING COMMENT 'Primary category of defect identified during yield analysis (e.g., particle contamination, pattern defect, electrical failure). [ENUM-REF-CANDIDATE: Particle|Pattern|Electrical|Scratch|Contamination|Lithography|Etch|Deposition|CMP|Implant|Other — 11 candidates stripped; promote to reference product]',
    `defect_type_secondary` STRING COMMENT 'Secondary category of defect contributing to yield loss, if applicable. [ENUM-REF-CANDIDATE: Particle|Pattern|Electrical|Scratch|Contamination|Lithography|Etch|Deposition|CMP|Implant|Other|None — 12 candidates stripped; promote to reference product]',
    `device_architecture_type` STRING COMMENT 'Type of transistor or device architecture used in the experimental lot (e.g., FinFET, Gate-All-Around, Complementary FET). [ENUM-REF-CANDIDATE: FinFET|GAA|CFET|Planar|Nanowire|Nanosheet|FDSOI|Other — 8 candidates stripped; promote to reference product]',
    `die_count_good` STRING COMMENT 'Number of dies that passed yield testing and are classified as good.',
    `die_count_total` STRING COMMENT 'Total number of dies across all wafers included in this yield learning record.',
    `die_yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of good dies per wafer measured during yield testing. Represents the ratio of functional dies to total dies on the wafer.',
    `dominant_detractor` STRING COMMENT 'The dominant detractor of the yield learning record record in the research domain.',
    `dominant_yield_detractor` STRING COMMENT 'Primary mechanism or defect type identified as the leading cause of yield loss in this experimental lot or tapeout.',
    `equipment_id_affected` STRING COMMENT 'Identifier of the specific fabrication equipment tool associated with the yield detractor, if applicable.',
    `export_control_classification` STRING COMMENT 'Export control classification for the yield learning data and associated technology (e.g., EAR99, ITAR, ECCN code).. Valid values are `EAR99|ITAR|ECCN [0-9][A-Z][0-9]{3}|Not Controlled`',
    `functional_yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of dies that pass functional testing and meet all electrical specifications. Subset of die yield focusing on operational performance.',
    `inspection_system_used` STRING COMMENT 'Name or identifier of the defect inspection and metrology system used to capture yield and defect data (e.g., KLA ICOS, optical inspection tool).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this yield learning record was last updated or modified.',
    `learning_cycle_number` STRING COMMENT 'The learning cycle number of the yield learning record record in the research domain.',
    `learning_cycle_phase` STRING COMMENT 'Current phase of the yield learning cycle for this record (e.g., initial assessment, root cause analysis, corrective action, validation).. Valid values are `Initial Assessment|Root Cause Analysis|Corrective Action|Validation|Closed`',
    `learning_engineer_name` STRING COMMENT 'Name of the process integration or yield engineer responsible for conducting the yield learning analysis and documenting findings.',
    `learning_summary` STRING COMMENT 'The learning summary of the yield learning record record in the research domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the yield learning record record in the research domain.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context related to the yield learning analysis and findings.',
    `pareto_analysis_performed_flag` BOOLEAN COMMENT 'Indicates whether Pareto analysis was performed to prioritize yield detractors by impact.',
    `process_step_affected` STRING COMMENT 'Specific fabrication process step (e.g., lithography, etch, deposition, CMP) identified as the source of yield loss.',
    `production_applicability_flag` BOOLEAN COMMENT 'Indicates whether the yield learning findings and corrective actions are applicable to production wafer lots and yield ramp planning.',
    `production_integration_date` DATE COMMENT 'Date on which the yield learning findings and corrective actions were integrated into production process flows.',
    `record_date` DATE COMMENT 'The record date associated with the yield learning record research record.',
    `record_status` STRING COMMENT 'The record status of the yield learning record record in the research domain.',
    `root_cause_analysis_findings` STRING COMMENT 'Detailed findings from root cause analysis identifying the underlying process, equipment, or material issues causing yield loss.',
    `root_cause_category` STRING COMMENT 'High-level category of the identified root cause (e.g., process variation, equipment malfunction, material defect, design issue). [ENUM-REF-CANDIDATE: Process|Equipment|Material|Design|Handling|Environmental|Unknown — 7 candidates stripped; promote to reference product]',
    `statistical_confidence_level` STRING COMMENT 'Confidence level in the statistical validity of the yield learning findings based on sample size and data quality.. Valid values are `High|Medium|Low`',
    `technology_node_nm` STRING COMMENT 'Process technology node in nanometers at which the experimental lot or tapeout was fabricated (e.g., 7, 5, 3, 2).',
    `wafer_count` STRING COMMENT 'Number of wafers included in the yield learning analysis for this record.',
    `yield_improvement_delta_percentage` DECIMAL(18,2) COMMENT 'Measured improvement in yield percentage achieved after implementing corrective actions, compared to baseline yield.',
    `yield_learning_record_status` STRING COMMENT 'The status of the yield learning record record in the research domain.',
    `yield_percent` DECIMAL(18,2) COMMENT 'The yield percent of the yield learning record record in the research domain.',
    CONSTRAINT pk_yield_learning_record PRIMARY KEY(`yield_learning_record_id`)
) COMMENT 'Yield learning records from experimental lots and research tapeouts capturing defect analysis, yield limiting mechanisms, and process improvement findings. Captures record ID, associated experimental lot or tapeout, technology node, yield measurement (die yield percentage, functional yield), dominant yield detractors, defect types identified (particle, pattern, electrical), root cause analysis findings, corrective process actions proposed, yield improvement delta achieved, and learning engineer. Feeds process integration improvement cycles and production yield ramp planning.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` (
    `competitive_benchmark_id` BIGINT COMMENT 'Primary key for competitive_benchmark',
    `employee_id` BIGINT COMMENT 'Employee identifier of the research analyst who conducted the benchmark analysis.',
    `competitive_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this competitive benchmark record.',
    `research_program_id` BIGINT COMMENT 'Reference to the R&D program that commissioned or utilizes this competitive benchmark analysis.',
    `research_technology_node_id` BIGINT COMMENT 'Unique identifier for the research technology node record within the competitive benchmark research entity.',
    `technology_roadmap_id` BIGINT COMMENT 'Reference to the technology roadmap that this competitive benchmark supports or informs.',
    `approval_date` DATE COMMENT 'Date when the competitive benchmark analysis was formally approved for use in strategic planning and roadmap decisions.',
    `approved_by_name` STRING COMMENT 'Name of the authority who approved the competitive benchmark analysis for official use.',
    `benchmark_code` STRING COMMENT 'Business identifier code for the competitive benchmark analysis, used for external reference and tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `benchmark_date` DATE COMMENT 'Date when the competitive benchmark analysis was conducted or published.',
    `benchmark_methodology` STRING COMMENT 'Detailed description of the methodology used to conduct the competitive benchmark, including measurement techniques, test conditions, and analytical approaches.',
    `benchmark_metric` STRING COMMENT 'The benchmark metric of the competitive benchmark record in the research domain.',
    `benchmark_name` STRING COMMENT 'Descriptive name of the competitive benchmark analysis, typically including the technology node or device architecture being compared.',
    `benchmark_source_reference` STRING COMMENT 'Detailed citation or reference to the source document, publication, or analysis from which the benchmark data was derived.',
    `benchmark_source_type` STRING COMMENT 'The type of source from which the competitive benchmark data was obtained, such as public disclosure, teardown analysis, academic paper, or industry report.. Valid values are `Public Disclosure|Teardown Analysis|Published Paper|Industry Report|Conference Presentation|Patent Filing`',
    `benchmark_status` STRING COMMENT 'Current lifecycle status of the competitive benchmark record, indicating whether it is in draft, under review, approved for use, or archived.. Valid values are `Draft|In Review|Approved|Archived|Superseded`',
    `competitive_benchmark_status` STRING COMMENT 'The status of the competitive benchmark record in the research domain.',
    `competitive_gap_analysis` STRING COMMENT 'Assessment of the performance gap between internal technology capabilities and competitor offerings, identifying areas of advantage or disadvantage.',
    `competitor_name` STRING COMMENT 'Name of the competitor company or foundry whose technology is being benchmarked against internal capabilities.',
    `competitor_product_name` STRING COMMENT 'Specific product, chip, or technology offering from the competitor that is the subject of this benchmark.',
    `competitor_value` DECIMAL(18,2) COMMENT 'The competitor value of the competitive benchmark record in the research domain.',
    `confidence_level` STRING COMMENT 'Assessment of the confidence level in the benchmark data accuracy and reliability, based on source quality and verification methods.. Valid values are `High|Medium|Low|Preliminary`',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this competitive benchmark record.. Valid values are `Public|Internal|Confidential|Restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitive benchmark record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Numerical score from 1 to 100 representing the overall quality and reliability of the benchmark data, based on source credibility and verification.',
    `device_architecture_type` STRING COMMENT 'Type of transistor or device architecture being benchmarked, such as FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), CFET (Complementary FET), or other advanced structures. [ENUM-REF-CANDIDATE: FinFET|GAA|CFET|Planar|Nanowire|Nanosheet|FDSOI|Other — 8 candidates stripped; promote to reference product]',
    `drive_current_ua_per_um` DECIMAL(18,2) COMMENT 'On-state drive current of the competitor device normalized per unit width, measured in microamperes per micrometer, indicating performance capability.',
    `export_control_classification` STRING COMMENT 'Export control classification of the benchmark data under US Export Administration Regulations (EAR) or International Traffic in Arms Regulations (ITAR).. Valid values are `EAR99|ECCN [0-9][A-Z][0-9]{3}|ITAR|Public|Unclassified`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitive benchmark record was last updated or modified.',
    `leakage_current_na_per_um` DECIMAL(18,2) COMMENT 'Off-state leakage current of the competitor device normalized per unit width, measured in nanoamperes per micrometer, indicating power efficiency.',
    `metric_name` STRING COMMENT 'The metric name of the competitive benchmark record in the research domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the competitive benchmark record in the research domain.',
    `notes` STRING COMMENT 'Additional notes, observations, or context regarding the competitive benchmark analysis that do not fit into structured fields.',
    `operating_frequency_ghz` DECIMAL(18,2) COMMENT 'Maximum operating frequency of the competitor technology in gigahertz, a key performance metric.',
    `our_value` DECIMAL(18,2) COMMENT 'The our value of the competitive benchmark record in the research domain.',
    `power_consumption_mw` DECIMAL(18,2) COMMENT 'Measured or estimated power consumption of the competitor technology in milliwatts under specified operating conditions.',
    `ppa_area_score` DECIMAL(18,2) COMMENT 'Area efficiency score for the competitor technology based on PPA analysis, normalized to a standard scale.',
    `ppa_performance_score` DECIMAL(18,2) COMMENT 'Composite performance score for the competitor technology based on Power, Performance, and Area metrics, normalized to a standard scale.',
    `ppa_power_score` DECIMAL(18,2) COMMENT 'Power efficiency score for the competitor technology based on PPA analysis, normalized to a standard scale.',
    `strategic_implication_assessment` STRING COMMENT 'Analysis of the strategic implications of the benchmark findings for internal technology roadmap decisions, competitive positioning, and investment priorities.',
    `technology_node_compared` STRING COMMENT 'The technology node compared of the competitive benchmark record in the research domain.',
    `technology_node_nm` STRING COMMENT 'The process technology node in nanometers being benchmarked (e.g., 5, 3, 2 for 5nm, 3nm, 2nm nodes).',
    `technology_readiness_level` STRING COMMENT 'Assessment of the maturity level of the competitor technology being benchmarked, using the standard TRL scale from basic research to production-ready. [ENUM-REF-CANDIDATE: TRL 1|TRL 2|TRL 3|TRL 4|TRL 5|TRL 6|TRL 7|TRL 8|TRL 9 — promote to reference product]. Valid values are `TRL 1|TRL 2|TRL 3|TRL 4|TRL 5|TRL 6`',
    `transistor_density_mtransistors_per_mm2` DECIMAL(18,2) COMMENT 'Measured or estimated transistor density of the competitor technology in millions of transistors per square millimeter, a key metric for area efficiency.',
    CONSTRAINT pk_competitive_benchmark PRIMARY KEY(`competitive_benchmark_id`)
) COMMENT 'Competitive technology benchmarking records tracking performance comparisons of internal technology nodes and device architectures against competitor and foundry offerings. Captures benchmark ID, benchmark date, technology node or device architecture being benchmarked, competitor or foundry reference, benchmark source (public disclosure, teardown analysis, published paper, industry report), PPA metrics compared (transistor density, drive current, leakage, frequency, power), benchmark methodology, confidence level, and strategic implication assessment. Supports technology roadmap decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`government_grant` (
    `government_grant_id` BIGINT COMMENT 'System-generated unique identifier for the government grant record.',
    `chips_act_obligation_id` BIGINT COMMENT 'Unique identifier for the chips act obligation record within the government grant research entity.',
    `employee_id` BIGINT COMMENT 'Internal employee identifier for the principal investigator.',
    `government_principal_investigator_employee_id` BIGINT COMMENT 'Unique identifier for the government principal investigator employee record within the government grant research entity.',
    `research_program_id` BIGINT COMMENT 'Unique identifier for the research program record within the government grant research entity.',
    `agency_name` STRING COMMENT 'The agency name of the government grant record in the research domain.',
    `award_amount` DECIMAL(18,2) COMMENT 'Total monetary value awarded by the granting agency.',
    `award_date` DATE COMMENT 'Date on which the grant award was officially issued.',
    `awarding_agency` STRING COMMENT 'Name of the government agency providing the grant.',
    `chips_act_award_number` STRING COMMENT 'Unique identifier assigned by the CHIPS Act program for this award.',
    `chips_act_compliance_flag` BOOLEAN COMMENT 'True if the grant must satisfy CHIPS Act reporting requirements.',
    `compliance_obligations` STRING COMMENT 'Regulatory and export‑control obligations attached to the grant.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the grant record.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grant record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the award currency.',
    `deliverables_description` STRING COMMENT 'List of required deliverables (reports, prototypes, patents) for the grant.',
    `effective_from` DATE COMMENT 'Date when the grant becomes effective for the recipient.',
    `effective_until` DATE COMMENT 'Date when the grant expires or ends its validity.',
    `export_control_classification` STRING COMMENT 'Export control regime applicable to the grant (e.g., EAR, ITAR).. Valid values are `EAR|ITAR|None`',
    `funding_source` STRING COMMENT 'Origin of the funding (e.g., CHIPS Act, DARPA, NSF, DOE).',
    `government_grant_status` STRING COMMENT 'Current lifecycle status of the grant.. Valid values are `active|closed|suspended|pending|withdrawn`',
    `grant_category` STRING COMMENT 'High‑level classification of the grant purpose.. Valid values are `research|infrastructure|equipment|collaboration`',
    `grant_number` STRING COMMENT 'External reference number assigned by the granting agency.',
    `grant_status` STRING COMMENT 'The grant status of the government grant record in the research domain.',
    `grant_title` STRING COMMENT 'Official title of the grant as recorded in the award documentation.',
    `grant_to_program` BIGINT COMMENT 'FK to research.rd_program.rd_program_id — Government grants fund specific R&D programs. Essential for CHIPS Act compliance reporting and funding traceability.',
    `grant_type` STRING COMMENT 'Category of the grant indicating the funding mechanism.. Valid values are `direct_funding|tax_credit|matching_fund|equipment_grant`',
    `granting_agency` STRING COMMENT 'The granting agency of the government grant record in the research domain.',
    `granting_agency_name` STRING COMMENT 'The granting agency name of the government grant record in the research domain.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the grant is subject to ITAR restrictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grant record.',
    `matching_fund_amount` DECIMAL(18,2) COMMENT 'Amount of matching funds required from the recipient, if applicable.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the government grant record in the research domain.',
    `notes` STRING COMMENT 'The notes of the government grant record in the research domain.',
    `performance_end_date` DATE COMMENT 'End date of the performance period for the grant.',
    `performance_period_end_date` DATE COMMENT 'The performance period end date associated with the government grant research record.',
    `performance_period_start_date` DATE COMMENT 'The performance period start date associated with the government grant research record.',
    `performance_start_date` DATE COMMENT 'Start date of the performance period for the grant.',
    `principal_investigator_department` STRING COMMENT 'Organizational department or research unit of the principal investigator.',
    `principal_investigator_email` STRING COMMENT 'Corporate email address of the principal investigator.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `principal_investigator_name` STRING COMMENT 'Full legal name of the lead researcher responsible for the grant.',
    `program_name` STRING COMMENT 'Name of the specific grant program or initiative.',
    `reporting_requirements` STRING COMMENT 'Frequency and format of progress reports required by the agency.',
    `tax_credit_amount` DECIMAL(18,2) COMMENT 'Monetary value of any tax credit associated with the grant.',
    `technical_scope` STRING COMMENT 'Brief description of the technical objectives and research areas covered by the grant.',
    CONSTRAINT pk_government_grant PRIMARY KEY(`government_grant_id`)
) COMMENT 'Government research grant and funding program records including CHIPS Act awards, DARPA contracts, NSF grants, DOE funding, and international government R&D subsidies. Captures grant ID, granting agency, program name, grant type (direct funding, tax credit, matching fund, equipment grant), award amount, currency, award date, performance period, technical scope, deliverables and reporting requirements, compliance obligations, principal investigator, and grant status. Supports CHIPS Act compliance reporting and R&D capitalization tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` (
    `process_flow_experiment_id` BIGINT COMMENT 'System-generated unique identifier for the experimental process flow record.',
    `experimental_lot_id` BIGINT COMMENT 'Identifier of the experimental wafer lot associated with this flow.',
    `fabrication_process_flow_id` BIGINT COMMENT 'Unique identifier for the fabrication process flow record within the process flow experiment research entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary engineer employee record within the process flow experiment research entity.',
    `primary_process_author_employee_id` BIGINT COMMENT 'Identifier of the employee who authored the flow.',
    `process_engineer_employee_id` BIGINT COMMENT 'Unique identifier for the process engineer employee record within the process flow experiment research entity.',
    `project_id` BIGINT COMMENT 'Unique identifier for the process project record within the process flow experiment research entity.',
    `process_research_project_id` BIGINT COMMENT 'Reference to the research project that owns this flow.',
    `research_program_id` BIGINT COMMENT 'Reference to the research program under which this flow is executed.',
    `actual_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Measured total processing time after execution.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Measured die yield percentage after execution.',
    `approval_status` STRING COMMENT 'Current approval state of the flow.. Valid values are `approved|pending|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the flow was approved.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the flow with industry standards.. Valid values are `compliant|non_compliant|pending`',
    `confidentiality_level` STRING COMMENT 'Data classification for the flow record.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the flow record was created.',
    `process_flow_experiment_description` STRING COMMENT 'Detailed free‑text description of the experimental flow.',
    `doe_design_type` STRING COMMENT 'The doe design type of the process flow experiment record in the research domain.',
    `doe_split_details` STRING COMMENT 'Details of the DOE split (e.g., factor levels, randomization).',
    `doe_split_flag` BOOLEAN COMMENT 'Indicates whether the flow includes a DOE split.',
    `equipment_type` STRING COMMENT 'Category of equipment used (e.g., CVD, PVD, ALD, EUV, DUV, CMP, Lithography, Etch, Implant). [ENUM-REF-CANDIDATE: CVD|PVD|ALD|EUV|DUV|CMP|Lithography|Etch|Implant — promote to reference product]',
    `expected_yield_percent` DECIMAL(18,2) COMMENT 'Target die yield percentage anticipated for the flow.',
    `experiment_code` STRING COMMENT 'Coded value representing the experiment code of the process flow experiment research record.',
    `experiment_name` STRING COMMENT 'The experiment name of the process flow experiment record in the research domain.',
    `experiment_status` STRING COMMENT 'The experiment status of the process flow experiment record in the research domain.',
    `export_control_classification` STRING COMMENT 'Export control regime applicable to the flow.. Valid values are `EAR|ITAR|None`',
    `flow_code` STRING COMMENT 'Human‑readable unique code for the experiment (e.g., PFX‑2023‑001).',
    `flow_name` STRING COMMENT 'Descriptive name of the experimental process flow.',
    `flow_revision` STRING COMMENT 'The flow revision of the process flow experiment record in the research domain.',
    `flow_type` STRING COMMENT 'Classification of the flow purpose (research, pilot, etc.).. Valid values are `research|pilot|proof_of_concept|exploratory`',
    `flow_variant_description` STRING COMMENT 'The flow variant description of the process flow experiment record in the research domain.',
    `flow_version` STRING COMMENT 'Version identifier for the flow (e.g., v1, v2).',
    `itar_controlled_flag` BOOLEAN COMMENT 'True if the flow is subject to ITAR restrictions.',
    `key_process_parameters` STRING COMMENT 'Critical parameters (temperature, pressure, time) for each step, stored as JSON or delimited text.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the flow record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the process flow experiment record in the research domain.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the experimental flow.',
    `process_flow_complexity_score` STRING COMMENT 'Numeric score representing the overall complexity of the flow (higher = more complex).',
    `process_flow_experiment_status` STRING COMMENT 'Current lifecycle status of the experimental flow.. Valid values are `draft|active|inactive|archived|pending_approval|rejected`',
    `process_pressure_pa` DECIMAL(18,2) COMMENT 'Operating pressure for the process step(s).',
    `process_step_sequence` STRING COMMENT 'Ordered list of process steps (e.g., FEOL→MOL→BEOL) encoded as a delimited string.',
    `process_temperature_c` DECIMAL(18,2) COMMENT 'Operating temperature for the process step(s).',
    `risk_level` STRING COMMENT 'Risk assessment rating for the experimental flow.. Valid values are `low|medium|high|critical`',
    `split_conditions` STRING COMMENT 'Design‑of‑Experiments split criteria for the flow, stored as JSON or delimited text.',
    `split_count` STRING COMMENT 'The split count of the process flow experiment record in the research domain.',
    `target_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Planned total processing time for the flow.',
    `target_device_structure` STRING COMMENT 'Intended device architecture (e.g., FinFET, GAA) for the flow.',
    `technology_node` STRING COMMENT 'Target technology node for the experimental flow.. Valid values are `3nm|5nm|7nm|10nm|14nm|28nm`',
    `tool_identifier` STRING COMMENT 'Unique identifier or serial number of the equipment tool used.',
    `total_steps` STRING COMMENT 'Count of distinct steps in the experimental flow.',
    CONSTRAINT pk_process_flow_experiment PRIMARY KEY(`process_flow_experiment_id`)
) COMMENT 'Experimental process flow records defining the sequence of process steps for a research wafer lot or process integration experiment. Captures flow ID, associated technology node, flow version, process step sequence (FEOL, MOL, BEOL), each step name and tool type, key process parameters per step, split conditions for DOE (Design of Experiments) splits, target device structures, flow author, and flow approval status. Distinct from production process flows managed in the process domain — these are research-grade exploratory flows.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` (
    `program_partner_collaboration_id` BIGINT COMMENT 'Primary key',
    `channel_partner_id` BIGINT COMMENT 'FK to channel partner',
    `collaboration_id` BIGINT COMMENT 'FK to collaboration',
    `account_id` BIGINT COMMENT 'Unique identifier for the partner account record within the program partner collaboration research entity.',
    `research_program_id` BIGINT COMMENT 'FK to research program',
    `agreement_end_date` DATE COMMENT 'The agreement end date associated with the program partner collaboration research record.',
    `agreement_reference` STRING COMMENT 'The agreement reference of the program partner collaboration record in the research domain.',
    `agreement_start_date` DATE COMMENT 'The agreement start date associated with the program partner collaboration research record.',
    `collaboration_end_date` DATE COMMENT 'The collaboration end date associated with the program partner collaboration research record.',
    `collaboration_notes` STRING COMMENT 'The collaboration notes of the program partner collaboration record in the research domain.',
    `collaboration_role` STRING COMMENT 'The collaboration role of the program partner collaboration record in the research domain.',
    `collaboration_scope` STRING COMMENT 'The collaboration scope of the program partner collaboration record in the research domain.',
    `collaboration_start_date` DATE COMMENT 'The collaboration start date associated with the program partner collaboration research record.',
    `collaboration_status` STRING COMMENT 'The collaboration status of the program partner collaboration record in the research domain.',
    `collaboration_type` STRING COMMENT 'The collaboration type of the program partner collaboration record in the research domain.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level of the program partner collaboration record in the research domain.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'The contribution amount of the program partner collaboration record in the research domain.',
    `contribution_currency_code` STRING COMMENT 'Coded value representing the contribution currency code of the program partner collaboration research record.',
    `contribution_pct` DECIMAL(18,2) COMMENT 'Contribution percentage',
    `contribution_type` STRING COMMENT 'The contribution type of the program partner collaboration record in the research domain.',
    `created_at` TIMESTAMP COMMENT 'The created at of the program partner collaboration record in the research domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the program partner collaboration record in the research domain.',
    `deliverable_description` STRING COMMENT 'The deliverable description of the program partner collaboration record in the research domain.',
    `deliverables` STRING COMMENT 'The deliverables of the program partner collaboration record in the research domain.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the program partner collaboration research record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the program partner collaboration research record.',
    `end_date` DATE COMMENT 'The end date associated with the program partner collaboration research record.',
    `funding_contribution_usd` DECIMAL(18,2) COMMENT 'The funding contribution usd of the program partner collaboration record in the research domain.',
    `funding_share_pct` DECIMAL(18,2) COMMENT 'Funding share percentage',
    `governance_model` STRING COMMENT 'The governance model of the program partner collaboration record in the research domain.',
    `governing_agreement_ref` STRING COMMENT 'The governing agreement ref of the program partner collaboration record in the research domain.',
    `ip_ownership_split_pct` DECIMAL(18,2) COMMENT 'The ip ownership split pct of the program partner collaboration record in the research domain.',
    `ip_ownership_terms` STRING COMMENT 'The ip ownership terms of the program partner collaboration record in the research domain.',
    `ip_sharing_terms` STRING COMMENT 'The ip sharing terms of the program partner collaboration record in the research domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the program partner collaboration record in the research domain.',
    `milestone_count` STRING COMMENT 'The milestone count of the program partner collaboration record in the research domain.',
    `milestone_schedule` STRING COMMENT 'The milestone schedule of the program partner collaboration record in the research domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the program partner collaboration record in the research domain.',
    `notes` STRING COMMENT 'The notes of the program partner collaboration record in the research domain.',
    `partner_contribution_type` STRING COMMENT 'The partner contribution type of the program partner collaboration record in the research domain.',
    `partner_organization` STRING COMMENT 'The partner organization of the program partner collaboration record in the research domain.',
    `partner_organization_name` STRING COMMENT 'The partner organization name of the program partner collaboration record in the research domain.',
    `partner_role` STRING COMMENT 'The partner role of the program partner collaboration record in the research domain.',
    `partner_type` STRING COMMENT 'The partner type of the program partner collaboration record in the research domain.',
    `primary_contact_name` STRING COMMENT 'The primary contact name of the program partner collaboration record in the research domain.',
    `program_partner_collaboration_status` STRING COMMENT 'The status of the program partner collaboration record in the research domain.',
    `resource_commitment_fte` STRING COMMENT 'The resource commitment fte of the program partner collaboration record in the research domain.',
    `start_date` DATE COMMENT 'The start date associated with the program partner collaboration research record.',
    `updated_at` TIMESTAMP COMMENT 'The updated at of the program partner collaboration record in the research domain.',
    CONSTRAINT pk_program_partner_collaboration PRIMARY KEY(`program_partner_collaboration_id`)
) COMMENT 'Represents the operational agreement between a sales channel partner and an R&D program. Each record links one channel_partner to one rd_program and stores attributes that belong exclusively to the partnership.. Existence Justification: Channel partners (distributors, VARs, system integrators) actively collaborate with multiple R&D programs, and each R&D program can involve multiple channel partners. The business records a collaboration agreement per partner‑program pair, capturing the partners role and a unique agreement identifier, which is managed and updated by stakeholders.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` (
    `compliance_assessment_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to assessor employee',
    `project_id` BIGINT COMMENT 'FK to project',
    `compliance_remediation_owner_employee_id` BIGINT COMMENT 'Unique identifier for the compliance remediation owner employee record within the compliance assessment research entity.',
    `compliance_research_project_id` BIGINT COMMENT 'FK to research project',
    `export_license_id` BIGINT COMMENT 'Unique identifier for the export license record within the compliance assessment research entity.',
    `obligation_register_id` BIGINT COMMENT 'FK to obligation register',
    `research_program_id` BIGINT COMMENT 'FK to research program',
    `approval_status` STRING COMMENT 'The approval status of the compliance assessment record in the research domain.',
    `approved_flag` BOOLEAN COMMENT 'The approved flag of the compliance assessment record in the research domain.',
    `assessed_date` DATE COMMENT 'The assessed date associated with the compliance assessment research record.',
    `assessment_code` STRING COMMENT 'Coded value representing the assessment code of the compliance assessment research record.',
    `assessment_date` DATE COMMENT 'The assessment date associated with the compliance assessment research record.',
    `assessment_notes` STRING COMMENT 'The assessment notes of the compliance assessment record in the research domain.',
    `assessment_result` STRING COMMENT 'The assessment result of the compliance assessment record in the research domain.',
    `assessment_score` STRING COMMENT 'The assessment score of the compliance assessment record in the research domain.',
    `assessment_status` STRING COMMENT 'The assessment status of the compliance assessment record in the research domain.',
    `assessment_type` STRING COMMENT 'The assessment type of the compliance assessment record in the research domain.',
    `assessor` STRING COMMENT 'The assessor of the compliance assessment record in the research domain.',
    `assessor_name` STRING COMMENT 'The assessor name of the compliance assessment record in the research domain.',
    `completion_date` DATE COMMENT 'The completion date associated with the compliance assessment research record.',
    `compliance_assessment_status` STRING COMMENT 'The status of the compliance assessment record in the research domain.',
    `compliance_result` STRING COMMENT 'The compliance result of the compliance assessment record in the research domain.',
    `compliance_status` STRING COMMENT 'The compliance status of the compliance assessment record in the research domain.',
    `corrective_actions` STRING COMMENT 'The corrective actions of the compliance assessment record in the research domain.',
    `created_at` TIMESTAMP COMMENT 'The created at of the compliance assessment record in the research domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the compliance assessment record in the research domain.',
    `due_date` DATE COMMENT 'The due date associated with the compliance assessment research record.',
    `evidence_documentation` STRING COMMENT 'The evidence documentation of the compliance assessment record in the research domain.',
    `evidence_reference` STRING COMMENT 'The evidence reference of the compliance assessment record in the research domain.',
    `export_control_classification` STRING COMMENT 'The export control classification of the compliance assessment record in the research domain.',
    `finding_summary` STRING COMMENT 'The finding summary of the compliance assessment record in the research domain.',
    `findings` STRING COMMENT 'The findings of the compliance assessment record in the research domain.',
    `findings_summary` STRING COMMENT 'The findings summary of the compliance assessment record in the research domain.',
    `gap_description` STRING COMMENT 'The gap description of the compliance assessment record in the research domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the compliance assessment record in the research domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the compliance assessment record in the research domain.',
    `next_review_date` DATE COMMENT 'The next review date associated with the compliance assessment research record.',
    `notes` STRING COMMENT 'The notes of the compliance assessment record in the research domain.',
    `regulation_reference` STRING COMMENT 'The regulation reference of the compliance assessment record in the research domain.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework of the compliance assessment record in the research domain.',
    `remediation_due_date` DATE COMMENT 'The remediation due date associated with the compliance assessment research record.',
    `remediation_notes` STRING COMMENT 'The remediation notes of the compliance assessment record in the research domain.',
    `remediation_plan` STRING COMMENT 'The remediation plan of the compliance assessment record in the research domain.',
    `remediation_required` BOOLEAN COMMENT 'The remediation required of the compliance assessment record in the research domain.',
    `result` STRING COMMENT 'The result of the compliance assessment record in the research domain.',
    `reviewer` STRING COMMENT 'The reviewer of the compliance assessment record in the research domain.',
    `risk_level` STRING COMMENT 'The risk level of the compliance assessment record in the research domain.',
    `risk_rating` STRING COMMENT 'The risk rating of the compliance assessment record in the research domain.',
    `updated_at` TIMESTAMP COMMENT 'The updated at of the compliance assessment record in the research domain.',
    CONSTRAINT pk_compliance_assessment PRIMARY KEY(`compliance_assessment_id`)
) COMMENT 'Represents the assessment of a specific regulatory or standards obligation for a given research project. Each record links one project to one obligation and stores data that belongs to the assessment itself.. Existence Justification: Each research project must satisfy multiple regulatory obligations, and each obligation can apply to many projects across the organization. The compliance team records an assessment for every project‑obligation pair, capturing the assessment date, status, and remediation plan. This relationship is actively managed and updated as projects progress and obligations evolve.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`test_structure` (
    `test_structure_id` BIGINT COMMENT 'Primary key for test_structure',
    `employee_id` BIGINT COMMENT 'Unique identifier for the designer employee record within the test structure research entity.',
    `experimental_lot_id` BIGINT COMMENT 'Unique identifier for the experimental lot record within the test structure research entity.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment used for this structure.',
    `parent_test_structure_id` BIGINT COMMENT 'Self-referencing FK on test_structure (parent_test_structure_id)',
    `research_technology_node_id` BIGINT COMMENT 'Unique identifier for the research technology node record within the test structure research entity.',
    `compliance_status` STRING COMMENT 'Indicates whether the test structure meets current regulatory and internal compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test structure record was created.',
    `current_limit_ma` DECIMAL(18,2) COMMENT 'Maximum current allowed during the test in milliamps.',
    `test_structure_description` STRING COMMENT 'Detailed description of the test structure purpose and configuration.',
    `documentation_url` STRING COMMENT 'Link to detailed documentation or specification for the test structure.',
    `effective_from` DATE COMMENT 'Date when the test structure becomes effective for use.',
    `effective_until` DATE COMMENT 'Date when the test structure is retired or no longer valid (null if indefinite).',
    `feature_size_nm` DECIMAL(18,2) COMMENT 'Nominal feature size of the structure in nanometers.',
    `frequency_mhz` DECIMAL(18,2) COMMENT 'Test signal frequency in megahertz.',
    `is_standard` BOOLEAN COMMENT 'Indicates whether the structure is part of the standard test library.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the test structure record in the research domain.',
    `measurement_parameter` STRING COMMENT 'The measurement parameter of the test structure record in the research domain.',
    `measurement_purpose` STRING COMMENT 'The measurement purpose of the test structure record in the research domain.',
    `measurement_unit` STRING COMMENT 'Unit of measurement used for primary quantitative attributes (e.g., nm, mV).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the test structure record in the research domain.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the test structure.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the test structure.',
    `related_process_node` STRING COMMENT 'Process node (e.g., 7nm, 5nm) associated with the test structure.',
    `revision_number` STRING COMMENT 'Revision number of the test structure definition.',
    `safety_classification` STRING COMMENT 'Safety classification of the test structure per internal safety standards.',
    `structure_code` STRING COMMENT 'External code used to reference the test structure in documentation and tooling.',
    `structure_name` STRING COMMENT 'Human‑readable name of the test structure.',
    `structure_status` STRING COMMENT 'The structure status of the test structure record in the research domain.',
    `structure_type` STRING COMMENT 'The structure type of the test structure record in the research domain.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the test is performed, in degrees Celsius.',
    `test_category` STRING COMMENT 'Higher‑level grouping of the test structure.',
    `test_duration_ms` BIGINT COMMENT 'Typical duration of the test execution in milliseconds.',
    `test_environment` STRING COMMENT 'Physical or simulated environment conditions for the test (e.g., cleanroom, probe station).',
    `test_methodology` STRING COMMENT 'Method or standard followed when executing the test.',
    `test_purpose` STRING COMMENT 'Business or engineering purpose of the test structure.',
    `test_structure_status` STRING COMMENT 'Current lifecycle status of the test structure.',
    `test_type` STRING COMMENT 'Category of test performed by the structure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test structure record.',
    `voltage_level_mv` DECIMAL(18,2) COMMENT 'Operating voltage level for the test in millivolts.',
    CONSTRAINT pk_test_structure PRIMARY KEY(`test_structure_id`)
) COMMENT 'Master reference table for test_structure. Referenced by test_structure_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`process_split` (
    `process_split_id` BIGINT COMMENT 'Primary key for process_split',
    `ip_core_development_id` BIGINT COMMENT 'Identifier of the IP core linked to this process split.',
    `experimental_lot_id` BIGINT COMMENT 'Unique identifier for the experimental lot record within the process split research entity.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the primary equipment used for this split.',
    `parent_process_split_id` BIGINT COMMENT 'Self-referencing FK on process_split (parent_process_split_id)',
    `process_flow_experiment_id` BIGINT COMMENT 'Unique identifier for the process flow experiment record within the process split research entity.',
    `project_id` BIGINT COMMENT 'Identifier of the R&D project that owns this split.',
    `process_flow_id` BIGINT COMMENT 'Identifier of the parent manufacturing process to which this split belongs.',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the wafer involved in the split.',
    `average_yield_percent` DECIMAL(18,2) COMMENT 'Average production yield achieved for this split, expressed as a percentage.',
    `change_control_number` STRING COMMENT 'Change control identifier for tracking modifications to the split.',
    `process_split_code` STRING COMMENT 'External code used to reference the process split across systems.',
    `compliance_regulation` STRING COMMENT 'Regulatory or industry standard code applicable to the split.',
    `cost_currency` STRING COMMENT 'Currency code for the cost estimate.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost to implement the split, expressed in US dollars.',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the process split record was first created.',
    `data_classification` STRING COMMENT 'Classification level indicating data sensitivity.',
    `deprecation_date` DATE COMMENT 'Date on which the split was officially deprecated.',
    `process_split_description` STRING COMMENT 'Detailed free‑text description of the process split.',
    `effective_end_date` DATE COMMENT 'Date when the process split ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the process split becomes effective for production.',
    `equipment_name` STRING COMMENT 'Human‑readable name of the equipment used.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the split is critical for downstream product performance.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the split has been deprecated.',
    `last_modified_by_user` STRING COMMENT 'User identifier of the person who last modified the record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the process split record in the research domain.',
    `last_validation_date` DATE COMMENT 'Date when the split was last validated against specifications.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the split ratio (e.g., percent or ratio).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the process split record in the research domain.',
    `process_split_name` STRING COMMENT 'Human‑readable name of the process split.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the process split.',
    `priority_level` STRING COMMENT 'Priority assigned to the split for scheduling and resource allocation.',
    `process_split_status` STRING COMMENT 'Current lifecycle status of the process split.',
    `process_split_type` STRING COMMENT 'Category of the process split based on technology node or architecture.',
    `process_step_count` STRING COMMENT 'Number of individual steps defined within this split.',
    `risk_level` STRING COMMENT 'Risk classification associated with the split.',
    `split_code` STRING COMMENT 'Coded value representing the split code of the process split research record.',
    `split_condition_description` STRING COMMENT 'The split condition description of the process split record in the research domain.',
    `split_method` STRING COMMENT 'Primary manufacturing method used to achieve the split.',
    `split_name` STRING COMMENT 'The split name of the process split record in the research domain.',
    `split_parameter` STRING COMMENT 'The split parameter of the process split record in the research domain.',
    `split_ratio` DECIMAL(18,2) COMMENT 'Numeric ratio representing the proportion of wafers or dies allocated to this split.',
    `split_reason` STRING COMMENT 'Business or technical rationale for creating this process split.',
    `split_status` STRING COMMENT 'The split status of the process split record in the research domain.',
    `split_value` DECIMAL(18,2) COMMENT 'The split value of the process split record in the research domain.',
    `total_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Aggregate cycle time for the split expressed in minutes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the process split record.',
    `validation_status` STRING COMMENT 'Result of the most recent validation activity.',
    `version_number` STRING COMMENT 'Version of the process split definition.',
    `wafer_count` STRING COMMENT 'The wafer count of the process split record in the research domain.',
    `wafer_lot_number` STRING COMMENT 'Lot number of the wafer batch associated with this split.',
    CONSTRAINT pk_process_split PRIMARY KEY(`process_split_id`)
) COMMENT 'Master reference table for process_split. Referenced by process_split_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` (
    `research_test_plan_id` BIGINT COMMENT 'Primary key for test_plan',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the specific wafer lot associated with the test plan.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the research test plan research entity.',
    `project_id` BIGINT COMMENT 'Unique identifier for the project record within the research test plan research entity.',
    `ip_core_development_id` BIGINT COMMENT 'Identifier of the intellectual property (IP) filing associated with the test plan.',
    `research_program_id` BIGINT COMMENT 'Unique identifier for the research program record within the research test plan research entity.',
    `test_plan_owner_employee_id` BIGINT COMMENT 'Unique identifier for the test plan owner employee record within the research test plan research entity.',
    `test_suite_id` BIGINT COMMENT 'Identifier of the test suite that groups related test cases for this plan.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Timestamp when execution of the test plan completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Timestamp when execution of the test plan actually began.',
    `approval_status` STRING COMMENT 'Current approval state of the test plan.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the test plan was approved.',
    `compliance_standard` STRING COMMENT 'Industry or safety standard that the test plan adheres to.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test plan record was first created.',
    `data_collection_method` STRING COMMENT 'Methodology used to capture test data (e.g., automated, manual).',
    `effective_from` DATE COMMENT 'Date when the test plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the test plan expires or is superseded; null for open‑ended.',
    `equipment_required` STRING COMMENT 'List of equipment or tools needed to carry out the test plan.',
    `estimated_duration_minutes` STRING COMMENT 'Planned total execution time for the test plan, expressed in minutes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the research test plan record in the research domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the research test plan record in the research domain.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the test plan.',
    `owner_team` STRING COMMENT 'Team responsible for maintaining and executing the test plan.',
    `pass_fail_criteria` STRING COMMENT 'Defined conditions that determine whether the test plan is considered successful.',
    `plan_code` STRING COMMENT 'External code or number used to reference the test plan in documentation and systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the test plan.',
    `plan_status` STRING COMMENT 'The plan status of the research test plan record in the research domain.',
    `plan_type` STRING COMMENT 'Category of testing the plan addresses (e.g., functional, performance).',
    `plan_version` STRING COMMENT 'The plan version of the research test plan record in the research domain.',
    `priority` STRING COMMENT 'Business priority level assigned to the test plan.',
    `result_summary` STRING COMMENT 'High‑level outcome of the test plan execution (e.g., passed, failed, partially passed).',
    `revision_number` STRING COMMENT 'Sequential revision count for the test plan.',
    `risk_level` STRING COMMENT 'Risk assessment associated with executing the test plan.',
    `stakeholder` STRING COMMENT 'Primary business stakeholder or sponsor for the test plan.',
    `target_device` STRING COMMENT 'Identifier of the device or chip architecture the test plan targets.',
    `test_environment` STRING COMMENT 'Environment where the test plan is executed (e.g., lab, fab, simulation).',
    `test_objective` STRING COMMENT 'The test objective of the research test plan record in the research domain.',
    `test_plan_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and methodology of the test plan.',
    `test_plan_status` STRING COMMENT 'Current lifecycle state of the test plan.',
    `updated_by` STRING COMMENT 'User identifier who last modified the test plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test plan record.',
    `version` STRING COMMENT 'Version label of the test plan (e.g., v1.0, v2.1).',
    `created_by` STRING COMMENT 'User identifier who initially created the test plan.',
    CONSTRAINT pk_research_test_plan PRIMARY KEY(`research_test_plan_id`)
) COMMENT 'Master reference table for test_plan. Referenced by test_plan_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`research`.`test_suite` (
    `test_suite_id` BIGINT COMMENT 'Primary key for test_suite',
    `parent_test_suite_id` BIGINT COMMENT 'Self-referencing FK on test_suite (parent_test_suite_id)',
    `ip_core_development_id` BIGINT COMMENT 'Identifier of the intellectual property (e.g., patent) associated with the test suite.',
    `research_program_id` BIGINT COMMENT 'Unique identifier for the research program record within the test suite research entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the person responsible for the test suite.',
    `research_test_plan_id` BIGINT COMMENT 'Unique identifier for the test plan record within the test suite research entity.',
    `test_suite_owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the test suite research entity.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the test suite was formally approved for production use.',
    `associated_process_node` STRING COMMENT 'Process node (e.g., 5nm, 7nm) the suite targets.',
    `average_test_duration_seconds` DECIMAL(18,2) COMMENT 'Mean execution time of tests in the suite, measured in seconds.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the test suite metadata.',
    `created_by_user` STRING COMMENT 'User name of the person who initially created the test suite record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the test suite record was created.',
    `deprecation_reason` STRING COMMENT 'Reason why the test suite was deprecated or retired.',
    `test_suite_description` STRING COMMENT 'Detailed description of the purpose and scope of the test suite.',
    `documentation_url` STRING COMMENT 'Link to detailed documentation or user guide for the test suite.',
    `domain` STRING COMMENT 'R&D domain the test suite belongs to.',
    `effective_from` DATE COMMENT 'Date when the test suite becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the test suite is retired or expires; null if open‑ended.',
    `estimated_coverage_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of the target technology or design space covered by the suite.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the test suite is fully automated (true) or requires manual steps (false).',
    `last_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the test suite was last run.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the test suite record in the research domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the test suite record in the research domain.',
    `test_suite_name` STRING COMMENT 'Human‑readable name of the test suite.',
    `notes` STRING COMMENT 'The notes of the test suite record in the research domain.',
    `pass_rate_percentage` DECIMAL(18,2) COMMENT 'Average percentage of tests that pass when the suite is executed.',
    `source_repository` STRING COMMENT 'URL of the version‑control repository where the test suite scripts are stored.',
    `suite_code` STRING COMMENT 'Unique alphanumeric code used to reference the test suite.',
    `suite_name` STRING COMMENT 'The suite name of the test suite record in the research domain.',
    `suite_status` STRING COMMENT 'The suite status of the test suite record in the research domain.',
    `suite_type` STRING COMMENT 'Category of tests contained in the suite.',
    `suite_version` STRING COMMENT 'The suite version of the test suite record in the research domain.',
    `test_case_count` STRING COMMENT 'The test case count of the test suite record in the research domain.',
    `test_count` STRING COMMENT 'Total number of individual tests contained in the suite.',
    `test_suite_status` STRING COMMENT 'Current lifecycle status of the test suite.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the test suite record.',
    `version` STRING COMMENT 'Version identifier of the test suite (e.g., v1.0, v2.1).',
    CONSTRAINT pk_test_suite PRIMARY KEY(`test_suite_id`)
) COMMENT 'Master reference table for test_suite. Referenced by test_suite_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ADD CONSTRAINT `fk_research_project_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ADD CONSTRAINT `fk_research_research_technology_node_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ADD CONSTRAINT `fk_research_research_technology_node_technology_roadmap_id` FOREIGN KEY (`technology_roadmap_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`technology_roadmap`(`technology_roadmap_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ADD CONSTRAINT `fk_research_technology_roadmap_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ADD CONSTRAINT `fk_research_technology_roadmap_research_technology_node_id` FOREIGN KEY (`research_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_technology_node`(`research_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ADD CONSTRAINT `fk_research_experimental_lot_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ADD CONSTRAINT `fk_research_experimental_lot_primary_experimental_project_id` FOREIGN KEY (`primary_experimental_project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ADD CONSTRAINT `fk_research_experimental_lot_research_technology_node_id` FOREIGN KEY (`research_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_technology_node`(`research_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ADD CONSTRAINT `fk_research_process_integration_run_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ADD CONSTRAINT `fk_research_process_integration_run_primary_process_experimental_lot_id` FOREIGN KEY (`primary_process_experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ADD CONSTRAINT `fk_research_process_integration_run_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ADD CONSTRAINT `fk_research_device_architecture_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ADD CONSTRAINT `fk_research_device_architecture_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ADD CONSTRAINT `fk_research_device_architecture_research_technology_node_id` FOREIGN KEY (`research_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_technology_node`(`research_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ADD CONSTRAINT `fk_research_materials_research_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ADD CONSTRAINT `fk_research_materials_research_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ADD CONSTRAINT `fk_research_ip_core_development_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ADD CONSTRAINT `fk_research_ip_core_development_primary_ip_project_id` FOREIGN KEY (`primary_ip_project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ADD CONSTRAINT `fk_research_ip_core_development_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_invention_disclosure_id` FOREIGN KEY (`invention_disclosure_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`invention_disclosure`(`invention_disclosure_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_invention_research_project_id` FOREIGN KEY (`invention_research_project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ADD CONSTRAINT `fk_research_collaboration_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ADD CONSTRAINT `fk_research_collaboration_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_primary_tapeout_project_id` FOREIGN KEY (`primary_tapeout_project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_research_technology_node_id` FOREIGN KEY (`research_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_technology_node`(`research_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ADD CONSTRAINT `fk_research_tapeout_experiment_research_test_plan_id` FOREIGN KEY (`research_test_plan_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_test_plan`(`research_test_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_primary_experimental_lot_id` FOREIGN KEY (`primary_experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_process_flow_experiment_id` FOREIGN KEY (`process_flow_experiment_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`process_flow_experiment`(`process_flow_experiment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_process_integration_run_id` FOREIGN KEY (`process_integration_run_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`process_integration_run`(`process_integration_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_process_split_id` FOREIGN KEY (`process_split_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`process_split`(`process_split_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ADD CONSTRAINT `fk_research_characterization_result_test_structure_id` FOREIGN KEY (`test_structure_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`test_structure`(`test_structure_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ADD CONSTRAINT `fk_research_pdk_development_research_technology_node_id` FOREIGN KEY (`research_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_technology_node`(`research_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ADD CONSTRAINT `fk_research_research_milestone_primary_research_project_id` FOREIGN KEY (`primary_research_project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ADD CONSTRAINT `fk_research_research_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ADD CONSTRAINT `fk_research_research_milestone_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_invention_disclosure_id` FOREIGN KEY (`invention_disclosure_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`invention_disclosure`(`invention_disclosure_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_primary_publication_project_id` FOREIGN KEY (`primary_publication_project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ADD CONSTRAINT `fk_research_budget_allocation_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ADD CONSTRAINT `fk_research_budget_allocation_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ADD CONSTRAINT `fk_research_packaging_research_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ADD CONSTRAINT `fk_research_packaging_research_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_process_integration_run_id` FOREIGN KEY (`process_integration_run_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`process_integration_run`(`process_integration_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ADD CONSTRAINT `fk_research_yield_learning_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ADD CONSTRAINT `fk_research_competitive_benchmark_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ADD CONSTRAINT `fk_research_competitive_benchmark_research_technology_node_id` FOREIGN KEY (`research_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_technology_node`(`research_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ADD CONSTRAINT `fk_research_competitive_benchmark_technology_roadmap_id` FOREIGN KEY (`technology_roadmap_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`technology_roadmap`(`technology_roadmap_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ADD CONSTRAINT `fk_research_government_grant_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ADD CONSTRAINT `fk_research_process_flow_experiment_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ADD CONSTRAINT `fk_research_process_flow_experiment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ADD CONSTRAINT `fk_research_process_flow_experiment_process_research_project_id` FOREIGN KEY (`process_research_project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ADD CONSTRAINT `fk_research_process_flow_experiment_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ADD CONSTRAINT `fk_research_program_partner_collaboration_collaboration_id` FOREIGN KEY (`collaboration_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`collaboration`(`collaboration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ADD CONSTRAINT `fk_research_program_partner_collaboration_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ADD CONSTRAINT `fk_research_compliance_assessment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ADD CONSTRAINT `fk_research_compliance_assessment_compliance_research_project_id` FOREIGN KEY (`compliance_research_project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ADD CONSTRAINT `fk_research_compliance_assessment_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ADD CONSTRAINT `fk_research_test_structure_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ADD CONSTRAINT `fk_research_test_structure_parent_test_structure_id` FOREIGN KEY (`parent_test_structure_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`test_structure`(`test_structure_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ADD CONSTRAINT `fk_research_test_structure_research_technology_node_id` FOREIGN KEY (`research_technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_technology_node`(`research_technology_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ADD CONSTRAINT `fk_research_process_split_ip_core_development_id` FOREIGN KEY (`ip_core_development_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`ip_core_development`(`ip_core_development_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ADD CONSTRAINT `fk_research_process_split_experimental_lot_id` FOREIGN KEY (`experimental_lot_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`experimental_lot`(`experimental_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ADD CONSTRAINT `fk_research_process_split_parent_process_split_id` FOREIGN KEY (`parent_process_split_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`process_split`(`process_split_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ADD CONSTRAINT `fk_research_process_split_process_flow_experiment_id` FOREIGN KEY (`process_flow_experiment_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`process_flow_experiment`(`process_flow_experiment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ADD CONSTRAINT `fk_research_process_split_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ADD CONSTRAINT `fk_research_research_test_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`project`(`project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ADD CONSTRAINT `fk_research_research_test_plan_ip_core_development_id` FOREIGN KEY (`ip_core_development_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`ip_core_development`(`ip_core_development_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ADD CONSTRAINT `fk_research_research_test_plan_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ADD CONSTRAINT `fk_research_research_test_plan_test_suite_id` FOREIGN KEY (`test_suite_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`test_suite`(`test_suite_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ADD CONSTRAINT `fk_research_test_suite_parent_test_suite_id` FOREIGN KEY (`parent_test_suite_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`test_suite`(`test_suite_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ADD CONSTRAINT `fk_research_test_suite_ip_core_development_id` FOREIGN KEY (`ip_core_development_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`ip_core_development`(`ip_core_development_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ADD CONSTRAINT `fk_research_test_suite_research_program_id` FOREIGN KEY (`research_program_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_program`(`research_program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ADD CONSTRAINT `fk_research_test_suite_research_test_plan_id` FOREIGN KEY (`research_test_plan_id`) REFERENCES `vibe_semiconductors_v1`.`research`.`research_test_plan`(`research_test_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`research` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Director Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `research_director_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Director Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `research_director_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `research_director_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `research_director_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `research_director_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Envelope Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `charter_description` SET TAGS ('dbx_business_glossary_term' = 'Program Charter Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `chips_act_award_number` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Award Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `chips_act_award_number` SET TAGS ('dbx_value_regex' = '^CHIPS-[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `chips_act_award_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `chips_act_program_flag` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Program Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `collaboration_partners` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partners');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `collaboration_partners` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `current_phase` SET TAGS ('dbx_business_glossary_term' = 'Current Phase');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `experimental_wafer_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Experimental Wafer Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `gate_review_stage` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Stage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `ip_filing_count` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `key_performance_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicators (KPIs)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `last_gate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Gate Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `last_gate_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Gate Review Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `last_gate_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|conditional_approval|deferred|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `next_gate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Gate Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Program Priority Rank');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'planning|active|on_hold|completed|cancelled|archived');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'process_node_development|device_architecture|advanced_packaging|materials_research|ip_core_development|design_methodology');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `research_program_status` SET TAGS ('dbx_business_glossary_term' = 'Research Program Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `sponsoring_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `strategic_objective` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objective');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `tapeout_milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Milestone Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `target_application_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Application Domain');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `technical_lead_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Lead Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `technical_lead_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `technology_generation_target` SET TAGS ('dbx_business_glossary_term' = 'Technology Generation Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_program` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `tertiary_project_principal_investigator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Employee Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `tertiary_project_principal_investigator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `tertiary_project_principal_investigator_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `tertiary_project_principal_investigator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `tertiary_project_principal_investigator_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `collaboration_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `collaboration_partner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_value_regex' = 'internal|university|consortium|government|oem_partner');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `device_architecture_focus` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Focus');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `experimental_wafer_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Experimental Wafer Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal_r_and_d|government_grant|consortium|customer_nre|venture_capital');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `ip_filing_count` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `ip_filing_planned` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Planned');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `mpw_shuttle_participation` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Participation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `nre_budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Budget Allocated');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `nre_budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `nre_budget_spent` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Budget Spent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `nre_budget_spent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'exploratory|feasibility|development|qualification|closed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `plm_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|completed|cancelled|pending_approval');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'proof_of_concept|feasibility_study|process_integration|materials_research|ip_development|device_architecture');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `research_domain` SET TAGS ('dbx_business_glossary_term' = 'Research Domain');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Project Scope Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `technical_objectives` SET TAGS ('dbx_business_glossary_term' = 'Technical Objectives');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `technology_node_target` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`project` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` SET TAGS ('dbx_subdomain' = 'technology_development');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` SET TAGS ('dbx_ssot_owner' = 'fabrication.fabrication_technology_node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Product Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `research_program_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `technology_roadmap_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Roadmap Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `authoritative_fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `collaboration_partners` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partners');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `cost_per_wafer_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost per Wafer (United States Dollars)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `cost_per_wafer_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `design_rule_manual_version` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Manual (DRM) Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `first_tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'First Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `foundry_name` SET TAGS ('dbx_business_glossary_term' = 'Foundry Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `gate_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Gate Pitch (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `ip_filing_count` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `irds_roadmap_alignment` SET TAGS ('dbx_business_glossary_term' = 'International Roadmap for Devices and Systems (IRDS) Alignment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `lithography_generation` SET TAGS ('dbx_business_glossary_term' = 'Lithography Generation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `lithography_generation` SET TAGS ('dbx_value_regex' = 'DUV|EUV|hybrid|next_gen');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `mask_count` SET TAGS ('dbx_business_glossary_term' = 'Photomask Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `maturity_status` SET TAGS ('dbx_business_glossary_term' = 'Maturity Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `metal_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Metal Pitch (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `minimum_feature_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Feature Size (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `multi_patterning_technique` SET TAGS ('dbx_business_glossary_term' = 'Multi-Patterning Technique');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `node_generation` SET TAGS ('dbx_business_glossary_term' = 'Node Generation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `node_maturity_status` SET TAGS ('dbx_business_glossary_term' = 'Node Maturity Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `node_maturity_status` SET TAGS ('dbx_value_regex' = 'research|development|pilot|production|mature|EOL');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost (United States Dollars)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `process_flow_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Complexity Score');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `production_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Production Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `reliability_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Reliability Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `reliability_qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|failed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `research_technology_node_status` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `supply_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Supply Voltage (Volts)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `target_area_scaling_factor` SET TAGS ('dbx_business_glossary_term' = 'Target Area Scaling Factor');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `target_performance_metric_ghz` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Metric (Gigahertz)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `target_power_metric_mw_per_mhz` SET TAGS ('dbx_business_glossary_term' = 'Target Power Metric (Milliwatts per Megahertz)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `transistor_density_mtransistors_per_mm2` SET TAGS ('dbx_business_glossary_term' = 'Transistor Density (Million Transistors per Square Millimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_technology_node` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` SET TAGS ('dbx_subdomain' = 'technology_development');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `technology_roadmap_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Roadmap ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Roadmap Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `area_improvement_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Area Improvement Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `benchmark_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `benchmark_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|estimated');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `benchmark_confidence_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `benchmark_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `benchmark_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `chips_act_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitive_benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitive_benchmark_source` SET TAGS ('dbx_value_regex' = 'public_disclosure|teardown_analysis|published_paper|industry_report|conference_presentation|patent_filing');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitive_benchmark_source` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_drive_current` SET TAGS ('dbx_business_glossary_term' = 'Competitor Drive Current');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_drive_current` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_frequency_ghz` SET TAGS ('dbx_business_glossary_term' = 'Competitor Frequency (GHz)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_frequency_ghz` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_leakage_current` SET TAGS ('dbx_business_glossary_term' = 'Competitor Leakage Current');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_leakage_current` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor or Foundry Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_power_consumption` SET TAGS ('dbx_business_glossary_term' = 'Competitor Power Consumption');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_power_consumption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_transistor_density` SET TAGS ('dbx_business_glossary_term' = 'Competitor Transistor Density');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `competitor_transistor_density` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `estimated_nre_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Non-Recurring Engineering (NRE) Cost');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `estimated_nre_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `horizon_end_year` SET TAGS ('dbx_business_glossary_term' = 'Horizon End Year');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `horizon_start_year` SET TAGS ('dbx_business_glossary_term' = 'Horizon Start Year');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `investment_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Investment Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `investment_priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|deferred');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `investment_priority_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `key_enabling_technologies` SET TAGS ('dbx_business_glossary_term' = 'Key Enabling Technologies');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Technology Milestone Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `performance_improvement_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `power_improvement_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Power Improvement Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `roadmap_name` SET TAGS ('dbx_business_glossary_term' = 'Roadmap Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `roadmap_references_nodes` SET TAGS ('dbx_business_glossary_term' = 'Roadmap References Nodes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `roadmap_status` SET TAGS ('dbx_business_glossary_term' = 'Roadmap Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `roadmap_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `roadmap_targets_node` SET TAGS ('dbx_business_glossary_term' = 'Roadmap Targets Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `roadmap_version` SET TAGS ('dbx_business_glossary_term' = 'Roadmap Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `roadmap_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `strategic_implication_assessment` SET TAGS ('dbx_business_glossary_term' = 'Strategic Implication Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `strategic_implication_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `target_introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Target Introduction Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `target_process_node` SET TAGS ('dbx_business_glossary_term' = 'Target Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `technology_focus_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Focus Area');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `technology_focus_area` SET TAGS ('dbx_value_regex' = 'process_node|device_architecture|advanced_packaging|materials|ip_core|integration');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `technology_roadmap_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Roadmap Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`technology_roadmap` ALTER COLUMN `transistor_density_target` SET TAGS ('dbx_business_glossary_term' = 'Transistor Density Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Process Flow ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Research Team ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `primary_experimental_project_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `data_collection_plan` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Plan');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `experimental_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `experimental_outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Experimental Outcome Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `experimental_outcome_status` SET TAGS ('dbx_value_regex' = 'pending|successful|partially_successful|failed|inconclusive');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'ear99|eccn|itar_controlled|not_controlled');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `fab_line_assignment` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Line Assignment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `ip_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `ip_filing_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `lot_purpose` SET TAGS ('dbx_business_glossary_term' = 'Lot Purpose');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `lot_to_project` SET TAGS ('dbx_business_glossary_term' = 'Lot To Project');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'process_development|device_validation|materials_research|split_lot|doe_experiment|proof_of_concept');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `mes_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) System Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `research_notes` SET TAGS ('dbx_business_glossary_term' = 'Research Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `research_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `scrap_reason` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `split_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Split Condition Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `split_count` SET TAGS ('dbx_business_glossary_term' = 'Split Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `target_device_structure` SET TAGS ('dbx_business_glossary_term' = 'Target Device Structure');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `technology_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`experimental_lot` ALTER COLUMN `wafer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (mm)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `process_integration_run_id` SET TAGS ('dbx_business_glossary_term' = 'Process Integration Run Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Integration Engineer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `primary_process_experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Process Experimental Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `process_engineer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `process_engineer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `process_engineer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `beol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Back End of Line (BEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `contact_resistance_ohm` SET TAGS ('dbx_business_glossary_term' = 'Contact Resistance in Ohms (Ω)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_value_regex' = 'FinFET|GAA|CFET|Planar|Nanowire|Nanosheet');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `doe_design_type` SET TAGS ('dbx_business_glossary_term' = 'Design of Experiments (DOE) Design Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `doe_design_type` SET TAGS ('dbx_value_regex' = 'full_factorial|fractional_factorial|taguchi|response_surface|one_factor_at_a_time|custom');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `drive_current_ua` SET TAGS ('dbx_business_glossary_term' = 'Drive Current (Ion) in Microamperes (μA)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `electrical_test_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Electrical Test Structure Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `electrical_test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Electrical Test Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `experiment_name` SET TAGS ('dbx_business_glossary_term' = 'Experiment Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `feol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Front End of Line (FEOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `gate_oxide_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Gate Oxide Thickness in Nanometers (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `ip_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `leakage_current_na` SET TAGS ('dbx_business_glossary_term' = 'Leakage Current (Ioff) in Nanoamperes (nA)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `learning_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Learning Cycle Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `mol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Middle of Line (MOL) Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `next_action_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Next Action Recommendation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Determination');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `pdk_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Contribution Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `process_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `process_integration_run_status` SET TAGS ('dbx_business_glossary_term' = 'Process Integration Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `research_program_name` SET TAGS ('dbx_business_glossary_term' = 'Research Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_code` SET TAGS ('dbx_business_glossary_term' = 'Run Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_objective` SET TAGS ('dbx_business_glossary_term' = 'Run Objective');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|on_hold|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `run_targets_node` SET TAGS ('dbx_business_glossary_term' = 'Run Targets Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `split_condition_count` SET TAGS ('dbx_business_glossary_term' = 'Split Condition Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `subthreshold_slope_mv_per_decade` SET TAGS ('dbx_business_glossary_term' = 'Subthreshold Slope in Millivolts per Decade (mV/dec)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `target_device_structure` SET TAGS ('dbx_business_glossary_term' = 'Target Device Structure');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `tcad_correlation_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Technology Computer-Aided Design (TCAD) Correlation Accuracy Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `tcad_simulation_correlation_flag` SET TAGS ('dbx_business_glossary_term' = 'Technology Computer-Aided Design (TCAD) Simulation Correlation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `threshold_voltage_mv` SET TAGS ('dbx_business_glossary_term' = 'Threshold Voltage (Vth) in Millivolts (mV)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_integration_run` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` SET TAGS ('dbx_subdomain' = 'technology_development');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `device_architecture_id` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Researcher Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_code` SET TAGS ('dbx_business_glossary_term' = 'Architecture Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_maturity_level` SET TAGS ('dbx_business_glossary_term' = 'Architecture Maturity Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_maturity_level` SET TAGS ('dbx_value_regex' = 'concept|simulated|fabricated|characterized|qualified');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_name` SET TAGS ('dbx_business_glossary_term' = 'Architecture Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_status` SET TAGS ('dbx_business_glossary_term' = 'Architecture Development Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed|transferred_to_production');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_targets_node` SET TAGS ('dbx_business_glossary_term' = 'Architecture Targets Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `architecture_type` SET TAGS ('dbx_value_regex' = 'device|packaging');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `associated_experimental_lot_ids` SET TAGS ('dbx_business_glossary_term' = 'Associated Experimental Lot Identifiers (IDs)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `channel_length_nm` SET TAGS ('dbx_business_glossary_term' = 'Channel Length (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `channel_material` SET TAGS ('dbx_business_glossary_term' = 'Channel Material');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `concept_date` SET TAGS ('dbx_business_glossary_term' = 'Concept Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `development_maturity_stage` SET TAGS ('dbx_business_glossary_term' = 'Development Maturity Stage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `device_architecture_status` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `device_structure_category` SET TAGS ('dbx_business_glossary_term' = 'Device Structure Category');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `device_structure_category` SET TAGS ('dbx_value_regex' = 'FinFET|GAA|CFET|FDSOI|planar|other');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `estimated_time_to_market_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time to Market (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `fabrication_complexity_rating` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Complexity Rating');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `fabrication_complexity_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|extreme');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `fin_width_nm` SET TAGS ('dbx_business_glossary_term' = 'Fin Width (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `first_fabrication_date` SET TAGS ('dbx_business_glossary_term' = 'First Fabrication Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `gate_length_nm` SET TAGS ('dbx_business_glossary_term' = 'Gate Length Nm');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `gate_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Gate Pitch (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `integration_approach` SET TAGS ('dbx_business_glossary_term' = 'Integration Approach');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `integration_approach` SET TAGS ('dbx_value_regex' = '2.5D|3D|fan_out|chiplet|monolithic|hybrid');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `interconnect_density_target` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Density Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `ip_ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `ip_ownership_status` SET TAGS ('dbx_value_regex' = 'proprietary|joint|licensed|open|pending');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `ip_ownership_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `key_technical_challenges` SET TAGS ('dbx_business_glossary_term' = 'Key Technical Challenges');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `materials_innovation_flag` SET TAGS ('dbx_business_glossary_term' = 'Materials Innovation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `patent_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `patent_filing_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `power_performance_area_target` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area (PPA) Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `structural_description` SET TAGS ('dbx_business_glossary_term' = 'Structural Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `target_application_domains` SET TAGS ('dbx_business_glossary_term' = 'Target Application Domains');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `target_technology_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Technology Node (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `technology_roadmap_alignment` SET TAGS ('dbx_business_glossary_term' = 'Technology Roadmap Alignment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `thermal_performance_target_w_cm2` SET TAGS ('dbx_business_glossary_term' = 'Thermal Performance Target (Watts per Square Centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`device_architecture` ALTER COLUMN `transistor_type` SET TAGS ('dbx_business_glossary_term' = 'Transistor Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` SET TAGS ('dbx_subdomain' = 'technology_development');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `materials_research_id` SET TAGS ('dbx_business_glossary_term' = 'Materials Research ID (Identifier)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Wafer Lot ID (Identifier)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `materials_researcher_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Researcher Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `materials_researcher_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `materials_researcher_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `bandgap_energy_ev` SET TAGS ('dbx_business_glossary_term' = 'Bandgap Energy (Electron Volts)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `breakdown_voltage_mv_cm` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Voltage (Megavolts per Centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `characterization_method` SET TAGS ('dbx_business_glossary_term' = 'Characterization Method');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `chemical_composition` SET TAGS ('dbx_business_glossary_term' = 'Chemical Composition');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `compatibility_assessment` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Compatibility Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `compatibility_assessment` SET TAGS ('dbx_value_regex' = 'fully_compatible|minor_integration_issues|major_integration_challenges|incompatible|under_evaluation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `deposition_method` SET TAGS ('dbx_business_glossary_term' = 'Deposition Method');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `dielectric_constant` SET TAGS ('dbx_business_glossary_term' = 'Dielectric Constant (k-value)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `electron_mobility_cm2_vs` SET TAGS ('dbx_business_glossary_term' = 'Electron Mobility (Square Centimeters per Volt-Second)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `etch_rate_nm_min` SET TAGS ('dbx_business_glossary_term' = 'Etch Rate (Nanometers per Minute)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `film_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Film Thickness (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `last_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `material_class` SET TAGS ('dbx_business_glossary_term' = 'Material Class');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `material_class` SET TAGS ('dbx_value_regex' = 'high_k_dielectric|low_k_ild|2d_material|iii_v_compound|advanced_metallization|other');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `material_cost_per_gram_usd` SET TAGS ('dbx_business_glossary_term' = 'Material Cost per Gram (United States Dollars)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `material_cost_per_gram_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `materials_research_status` SET TAGS ('dbx_business_glossary_term' = 'Materials Research Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Research Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `patent_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `patent_filing_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `process_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature (Celsius)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `reach_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'REACH (Registration Evaluation Authorization and Restriction of Chemicals) Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `reach_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|restricted|svhc_candidate|under_review|not_assessed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `research_institution_partner` SET TAGS ('dbx_business_glossary_term' = 'Research Institution Partner');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `research_maturity_stage` SET TAGS ('dbx_business_glossary_term' = 'Research Maturity Stage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `research_maturity_stage` SET TAGS ('dbx_value_regex' = 'concept|feasibility|proof_of_concept|optimization|pilot_integration|pre_production');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `research_objective` SET TAGS ('dbx_business_glossary_term' = 'Research Objective');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `research_project_code` SET TAGS ('dbx_business_glossary_term' = 'Research Project Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `research_start_date` SET TAGS ('dbx_business_glossary_term' = 'Research Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `research_status` SET TAGS ('dbx_business_glossary_term' = 'Research Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `research_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|completed|discontinued|transferred');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `resistivity_ohm_cm` SET TAGS ('dbx_business_glossary_term' = 'Resistivity (Ohm-Centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `rohs_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'RoHS (Restriction of Hazardous Substances) Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `rohs_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|under_review|not_assessed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `stress_mpa` SET TAGS ('dbx_business_glossary_term' = 'Film Stress (Megapascals)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `supplier_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier or Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `supplier_vendor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `surface_roughness_nm` SET TAGS ('dbx_business_glossary_term' = 'Surface Roughness (Nanometers Root Mean Square)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `technology_node_target` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `test_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Test Structure Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `thermal_conductivity_w_mk` SET TAGS ('dbx_business_glossary_term' = 'Thermal Conductivity (Watts per Meter-Kelvin)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `tsca_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'TSCA (Toxic Substances Control Act) Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`materials_research` ALTER COLUMN `tsca_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|restricted|requires_notification|under_review|not_assessed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_core_development_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Development ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Architect Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_lead_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_lead_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_lead_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `primary_ip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `product_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Product Ip Core Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `actual_nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Non-Recurring Engineering (NRE) Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `actual_nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `design_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Design Complexity Score');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `design_for_testability_coverage` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Coverage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `design_specification_version` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `development_stage` SET TAGS ('dbx_business_glossary_term' = 'Development Stage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `development_status` SET TAGS ('dbx_business_glossary_term' = 'Development Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `development_team_size` SET TAGS ('dbx_business_glossary_term' = 'Development Team Size');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `documentation_completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Documentation Completeness Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `eda_tool_suite` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Suite');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `estimated_nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Non-Recurring Engineering (NRE) Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `estimated_nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `first_silicon_target_date` SET TAGS ('dbx_business_glossary_term' = 'First Silicon Target Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_category` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Category');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_category` SET TAGS ('dbx_value_regex' = 'processor_core|memory_controller|phy_interface|analog_ip|standard_cell_library|other');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_core_development_status` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Development Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_core_name` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_portfolio_classification` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Portfolio Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_portfolio_classification` SET TAGS ('dbx_value_regex' = 'strategic|commercial|experimental|legacy');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_type` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `ip_type` SET TAGS ('dbx_value_regex' = 'hard_ip|soft_ip|firm_ip');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `last_milestone_achieved` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Achieved');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `last_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `licensing_model` SET TAGS ('dbx_business_glossary_term' = 'Licensing Model');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `licensing_model` SET TAGS ('dbx_value_regex' = 'internal_use_only|licensable_royalty|licensable_royalty_free|open_source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `patent_filing_count` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `production_release_target_date` SET TAGS ('dbx_business_glossary_term' = 'Production Release Target Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `reuse_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reuse Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `rtl_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Register Transfer Level (RTL) Completion Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `silicon_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Silicon Validation Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `silicon_validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|waived');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `target_node` SET TAGS ('dbx_business_glossary_term' = 'Target Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `target_ppa_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Target Power Performance Area (PPA) Area (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `target_ppa_performance_mhz` SET TAGS ('dbx_business_glossary_term' = 'Target Power Performance Area (PPA) Performance (MHz)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `target_ppa_power_mw` SET TAGS ('dbx_business_glossary_term' = 'Target Power Performance Area (PPA) Power (mW)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `target_process_node` SET TAGS ('dbx_business_glossary_term' = 'Target Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`ip_core_development` ALTER COLUMN `verification_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Verification Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `patent_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `invention_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Invention Disclosure Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inventor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `abandonment_date` SET TAGS ('dbx_business_glossary_term' = 'Application Abandonment Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `actual_filing_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Filing Cost Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `actual_filing_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{6,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `assigned_patent_counsel` SET TAGS ('dbx_business_glossary_term' = 'Assigned Patent Counsel Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `business_value_score` SET TAGS ('dbx_business_glossary_term' = 'Business Value Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `chips_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Reportable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `claims_allowed` SET TAGS ('dbx_business_glossary_term' = 'Number of Claims Allowed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `claims_filed` SET TAGS ('dbx_business_glossary_term' = 'Number of Claims Filed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `cpc_classification` SET TAGS ('dbx_business_glossary_term' = 'Cooperative Patent Classification (CPC) Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `disclosure_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Invention Disclosure Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `estimated_filing_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Filing Cost Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `estimated_filing_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN_[0-9][A-Z][0-9]{3}|ITAR');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Filing Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Grant Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `independent_claims` SET TAGS ('dbx_business_glossary_term' = 'Number of Independent Claims');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `invention_title` SET TAGS ('dbx_business_glossary_term' = 'Invention Title');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `inventor_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Inventors');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `inventors` SET TAGS ('dbx_business_glossary_term' = 'Inventor Names');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `inventors` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `ipc_classification` SET TAGS ('dbx_business_glossary_term' = 'International Patent Classification (IPC) Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `ipc_classification` SET TAGS ('dbx_value_regex' = '^[A-H][0-9]{2}[A-Z][0-9]{1,4}/[0-9]{2,6}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `last_office_action_date` SET TAGS ('dbx_business_glossary_term' = 'Last Office Action Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `law_firm` SET TAGS ('dbx_business_glossary_term' = 'External Law Firm Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `maintenance_fee_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Fee Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `national_phase_entry_date` SET TAGS ('dbx_business_glossary_term' = 'National Phase Entry Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `novelty_assessment` SET TAGS ('dbx_business_glossary_term' = 'Novelty Assessment Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `novelty_assessment` SET TAGS ('dbx_value_regex' = 'highly_novel|novel|incremental|questionable');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `office_action_count` SET TAGS ('dbx_business_glossary_term' = 'Office Action Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `patent_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Granted Patent Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `patent_title` SET TAGS ('dbx_business_glossary_term' = 'Patent Title');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `patent_to_project` SET TAGS ('dbx_business_glossary_term' = 'Patent To Project');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `patent_type` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `pct_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Cooperation Treaty (PCT) Application Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `pct_application_number` SET TAGS ('dbx_value_regex' = '^PCT/[A-Z]{2}[0-9]{4}/[0-9]{6}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `primary_inventor` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventor Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `primary_inventor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `prior_art_references` SET TAGS ('dbx_business_glossary_term' = 'Prior Art Reference Citations');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `prior_art_search_completed` SET TAGS ('dbx_business_glossary_term' = 'Prior Art Search Completed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Claim Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `prosecution_stage` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Stage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `protection_strategy` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Protection Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `protection_strategy` SET TAGS ('dbx_value_regex' = 'patent|trade_secret|defensive_publication|open_source|no_protection');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Application Publication Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `related_applications` SET TAGS ('dbx_business_glossary_term' = 'Related Patent Application Numbers');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Office Action Response Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `strategic_value` SET TAGS ('dbx_business_glossary_term' = 'Strategic Intellectual Property (IP) Value Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`patent_filing` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `invention_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Invention Disclosure Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inventor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `invention_research_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventor Employee Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `assigned_ip_counsel` SET TAGS ('dbx_business_glossary_term' = 'Assigned Intellectual Property (IP) Counsel');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `business_value_assessment` SET TAGS ('dbx_business_glossary_term' = 'Business Value Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `business_value_assessment` SET TAGS ('dbx_value_regex' = 'high|medium|low|pending');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `co_inventors` SET TAGS ('dbx_business_glossary_term' = 'Co-Inventors');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `co_inventors` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `competitive_advantage_description` SET TAGS ('dbx_business_glossary_term' = 'Competitive Advantage Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `competitive_advantage_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'highly_confidential|confidential|internal|public');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_value_regex' = 'finfet|gaa|cfet|planar|other|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_value_regex' = '^ID-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_title` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Title');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `experimental_wafer_lot` SET TAGS ('dbx_business_glossary_term' = 'Experimental Wafer Lot');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'ear99|eccn|itar_controlled|not_applicable|pending_review');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal_r_and_d|government_grant|industry_consortium|joint_development|other');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `government_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Government Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `government_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `invention_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Invention Disclosure Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `invention_title` SET TAGS ('dbx_business_glossary_term' = 'Invention Title');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `inventor_organization` SET TAGS ('dbx_business_glossary_term' = 'Inventor Organization');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `ip_counsel_contact` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Counsel Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `ip_counsel_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `ip_counsel_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `ip_counsel_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `ip_protection_strategy` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Protection Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `ip_protection_strategy` SET TAGS ('dbx_value_regex' = 'patent|trade_secret|defensive_publication|no_protection|pending_decision');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `market_application` SET TAGS ('dbx_business_glossary_term' = 'Market Application');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `novelty_assessment` SET TAGS ('dbx_business_glossary_term' = 'Novelty Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `novelty_assessment` SET TAGS ('dbx_value_regex' = 'high|medium|low|pending');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `patent_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `patent_filing_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Recommendation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `patent_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Patent Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventor Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `prior_art_references` SET TAGS ('dbx_business_glossary_term' = 'Prior Art References');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `prior_art_search_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Art Search Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `prior_art_search_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Art Search Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `prior_art_search_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_required');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `process_node_target` SET TAGS ('dbx_business_glossary_term' = 'Process Node Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `publication_number` SET TAGS ('dbx_business_glossary_term' = 'Publication Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `review_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Review Committee Decision');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `review_committee_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|deferred|pending');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `technical_description` SET TAGS ('dbx_business_glossary_term' = 'Technical Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `technical_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`invention_disclosure` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Technical Contact Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `background_ip_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Intellectual Property (IP) Included Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `collaboration_code` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_value_regex' = 'draft|active|on_hold|completed|terminated|expired');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_value_regex' = 'joint_development|sponsored_research|consortium_membership|cro_engagement|technology_licensing|material_transfer');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|proprietary');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `consortium_name` SET TAGS ('dbx_business_glossary_term' = 'Consortium Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `cost_sharing_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `cost_sharing_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `deliverables_schedule` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Collaboration End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'none|ear|itar|dual_use|controlled');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `funding_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Contribution Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `funding_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `government_program_name` SET TAGS ('dbx_business_glossary_term' = 'Government Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Terms');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `joint_patent_filing_terms` SET TAGS ('dbx_business_glossary_term' = 'Joint Patent Filing Terms');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `joint_patent_filing_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `collaboration_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `nda_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `nda_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Institution Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Partner Technical Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_email` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Technical Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_name` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `partner_technical_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `publication_rights` SET TAGS ('dbx_business_glossary_term' = 'Publication Rights');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `research_scope` SET TAGS ('dbx_business_glossary_term' = 'Research Scope');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `technology_focus_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Focus Area');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`collaboration` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `tapeout_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Experiment ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `primary_tapeout_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `research_test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `chip_name` SET TAGS ('dbx_business_glossary_term' = 'Chip Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `data_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Years)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `design_team` SET TAGS ('dbx_business_glossary_term' = 'Design Team');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Size (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `drc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Check (DRC) Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `drc_status` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Check (DRC) Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `drc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|waived|in_progress|not_started');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `eda_tool_suite` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Suite');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `foundry_fab_target` SET TAGS ('dbx_business_glossary_term' = 'Foundry or Fabrication Facility (FAB) Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `funding_source` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `gds_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Graphic Data System (GDS) Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `ip_core_under_test` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Under Test');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `ip_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `ip_filing_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `lvs_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Layout Versus Schematic (LVS) Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `lvs_status` SET TAGS ('dbx_business_glossary_term' = 'Layout Versus Schematic (LVS) Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `lvs_status` SET TAGS ('dbx_value_regex' = 'passed|failed|waived|in_progress|not_started');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `mpw_slot_allocation` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Slot Allocation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `number_of_dies_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Number of Dies Per Wafer');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `shuttle_name` SET TAGS ('dbx_business_glossary_term' = 'Shuttle Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `tapeout_experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Experiment Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `tapeout_name` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `tapeout_purpose` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Purpose');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `tapeout_purpose` SET TAGS ('dbx_value_regex' = 'process_validation|device_characterization|ip_validation|yield_learning|architecture_proof|packaging_test');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `tapeout_to_project` SET TAGS ('dbx_business_glossary_term' = 'Tapeout To Project');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `wafer_allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Wafer Allocation Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `wafer_allocation_type` SET TAGS ('dbx_value_regex' = 'mpw|dedicated|shared_lot|pilot_run');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`tapeout_experiment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `characterization_result_id` SET TAGS ('dbx_business_glossary_term' = 'Characterization Result Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Engineer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `characterization_engineer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `characterization_engineer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `characterization_engineer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `primary_experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Experimental Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `process_flow_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `process_integration_run_id` SET TAGS ('dbx_business_glossary_term' = 'Process Integration Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `process_split_id` SET TAGS ('dbx_business_glossary_term' = 'Process Split Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `test_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Test Structure Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `analysis_software` SET TAGS ('dbx_business_glossary_term' = 'Analysis Software');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `characterization_result_status` SET TAGS ('dbx_business_glossary_term' = 'Characterization Result Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `corrective_action_proposed` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Proposed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `data_file_path` SET TAGS ('dbx_business_glossary_term' = 'Data File Path');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `data_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `device_architecture` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `die_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Die Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `dominant_yield_detractor` SET TAGS ('dbx_business_glossary_term' = 'Dominant Yield Detractor');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `functional_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Functional Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `learning_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Learning Cycle Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_condition` SET TAGS ('dbx_business_glossary_term' = 'Measurement Condition');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Equipment Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'pass|fail|marginal|incomplete|invalid|retest_required');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `parametric_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Parametric Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `pdk_calibration_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Calibration Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `reliability_stress_type` SET TAGS ('dbx_business_glossary_term' = 'Reliability Stress Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Findings');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `specification_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `specification_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `yield_improvement_delta` SET TAGS ('dbx_business_glossary_term' = 'Yield Improvement Delta');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`characterization_result` ALTER COLUMN `yield_limiting_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Yield Limiting Mechanism');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` SET TAGS ('dbx_subdomain' = 'technology_development');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_development_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Development ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `cadence_virtuoso_compatible` SET TAGS ('dbx_business_glossary_term' = 'Cadence Virtuoso Compatible');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `critical_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Issues Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `development_stage` SET TAGS ('dbx_business_glossary_term' = 'Development Stage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `development_start_date` SET TAGS ('dbx_business_glossary_term' = 'Development Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `development_status` SET TAGS ('dbx_business_glossary_term' = 'Development Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `development_team` SET TAGS ('dbx_business_glossary_term' = 'Development Team');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|cfet|hybrid');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `end_of_support_date` SET TAGS ('dbx_business_glossary_term' = 'End of Support (EOS) Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `includes_design_rule_manual` SET TAGS ('dbx_business_glossary_term' = 'Includes Design Rule Manual');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `includes_drc_rules` SET TAGS ('dbx_business_glossary_term' = 'Includes Design Rule Check (DRC) Rules');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `includes_io_libraries` SET TAGS ('dbx_business_glossary_term' = 'Includes Input/Output (IO) Libraries');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `includes_lvs_rules` SET TAGS ('dbx_business_glossary_term' = 'Includes Layout Versus Schematic (LVS) Rules');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `includes_memory_compilers` SET TAGS ('dbx_business_glossary_term' = 'Includes Memory Compilers');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `includes_spice_models` SET TAGS ('dbx_business_glossary_term' = 'Includes Simulation Program with Integrated Circuit Emphasis (SPICE) Models');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `includes_standard_cell_libraries` SET TAGS ('dbx_business_glossary_term' = 'Includes Standard Cell Libraries');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `is_customer_accessible` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Accessible');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `known_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Known Issues Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_development|under_validation|released|active|suspended|retired');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `mentor_compatible` SET TAGS ('dbx_business_glossary_term' = 'Mentor Graphics Compatible');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `metal_layers_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layers Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `minimum_feature_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Feature Size (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_code` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_code` SET TAGS ('dbx_value_regex' = '^PDK-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_custodian_email` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Custodian Email');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_custodian_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_custodian_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_custodian_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_custodian_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_custodian_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Custodian Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_development_status` SET TAGS ('dbx_business_glossary_term' = 'Pdk Development Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_for_node` SET TAGS ('dbx_business_glossary_term' = 'Pdk For Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_name` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_targets_node` SET TAGS ('dbx_business_glossary_term' = 'Pdk Targets Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `pdk_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `planned_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `predecessor_pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `process_type` SET TAGS ('dbx_business_glossary_term' = 'Process Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `process_type` SET TAGS ('dbx_value_regex' = 'cmos|bicmos|soi|fdsoi|gan|sige');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'alpha|beta|production|maintenance|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `supports_euv_lithography` SET TAGS ('dbx_business_glossary_term' = 'Supports Extreme Ultraviolet (EUV) Lithography');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `synopsys_compatible` SET TAGS ('dbx_business_glossary_term' = 'Synopsys Compatible');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `validation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `validation_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `validation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`pdk_development` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|partial|complete|failed|waived');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` SET TAGS ('dbx_ssot_owner' = 'milestone');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `research_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Research Milestone Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `primary_research_approving_authority_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Employee Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `primary_research_approving_authority_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `primary_research_approving_authority_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `primary_research_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `authoritative_design_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Design Milestone Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `authoritative_design_milestone_id` SET TAGS ('dbx_ssot' = 'owner_reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `design_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Design Milestone Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `design_milestone_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `action_items` SET TAGS ('dbx_business_glossary_term' = 'Action Items');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `budget_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `budget_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `budget_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `chips_act_report_date` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Report Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `chips_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Reportable Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `collaboration_partner_involved` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner Involved Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `completion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Completion Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `critical_path_indicator` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `export_control_review_required` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Required Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `gate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `gate_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `gate_review_outcome` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|deferred|not_reviewed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `ip_filing_triggered` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Triggered Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|deferred|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_to_program` SET TAGS ('dbx_business_glossary_term' = 'Milestone To Program');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_to_project` SET TAGS ('dbx_business_glossary_term' = 'Milestone To Project');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'technical_gate|management_review|customer_demo|tapeout|silicon_return|qualification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `plm_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `research_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Research Milestone Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `review_meeting_minutes_url` SET TAGS ('dbx_business_glossary_term' = 'Review Meeting Minutes Uniform Resource Locator (URL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Days');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `stakeholder_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notification Sent Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_milestone` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `publication_id` SET TAGS ('dbx_business_glossary_term' = 'Publication Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `invention_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Disclosure ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `invention_disclosure_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Author Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `primary_publication_project_id` SET TAGS ('dbx_business_glossary_term' = 'Publication Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `publication_author_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `publication_author_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `publication_author_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Abstract');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `authors` SET TAGS ('dbx_business_glossary_term' = 'Authors');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `citation_count` SET TAGS ('dbx_business_glossary_term' = 'Citation Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `co_author_count` SET TAGS ('dbx_business_glossary_term' = 'Co-Author Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `publication_code` SET TAGS ('dbx_business_glossary_term' = 'Publication Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `collaboration_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `device_architecture_focus` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Focus');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `export_control_review_status` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `export_control_review_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|denied');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `export_control_review_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `internal_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Document Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `internal_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `isbn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Book Number (ISBN)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `issn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Serial Number (ISSN)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `issn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `issn` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `issn` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Publication Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `open_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Access Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|in_review|completed|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `plm_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `publication_type` SET TAGS ('dbx_business_glossary_term' = 'Publication Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `technology_disclosure_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Disclosure Clearance Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `technology_disclosure_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|denied');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `technology_disclosure_clearance_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `technology_node_focus` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Focus');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Publication Title');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Publication Uniform Resource Locator (URL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `venue` SET TAGS ('dbx_business_glossary_term' = 'Publication Venue');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `venue_type` SET TAGS ('dbx_business_glossary_term' = 'Venue Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`publication` ALTER COLUMN `venue_type` SET TAGS ('dbx_value_regex' = 'conference|journal|symposium|workshop|webinar|internal');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Employee Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Program Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `tertiary_budget_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `tertiary_budget_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `tertiary_budget_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `tertiary_budget_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `tertiary_budget_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `budget_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'headcount|equipment|materials|external_services|fab_costs|ip_licensing');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `budget_for_program` SET TAGS ('dbx_business_glossary_term' = 'Budget For Program');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `budget_funds_program` SET TAGS ('dbx_business_glossary_term' = 'Budget Funds Program');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `chips_act_award_number` SET TAGS ('dbx_business_glossary_term' = 'Creating Helpful Incentives to Produce Semiconductors (CHIPS) Act Award Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `chips_act_award_number` SET TAGS ('dbx_value_regex' = '^CHIPS-[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `chips_act_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Creating Helpful Incentives to Produce Semiconductors (CHIPS) Act Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `collaboration_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `compliance_obligations_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligations Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `deliverables_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = '^(EAR99|ECCN [0-9][A-Z][0-9]{3}|ITAR|NLR)$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_value_regex' = 'government_grant|internal_rd_budget|consortium_contribution|customer_funded_nre|venture_capital|strategic_partnership');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `grant_program_name` SET TAGS ('dbx_business_glossary_term' = 'Grant Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `grant_type` SET TAGS ('dbx_value_regex' = 'direct_funding|tax_credit|matching_fund|equipment_grant|research_contract|cooperative_agreement');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `granting_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Granting Agency Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `performance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `performance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `reporting_requirements_description` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`budget_allocation` ALTER COLUMN `technical_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Technical Scope Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` SET TAGS ('dbx_subdomain' = 'technology_development');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `packaging_research_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Research ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `packaging_researcher_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Researcher Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `packaging_researcher_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `packaging_researcher_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `primary_packaging_principal_investigator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `primary_packaging_principal_investigator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `primary_packaging_principal_investigator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Program ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `chips_act_program_flag` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Program Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `collaboration_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Collaboration Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `development_maturity_stage` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `die_stack_count` SET TAGS ('dbx_business_glossary_term' = 'Die Stack Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `experimental_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `integration_approach` SET TAGS ('dbx_business_glossary_term' = 'Integration Approach');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `integration_approach` SET TAGS ('dbx_value_regex' = '2.5D|3D|Fan-Out|Chiplet|Heterogeneous|Monolithic');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `interconnect_density_target` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Density Target');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `interconnect_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Pitch (Micrometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `ip_filing_count` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Filing Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `key_technical_challenges` SET TAGS ('dbx_business_glossary_term' = 'Key Technical Challenges');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `nre_budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Budget Allocated');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `nre_budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `nre_budget_spent` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Budget Spent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `nre_budget_spent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `package_size_x_mm` SET TAGS ('dbx_business_glossary_term' = 'Package Size X Dimension (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `package_size_y_mm` SET TAGS ('dbx_business_glossary_term' = 'Package Size Y Dimension (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `package_technology` SET TAGS ('dbx_business_glossary_term' = 'Package Technology');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `package_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Package Thickness (Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `packaging_research_status` SET TAGS ('dbx_business_glossary_term' = 'Packaging Research Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `packaging_technology_name` SET TAGS ('dbx_business_glossary_term' = 'Packaging Technology Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `packaging_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Technology Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `reliability_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Reliability Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `reliability_qualification_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Passed|Failed|Waived');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_code` SET TAGS ('dbx_business_glossary_term' = 'Research Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_name` SET TAGS ('dbx_business_glossary_term' = 'Research Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_objective` SET TAGS ('dbx_business_glossary_term' = 'Research Objective');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_record_code` SET TAGS ('dbx_business_glossary_term' = 'Research Record Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_record_code` SET TAGS ('dbx_value_regex' = '^PKG-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_start_date` SET TAGS ('dbx_business_glossary_term' = 'Research Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_status` SET TAGS ('dbx_business_glossary_term' = 'Research Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `research_topic` SET TAGS ('dbx_business_glossary_term' = 'Research Topic');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `target_application` SET TAGS ('dbx_value_regex' = 'HPC|AI Accelerator|Mobile|Automotive|IoT|Networking');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `test_vehicle_design_count` SET TAGS ('dbx_business_glossary_term' = 'Test Vehicle Design Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `thermal_performance_target_w_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Thermal Performance Target (Watts per Square Centimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `thermal_resistance_target_c_per_w` SET TAGS ('dbx_business_glossary_term' = 'Thermal Resistance Target (Degrees Celsius per Watt)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `warpage_target_um` SET TAGS ('dbx_business_glossary_term' = 'Warpage Target (Micrometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`packaging_research` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `yield_learning_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Learning Record Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Engineer Employee Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `process_integration_run_id` SET TAGS ('dbx_business_glossary_term' = 'Process Integration Run Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `yield_engineer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `yield_engineer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `yield_engineer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `baseline_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Baseline Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `baseline_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Baseline Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `collaboration_partner_involved` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner Involved');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `corrective_action_proposed` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Proposed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `current_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Current Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Square Centimeter (cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `defect_type_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `defect_type_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `die_count_good` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `die_count_total` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `die_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Die Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `dominant_detractor` SET TAGS ('dbx_business_glossary_term' = 'Dominant Detractor');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `dominant_yield_detractor` SET TAGS ('dbx_business_glossary_term' = 'Dominant Yield Detractor');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `equipment_id_affected` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID) Affected');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ITAR|ECCN [0-9][A-Z][0-9]{3}|Not Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `functional_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Functional Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `inspection_system_used` SET TAGS ('dbx_business_glossary_term' = 'Inspection System Used');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `learning_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Learning Cycle Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `learning_cycle_phase` SET TAGS ('dbx_business_glossary_term' = 'Learning Cycle Phase');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `learning_cycle_phase` SET TAGS ('dbx_value_regex' = 'Initial Assessment|Root Cause Analysis|Corrective Action|Validation|Closed');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `learning_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Learning Engineer Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `learning_summary` SET TAGS ('dbx_business_glossary_term' = 'Learning Summary');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `pareto_analysis_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Pareto Analysis Performed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `process_step_affected` SET TAGS ('dbx_business_glossary_term' = 'Process Step Affected');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `production_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Applicability Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `production_integration_date` SET TAGS ('dbx_business_glossary_term' = 'Production Integration Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `root_cause_analysis_findings` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Findings');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `statistical_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `statistical_confidence_level` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `technology_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `yield_improvement_delta_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Improvement Delta Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `yield_learning_record_status` SET TAGS ('dbx_business_glossary_term' = 'Yield Learning Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`yield_learning_record` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitive_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitive_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitive_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitive_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Program Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `technology_roadmap_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Roadmap Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_metric` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Metric');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_name` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_source_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_source_type` SET TAGS ('dbx_value_regex' = 'Public Disclosure|Teardown Analysis|Published Paper|Industry Report|Conference Presentation|Patent Filing');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_value_regex' = 'Draft|In Review|Approved|Archived|Superseded');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitive_benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitive_gap_analysis` SET TAGS ('dbx_business_glossary_term' = 'Competitive Gap Analysis');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitive_gap_analysis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor or Foundry Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitor_product_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Product Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitor_product_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `competitor_value` SET TAGS ('dbx_business_glossary_term' = 'Competitor Value');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'High|Medium|Low|Preliminary');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `device_architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `drive_current_ua_per_um` SET TAGS ('dbx_business_glossary_term' = 'Drive Current (Microamperes per Micrometer)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `drive_current_ua_per_um` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN [0-9][A-Z][0-9]{3}|ITAR|Public|Unclassified');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `leakage_current_na_per_um` SET TAGS ('dbx_business_glossary_term' = 'Leakage Current (Nanoamperes per Micrometer)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `leakage_current_na_per_um` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `operating_frequency_ghz` SET TAGS ('dbx_business_glossary_term' = 'Operating Frequency (Gigahertz)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `operating_frequency_ghz` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `our_value` SET TAGS ('dbx_business_glossary_term' = 'Our Value');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (Milliwatts)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `ppa_area_score` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area (PPA) Area Score');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `ppa_area_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `ppa_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area (PPA) Performance Score');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `ppa_performance_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `ppa_power_score` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area (PPA) Power Score');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `ppa_power_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `strategic_implication_assessment` SET TAGS ('dbx_business_glossary_term' = 'Strategic Implication Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `strategic_implication_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `technology_node_compared` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Compared');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `technology_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_value_regex' = 'TRL 1|TRL 2|TRL 3|TRL 4|TRL 5|TRL 6');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `transistor_density_mtransistors_per_mm2` SET TAGS ('dbx_business_glossary_term' = 'Transistor Density (Million Transistors per Square Millimeter)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`competitive_benchmark` ALTER COLUMN `transistor_density_mtransistors_per_mm2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `government_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Government Grant ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `government_principal_investigator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `government_principal_investigator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `government_principal_investigator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `awarding_agency` SET TAGS ('dbx_business_glossary_term' = 'Awarding Agency');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `chips_act_award_number` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Award Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `chips_act_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `compliance_obligations` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligations');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `deliverables_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|None');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `government_grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `government_grant_status` SET TAGS ('dbx_value_regex' = 'active|closed|suspended|pending|withdrawn');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `grant_category` SET TAGS ('dbx_business_glossary_term' = 'Grant Category');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `grant_category` SET TAGS ('dbx_value_regex' = 'research|infrastructure|equipment|collaboration');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `grant_title` SET TAGS ('dbx_business_glossary_term' = 'Grant Title');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `grant_to_program` SET TAGS ('dbx_business_glossary_term' = 'Grant To Program');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_value_regex' = 'direct_funding|tax_credit|matching_fund|equipment_grant');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `granting_agency` SET TAGS ('dbx_business_glossary_term' = 'Granting Agency');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `granting_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Granting Agency Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `matching_fund_amount` SET TAGS ('dbx_business_glossary_term' = 'Matching Fund Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `performance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `performance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `performance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `performance_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `principal_investigator_department` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Department');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Email');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `tax_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`government_grant` ALTER COLUMN `technical_scope` SET TAGS ('dbx_business_glossary_term' = 'Technical Scope');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_flow_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Experiment ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Wafer Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `fabrication_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Engineer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `primary_process_author_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `primary_process_author_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `primary_process_author_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_engineer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_engineer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_engineer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_research_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Research Project ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Related Research Program ID');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `actual_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Cycle Time (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_flow_experiment_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `doe_design_type` SET TAGS ('dbx_business_glossary_term' = 'Doe Design Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `doe_split_details` SET TAGS ('dbx_business_glossary_term' = 'DOE Split Details');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `doe_split_flag` SET TAGS ('dbx_business_glossary_term' = 'DOE Split Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `expected_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `experiment_name` SET TAGS ('dbx_business_glossary_term' = 'Experiment Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|None');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Experiment Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Experiment Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `flow_revision` SET TAGS ('dbx_business_glossary_term' = 'Flow Revision');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `flow_type` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `flow_type` SET TAGS ('dbx_value_regex' = 'research|pilot|proof_of_concept|exploratory');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `flow_variant_description` SET TAGS ('dbx_business_glossary_term' = 'Flow Variant Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `flow_version` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `key_process_parameters` SET TAGS ('dbx_business_glossary_term' = 'Key Process Parameters');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_flow_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Complexity Score');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_flow_experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_flow_experiment_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived|pending_approval|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_pressure_pa` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure (Pa)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Process Step Sequence');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `process_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `split_conditions` SET TAGS ('dbx_business_glossary_term' = 'DOE Split Conditions');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `split_count` SET TAGS ('dbx_business_glossary_term' = 'Split Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `target_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Cycle Time (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `target_device_structure` SET TAGS ('dbx_business_glossary_term' = 'Target Device Structure');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `technology_node` SET TAGS ('dbx_value_regex' = '3nm|5nm|7nm|10nm|14nm|28nm');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `tool_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_flow_experiment` ALTER COLUMN `total_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Number of Steps');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` SET TAGS ('dbx_association_edges' = 'sales.channel_partner,research.program');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `program_partner_collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'Program Partner Collaboration Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `collaboration_role` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Role');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `collaboration_scope` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Scope');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contribution Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Contribution Pct');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `deliverables` SET TAGS ('dbx_business_glossary_term' = 'Deliverables');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `funding_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Funding Share Pct');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `governance_model` SET TAGS ('dbx_business_glossary_term' = 'Governance Model');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'Ip Ownership Terms');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `ip_sharing_terms` SET TAGS ('dbx_business_glossary_term' = 'Ip Sharing Terms');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `partner_organization` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `partner_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `partner_role` SET TAGS ('dbx_business_glossary_term' = 'Partner Role');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `program_partner_collaboration_status` SET TAGS ('dbx_business_glossary_term' = 'Program Partner Collaboration Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`program_partner_collaboration` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` SET TAGS ('dbx_association_edges' = 'research.project,compliance.obligation_register');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `compliance_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `compliance_remediation_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `compliance_remediation_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `compliance_research_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `assessed_date` SET TAGS ('dbx_business_glossary_term' = 'Assessed Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `assessor` SET TAGS ('dbx_business_glossary_term' = 'Assessor');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `compliance_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Compliance Result');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `finding_summary` SET TAGS ('dbx_business_glossary_term' = 'Finding Summary');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `findings` SET TAGS ('dbx_business_glossary_term' = 'Findings');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Result');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `reviewer` SET TAGS ('dbx_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`compliance_assessment` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Test Structure Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Designer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `parent_test_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Test Structure Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `parent_test_structure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `research_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Research Technology Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `current_limit_ma` SET TAGS ('dbx_business_glossary_term' = 'Current Limit Ma');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_structure_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Url');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `feature_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Feature Size Nm');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Frequency Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `is_standard` SET TAGS ('dbx_business_glossary_term' = 'Is Standard');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `measurement_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measurement Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `measurement_purpose` SET TAGS ('dbx_business_glossary_term' = 'Measurement Purpose');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `related_process_node` SET TAGS ('dbx_business_glossary_term' = 'Related Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `structure_code` SET TAGS ('dbx_business_glossary_term' = 'Structure Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_business_glossary_term' = 'Structure Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_business_glossary_term' = 'Structure Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `structure_type` SET TAGS ('dbx_business_glossary_term' = 'Structure Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Test Duration Ms');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_methodology` SET TAGS ('dbx_business_glossary_term' = 'Test Methodology');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_purpose` SET TAGS ('dbx_business_glossary_term' = 'Test Purpose');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_structure_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_structure` ALTER COLUMN `voltage_level_mv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level Mv');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` SET TAGS ('dbx_subdomain' = 'technology_development');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_split_id` SET TAGS ('dbx_business_glossary_term' = 'Process Split Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `ip_core_development_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Ip Ip Core Development Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `experimental_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `parent_process_split_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Process Split Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `parent_process_split_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_flow_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Experiment Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Related Process Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `average_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_split_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Usd');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_split_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `last_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Date');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_split_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_split_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_split_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `process_step_count` SET TAGS ('dbx_business_glossary_term' = 'Process Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_code` SET TAGS ('dbx_business_glossary_term' = 'Split Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Split Condition Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_method` SET TAGS ('dbx_business_glossary_term' = 'Split Method');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_name` SET TAGS ('dbx_business_glossary_term' = 'Split Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_parameter` SET TAGS ('dbx_business_glossary_term' = 'Split Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_ratio` SET TAGS ('dbx_business_glossary_term' = 'Split Ratio');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_reason` SET TAGS ('dbx_business_glossary_term' = 'Split Reason');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_status` SET TAGS ('dbx_business_glossary_term' = 'Split Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `split_value` SET TAGS ('dbx_business_glossary_term' = 'Split Value');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `total_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Cycle Time Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`process_split` ALTER COLUMN `wafer_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `research_test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `ip_core_development_id` SET TAGS ('dbx_business_glossary_term' = 'Related Ip Ip Core Development Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `test_plan_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `test_plan_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `test_plan_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `test_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Test Suite Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `pass_fail_criteria` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `result_summary` SET TAGS ('dbx_business_glossary_term' = 'Result Summary');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `stakeholder` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `target_device` SET TAGS ('dbx_business_glossary_term' = 'Target Device');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `test_objective` SET TAGS ('dbx_business_glossary_term' = 'Test Objective');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `test_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `test_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`research_test_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` SET TAGS ('dbx_subdomain' = 'experimentation_execution');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Test Suite Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `parent_test_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Test Suite Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `parent_test_suite_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `ip_core_development_id` SET TAGS ('dbx_business_glossary_term' = 'Related Ip Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Research Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `research_test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_suite_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Suite Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_suite_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_suite_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `associated_process_node` SET TAGS ('dbx_business_glossary_term' = 'Associated Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `average_test_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Test Duration Seconds');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_suite_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Url');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Domain');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `estimated_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Coverage Percent');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `last_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_suite_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `pass_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pass Rate Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `source_repository` SET TAGS ('dbx_business_glossary_term' = 'Source Repository');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `suite_code` SET TAGS ('dbx_business_glossary_term' = 'Suite Code');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `suite_name` SET TAGS ('dbx_business_glossary_term' = 'Suite Name');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `suite_status` SET TAGS ('dbx_business_glossary_term' = 'Suite Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `suite_type` SET TAGS ('dbx_business_glossary_term' = 'Suite Type');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `suite_version` SET TAGS ('dbx_business_glossary_term' = 'Suite Version');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_case_count` SET TAGS ('dbx_business_glossary_term' = 'Test Case Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_count` SET TAGS ('dbx_business_glossary_term' = 'Test Count');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `test_suite_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`research`.`test_suite` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
