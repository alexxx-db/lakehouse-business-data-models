# Health_Insurance Lakehouse Data Models

**Version 2** | Generated on June 27, 2026 at 10:42 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Appeal](#domain-appeal)
  - [Billing](#domain-billing)
  - [Care](#domain-care)
  - [Claim](#domain-claim)
  - [Compliance](#domain-compliance)
  - [Contract](#domain-contract)
  - [Credential](#domain-credential)
  - [Employer](#domain-employer)
  - [Enrollment](#domain-enrollment)
  - [Finance](#domain-finance)
  - [Member](#domain-member)
  - [Network](#domain-network)
  - [Pharmacy](#domain-pharmacy)
  - [Plan](#domain-plan)
  - [Provider](#domain-provider)
  - [Risk](#domain-risk)
  - [Utilization](#domain-utilization)
  - [Vendor](#domain-vendor)
  - [Workforce](#domain-workforce)


## Business Description

health insurance industry enterprise data model.

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
| Domains | 12 | 19 |
| Subdomains | 28 | 75 |
| Products (Tables) | 104 | 426 |
| Attributes (Columns) | 4950 | 18595 |
| Foreign Keys | 634 | 1624 |
| Avg Attributes/Product | 47.6 | 43.7 |

## Domain & Product Comparison

<a id="domain-appeal"></a>
### appeal

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | adverse_determination | ✅ | ✅ |  |
| case_management | case | ✅ | ✅ |  |
| case_management | coverage_dispute | ✅ | ✅ |  |
| case_management | penalty | ✅ | ❌ | Excluded from MVM |
| case_management | timeline | ✅ | ✅ |  |
| review_processing | expedited_review | ✅ | ❌ | Excluded from MVM |
| review_processing | external_review | ✅ | ✅ |  |
| review_processing | iro_organization | ✅ | ✅ |  |
| review_processing | outcome | ✅ | ✅ |  |
| review_processing | review | ✅ | ✅ |  |
| supporting_documentation | appeal_communication | ✅ | ❌ | Excluded from MVM |
| supporting_documentation | appeal_communication2 | ✅ | ❌ | Excluded from MVM |
| supporting_documentation | appeal_document | ✅ | ❌ | Excluded from MVM |
| supporting_documentation | appeal_document2 | ✅ | ❌ | Excluded from MVM |
| supporting_documentation | appeal_grievance | ✅ | ❌ | Excluded from MVM |
| supporting_documentation | appeal_grievance2 | ✅ | ❌ | Excluded from MVM |
| supporting_documentation | evidence | ✅ | ❌ | Excluded from MVM |
| supporting_documentation | regulatory_filing | ✅ | ❌ | Excluded from MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | billing_calendar | ✅ | ❌ | Excluded from MVM |
| account_management | collection_case | ✅ | ❌ | Excluded from MVM |
| account_management | cycle | ✅ | ❌ | Excluded from MVM |
| account_management | grace_period | ✅ | ✅ |  |
| account_management | payer_billing_role | ✅ | ❌ | Excluded from MVM |
| account_management | payment_method | ✅ | ✅ |  |
| account_management | suspense_account | ✅ | ❌ | Excluded from MVM |
| adjustment_dispute | cms_remittance | ✅ | ❌ | Excluded from MVM |
| adjustment_dispute | cobra_billing | ✅ | ❌ | Excluded from MVM |
| adjustment_dispute | dispute | ✅ | ❌ | Excluded from MVM |
| adjustment_dispute | edi_820 | ✅ | ❌ | Excluded from MVM |
| adjustment_dispute | retro_adjustment | ✅ | ❌ | Excluded from MVM |
| premium_billing | aptc_subsidy | ✅ | ✅ |  |
| premium_billing | invoice_line | ✅ | ✅ |  |
| premium_billing | mlr_rebate | ✅ | ❌ | Excluded from MVM |
| premium_billing | payment_allocation | ✅ | ✅ |  |
| premium_billing | premium_invoice | ✅ | ✅ |  |
| premium_billing | premium_payment | ✅ | ✅ |  |
| premium_billing | premium_rate | ✅ | ✅ |  |
| premium_billing | premium_reconciliation | ✅ | ❌ | Excluded from MVM |
| premium_billing | premium_refund | ✅ | ❌ | Excluded from MVM |
| premium_billing | premium_statement | ✅ | ❌ | Excluded from MVM |
| premium_billing | rate_schedule | ✅ | ❌ | Excluded from MVM |

<a id="domain-care"></a>
### care

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| care_coordination | barrier | ✅ | ❌ | Excluded from MVM |
| care_coordination | coordinator | ✅ | ✅ |  |
| care_coordination | coordinator_assignment | ✅ | ❌ | Excluded from MVM |
| care_coordination | dme_coordination | ✅ | ❌ | Excluded from MVM |
| care_coordination | member_outreach | ✅ | ❌ | Excluded from MVM |
| care_coordination | snf_stay | ✅ | ❌ | Excluded from MVM |
| care_coordination | team | ✅ | ❌ | Excluded from MVM |
| care_coordination | transition | ✅ | ❌ | Excluded from MVM |
| program_management | care_enrollment | ✅ | ❌ | Excluded from MVM |
| program_management | care_enrollment2 | ✅ | ❌ | Excluded from MVM |
| program_management | care_plan | ✅ | ✅ |  |
| program_management | coordinator_program_assignment | ❌ | ✅ | MVM only (stub or new) |
| program_management | plan_goal | ✅ | ✅ |  |
| program_management | program | ✅ | ✅ |  |
| program_management | program_accreditation | ✅ | ❌ | Excluded from MVM |
| program_management | program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_management | program_obligation_mapping | ✅ | ❌ | Excluded from MVM |
| quality_measurement | cahps_survey | ✅ | ❌ | Excluded from MVM |
| quality_measurement | gap | ✅ | ✅ |  |
| quality_measurement | gap_obligation | ✅ | ❌ | Excluded from MVM |
| quality_measurement | hedis_measure | ✅ | ✅ |  |
| quality_measurement | hedis_result | ✅ | ✅ |  |
| quality_measurement | measure_obligation_mapping | ✅ | ❌ | Excluded from MVM |
| quality_measurement | star_rating_result | ✅ | ❌ | Excluded from MVM |
| risk_stratification | condition_registry | ✅ | ✅ |  |
| risk_stratification | hra | ✅ | ✅ |  |
| risk_stratification | member_risk_tier | ✅ | ✅ |  |
| risk_stratification | population_segment | ✅ | ❌ | Excluded from MVM |
| risk_stratification | question_set | ✅ | ❌ | Excluded from MVM |
| risk_stratification | questionnaire | ✅ | ❌ | Excluded from MVM |
| risk_stratification | sdoh_assessment | ✅ | ❌ | Excluded from MVM |

<a id="domain-claim"></a>
### claim

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| claim_processing | attachment | ✅ | ❌ | Excluded from MVM |
| claim_processing | diagnosis | ✅ | ✅ |  |
| claim_processing | header | ✅ | ✅ |  |
| claim_processing | line | ✅ | ✅ |  |
| claim_processing | procedure | ✅ | ✅ |  |
| claim_processing | status_event | ✅ | ❌ | Excluded from MVM |
| payment_settlement | adjudication | ✅ | ✅ |  |
| payment_settlement | adjudication_rate | ✅ | ❌ | Excluded from MVM |
| payment_settlement | denial | ✅ | ✅ |  |
| payment_settlement | eob | ✅ | ✅ |  |
| payment_settlement | payment | ✅ | ✅ |  |
| recovery_management | adjustment | ✅ | ✅ |  |
| recovery_management | cob | ✅ | ✅ |  |
| recovery_management | drg | ✅ | ❌ | Excluded from MVM |
| recovery_management | subrogation | ✅ | ❌ | Excluded from MVM |
| reserve_tracking | accumulator | ✅ | ❌ | Excluded from MVM |
| reserve_tracking | claim_payer | ✅ | ❌ | Excluded from MVM |
| reserve_tracking | ibnr | ✅ | ❌ | Excluded from MVM |
| reserve_tracking | payer_claim_role | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accreditation_training | accreditation_program | ✅ | ❌ | Domain not in MVM |
| accreditation_training | accreditation_survey | ✅ | ❌ | Domain not in MVM |
| accreditation_training | training_completion | ✅ | ❌ | Domain not in MVM |
| accreditation_training | training_program | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_engagement | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | cap_milestone | ✅ | ❌ | Domain not in MVM |
| audit_management | corrective_action_plan | ✅ | ❌ | Domain not in MVM |
| fraud_integrity | employee_screening | ✅ | ❌ | Domain not in MVM |
| fraud_integrity | fwa_case | ✅ | ❌ | Domain not in MVM |
| fraud_integrity | fwa_referral | ✅ | ❌ | Domain not in MVM |
| policy_governance | compliance_attestation | ✅ | ❌ | Domain not in MVM |
| policy_governance | policy_document | ✅ | ❌ | Domain not in MVM |
| policy_governance | policy_review | ✅ | ❌ | Domain not in MVM |
| policy_governance | regulatory_obligation | ✅ | ❌ | Domain not in MVM |
| privacy_protection | baa | ✅ | ❌ | Domain not in MVM |
| privacy_protection | breach_incident | ✅ | ❌ | Domain not in MVM |
| privacy_protection | breach_notification | ✅ | ❌ | Domain not in MVM |
| privacy_protection | breach_report | ✅ | ❌ | Domain not in MVM |
| privacy_protection | hipaa_privacy_request | ✅ | ❌ | Domain not in MVM |
| privacy_protection | phi_disclosure_log | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | erisa_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | mlr_calculation | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_submission | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | state_fair_hearing | ✅ | ❌ | Domain not in MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_parties | contract_amendment | ✅ | ❌ | Domain not in MVM |
| agreement_parties | contract_network_participation | ✅ | ❌ | Domain not in MVM |
| agreement_parties | delegation_agreement | ✅ | ❌ | Domain not in MVM |
| agreement_parties | party | ✅ | ❌ | Domain not in MVM |
| agreement_parties | provider_contract | ✅ | ❌ | Domain not in MVM |
| agreement_parties | service_scope | ✅ | ❌ | Domain not in MVM |
| agreement_parties | term | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | contract_lifecycle_event | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | contract_lifecycle_event2 | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | audit | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | contract_dispute | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | obligation | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | party_regulatory_obligation_compliance | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | reimbursement_policy | ✅ | ❌ | Domain not in MVM |
| payment_reimbursement | capitation_arrangement | ✅ | ❌ | Domain not in MVM |
| payment_reimbursement | capitation_payment | ✅ | ❌ | Domain not in MVM |
| payment_reimbursement | fee_schedule | ✅ | ❌ | Domain not in MVM |
| payment_reimbursement | fee_schedule_rate | ✅ | ❌ | Domain not in MVM |
| payment_reimbursement | financial_summary | ✅ | ❌ | Domain not in MVM |
| value_performance | bundled_payment_episode | ✅ | ❌ | Domain not in MVM |
| value_performance | incentive_arrangement | ✅ | ❌ | Domain not in MVM |
| value_performance | vbc_contract | ✅ | ❌ | Domain not in MVM |
| value_performance | vbc_performance_period | ✅ | ❌ | Domain not in MVM |

<a id="domain-credential"></a>
### credential

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| attestation_records | credential_appeal | ✅ | ❌ | Domain not in MVM |
| attestation_records | credential_attestation | ✅ | ❌ | Domain not in MVM |
| attestation_records | credential_attestation2 | ✅ | ❌ | Domain not in MVM |
| attestation_records | credential_document | ✅ | ❌ | Domain not in MVM |
| attestation_records | credential_outreach | ✅ | ❌ | Domain not in MVM |
| committee_oversight | committee | ✅ | ❌ | Domain not in MVM |
| committee_oversight | committee_review | ✅ | ❌ | Domain not in MVM |
| committee_oversight | committee_type | ✅ | ❌ | Domain not in MVM |
| committee_oversight | decision_document | ✅ | ❌ | Domain not in MVM |
| delegation_management | cvo_relationship | ✅ | ❌ | Domain not in MVM |
| delegation_management | delegated_entity | ✅ | ❌ | Domain not in MVM |
| delegation_management | delegation_audit | ✅ | ❌ | Domain not in MVM |
| obligation_tracking | contract_link | ✅ | ❌ | Domain not in MVM |
| obligation_tracking | credential_lifecycle_event | ✅ | ❌ | Domain not in MVM |
| obligation_tracking | finding | ✅ | ❌ | Domain not in MVM |
| obligation_tracking | obligation_mapping | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | application | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | expedited_credential | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | psv_verification | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | record | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | recredential_cycle | ✅ | ❌ | Domain not in MVM |
| screening_verification | npdb_query | ✅ | ❌ | Domain not in MVM |
| screening_verification | sanction_screening | ✅ | ❌ | Domain not in MVM |

<a id="domain-employer"></a>
### employer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | contribution_strategy | ✅ | ❌ | Domain not in MVM |
| account_management | group | ✅ | ❌ | Domain not in MVM |
| account_management | group_amendment | ✅ | ❌ | Domain not in MVM |
| account_management | group_contact | ✅ | ❌ | Domain not in MVM |
| account_management | group_division | ✅ | ❌ | Domain not in MVM |
| account_management | group_document | ✅ | ❌ | Domain not in MVM |
| account_management | group_location | ✅ | ❌ | Domain not in MVM |
| account_management | group_plan_offering | ✅ | ❌ | Domain not in MVM |
| account_management | group_rating_factor | ✅ | ❌ | Domain not in MVM |
| account_management | group_renewal | ✅ | ❌ | Domain not in MVM |
| account_management | open_enrollment_window | ✅ | ❌ | Domain not in MVM |
| account_management | participation_requirement | ✅ | ❌ | Domain not in MVM |
| administrative_services | employer_contract | ✅ | ❌ | Domain not in MVM |
| administrative_services | employer_contract2 | ✅ | ❌ | Domain not in MVM |
| administrative_services | tpa | ✅ | ❌ | Domain not in MVM |
| administrative_services | tpa_arrangement | ✅ | ❌ | Domain not in MVM |
| distribution_channels | broker | ✅ | ❌ | Domain not in MVM |
| distribution_channels | broker_agreement | ✅ | ❌ | Domain not in MVM |
| distribution_channels | broker_assignment | ✅ | ❌ | Domain not in MVM |
| distribution_channels | general_agent | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | cobra_administration | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | erisa_plan_document | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | regulatory_compliance_record | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | wellness_program | ✅ | ❌ | Domain not in MVM |
| underwriting_risk | aso_fee_schedule | ✅ | ❌ | Domain not in MVM |
| underwriting_risk | rate_quote | ✅ | ❌ | Domain not in MVM |
| underwriting_risk | stop_loss_policy | ✅ | ❌ | Domain not in MVM |
| underwriting_risk | underwriting_case | ✅ | ❌ | Domain not in MVM |

<a id="domain-enrollment"></a>
### enrollment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| eligibility_management | eligibility_verification | ✅ | ✅ |  |
| eligibility_management | enrollment_eligibility_span | ✅ | ❌ | Excluded from MVM |
| eligibility_management | medicaid_eligibility | ✅ | ❌ | Excluded from MVM |
| eligibility_management | medicare_entitlement | ✅ | ❌ | Excluded from MVM |
| eligibility_management | open_enrollment_period | ✅ | ✅ |  |
| eligibility_management | qualifying_life_event | ✅ | ✅ |  |
| enrollment_processing | batch | ✅ | ❌ | Excluded from MVM |
| enrollment_processing | cms_submission | ✅ | ❌ | Excluded from MVM |
| enrollment_processing | edi_transaction | ✅ | ✅ |  |
| enrollment_processing | event | ✅ | ✅ |  |
| enrollment_processing | pend_queue | ✅ | ❌ | Excluded from MVM |
| enrollment_processing | reconciliation | ✅ | ✅ |  |
| enrollment_processing | submission_batch | ✅ | ❌ | Excluded from MVM |
| enrollment_processing | transaction | ✅ | ✅ |  |
| plan_selection | cobra_election | ✅ | ❌ | Excluded from MVM |
| plan_selection | exchange_enrollment | ✅ | ❌ | Excluded from MVM |
| plan_selection | plan_election | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_depreciation | depreciation_transaction | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | fixed_asset | ✅ | ❌ | Domain not in MVM |
| general_ledger | budget | ✅ | ❌ | Domain not in MVM |
| general_ledger | budget_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | cost_center | ✅ | ❌ | Domain not in MVM |
| general_ledger | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | ledger | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_receipt | ✅ | ❌ | Domain not in MVM |
| payables_receivables | bank_account | ✅ | ❌ | Domain not in MVM |
| payables_receivables | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| revenue_settlement | mlr_financial_entry | ✅ | ❌ | Domain not in MVM |
| revenue_settlement | premium_revenue | ✅ | ❌ | Domain not in MVM |
| revenue_settlement | reinsurance_transaction | ✅ | ❌ | Domain not in MVM |
| revenue_settlement | vbc_settlement | ✅ | ❌ | Domain not in MVM |
| risk_reserving | actuarial_reserve | ✅ | ❌ | Domain not in MVM |
| risk_reserving | finance_regulatory_filing | ✅ | ❌ | Domain not in MVM |
| risk_reserving | legal_entity | ✅ | ❌ | Domain not in MVM |
| risk_reserving | tax_filing | ✅ | ❌ | Domain not in MVM |

<a id="domain-member"></a>
### member

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| core_identity | dependent | ✅ | ✅ |  |
| core_identity | household | ✅ | ❌ | Excluded from MVM |
| core_identity | identity | ✅ | ✅ |  |
| core_identity | lob_assignment | ✅ | ✅ |  |
| core_identity | member_address | ✅ | ❌ | Excluded from MVM |
| core_identity | member_contact | ✅ | ❌ | Excluded from MVM |
| core_identity | subscriber | ✅ | ✅ |  |
| coverage_enrollment | cob_record | ✅ | ❌ | Excluded from MVM |
| coverage_enrollment | cobra_continuant | ✅ | ❌ | Excluded from MVM |
| coverage_enrollment | disenrollment | ✅ | ✅ |  |
| coverage_enrollment | member_eligibility_span | ✅ | ❌ | Excluded from MVM |
| coverage_enrollment | member_enrollment | ✅ | ❌ | Excluded from MVM |
| coverage_enrollment | member_enrollment2 | ✅ | ❌ | Excluded from MVM |
| coverage_enrollment | pcp_assignment | ✅ | ✅ |  |
| engagement_tracking | authorized_representative | ✅ | ❌ | Excluded from MVM |
| engagement_tracking | consent | ✅ | ❌ | Excluded from MVM |
| engagement_tracking | id_card | ✅ | ✅ |  |
| engagement_tracking | member_communication | ✅ | ❌ | Excluded from MVM |
| engagement_tracking | member_grievance | ✅ | ❌ | Excluded from MVM |
| engagement_tracking | member_grievance2 | ✅ | ❌ | Excluded from MVM |
| engagement_tracking | segment | ✅ | ❌ | Excluded from MVM |
| enrollment_coverage | eligibility_span | ❌ | ✅ | MVM only (stub or new) |
| member_identity | address | ❌ | ✅ | MVM only (stub or new) |
| member_identity | contact | ❌ | ✅ | MVM only (stub or new) |
| reference_administration | assignment_rule | ✅ | ❌ | Excluded from MVM |
| reference_administration | authorization_document | ✅ | ❌ | Excluded from MVM |
| reference_administration | member_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| reference_administration | policy | ✅ | ✅ |  |

<a id="domain-network"></a>
### network

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| adequacy_compliance | access_standard | ✅ | ❌ | Excluded from MVM |
| adequacy_compliance | access_survey | ✅ | ❌ | Excluded from MVM |
| adequacy_compliance | adequacy_assessment | ✅ | ✅ |  |
| adequacy_compliance | adequacy_gap | ✅ | ❌ | Excluded from MVM |
| adequacy_compliance | adequacy_standard | ✅ | ✅ |  |
| adequacy_compliance | exception | ✅ | ❌ | Excluded from MVM |
| adequacy_compliance | filing | ✅ | ❌ | Excluded from MVM |
| adequacy_compliance | network_directory_verification | ✅ | ❌ | Excluded from MVM |
| network_structure | network_service_area | ✅ | ❌ | Excluded from MVM |
| network_structure | par_agreement | ✅ | ✅ |  |
| network_structure | plan_association | ✅ | ✅ |  |
| network_structure | provider_assignment | ✅ | ✅ |  |
| network_structure | provider_directory | ✅ | ✅ |  |
| network_structure | provider_network | ✅ | ✅ |  |
| network_structure | tier | ✅ | ✅ |  |
| provider_lifecycle | change_event | ✅ | ❌ | Excluded from MVM |
| provider_lifecycle | recruitment | ✅ | ❌ | Excluded from MVM |
| provider_lifecycle | termination | ✅ | ❌ | Excluded from MVM |
| value_programs | aco_provider | ✅ | ❌ | Excluded from MVM |
| value_programs | vbc_arrangement | ✅ | ❌ | Excluded from MVM |
| value_programs | vbc_program | ✅ | ❌ | Excluded from MVM |

<a id="domain-pharmacy"></a>
### pharmacy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| claim_processing | benefit_accumulator | ✅ | ❌ | Excluded from MVM |
| claim_processing | claim_line | ✅ | ✅ |  |
| claim_processing | part_d_submission | ✅ | ❌ | Excluded from MVM |
| claim_processing | pharmacy_claim | ✅ | ❌ | Excluded from MVM |
| claim_processing | pharmacy_claim2 | ✅ | ❌ | Excluded from MVM |
| clinical_review | dur_alert | ✅ | ❌ | Excluded from MVM |
| clinical_review | mtm_service | ✅ | ❌ | Excluded from MVM |
| clinical_review | prior_authorization | ✅ | ✅ |  |
| drug_management | dispensing_pharmacy | ✅ | ✅ |  |
| drug_management | drug_master | ✅ | ✅ |  |
| drug_management | drug_pricing | ✅ | ✅ |  |
| drug_management | specialty_drug_program | ✅ | ❌ | Excluded from MVM |
| formulary_benefits | formulary | ✅ | ✅ |  |
| formulary_benefits | formulary_drug_tier | ✅ | ✅ |  |
| formulary_benefits | formulary_exception | ✅ | ✅ |  |
| rebate_contracting | drug_rebate | ✅ | ❌ | Excluded from MVM |
| rebate_contracting | mac_list | ✅ | ❌ | Excluded from MVM |
| rebate_contracting | pbm_contract | ✅ | ✅ |  |
| rebate_contracting | pharmacy_contract | ✅ | ❌ | Excluded from MVM |

<a id="domain-plan"></a>
### plan

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| market_enrollment | offering | ✅ | ❌ | Excluded from MVM |
| market_enrollment | plan_provider_contract | ✅ | ❌ | Excluded from MVM |
| market_enrollment | plan_service_area | ✅ | ❌ | Excluded from MVM |
| market_enrollment | program_coverage | ✅ | ❌ | Excluded from MVM |
| market_enrollment | provider_contract_link | ✅ | ❌ | Excluded from MVM |
| plan_catalog | service_area | ❌ | ✅ | MVM only (stub or new) |
| pricing_rating | crosswalk | ✅ | ❌ | Excluded from MVM |
| pricing_rating | rate | ✅ | ✅ |  |
| pricing_rating | status_history | ✅ | ❌ | Excluded from MVM |
| product_design | benefit | ✅ | ✅ |  |
| product_design | benefit_package | ✅ | ✅ |  |
| product_design | cost_share_rule | ✅ | ✅ |  |
| product_design | health_plan | ✅ | ✅ |  |
| product_design | hsa_hra_config | ✅ | ❌ | Excluded from MVM |
| product_design | network_config | ✅ | ✅ |  |
| product_design | rx_benefit_config | ✅ | ✅ |  |
| product_design | year | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | plan_amendment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | plan_amendment2 | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | plan_regulatory_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_obligation_link | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | sbc_document | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | submission | ✅ | ❌ | Excluded from MVM |

<a id="domain-provider"></a>
### provider

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | provider_provider | ✅ | ❌ | Excluded from MVM |
| network_participation | affiliation | ✅ | ✅ |  |
| network_participation | directory_entry | ✅ | ✅ |  |
| network_participation | participation_status | ✅ | ✅ |  |
| network_participation | provider_network_participation | ✅ | ❌ | Excluded from MVM |
| network_participation | provider_network_participation2 | ✅ | ❌ | Excluded from MVM |
| outreach_verification | outreach_campaign | ✅ | ❌ | Excluded from MVM |
| outreach_verification | provider_directory_verification | ✅ | ❌ | Excluded from MVM |
| outreach_verification | provider_outreach | ✅ | ❌ | Excluded from MVM |
| provider_identity | dea_registration | ✅ | ❌ | Excluded from MVM |
| provider_identity | facility | ✅ | ✅ |  |
| provider_identity | group_practice | ✅ | ✅ |  |
| provider_identity | license | ✅ | ✅ |  |
| provider_identity | practice_location | ✅ | ✅ |  |
| provider_identity | provider | ✅ | ✅ |  |
| provider_identity | specialty | ✅ | ✅ |  |
| regulatory_compliance | audit_assignment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | exclusion_screening | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | npi_registry_sync | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | obligation_compliance | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | sanction | ✅ | ❌ | Excluded from MVM |

<a id="domain-risk"></a>
### risk

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| actuarial_pricing | actuarial_assumption_set | ✅ | ❌ | Excluded from MVM |
| actuarial_pricing | pool | ✅ | ❌ | Excluded from MVM |
| actuarial_pricing | rate_development | ✅ | ❌ | Excluded from MVM |
| actuarial_pricing | rbc_calculation | ✅ | ❌ | Excluded from MVM |
| regulatory_submission | adjustment_payment | ✅ | ❌ | Excluded from MVM |
| regulatory_submission | radv_audit | ✅ | ✅ |  |
| regulatory_submission | raps_submission | ✅ | ✅ |  |
| regulatory_submission | risk_cms_submission | ✅ | ❌ | Excluded from MVM |
| reinsurance_reserving | ibnr_reserve | ✅ | ❌ | Excluded from MVM |
| reinsurance_reserving | reinsurance_arrangement | ✅ | ❌ | Excluded from MVM |
| reinsurance_reserving | reinsurance_claim | ✅ | ❌ | Excluded from MVM |
| reinsurance_reserving | risk_underwriting_case | ✅ | ❌ | Excluded from MVM |
| score_management | hcc_mapping | ✅ | ✅ |  |
| score_management | member_risk_score | ✅ | ✅ |  |
| score_management | prospective_risk_model | ✅ | ❌ | Excluded from MVM |
| score_management | score_run | ✅ | ✅ |  |

<a id="domain-utilization"></a>
### utilization

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_management | auth_service_line | ✅ | ✅ |  |
| authorization_management | pa_decision | ✅ | ✅ |  |
| authorization_management | pa_notification | ✅ | ❌ | Excluded from MVM |
| authorization_management | pa_request | ✅ | ✅ |  |
| authorization_management | pa_required_service | ✅ | ❌ | Excluded from MVM |
| clinical_review | bed_day_review | ✅ | ❌ | Excluded from MVM |
| clinical_review | clinical_criteria | ✅ | ✅ |  |
| clinical_review | concurrent_review | ✅ | ✅ |  |
| clinical_review | medical_policy | ✅ | ✅ |  |
| clinical_review | peer_to_peer_review | ✅ | ❌ | Excluded from MVM |
| clinical_review | retrospective_review | ✅ | ❌ | Excluded from MVM |
| episode_grouping | episode_of_care | ✅ | ❌ | Excluded from MVM |
| episode_grouping | inpatient_admission | ✅ | ✅ |  |
| program_operations | tat_compliance_event | ✅ | ❌ | Excluded from MVM |
| program_operations | um_case | ✅ | ✅ |  |
| program_operations | um_delegation | ✅ | ❌ | Excluded from MVM |
| program_operations | um_program | ✅ | ❌ | Excluded from MVM |
| program_operations | um_program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_operations | um_reviewer | ✅ | ❌ | Excluded from MVM |

<a id="domain-vendor"></a>
### vendor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_procurement | contract_amendment | ✅ | ❌ | Domain not in MVM |
| contract_procurement | contract_term | ✅ | ❌ | Domain not in MVM |
| contract_procurement | goods_receipt | ✅ | ❌ | Domain not in MVM |
| contract_procurement | invoice | ✅ | ❌ | Domain not in MVM |
| contract_procurement | po_line | ✅ | ❌ | Domain not in MVM |
| contract_procurement | purchase_order | ✅ | ❌ | Domain not in MVM |
| contract_procurement | spend | ✅ | ❌ | Domain not in MVM |
| contract_procurement | vendor_contract | ✅ | ❌ | Domain not in MVM |
| risk_oversight | incident | ✅ | ❌ | Domain not in MVM |
| risk_oversight | performance | ✅ | ❌ | Domain not in MVM |
| risk_oversight | risk_assessment | ✅ | ❌ | Domain not in MVM |
| risk_oversight | sla_event | ✅ | ❌ | Domain not in MVM |
| risk_oversight | vendor_audit | ✅ | ❌ | Domain not in MVM |
| risk_oversight | vendor_certification | ✅ | ❌ | Domain not in MVM |
| risk_oversight | vendor_dispute | ✅ | ❌ | Domain not in MVM |
| risk_oversight | vendor_document | ✅ | ❌ | Domain not in MVM |
| risk_oversight | vendor_lifecycle_event | ✅ | ❌ | Domain not in MVM |
| supplier_master | baa_agreement | ✅ | ❌ | Domain not in MVM |
| supplier_master | insurance | ✅ | ❌ | Domain not in MVM |
| supplier_master | onboarding | ✅ | ❌ | Domain not in MVM |
| supplier_master | relationship | ✅ | ❌ | Domain not in MVM |
| supplier_master | rfp | ✅ | ❌ | Domain not in MVM |
| supplier_master | rfp_response | ✅ | ❌ | Domain not in MVM |
| supplier_master | spend_category | ✅ | ❌ | Domain not in MVM |
| supplier_master | vendor | ✅ | ❌ | Domain not in MVM |
| supplier_master | vendor_address | ✅ | ❌ | Domain not in MVM |
| supplier_master | vendor_contact | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_access | background_check | ✅ | ❌ | Domain not in MVM |
| compliance_access | compliance_event | ✅ | ❌ | Domain not in MVM |
| compliance_access | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| compliance_access | rbac_assignment | ✅ | ❌ | Domain not in MVM |
| compliance_access | rbac_role | ✅ | ❌ | Domain not in MVM |
| compliance_access | time_and_attendance | ✅ | ❌ | Domain not in MVM |
| employee_management | employee | ✅ | ❌ | Domain not in MVM |
| employee_management | employment_record | ✅ | ❌ | Domain not in MVM |
| employee_management | job_role | ✅ | ❌ | Domain not in MVM |
| employee_management | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_management | position | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | employee_benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_cost_allocation | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_disbursement | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| talent_development | headcount_plan | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_record | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_certification | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_certification2 | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_recruitment | ✅ | ❌ | Domain not in MVM |
