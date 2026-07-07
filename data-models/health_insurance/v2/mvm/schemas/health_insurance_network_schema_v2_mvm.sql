-- Schema for Domain: network | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`network` COMMENT 'Owns provider network configurations, tier assignments, in-network/out-of-network designations, geographic access standards, network adequacy metrics, and service area configurations. Manages ACO and VBC arrangement participation, network-to-plan associations, network directories, and CMS network adequacy filings. Distinct from provider identity (provider domain) and contract terms (contract domain); network owns the structural relationship between providers and plan networks.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`provider_network` (
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network. Primary key for the provider network entity.',
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
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan product that is associated with this provider network. Links to the plan and benefit domains plan entity.',
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
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with this network adequacy assessment.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network being assessed for adequacy compliance.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` (
    `provider_directory_id` BIGINT COMMENT 'Unique identifier for the provider directory record. Primary key for the published provider directory entry representing the member-facing view of a providers network participation.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: CMS regulations (42 CFR 438.10) require plan-specific provider directories. Insurers publish and maintain directories per health plan, not just per network. This FK supports CMS compliance reporting, ',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: A provider directory entry represents the member-facing published view of a providers network participation. The par_agreement is the formal contractual basis authorizing that participation and direc',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Provider directory accuracy and CMS/NCQA directory validation require linking each directory listing to the canonical practice location record. Eliminates denormalized address fields; supports directo',
    `provider_assignment_id` BIGINT COMMENT 'Foreign key linking to network.provider_assignment. Business justification: provider_directory is the member-facing published view of a providers network participation; provider_assignment is the internal operational record of that same participation. Linking provider_direct',
    `provider_id` BIGINT COMMENT 'Reference to the provider master record. Links this directory entry to the provider identity in the provider domain.',
    `provider_network_id` BIGINT COMMENT 'Reference to the network configuration. Identifies which network this provider participates in for member directory searches.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: NCQA and CMS directory accuracy standards require directory listings to reference canonical specialty records. Eliminates denormalized specialty_primary and specialty_secondary fields; supports specia',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients. Critical field for member directory searches and CMS directory accuracy compliance.',
    `accessibility_features` STRING COMMENT 'Description of specific accessibility features available at the practice location, such as wheelchair ramps, accessible parking, or assistive listening devices.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the practice location is ADA-compliant and accessible to individuals with disabilities. Supports member searches for accessible facilities.',
    `board_certification_status` STRING COMMENT 'Indicates whether the provider is board-certified in their specialty. Used for quality assessment and member directory filtering.. Valid values are `certified|not_certified|eligible|unknown`',
    `county` STRING COMMENT 'County name of the practice location. Used for CMS network adequacy reporting and geographic access standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this provider directory record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score for this directory entry based on completeness, accuracy, and recency of verification. Range 0.00 to 100.00. Supports directory quality monitoring.',
    `directory_publication_channel` STRING COMMENT 'The channel through which this directory entry is published and accessible to members. Supports multi-channel directory distribution tracking.. Valid values are `online|print|api|mobile_app|call_center`',
    `directory_status` STRING COMMENT 'Current status of the provider directory entry. Indicates whether the entry is actively published, pending verification, or suspended from member-facing display.. Valid values are `active|inactive|pending_verification|suspended`',
    `effective_end_date` DATE COMMENT 'Date when this provider directory entry was terminated or became inactive. Null for currently active entries. Supports historical directory analysis.',
    `effective_start_date` DATE COMMENT 'Date when this provider directory entry became effective and available for member searches. Supports historical tracking of directory changes.',
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
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `telehealth_available_flag` BOOLEAN COMMENT 'Indicates whether the provider offers telehealth or virtual visit services. Supports member search for remote care options.',
    `termination_reason` STRING COMMENT 'Reason why the provider directory entry was terminated or inactivated. Examples include provider left network, practice closed, or data quality issue.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `verified_fields` STRING COMMENT 'Comma-separated list of fields that were verified during the last verification event. Examples include address, phone, accepting_new_patients, specialty.',
    `verifying_agent` STRING COMMENT 'Name or identifier of the person or system that performed the last verification. Used for audit trail and quality assurance.',
    `website_url` STRING COMMENT 'Website address for the provider or practice location. Displayed in member directory for additional provider information.',
    CONSTRAINT pk_provider_directory PRIMARY KEY(`provider_directory_id`)
) COMMENT 'Published provider directory record representing the member-facing view of a providers network participation, including full verification lifecycle tracking. Captures provider name, specialty, practice location, phone, accepting-new-patients status, telehealth availability, languages spoken, accessibility features (ADA compliance), last verified date, and directory publication channel (online, print, API). Embeds complete verification history as child records — including verification method (outbound call, online attestation, EHR/HIE data match, claims-based inference), verification date, verified fields (address, phone, accepting-new-patients, specialty), verification outcome (confirmed, updated, unable to reach), and verifying agent/system. Supports CMS directory accuracy requirements (42 CFR 422.111), No Surprises Act compliance, the 90-day directory update mandate, and quarterly verification tracking. This is the SSOT for member-facing directory data and its verification audit trail.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` (
    `par_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the provider participation agreement.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Hospitals and facilities contract directly with health plans via facility-level participation agreements. Linking par_agreement to facility supports facility contracting workflows, hospital network ad',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Group practices sign participation agreements as contracting entities in health insurance network contracting. Linking par_agreement to group_practice supports group-level contract management, credent',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with the agreement, if plan‑specific.',
    `parent_par_agreement_id` BIGINT COMMENT 'Self-referencing FK on par_agreement (parent_par_agreement_id)',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider participating in the network.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which the agreement applies.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: par_agreement carries a denormalized STRING column `provider_tier_assignment` representing the tier at which the provider participates under the agreement. Normalizing this to a FK tier_id → tier.tier',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` (
    `provider_assignment_id` BIGINT COMMENT 'Unique identifier for the network-provider association record. Primary key for this entity.',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: A provider_assignment record represents the operational participation of a provider in a network, while par_agreement is the formal contractual instrument governing that participation. Linking provide',
    `provider_id` BIGINT COMMENT 'Identifier of the provider participating in this network. Links to the provider master entity.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which this provider participates. Links to the network master entity.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Network adequacy reporting and NCQA/CMS compliance require tracking provider assignments by specialty. Linking provider_assignment to specialty enables adequacy gap analysis by specialty category, sup',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: provider_assignment carries a denormalized STRING column `tier_assignment` representing the providers tier designation within the network. Normalizing this to a FK tier_id → tier.tier_id replaces the',
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
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this network-provider association record was most recently updated in the system.',
    `vbc_participant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider participates in value-based care arrangements within this network. True indicates VBC participation.',
    `weekend_availability_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider offers weekend services to members of this network. True indicates weekend availability.',
    CONSTRAINT pk_provider_assignment PRIMARY KEY(`provider_assignment_id`)
) COMMENT 'Association entity representing the participation of a specific provider (NPI) within a specific provider network, capturing in-network status, effective and termination dates, tier assignment, accepting-new-patients flag, telehealth availability, panel status (open/closed), panel capacity, and credentialing linkage. This is the SSOT for the structural relationship between a provider and a network — distinct from provider identity (provider domain), contract terms (contract domain), and ACO-specific participation (aco_provider). Supports provider directory publication, CMS network adequacy filings, and member eligibility verification.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ADD CONSTRAINT `fk_network_tier_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_adequacy_standard_id` FOREIGN KEY (`adequacy_standard_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_standard`(`adequacy_standard_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_provider_assignment_id` FOREIGN KEY (`provider_assignment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_assignment`(`provider_assignment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_parent_par_agreement_id` FOREIGN KEY (`parent_par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_par_agreement_id` FOREIGN KEY (`par_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ADD CONSTRAINT `fk_network_provider_assignment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`tier`(`tier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `aco_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Network Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `facility_count` SET TAGS ('dbx_business_glossary_term' = 'Facility Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_business_glossary_term' = 'Geographic Footprint');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `last_adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Network Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'Commercial|Medicare|Medicaid|Exchange|ASO');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `member_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Accreditation Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_accreditation_status` SET TAGS ('dbx_value_regex' = 'Accredited|Provisional|Denied|Not Applicable|Pending');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Accreditation Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_adequacy_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_value_regex' = 'Adequate|Deficient|Conditional|Pending Review');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('dbx_business_glossary_term' = 'Network Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_description` SET TAGS ('dbx_business_glossary_term' = 'Network Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Directory Uniform Resource Locator (URL)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Pending|Terminated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP|ACO');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `next_adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Network Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Network Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `pcp_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `pcp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'Statewide|Regional|County|ZIP|National');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `specialist_count` SET TAGS ('dbx_business_glossary_term' = 'Specialist Physician Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Network Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Classification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Single Tier|Tiered');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `coinsurance_differential_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Differential Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `copay_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Differential Amount');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `cost_share_differential_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Differential Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `cost_share_differential_type` SET TAGS ('dbx_value_regex' = 'copay|coinsurance|deductible|hybrid|none');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `deductible_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `display_label` SET TAGS ('dbx_business_glossary_term' = 'Tier Display Label');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `facility_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Facility Type Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `member_steerage_incentive_description` SET TAGS ('dbx_business_glossary_term' = 'Member Steerage Incentive Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `network_adequacy_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Credit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `oop_max_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket (OOP) Maximum Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `quality_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `rank` SET TAGS ('dbx_business_glossary_term' = 'Tier Rank');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `sbc_disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'Summary of Benefits and Coverage (SBC) Disclosure Text');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `specialty_applicability` SET TAGS ('dbx_business_glossary_term' = 'Specialty Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_value_regex' = 'preferred|standard|specialty|out_of_network|value_based|narrow_network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `vbc_arrangement_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `plan_association_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Product Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `aco_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `adequacy_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Certification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_type` SET TAGS ('dbx_value_regex' = 'primary|supplemental|specialty|out_of_area|reciprocal|tertiary');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `auto_assignment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Assignment Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `directory_publication_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Publication Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Association Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|marketplace|dual_eligible|chip');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'individual|small_group|large_group|jumbo_group|government|student');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempt|conditional');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Association Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Network Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `pcp_selection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider (PCP) Selection Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `plan_association_status` SET TAGS ('dbx_business_glossary_term' = 'Association Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `plan_association_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Network Priority Rank');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `star_rating_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Association Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('dbx_subdomain' = 'compliance_adequacy');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|proposed|superseded|under-review');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `after_hours_availability_required` SET TAGS ('dbx_business_glossary_term' = 'After Hours Availability Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `after_hours_definition` SET TAGS ('dbx_business_glossary_term' = 'After Hours Definition');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'routine|urgent|preventive|behavioral-health|specialist|emergency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `compliance_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reporting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `compliance_reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly|on-demand');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `geographic_classification` SET TAGS ('dbx_business_glossary_term' = 'Geographic Classification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `geographic_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|frontier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'medicare-advantage|medicaid|commercial|marketplace|dual-eligible|all');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Maximum Distance in Miles');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Travel Time in Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wait Time in Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `minimum_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Standard Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP|all');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `provider_to_member_ratio` SET TAGS ('dbx_business_glossary_term' = 'Provider to Member Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `regulatory_source` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Source');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `regulatory_source` SET TAGS ('dbx_value_regex' = 'CMS|state-DOI|NCQA|URAC|ACA|internal');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'county|zip|state|region|national');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `specialty_category` SET TAGS ('dbx_business_glossary_term' = 'Specialty Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_category` SET TAGS ('dbx_business_glossary_term' = 'Standard Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_category` SET TAGS ('dbx_value_regex' = 'time-distance|provider-ratio|appointment-access|after-hours|telehealth-equivalency|network-composition');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `telehealth_equivalency_allowed` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Equivalency Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `telehealth_percentage_cap` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Percentage Cap');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Threshold Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('dbx_subdomain' = 'compliance_adequacy');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Assessment ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `appointment_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Requested');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `appointment_type_requested` SET TAGS ('dbx_value_regex' = 'routine|urgent|preventive|follow-up|new-patient|specialist-referral');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'adequacy|access-survey|mystery-shopper|gap-analysis|time-distance|appointment-availability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|partially-compliant|under-review|remediation-required');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `gap_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Identified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `gap_severity` SET TAGS ('dbx_business_glossary_term' = 'Gap Severity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `gap_severity` SET TAGS ('dbx_value_regex' = 'critical|high|moderate|low');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `member_to_provider_ratio` SET TAGS ('dbx_business_glossary_term' = 'Member to Provider Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_count_available` SET TAGS ('dbx_business_glossary_term' = 'Provider Count Available');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_count_required` SET TAGS ('dbx_business_glossary_term' = 'Provider Count Required');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_value_regex' = 'cms-medicare|cms-marketplace|state-doi|ncqa|internal|aca-qhp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|completed|verified|overdue');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `specialty_type` SET TAGS ('dbx_business_glossary_term' = 'Specialty Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|resubmission-required');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'member-survey|secret-shopper-call|provider-survey|administrative-data|geospatial-analysis');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `telehealth_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Offered Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Compliance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_standard_miles` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Standard Miles');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_standard_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Standard Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `wait_time_days_routine` SET TAGS ('dbx_business_glossary_term' = 'Wait Time Days Routine');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `wait_time_days_urgent` SET TAGS ('dbx_business_glossary_term' = 'Wait Time Days Urgent');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|eligible|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_publication_channel` SET TAGS ('dbx_business_glossary_term' = 'Directory Publication Channel');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_publication_channel` SET TAGS ('dbx_value_regex' = 'online|print|api|mobile_app|call_center');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_status` SET TAGS ('dbx_business_glossary_term' = 'Directory Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_verification|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Provider Gender');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `hospital_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Hospital Affiliation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_method` SET TAGS ('dbx_value_regex' = 'outbound_call|online_attestation|ehr_data_match|claims_inference|mail_survey|email_confirmation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_outcome` SET TAGS ('dbx_value_regex' = 'confirmed|updated|unable_to_reach|provider_declined|no_response');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `telehealth_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `verified_fields` SET TAGS ('dbx_business_glossary_term' = 'Verified Fields');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `verifying_agent` SET TAGS ('dbx_business_glossary_term' = 'Verifying Agent');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('dbx_subdomain' = 'provider_participation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Agreement ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `parent_par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Par Agreement Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `parent_par_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Scope Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'individual|group|entity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_version` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `amendment_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `compliance_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `compliance_status_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `electronic_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Lob');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `paper_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Paper Signature Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `par_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `par_agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending|draft');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_directory_last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_directory_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Listing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_network_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_network_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|pending');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_participation_role` SET TAGS ('dbx_business_glossary_term' = 'Provider Participation Role');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_participation_role` SET TAGS ('dbx_value_regex' = 'primary_care|specialist|both|other');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_recredentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Re‑credentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `reimbursement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Signed By Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('dbx_business_glossary_term' = 'Signed By NPI');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `signed_by_title` SET TAGS ('dbx_business_glossary_term' = 'Signed By Title');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` SET TAGS ('dbx_subdomain' = 'provider_participation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `provider_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `accessibility_ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `aco_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `after_hours_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'After Hours Availability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('dbx_business_glossary_term' = 'Continuity of Care End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending|expired|suspended|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `current_panel_size` SET TAGS ('dbx_business_glossary_term' = 'Current Panel Size');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `directory_last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Directory Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `directory_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Listing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_resource_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `in_network_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Network Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `language_services_available` SET TAGS ('dbx_business_glossary_term' = 'Language Services Available');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `master_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_value_regex' = 'essential|standard|enhanced|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `network_participation_type` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `network_participation_type` SET TAGS ('dbx_value_regex' = 'par|non_par|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `npi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_business_glossary_term' = 'Panel Capacity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'open|closed|limited|full');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `pcp_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider (PCP) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `quality_tier_designation` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Designation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `quality_tier_designation` SET TAGS ('dbx_value_regex' = 'high_quality|standard_quality|low_quality|not_rated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `recredentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `risk_sharing_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Sharing Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `specialist_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialist Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `telehealth_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Termination Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_initiated_by` SET TAGS ('dbx_value_regex' = 'provider|health_plan|mutual|regulatory');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `vbc_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_assignment` ALTER COLUMN `weekend_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Availability Flag');
