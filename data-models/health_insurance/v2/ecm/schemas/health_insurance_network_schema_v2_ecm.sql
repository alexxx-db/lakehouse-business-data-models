-- Schema for Domain: network | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`network` COMMENT 'Owns provider network configurations, tier assignments, in-network/out-of-network designations, geographic access standards, network adequacy metrics, and service area configurations. Manages ACO and VBC arrangement participation, network-to-plan associations, network directories, and CMS network adequacy filings. Distinct from provider identity (provider domain) and contract terms (contract domain); network owns the structural relationship between providers and plan networks.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`provider_network` (
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network. Primary key for the provider network entity.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Network Management Vendor Assignment report requires linking each provider network to its contracted vendor for credentialing and data services.',
    `aco_participation_flag` BOOLEAN COMMENT 'Indicates whether this network includes participation in ACO arrangements. True if ACO providers are part of the network, False otherwise.',
    `cms_network_code` STRING COMMENT 'The unique identifier assigned by CMS for Medicare Advantage and Part D networks. Required for all Medicare networks. Format: one letter followed by five digits.. Valid values are `^[A-Z][0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this provider network record was first created in the system. Used for audit trail and data lineage.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'The date when this provider network becomes active and available for member enrollment and provider participation. Start of the networks operational lifecycle.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `facility_count` STRING COMMENT 'The number of hospitals, skilled nursing facilities, and other institutional providers in this network. Used for facility access adequacy assessments.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_footprint` STRING COMMENT 'Comma-separated list of states, counties, or service areas where this network operates. Defines the geographic scope of provider availability and member eligibility.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_adequacy_review_date` DATE COMMENT 'The date of the most recent internal or regulatory network adequacy review. Used to track compliance with annual review requirements.',
    `line_of_business` STRING COMMENT 'The primary business segment this network serves. Commercial (employer-sponsored), Medicare (federal beneficiaries), Medicaid (state beneficiaries), Exchange (ACA marketplace), ASO (Administrative Services Only self-funded).. Valid values are `Commercial|Medicare|Medicaid|Exchange|ASO`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_enrollment_count` STRING COMMENT 'The current number of members enrolled in plans associated with this network. Used for provider-to-member ratio calculations and capacity planning.',
    `ncqa_accreditation_date` DATE COMMENT 'The date when NCQA accreditation was granted or last renewed for this network. Null if not accredited.',
    `ncqa_accreditation_status` STRING COMMENT 'The current NCQA accreditation status for this network. Accredited (full accreditation), Provisional (conditional approval), Denied (failed accreditation), Not Applicable (not seeking accreditation), Pending (under review).. Valid values are `Accredited|Provisional|Denied|Not Applicable|Pending`',
    `ncqa_expiration_date` DATE COMMENT 'The date when the current NCQA accreditation expires and renewal is required. Null if not accredited.',
    `network_adequacy_filing_date` DATE COMMENT 'The date when the most recent network adequacy filing was submitted to CMS or state regulators. Required annually for Medicare Advantage and Exchange plans.',
    `network_adequacy_status` STRING COMMENT 'Regulatory assessment of whether the network meets time-and-distance and provider-to-member ratio standards. Adequate (meets all standards), Deficient (fails standards), Conditional (approved with corrective action plan), Pending Review (under regulatory evaluation).. Valid values are `Adequate|Deficient|Conditional|Pending Review`',
    `network_code` STRING COMMENT 'Short alphanumeric code used to identify the network in operational systems, claims processing, and provider directories. Externally-known business identifier.. Valid values are `^[A-Z0-9]{3,10}$`',
    `network_description` STRING COMMENT 'Detailed narrative description of the networks design, provider composition, geographic coverage, and unique features. Used in member materials and regulatory filings.',
    `network_directory_url` STRING COMMENT 'The web URL where members and providers can access the online provider directory for this network. Required for ACA and Medicare Advantage compliance.. Valid values are `^https?://.*$`',
    `network_name` STRING COMMENT 'The official business name of the provider network (e.g., HMO Narrow Network, PPO Broad Network, Medicare Advantage Network). Human-readable identifier used in member communications and plan documents.',
    `network_status` STRING COMMENT 'Current operational status of the provider network. Active (accepting enrollments and claims), Inactive (closed to new enrollments), Suspended (temporary hold), Pending (awaiting regulatory approval), Terminated (permanently closed).. Valid values are `Active|Inactive|Suspended|Pending|Terminated`',
    `network_type` STRING COMMENT 'The structural classification of the provider network. HMO (Health Maintenance Organization) requires PCP and referrals; PPO (Preferred Provider Organization) allows out-of-network access; EPO (Exclusive Provider Organization) no out-of-network except emergency; POS (Point of Service) hybrid model; HDHP (High Deductible Health Plan) network; ACO (Accountable Care Organization) value-based network.. Valid values are `HMO|PPO|EPO|POS|HDHP|ACO`',
    `next_adequacy_review_date` DATE COMMENT 'The scheduled date for the next network adequacy review. Typically annual for Medicare Advantage and Exchange networks.',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'Indicates whether the network allows members to access out-of-network providers with cost-sharing. True for PPO and some POS networks, False for HMO and EPO.',
    `pcp_count` STRING COMMENT 'The number of primary care physicians in this network. Key metric for network adequacy and member-to-PCP ratio calculations.',
    `pcp_required_flag` BOOLEAN COMMENT 'Indicates whether members enrolled in this network are required to select a primary care physician. True for HMO and POS networks, False for PPO and EPO.',
    `provider_count` STRING COMMENT 'The total number of unique providers (physicians, facilities, ancillary) participating in this network. Used for network adequacy calculations and member communications.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether specialist visits require a referral from the PCP. True for HMO networks, False for PPO, EPO, and most POS networks.',
    `regulatory_approval_date` DATE COMMENT 'The date when the network received regulatory approval from CMS or state Department of Insurance to begin operations.',
    `service_area_type` STRING COMMENT 'The geographic granularity at which this network is defined. Statewide (entire state), Regional (multi-county region), County (county-level), ZIP (ZIP code level), National (multi-state or nationwide).. Valid values are `Statewide|Regional|County|ZIP|National`',
    `specialist_count` STRING COMMENT 'The number of specialist physicians in this network. Used for specialty access adequacy assessments.',
    `star_rating` DECIMAL(18,2) COMMENT 'The CMS Star Rating for Medicare Advantage networks, ranging from 1.0 to 5.0 stars. Based on quality measures including network access, member satisfaction, and clinical outcomes. Null for non-Medicare networks.',
    `termination_date` DATE COMMENT 'The date when this provider network ceases operations and is no longer available for new enrollments. Nullable for open-ended networks. Existing members may have run-out periods.',
    `tier_classification` STRING COMMENT 'The tiering structure of the network for cost-sharing purposes. Tier 1 (lowest cost-sharing, narrow network), Tier 2 (moderate cost-sharing), Tier 3 (highest cost-sharing, broadest access), Single Tier (no tiering), Tiered (multi-tier structure).. Valid values are `Tier 1|Tier 2|Tier 3|Single Tier|Tiered`',
    `updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this network record. Used for audit and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this provider network record was last modified. Used for audit trail and change tracking.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this network includes value-based care arrangements with providers (e.g., shared savings, bundled payments, capitation). True if VBC arrangements exist, False otherwise.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this network record. Used for audit and accountability.',
    CONSTRAINT pk_provider_network PRIMARY KEY(`provider_network_id`)
) COMMENT 'Master entity representing a named provider network — the structural grouping of providers under a specific network product (e.g., HMO Narrow Network, PPO Broad Network, Medicare Advantage Network). Owns network identity, network type (HMO, PPO, EPO, POS), line of business association, effective/termination dates, geographic footprint, CMS network ID, NCQA accreditation status, and tier classification. SSOT for network identity — distinct from plan (benefit design), provider (provider identity), and contract (reimbursement terms).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`tier` (
    `tier_id` BIGINT COMMENT 'Unique identifier for the network tier. Primary key.',
    `employee_id` BIGINT COMMENT 'User identifier or system account that created this network tier record.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network tier definitions are scoped to a specific provider network; adding provider_network_id FK establishes the parent relationship.',
    `tier_code` STRING COMMENT 'Business identifier code for the network tier (e.g., TIER1, TIER2, TIER3, OON). Used in system integrations and member communications.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `coinsurance_differential_percentage` DECIMAL(18,2) COMMENT 'Percentage coinsurance differential for this tier. Used when cost_share_differential_type is coinsurance or hybrid. Null if not applicable.',
    `copay_differential_amount` DECIMAL(18,2) COMMENT 'Fixed dollar copay differential for this tier compared to baseline tier. Used when cost_share_differential_type is copay or hybrid. Null if not applicable.',
    `cost_share_differential_type` STRING COMMENT 'Type of cost-sharing differential applied to this tier (copay, coinsurance, deductible, hybrid, or none). Determines how member out-of-pocket (OOP) costs are calculated.. Valid values are `copay|coinsurance|deductible|hybrid|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network tier record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_applies_flag` BOOLEAN COMMENT 'Indicates whether the plan deductible applies to services rendered by providers in this tier before cost-sharing begins.',
    `display_label` STRING COMMENT 'Member-facing display label for the tier shown in EOB, member portal, and Summary of Benefits and Coverage (SBC). May differ from internal tier name for clarity.',
    `effective_date` DATE COMMENT 'Date when this network tier configuration becomes active and applicable to member cost-sharing and provider network assignments.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `facility_type_applicability` STRING COMMENT 'Defines which facility types this tier applies to (all, hospital, Skilled Nursing Facility (SNF), Durable Medical Equipment (DME), lab, imaging, pharmacy, home health, or custom list). Used to segment tier assignment rules by facility type. [ENUM-REF-CANDIDATE: all|hospital|snf|dme|lab|imaging|pharmacy|home_health|custom — 9 candidates stripped; promote to reference product]',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `internal_notes` STRING COMMENT 'Internal operational notes or comments about this tier configuration. Not visible to members or external parties.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_by` STRING COMMENT 'User identifier or system account that last modified this network tier record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network tier record was last modified.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_steerage_incentive_description` STRING COMMENT 'Description of any member steerage incentives or rewards offered for using providers in this tier (e.g., reduced cost-sharing, waived deductible, wellness credits).',
    `tier_name` STRING COMMENT 'Official name of the network tier as defined in plan documents and contracts.',
    `network_adequacy_credit_flag` BOOLEAN COMMENT 'Indicates whether providers in this tier count toward CMS network adequacy standards and state Department of Insurance (DOI) access requirements.',
    `oop_max_applies_flag` BOOLEAN COMMENT 'Indicates whether member cost-sharing for this tier counts toward the plan Maximum Out-of-Pocket (MOOP) limit.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether services from providers in this tier require Prior Authorization (PA) or Utilization Management (UM) review.',
    `quality_tier_flag` BOOLEAN COMMENT 'Indicates whether this tier is designated as a quality tier based on HEDIS, STAR ratings, or other quality performance metrics.',
    `rank` STRING COMMENT 'Numeric ranking of the tier indicating preference and cost-share level. Lower rank indicates preferred tier with lower member cost-sharing (e.g., 1=Tier 1 Preferred, 2=Tier 2 Standard, 3=Tier 3 Specialty, 99=Out-of-Network).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether members must obtain a referral from their Primary Care Provider (PCP) to access providers in this tier. Typically applies to HMO and POS plans.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the state Department of Insurance (DOI) or CMS filing that approved this tier structure. Used for compliance audit trails.',
    `sbc_disclosure_text` STRING COMMENT 'Standardized disclosure text for this tier that appears in the Summary of Benefits and Coverage (SBC) document provided to members under ACA requirements.',
    `specialty_applicability` STRING COMMENT 'Defines which provider specialties this tier applies to (all, primary care only, specialist only, facility, ancillary, behavioral health, or custom list). Used to segment tier assignment rules by provider type. [ENUM-REF-CANDIDATE: all|primary_care|specialist|facility|ancillary|behavioral_health|custom — 7 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'Date when this network tier configuration is terminated and no longer applicable. Null if currently active.',
    `tier_status` STRING COMMENT 'Current lifecycle status of the network tier configuration (active, inactive, pending approval, suspended, or retired).. Valid values are `active|inactive|pending|suspended|retired`',
    `tier_type` STRING COMMENT 'Classification of the tier indicating its strategic purpose within the network design (preferred, standard, specialty, out-of-network, value-based, narrow network).. Valid values are `preferred|standard|specialty|out_of_network|value_based|narrow_network`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vbc_arrangement_eligible_flag` BOOLEAN COMMENT 'Indicates whether this tier is eligible for Value-Based Care (VBC) or Accountable Care Organization (ACO) performance incentives and shared savings arrangements.',
    CONSTRAINT pk_tier PRIMARY KEY(`tier_id`)
) COMMENT 'Defines the tier structure within a provider network — Tier 1 (preferred/lowest cost-share), Tier 2 (standard), Tier 3 (specialty/higher cost-share), and out-of-network designations. Captures tier name, tier rank, cost-share differential rules, member-facing display label, and applicability by specialty or facility type. Used to drive member cost-sharing calculations and EOB generation. Distinct from contract fee schedules (owned by contract domain).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`plan_association` (
    `plan_association_id` BIGINT COMMENT 'Unique identifier for the plan association record. Primary key for this entity.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Links each plan‑network association to its annual budget, enabling budget‑vs‑actual variance analysis for network participation.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan product that is associated with this provider network. Links to the plan and benefit domains plan entity.',
    `network_service_area_id` BIGINT COMMENT 'Reference to the geographic service area where this plan-network association is valid. Defines the counties, ZIP codes, or regions where members can access this network under this plan.',
    `filing_id` BIGINT COMMENT 'The CMS-assigned identifier for the network adequacy filing or Plan Benefit Package (PBP) submission that includes this plan-network association. Required for Medicare Advantage and Marketplace plans.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network being associated with the health plan product. Links to the network domains network configuration entity.',
    `aco_participation_flag` BOOLEAN COMMENT 'Indicates whether this plan-network association includes participation in an Accountable Care Organization arrangement. True means ACO providers are included in this network for this plan; false means no ACO participation.',
    `adequacy_certification_date` DATE COMMENT 'The date when this plan-network association was certified as meeting network adequacy requirements by the regulatory authority or internal compliance review.',
    `adequacy_review_date` DATE COMMENT 'The date of the most recent network adequacy review or assessment for this plan-network association. Used to track compliance monitoring cycles.',
    `association_code` STRING COMMENT 'Business identifier code for this plan-to-network association, used in eligibility verification (270/271 EDI transactions) and claims adjudication routing.. Valid values are `^[A-Z0-9]{6,20}$`',
    `association_name` STRING COMMENT 'Human-readable name for this plan-to-network association, typically combining plan name and network name for operational reference.',
    `association_type` STRING COMMENT 'Classification of the networks role for this plan. Primary indicates the main network for member access; supplemental provides additional coverage; specialty covers specific service categories; out-of-area supports members outside primary service area; reciprocal represents shared network arrangements; tertiary provides fallback coverage.. Valid values are `primary|supplemental|specialty|out_of_area|reciprocal|tertiary`',
    `auto_assignment_eligible_flag` BOOLEAN COMMENT 'Indicates whether members can be automatically assigned to providers in this network under this plan. Relevant for Medicaid and some Medicare programs that use auto-assignment for members who do not actively select a provider. True means eligible for auto-assignment; false means member must actively select.',
    `contract_reference_number` STRING COMMENT 'Reference to the master contract or agreement document that governs this plan-network association. Links to contract management systems for terms, rates, and legal provisions.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this plan-network association record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `directory_publication_flag` BOOLEAN COMMENT 'Indicates whether providers in this network for this plan should be published in member-facing provider directories and online search tools. True means include in directory; false means exclude (e.g., for internal or specialty networks).',
    `effective_date` DATE COMMENT 'The date when this plan-to-network association becomes active and members can begin accessing providers in this network under this plan.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'The line of business this plan-network association serves. Commercial covers employer-sponsored and individual plans; Medicare includes Medicare Advantage; Medicaid covers state programs; Marketplace represents ACA exchange plans; dual eligible serves Medicare-Medicaid beneficiaries; CHIP covers Childrens Health Insurance Program.. Valid values are `commercial|medicare|medicaid|marketplace|dual_eligible|chip`',
    `market_segment` STRING COMMENT 'The market segment this plan-network association targets. Individual covers direct-to-consumer; small group typically 2-50 employees; large group 51-999 employees; jumbo group 1000+ employees; government includes federal and state employee plans; student covers university and college plans.. Valid values are `individual|small_group|large_group|jumbo_group|government|student`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_count` STRING COMMENT 'The number of members currently enrolled in this plan who have access to this network. Used for network adequacy calculations and capacity planning.',
    `network_adequacy_status` STRING COMMENT 'Indicates whether this plan-network association meets regulatory network adequacy standards for provider access, time-and-distance requirements, and specialty coverage. Compliant meets all standards; non-compliant fails requirements; under review is being evaluated; exempt has regulatory waiver; conditional meets standards with restrictions.. Valid values are `compliant|non_compliant|under_review|exempt|conditional`',
    `network_tier` STRING COMMENT 'The tier designation of this network within the plans tiered network structure. Tier 1 typically offers lowest cost-sharing; tier 2 moderate; tier 3 highest. Preferred, standard, basic, and premium are alternative tier naming conventions used by some plans. [ENUM-REF-CANDIDATE: tier_1|tier_2|tier_3|preferred|standard|basic|premium — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this plan-network association. Used for operational notes that do not fit structured fields.',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'Indicates whether this plan provides any coverage for out-of-network services when this network is the members assigned network. True means out-of-network benefits exist (typical for PPO); false means no out-of-network coverage (typical for HMO and EPO).',
    `pcp_selection_required_flag` BOOLEAN COMMENT 'Indicates whether members enrolled in this plan with this network must select a primary care provider. Typically true for HMO and POS plans; false for PPO and EPO plans.',
    `plan_association_status` STRING COMMENT 'Current lifecycle status of the plan-network association. Active indicates operational; inactive means temporarily disabled; pending awaits regulatory approval or contract execution; suspended indicates temporary hold; terminated means permanently ended.. Valid values are `active|inactive|pending|suspended|terminated`',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether services rendered by providers in this network under this plan require prior authorization. True means PA is required; false means no PA requirement. This is a network-level default that may be overridden by specific service or provider rules.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority order of this network when multiple networks are associated with the same plan. Lower numbers indicate higher priority. Used in claims adjudication routing when a member has access to multiple networks.',
    `provider_count` STRING COMMENT 'The number of unique providers (individual practitioners and facilities) participating in this network for this plan. Used for network adequacy reporting and member communications.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether members must obtain a referral from their primary care provider to access specialists in this network under this plan. Typically true for HMO plans; false for PPO and EPO plans.',
    `regulatory_approval_date` DATE COMMENT 'The date when the regulatory authority (CMS or state DOI) approved this plan-network association for use. Required before the association can become effective.',
    `star_rating_impact_flag` BOOLEAN COMMENT 'Indicates whether provider performance in this network impacts the plans CMS Star Ratings. Applicable primarily to Medicare Advantage plans. True means network performance affects Star metrics; false means no Star impact.',
    `termination_date` DATE COMMENT 'The date when this plan-to-network association ends. Null indicates an open-ended association. After this date, members can no longer access providers in this network under this plan for new services.',
    `updated_by` STRING COMMENT 'The user identifier or system account that last modified this plan-network association record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this plan-network association record was last modified. Used for audit trail and change tracking.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this plan-network association operates under a value-based care payment model. True means providers in this network are reimbursed based on quality and outcomes; false means traditional fee-for-service.',
    `created_by` STRING COMMENT 'The user identifier or system account that created this plan-network association record. Used for audit trail and accountability.',
    CONSTRAINT pk_plan_association PRIMARY KEY(`plan_association_id`)
) COMMENT 'Association entity linking a provider network to one or more health plan products, capturing the effective period, LOB, market segment (individual, small group, large group, Medicare, Medicaid), and whether the network is the primary or supplemental network for that plan. Enables plan-to-network resolution for eligibility verification (270/271 EDI) and claims adjudication routing. Owned by the network domain as the structural bridge between network configurations and plan offerings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` (
    `adequacy_standard_id` BIGINT COMMENT 'Unique identifier for the network adequacy standard record. Primary key.',
    `compliance_regulatory_obligation_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key to compliance.compliance_regulatory_obligation.regulatory_obligation_id',
    `adequacy_standard_status` STRING COMMENT 'Current lifecycle status of this adequacy standard: active (currently enforced), inactive (not currently enforced), proposed (pending regulatory approval), superseded (replaced by newer standard), or under-review (being evaluated for changes).. Valid values are `active|inactive|proposed|superseded|under-review`',
    `after_hours_availability_required` BOOLEAN COMMENT 'Indicates whether after-hours availability (evenings, weekends, holidays) is required for this specialty and geography. True if after-hours access is mandated, false otherwise.',
    `after_hours_definition` STRING COMMENT 'Definition of what constitutes after-hours for this standard (e.g., weekdays after 5pm, weekends, 24/7 access). Null if after-hours availability is not required.',
    `appointment_type` STRING COMMENT 'Type of appointment this wait-time standard applies to: routine (non-urgent care), urgent (same-day/next-day need), preventive (wellness visits), behavioral-health (mental health/substance abuse), specialist (referral appointments), or emergency. Null if standard is not appointment-access based.. Valid values are `routine|urgent|preventive|behavioral-health|specialist|emergency`',
    `compliance_reporting_frequency` STRING COMMENT 'How often compliance with this standard must be assessed and reported to regulators: annual, semi-annual, quarterly, monthly, or on-demand (event-triggered).. Valid values are `annual|semi-annual|quarterly|monthly|on-demand`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this adequacy standard record was first created in the system. Used for audit trail and data lineage.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when this adequacy standard becomes effective and must be met. Standards change over time as regulations evolve.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exception_criteria` STRING COMMENT 'Conditions under which an exception or waiver to this standard may be granted (e.g., provider shortage area designation, rural exception, temporary hardship). Null if no exceptions allowed.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_classification` STRING COMMENT 'Geographic area classification for which this standard applies: urban (metropolitan areas), suburban (surrounding metro areas), rural (non-metropolitan), or frontier (very low population density areas). Standards vary by geography.. Valid values are `urban|suburban|rural|frontier`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this adequacy standard record was last modified. Used for audit trail and change tracking.',
    `line_of_business` STRING COMMENT 'Health insurance line of business this standard applies to: medicare-advantage (MA plans), medicaid (state programs), commercial (employer-sponsored), marketplace (ACA exchange plans), dual-eligible (Medicare-Medicaid), or all (applies to all LOBs).. Valid values are `medicare-advantage|medicaid|commercial|marketplace|dual-eligible|all`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `maximum_distance_miles` DECIMAL(18,2) COMMENT 'Maximum allowable distance in miles from member residence to nearest in-network provider of this specialty in this geographic area. Null if standard is not distance-based.',
    `maximum_travel_time_minutes` STRING COMMENT 'Maximum allowable travel time in minutes from member residence to nearest in-network provider of this specialty in this geographic area. Null if standard is not time-based.',
    `maximum_wait_time_days` STRING COMMENT 'Maximum allowable wait time in days from appointment request to appointment date for this appointment type and specialty. Null if standard is not appointment-access based.',
    `measurement_methodology` STRING COMMENT 'Description of how compliance with this standard is measured (e.g., GeoAccess analysis, member survey, claims-based appointment tracking, provider attestation). Defines the assessment approach.',
    `minimum_provider_count` STRING COMMENT 'Absolute minimum number of providers of this specialty required in the network for this geography, regardless of member count. Null if not applicable.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or special instructions related to this adequacy standard. May include implementation guidance, historical context, or regulatory interpretation.',
    `penalty_for_non_compliance` STRING COMMENT 'Description of regulatory penalties or consequences for failing to meet this standard (e.g., corrective action plan, fines, enrollment suspension, Star rating impact). Null if no specific penalty defined.',
    `plan_type` STRING COMMENT 'Type of health plan this standard applies to: HMO (Health Maintenance Organization), PPO (Preferred Provider Organization), EPO (Exclusive Provider Organization), POS (Point of Service), HDHP (High Deductible Health Plan), or all (applies to all plan types). Standards may vary by plan structure.. Valid values are `HMO|PPO|EPO|POS|HDHP|all`',
    `provider_to_member_ratio` STRING COMMENT 'Required ratio of providers to members for this specialty and geography, expressed as ratio string (e.g., 1:2000 for PCPs, 1:5000 for specialists). Null if standard is not ratio-based.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_source` STRING COMMENT 'Governing body or regulatory authority that mandates this standard: CMS (Centers for Medicare and Medicaid Services), state-DOI (State Department of Insurance), NCQA (National Committee for Quality Assurance), URAC, ACA (Affordable Care Act), or internal (company-defined standard exceeding regulatory minimums).. Valid values are `CMS|state-DOI|NCQA|URAC|ACA|internal`',
    `service_area_type` STRING COMMENT 'Geographic unit for which this standard is defined: county (county-level), zip (ZIP code level), state (state-wide), region (multi-state region), or national (nationwide standard).. Valid values are `county|zip|state|region|national`',
    `specialty_category` STRING COMMENT 'Provider specialty or facility type this standard applies to (e.g., PCP, cardiology, behavioral-health, hospital, SNF, DME). May be broad category or specific specialty code.',
    `standard_category` STRING COMMENT 'Classification of the adequacy standard type: time-distance (geographic access), provider-ratio (provider-to-member ratios), appointment-access (wait time standards), after-hours (availability requirements), telehealth-equivalency (virtual care standards), or network-composition (network mix requirements).. Valid values are `time-distance|provider-ratio|appointment-access|after-hours|telehealth-equivalency|network-composition`',
    `standard_code` STRING COMMENT 'Business identifier code for the adequacy standard (e.g., PCP_URBAN_TIME, BH_RURAL_RATIO). Used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `standard_name` STRING COMMENT 'Human-readable name of the adequacy standard (e.g., Primary Care Physician Urban Time-Distance Standard).',
    `standard_version` STRING COMMENT 'Version identifier for this standard, used to track changes over time (e.g., 2024.1, v3.0). Supports historical analysis and regulatory audit trails.',
    `telehealth_equivalency_allowed` BOOLEAN COMMENT 'Indicates whether telehealth/virtual care providers can be counted toward meeting this adequacy standard. True if telehealth equivalency is permitted, false if only in-person providers count.',
    `telehealth_percentage_cap` DECIMAL(18,2) COMMENT 'Maximum percentage of the adequacy requirement that can be met through telehealth providers (e.g., 25.00 means up to 25% of required providers can be telehealth-only). Null if no cap or telehealth not allowed.',
    `termination_date` DATE COMMENT 'Date when this adequacy standard is no longer in effect, either due to regulatory change or supersession by a new standard. Null if currently active with no planned end date.',
    `threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage of members or geographic area that must meet this standard (e.g., 90.00 means 90% of members must have access within the specified time/distance). Used for compliance measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_adequacy_standard PRIMARY KEY(`adequacy_standard_id`)
) COMMENT 'Reference entity defining all network compliance standards by specialty, facility type, and geographic area — encompassing time-distance standards (e.g., 30 miles/30 minutes for PCPs), provider-to-member ratios, appointment access wait-time standards (routine, urgent, preventive, behavioral health), after-hours availability requirements, and telehealth equivalency rules. Captures regulatory source (CMS, state DOI, NCQA, URAC), standard category (time-distance, provider-ratio, appointment-access, after-hours, telehealth-equivalency), specialty category, geographic classification (urban, suburban, rural, frontier), maximum wait time in days, threshold values, and after-hours availability flag. This is the single source of truth for all network adequacy and access compliance standards — both geographic access (time-distance, ratios) and appointment access (wait times, after-hours). Used to evaluate compliance in adequacy assessments, access surveys, and CMS/state regulatory filings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` (
    `adequacy_assessment_id` BIGINT COMMENT 'Unique identifier for the network adequacy assessment record. Primary key.',
    `adequacy_standard_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_standard. Business justification: Each adequacy assessment applies a specific adequacy standard; linking via adequacy_standard_id enables reference to the standard definition.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Adequacy assessments are performed to meet a specific regulatory obligation for network adequacy compliance.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Adequacy assessments are performed per contract to verify network adequacy obligations; link enables contract‑level performance dashboards.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Captures costs of network adequacy assessments in a cost center to support regulatory cost reporting.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with this network adequacy assessment.',
    `network_service_area_id` BIGINT COMMENT 'Identifier of the geographic service area evaluated in this assessment.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network being assessed for adequacy compliance.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Network adequacy assessments require risk pool data to evaluate member health risk distribution for compliance and planning.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether providers in the assessed specialty or facility type are accepting new patients. True if accepting, False otherwise.',
    `appointment_type_requested` STRING COMMENT 'Type of appointment requested during mystery shopper or survey assessment: routine care, urgent care, preventive visit, follow-up visit, new patient intake, or specialist referral.. Valid values are `routine|urgent|preventive|follow-up|new-patient|specialist-referral`',
    `assessment_date` DATE COMMENT 'Date on which the network adequacy assessment was conducted or completed.',
    `assessment_number` STRING COMMENT 'Business identifier for the adequacy assessment, used for external reference and regulatory submissions.',
    `assessment_period_end_date` DATE COMMENT 'End date of the evaluation period covered by this assessment.',
    `assessment_period_start_date` DATE COMMENT 'Start date of the evaluation period covered by this assessment.',
    `assessment_type` STRING COMMENT 'Type of network compliance evaluation performed: adequacy (provider count and ratio), access-survey (member experience survey), mystery-shopper (secret shopper call study), gap-analysis (deficiency identification), time-distance (geographic access compliance), or appointment-availability (wait time measurement).. Valid values are `adequacy|access-survey|mystery-shopper|gap-analysis|time-distance|appointment-availability`',
    `assessor_name` STRING COMMENT 'Name of the individual or team responsible for conducting the network adequacy assessment.',
    `assessor_organization` STRING COMMENT 'Organization or department that conducted the assessment (e.g., internal network management team, third-party consultant, regulatory auditor).',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to the network adequacy assessment, including qualitative findings or special circumstances.',
    `compliance_outcome` STRING COMMENT 'Overall compliance result of the network adequacy assessment: compliant (meets all standards), non-compliant (fails standards), partially-compliant (meets some but not all standards), under-review (pending final determination), or remediation-required (corrective action needed).. Valid values are `compliant|non-compliant|partially-compliant|under-review|remediation-required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adequacy assessment record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `facility_type` STRING COMMENT 'Type of healthcare facility evaluated in this assessment (e.g., hospital, urgent care, skilled nursing facility (SNF), ambulatory surgery center, imaging center).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gap_identified_flag` BOOLEAN COMMENT 'Indicates whether network gaps or deficiencies were identified during the assessment. True if gaps exist, False otherwise.',
    `gap_severity` STRING COMMENT 'Severity level of identified network gaps: critical (immediate member access risk), high (significant access limitation), moderate (minor access concern), or low (minimal impact).. Valid values are `critical|high|moderate|low`',
    `gold_card_provider_count` BIGINT COMMENT '',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_to_pcp_ratio` DECIMAL(18,2) COMMENT '',
    `member_to_provider_ratio` DECIMAL(18,2) COMMENT 'Calculated ratio of enrolled members to available providers in the assessed specialty or facility type, expressed as members per provider.',
    `network_type_code` STRING COMMENT '',
    `provider_count_available` STRING COMMENT 'Number of in-network providers or facilities available in the assessed specialty or facility type within the service area.',
    `provider_count_required` STRING COMMENT 'Minimum number of providers or facilities required by regulatory standards to meet network adequacy thresholds for the assessed specialty or facility type.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory body or framework for which this assessment is being conducted: CMS Medicare, CMS Marketplace, State Department of Insurance (DOI), NCQA accreditation, internal monitoring, or ACA Qualified Health Plan (QHP) certification.. Valid values are `cms-medicare|cms-marketplace|state-doi|ncqa|internal|aca-qhp`',
    `remediation_action_taken` STRING COMMENT 'Description of corrective actions taken to address identified network gaps, such as provider recruitment, contract expansion, telehealth deployment, or member outreach.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed to resolve identified network gaps and achieve compliance.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts: not-started (action plan pending), in-progress (corrective actions underway), completed (actions finished), verified (compliance confirmed), or overdue (past due date).. Valid values are `not-started|in-progress|completed|verified|overdue`',
    `specialty_type` STRING COMMENT 'Medical specialty or provider type being evaluated in this assessment (e.g., primary care, cardiology, orthopedics, behavioral health, pediatrics).',
    `submission_date` DATE COMMENT 'Date on which the network adequacy assessment was submitted to the regulatory body (CMS, State DOI, NCQA).',
    `submission_status` STRING COMMENT 'Status of the regulatory submission: draft (not yet submitted), submitted (under review), accepted (approved by regulator), rejected (not approved), or resubmission-required (corrections needed).. Valid values are `draft|submitted|accepted|rejected|resubmission-required`',
    `survey_method` STRING COMMENT 'Methodology used to conduct the assessment: member survey (CAHPS or custom), secret shopper call (mystery shopper study), provider survey (direct provider inquiry), administrative data (claims and enrollment analysis), or geospatial analysis (GIS mapping).. Valid values are `member-survey|secret-shopper-call|provider-survey|administrative-data|geospatial-analysis`',
    `telehealth_offered_flag` BOOLEAN COMMENT 'Indicates whether telehealth or virtual care options were offered as an alternative during the assessment. True if telehealth was available, False otherwise.',
    `time_distance_compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of members in the service area who have access to the assessed provider specialty or facility type within the required time and distance standards.',
    `time_distance_compliant_flag` BOOLEAN COMMENT '',
    `time_distance_standard_miles` DECIMAL(18,2) COMMENT 'Maximum distance in miles that members should travel to access the assessed provider specialty or facility type, as defined by regulatory standards.',
    `time_distance_standard_minutes` STRING COMMENT 'Maximum travel time in minutes that members should travel to access the assessed provider specialty or facility type, as defined by regulatory standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the adequacy assessment record was last modified in the system.',
    `wait_time_days_routine` STRING COMMENT 'Average number of days members wait for a routine appointment with the assessed provider specialty, measured through survey or mystery shopper methodology.',
    `wait_time_days_urgent` STRING COMMENT 'Average number of days members wait for an urgent appointment with the assessed provider specialty, measured through survey or mystery shopper methodology.',
    CONSTRAINT pk_adequacy_assessment PRIMARY KEY(`adequacy_assessment_id`)
) COMMENT 'Transactional record of a network compliance evaluation — including network adequacy assessments, access surveys, mystery shopper studies, and gap identification. Captures assessment type (adequacy, access-survey, mystery-shopper), assessment date, regulatory submission type (CMS, state DOI), specialty/facility type evaluated, provider counts, member-to-provider ratios, time-distance compliance results, wait-time measurements, survey method (member survey, secret shopper call), appointment type requested, telehealth offered flag, and overall compliance outcome. Includes detail-level gap findings as child records: specific specialty or facility type shortfalls within a geographic area, gap severity, number of providers available vs. required, remediation actions taken, and resolution status. Supports CMS network adequacy filings, NCQA HEDIS access measures (Getting Care Quickly), CAHPS survey supplementation, and targeted network development. This is the SSOT for all network compliance evaluations and their associated gap findings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` (
    `adequacy_gap_id` BIGINT COMMENT 'Unique identifier for the network adequacy gap record. Primary key.',
    `adequacy_assessment_id` BIGINT COMMENT 'Reference to the parent network adequacy assessment that identified this gap.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan affected by this network adequacy gap.',
    `network_service_area_id` BIGINT COMMENT 'Reference to the geographic service area where this adequacy gap exists.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network in which this adequacy gap exists.',
    `actual_resolution_date` DATE COMMENT 'Actual date on which this adequacy gap was resolved and the network met the applicable adequacy standard. Null if gap remains unresolved.',
    `affected_member_count` STRING COMMENT 'Estimated number of plan members residing in the affected geographic area who are impacted by this adequacy gap.',
    `available_provider_count` STRING COMMENT 'Number of providers or facilities of the specified type currently available in the network in this geographic area. Null if standard is not count-based.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this adequacy gap record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exception_approval_date` DATE COMMENT 'Date on which the regulatory exception or access plan waiver was approved by CMS or the state DOI. Null if no exception has been granted.',
    `exception_expiration_date` DATE COMMENT 'Date on which the granted regulatory exception or access plan waiver expires and the network must meet the full adequacy standard. Null if no exception has been granted or if exception is permanent.',
    `exception_granted_flag` BOOLEAN COMMENT 'Indicates whether a regulatory exception or access plan waiver has been granted by CMS or the state DOI for this adequacy gap.',
    `exception_justification` STRING COMMENT 'Business rationale and supporting documentation for the regulatory exception or access plan waiver request (e.g., rural area with limited provider availability, specialty shortage area designation, alternative access arrangements).',
    `exception_request_date` DATE COMMENT 'Date on which a regulatory exception or access plan waiver was formally requested for this adequacy gap. Null if no exception has been requested.',
    `exception_requested_flag` BOOLEAN COMMENT 'Indicates whether a regulatory exception or access plan waiver has been requested from CMS or the state DOI for this adequacy gap.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: DetectedIssue)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gap_magnitude` STRING COMMENT 'Numeric difference between required and available provider count (required minus available). Positive values indicate shortfall. Null if standard is not count-based.',
    `gap_number` STRING COMMENT 'Business identifier for the adequacy gap, used for tracking and reporting purposes.',
    `gap_severity` STRING COMMENT 'Severity classification of the adequacy gap based on magnitude of shortfall, number of affected members, and criticality of the specialty or service type. Used to prioritize remediation efforts.. Valid values are `critical|high|medium|low`',
    `gap_status` STRING COMMENT 'Current lifecycle status of the adequacy gap indicating whether it has been identified, is being remediated, has been resolved, or has received a regulatory exception or waiver.. Valid values are `identified|remediation_in_progress|resolved|exception_granted|waived`',
    `gap_type` STRING COMMENT 'Classification of the adequacy gap by the dimension of network adequacy that fails to meet standards (specialty provider shortage, facility type shortage, geographic coverage gap, time and distance standard violation, appointment wait time standard violation, or essential community provider requirement shortfall).. Valid values are `specialty|facility|geographic|time_distance|appointment_wait_time|essential_community_provider`',
    `geographic_area_code` STRING COMMENT 'Code identifying the specific geographic area affected by this adequacy gap (e.g., FIPS county code, ZIP code, CBSA code).',
    `geographic_area_name` STRING COMMENT 'Human-readable name of the geographic area affected by this adequacy gap (e.g., county name, city name, region name).',
    `geographic_area_type` STRING COMMENT 'Type of geographic unit used to define the area affected by this adequacy gap (county, ZIP code, Core-Based Statistical Area, service area, or custom region).. Valid values are `county|zip_code|cbsa|service_area|custom_region`',
    `identified_date` DATE COMMENT 'Date on which this network adequacy gap was first identified during an adequacy assessment.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'Line of business to which this adequacy gap applies (Commercial, Medicare Advantage, Medicaid, Marketplace/Exchange, or Dual Eligible Special Needs Plan). Different LOBs may have different adequacy standards.. Valid values are `commercial|medicare_advantage|medicaid|marketplace|dual_eligible`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional free-text notes, context, or commentary regarding this adequacy gap, remediation efforts, or regulatory interactions.',
    `plan_year` STRING COMMENT 'Calendar year for which this adequacy gap applies and must be remediated (e.g., 2024, 2025). Network adequacy is assessed and certified annually.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether this adequacy gap must be disclosed in regulatory filings to CMS, state DOI, or other governing bodies (e.g., QHP certification, network adequacy annual report).',
    `remediation_action` STRING COMMENT 'Description of the corrective action plan or strategy being implemented to close this adequacy gap (e.g., targeted provider recruitment, contract expansion, telehealth deployment, access plan exception request).',
    `remediation_owner` STRING COMMENT 'Name or identifier of the individual, team, or department responsible for executing the remediation action and closing this adequacy gap.',
    `required_provider_count` STRING COMMENT 'Number of providers or facilities of the specified type required to meet the adequacy standard in this geographic area. Null if standard is not count-based.',
    `specialty_code` STRING COMMENT 'Standard taxonomy code for the provider specialty or facility type that is deficient (e.g., NUCC taxonomy code for specialty providers, facility type code for facilities). Null if gap is not specialty-specific.',
    `specialty_name` STRING COMMENT 'Human-readable name of the provider specialty or facility type that is deficient (e.g., Cardiology, Skilled Nursing Facility, Primary Care Physician). Null if gap is not specialty-specific.',
    `standard_threshold` STRING COMMENT 'The regulatory or contractual adequacy standard threshold that must be met (e.g., 30 miles or 30 minutes, 1 PCP per 2000 members, 95% within 10 business days). Format varies by standard type.',
    `standard_type` STRING COMMENT 'Type of network adequacy standard that this gap violates (time and distance, provider-to-member ratio, appointment availability, or essential community provider percentage requirement).. Valid values are `time_distance|provider_to_member_ratio|appointment_availability|essential_community_provider_percentage`',
    `target_resolution_date` DATE COMMENT 'Planned date by which this adequacy gap is expected to be resolved or mitigated to meet the applicable standard.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this adequacy gap record was last modified in the system.',
    CONSTRAINT pk_adequacy_gap PRIMARY KEY(`adequacy_gap_id`)
) COMMENT 'Captures individual network adequacy gaps identified during an adequacy assessment — specific specialty or facility type shortfalls within a geographic area that fail to meet the applicable adequacy standard. Records gap type, affected specialty, geographic area, number of providers available vs. required, gap severity, remediation action taken (e.g., provider recruitment, access plan exception), and resolution status. Enables targeted network development and regulatory gap closure tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` (
    `provider_directory_id` BIGINT COMMENT 'Unique identifier for the provider directory record. Primary key for the published provider directory entry representing the member-facing view of a providers network participation.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Provider Directory Vendor Management ensures directory data is sourced from a specific vendor, required for compliance audit.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Provider Directory Maintenance: assigns an employee who updates directory entries, required for data quality and audit trails.',
    `provider_id` BIGINT COMMENT 'Reference to the provider master record. Links this directory entry to the provider identity in the provider domain.',
    `provider_network_id` BIGINT COMMENT 'Reference to the network configuration. Identifies which network this provider participates in for member directory searches.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients. Critical field for member directory searches and CMS directory accuracy compliance.',
    `accessibility_features` STRING COMMENT 'Description of specific accessibility features available at the practice location, such as wheelchair ramps, accessible parking, or assistive listening devices.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the practice location is ADA-compliant and accessible to individuals with disabilities. Supports member searches for accessible facilities.',
    `address_line_1` STRING COMMENT 'Primary street address of the practice location. First line of the physical address where the provider sees patients.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number. Optional address component for practice location.',
    `board_certification_status` STRING COMMENT 'Indicates whether the provider is board-certified in their specialty. Used for quality assessment and member directory filtering.. Valid values are `certified|not_certified|eligible|unknown`',
    `city` STRING COMMENT 'City name of the practice location. Used for geographic search and network adequacy reporting.',
    `county` STRING COMMENT 'County name of the practice location. Used for CMS network adequacy reporting and geographic access standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this provider directory record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score for this directory entry based on completeness, accuracy, and recency of verification. Range 0.00 to 100.00. Supports directory quality monitoring.',
    `directory_publication_channel` STRING COMMENT 'The channel through which this directory entry is published and accessible to members. Supports multi-channel directory distribution tracking.. Valid values are `online|print|api|mobile_app|call_center`',
    `directory_status` STRING COMMENT 'Current status of the provider directory entry. Indicates whether the entry is actively published, pending verification, or suspended from member-facing display.. Valid values are `active|inactive|pending_verification|suspended`',
    `effective_end_date` DATE COMMENT 'Date when this provider directory entry was terminated or became inactive. Null for currently active entries. Supports historical directory analysis.',
    `effective_start_date` DATE COMMENT 'Date when this provider directory entry became effective and available for member searches. Supports historical tracking of directory changes.',
    `email_address` STRING COMMENT 'Email contact for the practice location. Used for electronic communication and directory verification outreach.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the practice location. Used for prior authorization and medical records transmission.. Valid values are `^[0-9]{10}$`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gender` STRING COMMENT 'Gender of the provider. Used for member preference-based directory searches, particularly for gender-specific care.. Valid values are `male|female|non-binary|other|unknown`',
    `hospital_affiliation` STRING COMMENT 'Name of the hospital or health system with which the provider has admitting privileges or affiliation. Supports continuity of care and member decision-making.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages spoken by the provider or available at the practice location. Supports culturally competent care and member language preference searches.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this provider directory record was last modified. Supports change tracking and audit compliance.',
    `last_verification_method` STRING COMMENT 'Method used for the most recent directory verification. Tracks how the provider information was validated for audit and compliance purposes.. Valid values are `outbound_call|online_attestation|ehr_data_match|claims_inference|mail_survey|email_confirmation`',
    `last_verification_outcome` STRING COMMENT 'Outcome of the most recent verification attempt. Indicates whether information was confirmed, updated, or if verification was unsuccessful.. Valid values are `confirmed|updated|unable_to_reach|provider_declined|no_response`',
    `last_verified_date` DATE COMMENT 'Date when the provider directory information was last verified. Critical for CMS 90-day directory update mandate and No Surprises Act compliance.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_verification_due_date` DATE COMMENT 'Date by which the next directory verification must be completed. Supports compliance with CMS 90-day update mandate and quarterly verification tracking.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned by CMS. Used for provider identification in claims and directory searches.. Valid values are `^[0-9]{10}$`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the practice location. Ten-digit phone number displayed in member directory for appointment scheduling.. Valid values are `^[0-9]{10}$`',
    `practice_location_name` STRING COMMENT 'Name of the practice location or facility where the provider sees patients. Displayed in member directory for location identification.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `specialty_primary` STRING COMMENT 'The primary medical specialty or taxonomy classification of the provider. Used for member search and filtering in the directory.',
    `specialty_secondary` STRING COMMENT 'Additional specialty or sub-specialty of the provider. Supports multi-specialty provider directory searches.',
    `state` STRING COMMENT 'Two-letter state abbreviation of the practice location. Used for geographic filtering and state-level network adequacy compliance.. Valid values are `^[A-Z]{2}$`',
    `telehealth_available_flag` BOOLEAN COMMENT 'Indicates whether the provider offers telehealth or virtual visit services. Supports member search for remote care options.',
    `termination_reason` STRING COMMENT 'Reason why the provider directory entry was terminated or inactivated. Examples include provider left network, practice closed, or data quality issue.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `verified_fields` STRING COMMENT 'Comma-separated list of fields that were verified during the last verification event. Examples include address, phone, accepting_new_patients, specialty.',
    `verifying_agent` STRING COMMENT 'Name or identifier of the person or system that performed the last verification. Used for audit trail and quality assurance.',
    `website_url` STRING COMMENT 'Website address for the provider or practice location. Displayed in member directory for additional provider information.',
    `zip_code` STRING COMMENT 'Five-digit or nine-digit ZIP code of the practice location. Used for proximity-based member searches and geographic access analysis.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_provider_directory PRIMARY KEY(`provider_directory_id`)
) COMMENT 'Published provider directory record representing the member-facing view of a providers network participation, including full verification lifecycle tracking. Captures provider name, specialty, practice location, phone, accepting-new-patients status, telehealth availability, languages spoken, accessibility features (ADA compliance), last verified date, and directory publication channel (online, print, API). Embeds complete verification history as child records — including verification method (outbound call, online attestation, EHR/HIE data match, claims-based inference), verification date, verified fields (address, phone, accepting-new-patients, specialty), verification outcome (confirmed, updated, unable to reach), and verifying agent/system. Supports CMS directory accuracy requirements (42 CFR 422.111), No Surprises Act compliance, the 90-day directory update mandate, and quarterly verification tracking. This is the SSOT for member-facing directory data and its verification audit trail.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` (
    `vbc_arrangement_id` BIGINT COMMENT 'Primary key for vbc_arrangement',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tracks VBC shared‑savings and risk‑adjustment costs against a specific cost center for financial consolidation.',
    `vbc_program_id` BIGINT COMMENT 'Foreign key linking to network.vbc_program. Business justification: A VBC arrangement implements a defined VBC program; adding vbc_program_id FK ties arrangement to its program definition.',
    `arrangement_name` STRING COMMENT 'Human-readable name of the VBC arrangement or ACO program (e.g., Metro Health ACO MSSP Track 1, Regional P4P Quality Incentive Program).',
    `arrangement_number` STRING COMMENT 'Business identifier or contract number assigned to this VBC arrangement. Externally-known reference used in communications with providers and CMS.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the VBC arrangement. Tracks progression from draft through active participation to termination or completion.. Valid values are `draft|pending_approval|active|suspended|terminated|completed`',
    `arrangement_type` STRING COMMENT 'Classification of the VBC arrangement model. Distinguishes between Medicare Shared Savings Program (MSSP) tracks, Next Generation ACO, Realizing Equity Access and Community Health (REACH) ACO, commercial pay-for-performance (P4P), episode-based payment, capitation, bundled payment, or other VBC models. [ENUM-REF-CANDIDATE: mssp_track_1|mssp_track_2|mssp_track_3|next_gen_aco|reach_aco|commercial_p4p|episode_based_payment|capitation|bundled_payment|other — 10 candidates stripped; promote to reference product]',
    `attributed_member_count` STRING COMMENT 'Number of health plan members or Medicare beneficiaries attributed to this ACO or VBC arrangement for the performance period. Used for PMPM calculations and risk adjustment.',
    `attribution_methodology` STRING COMMENT 'Method used to assign members to the ACO or provider group. Prospective assigns at year start; retrospective assigns at year end based on utilization; voluntary alignment allows member choice; claims-based uses historical claims patterns.. Valid values are `prospective|retrospective|voluntary_alignment|claims_based`',
    `benchmark_amount` DECIMAL(18,2) COMMENT 'Target cost or quality benchmark value established for the performance period. Expressed in dollars for cost benchmarks or as a quality score for quality benchmarks.',
    `benchmark_methodology` STRING COMMENT 'Method used to establish the cost or quality benchmark against which performance is measured. Options include historical baseline (prior year costs), regional average, national trend, risk-adjusted PMPM, or episode target price.. Valid values are `historical_baseline|regional_average|national_trend|risk_adjusted_pmpm|episode_target_price`',
    `care_coordination_required_flag` BOOLEAN COMMENT 'Indicates whether the VBC arrangement requires formal care coordination programs (care management, transitional care, chronic disease management). True if required; False if optional or not applicable.',
    `cms_aco_code` STRING COMMENT 'CMS-assigned identifier for Medicare Shared Savings Program (MSSP) or other federally-recognized ACO arrangements. Null for commercial VBC programs.',
    `cms_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this arrangement requires formal reporting to Centers for Medicare and Medicaid Services (CMS). True for all Medicare ACOs; False for commercial-only VBC programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VBC arrangement record was first created in the system. Used for audit trail and data lineage.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_sharing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a formal data sharing agreement exists between the health plan and the ACO or provider group for claims, clinical, and quality data exchange. True if agreement is in place; False otherwise.',
    `effective_end_date` DATE COMMENT 'Date when the VBC arrangement ends or is scheduled to end. Null for open-ended arrangements. Aligns with CMS performance year end for Medicare ACOs.',
    `effective_start_date` DATE COMMENT 'Date when the VBC arrangement becomes active and performance measurement begins. Aligns with CMS performance year start for Medicare ACOs.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `health_it_certification_required_flag` BOOLEAN COMMENT 'Indicates whether participating providers must use certified Electronic Health Record (EHR) systems and meet health IT standards. True if required; False if not required.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this VBC arrangement record was last modified. Used for audit trail and change tracking.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `minimum_loss_rate` DECIMAL(18,2) COMMENT 'Minimum percentage of cost overruns before shared losses are assessed. Provides a buffer zone for two-sided risk arrangements.',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'Minimum percentage of cost savings required before shared savings are paid. Acts as a threshold to ensure savings are statistically significant.',
    `participating_aco_name` STRING COMMENT 'Legal name of the Accountable Care Organization or provider group participating in this VBC arrangement. Null for program template records.',
    `participating_provider_count` STRING COMMENT 'Number of individual providers (physicians, specialists, facilities) participating in this ACO or VBC arrangement. Used for network adequacy and capacity planning.',
    `participating_tin` STRING COMMENT 'Tax Identification Number of the participating ACO or provider organization. Used for financial settlement and IRS reporting.',
    `performance_guarantee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of financial guarantee or bond required from the ACO or provider group to participate in two-sided risk arrangements. Ensures ability to repay shared losses.',
    `performance_year` STRING COMMENT 'Calendar year for which performance is measured and financial reconciliation is calculated. Aligns with CMS performance year for Medicare ACOs.',
    `primary_care_physician_count` STRING COMMENT 'Number of primary care physicians participating in this ACO or VBC arrangement. Critical for attribution and care coordination requirements.',
    `quality_measure_set` STRING COMMENT 'Name or identifier of the quality measure set used to evaluate clinical performance (e.g., CMS ACO Quality Measures, HEDIS Comprehensive, Custom Commercial P4P Measures).',
    `quality_performance_threshold` DECIMAL(18,2) COMMENT 'Minimum quality performance score required to earn shared savings or avoid penalties. Expressed as a percentage (e.g., 70.00 for 70th percentile).',
    `reconciliation_frequency` STRING COMMENT 'Frequency at which financial performance is reconciled and shared savings or losses are calculated and settled. Most Medicare ACOs reconcile annually; commercial arrangements may reconcile more frequently.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_type` STRING COMMENT 'Distinguishes whether this record represents a program definition template (reusable VBC program design) or a specific participation instance (actual arrangement with a provider group or ACO).. Valid values are `program_template|participation_instance`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_model` STRING COMMENT 'Financial risk-sharing model of the arrangement. One-sided risk allows shared savings only; two-sided risk includes shared savings and losses; upside-only is gain-sharing; downside risk is penalty-only; full capitation transfers all risk.. Valid values are `one_sided_risk|two_sided_risk|upside_only|downside_risk|full_capitation`',
    `service_area_description` STRING COMMENT 'Geographic description of the service area covered by this VBC arrangement (e.g., Statewide California, Metro Atlanta Region, National Medicare Population).',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'Percentage of cost overruns above benchmark that the ACO or provider group is responsible for under two-sided risk models. Null for one-sided risk arrangements.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'Percentage of cost savings below benchmark that the ACO or provider group earns as shared savings. Expressed as a percentage (e.g., 50.00 for 50%).',
    `specialist_physician_count` STRING COMMENT 'Number of specialist physicians participating in this ACO or VBC arrangement. Used for network adequacy and specialty care access analysis.',
    `sponsoring_entity_name` STRING COMMENT 'Name of the organization sponsoring or administering the VBC program (e.g., health plan name, CMS for federal programs, employer group for commercial arrangements).',
    `stop_loss_limit` DECIMAL(18,2) COMMENT 'Maximum financial loss amount the ACO or provider group is responsible for under two-sided risk arrangements. Provides downside risk protection. Null for one-sided risk or full capitation models.',
    `termination_date` DATE COMMENT 'Actual date the VBC arrangement was terminated or withdrawn. Null for active or completed arrangements. Distinct from effective_end_date which is the scheduled end.',
    `termination_reason` STRING COMMENT 'Business reason for early termination of the VBC arrangement (e.g., Poor Financial Performance, Provider Withdrawal, Regulatory Non-Compliance, Mutual Agreement). Null for arrangements that completed their term.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_vbc_arrangement PRIMARY KEY(`vbc_arrangement_id`)
) COMMENT 'Master entity representing Value-Based Care (VBC) programs and their participation arrangements — covering both program design (program type, sponsoring entity, quality measure set, risk model, benchmark methodology) and specific ACO/VBC participation instances (ACO name, CMS ACO ID, arrangement dates, shared savings/risk terms, participating provider groups). Supports MSSP, Next Gen, REACH, commercial P4P, episode-based payment, and capitation models. Records may represent a program definition (template) or a specific arrangement instance (participation record), distinguished by record type. Owned by the network domain as the structural participation record — financial settlement terms are owned by the contract domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` (
    `aco_provider_id` BIGINT COMMENT 'Unique identifier for the ACO provider association record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns ACO provider‑related expenses and shared‑savings allocations to a cost center for proper accounting.',
    `practice_location_id` BIGINT COMMENT 'Reference to the primary service location or facility where this provider delivers care under the ACO arrangement. Used for geographic attribution and network adequacy.',
    `vbc_arrangement_id` BIGINT COMMENT 'Reference to the parent ACO arrangement that this provider participates in. Links to the ACO contract or arrangement entity.',
    `attributed_member_count` STRING COMMENT 'The number of members currently attributed to this provider for ACO performance measurement and shared savings calculations.',
    `attribution_methodology` STRING COMMENT 'The method used to assign members to this provider for ACO performance measurement and shared savings calculations.. Valid values are `prospective|retrospective|voluntary|claims_based`',
    `care_coordination_tier` STRING COMMENT 'The tier level assigned to this provider for care coordination responsibilities and support services within the ACO. Higher tiers indicate greater care management obligations.. Valid values are `tier_1|tier_2|tier_3|standard`',
    `cost_efficiency_score` DECIMAL(18,2) COMMENT 'The cost efficiency or resource utilization score for this provider within the ACO arrangement. Used for shared savings calculations. Expressed as a percentage (0.00 to 100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ACO provider participation record was first created in the system. Audit trail field.',
    `credentialing_status` STRING COMMENT 'The credentialing status of this provider for ACO participation. Providers must maintain active credentialing to remain eligible for attribution and shared savings.. Valid values are `credentialed|pending|expired|suspended`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'The date when this providers participation in the ACO arrangement becomes active and member attribution begins.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `ehr_integration_flag` BOOLEAN COMMENT 'Indicates whether this providers EHR system is integrated with the ACOs health information exchange for care coordination and quality reporting. True if integrated.',
    `enrollment_date` DATE COMMENT 'The date when the provider formally enrolled or was onboarded into the ACO arrangement. May differ from effective_date if there is a waiting period.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `internal_notes` STRING COMMENT 'Free-text field for internal comments, special instructions, or contextual information about this providers ACO participation. Not shared externally.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_credentialing_date` DATE COMMENT 'The date when the providers credentials were last verified for ACO participation. Used to track recredentialing cycles.',
    `last_updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that most recently modified this ACO provider participation record. Audit trail field.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this ACO provider participation record was most recently modified. Audit trail field.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_credentialing_date` DATE COMMENT 'The date when the providers credentials are due for renewal or recredentialing for continued ACO participation.',
    `panel_size_limit` STRING COMMENT 'The maximum number of members that can be attributed to this provider under the ACO arrangement. Null if no limit is defined.',
    `participation_role` STRING COMMENT 'The functional role this provider plays within the ACO structure. Determines attribution rules and quality measure accountability.. Valid values are `primary_care|specialist|facility|ancillary|behavioral_health|post_acute`',
    `participation_status` STRING COMMENT 'Current lifecycle status of the providers participation in the ACO arrangement. Determines whether the provider is eligible for attribution and shared savings.. Valid values are `active|inactive|suspended|pending|terminated`',
    `participation_type` STRING COMMENT 'The level of financial risk and participation commitment for this provider within the ACO arrangement.. Valid values are `full_risk|shared_savings|preferred|affiliate|network_only`',
    `performance_year` STRING COMMENT 'The calendar year for which this provider participation record applies. Used for year-over-year performance tracking and historical analysis.',
    `primary_care_flag` BOOLEAN COMMENT 'Indicates whether this provider serves as a primary care physician (PCP) for attribution purposes within the ACO. True if the provider is eligible to be an attribution anchor.',
    `provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier for the individual provider participating in the ACO. Used when the participant is an individual practitioner.. Valid values are `^[0-9]{10}$`',
    `provider_tin` STRING COMMENT 'The 9-digit Tax Identification Number for the provider group or organization participating in the ACO. Used when the participant is a group practice or facility.. Valid values are `^[0-9]{9}$`',
    `quality_reporting_flag` BOOLEAN COMMENT 'Indicates whether this provider is required to submit quality measure data as part of ACO performance reporting. True if the provider must report HEDIS or CMS Star measures.',
    `quality_score` DECIMAL(18,2) COMMENT 'The composite quality performance score for this provider within the ACO arrangement. Used for performance-based incentive calculations. Expressed as a percentage (0.00 to 100.00).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_sharing_percentage` DECIMAL(18,2) COMMENT 'The percentage of financial risk (upside and downside) that this provider assumes under the ACO arrangement. Expressed as a percentage (e.g., 25.00 for 25%).',
    `shared_savings_eligible_flag` BOOLEAN COMMENT 'Indicates whether this provider is eligible to receive shared savings distributions based on ACO performance. True if the provider participates in financial upside.',
    `specialty_code` STRING COMMENT 'The primary specialty or taxonomy code for this provider within the ACO context. Used for role-based performance measurement and network adequacy assessment.',
    `termination_date` DATE COMMENT 'The date when this providers participation in the ACO arrangement ends. Null if participation is ongoing.',
    `termination_reason_code` STRING COMMENT 'The reason code indicating why the providers participation in the ACO was terminated. Null if participation is active or pending.. Valid values are `voluntary|performance|compliance|contract_end|merger|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vbc_track` STRING COMMENT 'The specific CMS MSSP track or value-based care program track that this provider participates in under the ACO arrangement. Determines risk level and savings methodology.. Valid values are `track_1|track_2|track_3|enhanced|basic`',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this ACO provider participation record. Audit trail field.',
    CONSTRAINT pk_aco_provider PRIMARY KEY(`aco_provider_id`)
) COMMENT 'Association entity linking individual providers (by NPI) or provider groups (by TIN) to an ACO arrangement, capturing participation role (primary care, specialist, facility), effective dates, attribution methodology (prospective, retrospective), panel size, and active status. Enables attribution of members to ACO providers for shared savings calculations and quality reporting. Distinct from network_provider (which tracks network participation) — this tracks ACO-specific participation roles.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`exception` (
    `exception_id` BIGINT COMMENT 'Unique identifier for the network adequacy exception record. Primary key.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Exception Appeal Tracking process records when a member appeals a network exception decision, linking exception to the appeal case.',
    `benefit_package_id` BIGINT COMMENT 'CMS Plan Benefit Package identifier for the specific Medicare Advantage plan affected by this exception.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Contract exceptions are recorded against the governing provider contract for audit and exception‑management workflows.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with this network adequacy exception, if applicable.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network for which the adequacy exception applies.',
    `affected_member_count` STRING COMMENT 'Estimated number of plan members residing in the affected geographic area who may be impacted by the network adequacy gap.',
    `alternative_access_arrangement` STRING COMMENT 'Description of alternative access arrangements provided to members in lieu of meeting standard adequacy (e.g., telehealth services, out-of-network reimbursement at in-network rates, transportation assistance).',
    `appeal_decision` STRING COMMENT 'Outcome of the appeal process if an appeal was filed: upheld (denial confirmed), overturned (exception granted on appeal), or pending (appeal under review). Null if no appeal filed.. Valid values are `upheld|overturned|pending`',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal was filed in response to a denial of this exception request. True if appeal filed, false otherwise.',
    `approval_date` DATE COMMENT 'Date the exception was approved by the regulatory body. Null if not yet approved or if denied.',
    `approved_terms` STRING COMMENT 'Specific terms and conditions under which the exception was granted by the regulatory body, including any requirements, limitations, or reporting obligations.',
    `cms_contract_number` STRING COMMENT 'CMS Medicare Advantage or Part D contract number associated with this exception filing, if applicable to Medicare lines of business.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exception record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_date` DATE COMMENT 'Date the exception was denied by the regulatory body. Null if approved or still under review.',
    `effective_date` DATE COMMENT 'Date from which the approved exception terms become effective and the network adequacy waiver applies.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exception_number` STRING COMMENT 'External filing or tracking number assigned by the regulatory body or internal system for this exception request.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception filing: draft (being prepared), submitted (filed with regulator), under review (regulator reviewing), approved (exception granted), denied (exception rejected), withdrawn (voluntarily withdrawn), or expired (approval period ended). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|denied|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `exception_type` STRING COMMENT 'Category of network adequacy exception being filed: time-distance waiver (cannot meet time/distance standards), rural exception (rural area with limited providers), access plan (formal plan to address gaps), specialty shortage (insufficient specialists in area), temporary disruption (short-term network change), or other.. Valid values are `time_distance_waiver|rural_exception|access_plan|specialty_shortage|temporary_disruption|other`',
    `expiration_date` DATE COMMENT 'Date on which the approved exception expires and standard network adequacy requirements resume. Null for indefinite exceptions.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_date` DATE COMMENT 'Date the exception request was officially submitted to the regulatory body.',
    `geographic_description` STRING COMMENT 'Textual description of the geographic area affected by the exception, including counties, ZIP codes, or other location identifiers.',
    `internal_notes` STRING COMMENT 'Internal operational notes regarding the exception filing, review process, or follow-up actions. Not shared with regulatory bodies or members.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_by` STRING COMMENT 'User ID or name of the person who last updated this exception record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this exception record was most recently updated.',
    `lob` STRING COMMENT 'Line of business to which this network adequacy exception applies: Medicare Advantage, Medicaid, commercial, marketplace (ACA exchange), or dual eligible (Medicare-Medicaid).. Valid values are `medicare_advantage|medicaid|commercial|marketplace|dual_eligible`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_notification_date` DATE COMMENT 'Date on which affected members were notified of the network adequacy exception and alternative access options. Null if notification not yet completed or not required.',
    `member_notification_flag` BOOLEAN COMMENT 'Indicates whether members in the affected area must be notified of the network adequacy exception and alternative access arrangements. True if notification is required, false otherwise.',
    `mitigation_plan` STRING COMMENT 'Description of the health plans strategy to mitigate member access issues during the exception period, such as out-of-network coverage, telehealth options, or provider recruitment efforts.',
    `provider_recruitment_effort` STRING COMMENT 'Summary of the health plans efforts to recruit additional providers in the affected specialty and geographic area to resolve the adequacy gap.',
    `reason` STRING COMMENT 'Detailed explanation of why the network cannot meet standard adequacy thresholds in this area, including market conditions, provider availability, and geographic constraints.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body` STRING COMMENT 'The regulatory authority to which this exception is filed: CMS (Centers for Medicare and Medicaid Services) for Medicare Advantage, state DOI (Department of Insurance) for commercial/Medicaid, NCQA (National Committee for Quality Assurance) for accreditation, or other.. Valid values are `cms|state_doi|ncqa|other`',
    `regulatory_jurisdiction` STRING COMMENT 'Specific jurisdiction or state where the exception is filed (e.g., state abbreviation for state DOI filings, or Federal for CMS).',
    `review_due_date` DATE COMMENT 'Expected or required date by which the regulatory body must complete review of the exception request.',
    `service_area_code` STRING COMMENT 'Code identifying the geographic service area where the network adequacy gap exists (e.g., county code, ZIP code, service area identifier).',
    `specialty_code` STRING COMMENT 'Code identifying the provider specialty or service type affected by this exception (e.g., cardiology, orthopedic surgery, behavioral health). May reference taxonomy codes or internal specialty classifications.',
    `specialty_name` STRING COMMENT 'Human-readable name of the provider specialty or service type affected by this exception.',
    `supporting_documentation_reference` STRING COMMENT 'Reference identifier or location of supporting documentation submitted with the exception filing (e.g., provider availability analysis, geographic access study, member impact assessment).',
    `time_distance_standard_waived` STRING COMMENT 'Specific time or distance standard that is waived under this exception (e.g., 30 minutes/30 miles for primary care). Applicable for time-distance waiver exception types.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this exception record.',
    CONSTRAINT pk_exception PRIMARY KEY(`exception_id`)
) COMMENT 'Transactional record of a network adequacy exception or access plan filed with a regulator when a network cannot meet standard adequacy thresholds in a specific geographic area or specialty. Captures exception type (time-distance waiver, rural exception, access plan), affected network, specialty, geographic area, regulatory body (CMS, state DOI), filing date, approval status, approved exception terms, and expiration date. Supports CMS HPMS exception filings and state DOI access plan submissions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`change_event` (
    `change_event_id` BIGINT COMMENT 'Unique identifier for the network change event record. Primary key.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Network change events can trigger contract amendments; the link supports amendment impact analysis and regulatory reporting.',
    `employee_id` BIGINT COMMENT 'Party that initiated the network change event: provider, health plan, regulatory authority, or mutual agreement.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network affected by this change event.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Each network change event is triggered by a regulatory change, tracked for compliance impact and reporting.',
    `aco_participation_flag` BOOLEAN COMMENT 'Indicates whether this change event affects the providers participation in an Accountable Care Organization arrangement.',
    `change_approval_date` DATE COMMENT 'Date when the network change was approved internally by the health plan.',
    `change_effective_date` DATE COMMENT 'Date when the network change becomes effective and operational.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the reason for the network change (e.g., voluntary termination, contract non-renewal, credentialing revocation, network expansion, quality improvement).',
    `change_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for the network change event.',
    `change_request_date` DATE COMMENT 'Date when the network change was formally requested or submitted for processing.',
    `change_status` STRING COMMENT 'Current status of the network change event in its lifecycle.. Valid values are `pending|approved|effective|cancelled|reversed`',
    `change_type` STRING COMMENT 'Type of network change event: addition (new provider to network), termination (provider exit), tier reassignment (tier level change), panel status change (open/closed status), service area modification (geographic coverage change), or credentialing status change.. Valid values are `addition|termination|tier_reassignment|panel_status_change|service_area_modification|credentialing_status_change`',
    `continuity_of_care_end_date` DATE COMMENT 'Date through which continuity-of-care obligations extend for members in active treatment with the terminated provider. Supports No Surprises Act compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this change event record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `facility_type` STRING COMMENT 'Type of facility affected by this change event (e.g., hospital, ambulatory surgery center, skilled nursing facility, imaging center). Applicable for facility-based providers.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `internal_notes` STRING COMMENT 'Internal operational notes and comments regarding the network change event. Not for external disclosure.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_by` STRING COMMENT 'User identifier or system account that last modified this change event record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this change event record was last modified.',
    `lob_applicability` STRING COMMENT 'Comma-separated list of lines of business affected by this change event (e.g., Commercial, Medicare Advantage, Medicaid, Exchange/QHP).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_impact_count` STRING COMMENT 'Number of members actively attributed to or receiving care from the provider at the time of the change event. Used for member transition planning and regulatory reporting.',
    `member_notification_required_flag` BOOLEAN COMMENT 'Indicates whether member notification is required for this change event per CMS and state DOI regulations.',
    `member_notification_sent_date` DATE COMMENT 'Date when member notification letters or communications were sent regarding this network change.',
    `member_notification_status` STRING COMMENT 'Current status of member notification process for this change event.. Valid values are `not_required|pending|sent|acknowledged|failed`',
    `member_transition_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal member transition plan is required for this change event to ensure continuity of care.',
    `network_adequacy_impact_flag` BOOLEAN COMMENT 'Indicates whether this change event materially impacts network adequacy standards for time and distance access requirements.',
    `new_panel_status` STRING COMMENT 'Provider panel status after the change event: open (accepting new patients), closed (not accepting new patients), or limited (accepting with restrictions).. Valid values are `open|closed|limited`',
    `new_tier_code` STRING COMMENT 'Network tier code assigned to the provider after the change event. Applicable for tier reassignment and addition change types.',
    `prior_panel_status` STRING COMMENT 'Provider panel status before the change event: open (accepting new patients), closed (not accepting new patients), or limited (accepting with restrictions).. Valid values are `open|closed|limited`',
    `prior_tier_code` STRING COMMENT 'Network tier code assigned to the provider before the change event. Applicable for tier reassignment change types.',
    `provider_directory_update_date` DATE COMMENT 'Date when the provider directory was updated to reflect this network change event.',
    `provider_npi` STRING COMMENT 'Ten-digit National Provider Identifier of the provider impacted by this network change event.. Valid values are `^[0-9]{10}$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_approval_date` DATE COMMENT 'Date when the regulatory authority approved the network change filing.',
    `regulatory_filing_date` DATE COMMENT 'Date when the network change was filed with the applicable regulatory authority (CMS, state DOI).',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier assigned by the regulatory authority for this network change filing.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this change event must be reported to CMS, state DOI, or other regulatory bodies.',
    `service_area_code` STRING COMMENT 'Code identifying the geographic service area affected by this change event. Applicable for service area modification change types.',
    `specialty_type` STRING COMMENT 'Provider specialty or taxonomy code affected by this change event. Relevant for network adequacy and access monitoring.',
    `termination_notice_date` DATE COMMENT 'Date when formal termination notice was issued to the provider and/or members. Required for CMS 30-day member notification compliance.',
    `termination_type` STRING COMMENT 'Classification of termination event: voluntary (provider-initiated), for-cause (plan-initiated due to quality or compliance issues), contract non-renewal, credentialing revocation, mutual agreement, or network restructuring. Applicable only when change_type is termination.. Valid values are `voluntary|for_cause|contract_non_renewal|credentialing_revocation|mutual_agreement|network_restructuring`',
    `transition_plan_completion_date` DATE COMMENT 'Date when the member transition plan was completed and all affected members were successfully transitioned to alternative providers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this change event affects the providers participation in a Value-Based Care arrangement.',
    `created_by` STRING COMMENT 'User identifier or system account that created this change event record.',
    CONSTRAINT pk_change_event PRIMARY KEY(`change_event_id`)
) COMMENT 'Transactional record capturing all material changes to provider network composition — provider additions, terminations (voluntary, for-cause, contract non-renewal, credentialing revocation), tier reassignments, panel status changes, and service area modifications. For terminations, captures termination type, continuity-of-care obligation period, termination reason code, member transition planning, notice date, and member notification status. For all change types, records change type, effective date, impacted provider NPI, change reason, member impact count, and regulatory reporting status. Supports CMS 30-day member notification requirements, state DOI network change and termination notification filings, continuity-of-care compliance under the No Surprises Act, and network stability monitoring. This is the SSOT for all network composition changes including terminations — replaces the need for a separate termination entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`access_standard` (
    `access_standard_id` BIGINT COMMENT 'Unique identifier for the access standard record. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key to compliance.compliance_regulatory_obligation.regulatory_obligation_id',
    `superseded_by_standard_access_standard_id` BIGINT COMMENT 'Reference to the access_standard_id of the newer standard that replaces this one, if status is superseded. Enables version tracking and historical compliance analysis.',
    `access_standard_status` STRING COMMENT 'Current lifecycle status of the access standard: active (in force and monitored), inactive (no longer enforced), draft (under development), pending_approval (awaiting regulatory or executive approval), superseded (replaced by a newer version).. Valid values are `active|inactive|draft|pending_approval|superseded`',
    `after_hours_availability_required_flag` BOOLEAN COMMENT 'Indicates whether providers must offer after-hours (evening, weekend, or holiday) appointment availability to meet this access standard. True for urgent care, behavioral health crisis, and certain primary care standards; false for routine specialty care.',
    `appointment_type_scope` STRING COMMENT 'Defines whether this access standard applies to new patient appointments, established patient follow-ups, specialist consultations, or all appointment types. New patient access is typically more stringent than follow-up access.. Valid values are `new_patient|established_patient|follow_up|consultation|all`',
    `compliance_measurement_method` STRING COMMENT 'The method used to measure and audit compliance with this access standard: appointment_log_audit (review of provider scheduling systems), member_survey (CAHPS or custom surveys), secret_shopper (test calls to provider offices), provider_attestation (self-reported compliance), claims_analysis (time between referral and service date in claims data).. Valid values are `appointment_log_audit|member_survey|secret_shopper|provider_attestation|claims_analysis`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this access standard record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'The date on which this access standard becomes enforceable. Aligns with regulatory effective dates, contract year start, or accreditation cycle.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exception_criteria` STRING COMMENT 'Conditions under which this access standard may be waived or modified (e.g., rural service area with documented provider shortage, member preference for delayed appointment, specialist unavailability due to leave). Used for compliance reporting and grievance resolution.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `internal_notes` STRING COMMENT 'Free-text field for operational notes, implementation guidance, or context for network management and compliance teams. Not disclosed to members or regulators.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_by` STRING COMMENT 'The user ID or system account that last modified this access standard record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this access standard record was most recently modified.',
    `line_of_business_applicability` STRING COMMENT 'Comma-separated list of lines of business to which this access standard applies (e.g., Commercial, Medicare Advantage, Medicaid, Exchange/QHP). Some standards are federally mandated for Medicare/Medicaid; others are state-specific or voluntary for commercial plans.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `maximum_wait_time_days` STRING COMMENT 'The maximum number of calendar days allowed between the members request for an appointment and the scheduled appointment date. For urgent care, this is typically 1-2 days; for routine care, 7-30 days depending on specialty and regulatory requirements.',
    `maximum_wait_time_hours` STRING COMMENT 'For emergent or crisis access standards, the maximum number of hours allowed for appointment availability (e.g., behavioral health crisis must be seen within 6 hours). Null for standards measured in days.',
    `member_age_group` STRING COMMENT 'The member age cohort to which this access standard applies: pediatric (under 18), adult (18-64), geriatric (65+), or all. Pediatric and geriatric populations often have stricter access requirements.. Valid values are `pediatric|adult|geriatric|all`',
    `monitoring_frequency` STRING COMMENT 'How often compliance with this access standard is measured and reported: monthly (for high-risk or CMS-mandated standards), quarterly (typical for HEDIS and accreditation), semi_annual, annual (for internal benchmarks), or continuous (real-time monitoring via appointment systems).. Valid values are `monthly|quarterly|semi_annual|annual|continuous`',
    `network_adequacy_credit_flag` BOOLEAN COMMENT 'Indicates whether meeting this access standard contributes to network adequacy compliance calculations for regulatory filings. True for standards tied to CMS or state DOI network adequacy requirements; false for internal quality benchmarks.',
    `penalty_for_noncompliance` STRING COMMENT 'Description of the consequences for failing to meet this access standard: regulatory sanctions, accreditation downgrade, member grievance escalation, provider contract breach, financial penalties, or corrective action plan requirements.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory or accreditation standard citation (e.g., 42 CFR 438.206, NCQA HEDIS AAP measure, State Insurance Code Section 1367.03). Provides traceability to the authoritative source.',
    `regulatory_source` STRING COMMENT 'The governing body or accreditation organization that mandates or recommends this access standard: NCQA (National Committee for Quality Assurance), URAC (health care accreditation), CMS (Centers for Medicare and Medicaid Services), state_doi (State Department of Insurance), aca (Affordable Care Act QHP standards), internal (health plans own standards exceeding regulatory minimums), joint_commission (for facility-based care). [ENUM-REF-CANDIDATE: ncqa|urac|cms|state_doi|aca|internal|joint_commission — 7 candidates stripped; promote to reference product]',
    `specialty_category` STRING COMMENT 'The provider specialty or service category to which this access standard applies (e.g., Primary Care, Cardiology, Orthopedics, Behavioral Health, Obstetrics). May be null for standards that apply across all specialties.',
    `standard_code` STRING COMMENT 'Business identifier code for the access standard, used for external reference and reporting (e.g., ROUTINE_PCP, URGENT_SPEC, BH_CRISIS).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `standard_name` STRING COMMENT 'Human-readable name of the access standard (e.g., Routine Primary Care Appointment, Urgent Specialty Care, Behavioral Health Crisis Access).',
    `standard_type` STRING COMMENT 'Classification of the access standard by care urgency and category: routine (non-urgent scheduled care), urgent (same-day or next-day need), emergent (immediate life-threatening), preventive (wellness and screening), behavioral_health (mental health and substance use), specialty (specialist consultation).. Valid values are `routine|urgent|emergent|preventive|behavioral_health|specialty`',
    `telehealth_equivalency_flag` BOOLEAN COMMENT 'Indicates whether telehealth (virtual) appointments satisfy this access standard in lieu of in-person visits. True for most routine and behavioral health standards post-COVID; may be false for certain procedures requiring physical examination.',
    `termination_date` DATE COMMENT 'The date on which this access standard is no longer in effect, either due to regulatory change, standard revision, or plan policy update. Null for currently active standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'The user ID or system account that created this access standard record.',
    CONSTRAINT pk_access_standard PRIMARY KEY(`access_standard_id`)
) COMMENT 'Reference entity defining appointment access and availability standards for the network — capturing standard type (routine, urgent, preventive, behavioral health), specialty category, maximum wait time in days, after-hours availability requirement, telehealth equivalency flag, and the regulatory or accreditation source (NCQA, URAC, state DOI, CMS). Distinct from adequacy_standard (which governs time-distance and provider-to-member ratios) — access_standard governs appointment availability and wait time compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`access_survey` (
    `access_survey_id` BIGINT COMMENT 'Unique identifier for the access survey record. Primary key.',
    `adequacy_assessment_id` BIGINT COMMENT 'add column adequacy_assessment_id (BIGINT) with FK to network.adequacy_assessment.adequacy_assessment_id - surveys feed adequacy assessments',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or entity who conducted the survey (internal auditor, third-party vendor, or member identifier).',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member who participated in the survey, if the survey was member-initiated. Null for mystery shopper surveys.',
    `provider_id` BIGINT COMMENT 'Internal identifier of the provider being surveyed for access.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the network in which the surveyed provider participates.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is accepting new patients at the time of the survey.',
    `access_standard_met_flag` BOOLEAN COMMENT 'Indicates whether the wait time offered meets the health plans network adequacy access standards for the appointment type and specialty.',
    `access_standard_threshold_days` STRING COMMENT 'The maximum number of days allowed by the health plans access standard for the requested appointment type and specialty.',
    `accessibility_accommodation_available_flag` BOOLEAN COMMENT 'Indicates whether the provider confirmed availability of requested accessibility accommodations.',
    `accessibility_accommodation_requested_flag` BOOLEAN COMMENT 'Indicates whether the surveyor requested accessibility accommodations (e.g., wheelchair access, hearing assistance) during the survey.',
    `after_hours_access_available_flag` BOOLEAN COMMENT 'Indicates whether the provider offers after-hours appointment availability (evenings or weekends).',
    `appointment_offered_date` DATE COMMENT 'Specific date of the earliest appointment offered by the provider during the survey.',
    `appointment_reason` STRING COMMENT 'Brief description of the reason for the appointment request used in the survey scenario.',
    `appointment_scheduled_flag` BOOLEAN COMMENT 'Indicates whether an appointment was successfully scheduled during the survey interaction.',
    `appointment_type_requested` STRING COMMENT 'Type of appointment requested during the survey (e.g., routine, urgent, preventive, follow-up).. Valid values are `routine|urgent|preventive|follow_up|new_patient|established_patient`',
    `cahps_survey_supplementation_flag` BOOLEAN COMMENT 'Indicates whether this survey result supplements CAHPS survey data for access and appointment availability measures.',
    `call_attempts` STRING COMMENT 'Number of call attempts made before achieving the final call outcome.',
    `call_outcome` STRING COMMENT 'Outcome of the telephonic survey attempt (e.g., completed, no answer, disconnected).. Valid values are `completed|no_answer|busy|disconnected|wrong_number|voicemail`',
    `cms_star_rating_applicable_flag` BOOLEAN COMMENT 'Indicates whether this survey result contributes to CMS Star Ratings for Medicare Advantage or Part D plans.',
    `compliance_outcome` STRING COMMENT 'Overall compliance outcome of the survey against network adequacy and access standards.. Valid values are `compliant|non_compliant|not_applicable|inconclusive`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_source` STRING COMMENT 'Source system or vendor that provided the survey data (e.g., internal audit team, third-party survey vendor, member portal).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hedis_measure_applicable_flag` BOOLEAN COMMENT 'Indicates whether this survey result is applicable to HEDIS Getting Care Quickly or other HEDIS access measures.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language_requested` STRING COMMENT 'Language in which the survey was conducted or appointment was requested (e.g., English, Spanish, Mandarin).',
    `language_services_available_flag` BOOLEAN COMMENT 'Indicates whether the provider offered language interpretation or multilingual services during the survey.',
    `last_updated_by` STRING COMMENT 'User or system identifier that last modified the survey record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was last modified.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_adequacy_filing_applicable_flag` BOOLEAN COMMENT 'Indicates whether this survey result is used in state or federal network adequacy filings and compliance reporting.',
    `non_compliance_reason` STRING COMMENT 'Explanation of why the survey result was non-compliant, if applicable (e.g., wait time exceeded standard, provider not accepting patients).',
    `npi` STRING COMMENT 'Ten-digit National Provider Identifier of the surveyed provider as assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `specialty_code` STRING COMMENT 'Code representing the specialty of the provider being surveyed (e.g., primary care, cardiology, orthopedics).',
    `specialty_name` STRING COMMENT 'Human-readable name of the provider specialty being surveyed.',
    `survey_cycle` STRING COMMENT 'Identifier of the survey cycle or campaign to which this survey belongs (e.g., Q1 2024 Network Adequacy Audit).',
    `survey_date` DATE COMMENT 'Date on which the access survey was conducted.',
    `survey_method` STRING COMMENT 'Method used to conduct the access survey (e.g., member survey, secret shopper call, telephonic audit).. Valid values are `member_survey|secret_shopper_call|mystery_shopper_call|telephonic_audit|online_survey|in_person_audit`',
    `survey_notes` STRING COMMENT 'Free-text notes captured by the surveyor regarding the survey interaction, provider responsiveness, or other observations.',
    `survey_status` STRING COMMENT 'Current status of the survey record (e.g., completed, in progress, cancelled, invalid).. Valid values are `completed|in_progress|cancelled|invalid`',
    `telehealth_offered_flag` BOOLEAN COMMENT 'Indicates whether the provider offered a telehealth or virtual visit option during the survey.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `wait_time_offered_days` STRING COMMENT 'Number of days from the survey date to the earliest appointment offered by the provider.',
    `created_by` STRING COMMENT 'User or system identifier that created the survey record.',
    CONSTRAINT pk_access_survey PRIMARY KEY(`access_survey_id`)
) COMMENT 'Transactional record of a member or mystery-shopper access survey conducted to measure appointment availability and wait times against access standards. Captures survey date, survey method (member survey, secret shopper call), provider NPI, specialty, appointment type requested, wait time offered in days, after-hours access result, telehealth offered flag, and compliance outcome. Supports NCQA HEDIS access measures (Getting Care Quickly) and CAHPS survey supplementation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`filing` (
    `filing_id` BIGINT COMMENT 'Unique identifier for the regulatory network filing record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filing must reference the specific regulatory obligation it satisfies, required for CMS network adequacy reporting.',
    `benefit_package_id` BIGINT COMMENT 'CMS Plan Benefit Package identifier for Medicare Advantage plans, or equivalent plan identifier for other lines of business.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network that is the subject of this regulatory filing.',
    `adequacy_standard_met_flag` BOOLEAN COMMENT 'Indicator of whether the network meets the applicable time-and-distance or provider-to-member ratio adequacy standards for the filing period.',
    `approval_date` DATE COMMENT 'Date on which the regulatory body officially approved the network filing.',
    `approval_number` STRING COMMENT 'Unique identifier assigned by the regulatory body upon approval of the filing.',
    `attestation_date` DATE COMMENT 'Date on which the authorized representative signed the network adequacy attestation.',
    `attestation_flag` BOOLEAN COMMENT 'Indicator of whether the health plan provided a formal attestation of network adequacy compliance as part of the filing.',
    `contract_number` STRING COMMENT 'CMS-assigned contract identifier for Medicare Advantage or Part D plans, or state-assigned contract identifier for Medicaid or commercial plans.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this filing record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deficiency_description` STRING COMMENT 'Detailed explanation of the deficiencies identified by the regulatory body and the corrective actions required.',
    `deficiency_issued_date` DATE COMMENT 'Date on which the regulatory body issued the deficiency notice to the health plan.',
    `deficiency_issued_flag` BOOLEAN COMMENT 'Indicator of whether the regulatory body issued a deficiency notice requiring additional information or corrections to the filing.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exception_approval_date` DATE COMMENT 'Date on which the regulatory body approved the adequacy exception or waiver.',
    `exception_approved_flag` BOOLEAN COMMENT 'Indicator of whether the regulatory body approved the adequacy exception or waiver request.',
    `exception_expiration_date` DATE COMMENT 'Date on which the approved adequacy exception or waiver expires and must be renewed or resolved.',
    `exception_geography` STRING COMMENT 'Geographic area (county, ZIP code, or service area) for which an adequacy exception or waiver applies.',
    `exception_justification` STRING COMMENT 'Detailed business rationale and supporting evidence for the adequacy exception or waiver request.',
    `exception_specialty` STRING COMMENT 'Provider specialty or service category for which an adequacy exception or waiver is being requested.',
    `exception_type` STRING COMMENT 'Category of network adequacy exception or waiver being requested, such as specialty shortage, geographic barrier, or low utilization.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_number` STRING COMMENT 'Externally-known unique identifier assigned by the regulatory body or internal tracking system for this filing submission.',
    `filing_status` STRING COMMENT 'Current state of the filing in the regulatory review and approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|deficiency_issued|resubmitted|approved|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'Category of regulatory filing submission indicating the nature of the network-related compliance requirement being addressed. [ENUM-REF-CANDIDATE: network_adequacy|service_area|provider_directory|access_plan|adequacy_exception|adequacy_waiver|network_certification|network_amendment — 8 candidates stripped; promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this filing record was most recently modified.',
    `line_of_business` STRING COMMENT 'Product line or market segment to which this network filing applies, such as Medicare Advantage, Medicaid, or commercial insurance.. Valid values are `medicare_advantage|medicaid|commercial|qhp|dual_eligible`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Internal notes and comments regarding the filing submission, review process, or follow-up actions.',
    `period_end_date` DATE COMMENT 'Ending date of the coverage period or plan year for which this filing applies.',
    `period_start_date` DATE COMMENT 'Beginning date of the coverage period or plan year for which this filing applies.',
    `plan_year` STRING COMMENT 'Calendar year for which the network configuration and adequacy filing is applicable.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body` STRING COMMENT 'Governing authority to which this filing is submitted for review and approval.. Valid values are `cms|state_doi|naic|hhs|ncqa`',
    `regulatory_jurisdiction` STRING COMMENT 'State or federal jurisdiction under which this filing is governed, typically a two-letter state code or FEDERAL for CMS submissions.',
    `rejection_date` DATE COMMENT 'Date on which the regulatory body officially rejected the network filing.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the regulatory body for the rejection of the filing.',
    `response_due_date` DATE COMMENT 'Deadline by which the health plan must submit a response or corrected filing to address the deficiency.',
    `response_submitted_date` DATE COMMENT 'Date on which the health plan submitted its response or corrected filing to address the deficiency.',
    `reviewer_name` STRING COMMENT 'Name of the regulatory body representative assigned to review this filing.',
    `submission_date` DATE COMMENT 'Date on which the filing was officially submitted to the regulatory body.',
    `submission_method` STRING COMMENT 'Channel or system through which the filing was submitted to the regulatory authority.. Valid values are `hpms|state_portal|serff|email|mail|fax`',
    `submitted_by` STRING COMMENT 'Name or identifier of the individual or department responsible for submitting the filing to the regulatory body.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `withdrawal_date` DATE COMMENT 'Date on which the health plan voluntarily withdrew the filing from regulatory review.',
    `withdrawal_reason` STRING COMMENT 'Explanation provided by the health plan for voluntarily withdrawing the filing.',
    CONSTRAINT pk_filing PRIMARY KEY(`filing_id`)
) COMMENT 'Transactional record of a regulatory network filing submitted to CMS, state DOI, or other governing body — including network adequacy filings, service area filings, provider directory submissions, access plan filings, and adequacy exception/waiver requests. Captures filing type, regulatory body, submission date, filing period, submission method (HPMS, state portal), filing status (submitted, accepted, deficiency issued, approved), deficiency description, response due date, and exception-specific attributes (exception type, affected specialty/geography, approved terms, expiration date). Serves as the compliance audit trail for all network-related regulatory submissions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` (
    `vbc_program_id` BIGINT COMMENT 'Unique identifier for the value-based care program. Primary key.',
    `vbc_health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - VBC programs operate within specific plans',
    `vbc_plan_health_plan_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `health_plan_id` BIGINT COMMENT '',
    `attribution_methodology` STRING COMMENT 'The method used to assign members or patients to providers or ACOs for performance measurement and accountability.. Valid values are `Prospective|Retrospective|Voluntary Alignment|Claims-Based|Hybrid`',
    `benchmark_methodology` STRING COMMENT 'The method used to calculate the cost or quality benchmark against which performance is measured. PMPM = Per Member Per Month.. Valid values are `Historical Trend|Regional Average|National Average|Risk-Adjusted PMPM|Episode-Based`',
    `benchmark_year` STRING COMMENT 'The base year or period used to establish the performance benchmark for this program.',
    `care_coordination_required_flag` BOOLEAN COMMENT 'Indicates whether participating providers must implement formal care coordination programs as a condition of participation.',
    `cms_program_identifier` STRING COMMENT 'The official CMS-assigned identifier for this VBC program, used for regulatory reporting and tracking. CMS = Centers for Medicare and Medicaid Services.',
    `contact_email` STRING COMMENT 'Primary email address for inquiries and communications regarding this VBC program.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this VBC program record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'The date when this VBC program design becomes active and available for provider participation.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eligible_provider_types` STRING COMMENT 'Comma-separated list of provider types eligible to participate in this VBC program (e.g., PCP, Specialist, Hospital, SNF). PCP = Primary Care Provider, SNF = Skilled Nursing Facility.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: CareTeam)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `health_it_requirement` STRING COMMENT 'Description of health IT capabilities required for participation (e.g., EHR certification, HIE connectivity, data reporting). EHR = Electronic Health Record, HIE = Health Information Exchange.',
    `internal_notes` STRING COMMENT 'Free-text field for internal operational notes, special considerations, or program-specific guidance.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this VBC program record was most recently modified.',
    `line_of_business` STRING COMMENT 'The insurance product line or market segment to which this VBC program applies. LOB = Line of Business.. Valid values are `Medicare|Medicaid|Commercial|Exchange|Dual Eligible|Medicare Advantage`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `minimum_loss_rate` DECIMAL(18,2) COMMENT 'The minimum percentage loss threshold that must be exceeded before shared losses are assessed. MLR = Minimum Loss Rate. Distinct from Medical Loss Ratio.',
    `minimum_member_threshold` STRING COMMENT 'The minimum number of attributed members required for a provider or ACO to participate in or qualify for this VBC program.',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'The minimum percentage savings threshold that must be achieved before shared savings are paid. MSR = Minimum Savings Rate.',
    `performance_period_end_date` DATE COMMENT 'The date when the performance measurement period for this VBC program ends.',
    `performance_period_start_date` DATE COMMENT 'The date when the performance measurement period for this VBC program begins.',
    `program_category` STRING COMMENT 'Broad category of value-based arrangement that this program represents. ACO = Accountable Care Organization.. Valid values are `ACO|Bundled Payment|Shared Savings|Pay for Performance|Capitation|Population Health`',
    `program_code` STRING COMMENT 'Unique business identifier code for the VBC program used across systems and external reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the VBC program objectives, structure, and key features.',
    `program_name` STRING COMMENT 'Full business name of the value-based care program.',
    `program_owner` STRING COMMENT 'The internal business unit or department responsible for managing and administering this VBC program.',
    `program_status` STRING COMMENT 'Current operational status of the VBC program.. Valid values are `Active|Inactive|Pending Approval|Suspended|Terminated|Pilot`',
    `program_type` STRING COMMENT 'Classification of the VBC program model. MSSP = Medicare Shared Savings Program, REACH = Realizing Equity Access and Community Health, NextGen = Next Generation ACO, P4P = Pay for Performance.. Valid values are `MSSP|REACH|NextGen|Commercial P4P|Episode-Based|Capitation`',
    `program_url` STRING COMMENT 'Web address for the program information page, provider portal, or documentation site.',
    `program_year` STRING COMMENT 'The calendar or performance year for which this VBC program design is configured.',
    `quality_measure_set` STRING COMMENT 'The standardized set of quality measures used to evaluate performance (e.g., HEDIS, STAR, CMS Quality Measures). HEDIS = Healthcare Effectiveness Data and Information Set.',
    `quality_performance_threshold` DECIMAL(18,2) COMMENT 'The minimum quality score threshold required to qualify for shared savings or incentive payments, expressed as a percentage.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the regulatory filing or approval associated with this VBC program.',
    `risk_model` STRING COMMENT 'The financial risk arrangement structure. Upside Only = shared savings only, Two-Sided = shared savings and losses, Downside Only = shared losses only.. Valid values are `Upside Only|Two-Sided|Downside Only|Capitation|Blended`',
    `settlement_frequency` STRING COMMENT 'How often financial reconciliation and shared savings/loss settlements are calculated and paid.. Valid values are `Annual|Semi-Annual|Quarterly|Monthly`',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'The percentage of losses above benchmark that is shared with participating providers, expressed as a percentage. Null for upside-only models.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'The percentage of savings below benchmark that is shared with participating providers, expressed as a percentage (e.g., 50.00 for 50%).',
    `sponsoring_entity` STRING COMMENT 'The organization or regulatory body that sponsors and governs this VBC program. CMS = Centers for Medicare and Medicaid Services.. Valid values are `CMS|State Medicaid|Commercial|Self-Insured Employer|Multi-Payer`',
    `termination_date` DATE COMMENT 'The date when this VBC program design is terminated or discontinued. Null for active programs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this record.',
    CONSTRAINT pk_vbc_program PRIMARY KEY(`vbc_program_id`)
) COMMENT 'Master entity representing a Value-Based Care (VBC) program design — the template or program structure under which ACO arrangements, pay-for-performance contracts, and shared savings models are organized. Captures program name, program type (MSSP, REACH, commercial P4P, episode-based payment, capitation), sponsoring entity (CMS, state Medicaid, commercial), program year, quality measure set, risk model (upside-only, two-sided), and benchmark methodology. Distinct from aco_arrangement (which is a specific participation instance) — vbc_program is the program definition.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`termination` (
    `termination_id` BIGINT COMMENT 'Unique identifier for the provider network termination record. Primary key for the termination entity.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Termination Appeal Process allows providers or members to appeal a termination; the termination record must reference the related appeal case.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Termination of network participation is tied to the underlying provider contract; needed for settlement and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocates termination settlement and related financial impacts to a cost center for accurate financial statements.',
    `employee_id` BIGINT COMMENT 'Party that initiated the termination: provider (voluntary), health plan (involuntary), mutual (both parties agreed), or regulatory authority (mandated by state DOI or CMS).',
    `provider_id` BIGINT COMMENT 'Reference to the provider being terminated from the network.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network from which the provider is being terminated.',
    `active_treatment_count` STRING COMMENT 'Number of members currently in active treatment episodes (e.g., ongoing therapy, pregnancy, post-surgical care) with the terminated provider. These members may be eligible for extended continuity-of-care benefits.',
    `appeal_outcome` STRING COMMENT 'Result of the provider appeal: upheld (termination stands), overturned (termination reversed), modified (terms changed), withdrawn (provider withdrew appeal), or pending (not yet resolved).. Valid values are `upheld|overturned|modified|withdrawn|pending`',
    `appeal_resolution_date` DATE COMMENT 'Date on which any provider appeal or grievance was resolved. Null if no appeal was filed or if appeal is still pending.',
    `appeals_filed_flag` BOOLEAN COMMENT 'Indicates whether the provider filed an appeal or grievance contesting the termination. True = appeal filed; False = no appeal filed.',
    `claims_runout_end_date` DATE COMMENT 'Final date through which claims for pre-termination services will be accepted at in-network rates. Calculated as termination effective date plus claims runout period days.',
    `claims_runout_period_days` STRING COMMENT 'Number of days after termination effective date during which claims for services rendered prior to termination will be accepted and processed at in-network rates. Typically 90-180 days per contract terms.',
    `continuity_of_care_end_date` DATE COMMENT 'Date through which existing patients may continue to receive in-network benefits from the terminated provider under continuity-of-care provisions. Required under No Surprises Act and state regulations.',
    `contract_end_date` DATE COMMENT 'Final date of the underlying provider contract. May differ from termination effective date if contract allows for early termination or extension provisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the termination record was first created in the system. Part of audit trail for compliance and operational tracking.',
    `credentialing_related_flag` BOOLEAN COMMENT 'Indicates whether the termination was due to credentialing issues such as license revocation, malpractice history, sanctions, or failure to meet credentialing standards. True = credentialing-related; False = other reason.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the provider termination becomes effective and the provider is no longer considered in-network for new services. Critical for claims adjudication and member communication.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `financial_settlement_date` DATE COMMENT 'Date on which final financial settlement was completed between the health plan and terminated provider.',
    `financial_settlement_required_flag` BOOLEAN COMMENT 'Indicates whether a financial settlement or reconciliation is required between the health plan and provider upon termination. True = settlement required; False = no settlement required. Common for capitated or risk-sharing arrangements.',
    `for_cause_flag` BOOLEAN COMMENT 'Indicates whether the termination was for-cause due to contract breach, quality issues, fraud, or other serious violations. True = for-cause termination; False = without-cause termination.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated the termination record. Part of audit trail.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the termination record. Part of audit trail for compliance and operational tracking.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_impact_count` STRING COMMENT 'Number of active members assigned to or receiving care from the terminated provider at the time of termination. Used to assess continuity-of-care obligations and member notification requirements.',
    `member_notification_date` DATE COMMENT 'Date on which affected members were notified of the provider termination. Required for regulatory compliance tracking.',
    `member_notification_method` STRING COMMENT 'Method used to notify affected members of the termination: mail (postal letter), email, member portal, phone call, or multiple channels.. Valid values are `mail|email|portal|phone|multiple`',
    `member_notification_required_flag` BOOLEAN COMMENT 'Indicates whether member notification is required by regulation or contract. True = notification required; False = no notification required. CMS and state DOI regulations mandate notification for certain termination types.',
    `network_adequacy_impact_flag` BOOLEAN COMMENT 'Indicates whether the termination impacts network adequacy standards for time-and-distance or provider-to-member ratios. True = adequacy impact; False = no adequacy impact. Triggers network adequacy re-assessment.',
    `notes` STRING COMMENT 'Free-text field for additional context, internal notes, or special handling instructions related to the termination. May include details of negotiations, legal considerations, or operational impacts.',
    `notice_date` DATE COMMENT 'Date on which formal written notice of termination was provided to the provider or plan, as required by contract terms and regulatory requirements.',
    `npi` STRING COMMENT 'Ten-digit unique identifier assigned by CMS to healthcare providers. Denormalized for operational efficiency and regulatory reporting.. Valid values are `^[0-9]{10}$`',
    `provider_directory_removal_date` DATE COMMENT 'Date on which the provider was removed from online and printed provider directories. CMS requires directory updates within specified timeframes.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for termination. Examples include quality concerns, credentialing failure, contract breach, provider relocation, retirement, network restructuring, or regulatory action.',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the termination reason, providing context beyond the reason code. May include specific incidents, performance issues, or business rationale.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_report_date` DATE COMMENT 'Date on which the termination was reported to the applicable regulatory authority (state DOI, CMS, NCQA). Required for compliance audit trail.',
    `regulatory_report_reference` STRING COMMENT 'Reference number or confirmation code from the regulatory authority acknowledging receipt of the termination report.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the termination must be reported to regulatory authorities such as state DOI or CMS. True = reporting required; False = no reporting required. For-cause and credentialing-related terminations typically require reporting.',
    `replacement_provider_required_flag` BOOLEAN COMMENT 'Indicates whether the health plan must recruit a replacement provider to maintain network adequacy. True = replacement required; False = no replacement required.',
    `termination_number` STRING COMMENT 'Business-assigned unique reference number for the termination event, used for tracking and correspondence.',
    `termination_status` STRING COMMENT 'Current lifecycle status of the termination record: pending (awaiting approval), approved (authorized but not yet effective), effective (termination is active), completed (all post-termination obligations fulfilled), cancelled (termination rescinded).. Valid values are `pending|approved|effective|completed|cancelled`',
    `termination_type` STRING COMMENT 'Classification of the termination event indicating whether it was voluntary (provider-initiated), involuntary (plan-initiated), for-cause (breach or quality issue), contract non-renewal, credentialing revocation, or mutual agreement.. Valid values are `voluntary|involuntary|for_cause|contract_non_renewal|credentialing_revocation|mutual_agreement`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created the termination record. Part of audit trail.',
    CONSTRAINT pk_termination PRIMARY KEY(`termination_id`)
) COMMENT 'Transactional record capturing the formal termination of a provider from a network — including voluntary and involuntary terminations. Records termination type (voluntary, for-cause, contract non-renewal, credentialing revocation), effective date, notice date, termination reason code, member impact count, continuity-of-care obligation period, member notification status, and regulatory reporting status. Supports CMS and state DOI termination notification requirements and continuity-of-care compliance under the No Surprises Act.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` (
    `par_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the provider participation agreement.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: PAR agreements are executed under a specific provider contract; linking enables contract‑level reporting and compliance tracking.',
    `fee_schedule_id` BIGINT COMMENT 'add column fee_schedule_id (BIGINT) with FK to contract.fee_schedule.fee_schedule_id - par agreements reference fee schedules',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with the agreement, if plan‑specific.',
    `parent_par_agreement_id` BIGINT COMMENT 'Self-referencing FK on par_agreement (parent_par_agreement_id)',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider participating in the network.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which the agreement applies.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the agreement by the health plan.',
    `agreement_scope_description` STRING COMMENT 'Narrative description of the services, specialties, and geographic areas covered.',
    `agreement_status` STRING COMMENT '',
    `agreement_type` STRING COMMENT 'Classifies the agreement as individual provider, group practice, or other entity.. Valid values are `individual|group|entity`',
    `agreement_version` STRING COMMENT 'Version identifier for the agreement document (e.g., v1, v2).',
    `amendment_effective_date` DATE COMMENT 'Date the amendment becomes effective.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this record represents an amendment to a prior agreement.',
    `amendment_number` STRING COMMENT 'Identifier for the amendment (e.g., A1, A2).',
    `amendment_termination_date` DATE COMMENT 'Date the amendment expires, if different from the base agreement.',
    `compliance_status_flag` STRING COMMENT 'Indicates whether the agreement meets all applicable regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `contract_reference_number` STRING COMMENT 'Reference to the broader provider contract that governs reimbursement terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date the agreement becomes binding and in‑force.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `electronic_signature_flag` BOOLEAN COMMENT 'True if the agreement was signed electronically.',
    `execution_date` DATE COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `internal_notes` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `lob` STRING COMMENT '',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the agreement.',
    `paper_signature_flag` BOOLEAN COMMENT 'True if the agreement was signed on paper.',
    `par_agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `active|inactive|terminated|pending|draft`',
    `participation_status` STRING COMMENT '',
    `provider_credentialing_date` DATE COMMENT 'Date the provider completed credentialing for the network.',
    `provider_credentialing_status` STRING COMMENT 'Credentialing state of the provider for network participation.. Valid values are `credentialed|pending|revoked`',
    `provider_directory_last_verified_date` DATE COMMENT 'Date the providers directory information was last verified.',
    `provider_directory_listing_flag` BOOLEAN COMMENT 'Indicates whether the provider is listed in the public network directory.',
    `provider_network_status` STRING COMMENT 'Current network participation status of the provider.. Valid values are `in_network|out_of_network|pending`',
    `provider_participation_role` STRING COMMENT 'Role of the provider within the network (e.g., primary care, specialist).. Valid values are `primary_care|specialist|both|other`',
    `provider_recredentialing_due_date` DATE COMMENT 'Next scheduled date for provider re‑credentialing.',
    `provider_tier_assignment` STRING COMMENT 'Tier code assigned to the provider within the network (e.g., Tier 1, Tier 2).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_approval_date` DATE COMMENT 'Date the agreement received regulatory approval, if required.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number for any required regulatory filing (e.g., CMS network adequacy filing).',
    `reimbursement_methodology` STRING COMMENT '',
    `renewal_date` DATE COMMENT 'Planned date for renewal of the agreement, if applicable.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement is set for automatic renewal.',
    `signatory_name` STRING COMMENT '',
    `signature_date` DATE COMMENT 'Date the agreement was signed by the provider.',
    `signed_by_name` STRING COMMENT 'Legal name of the individual who signed the agreement on behalf of the provider.',
    `signed_by_npi` STRING COMMENT 'National Provider Identifier of the signing individual.',
    `signed_by_title` STRING COMMENT 'Job title or role of the signing individual.',
    `termination_date` DATE COMMENT 'Date the agreement ends, either by expiration or early termination.',
    `termination_reason_code` STRING COMMENT 'Standardized code describing why the agreement was terminated.',
    `termination_reason_description` STRING COMMENT 'Free‑text description of the termination reason.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'User or system that created the agreement record.',
    CONSTRAINT pk_par_agreement PRIMARY KEY(`par_agreement_id`)
) COMMENT 'Provider participation agreement record — the formal agreement a provider signs to participate in a network. Captures agreement type (individual, group), signature date, effective date, termination provisions, and agreement version. Distinct from the broader provider_contract which covers reimbursement terms.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` (
    `network_directory_verification_id` BIGINT COMMENT 'Unique identifier for the provider directory verification event. Primary key for the directory verification record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or system user who performed the directory verification. Links to workforce or user management system. Nullable for automated system verifications.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan associated with this directory verification, if verification is plan-specific. Nullable for network-wide verifications.',
    `provider_id` BIGINT COMMENT 'Reference to the provider whose directory information is being verified. Links to the provider master record in the provider domain.',
    `provider_network_id` BIGINT COMMENT 'Reference to the network in which the provider directory listing is being verified. Links to the network configuration record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Directory Verification Vendor Audit tracks which external vendor performed verification for each provider directory entry.',
    `accepting_new_patients_status` STRING COMMENT 'Current status of whether the provider is accepting new patients as verified during this event. Accepting indicates open to new patients, not accepting indicates closed panel, accepting existing only indicates existing patient family members only, waitlist indicates accepting with delay, unknown indicates status could not be determined.. Valid values are `accepting|not_accepting|accepting_existing_only|waitlist|unknown`',
    `accepting_new_patients_verified` BOOLEAN COMMENT 'Indicates whether the provider accepting new patients status was verified during this verification event. True if status was confirmed or updated, false if not verified or unable to verify. Critical for member access and network adequacy reporting.',
    `accuracy_score` DECIMAL(18,2) COMMENT 'Calculated accuracy score for this verification event, expressed as a percentage (0.00 to 100.00). Represents the proportion of verified fields that were accurate without requiring updates. Used for CMS directory accuracy reporting and network adequacy metrics.',
    `address_verified` BOOLEAN COMMENT 'Indicates whether the provider practice address was verified during this verification event. True if address was confirmed or updated, false if not verified or unable to verify.',
    `change_summary` STRING COMMENT 'Free-text summary of changes identified during verification. Describes what directory fields were updated and the nature of the changes. Nullable if no changes were identified.',
    `changes_identified` BOOLEAN COMMENT 'Indicates whether any changes to directory information were identified during this verification event. True if updates were needed, false if all information was confirmed as accurate.',
    `cms_reportable` BOOLEAN COMMENT 'Indicates whether this verification event counts toward CMS directory accuracy reporting requirements. True if the verification meets CMS reporting criteria, false if excluded (e.g., duplicate verification within same quarter).',
    `compliance_quarter` STRING COMMENT 'Calendar quarter for which this verification counts toward CMS quarterly verification compliance requirements. Format YYYY-Q# (e.g., 2024-Q1). Used for regulatory reporting and compliance tracking.. Valid values are `^[0-9]{4}-Q[1-4]$`',
    `compliance_year` STRING COMMENT 'Calendar year for which this verification counts toward annual directory accuracy compliance requirements. Used for regulatory reporting and multi-year trend analysis.',
    `contact_attempt_count` STRING COMMENT 'Number of contact attempts made before achieving verification outcome. Tracks effort required to reach provider and supports operational efficiency analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this directory verification record was first created in the system. Audit field for data lineage and compliance tracking.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `directory_update_timestamp` TIMESTAMP COMMENT 'Date and time when the provider directory was updated based on verification findings. Nullable if no directory update was required. Used to track compliance with CMS 90-day update requirement.',
    `directory_updated` BOOLEAN COMMENT 'Indicates whether the provider directory was updated as a result of this verification. True if changes were applied to the directory, false if no updates were made. Tracks compliance with 90-day directory update mandate.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `first_contact_attempt_date` DATE COMMENT 'Date of the first contact attempt for this verification cycle. Used to measure time-to-verification and operational efficiency.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_contact_attempt_date` DATE COMMENT 'Date of the most recent contact attempt for this verification cycle. Used to track verification completion timeline.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_verification_due_date` DATE COMMENT 'Calculated date by which the next directory verification must be completed to maintain CMS quarterly verification compliance. Typically 90 days from current verification date.',
    `npi_verified` BOOLEAN COMMENT 'Indicates whether the provider National Provider Identifier was verified during this verification event. True if NPI was confirmed, false if not verified. NPI is the unique provider identifier required by HIPAA.',
    `phone_verified` BOOLEAN COMMENT 'Indicates whether the provider phone number was verified during this verification event. True if phone was confirmed or updated, false if not verified or unable to verify.',
    `prior_verification_date` DATE COMMENT 'Date of the previous directory verification for this provider in this network. Used to track compliance with quarterly verification frequency requirements.',
    `provider_response_time_hours` DECIMAL(18,2) COMMENT 'Number of hours between initial contact attempt and provider response. Used to measure provider engagement and operational efficiency. Nullable if provider did not respond.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `specialty_verified` BOOLEAN COMMENT 'Indicates whether the provider specialty information was verified during this verification event. True if specialty was confirmed or updated, false if not verified or unable to verify.',
    `updated_by` STRING COMMENT 'User ID or system identifier that last modified this directory verification record. Audit field for accountability and change tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this directory verification record was last modified. Audit field for data lineage and change tracking.',
    `verification_agent_name` STRING COMMENT 'Name of the person or system that performed the directory verification. For manual verifications, this is the employee name; for automated verifications, this is the system name.',
    `verification_channel` STRING COMMENT 'Communication channel used to conduct the verification. Phone indicates telephone call, email indicates electronic mail, portal indicates provider self-service portal, mail indicates postal mail, fax indicates facsimile, in person indicates face-to-face verification, automated indicates system-to-system verification. [ENUM-REF-CANDIDATE: phone|email|portal|mail|fax|in_person|automated — 7 candidates stripped; promote to reference product]',
    `verification_date` DATE COMMENT 'Date on which the directory verification was performed. Used to track compliance with CMS quarterly verification requirements and 90-day directory update mandate.',
    `verification_language` STRING COMMENT 'Language used to conduct the verification interaction. Three-letter ISO 639-2 language code (e.g., ENG for English, SPA for Spanish). Supports cultural competency tracking and language access compliance.',
    `verification_method` STRING COMMENT 'Method used to verify provider directory information. Outbound call indicates phone verification, online attestation indicates provider portal self-service, EHR/HIE match indicates electronic health record data validation, claims inference indicates verification based on recent claims activity, mail survey indicates postal verification, email confirmation indicates electronic mail verification.. Valid values are `outbound_call|online_attestation|ehr_hie_match|claims_inference|mail_survey|email_confirmation`',
    `verification_notes` STRING COMMENT 'Free-text notes captured during the verification process. Includes details about contact interactions, provider responses, issues encountered, or additional context relevant to the verification outcome.',
    `verification_number` STRING COMMENT 'Business identifier for the directory verification event. Human-readable unique reference number used for tracking and audit purposes.. Valid values are `^DV-[0-9]{10}$`',
    `verification_source_document` STRING COMMENT 'Reference to the source document or evidence supporting the verification. Examples include call recording ID, attestation form ID, EHR data extract reference, claims report ID. Supports audit trail and compliance documentation.',
    `verification_status` STRING COMMENT 'Outcome of the directory verification attempt. Confirmed indicates all information validated as accurate, updated indicates changes were made, unable to reach indicates contact attempt failed, provider declined indicates provider refused verification, invalid contact indicates contact information is incorrect, pending response indicates awaiting provider response.. Valid values are `confirmed|updated|unable_to_reach|provider_declined|invalid_contact|pending_response`',
    `verification_system` STRING COMMENT 'Name of the system or platform used to perform the verification. Examples include provider portal, call center system, automated verification engine, EHR integration platform, claims analytics system.',
    `verification_timestamp` TIMESTAMP COMMENT 'Precise date and time when the directory verification event occurred. Provides audit trail for compliance reporting and operational tracking.',
    `verified_fields` STRING COMMENT 'Comma-separated list of specific directory fields that were verified during this event. Examples include address, phone, accepting_new_patients, specialty, office_hours, languages_spoken, accessibility_features. Tracks granular verification coverage.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this directory verification record. Audit field for accountability and compliance tracking.',
    CONSTRAINT pk_network_directory_verification PRIMARY KEY(`network_directory_verification_id`)
) COMMENT 'Transactional record of a provider directory data verification event — capturing the verification method (outbound call, online attestation, EHR/HIE data match, claims-based inference), verification date, verified fields (address, phone, accepting-new-patients, specialty), verification outcome (confirmed, updated, unable to reach), and the agent or system that performed the verification. Supports CMS requirement for quarterly directory accuracy verification and tracks compliance with the 90-day directory update mandate.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` (
    `provider_assignment_id` BIGINT COMMENT 'Unique identifier for the network-provider association record. Primary key for this entity.',
    `delegated_entity_id` BIGINT COMMENT 'Foreign key linking to credential.delegated_entity. Business justification: When credentialing is delegated, Network Provider must reference the Delegated Credentialing Entity that performed the credentialing, required for the Delegated Credentialing Compliance Report.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Network Provider Management: each provider is assigned a liaison employee who oversees contracts and compliance; required for provider relationship reporting.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider participating in this network. Links to the provider master entity.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which this provider participates. Links to the network master entity.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Network Provider participation requires linking to the specific Credential Record used for credentialing, enabling the Network Participation Report and compliance audit.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider is currently accepting new patients from this network. True indicates accepting new patients.',
    `accessibility_ada_compliant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this providers facilities meet ADA accessibility requirements for members with disabilities. True indicates ADA compliance.',
    `aco_participant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider participates in an ACO arrangement within this network. True indicates ACO participation.',
    `after_hours_availability_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider offers after-hours or extended-hours services to members of this network. True indicates after-hours availability.',
    `continuity_of_care_end_date` DATE COMMENT 'The date through which existing members may continue to see this provider under in-network benefits after network termination, per continuity of care requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this network-provider association record was first created in the system.',
    `credentialing_date` DATE COMMENT 'The date on which the provider was most recently credentialed for participation in this network.',
    `credentialing_status` STRING COMMENT 'Current credentialing status of the provider for participation in this network. Credentialed indicates all requirements met.. Valid values are `credentialed|pending|expired|suspended|revoked`',
    `current_panel_size` STRING COMMENT 'The current number of members assigned to or served by this provider within this network.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `directory_last_verified_date` DATE COMMENT 'The date on which the providers directory information was last verified for accuracy. CMS requires quarterly verification.',
    `directory_listing_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider should be included in the published provider directory for this network. True indicates directory inclusion.',
    `effective_date` DATE COMMENT 'The date on which the providers participation in this network became or will become effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_service_area` STRING COMMENT 'The geographic area or region within which this provider serves members of this network. May be county, ZIP code range, or custom service area code.',
    `in_network_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider is currently in-network for this network. True indicates in-network status.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language_services_available` STRING COMMENT 'Comma-separated list of languages in which this provider offers services to members of this network, supporting cultural and linguistic access requirements.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_adequacy_category` STRING COMMENT 'Classification of this providers role in meeting network adequacy requirements. Essential indicates critical for minimum adequacy standards.. Valid values are `essential|standard|enhanced|specialty`',
    `network_participation_type` STRING COMMENT 'Classification of the providers participation relationship with this network. PAR indicates participating provider with contracted rates; non-PAR indicates non-participating.. Valid values are `par|non_par|out_of_network`',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned by CMS to uniquely identify this provider in the network.. Valid values are `^[0-9]{10}$`',
    `panel_capacity` STRING COMMENT 'The maximum number of members this provider can serve within this network. Used for network adequacy calculations.',
    `panel_status` STRING COMMENT 'Current status of the providers patient panel for this network. Open indicates capacity for new members; closed indicates no capacity.. Valid values are `open|closed|limited|full`',
    `participation_status` STRING COMMENT 'Current status of the providers participation in this network. Active indicates the provider is currently in-network and accepting members.. Valid values are `active|inactive|suspended|pending|terminated`',
    `pcp_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider serves as a Primary Care Provider within this network. True indicates PCP designation.',
    `quality_tier_designation` STRING COMMENT 'Quality-based tier assignment for this provider within the network, based on HEDIS or Star Ratings performance metrics.. Valid values are `high_quality|standard_quality|low_quality|not_rated`',
    `record_active_flag` BOOLEAN COMMENT 'Boolean indicator of whether this network-provider association record is currently active in the system. False indicates a logically deleted or superseded record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recredentialing_due_date` DATE COMMENT 'The date by which the provider must complete recredentialing to maintain participation in this network. Typically every 3 years per NCQA standards.',
    `risk_sharing_arrangement_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider participates in risk-sharing financial arrangements within this network. True indicates risk-sharing participation.',
    `specialist_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider is designated as a specialist within this network. True indicates specialist designation.',
    `telehealth_available_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider offers telehealth services to members of this network. True indicates telehealth availability.',
    `termination_date` DATE COMMENT 'The date on which the providers participation in this network ended or will end. Null for ongoing participation.',
    `termination_initiated_by` STRING COMMENT 'Indicates which party initiated the termination of the providers network participation. Null for active participation.. Valid values are `provider|health_plan|mutual|regulatory`',
    `termination_reason_code` STRING COMMENT 'Code indicating the reason for termination of the providers participation in this network. Null for active participation. [ENUM-REF-CANDIDATE: voluntary|contract_expiration|quality_issues|credentialing_failure|network_restructure|provider_request|other — 7 candidates stripped; promote to reference product]',
    `tier_assignment` STRING COMMENT 'The benefit tier assigned to this provider within the network, determining member cost-sharing levels. Tier 1 typically represents lowest member cost-sharing.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|out_of_network`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this network-provider association record was most recently updated in the system.',
    `vbc_participant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider participates in value-based care arrangements within this network. True indicates VBC participation.',
    `weekend_availability_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider offers weekend services to members of this network. True indicates weekend availability.',
    CONSTRAINT pk_provider_assignment PRIMARY KEY(`provider_assignment_id`)
) COMMENT 'Association entity representing the participation of a specific provider (NPI) within a specific provider network, capturing in-network status, effective and termination dates, tier assignment, accepting-new-patients flag, telehealth availability, panel status (open/closed), panel capacity, and credentialing linkage. This is the SSOT for the structural relationship between a provider and a network — distinct from provider identity (provider domain), contract terms (contract domain), and ACO-specific participation (aco_provider). Supports provider directory publication, CMS network adequacy filings, and member eligibility verification.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`recruitment` (
    `recruitment_id` BIGINT COMMENT 'Unique identifier for the provider recruitment activity record.',
    `adequacy_assessment_id` BIGINT COMMENT 'Identifier linking this recruitment activity to a specific network adequacy gap assessment finding that triggered the recruitment need.',
    `provider_contract_id` BIGINT COMMENT 'Identifier of the provider contract that resulted from successful recruitment, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Records recruitment expenses for network provider outreach against a cost center for budgeting and expense tracking.',
    `filing_id` BIGINT COMMENT 'The CMS filing identifier associated with the network adequacy gap that this recruitment addresses, if applicable.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network for which recruitment is being conducted.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the recruiter assigned to manage this recruitment activity.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Provider recruitment decisions use risk pool characteristics to prioritize filling gaps for high‑risk member segments, supporting network adequacy.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Provider Recruitment Vendor Management links recruitment activities to external recruiting vendors for reporting and cost allocation.',
    `adequacy_gap_type` STRING COMMENT 'The specific type of network adequacy gap this recruitment is intended to address, if applicable.. Valid values are `time_distance|provider_ratio|specialty_shortage|geographic_coverage|access_hours`',
    `recruitment_code` STRING COMMENT 'Business identifier code for the recruitment activity, typically formatted as REC-YYYYMMDD or similar convention.. Valid values are `^REC-[0-9]{8}$`',
    `contract_effective_date` DATE COMMENT 'The effective date of the provider contract resulting from this recruitment, if successfully contracted.',
    `contracting_referral_date` DATE COMMENT 'The date when the recruitment activity was referred to the contracting team for formal contract negotiation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this recruitment record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disposition` STRING COMMENT 'The final outcome or current status of the recruitment activity.. Valid values are `contracted|declined|no_response|in_progress|on_hold|withdrawn`',
    `disposition_date` DATE COMMENT 'The date when the recruitment activity reached its final disposition.',
    `disposition_reason` STRING COMMENT 'Detailed explanation or reason code for the final disposition outcome (e.g., rate disagreement, geographic mismatch, credentialing issues).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `estimated_annual_claims_volume` DECIMAL(18,2) COMMENT 'Projected annual claims volume in dollars expected from this provider if successfully recruited.',
    `estimated_member_impact` STRING COMMENT 'Estimated number of members who would benefit from adding this provider to the network.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `follow_up_date` DATE COMMENT 'The scheduled date for follow-up contact with the provider.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob` STRING COMMENT 'The line of business for which this provider recruitment is being conducted.. Valid values are `commercial|medicare|medicaid|marketplace|dual_eligible`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, conversation details, or special considerations related to the recruitment activity.',
    `outreach_date` DATE COMMENT 'The date when initial outreach was made to the target provider.',
    `outreach_method` STRING COMMENT 'The communication channel or method used for initial provider outreach.. Valid values are `phone|email|in_person|mail|referral|conference`',
    `priority_level` STRING COMMENT 'The urgency or priority assigned to this recruitment activity based on business need and regulatory risk.. Valid values are `critical|high|medium|low`',
    `provider_response` STRING COMMENT 'The initial response received from the target provider following outreach.. Valid values are `interested|not_interested|requested_info|no_response|deferred`',
    `reason` STRING COMMENT 'The primary business reason driving this recruitment activity.. Valid values are `adequacy_gap_closure|strategic_expansion|member_request|competitor_response|quality_improvement|cost_reduction`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recruiter_assigned` STRING COMMENT 'Name or identifier of the network development recruiter assigned to this recruitment activity.',
    `recruitment_status` STRING COMMENT 'Current operational status of the recruitment activity in the pipeline.. Valid values are `active|completed|cancelled|on_hold`',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether successful recruitment of this provider requires a regulatory filing or network adequacy update with state or federal authorities.',
    `response_date` DATE COMMENT 'The date when the provider responded to the recruitment outreach.',
    `target_county_fips` STRING COMMENT 'The 5-digit FIPS code identifying the target county for recruitment.. Valid values are `^[0-9]{5}$`',
    `target_geographic_area` STRING COMMENT 'The geographic area or service area where the provider is needed, typically defined by county, ZIP code, or Metropolitan Statistical Area (MSA).',
    `target_provider_name` STRING COMMENT 'Name of the provider or provider organization being recruited.',
    `target_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the specific provider being recruited, if known at outreach time.. Valid values are `^[0-9]{10}$`',
    `target_provider_tin` STRING COMMENT 'The 9-digit Tax Identification Number (TIN) of the provider organization or practice being recruited.. Valid values are `^[0-9]{9}$`',
    `target_specialty` STRING COMMENT 'The medical specialty or provider type being recruited to address network adequacy gaps (e.g., Cardiology, Primary Care, Pediatrics).',
    `target_zip_code` STRING COMMENT 'The 5-digit ZIP code identifying the target geographic area for recruitment.. Valid values are `^[0-9]{5}$`',
    `updated_by` STRING COMMENT 'User identifier or system account that last updated this recruitment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this recruitment record was last modified.',
    `created_by` STRING COMMENT 'User identifier or system account that created this recruitment record.',
    CONSTRAINT pk_recruitment PRIMARY KEY(`recruitment_id`)
) COMMENT 'Transactional record tracking provider recruitment activities to address network adequacy gaps or strategic expansion. Captures target provider NPI/TIN, target specialty, target geographic area, recruitment reason (adequacy gap closure, strategic expansion, member request, competitor response), outreach date, outreach method, recruiter assigned, provider response, contracting referral date, and disposition (contracted, declined, no response). Links to adequacy assessment gap findings for remediation tracking. Supports network development pipeline management and regulatory gap closure evidence.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` (
    `network_service_area_id` BIGINT COMMENT 'Unique identifier for the geographic service area. Primary key.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which this service area belongs.',
    `filing_id` BIGINT COMMENT 'Identifier of the regulatory filing (e.g., SERFF filing, CMS HPMS submission) that established or modified this service area.',
    `cms_service_area_code` STRING COMMENT 'CMS-assigned identifier for the service area, used in Medicare Advantage and Marketplace (QHP) filings.. Valid values are `^[A-Z0-9]{1,20}$`',
    `commercial_approved_flag` BOOLEAN COMMENT 'Indicates whether this service area is approved for commercial (employer-sponsored and individual) plan enrollment.',
    `county_fips_code` STRING COMMENT 'Five-digit Federal Information Processing Standards code uniquely identifying the county. Null for non-county-based service areas.. Valid values are `^[0-9]{5}$`',
    `county_name` STRING COMMENT 'Name of the county included in this service area. Null for non-county-based service areas.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service area record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when this service area configuration becomes active and available for member enrollment.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_code` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_boundary_description` STRING COMMENT 'Textual description of the service area boundaries, used for custom or complex geographic definitions not captured by standard codes.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicaid_approved_flag` BOOLEAN COMMENT 'Indicates whether this service area is approved for Medicaid managed care enrollment.',
    `medicare_advantage_approved_flag` BOOLEAN COMMENT 'Indicates whether this service area is approved for Medicare Advantage plan enrollment.',
    `member_residency_required_flag` BOOLEAN COMMENT 'Indicates whether members must reside within this service area to be eligible for enrollment in the associated network.',
    `msa_code` STRING COMMENT 'Five-digit code identifying the Metropolitan Statistical Area. Null for non-MSA-based service areas.. Valid values are `^[0-9]{5}$`',
    `msa_name` STRING COMMENT 'Name of the Metropolitan Statistical Area (e.g., San Francisco-Oakland-Hayward, CA). Null for non-MSA-based service areas.',
    `network_adequacy_approval_date` DATE COMMENT 'Date when the network adequacy filing was approved by CMS or the state Department of Insurance for this service area.',
    `network_adequacy_filing_date` DATE COMMENT 'Date when the most recent network adequacy filing was submitted to CMS or the state Department of Insurance for this service area.',
    `network_adequacy_status` STRING COMMENT 'Indicates whether the service area meets CMS and state network adequacy standards for provider access: compliant, non-compliant, under review, waiver granted, or not applicable.. Valid values are `compliant|non_compliant|under_review|waiver_granted|not_applicable`',
    `network_service_area_status` STRING COMMENT 'Current lifecycle status of the service area: active (available for enrollment), inactive (not available), pending approval (awaiting regulatory approval), suspended (temporarily unavailable), or terminated (permanently closed).. Valid values are `active|inactive|pending_approval|suspended|terminated`',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, exceptions, or special instructions related to this service area configuration.',
    `out_of_area_coverage_allowed_flag` BOOLEAN COMMENT 'Indicates whether the plan allows coverage for services received outside this service area (e.g., for travel or temporary relocation).',
    `population_count` BIGINT COMMENT 'Estimated total population residing in this service area, used for network adequacy calculations and market sizing.',
    `qhp_approved_flag` BOOLEAN COMMENT 'Indicates whether this service area is approved for Qualified Health Plan (Marketplace/Exchange) enrollment under the Affordable Care Act.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_approval_number` STRING COMMENT 'Reference number assigned by CMS or the state Department of Insurance when approving this service area configuration.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `service_area_code` STRING COMMENT 'Business identifier for the service area, used in contracts, filings, and member communications.. Valid values are `^[A-Z0-9]{3,15}$`',
    `service_area_name` STRING COMMENT 'Human-readable name of the service area (e.g., Northern California Region, Metro Atlanta Service Area).',
    `service_area_type` STRING COMMENT 'Classification of how the service area is defined geographically: county-based, ZIP code-based, Metropolitan Statistical Area (MSA)-based, state-based, custom boundary, or multi-state.. Valid values are `county_based|zip_based|msa_based|state_based|custom_boundary|multi_state`',
    `state_code` STRING COMMENT 'Two-letter state abbreviation where the service area is located (e.g., CA, TX, NY). For multi-state service areas, this represents the primary state.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when this service area configuration is no longer active. Null for currently active service areas.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this service area record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service area record was last modified.',
    `urban_rural_designation` STRING COMMENT 'Classification of the service area as urban, suburban, rural, frontier (very low population density), or mixed.. Valid values are `urban|suburban|rural|frontier|mixed`',
    `zip_code` STRING COMMENT 'Five-digit ZIP code included in this service area. Null for non-ZIP-based service areas.. Valid values are `^[0-9]{5}$`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this service area record.',
    CONSTRAINT pk_network_service_area PRIMARY KEY(`network_service_area_id`)
) COMMENT 'Defines the geographic service area for a provider network — the counties, ZIP codes, or metropolitan statistical areas (MSAs) where the network is available and where members must reside to enroll. Captures state, county FIPS code, ZIP code, service area type (county-based, ZIP-based), CMS service area ID, effective dates, and whether the area is approved for QHP/Medicare Advantage enrollment. Critical for CMS network adequacy filings and state DOI market conduct compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ADD CONSTRAINT `fk_network_tier_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`filing`(`filing_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_adequacy_standard_id` FOREIGN KEY (`adequacy_standard_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_standard`(`adequacy_standard_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ADD CONSTRAINT `fk_network_vbc_arrangement_vbc_program_id` FOREIGN KEY (`vbc_program_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`vbc_program`(`vbc_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ADD CONSTRAINT `fk_network_aco_provider_vbc_arrangement_id` FOREIGN KEY (`vbc_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`vbc_arrangement`(`vbc_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ADD CONSTRAINT `fk_network_change_event_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ADD CONSTRAINT `fk_network_access_standard_superseded_by_standard_access_standard_id` FOREIGN KEY (`superseded_by_standard_access_standard_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`access_standard`(`access_standard_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ADD CONSTRAINT `fk_network_access_survey_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ADD CONSTRAINT `fk_network_access_survey_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ADD CONSTRAINT `fk_network_filing_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ADD CONSTRAINT `fk_network_termination_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_parent_par_agreement_id` FOREIGN KEY (`parent_par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ADD CONSTRAINT `fk_network_network_directory_verification_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ADD CONSTRAINT `fk_network_recruitment_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ADD CONSTRAINT `fk_network_recruitment_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`filing`(`filing_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ADD CONSTRAINT `fk_network_recruitment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ADD CONSTRAINT `fk_network_network_service_area_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ADD CONSTRAINT `fk_network_network_service_area_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`filing`(`filing_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`network` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`network` SET TAGS ('pii_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `provider_network_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Network Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `aco_participation_flag` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Network Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `facility_count` SET TAGS ('pii_business_glossary_term' = 'Facility Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `geographic_footprint` SET TAGS ('pii_business_glossary_term' = 'Geographic Footprint');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `last_adequacy_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Network Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'Commercial|Medicare|Medicaid|Exchange|ASO');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `member_enrollment_count` SET TAGS ('pii_business_glossary_term' = 'Member Enrollment Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_accreditation_date` SET TAGS ('pii_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Accreditation Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_accreditation_status` SET TAGS ('pii_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_accreditation_status` SET TAGS ('pii_value_regex' = 'Accredited|Provisional|Denied|Not Applicable|Pending');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_expiration_date` SET TAGS ('pii_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Accreditation Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_adequacy_filing_date` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('pii_value_regex' = 'Adequate|Deficient|Conditional|Pending Review');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('pii_business_glossary_term' = 'Network Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_description` SET TAGS ('pii_business_glossary_term' = 'Network Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('pii_business_glossary_term' = 'Network Provider Directory Uniform Resource Locator (URL)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('pii_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('pii_business_glossary_term' = 'Network Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('pii_value_regex' = 'Active|Inactive|Suspended|Pending|Terminated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('pii_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP|ACO');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `next_adequacy_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Network Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('pii_business_glossary_term' = 'Out-of-Network Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `pcp_count` SET TAGS ('pii_business_glossary_term' = 'Primary Care Physician (PCP) Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `pcp_required_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Care Physician (PCP) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `provider_count` SET TAGS ('pii_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `referral_required_flag` SET TAGS ('pii_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `regulatory_approval_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('pii_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('pii_value_regex' = 'Statewide|Regional|County|ZIP|National');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `specialist_count` SET TAGS ('pii_business_glossary_term' = 'Specialist Physician Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `star_rating` SET TAGS ('pii_business_glossary_term' = 'Star Rating');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Network Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `tier_classification` SET TAGS ('pii_business_glossary_term' = 'Network Tier Classification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `tier_classification` SET TAGS ('pii_value_regex' = 'Tier 1|Tier 2|Tier 3|Single Tier|Tiered');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_id` SET TAGS ('pii_business_glossary_term' = 'Network Tier Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('pii_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `coinsurance_differential_percentage` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Differential Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `copay_differential_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Differential Amount');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `cost_share_differential_type` SET TAGS ('pii_business_glossary_term' = 'Cost Share Differential Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `cost_share_differential_type` SET TAGS ('pii_value_regex' = 'copay|coinsurance|deductible|hybrid|none');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `deductible_applies_flag` SET TAGS ('pii_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `display_label` SET TAGS ('pii_business_glossary_term' = 'Tier Display Label');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `facility_type_applicability` SET TAGS ('pii_business_glossary_term' = 'Facility Type Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `internal_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `member_steerage_incentive_description` SET TAGS ('pii_business_glossary_term' = 'Member Steerage Incentive Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_name` SET TAGS ('pii_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `network_adequacy_credit_flag` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Credit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `oop_max_applies_flag` SET TAGS ('pii_business_glossary_term' = 'Out-of-Pocket (OOP) Maximum Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `quality_tier_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Tier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `rank` SET TAGS ('pii_business_glossary_term' = 'Tier Rank');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `referral_required_flag` SET TAGS ('pii_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `sbc_disclosure_text` SET TAGS ('pii_business_glossary_term' = 'Summary of Benefits and Coverage (SBC) Disclosure Text');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `specialty_applicability` SET TAGS ('pii_business_glossary_term' = 'Specialty Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_status` SET TAGS ('pii_business_glossary_term' = 'Tier Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_type` SET TAGS ('pii_business_glossary_term' = 'Tier Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_type` SET TAGS ('pii_value_regex' = 'preferred|standard|specialty|out_of_network|value_based|narrow_network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `vbc_arrangement_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `plan_association_id` SET TAGS ('pii_business_glossary_term' = 'Plan Association Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Product Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_service_area_id` SET TAGS ('pii_business_glossary_term' = 'Service Area Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `filing_id` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Filing Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `aco_participation_flag` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `adequacy_certification_date` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Certification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `adequacy_review_date` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('pii_business_glossary_term' = 'Plan Association Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_name` SET TAGS ('pii_business_glossary_term' = 'Plan Association Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_type` SET TAGS ('pii_business_glossary_term' = 'Plan Association Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_type` SET TAGS ('pii_value_regex' = 'primary|supplemental|specialty|out_of_area|reciprocal|tertiary');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `auto_assignment_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Auto-Assignment Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('pii_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `directory_publication_flag` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Publication Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Association Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|marketplace|dual_eligible|chip');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'individual|small_group|large_group|jumbo_group|government|student');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `member_count` SET TAGS ('pii_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_adequacy_status` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_adequacy_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|under_review|exempt|conditional');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Association Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('pii_business_glossary_term' = 'Out-of-Network Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `pcp_selection_required_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider (PCP) Selection Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `plan_association_status` SET TAGS ('pii_business_glossary_term' = 'Association Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `plan_association_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `priority_rank` SET TAGS ('pii_business_glossary_term' = 'Network Priority Rank');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `provider_count` SET TAGS ('pii_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `referral_required_flag` SET TAGS ('pii_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `regulatory_approval_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `star_rating_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Star Rating Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Association Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_id` SET TAGS ('pii_business_glossary_term' = 'Adequacy Standard Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `compliance_regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_status` SET TAGS ('pii_business_glossary_term' = 'Standard Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_status` SET TAGS ('pii_value_regex' = 'active|inactive|proposed|superseded|under-review');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `after_hours_availability_required` SET TAGS ('pii_business_glossary_term' = 'After Hours Availability Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `after_hours_definition` SET TAGS ('pii_business_glossary_term' = 'After Hours Definition');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `appointment_type` SET TAGS ('pii_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `appointment_type` SET TAGS ('pii_value_regex' = 'routine|urgent|preventive|behavioral-health|specialist|emergency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `compliance_reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Compliance Reporting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `compliance_reporting_frequency` SET TAGS ('pii_value_regex' = 'annual|semi-annual|quarterly|monthly|on-demand');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `exception_criteria` SET TAGS ('pii_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `geographic_classification` SET TAGS ('pii_business_glossary_term' = 'Geographic Classification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `geographic_classification` SET TAGS ('pii_value_regex' = 'urban|suburban|rural|frontier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'medicare-advantage|medicaid|commercial|marketplace|dual-eligible|all');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_distance_miles` SET TAGS ('pii_business_glossary_term' = 'Maximum Distance in Miles');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_travel_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Maximum Travel Time in Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_wait_time_days` SET TAGS ('pii_business_glossary_term' = 'Maximum Wait Time in Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `measurement_methodology` SET TAGS ('pii_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `minimum_provider_count` SET TAGS ('pii_business_glossary_term' = 'Minimum Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Standard Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('pii_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP|all');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `provider_to_member_ratio` SET TAGS ('pii_business_glossary_term' = 'Provider to Member Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `regulatory_source` SET TAGS ('pii_business_glossary_term' = 'Regulatory Source');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `regulatory_source` SET TAGS ('pii_value_regex' = 'CMS|state-DOI|NCQA|URAC|ACA|internal');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `service_area_type` SET TAGS ('pii_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `service_area_type` SET TAGS ('pii_value_regex' = 'county|zip|state|region|national');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `specialty_category` SET TAGS ('pii_business_glossary_term' = 'Specialty Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_category` SET TAGS ('pii_business_glossary_term' = 'Standard Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_category` SET TAGS ('pii_value_regex' = 'time-distance|provider-ratio|appointment-access|after-hours|telehealth-equivalency|network-composition');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('pii_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_business_glossary_term' = 'Standard Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_version` SET TAGS ('pii_business_glossary_term' = 'Standard Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `telehealth_equivalency_allowed` SET TAGS ('pii_business_glossary_term' = 'Telehealth Equivalency Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `telehealth_percentage_cap` SET TAGS ('pii_business_glossary_term' = 'Telehealth Percentage Cap');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `threshold_percentage` SET TAGS ('pii_business_glossary_term' = 'Threshold Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Adequacy Assessment ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `adequacy_standard_id` SET TAGS ('pii_business_glossary_term' = 'Adequacy Standard Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `network_service_area_id` SET TAGS ('pii_business_glossary_term' = 'Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `appointment_type_requested` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Requested');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `appointment_type_requested` SET TAGS ('pii_value_regex' = 'routine|urgent|preventive|follow-up|new-patient|specialist-referral');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_number` SET TAGS ('pii_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'adequacy|access-survey|mystery-shopper|gap-analysis|time-distance|appointment-availability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_organization` SET TAGS ('pii_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `compliance_outcome` SET TAGS ('pii_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `compliance_outcome` SET TAGS ('pii_value_regex' = 'compliant|non-compliant|partially-compliant|under-review|remediation-required');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `facility_type` SET TAGS ('pii_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `gap_identified_flag` SET TAGS ('pii_business_glossary_term' = 'Gap Identified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `gap_severity` SET TAGS ('pii_business_glossary_term' = 'Gap Severity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `gap_severity` SET TAGS ('pii_value_regex' = 'critical|high|moderate|low');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `member_to_provider_ratio` SET TAGS ('pii_business_glossary_term' = 'Member to Provider Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_count_available` SET TAGS ('pii_business_glossary_term' = 'Provider Count Available');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_count_required` SET TAGS ('pii_business_glossary_term' = 'Provider Count Required');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_submission_type` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_submission_type` SET TAGS ('pii_value_regex' = 'cms-medicare|cms-marketplace|state-doi|ncqa|internal|aca-qhp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_action_taken` SET TAGS ('pii_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('pii_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_status` SET TAGS ('pii_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_status` SET TAGS ('pii_value_regex' = 'not-started|in-progress|completed|verified|overdue');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `specialty_type` SET TAGS ('pii_business_glossary_term' = 'Specialty Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `submission_status` SET TAGS ('pii_value_regex' = 'draft|submitted|accepted|rejected|resubmission-required');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `survey_method` SET TAGS ('pii_business_glossary_term' = 'Survey Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `survey_method` SET TAGS ('pii_value_regex' = 'member-survey|secret-shopper-call|provider-survey|administrative-data|geospatial-analysis');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `telehealth_offered_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Offered Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_compliance_percentage` SET TAGS ('pii_business_glossary_term' = 'Time Distance Compliance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_standard_miles` SET TAGS ('pii_business_glossary_term' = 'Time Distance Standard Miles');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_standard_minutes` SET TAGS ('pii_business_glossary_term' = 'Time Distance Standard Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `wait_time_days_routine` SET TAGS ('pii_business_glossary_term' = 'Wait Time Days Routine');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `wait_time_days_urgent` SET TAGS ('pii_business_glossary_term' = 'Wait Time Days Urgent');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_fhir_resource' = 'DetectedIssue');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `adequacy_gap_id` SET TAGS ('pii_business_glossary_term' = 'Adequacy Gap Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Assessment Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `network_service_area_id` SET TAGS ('pii_business_glossary_term' = 'Service Area Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `affected_member_count` SET TAGS ('pii_business_glossary_term' = 'Affected Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `available_provider_count` SET TAGS ('pii_business_glossary_term' = 'Available Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_approval_date` SET TAGS ('pii_business_glossary_term' = 'Exception Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_granted_flag` SET TAGS ('pii_business_glossary_term' = 'Exception Granted Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_justification` SET TAGS ('pii_business_glossary_term' = 'Exception Justification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_request_date` SET TAGS ('pii_business_glossary_term' = 'Exception Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_requested_flag` SET TAGS ('pii_business_glossary_term' = 'Exception Requested Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_magnitude` SET TAGS ('pii_business_glossary_term' = 'Gap Magnitude');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_number` SET TAGS ('pii_business_glossary_term' = 'Gap Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_severity` SET TAGS ('pii_business_glossary_term' = 'Gap Severity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_severity` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_status` SET TAGS ('pii_business_glossary_term' = 'Gap Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_status` SET TAGS ('pii_value_regex' = 'identified|remediation_in_progress|resolved|exception_granted|waived');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_type` SET TAGS ('pii_business_glossary_term' = 'Gap Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_type` SET TAGS ('pii_value_regex' = 'specialty|facility|geographic|time_distance|appointment_wait_time|essential_community_provider');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_code` SET TAGS ('pii_business_glossary_term' = 'Geographic Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_name` SET TAGS ('pii_business_glossary_term' = 'Geographic Area Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_type` SET TAGS ('pii_business_glossary_term' = 'Geographic Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_type` SET TAGS ('pii_value_regex' = 'county|zip_code|cbsa|service_area|custom_region');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare_advantage|medicaid|marketplace|dual_eligible');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `remediation_action` SET TAGS ('pii_business_glossary_term' = 'Remediation Action');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `remediation_owner` SET TAGS ('pii_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `required_provider_count` SET TAGS ('pii_business_glossary_term' = 'Required Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `specialty_name` SET TAGS ('pii_business_glossary_term' = 'Specialty Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `standard_threshold` SET TAGS ('pii_business_glossary_term' = 'Standard Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `standard_type` SET TAGS ('pii_business_glossary_term' = 'Standard Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `standard_type` SET TAGS ('pii_value_regex' = 'time_distance|provider_to_member_ratio|appointment_availability|essential_community_provider_percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `target_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_directory_id` SET TAGS ('pii_business_glossary_term' = 'Provider Directory ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Directory Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Maintaining Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `accessibility_features` SET TAGS ('pii_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `ada_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `board_certification_status` SET TAGS ('pii_business_glossary_term' = 'Board Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `board_certification_status` SET TAGS ('pii_value_regex' = 'certified|not_certified|eligible|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `county` SET TAGS ('pii_business_glossary_term' = 'County');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_publication_channel` SET TAGS ('pii_business_glossary_term' = 'Directory Publication Channel');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_publication_channel` SET TAGS ('pii_value_regex' = 'online|print|api|mobile_app|call_center');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_status` SET TAGS ('pii_business_glossary_term' = 'Directory Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending_verification|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Provider Gender');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|non-binary|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('pii_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `hospital_affiliation` SET TAGS ('pii_business_glossary_term' = 'Hospital Affiliation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `languages_spoken` SET TAGS ('pii_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_method` SET TAGS ('pii_business_glossary_term' = 'Last Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_method` SET TAGS ('pii_value_regex' = 'outbound_call|online_attestation|ehr_data_match|claims_inference|mail_survey|email_confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_outcome` SET TAGS ('pii_business_glossary_term' = 'Last Verification Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_outcome` SET TAGS ('pii_value_regex' = 'confirmed|updated|unable_to_reach|provider_declined|no_response');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `next_verification_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `practice_location_name` SET TAGS ('pii_business_glossary_term' = 'Practice Location Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `specialty_primary` SET TAGS ('pii_business_glossary_term' = 'Primary Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `specialty_secondary` SET TAGS ('pii_business_glossary_term' = 'Secondary Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `telehealth_available_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `verified_fields` SET TAGS ('pii_business_glossary_term' = 'Verified Fields');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `verifying_agent` SET TAGS ('pii_business_glossary_term' = 'Verifying Agent');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_subdomain' = 'value_programs');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Vbc Arrangement Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `vbc_program_id` SET TAGS ('pii_business_glossary_term' = 'Vbc Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('pii_business_glossary_term' = 'Arrangement Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('pii_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|active|suspended|terminated|completed');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `attributed_member_count` SET TAGS ('pii_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `attribution_methodology` SET TAGS ('pii_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `attribution_methodology` SET TAGS ('pii_value_regex' = 'prospective|retrospective|voluntary_alignment|claims_based');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `benchmark_amount` SET TAGS ('pii_business_glossary_term' = 'Benchmark Amount');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `benchmark_methodology` SET TAGS ('pii_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `benchmark_methodology` SET TAGS ('pii_value_regex' = 'historical_baseline|regional_average|national_trend|risk_adjusted_pmpm|episode_target_price');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `care_coordination_required_flag` SET TAGS ('pii_business_glossary_term' = 'Care Coordination Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `cms_aco_code` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) ACO ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `cms_aco_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `cms_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'CMS Reporting Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `data_sharing_agreement_flag` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Agreement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Health Information Technology (IT) Certification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `minimum_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Loss Rate (MLR)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `minimum_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Savings Rate (MSR)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_aco_name` SET TAGS ('pii_business_glossary_term' = 'Participating ACO Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_provider_count` SET TAGS ('pii_business_glossary_term' = 'Participating Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_tin` SET TAGS ('pii_business_glossary_term' = 'Participating Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_tin` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `performance_guarantee_amount` SET TAGS ('pii_business_glossary_term' = 'Performance Guarantee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `primary_care_physician_count` SET TAGS ('pii_business_glossary_term' = 'Primary Care Physician (PCP) Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `quality_measure_set` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `quality_performance_threshold` SET TAGS ('pii_business_glossary_term' = 'Quality Performance Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `reconciliation_frequency` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `reconciliation_frequency` SET TAGS ('pii_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_type` SET TAGS ('pii_business_glossary_term' = 'Record Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_type` SET TAGS ('pii_value_regex' = 'program_template|participation_instance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `risk_model` SET TAGS ('pii_business_glossary_term' = 'Risk Model');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `risk_model` SET TAGS ('pii_value_regex' = 'one_sided_risk|two_sided_risk|upside_only|downside_risk|full_capitation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `service_area_description` SET TAGS ('pii_business_glossary_term' = 'Service Area Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `shared_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Shared Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `shared_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Shared Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `specialist_physician_count` SET TAGS ('pii_business_glossary_term' = 'Specialist Physician Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `sponsoring_entity_name` SET TAGS ('pii_business_glossary_term' = 'Sponsoring Entity Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `stop_loss_limit` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Limit');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_subdomain' = 'value_programs');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `aco_provider_id` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `practice_location_id` SET TAGS ('pii_business_glossary_term' = 'Primary Service Location ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Arrangement ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `attributed_member_count` SET TAGS ('pii_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `attribution_methodology` SET TAGS ('pii_business_glossary_term' = 'Member Attribution Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `attribution_methodology` SET TAGS ('pii_value_regex' = 'prospective|retrospective|voluntary|claims_based');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `care_coordination_tier` SET TAGS ('pii_business_glossary_term' = 'Care Coordination Tier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `care_coordination_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|standard');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `cost_efficiency_score` SET TAGS ('pii_business_glossary_term' = 'Provider Cost Efficiency Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'ACO Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'credentialed|pending|expired|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'ACO Participation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `ehr_integration_flag` SET TAGS ('pii_business_glossary_term' = 'Electronic Health Record (EHR) Integration Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Provider Enrollment Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `last_credentialing_date` SET TAGS ('pii_business_glossary_term' = 'Last Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `next_credentialing_date` SET TAGS ('pii_business_glossary_term' = 'Next Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `panel_size_limit` SET TAGS ('pii_business_glossary_term' = 'Provider Panel Size Limit');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_role` SET TAGS ('pii_business_glossary_term' = 'ACO Participation Role');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_role` SET TAGS ('pii_value_regex' = 'primary_care|specialist|facility|ancillary|behavioral_health|post_acute');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'ACO Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_type` SET TAGS ('pii_business_glossary_term' = 'ACO Participation Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_type` SET TAGS ('pii_value_regex' = 'full_risk|shared_savings|preferred|affiliate|network_only');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'ACO Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `primary_care_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_tin` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_tin` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_tin` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_tin` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `quality_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Reporting Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Provider Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `risk_sharing_percentage` SET TAGS ('pii_business_glossary_term' = 'Risk Sharing Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `shared_savings_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Shared Savings Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'ACO Participation Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_business_glossary_term' = 'Participation Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_value_regex' = 'voluntary|performance|compliance|contract_end|merger|other');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `vbc_track` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Track');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `vbc_track` SET TAGS ('pii_value_regex' = 'track_1|track_2|track_3|enhanced|basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_id` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Exception ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `benefit_package_id` SET TAGS ('pii_business_glossary_term' = 'CMS Plan Benefit Package (PBP) ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `affected_member_count` SET TAGS ('pii_business_glossary_term' = 'Affected Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `alternative_access_arrangement` SET TAGS ('pii_business_glossary_term' = 'Alternative Access Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `appeal_decision` SET TAGS ('pii_business_glossary_term' = 'Appeal Decision');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `appeal_decision` SET TAGS ('pii_value_regex' = 'upheld|overturned|pending');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Exception Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `approved_terms` SET TAGS ('pii_business_glossary_term' = 'Approved Exception Terms');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `denial_date` SET TAGS ('pii_business_glossary_term' = 'Exception Denial Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Exception Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_number` SET TAGS ('pii_business_glossary_term' = 'Exception Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_status` SET TAGS ('pii_business_glossary_term' = 'Exception Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_type` SET TAGS ('pii_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_type` SET TAGS ('pii_value_regex' = 'time_distance_waiver|rural_exception|access_plan|specialty_shortage|temporary_disruption|other');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `filing_date` SET TAGS ('pii_business_glossary_term' = 'Exception Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `geographic_description` SET TAGS ('pii_business_glossary_term' = 'Geographic Area Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `internal_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'medicare_advantage|medicaid|commercial|marketplace|dual_eligible');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `member_notification_date` SET TAGS ('pii_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `member_notification_flag` SET TAGS ('pii_business_glossary_term' = 'Member Notification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `mitigation_plan` SET TAGS ('pii_business_glossary_term' = 'Access Mitigation Plan');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `provider_recruitment_effort` SET TAGS ('pii_business_glossary_term' = 'Provider Recruitment Effort Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'cms|state_doi|ncqa|other');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `review_due_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Review Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `service_area_code` SET TAGS ('pii_business_glossary_term' = 'Service Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `service_area_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `specialty_name` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `time_distance_standard_waived` SET TAGS ('pii_business_glossary_term' = 'Time-Distance Standard Waived');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_subdomain' = 'provider_lifecycle');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_event_id` SET TAGS ('pii_business_glossary_term' = 'Change Event Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Change Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `aco_participation_flag` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_approval_date` SET TAGS ('pii_business_glossary_term' = 'Change Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_effective_date` SET TAGS ('pii_business_glossary_term' = 'Change Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_reason_code` SET TAGS ('pii_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_reason_description` SET TAGS ('pii_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_request_date` SET TAGS ('pii_business_glossary_term' = 'Change Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_status` SET TAGS ('pii_business_glossary_term' = 'Change Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_status` SET TAGS ('pii_value_regex' = 'pending|approved|effective|cancelled|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_type` SET TAGS ('pii_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_type` SET TAGS ('pii_value_regex' = 'addition|termination|tier_reassignment|panel_status_change|service_area_modification|credentialing_status_change');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('pii_business_glossary_term' = 'Continuity of Care (COC) End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `facility_type` SET TAGS ('pii_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `internal_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `lob_applicability` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_impact_count` SET TAGS ('pii_business_glossary_term' = 'Member Impact Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Member Notification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_notification_sent_date` SET TAGS ('pii_business_glossary_term' = 'Member Notification Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_notification_status` SET TAGS ('pii_business_glossary_term' = 'Member Notification Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_notification_status` SET TAGS ('pii_value_regex' = 'not_required|pending|sent|acknowledged|failed');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_transition_plan_required_flag` SET TAGS ('pii_business_glossary_term' = 'Member Transition Plan Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `network_adequacy_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `new_panel_status` SET TAGS ('pii_business_glossary_term' = 'New Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `new_panel_status` SET TAGS ('pii_value_regex' = 'open|closed|limited');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `new_tier_code` SET TAGS ('pii_business_glossary_term' = 'New Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `new_tier_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `prior_panel_status` SET TAGS ('pii_business_glossary_term' = 'Prior Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `prior_panel_status` SET TAGS ('pii_value_regex' = 'open|closed|limited');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `prior_tier_code` SET TAGS ('pii_business_glossary_term' = 'Prior Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `prior_tier_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_directory_update_date` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Update Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_approval_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_filing_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `service_area_code` SET TAGS ('pii_business_glossary_term' = 'Service Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `service_area_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `specialty_type` SET TAGS ('pii_business_glossary_term' = 'Specialty Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `termination_notice_date` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `termination_type` SET TAGS ('pii_business_glossary_term' = 'Termination Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `termination_type` SET TAGS ('pii_value_regex' = 'voluntary|for_cause|contract_non_renewal|credentialing_revocation|mutual_agreement|network_restructuring');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `transition_plan_completion_date` SET TAGS ('pii_business_glossary_term' = 'Transition Plan Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `access_standard_id` SET TAGS ('pii_business_glossary_term' = 'Access Standard Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `superseded_by_standard_access_standard_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Access Standard Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `access_standard_status` SET TAGS ('pii_business_glossary_term' = 'Access Standard Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `access_standard_status` SET TAGS ('pii_value_regex' = 'active|inactive|draft|pending_approval|superseded');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `after_hours_availability_required_flag` SET TAGS ('pii_business_glossary_term' = 'After-Hours Availability Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `appointment_type_scope` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Scope');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `appointment_type_scope` SET TAGS ('pii_value_regex' = 'new_patient|established_patient|follow_up|consultation|all');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `compliance_measurement_method` SET TAGS ('pii_business_glossary_term' = 'Compliance Measurement Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `compliance_measurement_method` SET TAGS ('pii_value_regex' = 'appointment_log_audit|member_survey|secret_shopper|provider_attestation|claims_analysis');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `exception_criteria` SET TAGS ('pii_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `line_of_business_applicability` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `maximum_wait_time_days` SET TAGS ('pii_business_glossary_term' = 'Maximum Wait Time in Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `maximum_wait_time_hours` SET TAGS ('pii_business_glossary_term' = 'Maximum Wait Time in Hours');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `member_age_group` SET TAGS ('pii_business_glossary_term' = 'Member Age Group');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `member_age_group` SET TAGS ('pii_value_regex' = 'pediatric|adult|geriatric|all');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|continuous');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `network_adequacy_credit_flag` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Credit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `penalty_for_noncompliance` SET TAGS ('pii_business_glossary_term' = 'Penalty for Noncompliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `regulatory_source` SET TAGS ('pii_business_glossary_term' = 'Regulatory Source');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `specialty_category` SET TAGS ('pii_business_glossary_term' = 'Specialty Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_code` SET TAGS ('pii_business_glossary_term' = 'Access Standard Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_business_glossary_term' = 'Access Standard Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_type` SET TAGS ('pii_business_glossary_term' = 'Access Standard Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_type` SET TAGS ('pii_value_regex' = 'routine|urgent|emergent|preventive|behavioral_health|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `telehealth_equivalency_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Equivalency Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `access_survey_id` SET TAGS ('pii_business_glossary_term' = 'Access Survey ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Surveyor ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `access_standard_met_flag` SET TAGS ('pii_business_glossary_term' = 'Access Standard Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `access_standard_threshold_days` SET TAGS ('pii_business_glossary_term' = 'Access Standard Threshold (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `accessibility_accommodation_available_flag` SET TAGS ('pii_business_glossary_term' = 'Accessibility Accommodation Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `accessibility_accommodation_requested_flag` SET TAGS ('pii_business_glossary_term' = 'Accessibility Accommodation Requested Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `after_hours_access_available_flag` SET TAGS ('pii_business_glossary_term' = 'After-Hours Access Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_offered_date` SET TAGS ('pii_business_glossary_term' = 'Appointment Offered Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_reason` SET TAGS ('pii_business_glossary_term' = 'Appointment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_scheduled_flag` SET TAGS ('pii_business_glossary_term' = 'Appointment Scheduled Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_type_requested` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Requested');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_type_requested` SET TAGS ('pii_value_regex' = 'routine|urgent|preventive|follow_up|new_patient|established_patient');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `cahps_survey_supplementation_flag` SET TAGS ('pii_business_glossary_term' = 'Consumer Assessment of Healthcare Providers and Systems (CAHPS) Survey Supplementation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `call_attempts` SET TAGS ('pii_business_glossary_term' = 'Call Attempts');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `call_outcome` SET TAGS ('pii_business_glossary_term' = 'Call Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `call_outcome` SET TAGS ('pii_value_regex' = 'completed|no_answer|busy|disconnected|wrong_number|voicemail');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `cms_star_rating_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Star Rating Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `compliance_outcome` SET TAGS ('pii_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `compliance_outcome` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|not_applicable|inconclusive');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `hedis_measure_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Measure Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `language_requested` SET TAGS ('pii_business_glossary_term' = 'Language Requested');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `language_services_available_flag` SET TAGS ('pii_business_glossary_term' = 'Language Services Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `network_adequacy_filing_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Filing Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `non_compliance_reason` SET TAGS ('pii_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `specialty_name` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_cycle` SET TAGS ('pii_business_glossary_term' = 'Survey Cycle');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_date` SET TAGS ('pii_business_glossary_term' = 'Survey Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_method` SET TAGS ('pii_business_glossary_term' = 'Survey Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_method` SET TAGS ('pii_value_regex' = 'member_survey|secret_shopper_call|mystery_shopper_call|telephonic_audit|online_survey|in_person_audit');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_notes` SET TAGS ('pii_business_glossary_term' = 'Survey Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_status` SET TAGS ('pii_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_status` SET TAGS ('pii_value_regex' = 'completed|in_progress|cancelled|invalid');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `telehealth_offered_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Offered Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `wait_time_offered_days` SET TAGS ('pii_business_glossary_term' = 'Wait Time Offered (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_id` SET TAGS ('pii_business_glossary_term' = 'Filing Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `benefit_package_id` SET TAGS ('pii_business_glossary_term' = 'Plan Benefit Package Identifier (PBP ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `adequacy_standard_met_flag` SET TAGS ('pii_business_glossary_term' = 'Adequacy Standard Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `approval_number` SET TAGS ('pii_business_glossary_term' = 'Approval Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `approval_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `attestation_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `attestation_flag` SET TAGS ('pii_business_glossary_term' = 'Attestation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `deficiency_description` SET TAGS ('pii_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `deficiency_issued_date` SET TAGS ('pii_business_glossary_term' = 'Deficiency Issued Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `deficiency_issued_flag` SET TAGS ('pii_business_glossary_term' = 'Deficiency Issued Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_approval_date` SET TAGS ('pii_business_glossary_term' = 'Exception Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_approved_flag` SET TAGS ('pii_business_glossary_term' = 'Exception Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_geography` SET TAGS ('pii_business_glossary_term' = 'Exception Geography');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_justification` SET TAGS ('pii_business_glossary_term' = 'Exception Justification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_specialty` SET TAGS ('pii_business_glossary_term' = 'Exception Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_type` SET TAGS ('pii_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_number` SET TAGS ('pii_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_status` SET TAGS ('pii_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_type` SET TAGS ('pii_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'medicare_advantage|medicaid|commercial|qhp|dual_eligible');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Filing Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'cms|state_doi|naic|hhs|ncqa');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `rejection_date` SET TAGS ('pii_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `response_submitted_date` SET TAGS ('pii_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `submission_method` SET TAGS ('pii_value_regex' = 'hpms|state_portal|serff|email|mail|fax');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `submitted_by` SET TAGS ('pii_business_glossary_term' = 'Submitted By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `withdrawal_date` SET TAGS ('pii_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `withdrawal_reason` SET TAGS ('pii_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_subdomain' = 'value_programs');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_fhir_resource' = 'CareTeam');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `vbc_program_id` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `vbc_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `vbc_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `vbc_plan_health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `vbc_plan_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `vbc_plan_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `attribution_methodology` SET TAGS ('pii_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `attribution_methodology` SET TAGS ('pii_value_regex' = 'Prospective|Retrospective|Voluntary Alignment|Claims-Based|Hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `benchmark_methodology` SET TAGS ('pii_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `benchmark_methodology` SET TAGS ('pii_value_regex' = 'Historical Trend|Regional Average|National Average|Risk-Adjusted PMPM|Episode-Based');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `benchmark_year` SET TAGS ('pii_business_glossary_term' = 'Benchmark Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `care_coordination_required_flag` SET TAGS ('pii_business_glossary_term' = 'Care Coordination Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `cms_program_identifier` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Program Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `eligible_provider_types` SET TAGS ('pii_business_glossary_term' = 'Eligible Provider Types');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('pii_business_glossary_term' = 'Health Information Technology (IT) Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'Medicare|Medicaid|Commercial|Exchange|Dual Eligible|Medicare Advantage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `minimum_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Loss Rate (MLR)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `minimum_member_threshold` SET TAGS ('pii_business_glossary_term' = 'Minimum Member Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `minimum_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Savings Rate (MSR)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `performance_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `performance_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_category` SET TAGS ('pii_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_category` SET TAGS ('pii_value_regex' = 'ACO|Bundled Payment|Shared Savings|Pay for Performance|Capitation|Population Health');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_description` SET TAGS ('pii_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_owner` SET TAGS ('pii_business_glossary_term' = 'Program Owner');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_status` SET TAGS ('pii_value_regex' = 'Active|Inactive|Pending Approval|Suspended|Terminated|Pilot');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'MSSP|REACH|NextGen|Commercial P4P|Episode-Based|Capitation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_url` SET TAGS ('pii_business_glossary_term' = 'Program URL');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_year` SET TAGS ('pii_business_glossary_term' = 'Program Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `quality_measure_set` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `quality_performance_threshold` SET TAGS ('pii_business_glossary_term' = 'Quality Performance Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `risk_model` SET TAGS ('pii_business_glossary_term' = 'Risk Model');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `risk_model` SET TAGS ('pii_value_regex' = 'Upside Only|Two-Sided|Downside Only|Capitation|Blended');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `settlement_frequency` SET TAGS ('pii_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `settlement_frequency` SET TAGS ('pii_value_regex' = 'Annual|Semi-Annual|Quarterly|Monthly');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `shared_loss_rate` SET TAGS ('pii_business_glossary_term' = 'Shared Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `shared_savings_rate` SET TAGS ('pii_business_glossary_term' = 'Shared Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `sponsoring_entity` SET TAGS ('pii_business_glossary_term' = 'Sponsoring Entity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `sponsoring_entity` SET TAGS ('pii_value_regex' = 'CMS|State Medicaid|Commercial|Self-Insured Employer|Multi-Payer');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_subdomain' = 'provider_lifecycle');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_id` SET TAGS ('pii_business_glossary_term' = 'Termination Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Termination Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `active_treatment_count` SET TAGS ('pii_business_glossary_term' = 'Active Treatment Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `active_treatment_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `active_treatment_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_value_regex' = 'upheld|overturned|modified|withdrawn|pending');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `appeal_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `appeals_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeals Filed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `claims_runout_end_date` SET TAGS ('pii_business_glossary_term' = 'Claims Runout End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `claims_runout_period_days` SET TAGS ('pii_business_glossary_term' = 'Claims Runout Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('pii_business_glossary_term' = 'Continuity of Care End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `contract_end_date` SET TAGS ('pii_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `credentialing_related_flag` SET TAGS ('pii_business_glossary_term' = 'Credentialing Related Termination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Termination Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `financial_settlement_date` SET TAGS ('pii_business_glossary_term' = 'Financial Settlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `financial_settlement_required_flag` SET TAGS ('pii_business_glossary_term' = 'Financial Settlement Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `for_cause_flag` SET TAGS ('pii_business_glossary_term' = 'For Cause Termination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_impact_count` SET TAGS ('pii_business_glossary_term' = 'Member Impact Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_notification_date` SET TAGS ('pii_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_notification_method` SET TAGS ('pii_business_glossary_term' = 'Member Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_notification_method` SET TAGS ('pii_value_regex' = 'mail|email|portal|phone|multiple');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Member Notification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `network_adequacy_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Termination Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `notice_date` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `provider_directory_removal_date` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Removal Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `regulatory_report_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `regulatory_report_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Report Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `replacement_provider_required_flag` SET TAGS ('pii_business_glossary_term' = 'Replacement Provider Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_number` SET TAGS ('pii_business_glossary_term' = 'Termination Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_status` SET TAGS ('pii_business_glossary_term' = 'Termination Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_status` SET TAGS ('pii_value_regex' = 'pending|approved|effective|completed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_type` SET TAGS ('pii_business_glossary_term' = 'Termination Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_type` SET TAGS ('pii_value_regex' = 'voluntary|involuntary|for_cause|contract_non_renewal|credentialing_revocation|mutual_agreement');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `par_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Provider Agreement ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `parent_par_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Parent Par Agreement Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `parent_par_agreement_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_scope_description` SET TAGS ('pii_business_glossary_term' = 'Agreement Scope Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_value_regex' = 'individual|group|entity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_version` SET TAGS ('pii_business_glossary_term' = 'Agreement Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_effective_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_flag` SET TAGS ('pii_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_termination_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `compliance_status_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Status Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `compliance_status_flag` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('pii_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `electronic_signature_flag` SET TAGS ('pii_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `internal_notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Lob');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `paper_signature_flag` SET TAGS ('pii_business_glossary_term' = 'Paper Signature Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `par_agreement_status` SET TAGS ('pii_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `par_agreement_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|pending|draft');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_date` SET TAGS ('pii_business_glossary_term' = 'Provider Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Provider Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_status` SET TAGS ('pii_value_regex' = 'credentialed|pending|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_directory_last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_directory_listing_flag` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Listing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_network_status` SET TAGS ('pii_business_glossary_term' = 'Provider Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_network_status` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|pending');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_participation_role` SET TAGS ('pii_business_glossary_term' = 'Provider Participation Role');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_participation_role` SET TAGS ('pii_value_regex' = 'primary_care|specialist|both|other');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_recredentialing_due_date` SET TAGS ('pii_business_glossary_term' = 'Provider Re‑credentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_tier_assignment` SET TAGS ('pii_business_glossary_term' = 'Provider Tier Assignment');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `regulatory_approval_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `reimbursement_methodology` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_business_glossary_term' = 'Signatory Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signature_date` SET TAGS ('pii_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('pii_business_glossary_term' = 'Signed By Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('pii_business_glossary_term' = 'Signed By NPI');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_title` SET TAGS ('pii_business_glossary_term' = 'Signed By Title');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_reason_description` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `network_directory_verification_id` SET TAGS ('pii_business_glossary_term' = 'Directory Verification ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Verification Agent ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Verification Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `accepting_new_patients_status` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `accepting_new_patients_status` SET TAGS ('pii_value_regex' = 'accepting|not_accepting|accepting_existing_only|waitlist|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `accepting_new_patients_verified` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Status Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `accuracy_score` SET TAGS ('pii_business_glossary_term' = 'Directory Accuracy Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `address_verified` SET TAGS ('pii_business_glossary_term' = 'Address Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `address_verified` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `address_verified` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `change_summary` SET TAGS ('pii_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `changes_identified` SET TAGS ('pii_business_glossary_term' = 'Changes Identified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `cms_reportable` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Reportable');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `compliance_quarter` SET TAGS ('pii_business_glossary_term' = 'Compliance Quarter');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `compliance_quarter` SET TAGS ('pii_value_regex' = '^[0-9]{4}-Q[1-4]$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `compliance_year` SET TAGS ('pii_business_glossary_term' = 'Compliance Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `contact_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Contact Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `directory_update_timestamp` SET TAGS ('pii_business_glossary_term' = 'Directory Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `directory_updated` SET TAGS ('pii_business_glossary_term' = 'Directory Updated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `first_contact_attempt_date` SET TAGS ('pii_business_glossary_term' = 'First Contact Attempt Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `last_contact_attempt_date` SET TAGS ('pii_business_glossary_term' = 'Last Contact Attempt Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `next_verification_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `npi_verified` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI) Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `phone_verified` SET TAGS ('pii_business_glossary_term' = 'Phone Number Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `phone_verified` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `phone_verified` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `prior_verification_date` SET TAGS ('pii_business_glossary_term' = 'Prior Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `provider_response_time_hours` SET TAGS ('pii_business_glossary_term' = 'Provider Response Time Hours');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `specialty_verified` SET TAGS ('pii_business_glossary_term' = 'Specialty Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_agent_name` SET TAGS ('pii_business_glossary_term' = 'Verification Agent Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_channel` SET TAGS ('pii_business_glossary_term' = 'Verification Channel');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_language` SET TAGS ('pii_business_glossary_term' = 'Verification Language');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_method` SET TAGS ('pii_value_regex' = 'outbound_call|online_attestation|ehr_hie_match|claims_inference|mail_survey|email_confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_notes` SET TAGS ('pii_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_number` SET TAGS ('pii_business_glossary_term' = 'Verification Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_number` SET TAGS ('pii_value_regex' = '^DV-[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_source_document` SET TAGS ('pii_business_glossary_term' = 'Verification Source Document');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'confirmed|updated|unable_to_reach|provider_declined|invalid_contact|pending_response');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_system` SET TAGS ('pii_business_glossary_term' = 'Verification System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verified_fields` SET TAGS ('pii_business_glossary_term' = 'Verified Fields');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `provider_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Network Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Credentialing Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Liaison Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `accessibility_ada_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Accessibility Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `aco_participant_flag` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `after_hours_availability_flag` SET TAGS ('pii_business_glossary_term' = 'After Hours Availability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('pii_business_glossary_term' = 'Continuity of Care End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `credentialing_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'credentialed|pending|expired|suspended|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `current_panel_size` SET TAGS ('pii_business_glossary_term' = 'Current Panel Size');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `directory_last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Directory Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `directory_listing_flag` SET TAGS ('pii_business_glossary_term' = 'Directory Listing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `geographic_service_area` SET TAGS ('pii_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `in_network_flag` SET TAGS ('pii_business_glossary_term' = 'In-Network Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `language_services_available` SET TAGS ('pii_business_glossary_term' = 'Language Services Available');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `network_adequacy_category` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `network_adequacy_category` SET TAGS ('pii_value_regex' = 'essential|standard|enhanced|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `network_participation_type` SET TAGS ('pii_business_glossary_term' = 'Network Participation Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `network_participation_type` SET TAGS ('pii_value_regex' = 'par|non_par|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `panel_capacity` SET TAGS ('pii_business_glossary_term' = 'Panel Capacity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `panel_status` SET TAGS ('pii_business_glossary_term' = 'Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `panel_status` SET TAGS ('pii_value_regex' = 'open|closed|limited|full');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `participation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `pcp_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider (PCP) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `quality_tier_designation` SET TAGS ('pii_business_glossary_term' = 'Quality Tier Designation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `quality_tier_designation` SET TAGS ('pii_value_regex' = 'high_quality|standard_quality|low_quality|not_rated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_active_flag` SET TAGS ('pii_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `recredentialing_due_date` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `risk_sharing_arrangement_flag` SET TAGS ('pii_business_glossary_term' = 'Risk Sharing Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `specialist_flag` SET TAGS ('pii_business_glossary_term' = 'Specialist Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `telehealth_available_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_initiated_by` SET TAGS ('pii_business_glossary_term' = 'Termination Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_initiated_by` SET TAGS ('pii_value_regex' = 'provider|health_plan|mutual|regulatory');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `tier_assignment` SET TAGS ('pii_business_glossary_term' = 'Tier Assignment');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `tier_assignment` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `vbc_participant_flag` SET TAGS ('pii_business_glossary_term' = 'Value-Based Care (VBC) Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `weekend_availability_flag` SET TAGS ('pii_business_glossary_term' = 'Weekend Availability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_subdomain' = 'provider_lifecycle');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `recruitment_id` SET TAGS ('pii_business_glossary_term' = 'Recruitment ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Adequacy Assessment ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `filing_id` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Recruiter Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Recruitment Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `adequacy_gap_type` SET TAGS ('pii_business_glossary_term' = 'Adequacy Gap Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `adequacy_gap_type` SET TAGS ('pii_value_regex' = 'time_distance|provider_ratio|specialty_shortage|geographic_coverage|access_hours');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `recruitment_code` SET TAGS ('pii_business_glossary_term' = 'Recruitment Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `recruitment_code` SET TAGS ('pii_value_regex' = '^REC-[0-9]{8}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `recruitment_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `contract_effective_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `contracting_referral_date` SET TAGS ('pii_business_glossary_term' = 'Contracting Referral Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `disposition` SET TAGS ('pii_business_glossary_term' = 'Recruitment Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `disposition` SET TAGS ('pii_value_regex' = 'contracted|declined|no_response|in_progress|on_hold|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `disposition_date` SET TAGS ('pii_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `disposition_reason` SET TAGS ('pii_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `estimated_annual_claims_volume` SET TAGS ('pii_business_glossary_term' = 'Estimated Annual Claims Volume');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `estimated_member_impact` SET TAGS ('pii_business_glossary_term' = 'Estimated Member Impact');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `follow_up_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|marketplace|dual_eligible');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Recruitment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `outreach_date` SET TAGS ('pii_business_glossary_term' = 'Outreach Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `outreach_method` SET TAGS ('pii_business_glossary_term' = 'Outreach Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `outreach_method` SET TAGS ('pii_value_regex' = 'phone|email|in_person|mail|referral|conference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `provider_response` SET TAGS ('pii_business_glossary_term' = 'Provider Response');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `provider_response` SET TAGS ('pii_value_regex' = 'interested|not_interested|requested_info|no_response|deferred');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Recruitment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `reason` SET TAGS ('pii_value_regex' = 'adequacy_gap_closure|strategic_expansion|member_request|competitor_response|quality_improvement|cost_reduction');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `recruiter_assigned` SET TAGS ('pii_business_glossary_term' = 'Recruiter Assigned');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `recruitment_status` SET TAGS ('pii_business_glossary_term' = 'Recruitment Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `recruitment_status` SET TAGS ('pii_value_regex' = 'active|completed|cancelled|on_hold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_county_fips` SET TAGS ('pii_business_glossary_term' = 'Target County Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_county_fips` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_geographic_area` SET TAGS ('pii_business_glossary_term' = 'Target Geographic Area');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_name` SET TAGS ('pii_business_glossary_term' = 'Target Provider Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Target Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_tin` SET TAGS ('pii_business_glossary_term' = 'Target Provider Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_tin` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_provider_tin` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_specialty` SET TAGS ('pii_business_glossary_term' = 'Target Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_zip_code` SET TAGS ('pii_business_glossary_term' = 'Target ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `target_zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`recruitment` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_service_area_id` SET TAGS ('pii_business_glossary_term' = 'Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `cms_service_area_code` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `cms_service_area_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `cms_service_area_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `commercial_approved_flag` SET TAGS ('pii_business_glossary_term' = 'Commercial Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `county_fips_code` SET TAGS ('pii_business_glossary_term' = 'County Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `county_fips_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `county_fips_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `county_name` SET TAGS ('pii_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_resource_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `geographic_boundary_description` SET TAGS ('pii_business_glossary_term' = 'Geographic Boundary Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `medicaid_approved_flag` SET TAGS ('pii_business_glossary_term' = 'Medicaid Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `medicare_advantage_approved_flag` SET TAGS ('pii_business_glossary_term' = 'Medicare Advantage Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `member_residency_required_flag` SET TAGS ('pii_business_glossary_term' = 'Member Residency Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `msa_code` SET TAGS ('pii_business_glossary_term' = 'Metropolitan Statistical Area (MSA) Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `msa_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `msa_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `msa_name` SET TAGS ('pii_business_glossary_term' = 'Metropolitan Statistical Area (MSA) Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_approval_date` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_filing_date` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_status` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|under_review|waiver_granted|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_service_area_status` SET TAGS ('pii_business_glossary_term' = 'Service Area Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_service_area_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending_approval|suspended|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Service Area Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `out_of_area_coverage_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Out of Area Coverage Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `population_count` SET TAGS ('pii_business_glossary_term' = 'Population Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `qhp_approved_flag` SET TAGS ('pii_business_glossary_term' = 'Qualified Health Plan (QHP) Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `regulatory_approval_number` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `regulatory_approval_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `regulatory_approval_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_code` SET TAGS ('pii_business_glossary_term' = 'Service Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_name` SET TAGS ('pii_business_glossary_term' = 'Service Area Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_type` SET TAGS ('pii_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_type` SET TAGS ('pii_value_regex' = 'county_based|zip_based|msa_based|state_based|custom_boundary|multi_state');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `urban_rural_designation` SET TAGS ('pii_business_glossary_term' = 'Urban Rural Designation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `urban_rural_designation` SET TAGS ('pii_value_regex' = 'urban|suburban|rural|frontier|mixed');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
