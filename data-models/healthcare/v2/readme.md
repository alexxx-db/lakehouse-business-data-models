# Healthcare Lakehouse Data Models

**Version 2** | Generated on July 02, 2026 at 08:58 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Behavioral_health](#domain-behavioral_health)
  - [Billing](#domain-billing)
  - [Claim](#domain-claim)
  - [Clinical](#domain-clinical)
  - [Clinical_ai](#domain-clinical_ai)
  - [Compliance](#domain-compliance)
  - [Consent](#domain-consent)
  - [Digital_health](#domain-digital_health)
  - [Encounter](#domain-encounter)
  - [Facility](#domain-facility)
  - [Finance](#domain-finance)
  - [Genomics](#domain-genomics)
  - [Insurance](#domain-insurance)
  - [Interoperability](#domain-interoperability)
  - [Laboratory](#domain-laboratory)
  - [Order](#domain-order)
  - [Patient](#domain-patient)
  - [Pharmacy](#domain-pharmacy)
  - [Population_health](#domain-population_health)
  - [Post_acute](#domain-post_acute)
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
| Domains | 12 | 28 |
| Subdomains | 28 | 96 |
| Products (Tables) | 119 | 588 |
| Attributes (Columns) | 5573 | 26071 |
| Foreign Keys | 813 | 4073 |
| Avg Attributes/Product | 46.8 | 44.3 |

## Domain & Product Comparison

<a id="domain-behavioral_health"></a>
### behavioral_health

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_treatment | crisis_episode | ✅ | ❌ | Domain not in MVM |
| clinical_treatment | mat_treatment | ✅ | ❌ | Domain not in MVM |
| clinical_treatment | psychiatric_assessment | ✅ | ❌ | Domain not in MVM |
| clinical_treatment | sud_episode | ✅ | ❌ | Domain not in MVM |
| program_consent | otp_enrollment | ✅ | ❌ | Domain not in MVM |
| program_consent | part2_consent | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_collections | charity_care_application | ✅ | ❌ | Excluded from MVM |
| account_collections | collection_account | ✅ | ❌ | Excluded from MVM |
| account_collections | patient_account | ✅ | ✅ |  |
| charge_capture | cdm_entry | ✅ | ✅ |  |
| charge_capture | charge | ✅ | ✅ |  |
| charge_capture | coding_assignment | ✅ | ✅ |  |
| charge_capture | site_cdm_pricing | ✅ | ❌ | Excluded from MVM |
| invoice_billing | billing_coverage | ✅ | ❌ | Excluded from MVM |
| invoice_billing | billing_network_participation | ✅ | ❌ | Excluded from MVM |
| invoice_billing | invoice | ✅ | ✅ |  |
| invoice_billing | invoice_coverage_billing | ✅ | ❌ | Excluded from MVM |
| invoice_billing | invoice_line | ✅ | ❌ | Excluded from MVM |
| invoice_billing | invoice_line_item | ✅ | ❌ | Excluded from MVM |
| invoice_billing | statement | ✅ | ✅ |  |
| invoice_billing | study_service_coverage | ✅ | ❌ | Excluded from MVM |
| payment_reconciliation | adjustment | ✅ | ✅ |  |
| payment_reconciliation | payment | ✅ | ✅ |  |
| payment_reconciliation | payment_plan | ✅ | ✅ |  |
| payment_reconciliation | rac_audit | ✅ | ❌ | Excluded from MVM |
| payment_reconciliation | refund | ✅ | ❌ | Excluded from MVM |
| payment_reconciliation | write_off | ✅ | ❌ | Excluded from MVM |

<a id="domain-claim"></a>
### claim

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_eligibility | authorization_service | ✅ | ❌ | Excluded from MVM |
| authorization_eligibility | eligibility | ✅ | ✅ |  |
| authorization_eligibility | prior_authorization | ✅ | ✅ |  |
| claim_submission | attachment | ✅ | ❌ | Excluded from MVM |
| claim_submission | claim | ✅ | ✅ |  |
| claim_submission | diagnosis_link | ✅ | ✅ |  |
| claim_submission | line | ✅ | ✅ |  |
| claim_submission | status_history | ✅ | ❌ | Excluded from MVM |
| claim_submission | study_attribution | ✅ | ❌ | Excluded from MVM |
| claim_submission | submission | ✅ | ✅ |  |
| payment_reconciliation | appeal | ✅ | ✅ |  |
| payment_reconciliation | audit_sample | ✅ | ❌ | Excluded from MVM |
| payment_reconciliation | cob | ✅ | ✅ |  |
| payment_reconciliation | denial | ✅ | ✅ |  |
| payment_reconciliation | remittance | ✅ | ✅ |  |
| payment_reconciliation | remittance_line | ✅ | ✅ |  |

<a id="domain-clinical"></a>
### clinical

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| care_planning | advance_directive | ✅ | ✅ |  |
| care_planning | care_plan | ✅ | ✅ |  |
| care_planning | care_plan_goal | ✅ | ❌ | Excluded from MVM |
| care_planning | care_team | ✅ | ✅ |  |
| care_planning | care_team_member | ✅ | ✅ |  |
| care_planning | plan_care_coordination | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | cdi_query | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | cdi_worksheet | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | clinical_finding | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | diagnosis | ✅ | ✅ |  |
| clinical_documentation | note | ✅ | ✅ |  |
| clinical_documentation | note_template | ✅ | ❌ | Excluded from MVM |
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
| patient_assessment | observation | ✅ | ✅ |  |
| patient_assessment | problem | ✅ | ✅ |  |
| patient_assessment | vital_sign | ✅ | ✅ |  |

<a id="domain-clinical_ai"></a>
### clinical_ai

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| governance_compliance | bias_monitoring | ✅ | ❌ | Domain not in MVM |
| governance_compliance | model_card | ✅ | ❌ | Domain not in MVM |
| governance_compliance | samd_regulatory_tracking | ✅ | ❌ | Domain not in MVM |
| model_inference | care_gap | ✅ | ❌ | Domain not in MVM |
| model_inference | clinical_nlp_result | ✅ | ❌ | Domain not in MVM |
| model_inference | feature_store_entity | ✅ | ❌ | Domain not in MVM |
| model_inference | model_inference_log | ✅ | ❌ | Domain not in MVM |
| model_inference | patient_risk_score | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_monitoring | audit | ✅ | ❌ | Domain not in MVM |
| audit_monitoring | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_monitoring | compliance_regulatory_submission | ✅ | ❌ | Domain not in MVM |
| audit_monitoring | corrective_action_plan | ✅ | ❌ | Domain not in MVM |
| audit_monitoring | exclusion_screening | ✅ | ❌ | Domain not in MVM |
| audit_monitoring | monitoring_activity | ✅ | ❌ | Domain not in MVM |
| audit_monitoring | phi_access_log | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | accreditation_status | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | cms_condition_status | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | compliance_policy | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | compliance_program | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | policy_payer_applicability | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | policy_regulatory_impact | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | policy_version | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | program_policy_assignment | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| risk_investigation | conflict_of_interest | ✅ | ❌ | Domain not in MVM |
| risk_investigation | hipaa_privacy_incident | ✅ | ❌ | Domain not in MVM |
| risk_investigation | hipaa_security_risk | ✅ | ❌ | Domain not in MVM |
| risk_investigation | hotline_report | ✅ | ❌ | Domain not in MVM |
| risk_investigation | investigation | ✅ | ❌ | Domain not in MVM |
| risk_investigation | osha_exposure_incident | ✅ | ❌ | Domain not in MVM |
| risk_investigation | stark_arrangement | ✅ | ❌ | Domain not in MVM |
| workforce_attestation | attestation | ✅ | ❌ | Domain not in MVM |
| workforce_attestation | business_associate_agreement | ✅ | ❌ | Domain not in MVM |
| workforce_attestation | notice_of_privacy_practices | ✅ | ❌ | Domain not in MVM |
| workforce_attestation | osha_safety_program | ✅ | ❌ | Domain not in MVM |
| workforce_attestation | training | ✅ | ❌ | Domain not in MVM |
| workforce_attestation | training_completion | ✅ | ❌ | Domain not in MVM |

<a id="domain-consent"></a>
### consent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_capture | hipaa_authorization | ✅ | ❌ | Domain not in MVM |
| authorization_capture | photography_media_consent | ✅ | ❌ | Domain not in MVM |
| authorization_capture | research_consent | ✅ | ❌ | Domain not in MVM |
| authorization_capture | telehealth_consent | ✅ | ❌ | Domain not in MVM |
| authorization_capture | treatment_consent | ✅ | ❌ | Domain not in MVM |
| compliance_monitoring | deficiency | ✅ | ❌ | Domain not in MVM |
| compliance_monitoring | disclosure_log | ✅ | ❌ | Domain not in MVM |
| compliance_monitoring | expiration_alert | ✅ | ❌ | Domain not in MVM |
| compliance_monitoring | npp_acknowledgment | ✅ | ❌ | Domain not in MVM |
| consent_governance | consent_policy | ✅ | ❌ | Domain not in MVM |
| consent_governance | consent_session | ✅ | ❌ | Domain not in MVM |
| consent_governance | form_template | ✅ | ❌ | Domain not in MVM |
| patient_rights | amendment_request | ✅ | ❌ | Domain not in MVM |
| patient_rights | capacity_assessment | ✅ | ❌ | Domain not in MVM |
| patient_rights | delegation | ✅ | ❌ | Domain not in MVM |
| patient_rights | restriction_request | ✅ | ❌ | Domain not in MVM |
| patient_rights | revocation | ✅ | ❌ | Domain not in MVM |
| sensitive_directives | behavioral_health_consent | ✅ | ❌ | Domain not in MVM |
| sensitive_directives | genetic_testing_consent | ✅ | ❌ | Domain not in MVM |
| sensitive_directives | hie_directive | ✅ | ❌ | Domain not in MVM |
| sensitive_directives | minor_consent | ✅ | ❌ | Domain not in MVM |
| sensitive_directives | substance_use_consent | ✅ | ❌ | Domain not in MVM |

<a id="domain-digital_health"></a>
### digital_health

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| patient_engagement | portal_engagement_event | ✅ | ❌ | Domain not in MVM |
| patient_engagement | portal_session | ✅ | ❌ | Domain not in MVM |
| patient_engagement | prom_instrument | ✅ | ❌ | Domain not in MVM |
| patient_engagement | prom_question | ✅ | ❌ | Domain not in MVM |
| patient_engagement | prom_response | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | alert_threshold | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | device_alert_threshold | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | device_reading | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | rpm_alert_threshold | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | rpm_device | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | rpm_device_reading | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | rpm_enrollment | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | rpm_program_enrollment | ✅ | ❌ | Domain not in MVM |

<a id="domain-encounter"></a>
### encounter

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_documentation | discharge_summary | ✅ | ✅ |  |
| clinical_documentation | drg_assignment | ✅ | ✅ |  |
| clinical_documentation | readmission | ✅ | ❌ | Excluded from MVM |
| clinical_documentation | triage_assessment | ✅ | ✅ |  |
| clinical_documentation | visit_diagnosis | ✅ | ✅ |  |
| clinical_documentation | visit_procedure | ✅ | ✅ |  |
| clinical_documentation | visit_recall_impact | ✅ | ❌ | Excluded from MVM |
| encounter_management | adt_event | ✅ | ✅ |  |
| encounter_management | bed_assignment | ✅ | ✅ |  |
| encounter_management | transfer_request | ✅ | ❌ | Excluded from MVM |
| encounter_management | visit | ✅ | ✅ |  |
| encounter_management | visit_provider | ✅ | ✅ |  |
| encounter_management | visit_status_history | ✅ | ❌ | Excluded from MVM |
| financial_coverage | encounter_authorization | ✅ | ❌ | Excluded from MVM |
| financial_coverage | visit_coverage | ✅ | ❌ | Excluded from MVM |
| financial_coverage | visit_insurance | ✅ | ✅ |  |

<a id="domain-facility"></a>
### facility

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_maintenance | equipment_asset | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | equipment_authorization | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | maintenance_order | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | pm_schedule | ✅ | ❌ | Domain not in MVM |
| capacity_operations | bed_status_event | ✅ | ❌ | Domain not in MVM |
| capacity_operations | block_assignment | ✅ | ❌ | Domain not in MVM |
| capacity_operations | capacity_snapshot | ✅ | ❌ | Domain not in MVM |
| capacity_operations | environmental_service_request | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | bed | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | building | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | care_site | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | or_suite | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | organization | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | room | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | service | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | site_hierarchy | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | space_allocation | ✅ | ❌ | Domain not in MVM |
| physical_infrastructure | unit | ✅ | ❌ | Domain not in MVM |
| regulatory_safety | hazardous_material | ✅ | ❌ | Domain not in MVM |
| regulatory_safety | inspection | ✅ | ❌ | Domain not in MVM |
| regulatory_safety | inspection_finding | ✅ | ❌ | Domain not in MVM |
| regulatory_safety | license_accreditation | ✅ | ❌ | Domain not in MVM |
| regulatory_safety | safety_incident | ✅ | ❌ | Domain not in MVM |
| vendor_contracts | contract | ✅ | ❌ | Domain not in MVM |
| vendor_contracts | facility_program_participation | ✅ | ❌ | Domain not in MVM |
| vendor_contracts | network_contract | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | allocation_method | ✅ | ❌ | Domain not in MVM |
| budget_planning | allocation_run | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_transfer | ✅ | ❌ | Domain not in MVM |
| budget_planning | cost_allocation | ✅ | ❌ | Domain not in MVM |
| budget_planning | financial_forecast | ✅ | ❌ | Domain not in MVM |
| budget_planning | forecast_line | ✅ | ❌ | Domain not in MVM |
| capital_assets | asset_book | ✅ | ❌ | Domain not in MVM |
| capital_assets | capital_expenditure | ✅ | ❌ | Domain not in MVM |
| capital_assets | capital_project | ✅ | ❌ | Domain not in MVM |
| capital_assets | depreciation_run | ✅ | ❌ | Domain not in MVM |
| capital_assets | depreciation_schedule | ✅ | ❌ | Domain not in MVM |
| capital_assets | fixed_asset | ✅ | ❌ | Domain not in MVM |
| fund_management | donor | ✅ | ❌ | Domain not in MVM |
| fund_management | fund | ✅ | ❌ | Domain not in MVM |
| fund_management | fund_allocation | ✅ | ❌ | Domain not in MVM |
| fund_management | grant | ✅ | ❌ | Domain not in MVM |
| general_ledger | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| general_ledger | cost_center | ✅ | ❌ | Domain not in MVM |
| general_ledger | financial_entity | ✅ | ❌ | Domain not in MVM |
| general_ledger | financial_period_close | ✅ | ❌ | Domain not in MVM |
| general_ledger | fiscal_period | ✅ | ❌ | Domain not in MVM |
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
| payables_receivables | bank_account | ✅ | ❌ | Domain not in MVM |
| payables_receivables | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| payables_receivables | invoice_payment_application | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_batch | ✅ | ❌ | Domain not in MVM |
| payables_receivables | recurring_schedule | ✅ | ❌ | Domain not in MVM |

<a id="domain-genomics"></a>
### genomics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| genomics_core | biobank_specimen | ✅ | ❌ | Domain not in MVM |
| genomics_core | genetic_variant | ✅ | ❌ | Domain not in MVM |
| genomics_core | pharmacogenomics_result | ✅ | ❌ | Domain not in MVM |

<a id="domain-insurance"></a>
### insurance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| member_enrollment | accumulator | ✅ | ❌ | Excluded from MVM |
| member_enrollment | broker | ✅ | ❌ | Excluded from MVM |
| member_enrollment | dependent | ✅ | ✅ |  |
| member_enrollment | eligibility_span | ✅ | ✅ |  |
| member_enrollment | employer_group | ✅ | ❌ | Excluded from MVM |
| member_enrollment | member_enrollment | ✅ | ✅ |  |
| member_enrollment | premium_billing | ✅ | ❌ | Excluded from MVM |
| member_enrollment | subscriber | ✅ | ✅ |  |
| network_contracting | fee_schedule | ✅ | ✅ |  |
| network_contracting | fee_schedule_line | ✅ | ✅ |  |
| network_contracting | insurance_network_participation | ✅ | ❌ | Excluded from MVM |
| network_contracting | insurance_network_participation2 | ✅ | ❌ | Excluded from MVM |
| network_contracting | insurance_payer_enrollment | ✅ | ❌ | Excluded from MVM |
| network_contracting | network_adequacy | ✅ | ❌ | Excluded from MVM |
| network_contracting | payer_contact | ✅ | ❌ | Excluded from MVM |
| network_contracting | payer_contract | ✅ | ✅ |  |
| network_contracting | plan_network | ✅ | ✅ |  |
| network_contracting | provider_network | ✅ | ✅ |  |
| plan_design | benefit | ✅ | ✅ |  |
| plan_design | coverage_policy | ✅ | ✅ |  |
| plan_design | formulary_tier | ✅ | ❌ | Excluded from MVM |
| plan_design | health_plan | ✅ | ✅ |  |
| plan_design | payer | ✅ | ✅ |  |
| utilization_authorization | coordination_of_benefits | ✅ | ❌ | Excluded from MVM |
| utilization_authorization | payer_compliance_requirement | ✅ | ❌ | Excluded from MVM |
| utilization_authorization | plan_consent_requirement | ✅ | ❌ | Excluded from MVM |
| utilization_authorization | prior_auth_rule | ✅ | ✅ |  |
| utilization_authorization | utilization_review | ✅ | ❌ | Excluded from MVM |
| value_payment | accountable_care_organization | ✅ | ❌ | Excluded from MVM |
| value_payment | capitation_contract | ✅ | ❌ | Excluded from MVM |
| value_payment | capitation_payment | ✅ | ❌ | Excluded from MVM |
| value_payment | member_attribution | ✅ | ❌ | Excluded from MVM |
| value_payment | risk_adjustment | ✅ | ❌ | Excluded from MVM |
| value_payment | third_party_administrator | ✅ | ❌ | Excluded from MVM |
| value_payment | vbc_performance | ✅ | ❌ | Excluded from MVM |

<a id="domain-interoperability"></a>
### interoperability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| health_exchange | care_transition_notification | ✅ | ❌ | Domain not in MVM |
| health_exchange | cda_document | ✅ | ❌ | Domain not in MVM |
| health_exchange | cda_validation_result | ✅ | ❌ | Domain not in MVM |
| health_exchange | conformance_test | ✅ | ❌ | Domain not in MVM |
| health_exchange | exchange_standard | ✅ | ❌ | Domain not in MVM |
| health_exchange | hie_participation | ✅ | ❌ | Domain not in MVM |
| health_exchange | hie_query | ✅ | ❌ | Domain not in MVM |
| health_exchange | hie_transaction | ✅ | ❌ | Domain not in MVM |
| health_exchange | mapping_definition | ✅ | ❌ | Domain not in MVM |
| health_exchange | mapping_rule | ✅ | ❌ | Domain not in MVM |
| health_exchange | patient_identity_match | ✅ | ❌ | Domain not in MVM |
| health_exchange | terminology_mapping | ✅ | ❌ | Domain not in MVM |
| interface_operations | direct_address | ✅ | ❌ | Domain not in MVM |
| interface_operations | direct_message | ✅ | ❌ | Domain not in MVM |
| interface_operations | fhir_endpoint | ✅ | ❌ | Domain not in MVM |
| interface_operations | fhir_resource_log | ✅ | ❌ | Domain not in MVM |
| interface_operations | interface_channel | ✅ | ❌ | Domain not in MVM |
| interface_operations | interface_downtime | ✅ | ❌ | Domain not in MVM |
| interface_operations | interface_engine | ✅ | ❌ | Domain not in MVM |
| interface_operations | message_error | ✅ | ❌ | Domain not in MVM |
| interface_operations | message_log | ✅ | ❌ | Domain not in MVM |
| interface_operations | subscription_notification | ✅ | ❌ | Domain not in MVM |
| interface_operations | subscription_topic | ✅ | ❌ | Domain not in MVM |
| partner_governance | data_sharing_agreement | ✅ | ❌ | Domain not in MVM |
| partner_governance | data_use_agreement | ✅ | ❌ | Domain not in MVM |
| partner_governance | hie_organization | ✅ | ❌ | Domain not in MVM |
| partner_governance | interface_sla | ✅ | ❌ | Domain not in MVM |
| partner_governance | onboarding_project | ✅ | ❌ | Domain not in MVM |
| partner_governance | trading_partner | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | promoting_interoperability | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | public_health_report | ✅ | ❌ | Domain not in MVM |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_reference | organism | ✅ | ❌ | Excluded from MVM |
| catalog_reference | reference_range | ✅ | ✅ |  |
| catalog_reference | study_test_requirement | ✅ | ❌ | Excluded from MVM |
| catalog_reference | test_catalog | ✅ | ✅ |  |
| quality_compliance | clia_certificate | ✅ | ❌ | Excluded from MVM |
| quality_compliance | instrument | ✅ | ❌ | Excluded from MVM |
| quality_compliance | instrument_policy_compliance | ✅ | ❌ | Excluded from MVM |
| quality_compliance | qc_run | ✅ | ❌ | Excluded from MVM |
| quality_compliance | reagent_lot | ✅ | ❌ | Excluded from MVM |
| revenue_coverage | lab_charge | ✅ | ❌ | Excluded from MVM |
| revenue_coverage | lab_fee_schedule_line | ✅ | ❌ | Excluded from MVM |
| revenue_coverage | test_coverage_policy | ✅ | ❌ | Excluded from MVM |
| testing_operations | blood_bank_unit | ✅ | ✅ |  |
| testing_operations | lab_order | ✅ | ✅ |  |
| testing_operations | microbiology_culture | ✅ | ✅ |  |
| testing_operations | molecular_test | ✅ | ❌ | Excluded from MVM |
| testing_operations | pathology_report | ✅ | ✅ |  |
| testing_operations | point_of_care_test | ✅ | ❌ | Excluded from MVM |
| testing_operations | specimen | ✅ | ✅ |  |
| testing_operations | susceptibility_result | ✅ | ❌ | Excluded from MVM |
| testing_operations | test_result | ✅ | ✅ |  |
| testing_operations | transfusion_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| decision_support | alert_rule | ✅ | ❌ | Excluded from MVM |
| decision_support | cpoe_alert | ✅ | ❌ | Excluded from MVM |
| decision_support | order_authorization | ✅ | ❌ | Excluded from MVM |
| decision_support | reconciliation | ✅ | ❌ | Excluded from MVM |
| fulfillment_routing | fulfillment | ✅ | ✅ |  |
| fulfillment_routing | order_status_history | ✅ | ❌ | Excluded from MVM |
| fulfillment_routing | routing | ✅ | ✅ |  |
| fulfillment_routing | routing_rule | ✅ | ❌ | Excluded from MVM |
| order_entry | clinical_order | ✅ | ✅ |  |
| order_entry | diet_order | ✅ | ✅ |  |
| order_entry | referral_order | ✅ | ✅ |  |
| order_entry | set | ✅ | ✅ |  |
| order_entry | set_item | ✅ | ✅ |  |
| order_entry | standing_order | ✅ | ✅ |  |
| order_entry | therapy_order | ✅ | ❌ | Excluded from MVM |
| order_entry | verbal_order | ✅ | ❌ | Excluded from MVM |

<a id="domain-patient"></a>
### patient

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| coverage_financial | eligibility_check | ✅ | ✅ |  |
| coverage_financial | financial_assistance | ✅ | ❌ | Excluded from MVM |
| coverage_financial | insurance_coverage | ✅ | ✅ |  |
| coverage_financial | patient_coverage | ✅ | ❌ | Excluded from MVM |
| engagement_communication | communication_campaign | ✅ | ❌ | Excluded from MVM |
| engagement_communication | communication_log | ✅ | ❌ | Excluded from MVM |
| engagement_communication | consent_reference | ✅ | ✅ |  |
| engagement_communication | message_template | ✅ | ❌ | Excluded from MVM |
| engagement_communication | portal_account | ✅ | ✅ |  |
| engagement_communication | preference | ✅ | ❌ | Excluded from MVM |
| engagement_communication | proxy_access | ✅ | ❌ | Excluded from MVM |
| patient_identity | address | ✅ | ✅ |  |
| patient_identity | demographics | ✅ | ✅ |  |
| patient_identity | emergency_contact | ✅ | ✅ |  |
| patient_identity | flag | ✅ | ❌ | Excluded from MVM |
| patient_identity | guarantor | ✅ | ✅ |  |
| patient_identity | identity_merge_history | ✅ | ❌ | Excluded from MVM |
| patient_identity | mpi_record | ✅ | ✅ |  |
| patient_identity | mrn_crosswalk | ✅ | ❌ | Excluded from MVM |
| patient_identity | registration_event | ✅ | ✅ |  |
| population_care | attribution_panel | ✅ | ❌ | Excluded from MVM |
| population_care | care_program | ✅ | ❌ | Excluded from MVM |
| population_care | care_program_enrollment | ✅ | ❌ | Excluded from MVM |
| population_care | pcp_attribution | ✅ | ✅ |  |
| population_care | population_segment | ✅ | ❌ | Excluded from MVM |
| population_care | program_enrollment | ✅ | ❌ | Excluded from MVM |
| population_care | quality_measure_evaluation | ✅ | ❌ | Excluded from MVM |
| social_determinants | chw_intervention | ✅ | ❌ | Excluded from MVM |
| social_determinants | community_resource | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_assessment | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_need_closure | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_referral | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_risk_score | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_risk_stratification | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_zcode_mapping | ✅ | ❌ | Excluded from MVM |

<a id="domain-pharmacy"></a>
### pharmacy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefit_reimbursement | medication_pa_request | ✅ | ❌ | Excluded from MVM |
| benefit_reimbursement | pharmacy_network_participation | ✅ | ❌ | Excluded from MVM |
| benefit_reimbursement | rx_claim | ✅ | ❌ | Excluded from MVM |
| clinical_services | adverse_drug_event | ✅ | ✅ |  |
| clinical_services | medication_review | ✅ | ❌ | Excluded from MVM |
| clinical_services | medication_therapy_mgmt | ✅ | ❌ | Excluded from MVM |
| clinical_services | study_drug_assignment | ✅ | ❌ | Excluded from MVM |
| dispensing_operations | controlled_substance_log | ✅ | ✅ |  |
| dispensing_operations | dispense_event | ✅ | ✅ |  |
| dispensing_operations | mar_record | ✅ | ✅ |  |
| dispensing_operations | prescription | ✅ | ✅ |  |
| formulary_management | compounding_record | ✅ | ❌ | Excluded from MVM |
| formulary_management | drug_master | ✅ | ✅ |  |
| formulary_management | formulary | ✅ | ✅ |  |
| formulary_management | inventory | ✅ | ✅ |  |
| formulary_management | pharmacy_location | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | drug_recall | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | rems_compliance | ✅ | ❌ | Excluded from MVM |

<a id="domain-population_health"></a>
### population_health

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| population_health | cohort_definition | ✅ | ❌ | Domain not in MVM |
| population_health | cohort_membership | ✅ | ❌ | Domain not in MVM |
| population_health | trial_match_evaluation | ✅ | ❌ | Domain not in MVM |

<a id="domain-post_acute"></a>
### post_acute

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| post_acute | home_health_episode | ✅ | ❌ | Domain not in MVM |
| post_acute | hospice_episode | ✅ | ❌ | Domain not in MVM |
| post_acute | snf_stay | ✅ | ❌ | Domain not in MVM |

<a id="domain-provider"></a>
### provider

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credentialing_compliance | board_certification | ✅ | ✅ |  |
| credentialing_compliance | cme_activity | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | committee | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | credential | ✅ | ✅ |  |
| credentialing_compliance | credentialing_application | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | credentialing_file | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | dea_registration | ✅ | ✅ |  |
| credentialing_compliance | education_training | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | malpractice_coverage | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | npdb_query | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | peer_reference | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | privileging | ✅ | ✅ |  |
| credentialing_compliance | reappointment | ✅ | ❌ | Excluded from MVM |
| credentialing_compliance | sanction | ✅ | ❌ | Excluded from MVM |
| network_enrollment | affiliation | ✅ | ❌ | Excluded from MVM |
| network_enrollment | affiliation_history | ✅ | ❌ | Excluded from MVM |
| network_enrollment | network_affiliation | ✅ | ✅ |  |
| network_enrollment | provider_network_participation | ✅ | ❌ | Excluded from MVM |
| network_enrollment | provider_payer_enrollment | ✅ | ❌ | Excluded from MVM |
| network_enrollment | telehealth_authorization | ✅ | ❌ | Excluded from MVM |
| practice_engagement | assignment | ✅ | ❌ | Excluded from MVM |
| practice_engagement | preference_card | ✅ | ❌ | Excluded from MVM |
| practice_engagement | study_team_member | ✅ | ❌ | Excluded from MVM |
| practice_engagement | survey_participation | ✅ | ❌ | Excluded from MVM |
| provider_registry | clinician | ✅ | ✅ |  |
| provider_registry | group | ✅ | ✅ |  |
| provider_registry | group_membership | ✅ | ✅ |  |
| provider_registry | location_specialty | ✅ | ❌ | Excluded from MVM |
| provider_registry | org_provider | ✅ | ✅ |  |
| provider_registry | provider_location | ✅ | ❌ | Excluded from MVM |
| provider_registry | specialty | ✅ | ✅ |  |
| provider_registry | taxonomy | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accreditation_improvement | accreditation_program | ✅ | ❌ | Domain not in MVM |
| accreditation_improvement | accreditation_survey | ✅ | ❌ | Domain not in MVM |
| accreditation_improvement | contract_initiative | ✅ | ❌ | Domain not in MVM |
| accreditation_improvement | corrective_action | ✅ | ❌ | Domain not in MVM |
| accreditation_improvement | improvement_initiative | ✅ | ❌ | Domain not in MVM |
| accreditation_improvement | program_study_participation | ✅ | ❌ | Domain not in MVM |
| accreditation_improvement | standard_finding | ✅ | ❌ | Domain not in MVM |
| measure_management | apm_enrollment | ✅ | ❌ | Domain not in MVM |
| measure_management | hedis_measure | ✅ | ❌ | Domain not in MVM |
| measure_management | hedis_result | ✅ | ❌ | Domain not in MVM |
| measure_management | initiative_measure_target | ✅ | ❌ | Domain not in MVM |
| measure_management | measure | ✅ | ❌ | Domain not in MVM |
| measure_management | measure_attribution | ✅ | ❌ | Domain not in MVM |
| measure_management | measure_budget_allocation | ✅ | ❌ | Domain not in MVM |
| measure_management | measure_result | ✅ | ❌ | Domain not in MVM |
| measure_management | mips_measure_reporting | ✅ | ❌ | Domain not in MVM |
| measure_management | program_measure_assignment | ✅ | ❌ | Domain not in MVM |
| measure_management | quality_program | ✅ | ❌ | Domain not in MVM |
| measure_management | quality_program_participation | ✅ | ❌ | Domain not in MVM |
| measure_management | raf_score | ✅ | ❌ | Domain not in MVM |
| measure_management | vbp_program | ✅ | ❌ | Domain not in MVM |
| patient_experience | cahps_response | ✅ | ❌ | Domain not in MVM |
| patient_experience | cahps_survey | ✅ | ❌ | Domain not in MVM |
| patient_experience | care_gap_closure | ✅ | ❌ | Domain not in MVM |
| patient_experience | population_health_gap | ✅ | ❌ | Domain not in MVM |
| patient_experience | sdoh_screening | ✅ | ❌ | Domain not in MVM |
| safety_review | cdi_review | ✅ | ❌ | Domain not in MVM |
| safety_review | mortality_review | ✅ | ❌ | Domain not in MVM |
| safety_review | patient_safety_event | ✅ | ❌ | Domain not in MVM |
| safety_review | quality_committee | ✅ | ❌ | Domain not in MVM |
| safety_review | quality_peer_review | ✅ | ❌ | Domain not in MVM |
| safety_review | safety_event_review | ✅ | ❌ | Domain not in MVM |

<a id="domain-radiology"></a>
### radiology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| external_distribution | distribution_rule | ✅ | ❌ | Excluded from MVM |
| external_distribution | network_modality_participation | ✅ | ❌ | Excluded from MVM |
| external_distribution | report_distribution | ✅ | ❌ | Excluded from MVM |
| external_distribution | transmission | ✅ | ❌ | Excluded from MVM |
| order_management | appointment | ❌ | ✅ | MVM only (stub or new) |
| order_management | follow_up | ✅ | ❌ | Excluded from MVM |
| order_management | imaging_order | ✅ | ✅ |  |
| order_management | radiology_appointment | ✅ | ❌ | Excluded from MVM |
| order_management | radiology_order_status_history | ✅ | ❌ | Excluded from MVM |
| order_management | reader_assignment | ✅ | ❌ | Excluded from MVM |
| order_management | teleradiology_case | ✅ | ❌ | Excluded from MVM |
| reporting_interpretation | critical_result | ✅ | ✅ |  |
| reporting_interpretation | radiology_finding | ✅ | ❌ | Excluded from MVM |
| reporting_interpretation | radiology_peer_review | ✅ | ❌ | Excluded from MVM |
| reporting_interpretation | report | ✅ | ✅ |  |
| reporting_interpretation | report_addendum | ✅ | ❌ | Excluded from MVM |
| study_acquisition | contrast_admin | ✅ | ✅ |  |
| study_acquisition | dicom_series | ✅ | ✅ |  |
| study_acquisition | dose_record | ✅ | ❌ | Excluded from MVM |
| study_acquisition | interventional_procedure | ✅ | ❌ | Excluded from MVM |
| study_acquisition | modality | ✅ | ✅ |  |
| study_acquisition | protocol | ✅ | ✅ |  |
| study_acquisition | radiology_study | ✅ | ❌ | Excluded from MVM |

<a id="domain-reference"></a>
### reference

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_codes | condition_code | ✅ | ❌ | Domain not in MVM |
| billing_codes | cpt_code | ✅ | ❌ | Domain not in MVM |
| billing_codes | drg | ✅ | ❌ | Domain not in MVM |
| billing_codes | hcpcs_code | ✅ | ❌ | Domain not in MVM |
| billing_codes | major_diagnostic_category | ✅ | ❌ | Domain not in MVM |
| clinical_terminology | code_set_version | ✅ | ❌ | Domain not in MVM |
| clinical_terminology | crosswalk | ✅ | ❌ | Domain not in MVM |
| clinical_terminology | fhir_value_set | ✅ | ❌ | Domain not in MVM |
| clinical_terminology | icd_code | ✅ | ❌ | Domain not in MVM |
| clinical_terminology | loinc_code | ✅ | ❌ | Domain not in MVM |
| clinical_terminology | ndc_drug | ✅ | ❌ | Domain not in MVM |
| clinical_terminology | snomed_concept | ✅ | ❌ | Domain not in MVM |
| registry_directory | geographic_region | ✅ | ❌ | Domain not in MVM |
| registry_directory | npi_registry | ✅ | ❌ | Domain not in MVM |
| registry_directory | reference_sdoh_zcode_mapping | ✅ | ❌ | Domain not in MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| data_governance | data_access_request | ✅ | ❌ | Domain not in MVM |
| data_governance | data_governance_committee | ✅ | ❌ | Domain not in MVM |
| data_governance | deidentified_dataset | ✅ | ❌ | Domain not in MVM |
| data_governance | dua_document | ✅ | ❌ | Domain not in MVM |
| data_governance | study_partner_agreement | ✅ | ❌ | Domain not in MVM |
| financial_grants | billing_event | ✅ | ❌ | Domain not in MVM |
| financial_grants | coverage_analysis | ✅ | ❌ | Domain not in MVM |
| financial_grants | grant | ✅ | ❌ | Domain not in MVM |
| financial_grants | grant_expenditure | ✅ | ❌ | Domain not in MVM |
| financial_grants | grant_personnel | ✅ | ❌ | Domain not in MVM |
| financial_grants | study_budget | ✅ | ❌ | Domain not in MVM |
| financial_grants | study_sponsor | ✅ | ❌ | Domain not in MVM |
| safety_monitoring | adverse_event | ✅ | ❌ | Domain not in MVM |
| safety_monitoring | data_safety_monitoring | ✅ | ❌ | Domain not in MVM |
| safety_monitoring | dsmb_committee | ✅ | ❌ | Domain not in MVM |
| safety_monitoring | monitoring_visit | ✅ | ❌ | Domain not in MVM |
| safety_monitoring | protocol_deviation | ✅ | ❌ | Domain not in MVM |
| study_management | investigational_product | ✅ | ❌ | Domain not in MVM |
| study_management | investigational_product_training | ✅ | ❌ | Domain not in MVM |
| study_management | ip_dispensation | ✅ | ❌ | Domain not in MVM |
| study_management | irb_submission | ✅ | ❌ | Domain not in MVM |
| study_management | protocol_amendment | ✅ | ❌ | Domain not in MVM |
| study_management | research_document | ✅ | ❌ | Domain not in MVM |
| study_management | research_regulatory_submission | ✅ | ❌ | Domain not in MVM |
| study_management | research_study | ✅ | ❌ | Domain not in MVM |
| study_management | study_arm | ✅ | ❌ | Domain not in MVM |
| study_management | study_site | ✅ | ❌ | Domain not in MVM |
| subject_participation | biospecimen | ✅ | ❌ | Domain not in MVM |
| subject_participation | consent_template | ✅ | ❌ | Domain not in MVM |
| subject_participation | informed_consent | ✅ | ❌ | Domain not in MVM |
| subject_participation | study_visit | ✅ | ❌ | Domain not in MVM |
| subject_participation | subject_enrollment | ✅ | ❌ | Domain not in MVM |

<a id="domain-scheduling"></a>
### scheduling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| appointment_booking | appointment_prior_auth_requirement | ✅ | ❌ | Excluded from MVM |
| appointment_booking | appointment_status_history | ✅ | ❌ | Excluded from MVM |
| appointment_booking | appointment_type | ✅ | ✅ |  |
| appointment_booking | booking_queue | ✅ | ❌ | Excluded from MVM |
| appointment_booking | recall_list | ✅ | ❌ | Excluded from MVM |
| appointment_booking | scheduling_appointment | ✅ | ❌ | Excluded from MVM |
| appointment_booking | telehealth_session | ✅ | ✅ |  |
| appointment_booking | waitlist_entry | ✅ | ✅ |  |
| capacity_management | capacity_utilization | ✅ | ❌ | Excluded from MVM |
| capacity_management | open_slot | ✅ | ✅ |  |
| capacity_management | provider_availability | ✅ | ✅ |  |
| capacity_management | resource_assignment | ✅ | ✅ |  |
| capacity_management | schedulable_resource | ✅ | ✅ |  |
| capacity_management | schedule_template | ✅ | ✅ |  |
| patient_engagement | appointment_reminder | ✅ | ❌ | Excluded from MVM |
| patient_engagement | booking_rule | ✅ | ❌ | Excluded from MVM |
| patient_engagement | patient_preference | ✅ | ❌ | Excluded from MVM |
| patient_engagement | reminder_template | ✅ | ❌ | Excluded from MVM |
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
| inventory_management | inventory_balance | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_location | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_transaction | ✅ | ❌ | Domain not in MVM |
| inventory_management | location_audit | ✅ | ❌ | Domain not in MVM |
| inventory_management | material_policy_governance | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | case_cart | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | goods_receipt | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | material_master | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | purchase_order | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | purchase_order_line | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | recall_notice | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | requisition | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | sterile_processing_record | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | surgical_bom | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | udi_record | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | vendor | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | vendor_contract | ✅ | ❌ | Domain not in MVM |
| supply_sourcing | vendor_site | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefits_leave | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| benefits_leave | benefit_plan | ✅ | ❌ | Domain not in MVM |
| benefits_leave | leave_request | ✅ | ❌ | Domain not in MVM |
| benefits_leave | osha_incident | ✅ | ❌ | Domain not in MVM |
| clinical_authorization | channel_support_assignment | ✅ | ❌ | Domain not in MVM |
| clinical_authorization | clinical_privilege | ✅ | ❌ | Domain not in MVM |
| clinical_authorization | position_procedure_authorization | ✅ | ❌ | Domain not in MVM |
| clinical_authorization | workforce_provider_network_participation | ✅ | ❌ | Domain not in MVM |
| talent_development | applicant | ✅ | ❌ | Domain not in MVM |
| talent_development | competency_assessment | ✅ | ❌ | Domain not in MVM |
| talent_development | education_program | ✅ | ❌ | Domain not in MVM |
| talent_development | employment_competency | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | recruitment | ✅ | ❌ | Domain not in MVM |
| talent_development | review_template | ✅ | ❌ | Domain not in MVM |
| time_payroll | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| time_payroll | payroll_run | ✅ | ❌ | Domain not in MVM |
| time_payroll | shift_schedule | ✅ | ❌ | Domain not in MVM |
| time_payroll | time_attendance | ✅ | ❌ | Domain not in MVM |
| workforce_administration | employee | ✅ | ❌ | Domain not in MVM |
| workforce_administration | fte_budget | ✅ | ❌ | Domain not in MVM |
| workforce_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| workforce_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_administration | position | ✅ | ❌ | Domain not in MVM |
