# Construction Lakehouse Data Models

**Version 2** | Generated on June 27, 2026 at 01:55 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Bid](#domain-bid)
  - [Client](#domain-client)
  - [Compliance](#domain-compliance)
  - [Contract](#domain-contract)
  - [Design](#domain-design)
  - [Employee](#domain-employee)
  - [Equipment](#domain-equipment)
  - [Finance](#domain-finance)
  - [Hr](#domain-hr)
  - [Material](#domain-material)
  - [Org_unit](#domain-org_unit)
  - [Position](#domain-position)
  - [Procurement](#domain-procurement)
  - [Project](#domain-project)
  - [Quality](#domain-quality)
  - [Safety](#domain-safety)
  - [Schedule](#domain-schedule)
  - [Site](#domain-site)
  - [Subcontractor](#domain-subcontractor)
  - [Sustainability](#domain-sustainability)
  - [Workforce](#domain-workforce)


## Business Description

construction industry enterprise data model.

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
| Domains | 13 | 21 |
| Subdomains | 34 | 69 |
| Products (Tables) | 141 | 368 |
| Attributes (Columns) | 5290 | 13608 |
| Foreign Keys | 834 | 1819 |
| Avg Attributes/Product | 37.5 | 37.0 |

## Domain & Product Comparison

<a id="domain-bid"></a>
### bid

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_estimating | estimate | ✅ | ❌ | Domain not in MVM |
| cost_estimating | estimate_line | ✅ | ❌ | Domain not in MVM |
| cost_estimating | response | ✅ | ❌ | Domain not in MVM |
| cost_estimating | vendor_quote | ✅ | ❌ | Domain not in MVM |
| partner_qualification | bidder_prequalification | ✅ | ❌ | Domain not in MVM |
| partner_qualification | firm_profile | ✅ | ❌ | Domain not in MVM |
| partner_qualification | jv_partner | ✅ | ❌ | Domain not in MVM |
| partner_qualification | subcontractor_prequalification | ✅ | ❌ | Domain not in MVM |
| payment_processing | bid_lien_waiver | ✅ | ❌ | Domain not in MVM |
| payment_processing | bid_payment_application | ✅ | ❌ | Domain not in MVM |
| pursuit_management | approval | ✅ | ❌ | Domain not in MVM |
| pursuit_management | bid_team_assignment | ✅ | ❌ | Domain not in MVM |
| pursuit_management | clarification | ✅ | ❌ | Domain not in MVM |
| pursuit_management | pursuit | ✅ | ❌ | Domain not in MVM |
| pursuit_management | pursuit_risk | ✅ | ❌ | Domain not in MVM |
| pursuit_management | submission | ✅ | ❌ | Domain not in MVM |
| pursuit_management | win_loss_record | ✅ | ❌ | Domain not in MVM |
| tender_preparation | bid_contract_agreement | ✅ | ❌ | Domain not in MVM |
| tender_preparation | bid_pricing_line | ✅ | ❌ | Domain not in MVM |
| tender_preparation | bond | ✅ | ❌ | Domain not in MVM |
| tender_preparation | boq | ✅ | ❌ | Domain not in MVM |
| tender_preparation | subcontractor_bond | ✅ | ❌ | Domain not in MVM |
| tender_preparation | tender | ✅ | ❌ | Domain not in MVM |
| tender_preparation | trade_package | ✅ | ❌ | Domain not in MVM |

<a id="domain-client"></a>
### client

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_credit_profile | ✅ | ❌ | Excluded from MVM |
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | address | ✅ | ✅ |  |
| account_management | contact | ✅ | ✅ |  |
| account_management | jv_structure | ✅ | ❌ | Excluded from MVM |
| business_development | opportunity | ❌ | ✅ | MVM only (stub or new) |
| business_development | opportunity_contact_engagement | ❌ | ✅ | MVM only (stub or new) |
| business_development | prequalification | ❌ | ✅ | MVM only (stub or new) |
| relationship_intelligence | client_opportunity | ✅ | ❌ | Excluded from MVM |
| relationship_intelligence | client_prequalification | ✅ | ❌ | Excluded from MVM |
| relationship_intelligence | interaction | ✅ | ❌ | Excluded from MVM |
| relationship_intelligence | master_services_agreement | ✅ | ✅ |  |
| relationship_intelligence | project_engagement | ✅ | ❌ | Excluded from MVM |
| relationship_intelligence | rfp_issuance | ✅ | ✅ |  |
| relationship_intelligence | segment | ✅ | ✅ |  |
| relationship_intelligence | survey | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_assurance | assessment | ✅ | ❌ | Domain not in MVM |
| audit_assurance | audit_report | ✅ | ❌ | Domain not in MVM |
| audit_assurance | finding | ✅ | ❌ | Domain not in MVM |
| audit_assurance | obligation_calendar | ✅ | ❌ | Domain not in MVM |
| audit_assurance | remediation_action | ✅ | ❌ | Domain not in MVM |
| environmental_standards | env_impact_assessment | ✅ | ❌ | Domain not in MVM |
| environmental_standards | env_monitoring | ✅ | ❌ | Domain not in MVM |
| environmental_standards | iso_audit | ✅ | ❌ | Domain not in MVM |
| environmental_standards | iso_certification | ✅ | ❌ | Domain not in MVM |
| environmental_standards | leed_certification | ✅ | ❌ | Domain not in MVM |
| environmental_standards | leed_credit | ✅ | ❌ | Domain not in MVM |
| permit_oversight | permit_application | ✅ | ❌ | Domain not in MVM |
| permit_oversight | permit_condition | ✅ | ❌ | Domain not in MVM |
| permit_oversight | regulatory_authority | ✅ | ❌ | Domain not in MVM |
| permit_oversight | regulatory_permit | ✅ | ❌ | Domain not in MVM |
| permit_oversight | waiver_exemption | ✅ | ❌ | Domain not in MVM |
| privacy_protection | consent_record | ✅ | ❌ | Domain not in MVM |
| privacy_protection | pci_assessment | ✅ | ❌ | Domain not in MVM |
| privacy_protection | pci_control | ✅ | ❌ | Domain not in MVM |
| privacy_protection | privacy_incident | ✅ | ❌ | Domain not in MVM |
| privacy_protection | privacy_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | authority_notice | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_submission | ✅ | ❌ | Domain not in MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_administration | agreement | ✅ | ✅ |  |
| agreement_administration | amendment | ✅ | ✅ |  |
| agreement_administration | closeout | ✅ | ❌ | Excluded from MVM |
| agreement_administration | contract_agreement | ✅ | ❌ | Excluded from MVM |
| agreement_administration | contractual_notice | ✅ | ❌ | Excluded from MVM |
| agreement_administration | party | ✅ | ✅ |  |
| agreement_administration | scope_of_work | ✅ | ✅ |  |
| agreement_administration | subcontract | ✅ | ✅ |  |
| change_claims | change_order_activity_impact | ✅ | ❌ | Excluded from MVM |
| change_claims | commercial_change_order | ✅ | ✅ |  |
| change_claims | dispute | ✅ | ✅ |  |
| change_claims | ld_assessment | ✅ | ❌ | Excluded from MVM |
| change_claims | prime_eot_claim | ✅ | ❌ | Excluded from MVM |
| contract_administration | scope_variation_item | ❌ | ✅ | MVM only (stub or new) |
| payment_retention | advance_payment | ✅ | ❌ | Excluded from MVM |
| payment_retention | payment_certificate | ✅ | ✅ |  |
| payment_retention | payment_milestone | ✅ | ❌ | Excluded from MVM |
| payment_retention | payment_schedule | ✅ | ✅ |  |
| payment_retention | retention_account | ✅ | ❌ | Excluded from MVM |
| payment_retention | subcontract_payment | ✅ | ✅ |  |
| risk_compliance | bond_guarantee | ✅ | ✅ |  |
| risk_compliance | dlp_register | ✅ | ❌ | Excluded from MVM |
| risk_compliance | insurance_certificate | ✅ | ❌ | Excluded from MVM |
| risk_compliance | insurance_register | ✅ | ✅ |  |

<a id="domain-design"></a>
### design

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_management | change_impact | ✅ | ❌ | Excluded from MVM |
| change_management | change_notice | ✅ | ❌ | Excluded from MVM |
| change_management | design_scope | ✅ | ❌ | Excluded from MVM |
| change_management | value_engineering_proposal | ✅ | ❌ | Excluded from MVM |
| document_control | access_permission | ✅ | ❌ | Excluded from MVM |
| document_control | correspondence | ✅ | ❌ | Excluded from MVM |
| document_control | correspondence_response | ✅ | ❌ | Excluded from MVM |
| document_control | distribution_matrix | ✅ | ❌ | Excluded from MVM |
| document_control | document_register | ✅ | ✅ |  |
| document_control | revision | ✅ | ✅ |  |
| document_control | rfi | ✅ | ✅ |  |
| document_control | transmittal | ✅ | ✅ |  |
| document_control | transmittal_item | ✅ | ❌ | Excluded from MVM |
| document_control | workflow_approval | ✅ | ✅ |  |
| document_control | workflow_template | ✅ | ❌ | Excluded from MVM |
| engineering_drawings | bim_model | ✅ | ✅ |  |
| engineering_drawings | calculation_register | ✅ | ❌ | Excluded from MVM |
| engineering_drawings | clash_detection_run | ✅ | ❌ | Excluded from MVM |
| engineering_drawings | drawing | ✅ | ✅ |  |
| engineering_drawings | drawing_incident_link | ✅ | ❌ | Excluded from MVM |
| engineering_drawings | drawing_requirement | ✅ | ❌ | Excluded from MVM |
| engineering_drawings | drawing_revision | ✅ | ✅ |  |
| engineering_drawings | package | ✅ | ✅ |  |
| engineering_drawings | review | ✅ | ❌ | Excluded from MVM |
| engineering_drawings | technical_specification | ✅ | ✅ |  |
| handover_commissioning | engineering_submittal | ✅ | ✅ |  |
| handover_commissioning | handover_item | ✅ | ❌ | Excluded from MVM |
| handover_commissioning | handover_package | ✅ | ❌ | Excluded from MVM |
| spatial_coordination | equipment_installation | ✅ | ❌ | Excluded from MVM |
| spatial_coordination | interface_equipment_assignment | ✅ | ❌ | Excluded from MVM |
| spatial_coordination | interface_point | ✅ | ❌ | Excluded from MVM |
| spatial_coordination | mep_coordination_zone | ✅ | ❌ | Excluded from MVM |
| spatial_coordination | zone_equipment_allocation | ✅ | ❌ | Excluded from MVM |

<a id="domain-employee"></a>
### employee

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | *(no products)* | ✅ | ❌ | |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | asset | ✅ | ✅ |  |
| asset_registry | asset_category | ✅ | ✅ |  |
| asset_registry | asset_valuation | ✅ | ❌ | Excluded from MVM |
| asset_registry | fuel_point | ✅ | ❌ | Excluded from MVM |
| asset_registry | functional_location | ✅ | ✅ |  |
| asset_registry | insurance_policy | ✅ | ❌ | Excluded from MVM |
| fleet_operations | asset_activity_assignment | ✅ | ❌ | Excluded from MVM |
| fleet_operations | equipment_mobilization | ✅ | ❌ | Excluded from MVM |
| fleet_operations | fleet_assignment | ✅ | ✅ |  |
| fleet_operations | operator_certification | ✅ | ❌ | Excluded from MVM |
| fleet_operations | rental_agreement | ✅ | ✅ |  |
| fleet_operations | telematics_reading | ✅ | ❌ | Excluded from MVM |
| maintenance_service | fuel_transaction | ✅ | ✅ |  |
| maintenance_service | hours | ✅ | ✅ |  |
| maintenance_service | inspection_record | ✅ | ✅ |  |
| maintenance_service | maintenance_notification | ✅ | ❌ | Excluded from MVM |
| maintenance_service | maintenance_order | ✅ | ✅ |  |
| maintenance_service | maintenance_plan | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_control | commitment | ✅ | ❌ | Excluded from MVM |
| cost_control | commitment_item | ✅ | ❌ | Excluded from MVM |
| cost_control | cost_center | ✅ | ✅ |  |
| cost_control | cost_code | ✅ | ✅ |  |
| cost_control | earned_value_record | ✅ | ❌ | Excluded from MVM |
| cost_control | finance_budget_revision | ✅ | ❌ | Excluded from MVM |
| cost_control | job_cost_transaction | ✅ | ✅ |  |
| cost_control | profit_center | ✅ | ❌ | Excluded from MVM |
| cost_control | project_budget | ✅ | ✅ |  |
| ledger_accounting | chart_of_accounts | ✅ | ✅ |  |
| ledger_accounting | company_code | ✅ | ✅ |  |
| ledger_accounting | finance_retention_ledger | ✅ | ❌ | Excluded from MVM |
| ledger_accounting | gl_account | ✅ | ✅ |  |
| ledger_accounting | journal_entry | ✅ | ✅ |  |
| ledger_accounting | journal_entry_line | ✅ | ✅ |  |
| ledger_accounting | revenue_recognition_entry | ✅ | ❌ | Excluded from MVM |
| payment_processing | accounts_receivable_invoice | ✅ | ❌ | Excluded from MVM |
| payment_processing | billing_period | ✅ | ❌ | Excluded from MVM |
| payment_processing | finance_lien_waiver | ✅ | ❌ | Excluded from MVM |
| payment_processing | finance_payment_application | ✅ | ❌ | Excluded from MVM |
| payment_processing | invoice | ✅ | ✅ |  |
| payment_processing | payment_record | ✅ | ✅ |  |
| payment_processing | payment_run | ✅ | ❌ | Excluded from MVM |
| payment_processing | progress_billing | ✅ | ✅ |  |
| treasury_risk | cash_flow_forecast | ✅ | ✅ |  |
| treasury_risk | financial_guarantee | ✅ | ❌ | Excluded from MVM |

<a id="domain-hr"></a>
### hr

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_relations | disciplinary_case | ✅ | ❌ | Domain not in MVM |
| employee_relations | grievance | ✅ | ❌ | Domain not in MVM |
| employee_relations | policy | ✅ | ❌ | Domain not in MVM |
| leave_attendance | leave_balance | ✅ | ❌ | Domain not in MVM |
| leave_attendance | leave_request | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation_review | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_group | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| performance_development | goal | ✅ | ❌ | Domain not in MVM |
| performance_development | kpi | ✅ | ❌ | Domain not in MVM |
| performance_development | performance_review | ✅ | ❌ | Domain not in MVM |
| performance_development | training_course | ✅ | ❌ | Domain not in MVM |
| performance_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | applicant | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | onboarding_checklist | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | onboarding_template | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | separation | ✅ | ❌ | Domain not in MVM |
| workforce_master | employment_contract | ✅ | ❌ | Domain not in MVM |
| workforce_master | hr_employee | ✅ | ❌ | Domain not in MVM |
| workforce_master | hr_org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_master | job_profile | ✅ | ❌ | Domain not in MVM |
| workforce_master | position | ✅ | ❌ | Domain not in MVM |
| workforce_master | succession_plan | ✅ | ❌ | Domain not in MVM |
| workforce_master | workforce_headcount_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-material"></a>
### material

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | goods_issue | ✅ | ✅ |  |
| inventory_control | physical_inventory | ✅ | ❌ | Excluded from MVM |
| inventory_control | stock_level | ✅ | ✅ |  |
| inventory_control | stock_movement | ✅ | ✅ |  |
| inventory_control | stock_transfer | ✅ | ❌ | Excluded from MVM |
| inventory_control | warehouse | ✅ | ✅ |  |
| inventory_control | wastage | ✅ | ❌ | Excluded from MVM |
| material_catalog | approved_material_list | ✅ | ❌ | Excluded from MVM |
| material_catalog | batch_lot | ✅ | ✅ |  |
| material_catalog | conformance_certificate | ✅ | ❌ | Excluded from MVM |
| material_catalog | hazmat_register | ✅ | ❌ | Excluded from MVM |
| material_catalog | master | ✅ | ✅ |  |
| material_catalog | specification | ✅ | ❌ | Excluded from MVM |
| material_registry | boq_line | ❌ | ✅ | MVM only (stub or new) |
| quantity_planning | material_boq_line | ✅ | ❌ | Excluded from MVM |
| quantity_planning | mto_header | ✅ | ✅ |  |
| quantity_planning | mto_line | ✅ | ✅ |  |
| quantity_planning | requisition | ✅ | ✅ |  |

<a id="domain-org_unit"></a>
### org_unit

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | *(no products)* | ✅ | ❌ | |

<a id="domain-position"></a>
### position

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | *(no products)* | ✅ | ❌ | |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_sourcing | material_catalog | ✅ | ✅ |  |
| catalog_sourcing | rfq | ✅ | ✅ |  |
| catalog_sourcing | rfq_line | ✅ | ✅ |  |
| catalog_sourcing | service | ✅ | ❌ | Excluded from MVM |
| catalog_sourcing | sourcing_plan | ✅ | ❌ | Excluded from MVM |
| catalog_sourcing | vendor_quotation | ✅ | ✅ |  |
| delivery_inspection | delivery_schedule | ✅ | ❌ | Excluded from MVM |
| delivery_inspection | goods_receipt | ✅ | ✅ |  |
| delivery_inspection | inspection_release | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | approval_workflow | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | po_amendment | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | po_line | ✅ | ✅ |  |
| order_fulfillment | procurement_bid | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | purchase_order | ✅ | ✅ |  |
| order_fulfillment | purchase_requisition | ✅ | ✅ |  |
| supplier_management | procurement_framework_agreement | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor | ✅ | ✅ |  |
| supplier_management | vendor_document | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_evaluation | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_invoice | ✅ | ✅ |  |
| supplier_management | vendor_qualification | ✅ | ✅ |  |
| vendor_management | purchasing_info_record | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commissioning_handover | commissioning_package | ✅ | ❌ | Excluded from MVM |
| commissioning_handover | deliverable | ✅ | ✅ |  |
| commissioning_handover | handover_certificate | ✅ | ❌ | Excluded from MVM |
| cost_control | change_order | ❌ | ✅ | MVM only (stub or new) |
| performance_tracking | cost_account | ✅ | ✅ |  |
| performance_tracking | evm_period_record | ✅ | ✅ |  |
| performance_tracking | forecast | ✅ | ✅ |  |
| performance_tracking | progress_measurement | ✅ | ✅ |  |
| performance_tracking | project_budget_revision | ✅ | ❌ | Excluded from MVM |
| performance_tracking | project_change_order | ✅ | ❌ | Excluded from MVM |
| performance_tracking | reporting_period | ✅ | ❌ | Excluded from MVM |
| project_delivery | construction_project | ✅ | ✅ |  |
| project_delivery | phase | ✅ | ✅ |  |
| project_delivery | project_baseline | ✅ | ✅ |  |
| project_delivery | project_milestone | ✅ | ❌ | Excluded from MVM |
| project_delivery | project_site | ✅ | ✅ |  |
| project_delivery | team_member | ✅ | ❌ | Excluded from MVM |
| project_delivery | wbs_element | ✅ | ✅ |  |
| project_setup | milestone | ❌ | ✅ | MVM only (stub or new) |
| regulatory_governance | regulatory_oversight | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | risk_register | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_verification | corrective_action | ✅ | ✅ |  |
| field_verification | defect | ✅ | ❌ | Excluded from MVM |
| field_verification | inspection | ✅ | ✅ |  |
| field_verification | ncr | ✅ | ✅ |  |
| field_verification | punch_item | ✅ | ✅ |  |
| field_verification | punch_list | ✅ | ✅ |  |
| field_verification | quality_audit | ✅ | ❌ | Excluded from MVM |
| field_verification | quality_submittal | ✅ | ❌ | Excluded from MVM |
| inspection_planning | checklist | ✅ | ✅ |  |
| inspection_planning | checklist_execution | ✅ | ❌ | Excluded from MVM |
| inspection_planning | itp | ✅ | ✅ |  |
| inspection_planning | itp_line | ✅ | ✅ |  |
| inspection_planning | plan | ❌ | ✅ | MVM only (stub or new) |
| inspection_planning | quality_plan | ✅ | ❌ | Excluded from MVM |
| material_testing | acceptance_test | ✅ | ❌ | Excluded from MVM |
| material_testing | concrete_pour_record | ✅ | ❌ | Excluded from MVM |
| material_testing | lab_test | ✅ | ❌ | Excluded from MVM |
| material_testing | laboratory | ✅ | ❌ | Excluded from MVM |
| material_testing | ndt_record | ✅ | ❌ | Excluded from MVM |
| material_testing | sample | ✅ | ❌ | Excluded from MVM |
| material_testing | test_certificate | ✅ | ✅ |  |
| material_testing | weld_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_compliance | environmental_monitoring | ✅ | ✅ |  |
| field_compliance | hse_inspection | ✅ | ✅ |  |
| field_compliance | safety_audit | ✅ | ❌ | Excluded from MVM |
| field_compliance | toolbox_meeting | ✅ | ✅ |  |
| hazard_control | chemical_register | ✅ | ❌ | Excluded from MVM |
| hazard_control | hazard_register | ✅ | ✅ |  |
| hazard_control | permit_to_work | ✅ | ✅ |  |
| hazard_control | risk_assessment | ✅ | ✅ |  |
| hazard_control | swms | ✅ | ✅ |  |
| incident_management | incident | ✅ | ✅ |  |
| incident_management | incident_investigation | ✅ | ✅ |  |
| incident_management | incident_subcontractor_involvement | ✅ | ❌ | Excluded from MVM |
| worker_protection | hse_plan | ✅ | ✅ |  |
| worker_protection | ppe_register | ✅ | ❌ | Excluded from MVM |
| worker_protection | training | ✅ | ❌ | Excluded from MVM |

<a id="domain-schedule"></a>
### schedule

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| activity_planning | activity | ✅ | ✅ |  |
| activity_planning | activity_relationship | ✅ | ✅ |  |
| activity_planning | activity_resource_assignment | ✅ | ✅ |  |
| activity_planning | resource | ✅ | ✅ |  |
| activity_planning | wbs_node | ✅ | ❌ | Excluded from MVM |
| baseline_control | baseline_activity | ✅ | ✅ |  |
| baseline_control | schedule_baseline | ✅ | ✅ |  |
| baseline_control | schedule_calendar | ✅ | ❌ | Excluded from MVM |
| execution_tracking | plan_commitment | ❌ | ✅ | MVM only (stub or new) |
| progress_tracking | lookahead_activity | ✅ | ❌ | Excluded from MVM |
| progress_tracking | lookahead_plan | ✅ | ✅ |  |
| progress_tracking | progress_update | ✅ | ✅ |  |
| risk_delay | delay_event | ✅ | ✅ |  |
| risk_delay | schedule_impact_claim | ✅ | ❌ | Excluded from MVM |
| risk_delay | schedule_risk | ✅ | ❌ | Excluded from MVM |
| risk_delay | scheduled_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-site"></a>
### site

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| construction_activity | concrete_pour | ✅ | ✅ |  |
| construction_activity | earthwork_volume | ✅ | ❌ | Excluded from MVM |
| construction_activity | equipment_deployment | ✅ | ✅ |  |
| construction_activity | field_progress | ✅ | ✅ |  |
| field_operations | crew_deployment | ✅ | ✅ |  |
| field_operations | daily_log | ✅ | ✅ |  |
| field_operations | production_entry | ✅ | ✅ |  |
| field_operations | work_front | ✅ | ✅ |  |
| location_reference | site | ✅ | ✅ |  |
| location_reference | site_location | ✅ | ❌ | Excluded from MVM |
| permit_compliance | instruction | ✅ | ❌ | Excluded from MVM |
| permit_compliance | material_delivery | ✅ | ✅ |  |
| permit_compliance | site_permit | ✅ | ❌ | Excluded from MVM |
| permit_compliance | work_front_assignment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | permit | ❌ | ✅ | MVM only (stub or new) |
| resource_mobilization | mobilization | ❌ | ✅ | MVM only (stub or new) |
| site_setup | lift_plan | ✅ | ❌ | Excluded from MVM |
| site_setup | logistics_plan | ✅ | ❌ | Excluded from MVM |
| site_setup | shift_report | ✅ | ❌ | Excluded from MVM |
| site_setup | site_mobilization | ✅ | ❌ | Excluded from MVM |

<a id="domain-subcontractor"></a>
### subcontractor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_settlement | back_charge | ✅ | ❌ | Domain not in MVM |
| financial_settlement | final_account | ✅ | ❌ | Domain not in MVM |
| performance_administration | performance_scorecard | ✅ | ❌ | Domain not in MVM |
| performance_administration | sub_change_order | ✅ | ❌ | Domain not in MVM |
| performance_administration | sub_time_extension | ✅ | ❌ | Domain not in MVM |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carbon_management | carbon_emission | ✅ | ❌ | Domain not in MVM |
| carbon_management | carbon_offset | ✅ | ❌ | Domain not in MVM |
| carbon_management | carbon_reduction_initiative | ✅ | ❌ | Domain not in MVM |
| carbon_management | carbon_target | ✅ | ❌ | Domain not in MVM |
| carbon_management | embodied_carbon_assessment | ✅ | ❌ | Domain not in MVM |
| carbon_management | emission_factor | ✅ | ❌ | Domain not in MVM |
| carbon_management | emission_source | ✅ | ❌ | Domain not in MVM |
| carbon_management | supply_chain_carbon | ✅ | ❌ | Domain not in MVM |
| esg_reporting | esg_disclosure_item | ✅ | ❌ | Domain not in MVM |
| esg_reporting | esg_report | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | biodiversity_assessment | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | energy_consumption | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | green_certification | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | green_credit | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | sustainable_material | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | water_consumption | ✅ | ❌ | Domain not in MVM |
| social_impact | climate_risk_assessment | ✅ | ❌ | Domain not in MVM |
| social_impact | climate_risk_item | ✅ | ❌ | Domain not in MVM |
| social_impact | social_value_record | ✅ | ❌ | Domain not in MVM |
| social_impact | sustainability_action | ✅ | ❌ | Domain not in MVM |
| social_impact | sustainability_audit | ✅ | ❌ | Domain not in MVM |
| social_impact | sustainability_plan | ✅ | ❌ | Domain not in MVM |
| waste_environmental | disposal_facility | ✅ | ❌ | Domain not in MVM |
| waste_environmental | env_incident | ✅ | ❌ | Domain not in MVM |
| waste_environmental | waste_carrier | ✅ | ❌ | Domain not in MVM |
| waste_environmental | waste_record | ✅ | ❌ | Domain not in MVM |
| waste_environmental | waste_target | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_personnel | apprenticeship_progression | ✅ | ❌ | Excluded from MVM |
| field_personnel | craft_certification | ✅ | ✅ |  |
| field_personnel | craft_worker | ✅ | ✅ |  |
| field_personnel | crew | ✅ | ✅ |  |
| field_personnel | crew_assignment | ✅ | ✅ |  |
| field_personnel | labor_mobilization | ✅ | ❌ | Excluded from MVM |
| field_personnel | site_access_record | ✅ | ❌ | Excluded from MVM |
| labor_tracking | carbon_reduction_participation | ✅ | ❌ | Excluded from MVM |
| labor_tracking | production_rate | ✅ | ❌ | Excluded from MVM |
| labor_tracking | staffing_plan | ✅ | ✅ |  |
| labor_tracking | timesheet | ✅ | ✅ |  |
| labor_tracking | timesheet_line | ✅ | ✅ |  |
| trade_agreements | agency | ✅ | ❌ | Excluded from MVM |
| trade_agreements | agency_labor_order | ✅ | ❌ | Excluded from MVM |
| trade_agreements | labor_agreement | ✅ | ❌ | Excluded from MVM |
| trade_agreements | labor_cost_code | ✅ | ✅ |  |
| trade_agreements | labor_rate | ✅ | ❌ | Excluded from MVM |
| trade_agreements | skill_trade | ✅ | ✅ |  |
