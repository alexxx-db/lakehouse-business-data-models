# Ngo Lakehouse Data Models

**Version 2** | Generated on July 03, 2026 at 06:20 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Beneficiary](#domain-beneficiary)
  - [Communication](#domain-communication)
  - [Compliance](#domain-compliance)
  - [Donor](#domain-donor)
  - [Field](#domain-field)
  - [Finance](#domain-finance)
  - [Grant](#domain-grant)
  - [Mel](#domain-mel)
  - [Partnership](#domain-partnership)
  - [Program](#domain-program)
  - [Safeguarding](#domain-safeguarding)
  - [Supply](#domain-supply)
  - [Technology](#domain-technology)
  - [Volunteer](#domain-volunteer)
  - [Workforce](#domain-workforce)


## Business Description

ngo industry enterprise data model.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v2_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v2_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `v2/mvm` | `v2/ecm` |
| **Target Organization** | Small-to-mid businesses, startups, focused teams | Large enterprises, complex multi-division organizations |
| **Domain Coverage** | Core operations + business domains | All domains including corporate back-office |
| **Divisions Included** | Operations, Business | Operations, Business, Corporate |
| **Attribute Depth** | Full (same as ECM) | Full |
| **M:N Associations** | Minimized (direct FKs preferred) | Comprehensive junction tables |
| **Growth Path** | Start here, enlarge to ECM as needed | Complete from day one |
| **Best For** | Quick production deployments, focused analytics, POC, growing businesses | Organization-wide analytics, compliance, global operations |

## Model Metrics Comparison

| Metric | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| Domains | 10 | 15 |
| Subdomains | 24 | 58 |
| Products (Tables) | 101 | 330 |
| Attributes (Columns) | 4080 | 11687 |
| Foreign Keys | 675 | 1807 |
| Avg Attributes/Product | 40.4 | 35.4 |

## Domain & Product Comparison

<a id="domain-beneficiary"></a>
### beneficiary

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | case_action | ✅ | ✅ |  |
| case_management | case_record | ✅ | ✅ |  |
| case_management | household_volunteer_assignment | ✅ | ❌ | Excluded from MVM |
| case_management | referral | ✅ | ✅ |  |
| case_management | service_assignment | ✅ | ❌ | Excluded from MVM |
| identity_registration | biometric_record | ✅ | ❌ | Excluded from MVM |
| identity_registration | community | ✅ | ❌ | Excluded from MVM |
| identity_registration | displacement_history | ✅ | ❌ | Excluded from MVM |
| identity_registration | document_record | ✅ | ❌ | Excluded from MVM |
| identity_registration | exit_record | ✅ | ❌ | Excluded from MVM |
| identity_registration | household | ✅ | ✅ |  |
| identity_registration | household_member | ✅ | ✅ |  |
| identity_registration | registrant | ✅ | ✅ |  |
| identity_registration | registration_event | ✅ | ❌ | Excluded from MVM |
| program_participation | community_intervention | ✅ | ❌ | Excluded from MVM |
| program_participation | cva_transfer | ✅ | ✅ |  |
| program_participation | end_user_verification | ✅ | ❌ | Excluded from MVM |
| program_participation | enrollment | ✅ | ✅ |  |
| program_participation | entitlement | ✅ | ✅ |  |
| program_participation | financial_service_provider | ✅ | ❌ | Excluded from MVM |
| program_participation | minimum_expenditure_basket | ✅ | ❌ | Excluded from MVM |
| protection_assessment | beneficiary_needs_assessment | ✅ | ❌ | Excluded from MVM |
| protection_assessment | consent_record | ✅ | ✅ |  |
| protection_assessment | needs_assessment | ✅ | ✅ |  |
| protection_assessment | protection_flag | ✅ | ❌ | Excluded from MVM |
| protection_assessment | vulnerability_profile | ✅ | ✅ |  |

<a id="domain-communication"></a>
### communication

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| advocacy_outreach | advocacy_campaign | ✅ | ❌ | Domain not in MVM |
| advocacy_outreach | campaign_media_outreach | ✅ | ❌ | Domain not in MVM |
| advocacy_outreach | campaign_touchpoint | ✅ | ❌ | Domain not in MVM |
| advocacy_outreach | plan | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | community_engagement_event | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | constituent_consent | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | constituent_message | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | donor_stewardship_touchpoint | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | feedback_case | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | feedback_submission | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | message_thread | ✅ | ❌ | Domain not in MVM |
| content_publishing | digital_content | ✅ | ❌ | Domain not in MVM |
| content_publishing | email_broadcast | ✅ | ❌ | Domain not in MVM |
| content_publishing | impact_story | ✅ | ❌ | Domain not in MVM |
| media_relations | crisis_communication | ✅ | ❌ | Domain not in MVM |
| media_relations | media_activity | ✅ | ❌ | Domain not in MVM |
| media_relations | media_contact | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_oversight | audit_finding | ✅ | ✅ |  |
| audit_oversight | chs_self_assessment | ✅ | ❌ | Excluded from MVM |
| audit_oversight | cognizant_agency | ✅ | ❌ | Excluded from MVM |
| audit_oversight | corrective_action_plan | ✅ | ✅ |  |
| audit_oversight | internal_review | ✅ | ❌ | Excluded from MVM |
| audit_oversight | single_audit | ✅ | ✅ |  |
| incident_screening | compliance_incident | ✅ | ❌ | Excluded from MVM |
| incident_screening | sanctions_screening | ✅ | ❌ | Excluded from MVM |
| regulatory_obligations | donor_requirement | ✅ | ✅ |  |
| regulatory_obligations | governance_policy | ✅ | ✅ |  |
| regulatory_obligations | iati_publication | ✅ | ❌ | Excluded from MVM |
| regulatory_obligations | nicra_agreement | ✅ | ❌ | Excluded from MVM |
| regulatory_obligations | obligation | ✅ | ✅ |  |
| regulatory_obligations | obligation_schedule | ✅ | ✅ |  |
| regulatory_obligations | regulatory_filing | ✅ | ✅ |  |
| regulatory_obligations | statutory_registration | ✅ | ✅ |  |

<a id="domain-donor"></a>
### donor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_engagement | appeal | ✅ | ✅ |  |
| campaign_engagement | appeal_targeting | ✅ | ❌ | Excluded from MVM |
| campaign_engagement | campaign | ✅ | ✅ |  |
| campaign_engagement | participation | ✅ | ❌ | Excluded from MVM |
| campaign_giving | fund | ❌ | ✅ | MVM only (stub or new) |
| constituent_management | constituent | ✅ | ✅ |  |
| constituent_management | portfolio_assignment | ✅ | ❌ | Excluded from MVM |
| constituent_management | prospect | ✅ | ✅ |  |
| constituent_management | segment | ✅ | ❌ | Excluded from MVM |
| constituent_management | segment_membership | ✅ | ❌ | Excluded from MVM |
| constituent_management | wealth_screening | ✅ | ❌ | Excluded from MVM |
| gift_fundraising | gift | ✅ | ✅ |  |
| gift_fundraising | indicator_funding | ✅ | ❌ | Excluded from MVM |
| gift_fundraising | major_gift_opportunity | ✅ | ✅ |  |
| gift_fundraising | planned_giving | ✅ | ❌ | Excluded from MVM |
| gift_fundraising | pledge | ✅ | ✅ |  |
| gift_fundraising | soft_credit | ✅ | ❌ | Excluded from MVM |
| stewardship_events | donor_fund | ✅ | ❌ | Excluded from MVM |
| stewardship_events | event_registration | ✅ | ❌ | Excluded from MVM |
| stewardship_events | event_volunteer_assignment | ✅ | ❌ | Excluded from MVM |
| stewardship_events | fundraising_event | ✅ | ✅ |  |
| stewardship_events | stewardship_activity | ✅ | ✅ |  |

<a id="domain-field"></a>
### field

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assessment_services | assessment | ✅ | ✅ |  |
| assessment_services | assessment_participation | ✅ | ❌ | Excluded from MVM |
| assessment_services | assessment_response | ✅ | ✅ |  |
| assessment_services | mobile_health_outreach | ✅ | ❌ | Excluded from MVM |
| assessment_services | wash_intervention | ✅ | ❌ | Excluded from MVM |
| distribution_response | distribution_event | ✅ | ✅ |  |
| distribution_response | distribution_line | ✅ | ✅ |  |
| distribution_response | distribution_participation | ✅ | ❌ | Excluded from MVM |
| distribution_response | field_distribution_line | ✅ | ❌ | Excluded from MVM |
| distribution_response | field_financial_service_provider | ✅ | ❌ | Excluded from MVM |
| distribution_response | pdm_survey | ✅ | ❌ | Excluded from MVM |
| geographic_presence | cluster_coordination | ✅ | ❌ | Excluded from MVM |
| geographic_presence | country | ✅ | ✅ |  |
| geographic_presence | country_office | ✅ | ✅ |  |
| geographic_presence | emergency | ✅ | ✅ |  |
| geographic_presence | project_site | ✅ | ✅ |  |
| operational_deployment | access_constraint | ✅ | ❌ | Excluded from MVM |
| operational_deployment | field_deployment | ✅ | ❌ | Excluded from MVM |
| operational_deployment | field_team | ✅ | ❌ | Excluded from MVM |
| operational_deployment | security_incident | ✅ | ✅ |  |
| operational_deployment | sitrep | ✅ | ✅ |  |
| site_operations | team | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_control | budget | ✅ | ❌ | Domain not in MVM |
| budget_control | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_control | budget_version | ✅ | ❌ | Domain not in MVM |
| budget_control | cost_allocation | ✅ | ❌ | Domain not in MVM |
| budget_control | grant_budget | ✅ | ❌ | Domain not in MVM |
| budget_control | nicra_rate | ✅ | ❌ | Domain not in MVM |
| fund_management | cost_center | ✅ | ❌ | Domain not in MVM |
| fund_management | finance_fund | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | exchange_rate | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | fiscal_period | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| payables_processing | payable | ✅ | ❌ | Domain not in MVM |
| payables_processing | payable_payment | ✅ | ❌ | Domain not in MVM |
| payables_processing | payment_run | ✅ | ❌ | Domain not in MVM |
| payables_processing | receivable | ✅ | ❌ | Domain not in MVM |
| payables_processing | receivable_receipt | ✅ | ❌ | Domain not in MVM |
| treasury_reconciliation | bank_account | ✅ | ❌ | Domain not in MVM |
| treasury_reconciliation | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| treasury_reconciliation | bank_transaction | ✅ | ❌ | Domain not in MVM |
| treasury_reconciliation | finance_face_form | ✅ | ❌ | Domain not in MVM |
| treasury_reconciliation | fund_compliance_tracking | ✅ | ❌ | Domain not in MVM |

<a id="domain-grant"></a>
### grant

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| award_management | amendment | ❌ | ✅ | MVM only (stub or new) |
| award_pipeline | award | ✅ | ✅ |  |
| award_pipeline | funding_source | ✅ | ✅ |  |
| award_pipeline | grant_amendment | ✅ | ❌ | Excluded from MVM |
| award_pipeline | proposal | ✅ | ✅ |  |
| award_pipeline | solicitation | ✅ | ❌ | Excluded from MVM |
| budget_compliance | award_budget | ✅ | ✅ |  |
| budget_compliance | award_budget_line | ✅ | ✅ |  |
| budget_compliance | cost_share_commitment | ✅ | ❌ | Excluded from MVM |
| budget_compliance | donor_condition | ✅ | ✅ |  |
| budget_compliance | donor_report | ✅ | ✅ |  |
| budget_compliance | grant_closeout | ✅ | ❌ | Excluded from MVM |
| budget_compliance | prior_approval | ✅ | ❌ | Excluded from MVM |
| subaward_management | asset_allocation | ✅ | ❌ | Excluded from MVM |
| subaward_management | award_position_funding | ✅ | ❌ | Excluded from MVM |
| subaward_management | award_site_allocation | ✅ | ❌ | Excluded from MVM |
| subaward_management | grant_staff_assignment | ✅ | ❌ | Excluded from MVM |
| subaward_management | sub_award_disbursement | ✅ | ✅ |  |
| subaward_management | subaward | ✅ | ✅ |  |

<a id="domain-mel"></a>
### mel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| data_collection | data_collection_tool | ✅ | ✅ |  |
| data_collection | data_quality_assessment | ✅ | ❌ | Excluded from MVM |
| data_collection | dhis2_aggregate_report | ✅ | ❌ | Excluded from MVM |
| data_collection | mel_needs_assessment | ✅ | ❌ | Excluded from MVM |
| data_collection | qualitative_record | ✅ | ❌ | Excluded from MVM |
| evaluation_learning | evaluation | ✅ | ✅ |  |
| evaluation_learning | evaluation_finding | ✅ | ✅ |  |
| evaluation_learning | learning_agenda | ✅ | ❌ | Excluded from MVM |
| indicator_management | indicator | ✅ | ✅ |  |
| indicator_management | indicator_result | ✅ | ✅ |  |
| indicator_management | indicator_target | ✅ | ✅ |  |
| indicator_management | sdg_indicator_alignment | ✅ | ❌ | Excluded from MVM |
| results_framework | geographic_scope | ✅ | ❌ | Excluded from MVM |
| results_framework | meal_plan | ✅ | ✅ |  |
| results_framework | mel_logframe | ✅ | ✅ |  |
| results_framework | reporting_period | ✅ | ✅ |  |

<a id="domain-partnership"></a>
### partnership

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_governance | agreement | ✅ | ✅ |  |
| agreement_governance | agreement_amendment | ✅ | ❌ | Excluded from MVM |
| agreement_governance | mou_obligation | ✅ | ❌ | Excluded from MVM |
| agreement_governance | partner_compliance | ✅ | ❌ | Excluded from MVM |
| agreement_governance | partnership_agreement | ✅ | ❌ | Excluded from MVM |
| capacity_development | capacity_assessment | ✅ | ✅ |  |
| capacity_development | capacity_building_activity | ✅ | ❌ | Excluded from MVM |
| capacity_development | capacity_building_plan | ✅ | ❌ | Excluded from MVM |
| capacity_development | field_monitoring_visit | ✅ | ❌ | Excluded from MVM |
| capacity_development | partner_performance_review | ✅ | ✅ |  |
| capacity_development | partner_report_submission | ✅ | ✅ |  |
| capacity_development | partnership_face_form | ✅ | ❌ | Excluded from MVM |
| capacity_development | programme_visit | ✅ | ❌ | Excluded from MVM |
| capacity_development | scheduled_audit | ✅ | ❌ | Excluded from MVM |
| capacity_development | spot_check | ✅ | ❌ | Excluded from MVM |
| consortium_coordination | campaign_participation | ✅ | ❌ | Excluded from MVM |
| consortium_coordination | consortium | ✅ | ✅ |  |
| consortium_coordination | consortium_communication | ✅ | ❌ | Excluded from MVM |
| consortium_coordination | consortium_member | ✅ | ✅ |  |
| consortium_coordination | coordination_meeting | ✅ | ❌ | Excluded from MVM |
| partner_registry | due_diligence_record | ✅ | ✅ |  |
| partner_registry | macro_assessment | ✅ | ❌ | Excluded from MVM |
| partner_registry | micro_assessment | ✅ | ❌ | Excluded from MVM |
| partner_registry | partner_accreditation | ✅ | ❌ | Excluded from MVM |
| partner_registry | partner_contact | ✅ | ✅ |  |
| partner_registry | partner_org | ✅ | ✅ |  |
| partner_registry | partner_risk_register | ✅ | ❌ | Excluded from MVM |

<a id="domain-program"></a>
### program

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| delivery_planning | budget_plan | ✅ | ✅ |  |
| delivery_planning | budget_plan_line | ✅ | ✅ |  |
| delivery_planning | component_system_usage | ✅ | ❌ | Excluded from MVM |
| delivery_planning | implementation_plan | ✅ | ✅ |  |
| delivery_planning | intervention_compliance | ✅ | ❌ | Excluded from MVM |
| delivery_planning | partner_linkage | ✅ | ❌ | Excluded from MVM |
| delivery_planning | program_partnership | ✅ | ✅ |  |
| program_design | component | ✅ | ✅ |  |
| program_design | country_programme_document | ✅ | ❌ | Excluded from MVM |
| program_design | design_assessment | ✅ | ❌ | Excluded from MVM |
| program_design | humanitarian_response_plan | ✅ | ❌ | Excluded from MVM |
| program_design | intervention | ✅ | ✅ |  |
| program_design | program | ✅ | ✅ |  |
| program_design | program_amendment | ✅ | ❌ | Excluded from MVM |
| program_design | program_closeout | ✅ | ❌ | Excluded from MVM |
| program_design | review_event | ✅ | ❌ | Excluded from MVM |
| program_design | strategic_plan_goal_area | ✅ | ❌ | Excluded from MVM |
| program_design | target_population | ✅ | ✅ |  |
| program_design | theory_of_change | ✅ | ✅ |  |
| program_design | unsdcf_outcome | ✅ | ❌ | Excluded from MVM |
| results_framework | component_indicator | ✅ | ❌ | Excluded from MVM |
| results_framework | logframe_row | ✅ | ✅ |  |
| results_framework | program_logframe | ✅ | ✅ |  |
| results_framework | risk_register | ✅ | ❌ | Excluded from MVM |

<a id="domain-safeguarding"></a>
### safeguarding

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| incident_response | alleged_perpetrator | ✅ | ❌ | Excluded from MVM |
| incident_response | disciplinary_outcome | ✅ | ❌ | Excluded from MVM |
| incident_response | incident | ❌ | ✅ | MVM only (stub or new) |
| incident_response | investigation | ✅ | ✅ |  |
| incident_response | investigation_action | ✅ | ✅ |  |
| incident_response | misconduct_disclosure | ✅ | ❌ | Excluded from MVM |
| incident_response | safeguarding_incident | ✅ | ❌ | Excluded from MVM |
| partner_accountability | audit | ✅ | ❌ | Excluded from MVM |
| partner_accountability | audit_recommendation | ✅ | ❌ | Excluded from MVM |
| partner_accountability | donor_safeguarding_requirement | ✅ | ❌ | Excluded from MVM |
| partner_accountability | partner_psea_assessment | ✅ | ❌ | Excluded from MVM |
| partner_accountability | psea_network | ✅ | ❌ | Excluded from MVM |
| partner_accountability | psea_network_membership | ✅ | ❌ | Excluded from MVM |
| policy_compliance | focal_point | ✅ | ✅ |  |
| policy_compliance | psea_policy | ✅ | ✅ |  |
| policy_compliance | reporting_channel | ✅ | ✅ |  |
| policy_compliance | risk_assessment | ✅ | ✅ |  |
| policy_compliance | safeguarding_policy_acknowledgment | ✅ | ❌ | Excluded from MVM |
| survivor_support | support_service_referral | ✅ | ❌ | Excluded from MVM |
| survivor_support | survivor_record | ✅ | ✅ |  |
| survivor_support | survivor_support_plan | ✅ | ✅ |  |
| training_awareness | community_awareness_session | ✅ | ❌ | Excluded from MVM |
| training_awareness | safeguarding_training_completion | ✅ | ❌ | Excluded from MVM |
| training_awareness | training_program | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cold_chain | batch_lot | ✅ | ❌ | Excluded from MVM |
| cold_chain | cold_chain_equipment | ✅ | ❌ | Excluded from MVM |
| cold_chain | gavi_cofinancing | ✅ | ❌ | Excluded from MVM |
| cold_chain | gavi_cofinancing_tracking | ✅ | ❌ | Excluded from MVM |
| cold_chain | temperature_excursion | ✅ | ❌ | Excluded from MVM |
| cold_chain | vaccine_vial_monitor_state | ✅ | ❌ | Excluded from MVM |
| field_distribution | distribution_order | ✅ | ✅ |  |
| field_distribution | distribution_plan | ✅ | ✅ |  |
| field_distribution | distribution_plan_line | ✅ | ❌ | Excluded from MVM |
| field_distribution | shipment | ✅ | ❌ | Excluded from MVM |
| field_distribution | supply_distribution_line | ✅ | ❌ | Excluded from MVM |
| field_distribution | waybill | ✅ | ✅ |  |
| inventory_management | commodity | ✅ | ✅ |  |
| inventory_management | goods_receipt | ✅ | ✅ |  |
| inventory_management | inkind_donation | ✅ | ❌ | Excluded from MVM |
| inventory_management | inventory_balance | ✅ | ✅ |  |
| inventory_management | stock_movement | ✅ | ✅ |  |
| inventory_management | supply_category | ✅ | ❌ | Excluded from MVM |
| inventory_management | warehouse | ✅ | ✅ |  |
| procurement_sourcing | bid | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | commodity_supply_agreement | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | framework_agreement | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | procurement_request | ✅ | ✅ |  |
| procurement_sourcing | purchase_order | ✅ | ✅ |  |
| procurement_sourcing | purchase_order_line | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | rfq | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | supply_agreement | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | vendor | ✅ | ✅ |  |

<a id="domain-technology"></a>
### technology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_security | access_provisioning | ✅ | ❌ | Domain not in MVM |
| access_security | access_role | ✅ | ❌ | Domain not in MVM |
| access_security | security_assessment | ✅ | ❌ | Domain not in MVM |
| access_security | security_control | ✅ | ❌ | Domain not in MVM |
| access_security | user_account | ✅ | ❌ | Domain not in MVM |
| access_security | vulnerability | ✅ | ❌ | Domain not in MVM |
| digital_delivery | it_procurement | ✅ | ❌ | Domain not in MVM |
| digital_delivery | it_project | ✅ | ❌ | Domain not in MVM |
| digital_delivery | platform_integration | ✅ | ❌ | Domain not in MVM |
| infrastructure_assets | backup_schedule | ✅ | ❌ | Domain not in MVM |
| infrastructure_assets | connectivity_log | ✅ | ❌ | Domain not in MVM |
| infrastructure_assets | it_asset | ✅ | ❌ | Domain not in MVM |
| infrastructure_assets | network_site | ✅ | ❌ | Domain not in MVM |
| infrastructure_assets | software_license | ✅ | ❌ | Domain not in MVM |
| infrastructure_assets | system_platform | ✅ | ❌ | Domain not in MVM |
| service_operations | cab_meeting | ✅ | ❌ | Domain not in MVM |
| service_operations | change_request | ✅ | ❌ | Domain not in MVM |
| service_operations | it_incident | ✅ | ❌ | Domain not in MVM |
| service_operations | it_problem | ✅ | ❌ | Domain not in MVM |
| service_operations | it_service | ✅ | ❌ | Domain not in MVM |
| service_operations | knowledge_article | ✅ | ❌ | Domain not in MVM |
| service_operations | service_request | ✅ | ❌ | Domain not in MVM |

<a id="domain-volunteer"></a>
### volunteer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| deployment_operations | hour_log | ✅ | ❌ | Domain not in MVM |
| deployment_operations | schedule | ✅ | ❌ | Domain not in MVM |
| deployment_operations | stipend | ✅ | ❌ | Domain not in MVM |
| deployment_operations | volunteer_deployment | ✅ | ❌ | Domain not in MVM |
| deployment_operations | volunteer_deployment2 | ✅ | ❌ | Domain not in MVM |
| deployment_operations | volunteer_redeployment | ✅ | ❌ | Domain not in MVM |
| engagement_welfare | feedback | ✅ | ❌ | Domain not in MVM |
| engagement_welfare | incident_report | ✅ | ❌ | Domain not in MVM |
| engagement_welfare | recognition | ✅ | ❌ | Domain not in MVM |
| learning_certification | certification | ✅ | ❌ | Domain not in MVM |
| learning_certification | tool_authorization | ✅ | ❌ | Domain not in MVM |
| learning_certification | training | ✅ | ❌ | Domain not in MVM |
| learning_certification | training_enrollment | ✅ | ❌ | Domain not in MVM |
| learning_certification | volunteer_training_completion | ✅ | ❌ | Domain not in MVM |
| volunteer_registry | application | ✅ | ❌ | Domain not in MVM |
| volunteer_registry | consent | ✅ | ❌ | Domain not in MVM |
| volunteer_registry | role | ✅ | ❌ | Domain not in MVM |
| volunteer_registry | volunteer | ✅ | ❌ | Domain not in MVM |
| volunteer_registry | volunteer_policy_acknowledgment | ✅ | ❌ | Domain not in MVM |
| volunteer_registry | volunteer_team | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | disciplinary_case | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payslip | ✅ | ❌ | Domain not in MVM |
| performance_development | calibration_session | ✅ | ❌ | Domain not in MVM |
| performance_development | competency_framework | ✅ | ❌ | Domain not in MVM |
| performance_development | learning_course | ✅ | ❌ | Domain not in MVM |
| performance_development | learning_enrollment | ✅ | ❌ | Domain not in MVM |
| performance_development | performance_improvement_plan | ✅ | ❌ | Domain not in MVM |
| performance_development | performance_review | ✅ | ❌ | Domain not in MVM |
| performance_development | rating_scale | ✅ | ❌ | Domain not in MVM |
| performance_development | review_cycle | ✅ | ❌ | Domain not in MVM |
| performance_development | review_template | ✅ | ❌ | Domain not in MVM |
| staff_records | employment_contract | ✅ | ❌ | Domain not in MVM |
| staff_records | expat_package | ✅ | ❌ | Domain not in MVM |
| staff_records | job_profile | ✅ | ❌ | Domain not in MVM |
| staff_records | org_unit | ✅ | ❌ | Domain not in MVM |
| staff_records | position | ✅ | ❌ | Domain not in MVM |
| staff_records | separation_event | ✅ | ❌ | Domain not in MVM |
| staff_records | staff_certification | ✅ | ❌ | Domain not in MVM |
| staff_records | staff_member | ✅ | ❌ | Domain not in MVM |
| staff_records | timesheet | ✅ | ❌ | Domain not in MVM |
| staff_records | workforce_staff_assignment | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | candidate | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
