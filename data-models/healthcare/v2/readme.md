# Healthcare Lakehouse Data Models

**Version 2** | Generated on July 10, 2026 at 04:21 PM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Billing](#domain-billing)
  - [Claim](#domain-claim)
  - [Clinical](#domain-clinical)
  - [Compliance](#domain-compliance)
  - [Consent](#domain-consent)
  - [Encounter](#domain-encounter)
  - [Facility](#domain-facility)
  - [Finance](#domain-finance)
  - [Insurance](#domain-insurance)
  - [Interoperability](#domain-interoperability)
  - [Laboratory](#domain-laboratory)
  - [Order](#domain-order)
  - [Patient](#domain-patient)
  - [Pharmacy](#domain-pharmacy)
  - [Provider](#domain-provider)
  - [Quality](#domain-quality)
  - [Radiology](#domain-radiology)
  - [Reference](#domain-reference)
  - [Research](#domain-research)
  - [Scheduling](#domain-scheduling)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

healthcare industry enterprise data model.

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
| Domains | 12 | 22 |
| Subdomains | 29 | 80 |
| Products (Tables) | 121 | 542 |
| Attributes (Columns) | 5176 | 22180 |
| Foreign Keys | 1056 | 4048 |
| Avg Attributes/Product | 42.8 | 40.9 |

## Domain & Product Comparison

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| charge_capture | cdm_entry | ✅ | ✅ |  |
| charge_capture | charge | ✅ | ✅ |  |
| charge_capture | coding_assignment | ✅ | ✅ |  |
| charge_capture | site_cdm_pricing | ✅ | ❌ | Excluded from MVM |
| charge_capture | study_service_coverage | ✅ | ❌ | Excluded from MVM |
| claims_invoicing | billing_coverage | ✅ | ✅ |  |
| claims_invoicing | billing_network_participation | ✅ | ❌ | Excluded from MVM |
| claims_invoicing | invoice | ✅ | ✅ |  |
| claims_invoicing | invoice_coverage_billing | ✅ | ❌ | Excluded from MVM |
| claims_invoicing | invoice_line | ✅ | ✅ |  |
| claims_invoicing | invoice_material_line | ✅ | ❌ | Excluded from MVM |
| patient_collections | charity_care_application | ✅ | ❌ | Excluded from MVM |
| patient_collections | collection_account | ✅ | ❌ | Excluded from MVM |
| patient_collections | patient_account | ✅ | ✅ |  |
| patient_collections | payment_plan | ✅ | ❌ | Excluded from MVM |
| patient_collections | statement | ✅ | ✅ |  |
| payment_reconciliation | adjustment | ✅ | ✅ |  |
| payment_reconciliation | payment | ✅ | ✅ |  |
| payment_reconciliation | rac_audit | ✅ | ❌ | Excluded from MVM |
| payment_reconciliation | refund | ✅ | ❌ | Excluded from MVM |
| payment_reconciliation | write_off | ✅ | ❌ | Excluded from MVM |

<a id="domain-claim"></a>
### claim

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_eligibility | authorization_service | ✅ | ❌ | Excluded from MVM |
| authorization_eligibility | cob | ✅ | ❌ | Excluded from MVM |
| authorization_eligibility | eligibility | ✅ | ✅ |  |
| authorization_eligibility | prior_authorization | ✅ | ✅ |  |
| claim_processing | claim_status_history | ❌ | ✅ | MVM only (stub or new) |
| claim_processing | line | ❌ | ✅ | MVM only (stub or new) |
| claim_submission | claim | ✅ | ✅ |  |
| claim_submission | claim_attachment | ✅ | ❌ | Excluded from MVM |
| claim_submission | claim_line | ✅ | ❌ | Excluded from MVM |
| claim_submission | diagnosis_link | ✅ | ✅ |  |
| claim_submission | status_history | ✅ | ❌ | Excluded from MVM |
| claim_submission | submission | ✅ | ✅ |  |
| compliance_attribution | audit_sample | ✅ | ❌ | Excluded from MVM |
| compliance_attribution | study_attribution | ✅ | ❌ | Excluded from MVM |
| dispute_resolution | appeal | ❌ | ✅ | MVM only (stub or new) |
| dispute_resolution | denial | ❌ | ✅ | MVM only (stub or new) |
| payment_adjudication | claim_appeal | ✅ | ❌ | Excluded from MVM |
| payment_adjudication | claim_denial | ✅ | ❌ | Excluded from MVM |
| payment_adjudication | remittance | ✅ | ✅ |  |
| payment_adjudication | remittance_line | ✅ | ✅ |  |

<a id="domain-clinical"></a>
### clinical

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| care_coordination | advance_directive | ✅ | ✅ |  |
| care_coordination | care_plan | ✅ | ✅ |  |
| care_coordination | care_plan_goal | ✅ | ❌ | Excluded from MVM |
| care_coordination | care_team | ✅ | ✅ |  |
| care_coordination | care_team_member | ✅ | ✅ |  |
| care_coordination | plan_care_coordination | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | cdi_query | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | cdi_worksheet | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | clinical_finding | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | diagnosis | ✅ | ✅ |  |
| clinical_documentation | note | ✅ | ✅ |  |
| clinical_documentation | note_template | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | observation | ✅ | ✅ |  |
| clinical_documentation | problem | ✅ | ✅ |  |
| clinical_documentation | procedure_event | ✅ | ✅ |  |
| infection_surveillance | hai_event | ✅ | ❌ | Excluded from MVM |
| infection_surveillance | outbreak | ✅ | ❌ | Excluded from MVM |
| infection_surveillance | procedure_equipment_usage | ✅ | ❌ | Excluded from MVM |
| patient_assessment | allergy | ✅ | ✅ |  |
| patient_assessment | flowsheet_row | ✅ | ❌ | Excluded from MVM |
| patient_assessment | flowsheet_template | ✅ | ❌ | Excluded from MVM |
| patient_assessment | functional_status | ✅ | ❌ | Excluded from MVM |
| patient_assessment | immunization | ✅ | ✅ |  |
| patient_assessment | nursing_assessment | ✅ | ❌ | Excluded from MVM |
| patient_assessment | vital_sign | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_investigation | audit | ✅ | ❌ | Domain not in MVM |
| audit_investigation | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_investigation | corrective_action_plan | ✅ | ❌ | Domain not in MVM |
| audit_investigation | hotline_report | ✅ | ❌ | Domain not in MVM |
| audit_investigation | investigation | ✅ | ❌ | Domain not in MVM |
| audit_investigation | monitoring_activity | ✅ | ❌ | Domain not in MVM |
| governance_policy | compliance_policy | ✅ | ❌ | Domain not in MVM |
| governance_policy | compliance_program | ✅ | ❌ | Domain not in MVM |
| governance_policy | policy_payer_applicability | ✅ | ❌ | Domain not in MVM |
| governance_policy | policy_regulatory_impact | ✅ | ❌ | Domain not in MVM |
| governance_policy | policy_version | ✅ | ❌ | Domain not in MVM |
| governance_policy | program_policy_assignment | ✅ | ❌ | Domain not in MVM |
| privacy_safety | business_associate_agreement | ✅ | ❌ | Domain not in MVM |
| privacy_safety | hipaa_privacy_incident | ✅ | ❌ | Domain not in MVM |
| privacy_safety | hipaa_security_risk | ✅ | ❌ | Domain not in MVM |
| privacy_safety | notice_of_privacy_practices | ✅ | ❌ | Domain not in MVM |
| privacy_safety | osha_exposure_incident | ✅ | ❌ | Domain not in MVM |
| privacy_safety | osha_safety_program | ✅ | ❌ | Domain not in MVM |
| privacy_safety | phi_access_log | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | accreditation_status | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | cms_condition_status | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | compliance_regulatory_submission | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | stark_arrangement | ✅ | ❌ | Domain not in MVM |
| training_attestation | attestation | ✅ | ❌ | Domain not in MVM |
| training_attestation | conflict_of_interest | ✅ | ❌ | Domain not in MVM |
| training_attestation | exclusion_screening | ✅ | ❌ | Domain not in MVM |
| training_attestation | training | ✅ | ❌ | Domain not in MVM |
| training_attestation | training_completion | ✅ | ❌ | Domain not in MVM |

<a id="domain-consent"></a>
### consent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_oversight | capacity_assessment | ✅ | ❌ | Domain not in MVM |
| compliance_oversight | consent_exception | ✅ | ❌ | Domain not in MVM |
| compliance_oversight | consent_verification | ✅ | ❌ | Domain not in MVM |
| compliance_oversight | deficiency | ✅ | ❌ | Domain not in MVM |
| consent_authoring | consent_policy | ✅ | ❌ | Domain not in MVM |
| consent_authoring | consent_session | ✅ | ❌ | Domain not in MVM |
| consent_authoring | consent_translation | ✅ | ❌ | Domain not in MVM |
| consent_authoring | form_template | ✅ | ❌ | Domain not in MVM |
| consent_authoring | workflow | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | amendment_request | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | consent_event | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | disclosure_log | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | expiration_alert | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | npp_acknowledgment | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | restriction_request | ✅ | ❌ | Domain not in MVM |
| lifecycle_tracking | revocation | ✅ | ❌ | Domain not in MVM |
| patient_authorization | behavioral_health_consent | ✅ | ❌ | Domain not in MVM |
| patient_authorization | consent_record | ✅ | ❌ | Domain not in MVM |
| patient_authorization | delegation | ✅ | ❌ | Domain not in MVM |
| patient_authorization | genetic_testing_consent | ✅ | ❌ | Domain not in MVM |
| patient_authorization | hie_directive | ✅ | ❌ | Domain not in MVM |
| patient_authorization | hipaa_authorization | ✅ | ❌ | Domain not in MVM |
| patient_authorization | minor_consent | ✅ | ❌ | Domain not in MVM |
| patient_authorization | photography_media_consent | ✅ | ❌ | Domain not in MVM |
| patient_authorization | research_consent | ✅ | ❌ | Domain not in MVM |
| patient_authorization | substance_use_consent | ✅ | ❌ | Domain not in MVM |
| patient_authorization | telehealth_consent | ✅ | ❌ | Domain not in MVM |
| patient_authorization | treatment_consent | ✅ | ❌ | Domain not in MVM |

<a id="domain-encounter"></a>
### encounter

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_documentation | discharge_summary | ✅ | ✅ |  |
| clinical_documentation | drg_assignment | ✅ | ✅ |  |
| clinical_documentation | triage_assessment | ✅ | ✅ |  |
| clinical_documentation | visit_diagnosis | ✅ | ✅ |  |
| clinical_documentation | visit_procedure | ✅ | ✅ |  |
| encounter_management | visit | ✅ | ✅ |  |
| encounter_management | visit_provider | ✅ | ✅ |  |
| encounter_management | visit_recall_impact | ✅ | ❌ | Excluded from MVM |
| encounter_management | visit_status_history | ✅ | ❌ | Excluded from MVM |
| financial_coverage | encounter_authorization | ✅ | ❌ | Excluded from MVM |
| financial_coverage | visit_coverage | ✅ | ❌ | Excluded from MVM |
| financial_coverage | visit_insurance | ✅ | ✅ |  |
| patient_flow | adt_event | ✅ | ✅ |  |
| patient_flow | bed_assignment | ✅ | ✅ |  |
| patient_flow | readmission | ✅ | ❌ | Excluded from MVM |
| patient_flow | transfer_request | ✅ | ❌ | Excluded from MVM |

<a id="domain-facility"></a>
### facility

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_maintenance | environmental_service_request | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | equipment_asset | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | equipment_authorization | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | hazardous_material | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | maintenance_order | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | pm_schedule | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | bed | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | bed_status_event | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | block_assignment | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | building | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | capacity_snapshot | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | care_site | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | or_suite | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | organization | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | room | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | site_hierarchy | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | space_allocation | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | unit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | facility_inspection | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | inspection_finding | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | license_accreditation | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | safety_incident | ✅ | ❌ | Domain not in MVM |
| service_contracting | facility_contract | ✅ | ❌ | Domain not in MVM |
| service_contracting | facility_program_participation | ✅ | ❌ | Domain not in MVM |
| service_contracting | facility_service | ✅ | ❌ | Domain not in MVM |
| service_contracting | network_contract | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | allocation_method | ✅ | ❌ | Domain not in MVM |
| budget_planning | allocation_run | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_transfer | ✅ | ❌ | Domain not in MVM |
| budget_planning | capital_expenditure | ✅ | ❌ | Domain not in MVM |
| budget_planning | capital_project | ✅ | ❌ | Domain not in MVM |
| budget_planning | cost_allocation | ✅ | ❌ | Domain not in MVM |
| budget_planning | cost_center | ✅ | ❌ | Domain not in MVM |
| budget_planning | financial_forecast | ✅ | ❌ | Domain not in MVM |
| budget_planning | forecast_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| general_ledger | financial_entity | ✅ | ❌ | Domain not in MVM |
| general_ledger | financial_period_close | ✅ | ❌ | Domain not in MVM |
| general_ledger | fiscal_period | ✅ | ❌ | Domain not in MVM |
| general_ledger | fund | ✅ | ❌ | Domain not in MVM |
| general_ledger | fund_allocation | ✅ | ❌ | Domain not in MVM |
| general_ledger | general_ledger | ✅ | ❌ | Domain not in MVM |
| general_ledger | intercompany_agreement | ✅ | ❌ | Domain not in MVM |
| general_ledger | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | transaction_batch | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice_line | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_account | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_transaction | ✅ | ❌ | Domain not in MVM |
| payables_receivables | invoice_payment_application | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_batch | ✅ | ❌ | Domain not in MVM |
| treasury_assets | asset_book | ✅ | ❌ | Domain not in MVM |
| treasury_assets | bank_account | ✅ | ❌ | Domain not in MVM |
| treasury_assets | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| treasury_assets | depreciation_run | ✅ | ❌ | Domain not in MVM |
| treasury_assets | depreciation_schedule | ✅ | ❌ | Domain not in MVM |
| treasury_assets | donor | ✅ | ❌ | Domain not in MVM |
| treasury_assets | fixed_asset | ✅ | ❌ | Domain not in MVM |
| treasury_assets | recurring_schedule | ✅ | ❌ | Domain not in MVM |

<a id="domain-insurance"></a>
### insurance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| member_enrollment | dependent | ✅ | ❌ | Domain not in MVM |
| member_enrollment | eligibility_span | ✅ | ❌ | Domain not in MVM |
| member_enrollment | employer_group | ✅ | ❌ | Domain not in MVM |
| member_enrollment | member_enrollment | ✅ | ❌ | Domain not in MVM |
| member_enrollment | premium_billing | ✅ | ❌ | Domain not in MVM |
| member_enrollment | subscriber | ✅ | ❌ | Domain not in MVM |
| network_contracting | fee_schedule | ✅ | ❌ | Domain not in MVM |
| network_contracting | fee_schedule_line | ✅ | ❌ | Domain not in MVM |
| network_contracting | insurance_network_participation | ✅ | ❌ | Domain not in MVM |
| network_contracting | insurance_payer_enrollment | ✅ | ❌ | Domain not in MVM |
| network_contracting | network_adequacy | ✅ | ❌ | Domain not in MVM |
| network_contracting | payer_contract | ✅ | ❌ | Domain not in MVM |
| network_contracting | plan_network | ✅ | ❌ | Domain not in MVM |
| network_contracting | provider_network | ✅ | ❌ | Domain not in MVM |
| payer_management | broker | ✅ | ❌ | Domain not in MVM |
| payer_management | payer | ✅ | ❌ | Domain not in MVM |
| payer_management | payer_compliance_requirement | ✅ | ❌ | Domain not in MVM |
| payer_management | payer_contact | ✅ | ❌ | Domain not in MVM |
| payer_management | third_party_administrator | ✅ | ❌ | Domain not in MVM |
| plan_design | benefit | ✅ | ❌ | Domain not in MVM |
| plan_design | coverage_policy | ✅ | ❌ | Domain not in MVM |
| plan_design | formulary_tier | ✅ | ❌ | Domain not in MVM |
| plan_design | health_plan | ✅ | ❌ | Domain not in MVM |
| plan_design | plan_consent_requirement | ✅ | ❌ | Domain not in MVM |
| utilization_adjudication | accumulator | ✅ | ❌ | Domain not in MVM |
| utilization_adjudication | coordination_of_benefits | ✅ | ❌ | Domain not in MVM |
| utilization_adjudication | prior_auth_rule | ✅ | ❌ | Domain not in MVM |
| utilization_adjudication | utilization_review | ✅ | ❌ | Domain not in MVM |
| value_care | accountable_care_organization | ✅ | ❌ | Domain not in MVM |
| value_care | capitation_contract | ✅ | ❌ | Domain not in MVM |
| value_care | capitation_payment | ✅ | ❌ | Domain not in MVM |
| value_care | member_attribution | ✅ | ❌ | Domain not in MVM |
| value_care | risk_adjustment | ✅ | ❌ | Domain not in MVM |
| value_care | vbc_performance | ✅ | ❌ | Domain not in MVM |

<a id="domain-interoperability"></a>
### interoperability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| health_exchange | data_sharing_agreement | ✅ | ❌ | Domain not in MVM |
| health_exchange | data_use_agreement | ✅ | ❌ | Domain not in MVM |
| health_exchange | hie_organization | ✅ | ❌ | Domain not in MVM |
| health_exchange | hie_participation | ✅ | ❌ | Domain not in MVM |
| health_exchange | hie_query | ✅ | ❌ | Domain not in MVM |
| health_exchange | hie_transaction | ✅ | ❌ | Domain not in MVM |
| health_exchange | patient_identity_match | ✅ | ❌ | Domain not in MVM |
| interface_integration | conformance_test | ✅ | ❌ | Domain not in MVM |
| interface_integration | exchange_standard | ✅ | ❌ | Domain not in MVM |
| interface_integration | interface_channel | ✅ | ❌ | Domain not in MVM |
| interface_integration | interface_downtime | ✅ | ❌ | Domain not in MVM |
| interface_integration | interface_engine | ✅ | ❌ | Domain not in MVM |
| interface_integration | interface_sla | ✅ | ❌ | Domain not in MVM |
| interface_integration | message_error | ✅ | ❌ | Domain not in MVM |
| interface_integration | message_log | ✅ | ❌ | Domain not in MVM |
| interface_integration | onboarding_project | ✅ | ❌ | Domain not in MVM |
| interface_integration | trading_partner | ✅ | ❌ | Domain not in MVM |
| public_reporting | care_transition_notification | ✅ | ❌ | Domain not in MVM |
| public_reporting | direct_address | ✅ | ❌ | Domain not in MVM |
| public_reporting | direct_message | ✅ | ❌ | Domain not in MVM |
| public_reporting | promoting_interoperability | ✅ | ❌ | Domain not in MVM |
| public_reporting | public_health_report | ✅ | ❌ | Domain not in MVM |
| standards_terminology | cda_document | ✅ | ❌ | Domain not in MVM |
| standards_terminology | cda_validation_result | ✅ | ❌ | Domain not in MVM |
| standards_terminology | fhir_endpoint | ✅ | ❌ | Domain not in MVM |
| standards_terminology | fhir_resource_log | ✅ | ❌ | Domain not in MVM |
| standards_terminology | mapping_definition | ✅ | ❌ | Domain not in MVM |
| standards_terminology | mapping_rule | ✅ | ❌ | Domain not in MVM |
| standards_terminology | subscription_notification | ✅ | ❌ | Domain not in MVM |
| standards_terminology | subscription_topic | ✅ | ❌ | Domain not in MVM |
| standards_terminology | terminology_mapping | ✅ | ❌ | Domain not in MVM |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| diagnostic_testing | lab_order | ✅ | ✅ |  |
| diagnostic_testing | point_of_care_test | ✅ | ❌ | Excluded from MVM |
| diagnostic_testing | reference_range | ✅ | ✅ |  |
| diagnostic_testing | test_catalog | ✅ | ✅ |  |
| diagnostic_testing | test_result | ✅ | ✅ |  |
| laboratory_operations | clia_certificate | ✅ | ❌ | Excluded from MVM |
| laboratory_operations | instrument | ✅ | ❌ | Excluded from MVM |
| laboratory_operations | instrument_policy_compliance | ✅ | ❌ | Excluded from MVM |
| laboratory_operations | qc_run | ✅ | ❌ | Excluded from MVM |
| laboratory_operations | reagent_lot | ✅ | ❌ | Excluded from MVM |
| revenue_reimbursement | lab_charge | ✅ | ❌ | Excluded from MVM |
| revenue_reimbursement | lab_fee_schedule_line | ✅ | ❌ | Excluded from MVM |
| revenue_reimbursement | study_test_requirement | ✅ | ❌ | Excluded from MVM |
| revenue_reimbursement | test_coverage_policy | ✅ | ❌ | Excluded from MVM |
| specialized_diagnostics | blood_bank_unit | ✅ | ✅ |  |
| specialized_diagnostics | microbiology_culture | ✅ | ✅ |  |
| specialized_diagnostics | molecular_test | ✅ | ❌ | Excluded from MVM |
| specialized_diagnostics | pathology_report | ✅ | ✅ |  |
| specialized_diagnostics | susceptibility_result | ✅ | ❌ | Excluded from MVM |
| specialized_diagnostics | transfusion_event | ✅ | ✅ |  |
| specimen_management | organism | ✅ | ❌ | Excluded from MVM |
| specimen_management | specimen | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| decision_support | alert_rule | ✅ | ❌ | Excluded from MVM |
| decision_support | cpoe_alert | ✅ | ❌ | Excluded from MVM |
| decision_support | routing_rule | ✅ | ❌ | Excluded from MVM |
| fulfillment_processing | fulfillment | ✅ | ✅ |  |
| fulfillment_processing | order_authorization | ✅ | ❌ | Excluded from MVM |
| fulfillment_processing | order_routing | ✅ | ❌ | Excluded from MVM |
| fulfillment_processing | order_status_history | ✅ | ✅ |  |
| fulfillment_processing | reconciliation | ✅ | ❌ | Excluded from MVM |
| order_management | clinical_order | ✅ | ✅ |  |
| order_management | diet_order | ✅ | ✅ |  |
| order_management | order_set | ✅ | ❌ | Excluded from MVM |
| order_management | referral_order | ✅ | ✅ |  |
| order_management | set_item | ✅ | ✅ |  |
| order_management | standing_order | ✅ | ✅ |  |
| order_management | therapy_order | ✅ | ✅ |  |
| order_management | verbal_order | ✅ | ❌ | Excluded from MVM |
| protocol_configuration | set | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-patient"></a>
### patient

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_communication | communication_campaign | ✅ | ❌ | Excluded from MVM |
| engagement_communication | communication_log | ✅ | ❌ | Excluded from MVM |
| engagement_communication | consent_reference | ✅ | ✅ |  |
| engagement_communication | message_template | ✅ | ❌ | Excluded from MVM |
| engagement_communication | portal_account | ✅ | ✅ |  |
| engagement_communication | preference | ✅ | ❌ | Excluded from MVM |
| engagement_communication | proxy_access | ✅ | ❌ | Excluded from MVM |
| financial_coverage | eligibility_check | ✅ | ✅ |  |
| financial_coverage | financial_assistance | ✅ | ❌ | Excluded from MVM |
| financial_coverage | guarantor | ✅ | ✅ |  |
| financial_coverage | insurance_coverage | ✅ | ✅ |  |
| financial_coverage | patient_coverage | ✅ | ✅ |  |
| identity_management | address | ✅ | ✅ |  |
| identity_management | demographics | ✅ | ✅ |  |
| identity_management | emergency_contact | ✅ | ✅ |  |
| identity_management | flag | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_merge_history | ✅ | ❌ | Excluded from MVM |
| identity_management | mpi_record | ✅ | ✅ |  |
| identity_management | mrn_crosswalk | ✅ | ❌ | Excluded from MVM |
| identity_management | registration_event | ✅ | ✅ |  |
| population_health | attribution_panel | ✅ | ❌ | Excluded from MVM |
| population_health | care_program | ✅ | ❌ | Excluded from MVM |
| population_health | care_program_enrollment | ✅ | ❌ | Excluded from MVM |
| population_health | pcp_attribution | ✅ | ✅ |  |
| population_health | population_segment | ✅ | ❌ | Excluded from MVM |
| population_health | program_enrollment | ✅ | ❌ | Excluded from MVM |
| population_health | quality_measure_evaluation | ✅ | ❌ | Excluded from MVM |
| population_health | sdoh_assessment | ✅ | ❌ | Excluded from MVM |

<a id="domain-pharmacy"></a>
### pharmacy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefit_reimbursement | medication_pa_request | ✅ | ❌ | Excluded from MVM |
| benefit_reimbursement | pharmacy_network_participation | ✅ | ❌ | Excluded from MVM |
| benefit_reimbursement | rx_claim | ✅ | ✅ |  |
| clinical_safety | adverse_drug_event | ✅ | ✅ |  |
| clinical_safety | drug_recall | ✅ | ❌ | Excluded from MVM |
| clinical_safety | medication_review | ✅ | ❌ | Excluded from MVM |
| clinical_safety | medication_therapy_mgmt | ✅ | ❌ | Excluded from MVM |
| clinical_safety | rems_compliance | ✅ | ❌ | Excluded from MVM |
| dispensing_operations | controlled_substance_log | ✅ | ✅ |  |
| dispensing_operations | dispense_event | ✅ | ✅ |  |
| dispensing_operations | mar_record | ✅ | ✅ |  |
| dispensing_operations | prescription | ✅ | ✅ |  |
| formulary_management | compounding_record | ✅ | ❌ | Excluded from MVM |
| formulary_management | drug_master | ✅ | ✅ |  |
| formulary_management | formulary | ✅ | ✅ |  |
| formulary_management | inventory | ✅ | ✅ |  |
| formulary_management | pharmacy_location | ✅ | ❌ | Excluded from MVM |
| formulary_management | study_drug_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-provider"></a>
### provider

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credential_management | payer_enrollment | ❌ | ✅ | MVM only (stub or new) |
| credentialing_compliance | board_certification | ✅ | ✅ |  |
| credentialing_compliance | cme_activity | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | credentialing_application | ✅ | ✅ |  |
| credentialing_compliance | credentialing_file | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | dea_registration | ✅ | ✅ |  |
| credentialing_compliance | education_training | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | malpractice_coverage | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | npdb_query | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | peer_reference | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | privileging | ✅ | ✅ |  |
| credentialing_compliance | provider_committee | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | provider_credential | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | provider_sanction | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | reappointment | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | study_team_member | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | survey_participation | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | telehealth_authorization | ✅ | ❌ | Excluded from MVM |
| network_contracting | network_affiliation | ✅ | ❌ | Excluded from MVM |
| network_contracting | provider_network_participation | ✅ | ❌ | Excluded from MVM |
| network_contracting | provider_payer_enrollment | ✅ | ❌ | Excluded from MVM |
| professional_registry | location | ❌ | ✅ | MVM only (stub or new) |
| provider_directory | affiliation | ✅ | ❌ | Excluded from MVM |
| provider_directory | affiliation_history | ✅ | ❌ | Excluded from MVM |
| provider_directory | clinician | ✅ | ✅ |  |
| provider_directory | group | ✅ | ✅ |  |
| provider_directory | group_membership | ✅ | ✅ |  |
| provider_directory | org_provider | ✅ | ✅ |  |
| provider_directory | preference_card | ✅ | ❌ | Excluded from MVM |
| provider_directory | provider_assignment | ✅ | ❌ | Excluded from MVM |
| provider_directory | provider_location | ✅ | ❌ | Excluded from MVM |
| provider_directory | specialty | ✅ | ✅ |  |
| provider_directory | taxonomy | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | committee | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | accreditation_program | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | accreditation_survey | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | cdi_review | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | contract_initiative | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | corrective_action | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | improvement_initiative | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | initiative_measure_target | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | quality_committee | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | standard_finding | ✅ | ❌ | Domain not in MVM |
| measure_performance | hedis_measure | ✅ | ❌ | Domain not in MVM |
| measure_performance | hedis_result | ✅ | ❌ | Domain not in MVM |
| measure_performance | measure | ✅ | ❌ | Domain not in MVM |
| measure_performance | measure_budget_allocation | ✅ | ❌ | Domain not in MVM |
| measure_performance | measure_result | ✅ | ❌ | Domain not in MVM |
| measure_performance | program_measure_assignment | ✅ | ❌ | Domain not in MVM |
| measure_performance | program_study_participation | ✅ | ❌ | Domain not in MVM |
| measure_performance | quality_program | ✅ | ❌ | Domain not in MVM |
| measure_performance | quality_program_participation | ✅ | ❌ | Domain not in MVM |
| measure_performance | vbp_program | ✅ | ❌ | Domain not in MVM |
| patient_safety | cahps_response | ✅ | ❌ | Domain not in MVM |
| patient_safety | cahps_survey | ✅ | ❌ | Domain not in MVM |
| patient_safety | mortality_review | ✅ | ❌ | Domain not in MVM |
| patient_safety | patient_safety_event | ✅ | ❌ | Domain not in MVM |
| patient_safety | population_health_gap | ✅ | ❌ | Domain not in MVM |
| patient_safety | quality_peer_review | ✅ | ❌ | Domain not in MVM |
| patient_safety | safety_event_review | ✅ | ❌ | Domain not in MVM |
| patient_safety | sdoh_screening | ✅ | ❌ | Domain not in MVM |

<a id="domain-radiology"></a>
### radiology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_reporting | critical_result | ✅ | ✅ |  |
| clinical_reporting | follow_up | ✅ | ❌ | Excluded from MVM |
| clinical_reporting | radiology_finding | ✅ | ❌ | Excluded from MVM |
| clinical_reporting | radiology_order_status_history | ✅ | ❌ | Excluded from MVM |
| clinical_reporting | radiology_peer_review | ✅ | ❌ | Excluded from MVM |
| clinical_reporting | reader_assignment | ✅ | ❌ | Excluded from MVM |
| clinical_reporting | report | ✅ | ✅ |  |
| clinical_reporting | report_addendum | ✅ | ❌ | Excluded from MVM |
| clinical_reporting | teleradiology_case | ✅ | ❌ | Excluded from MVM |
| diagnostic_imaging | study | ❌ | ✅ | MVM only (stub or new) |
| external_exchange | network_modality_participation | ✅ | ❌ | Excluded from MVM |
| external_exchange | report_distribution | ✅ | ❌ | Excluded from MVM |
| external_exchange | transmission | ✅ | ❌ | Excluded from MVM |
| imaging_operations | contrast_admin | ✅ | ✅ |  |
| imaging_operations | dicom_series | ✅ | ✅ |  |
| imaging_operations | dose_record | ✅ | ❌ | Excluded from MVM |
| imaging_operations | imaging_order | ✅ | ✅ |  |
| imaging_operations | interventional_procedure | ✅ | ❌ | Excluded from MVM |
| imaging_operations | modality | ✅ | ✅ |  |
| imaging_operations | protocol | ✅ | ✅ |  |
| imaging_operations | radiology_appointment | ✅ | ✅ |  |
| imaging_operations | radiology_study | ✅ | ❌ | Excluded from MVM |

<a id="domain-reference"></a>
### reference

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_terminology | cpt_code | ✅ | ✅ |  |
| clinical_terminology | drg | ✅ | ✅ |  |
| clinical_terminology | hcpcs_code | ✅ | ✅ |  |
| clinical_terminology | icd_code | ✅ | ✅ |  |
| clinical_terminology | loinc_code | ✅ | ✅ |  |
| clinical_terminology | major_diagnostic_category | ✅ | ❌ | Excluded from MVM |
| clinical_terminology | ndc_drug | ✅ | ✅ |  |
| clinical_terminology | snomed_concept | ✅ | ✅ |  |
| reference_governance | code_set_version | ✅ | ✅ |  |
| reference_governance | condition_code | ✅ | ❌ | Excluded from MVM |
| reference_governance | crosswalk | ✅ | ✅ |  |
| reference_governance | fhir_value_set | ✅ | ❌ | Excluded from MVM |
| reference_governance | geographic_region | ✅ | ❌ | Excluded from MVM |
| reference_governance | npi_registry | ✅ | ❌ | Excluded from MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_data | billing_event | ✅ | ❌ | Domain not in MVM |
| financial_data | coverage_analysis | ✅ | ❌ | Domain not in MVM |
| financial_data | data_access_request | ✅ | ❌ | Domain not in MVM |
| financial_data | deidentified_dataset | ✅ | ❌ | Domain not in MVM |
| financial_data | grant_expenditure | ✅ | ❌ | Domain not in MVM |
| financial_data | grant_personnel | ✅ | ❌ | Domain not in MVM |
| financial_data | research_grant | ✅ | ❌ | Domain not in MVM |
| financial_data | study_budget | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | consent_template | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | data_safety_monitoring | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | dua_document | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | informed_consent | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | irb_submission | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | monitoring_visit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | protocol_amendment | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | protocol_deviation | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | research_document | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | research_regulatory_submission | ✅ | ❌ | Domain not in MVM |
| study_management | data_governance_committee | ✅ | ❌ | Domain not in MVM |
| study_management | dsmb_committee | ✅ | ❌ | Domain not in MVM |
| study_management | research_study | ✅ | ❌ | Domain not in MVM |
| study_management | study_arm | ✅ | ❌ | Domain not in MVM |
| study_management | study_partner_agreement | ✅ | ❌ | Domain not in MVM |
| study_management | study_site | ✅ | ❌ | Domain not in MVM |
| study_management | study_sponsor | ✅ | ❌ | Domain not in MVM |
| subject_conduct | adverse_event | ✅ | ❌ | Domain not in MVM |
| subject_conduct | biospecimen | ✅ | ❌ | Domain not in MVM |
| subject_conduct | investigational_product | ✅ | ❌ | Domain not in MVM |
| subject_conduct | investigational_product_training | ✅ | ❌ | Domain not in MVM |
| subject_conduct | ip_dispensation | ✅ | ❌ | Domain not in MVM |
| subject_conduct | study_visit | ✅ | ❌ | Domain not in MVM |
| subject_conduct | subject_enrollment | ✅ | ❌ | Domain not in MVM |

<a id="domain-scheduling"></a>
### scheduling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| appointment_booking | appointment_prior_auth_requirement | ✅ | ❌ | Excluded from MVM |
| appointment_booking | appointment_reminder | ✅ | ❌ | Excluded from MVM |
| appointment_booking | appointment_status_history | ✅ | ❌ | Excluded from MVM |
| appointment_booking | appointment_type | ✅ | ✅ |  |
| appointment_booking | booking_queue | ✅ | ❌ | Excluded from MVM |
| appointment_booking | recall_list | ✅ | ❌ | Excluded from MVM |
| appointment_booking | reminder_template | ✅ | ❌ | Excluded from MVM |
| appointment_booking | scheduling_appointment | ✅ | ✅ |  |
| appointment_booking | telehealth_session | ✅ | ❌ | Excluded from MVM |
| appointment_booking | waitlist_entry | ✅ | ✅ |  |
| resource_capacity | booking_rule | ✅ | ❌ | Excluded from MVM |
| resource_capacity | capacity_utilization | ✅ | ❌ | Excluded from MVM |
| resource_capacity | open_slot | ✅ | ✅ |  |
| resource_capacity | patient_preference | ✅ | ❌ | Excluded from MVM |
| resource_capacity | provider_availability | ✅ | ✅ |  |
| resource_capacity | resource_assignment | ✅ | ❌ | Excluded from MVM |
| resource_capacity | schedulable_resource | ✅ | ✅ |  |
| resource_capacity | schedule_template | ✅ | ✅ |  |
| surgical_operations | surgical_resource_assignment | ❌ | ✅ | MVM only (stub or new) |
| surgical_scheduling | block_utilization | ✅ | ❌ | Excluded from MVM |
| surgical_scheduling | case_material_usage | ✅ | ❌ | Excluded from MVM |
| surgical_scheduling | equipment_reservation | ✅ | ❌ | Excluded from MVM |
| surgical_scheduling | or_block | ✅ | ✅ |  |
| surgical_scheduling | surgical_case | ✅ | ✅ |  |
| surgical_scheduling | surgical_case_team | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_supply | case_cart | ✅ | ❌ | Domain not in MVM |
| clinical_supply | sterile_processing_record | ✅ | ❌ | Domain not in MVM |
| clinical_supply | surgical_bom | ✅ | ❌ | Domain not in MVM |
| clinical_supply | udi_record | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_balance | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_location | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_transaction | ✅ | ❌ | Domain not in MVM |
| inventory_management | material_master | ✅ | ❌ | Domain not in MVM |
| inventory_management | requisition | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | goods_receipt | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | purchase_order_line | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | vendor | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | vendor_contract | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | vendor_site | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | location_audit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | material_policy_governance | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | recall_notice | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefits_wellbeing | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| benefits_wellbeing | benefit_plan | ✅ | ❌ | Domain not in MVM |
| benefits_wellbeing | leave_request | ✅ | ❌ | Domain not in MVM |
| benefits_wellbeing | osha_incident | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | applicant | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | channel_support_assignment | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | clinical_privilege | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | competency_assessment | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | education_program | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | employment_competency | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | recruitment | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | review_template | ✅ | ❌ | Domain not in MVM |
| talent_credentialing | workforce_provider_network_participation | ✅ | ❌ | Domain not in MVM |
| time_payroll | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| time_payroll | payroll_run | ✅ | ❌ | Domain not in MVM |
| time_payroll | shift_schedule | ✅ | ❌ | Domain not in MVM |
| time_payroll | time_attendance | ✅ | ❌ | Domain not in MVM |
| workforce_administration | employee | ✅ | ❌ | Domain not in MVM |
| workforce_administration | fte_budget | ✅ | ❌ | Domain not in MVM |
| workforce_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| workforce_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_administration | position | ✅ | ❌ | Domain not in MVM |
| workforce_administration | position_procedure_authorization | ✅ | ❌ | Domain not in MVM |
