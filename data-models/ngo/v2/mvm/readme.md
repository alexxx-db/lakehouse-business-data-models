# Ngo Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on July 03, 2026 at 06:20 AM

This document outlines a vibed Lakehouse data model for the Ngo business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Field](#domain-field)
  - [Mel](#domain-mel)
  - [Program](#domain-program)
  - [Supply](#domain-supply)
  - [Beneficiary](#domain-beneficiary)
  - [Donor](#domain-donor)
  - [Grant](#domain-grant)
  - [Partnership](#domain-partnership)
  - [Compliance](#domain-compliance)
  - [Safeguarding](#domain-safeguarding)
- [Metric Views](#metric-views)

## Output Folder Structure

All artifacts for version **v2_mvm** are organized as follows:

```
v2/mvm/
  schemas/          DDL SQL files (one per domain)
  metrics/          Metric view SQL files (one per domain)
  samples/          Sample data CSV files (one per data product)
  docs/             Excel workbook, model CSV, release notes
  diagram/          DBML schema
  vibes/            Current & next vibes context
  ontology/         RDF/Turtle ontology schema
  model.json        Full model with requirements, metadata, and model data
  readme.md         This file
```

| Folder | Contents |
|---|---|
| `schemas/` | `ngo_<domain>_schema_v2_mvm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `ngo_catalogs_v2_mvm.sql` (catalog-level DDL) |
| `metrics/` | `ngo_<domain>_metrics_v2_mvm.sql` (one file per domain) |
| `docs/` | `ngo_model_v2_mvm.xlsx`, `ngo_model_v2_mvm.csv`, `releasenotes.txt` |
| `diagram/` | `ngo_dbml_v2_mvm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `ngo_rdf_v2_mvm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | MVM (Minimum Viable Model) |
| Total Domains | 10 |
| Total Subdomains | 24 |
| Total Products | 101 |
| Total Attributes | 4080 |
| Primary Keys | 101 |
| Foreign Keys | 675 |
| Avg Attributes/Product | 40.4 |
| Metric Views | 89 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Ngo | Ngo | MVM (Minimum Viable Model) | ngo industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-field"></a>

### Domain: Field

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| field | operations | 2 | Systems of record: Kobo Toolbox (assessments & surveys), DHIS2 (health data), RAM (WFP real-time assessment monitoring), ActivityInfo (cluster coordination), ReliefWeb (sitreps). Field operations span project sites, distributions, WASH, and emergency response. | 11 |

**Subdomains:** distribution_assessment, site_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| distribution_assessment | assessment | master_data | Field assessment capturing multi-sector data collection activities at project sites, including methodology, sample size, key findings, and protection concerns. Sourced from Kobo Toolbox, ODK, or field team submissions. | 49 |
| distribution_assessment | assessment_response | transactional_data | Individual survey or interview response record collected during a field assessment, sourced from KoboToolbox or CommCare mobile data collection. Captures respondent anonymized ID, assessment form ID, submission timestamp, GPS coordinates of submission, enumerator ID, response status (submitted, validated, rejected), and key structured response fields (household size, displacement status, primary needs, protection concerns). Enables disaggregated analysis by sex, age, IDP status, and vulnerability category. | 40 |
| distribution_assessment | distribution_event | transactional_data | Transactional record of a single distribution event (NFI, food, cash, or voucher) conducted at a project site. Captures event date, site, distribution type (general, targeted, blanket, voucher redemption), planned vs. actual beneficiary count, commodity categories, distribution modality (in-kind, cash, voucher, mobile money), responsible cluster, implementing field team, verification method, and PDM scheduling status. Core operational transaction for field service delivery and the primary unit of work for BvA reconciliation against supply pipeline. | 44 |
| distribution_assessment | distribution_line | transactional_data | ECM-canonical distribution line item entity. Supersedes the MVM-tier stub 'distribution_line' and is a strict superset of its attributes. Source systems: SAP/ICON procurement, VISION, eTools, WFP LESS/COMET, SCOPE. Tracks individual line items within a distribution event including commodity, quantity, value, and beneficiary counts. | 39 |
| distribution_assessment | sitrep | transactional_data | Situation Report (SitRep) following OCHA reporting standards for humanitarian operations. Captures cluster-level response metrics, beneficiary reach, funding gaps, and operational constraints. Feeds into HRP progress tracking and donor reporting. Source systems: eTools, OCHA reporting templates, ReliefWeb. | 47 |
| site_operations | country | master_data | Master reference table for country. Referenced by country_id. | 50 |
| site_operations | country_office | master_data | Represents a humanitarian organization country office operating under OCHA coordination frameworks. Maps to eTools country programme structure, UNDSS security management, and UNICEF/WFP/UNHCR field presence. Source systems: SAP S/4HANA (cost center), eTools (programme), UNDSS (security level). | 34 |
| site_operations | emergency | master_data | Represents a declared humanitarian emergency (L1/L2/L3 or IASC System-Wide Scale-Up) triggering coordinated response under OCHA. Tracks HRP/Flash Appeal issuance, CERF allocations, cluster activations, and response modalities. Source systems: OCHA FTS, ReliefWeb, Humanitarian InSight, GDACS. | 50 |
| site_operations | project_site | master_data | Represents a physical humanitarian project site (camp, distribution point, health facility, school, WASH point) with OCHA P-code geographic referencing. Supports 3W (Who does What Where) reporting, cluster coordination, and HDX spatial data. Source systems: Kobo Toolbox (GPS), eTools, CCCM site management. Systems-of-record: eTools (field monitoring), InSight, SAP PS. Framework: IATI v2.03 location elements / UN p-codes (OCHA CODs). | 40 |
| site_operations | security_incident | transactional_data | Records security incidents affecting humanitarian operations per UNDSS Security Level System (SLS) and INSO reporting standards. Tracks staff safety events, asset losses, and coordination with UNDSS/INSO. Supports Aid Worker Security Database (AWSD) reporting. Source systems: UNDSS SSIRS, INSO, internal security management. | 44 |
| site_operations | team | master_data | SSOT for field operations teams deployed to project sites for humanitarian response, including staff-led teams with security clearances, equipment, and operational budgets. Distinct from volunteer.volunteer_team which manages volunteer-led community teams. | 33 |

<a id="domain-mel"></a>

### Domain: Mel

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| mel | operations | 3 | Systems of record: DHIS2 (aggregate health/nutrition reporting), Kobo Toolbox (data collection), InSight (analytics & dashboards), ActivityInfo (indicator tracking), DevResults, CountrySTAT. MEL covers indicators, evaluations, data quality, and learning agendas. | 9 |

**Subdomains:** indicator_management, program_evaluation, reporting_cycles


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| indicator_management | indicator | master_data | Defines a measurable indicator used to track program outcomes, outputs, and impact. Sourced from DHIS2, Kobo Toolbox, or manual entry. Supports SDG alignment, UNSDCF outcome linkage, and strategic plan goal area mapping. Systems-of-record: DHIS2, RAM (Results Assessment Module), InSight. Framework: IATI Result Standard v2.03 / OECD-DAC criteria. | 48 |
| indicator_management | indicator_result | transactional_data | Actual measured result values for indicators collected during reporting periods, including data quality scores, variance analysis, and verification status. | 48 |
| indicator_management | indicator_target | master_data | Planned target values for indicators over specific reporting periods, with disaggregation dimensions (sex, age, disability, displacement status) and geographic scope. | 36 |
| indicator_management | mel_logframe | master_data | Logical framework (logframe) linking interventions to results chains (goal, purpose, outputs, activities) with objectively verifiable indicators, means of verification, and assumptions. Aligned to DAC evaluation criteria. | 42 |
| program_evaluation | evaluation | transactional_data | Formal evaluation of a program or intervention assessing DAC criteria (relevance, coherence, effectiveness, efficiency, impact, sustainability). Sourced from eTools or evaluation management systems. | 57 |
| program_evaluation | evaluation_finding | transactional_data | Individual finding from an evaluation with associated recommendations, management response, and implementation tracking. | 45 |
| program_evaluation | meal_plan | master_data | Monitoring, Evaluation, Accountability, and Learning (MEAL) plan defining data collection methods, reporting calendars, accountability mechanisms, and learning agendas for an intervention. | 41 |
| reporting_cycles | data_collection_tool | master_data | Definition of a data collection instrument (survey, form, checklist) deployed via Kobo Toolbox, ODK, or other platforms. Includes versioning, language support, and ethical review status. | 39 |
| reporting_cycles | reporting_period | master_data | Time period definition for MEL reporting cycles (monthly, quarterly, annual) with DHIS2 period codes and donor reporting alignment. | 36 |

<a id="domain-program"></a>

### Domain: Program

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| program | operations | 3 | Systems of record: SAP S/4HANA (programme/project accounting), eTools (UNICEF programme monitoring), InSight (programme analytics), Vision/SAP ERP (programme budgets). UN programme hierarchy: CPD, UNSDCF outcomes, Strategic Plan goal areas. | 11 |

**Subdomains:** budget_planning, program_design, results_framework


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| budget_planning | budget_plan | master_data | Program-level budget plan capturing the approved budget envelope for a program intervention, including line-item detail by cost category (personnel, fringe, travel, equipment, supplies, contractual, other direct costs, indirect costs). Stores total approved budget, currency, budget period, budget version, donor-specific budget codes, indirect cost rate (ICR/NICRA), F&A allocation, unit costs, quantities, and budget status. Distinct from the finance domain's GL and BvA tracking — this is the program-level planning budget owned by program management. | 40 |
| budget_planning | budget_plan_line | master_data | Individual budget line item within a program budget, capturing cost category (personnel, fringe, travel, equipment, supplies, contractual, other direct costs, indirect costs), budget line description, unit cost, quantity, unit of measure, total planned amount, donor budget code, and cost-sharing flag. Enables granular budget management, BvA tracking linkage to finance domain, and donor financial reporting by budget category. | 41 |
| budget_planning | program_partnership | association_data | This association product represents the formal partnership agreement between a humanitarian/development intervention and a partner organization. It captures the specific role, responsibilities, budget allocation, performance metrics, and compliance status for each partner's involvement in each intervention. Each record links one intervention to one partner organization with attributes that exist only in the context of this specific partnership arrangement.. Existence Justification: In nonprofit humanitarian operations, interventions are routinely implemented through multi-partner consortia where a single intervention engages multiple partner organizations (lead implementer, sub-recipients, local CBOs, technical specialists) each with distinct roles, geographic coverage, and budget allocations. Simultaneously, established partner organizations implement multiple interventions across different sectors and geographies. The partnership arrangement itself is an operational business entity that program managers actively create, monitor, and close out, with specific attributes like role, budget allocation, performance rating, compliance status, and risk assessment that belong to neither the intervention nor the partner organization alone. | 20 |
| program_design | component | master_data | Hierarchical decomposition of a program intervention into components, sub-components, or workstreams (e.g., a WASH program broken into water supply, sanitation, and hygiene promotion components). Captures component name, description, sector, sub-sector, responsible team, geographic focus, budget envelope, start/end dates, and status. Supports multi-sector and integrated programming models. Enables program hierarchy navigation from intervention down to activity level. | 41 |
| program_design | intervention | master_data | Programmatic intervention or project delivering outcomes. Source systems: SAP S/4HANA (project accounting), eTools (UNICEF programme monitoring), InSight. Systems-of-record: eTools (Programme Management), InSight (BI/reporting). IATI Activity Standard v2.03 alignment for intervention-level publishing. | 45 |
| program_design | program | master_data | Master reference table for program. Referenced by program_id. Systems-of-record: eTools, InSight, SAP PS (Project System). IATI Organisation Standard alignment. Links to CPD/UNSDCF outcomes. | 38 |
| program_design | target_population | master_data | Defines the intended beneficiary population for a program intervention or component, capturing targeting criteria, geographic scope, demographic profile (age, sex, vulnerability category), estimated population size, targeting methodology (e.g., MUAC screening, vulnerability scoring, community-based targeting), inclusion/exclusion criteria, and IDP/PoC/host community breakdown. Distinct from individual beneficiary registration (owned by beneficiary domain) — this is the program-level population planning entity. | 42 |
| program_design | theory_of_change | master_data | Captures the Theory of Change (ToC) for each program intervention, documenting the causal logic linking inputs, activities, outputs, outcomes, and impact. Stores narrative ToC statements, assumptions, risks, enabling conditions, and linkages to SDGs and humanitarian principles. Supports RBM (Results-Based Management) and donor reporting requirements. One ToC record per program version, with versioning to track revisions across program cycles. Supports CPD outcome logic and Strategic Plan goal area alignment. | 30 |
| results_framework | implementation_plan | master_data | Detailed implementation plan (work plan) for a program intervention or component, serving as the operational roadmap for field teams and the baseline for progress tracking. Captures planned activities at the task level including activity name, description, type, responsible parties, timelines (Gantt-style), resource requirements, geographic phasing, target beneficiary counts, status tracking, and linkage to LogFrame outputs. Includes comprehensive milestone tracking (program launch, mid-term review, final evaluation, closeout, donor reporting deadlines) with milestone type, planned/actual dates, completion status, deliverable description, sign-off authority, and dependency sequencing. Stores plan version, planning period, approval status, and last revision date. This is the SSOT for all program scheduling, activity sequencing, and milestone management — the schedule authority for donor reporting timelines and grant compliance. | 41 |
| results_framework | logframe_row | master_data | Individual row within a LogFrame matrix representing a single result level entry (goal, outcome, output, or activity). Captures the result statement, indicator reference, baseline value, target value, means of verification, assumptions, responsible unit, and reporting frequency. Enables granular tracking of each LogFrame element and supports MEL data linkage at the indicator level. | 37 |
| results_framework | program_logframe | master_data | SSOT for programme design logical frameworks used in programme management, donor reporting, and intervention design. Distinct from mel.mel_logframe which is the MEL-owned logframe for indicator monitoring, evaluation, and learning activities. Aligned to CPD outcomes and UNSDCF results framework. Source systems: eTools, InSight, VISION/SAP. | 35 |

<a id="domain-supply"></a>

### Domain: Supply

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| supply | operations | 2 | Systems of record: ICON procurement (UNICEF), SAP Materials Management, UNICEF Supply Division systems, WFP LESS (logistics), Humanitarian OpenStreetMap. Covers commodities, warehousing, procurement, and distribution. | 11 |

**Subdomains:** inventory_distribution, procurement_sourcing


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| inventory_distribution | distribution_order | transactional_data | Operational order authorizing the release and dispatch of commodities from a warehouse to a field distribution point for beneficiary delivery. Captures order number, originating distribution plan, issuing warehouse, destination distribution point, commodity lines with quantities, dispatch date, transport mode, waybill reference, loading officer, and order status (draft/approved/dispatched/delivered/closed). Triggers stock movement and last-mile logistics execution. | 51 |
| inventory_distribution | distribution_plan | master_data | Master plan for the distribution of humanitarian commodities to beneficiaries at field locations. Captures distribution plan name, target program, geographic coverage (country/admin levels), planned distribution date range, target beneficiary count, commodity list with planned quantities per beneficiary, distribution modality (direct/voucher/cash-in-kind), responsible field office, and approval status. Links supply chain planning to field operations and MEL targets. | 45 |
| inventory_distribution | inventory_balance | master_data | Current and historical stock balance records for each commodity at each warehouse location. Captures commodity, warehouse, stock quantity on hand, quantity reserved for distribution, quantity in transit, quantity quarantined, reorder level, maximum stock level, last physical count date, and stock valuation. Supports commodity pipeline management, pre-positioning decisions, and OCHA cluster reporting on pipeline gaps. | 33 |
| inventory_distribution | stock_movement | transactional_data | Transactional log of all inventory movements including receipts, issues, transfers between warehouses, adjustments, physical count reconciliations, losses, and write-offs. Each record captures movement type (receipt/issue/transfer/adjustment/physical_count/loss/write-off), commodity, source location, destination location, quantity, movement date, reference document (GRN/waybill/distribution order/count sheet), reason code, authorizing officer, and count team reference (for physical count adjustments). Provides full commodity pipeline audit trail for donor reporting, IATI transparency, inventory accuracy management, and loss detection. | 44 |
| inventory_distribution | warehouse | master_data | Physical warehouse or storage facility for humanitarian supplies. Source systems: SAP WM, WFP LESS, UNICEF Supply Division systems. | 53 |
| inventory_distribution | waybill | transactional_data | Transactional shipping document accompanying commodity movements between warehouses or to distribution points. Records waybill number, dispatch date, origin warehouse, destination location, transporter/carrier, vehicle registration, driver details, commodity lines with dispatched quantities, seal numbers, departure time, arrival time, received quantities, and discrepancy notes. Critical for last-mile accountability, loss tracking, and donor audit compliance. | 50 |
| procurement_sourcing | commodity | master_data | Supply item or commodity managed in humanitarian logistics. Source systems: ICON procurement (UNICEF Supply Division), SAP MM, WFP LESS. Systems-of-record: SAP MM, ICON, Supply Division catalogue. Framework: IPSAS 12 / WHO Essential Medicines List / UNICEF Supply Catalogue. | 51 |
| procurement_sourcing | goods_receipt | transactional_data | Transactional record capturing the physical receipt of commodities at a warehouse or field location against a purchase order or in-kind donation. Records receipt date, receiving warehouse, commodity, quantity received, condition on arrival (good/damaged/expired), batch/lot number, expiry date, receiving officer, discrepancy notes, and SAP goods receipt document number. Triggers inventory update and initiates three-way matching for AP payment processing. | 46 |
| procurement_sourcing | procurement_request | transactional_data | Internal requisition raised by program or field teams requesting procurement of commodities or services. Captures requisition number, requesting unit/program, commodity or service description, quantity, estimated budget, urgency level (routine/urgent/emergency), required delivery date, funding source, justification narrative, and approval workflow status. Initiates the procurement cycle and links program needs to supply chain execution. | 42 |
| procurement_sourcing | purchase_order | transactional_data | Procurement purchase order for goods or services. Source systems: ICON procurement (UNICEF), SAP MM/Procurement, WFP procurement systems. Systems-of-record: SAP MM (Materials Management), ICON procurement. Framework: IPSAS 12 (Inventories) / IATI v2.03 transaction elements. | 48 |
| procurement_sourcing | vendor | master_data | Master record for all suppliers, vendors, service providers, and logistics operators engaged in humanitarian procurement and supply chain operations. Covers commodity suppliers, international manufacturers, freight forwarders, clearing agents, trucking companies, air cargo operators, and last-mile delivery partners. Captures vendor registration details, country of operation, commodity categories supplied, transport modes offered (where applicable), pre-qualification status, performance tier, fleet size (for transport providers), blacklist/debarment flags, UN vendor registration number, compliance certifications (e.g., ISO, GMP), and humanitarian logistics network membership (e.g., WFP LHF, UNHRD). SSOT for all supplier and service provider identity within the supply domain. | 46 |

<a id="domain-beneficiary"></a>

### Domain: Beneficiary

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| beneficiary | business | 3 | Systems of record: Primero (child protection & GBV case management), proGres v4 (UNHCR registration), Kobo Toolbox (field data collection), SCOPE (WFP beneficiary management), CommCare (community health). Note: Salesforce Nonprofit Cloud may apply for National Committee CRM use cases but is not the primary SoR for field operations. | 12 |

**Subdomains:** assistance_delivery, beneficiary_registration, case_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| assistance_delivery | cva_transfer | master_data | Cash and Voucher Assistance transfer to beneficiary | 25 |
| assistance_delivery | enrollment | association_data | Tracks beneficiary enrollment into program components | 19 |
| assistance_delivery | entitlement | association_data | This association product represents the entitlement relationship between registrant and commodity. It captures the humanitarian assistance entitlement rules that define which commodities each beneficiary is entitled to receive, in what quantities, at what frequency, and for what duration. Each record links one registrant to one commodity with entitlement-specific parameters including quantity per distribution cycle, distribution frequency, entitlement validity period, vulnerability-based adjustments, and special dietary requirements. This is the operational SSOT for ration planning, distribution planning, and beneficiary entitlement verification in food security and NFI distribution programs.. Existence Justification: In humanitarian operations, beneficiaries are entitled to receive multiple commodities simultaneously as part of their assistance package (e.g., a monthly food basket includes rice, oil, beans, salt, and a household receives multiple NFI items like blankets, jerry cans, soap). Each commodity is entitled to thousands of beneficiaries across the program. The entitlement relationship is an operational business entity actively managed by program officers, carrying specific data about quantity per distribution cycle, frequency, validity period, vulnerability-based adjustments, and special dietary requirements that belong to neither the beneficiary nor the commodity alone. | 22 |
| beneficiary_registration | household | master_data | Household unit for humanitarian targeting and assistance delivery. Source systems: Primero, SCOPE, Kobo Toolbox, CommCare. Household unit linked to registrant (head of household) as SSOT. Source systems: SCOPE, proGres v4, Kobo Toolbox, CommCare. Protection-aware: household composition data (female-headed, PWD, UAM) drives vulnerability scoring and targeting. | 44 |
| beneficiary_registration | household_member | association_data | Association entity linking an individual registrant to their household. Captures role (head, spouse, child, dependent, elderly), relationship to head-of-household, membership start/end dates, and demographic attributes relevant to household composition analysis. Enables NFI distribution sizing, dependency ratio calculations, and vulnerability scoring at household level. Individual members within a household, linked to registrant SSOT. Source systems: Primero, proGres v4, SCOPE. Protection-sensitive: individual-level vulnerability and protection concern data requires strict access controls. | 47 |
| beneficiary_registration | registrant | master_data | Individual registered for humanitarian assistance. Source systems: Primero, proGres v4, SCOPE, Kobo Toolbox. Replaces prior Salesforce-only framing. SSOT for beneficiary identity. Source systems: Primero, proGres v4, SCOPE, Kobo Toolbox. Protection-sensitive: contains PII requiring dynamic masking in non-prod environments. Layered with household, household_member for demographic composition and vulnerability_profile for needs scoring. Systems-of-record: Primero (child protection), SCOPE (WFP), proGres (UNHCR), Kobo Toolbox (registration forms). Framework: IASC Data Responsibility Guidelines / Sphere Standards. | 39 |
| beneficiary_registration | vulnerability_profile | master_data | Structured vulnerability assessment record for a registrant or household capturing multi-dimensional vulnerability indicators including food insecurity score (IPC phase classification), protection risk level, disability classification (Washington Group questions), chronic illness flags, GAM/SAM nutritional status (MUAC measurement), GBV exposure flag, displacement category (IDP, refugee, returnee), and composite vulnerability score used for program targeting and prioritization. Distinct from needs_assessment which captures point-in-time sector-specific assessment findings — vulnerability_profile represents the beneficiary's current consolidated vulnerability state derived from multiple assessment inputs. Updated when new assessment data materially changes vulnerability classification. | 42 |
| case_management | case_action | transactional_data | Transactional log of individual actions, interventions, and follow-up activities taken within a beneficiary case. Captures action type (home visit, counseling session, referral, service provision, follow-up call), action date, action outcome, responsible staff or volunteer, next action due date, and action notes. Enables case progress tracking and workload management for case workers. Individual actions/interventions within a case record. Source systems: Primero, CommCare, case management platforms. Protection-sensitive: tracks PSS sessions, protection referrals, service delivery. Linked to case_record and registrant SSOT; supports supervisor review workflow. | 44 |
| case_management | case_record | transactional_data | Case management record for protection, child welfare, or GBV response. Source systems: Primero (child protection & GBV), proGres v4 (refugee status determination). | 51 |
| case_management | consent_record | transactional_data | Formal consent management record capturing a beneficiary's informed consent for data collection, storage, sharing, and program participation. Stores consent type (data processing, photography, case referral, biometric enrollment), consent status (given, withdrawn, pending), consent date, consent method (verbal, written, digital), language of consent, witness details, and CHS (Core Humanitarian Standard) accountability compliance flags. Informed consent record for data collection, sharing, and biometric enrollment. Source systems: Primero, SCOPE, proGres v4. CHS-compliant: tracks consent scope, withdrawal, proxy consent for minors, and GDPR applicability. Linked to registrant SSOT; consent withdrawal triggers data retention policy enforcement. | 38 |
| case_management | needs_assessment | transactional_data | ECM-canonical needs assessment entity. Supersedes the MVM-tier stub 'needs_assessment' and is a strict superset of its attributes. Source systems: Kobo Toolbox, ODK, CommCare, ONA, eTools (UNICEF), Primero (child protection). Captures multi-sector vulnerability scoring at individual/household level for targeting and prioritization. | 56 |
| case_management | referral | transactional_data | Transactional record of a formal referral of a beneficiary from one service provider, program, or organization to another. Captures referral date, referring organization, receiving organization or service, referral reason, referral type (internal, external, emergency), referral status (pending, accepted, completed, declined), follow-up date, and outcome. Supports inter-agency coordination, GBV referral pathways, and protection case management. | 44 |

<a id="domain-donor"></a>

### Domain: Donor

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| donor | business | 2 | Systems of record: Raiser's Edge NXT (National Committee fundraising), Salesforce Nonprofit Cloud (constituent CRM for National Committees), SAP CRM (institutional donor management). For UN agencies, donor management is handled via SAP Grants Management and donor portals. | 10 |

**Subdomains:** campaign_giving, donor_relationships


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| campaign_giving | appeal | master_data | Specific fundraising appeal or solicitation package within a campaign, managed in Raisers Edge NXT. An appeal is a targeted ask sent to a defined segment of constituents via a specific channel (direct mail, email, phone, event). Captures appeal code, appeal name, parent campaign, appeal type (acquisition, renewal, upgrade, lapsed reactivation), mailing date, channel (mail, email, phone, digital), cost, number of pieces sent, response rate, and total revenue generated. Enables granular attribution of gifts to specific solicitation efforts. | 38 |
| campaign_giving | campaign | master_data | Fundraising campaign master record managing all donor-facing fundraising initiatives in Salesforce Nonprofit Cloud. Captures campaign name, campaign type (annual fund, capital campaign, emergency appeal, planned giving, corporate partnership, digital/online), campaign goal amount, start and end dates, campaign status, target audience segment, appeal codes associated, total gifts raised to date, number of donors, cost of fundraising, and ROI. Supports campaign performance tracking and donor attribution across all gift transactions. | 31 |
| campaign_giving | fund | master_data | SSOT for donor-facing fund records representing restricted/unrestricted gift designations, stewardship tracking, and donor intent. Links to finance.finance_fund for GL-level fund accounting. Distinct from finance.finance_fund which is the SSOT for general ledger fund segments and financial reporting. | 41 |
| campaign_giving | gift | transactional_data | Financial gift or donation transaction. Source systems: Raiser's Edge NXT, Salesforce Nonprofit Cloud, payment processors. For UN agencies, contributions are tracked in SAP Grants Management. Systems-of-record: Salesforce Nonprofit Cloud, Raisers Edge NXT, SAP FI-AR. Framework: IPSAS 23 / US GAAP ASC 958-605 / IATI v2.03 transaction. | 50 |
| campaign_giving | major_gift_opportunity | transactional_data | Pipeline management record for major gift solicitations tracked in Raisers Edge NXT and Salesforce Nonprofit Cloud. Represents a specific ask or solicitation opportunity with a named prospect or donor. Captures opportunity name, ask amount, expected gift amount, probability percentage, solicitation stage (identification, qualification, cultivation, solicitation, stewardship, closed-won, closed-lost), expected close date, assigned major gift officer, fund designation, campaign, proposal reference, and ask strategy. Enables major gift pipeline reporting and revenue forecasting. | 38 |
| campaign_giving | pledge | transactional_data | Tracks multi-installment giving commitments, pledge agreements, and their individual installment schedules from donors, managed in Raisers Edge NXT and Salesforce Nonprofit Cloud. Captures pledge date, total pledge amount, installment schedule (monthly, quarterly, annual), number of installments, pledge balance outstanding, pledge status (active, fulfilled, lapsed, written-off), fund designation, campaign, appeal, reminder schedule, and write-off reason. Includes installment-level detail: individual due dates, scheduled amounts, actual payment dates, amounts paid, installment status (scheduled, paid, overdue, skipped, waived), payment method, and linked gift reference upon payment. Enables granular pledge fulfillment tracking, overdue installment identification, automated reminder generation, and BvA (Budget vs. Actual) reconciliation for pledged revenue. Distinct from gift — a pledge is a commitment to give, not a completed transaction. | 47 |
| donor_relationships | constituent | master_data | Donor constituent record for fundraising and relationship management. Source systems: Raiser's Edge NXT (National Committees), Salesforce NPSP (National Committees), SAP CRM (institutional donors). Systems-of-record: Salesforce Nonprofit Cloud (National Committees), Raisers Edge NXT, SAP CRM (institutional donors). Framework: IATI Organisation Standard. | 38 |
| donor_relationships | fundraising_event | master_data | Master record for donor-facing fundraising events and attendee registrations including galas, benefit dinners, golf tournaments, virtual fundraisers, and cultivation events managed in Salesforce Nonprofit Cloud. Captures event name, event type, event date and venue, fundraising goal, ticket price tiers, sponsorship levels, total revenue raised, total attendance, event cost, net revenue, and event manager. Includes individual constituent registration records with registration date, registration type (attendee, table sponsor, individual sponsor, volunteer), ticket type and price paid, table assignment, meal preference, attendance confirmation status, check-in timestamp, and post-event follow-up status. Enables event capacity management, seating logistics, and post-event stewardship workflows. Distinct from field operations events — fundraising events are donor cultivation and revenue generation activities. | 49 |
| donor_relationships | prospect | master_data | Prospect research and donor cultivation pipeline record managed in Raisers Edge NXT and Salesforce Nonprofit Cloud. Tracks prospective donors and funders through the cultivation lifecycle from identification through qualification, cultivation, solicitation, and stewardship. Captures prospect rating, estimated giving capacity, wealth screening score, research stage, assigned major gift officer, next action date, cultivation strategy notes, and linkage-ability-interest (LAI) assessment. Supports the Donor Cultivation and Fundraising core business process. | 42 |
| donor_relationships | stewardship_activity | transactional_data | Records all donor stewardship touchpoints and relationship management activities conducted by major gift officers and stewardship staff. Captures activity type (acknowledgement letter, impact report, site visit, phone call, event invitation, personal meeting, grant report delivery), activity date, staff member responsible, constituent involved, related gift or pledge, activity outcome, next steps, and stewardship plan stage. Supports the donor cultivation and stewardship lifecycle and enables relationship health tracking in Salesforce Nonprofit Cloud. | 50 |

<a id="domain-grant"></a>

### Domain: Grant

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| grant | business | 2 | Systems of record: SAP Grants Management, eZHACT (UNICEF HACT cash transfers), donor portals (USAID ASIST, EC PROSPECT). Award lifecycle from solicitation through closeout. | 10 |

**Subdomains:** award_management, donor_compliance


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| award_management | amendment | transactional_data | Tracks modifications to grant awards including no-cost extensions, budget realignments, scope changes, and key personnel changes. Source systems: SAP, eTools. | 37 |
| award_management | award | master_data | Represents a formal grant award from a donor to the organization, including financial terms, compliance requirements, and period of performance. Source systems: SAP Grants Management, eTools, Salesforce Nonprofit Cloud. Systems-of-record: SAP Grants Management (GM), VISION, eZHACT. Framework: 2 CFR 200 / IPSAS 23 / IATI v2.03 budget elements. | 55 |
| award_management | award_budget | master_data | Represents the approved budget for a grant award period, including cost categories, indirect cost calculations, and donor approval status. Source systems: SAP, eTools. | 35 |
| award_management | award_budget_line | transactional_data | Individual line items within an award budget, tracking cost categories, amounts, variances, and compliance flags (allowability, allocability, reasonableness). Source systems: SAP, eTools. | 45 |
| award_management | proposal | master_data | Tracks grant proposals from identification through submission and outcome, including go/no-go decisions, budget summaries, and partnership models. Source systems: Salesforce, internal BD trackers. | 49 |
| award_management | sub_award_disbursement | transactional_data | Records individual disbursement transactions to sub-awardees under a grant award, tracking amounts, liquidation status, and compliance with donor conditions. Source systems: SAP, eZHACT, eTools. | 44 |
| award_management | subaward | master_data | Represents sub-awards issued to implementing partners under a prime award, tracking financial terms, compliance requirements, and performance. Source systems: SAP, eTools, eZHACT. | 53 |
| donor_compliance | donor_condition | master_data | Tracks specific conditions imposed by donors on awards, including compliance status, due dates, and monitoring requirements. Source systems: eTools, SAP. | 50 |
| donor_compliance | donor_report | transactional_data | Tracks donor reporting obligations and submissions including financial and programmatic reports, compliance certifications, and donor feedback. Source systems: eTools, SAP. Systems-of-record: eTools, InSight, donor portals. Framework: IATI v2.03 result reporting / donor-specific templates (ECHO, USAID, DFID). | 46 |
| donor_compliance | funding_source | reference_data | Represents a funding source (donor entity or mechanism) with its compliance requirements, cost policies, and geographic/thematic restrictions. Source systems: SAP, Raisers Edge NXT. | 48 |

<a id="domain-partnership"></a>

### Domain: Partnership

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| partnership | business | 2 | Systems of record: eTools (UNICEF partner management & HACT), UN Partner Portal (UNPP), SAP vendor master. Covers partner assessments, agreements, HACT compliance, and capacity building. | 9 |

**Subdomains:** agreement_compliance, partner_registry


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| agreement_compliance | agreement | master_data | ECM-canonical partnership agreement entity. Supersedes the MVM-tier stub 'agreement' and is a strict superset of its attributes. Source systems: eTools (UNICEF), SAP, UN Partner Portal, UNPP, InSight. Captures the full lifecycle of implementing partner agreements including PCA, SSFA, and programme documents with HACT compliance tracking. | 59 |
| agreement_compliance | capacity_assessment | transactional_data | Partner capacity assessment including HACT micro-assessment. Source systems: eTools, eZHACT, UN Partner Portal. | 48 |
| agreement_compliance | due_diligence_record | transactional_data | Formal due diligence and partner verification master record covering legal compliance checks, sanctions screening (OFAC, EU, UN), anti-terrorism certification, financial audit review, governance verification, and regulatory standing. Includes embedded accreditation/certification tracking for CHS (Core Humanitarian Standard), Sphere compliance, HAP membership, ISO certifications, and national NGO registration status with issuing body, certificate number, issue date, expiry date, and verification status. Tracks due diligence type, completion date, outcome, risk level, next review date, and responsible staff. Required for compliance with 2 CFR 200, USAID ADS 303, and donor partner vetting regulations. This is the SSOT for all partner verification, screening, and accreditation data in the partnership domain. | 48 |
| agreement_compliance | partner_performance_review | transactional_data | Periodic performance review records for implementing partners assessing delivery against agreed SoW milestones, reporting compliance, financial accountability, and programmatic quality. Captures review period, performance rating, key findings, corrective action requirements, and reviewer details. Feeds into partnership renewal and risk management decisions. | 50 |
| agreement_compliance | partner_report_submission | transactional_data | Tracks all programmatic and financial reports submitted by implementing partners under their sub-award or agreement obligations. Captures report type (narrative, financial, SitRep, PDM), reporting period, submission date, review status, feedback provided, and acceptance date. Supports compliance monitoring and donor reporting obligations under 2 CFR 200. Systems-of-record: eTools (PD/SSFA reporting), InSight. Framework: HACT / IATI v2.03 result reporting. | 53 |
| partner_registry | consortium | master_data | Master record for multi-partner consortia and joint programming arrangements where Ngo acts as lead agency or member. Captures consortium name, lead organization, governance structure (steering committee composition, decision-making protocols), consortium agreement reference, geographic scope, thematic focus, total funding envelope, and operational status. Supports coordination with OCHA cluster leads, IASC working groups, and pooled fund mechanisms. Essential for Grand Bargain localization commitments and joint donor reporting. | 44 |
| partner_registry | consortium_member | master_data | Association record linking partner organizations to consortia, capturing each member's role (lead, co-implementer, technical advisor), contribution type, funding allocation percentage, geographic responsibility, and membership status. Tracks the full composition and role distribution within each consortium arrangement. | 44 |
| partner_registry | partner_contact | master_data | Master record for individual contacts within partner organizations including focal points, authorized representatives, technical leads, and financial officers. Captures name, title, role type, communication channels, language preference, and active status. Supports relationship management and coordination workflows across the partnership lifecycle. | 44 |
| partner_registry | partner_org | master_data | Implementing partner organization. Source systems: UN Partner Portal (UNPP), eTools (UNICEF), SAP vendor master. Systems-of-record: eTools (Partner Management), SAP vendor master, UN Partner Portal. Framework: HACT / IATI Organisation Standard. | 53 |

<a id="domain-compliance"></a>

### Domain: Compliance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| compliance | corporate | 2 | Systems of record: SAP GRC (governance risk compliance), TeamMate (audit management), IATI Registry (transparency reporting), national regulatory portals. Covers regulatory filings, audits, NICRA, sanctions screening, and governance. | 9 |

**Subdomains:** audit_governance, regulatory_obligations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| audit_governance | audit_finding | transactional_data | Transactional record of each finding, material weakness, significant deficiency, or questioned cost identified during a Single Audit or internal compliance audit. Captures finding reference number, finding type (material weakness, significant deficiency, questioned cost, noncompliance), federal program CFDA number, finding description, condition, criteria, cause, effect, and recommendation. Links to corrective action plans. | 42 |
| audit_governance | corrective_action_plan | master_data | Master record of corrective action plans (CAPs) developed in response to audit findings, CHS non-conformities, donor compliance issues, or internal control deficiencies. Captures finding reference, corrective action description, responsible manager, target completion date, actual completion date, verification method, and status (open, in progress, closed, overdue). Supports management response documentation required by 2 CFR 200 and CHS Alliance. | 37 |
| audit_governance | governance_policy | master_data | Master catalog of organizational governance documents including board-approved policies, bylaws, board resolutions, charters, conflict-of-interest disclosures, and internal control frameworks. Captures document type (policy, resolution, bylaw, charter, COI disclosure), name, category (financial, HR, safeguarding, anti-fraud, data protection, COI), version, effective/expiry dates, approving authority, document owner, review cycle. For resolutions: meeting date, meeting type, resolution text, vote outcome, and resolution number. For COI disclosures: disclosing party, nature of conflict, related party, recusal decision, review outcome, and annual certification status. Supports IRS 990 Schedule O and Part VI governance disclosures, Charity Commission annual returns, and donor due diligence. | 41 |
| audit_governance | single_audit | master_data | Single Audit (2 CFR 200) or equivalent statutory audit. Source systems: TeamMate (audit management), SAP GRC. Applicable to US federal fund recipients; UN agencies undergo Board of Auditors review. Systems-of-record: SAP GRC, cognizant agency portals. Framework: 2 CFR 200 Subpart F (Single Audit) / IPSAS external audit standards (ISA). | 37 |
| regulatory_obligations | donor_requirement | master_data | Master record of specific compliance requirements imposed by individual institutional donors (USAID, DFID, EU, UN agencies) on grants awarded to the organization. Captures donor name, grant reference, requirement type (financial reporting, programmatic reporting, audit, visibility, procurement rules, anti-terrorism certification, NICRA application), requirement description, due date, and compliance status. Distinct from general regulatory obligations — these are donor-specific contractual compliance conditions. | 31 |
| regulatory_obligations | obligation | master_data | Master catalog of all recurring and one-time compliance obligations the organization must fulfill across regulatory, donor, and voluntary accountability frameworks. Includes IRS 990 filings, Charity Commission returns, IATI publications, CHS self-assessments, Single Audit requirements (2 CFR 200), state registrations, OCHA reporting, and donor-specific conditions. Captures obligation name, governing body, legal basis, frequency, jurisdiction, responsible unit, lead time, and risk rating. Overdue obligations escalate to incident records via obligation_schedule monitoring. | 34 |
| regulatory_obligations | obligation_schedule | transactional_data | Operational schedule linking compliance obligations to specific fiscal periods, deadlines, and responsible staff. Tracks planned due date, extended due date (if extension granted), assigned compliance officer, review workflow stage, escalation thresholds, and completion status. Enables proactive compliance calendar management and deadline monitoring across all jurisdictions and reporting frameworks. | 29 |
| regulatory_obligations | regulatory_filing | master_data | Regulatory filing or statutory submission. Source systems: SAP GRC, national regulatory portals, IATI Registry. Covers US Form 990, Charity Commission (UK), IPSAS-mandated disclosures. Systems-of-record: SAP GRC, internal compliance systems. Framework: 2 CFR 200 / Form 990 (US) / Charity Commission (UK) / IPSAS disclosure requirements. | 39 |
| regulatory_obligations | statutory_registration | master_data | Master record of the organization's legal registrations and statutory status across all operating jurisdictions, including US 501(c)(3) IRS determination letter, UK Charity Commission registration, country-level NGO registrations, and foreign agent registrations. Captures jurisdiction, registration type, registration number, registration date, expiry date, registered name, registered address, and renewal requirements. Foundational for legal operating authority and donor eligibility verification. | 37 |

<a id="domain-safeguarding"></a>

### Domain: Safeguarding

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| safeguarding | corporate | 3 | Systems of record: Primero (case management for child protection), dedicated PSEA case tracking systems, HR disciplinary systems. Covers PSEA policies, incident investigation, survivor support, and community awareness. | 9 |

**Subdomains:** incident_response, policy_compliance, survivor_support


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| incident_response | incident | transactional_data | SSOT for safeguarding incidents including PSEA (Protection from Sexual Exploitation and Abuse), sexual harassment, child protection violations, and abuse of power. Distinct from compliance.compliance_incident which covers regulatory/financial compliance breaches. | 36 |
| incident_response | investigation | master_data | Formal investigation record linked to a safeguarding incident. Tracks investigation lifecycle, findings, and outcomes. | 23 |
| incident_response | investigation_action | transactional_data | Individual actions taken during an investigation (interviews, evidence collection, site visits). | 12 |
| policy_compliance | focal_point | master_data | Designated safeguarding/PSEA focal point responsible for a geographic area or organizational unit. | 13 |
| policy_compliance | psea_policy | master_data | Protection from Sexual Exploitation and Abuse policy record. Tracks organizational PSEA policies, versions, approval dates, and compliance status. Source systems: eTools, Primero, internal policy management. Systems-of-record: Internal policy management, IASC PSEA portal. Framework: UN Secretary-General Bulletin ST/SGB/2003/13 / IASC Six Core Principles / CHS Alliance standards. | 18 |
| policy_compliance | reporting_channel | master_data | Reporting channel/mechanism for safeguarding concerns (hotline, email, in-person, community-based). | 16 |
| policy_compliance | risk_assessment | master_data | Safeguarding risk assessment for a program, project site, or partner. Identifies SEA/SH risks and mitigation measures. | 20 |
| survivor_support | survivor_record | master_data | De-identified survivor record linked to a safeguarding incident. Contains only minimal demographic data needed for case management. All fields are pii_beneficiary_protected. | 17 |
| survivor_support | survivor_support_plan | master_data | Support plan for a survivor including services, timeline, and responsible parties. | 17 |

## Metric Views

Total metric views generated: **89**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | field_assessment | field | assessment | Field assessment quality and coverage KPIs — measures data quality, beneficiary satisfaction, and assessment utilisation to guide MEL and programme decisions. |
| 2 | field_assessment_response | field | assessment_response | Household-level assessment response KPIs — tracks vulnerability profiles, food security, protection concerns, and referral needs to inform targeting and programme design. |
| 3 | field_distribution_event | field | distribution_event | Operational KPIs for humanitarian distribution events — tracks budget utilisation, beneficiary reach, and delivery efficiency to steer field programme decisions. |
| 4 | field_distribution_line | field | distribution_line | Item-level distribution KPIs — tracks quantities distributed, delivery value, variance, and quality to inform supply chain and programme decisions. |
| 5 | field_emergency | field | emergency | Emergency response KPIs — tracks funding coverage, population reach, and response activation to steer humanitarian resource allocation and strategic decisions. |
| 6 | field_project_site | field | project_site | Project site infrastructure and operational KPIs — tracks site coverage, accessibility, and digital readiness to inform field infrastructure investment decisions. |
| 7 | field_security_incident | field | security_incident | Security incident KPIs — tracks incident frequency, severity, financial impact, and reporting compliance to steer duty-of-care and risk management decisions. |
| 8 | field_sitrep | field | sitrep | Situation report KPIs — tracks reporting timeliness, HRP progress, funding gaps, and submission compliance to steer donor accountability and operational coordination. |
| 9 | field_team | field | team | Field team operational KPIs — tracks budget deployment, team performance, and operational readiness to steer human resource and field management decisions. |
| 10 | mel_data_collection_tool | mel | data_collection_tool | Data collection tool quality and compliance view. Tracks tool deployment status, ethical review compliance, data protection adherence, and tool portfolio composition — informing MEL operational readiness and research ethics compliance. |
| 11 | mel_evaluation | mel | evaluation | Evaluation portfolio quality and efficiency view. Tracks evaluation completion rates, DAC criteria ratings, budget utilization, and management response compliance — key inputs for organizational learning and accountability. |
| 12 | mel_evaluation_finding | mel | evaluation_finding | Evaluation findings implementation and accountability view. Tracks finding resolution rates, implementation progress, priority distribution, and management response quality — critical for organizational learning loops. |
| 13 | mel_indicator | mel | indicator | Indicator portfolio health and design quality view. Tracks indicator coverage, SDG alignment, mandatory compliance, and baseline establishment across the MEL framework. |
| 14 | mel_indicator_result | mel | indicator_result | Core MEL performance tracking view measuring indicator achievement, target attainment rates, data quality, and result variance across programs. Primary KPI surface for program performance steering. |
| 15 | mel_indicator_target | mel | indicator_target | Indicator target-setting quality and ambition view. Tracks target coverage, disaggregation completeness, and target value distribution — informing whether program ambition is appropriately calibrated. |
| 16 | mel_logframe | mel | mel_logframe | MEL logframe quality and results chain coverage view. Tracks logframe completeness, results chain hierarchy, SDG alignment, and target vs. actual performance at the logframe level — the backbone of program accountability. |
| 17 | mel_meal_plan | mel | meal_plan | MEL plan investment and strategic coverage view. Tracks MEL budget allocation, plan status, and strategic framework alignment — informing whether MEL capacity is adequately resourced and strategically aligned. |
| 18 | mel_reporting_period | mel | reporting_period | Reporting period pipeline and compliance view. Tracks active reporting periods, deadline adherence, data quality audit scheduling, and special period flags — informing MEL operational calendar management and donor reporting compliance. |
| 19 | program | program | program | Strategic program portfolio metrics providing executives with budget, lifecycle, and risk visibility across all programs. Enables portfolio steering, resource allocation decisions, and compliance monitoring. |
| 20 | program_budget_plan | program | budget_plan | Budget plan financial metrics providing finance teams and program directors with visibility into budget composition, cost structure, and indirect cost rates across all budget plans. |

*... and 69 more metric views. See the `metrics/` folder for full details.*