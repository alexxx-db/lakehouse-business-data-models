# Water_Utilities Lakehouse Data Models

**Version 2** | Generated on July 02, 2026 at 05:00 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Asset](#domain-asset)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Distribution](#domain-distribution)
  - [Finance](#domain-finance)
  - [Laboratory](#domain-laboratory)
  - [Metering](#domain-metering)
  - [Project](#domain-project)
  - [Quality](#domain-quality)
  - [Service](#domain-service)
  - [Supply](#domain-supply)
  - [Treatment](#domain-treatment)
  - [Wastewater](#domain-wastewater)
  - [Workforce](#domain-workforce)


## Business Description

water utilities industry enterprise data model.

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
| Domains | 9 | 15 |
| Subdomains | 21 | 50 |
| Products (Tables) | 85 | 381 |
| Attributes (Columns) | 3997 | 18101 |
| Foreign Keys | 363 | 2553 |
| Avg Attributes/Product | 47.0 | 47.5 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | asset_class | ✅ | ❌ | Excluded from MVM |
| asset_registry | asset_meter | ✅ | ❌ | Excluded from MVM |
| asset_registry | asset_sampling_point | ✅ | ❌ | Excluded from MVM |
| asset_registry | class | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | criticality_rating | ✅ | ❌ | Excluded from MVM |
| asset_registry | document | ✅ | ❌ | Excluded from MVM |
| asset_registry | location | ✅ | ✅ |  |
| asset_registry | registry | ✅ | ✅ |  |
| lifecycle_finance | acquisition | ✅ | ❌ | Excluded from MVM |
| lifecycle_finance | compliance_requirement | ✅ | ❌ | Excluded from MVM |
| lifecycle_finance | depreciation_schedule | ✅ | ❌ | Excluded from MVM |
| lifecycle_finance | disposal | ✅ | ❌ | Excluded from MVM |
| lifecycle_finance | grant_funding | ✅ | ❌ | Excluded from MVM |
| lifecycle_finance | procurement_mapping | ✅ | ❌ | Excluded from MVM |
| lifecycle_finance | warranty | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | condition_assessment | ✅ | ✅ |  |
| maintenance_operations | failure_record | ✅ | ✅ |  |
| maintenance_operations | inspection_checklist | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | inspection_event | ✅ | ✅ |  |
| maintenance_operations | job_plan | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pm_schedule | ✅ | ✅ |  |
| maintenance_operations | prediction_event | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | work_order | ✅ | ✅ |  |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_cycle | billing_account | ✅ | ✅ |  |
| account_cycle | billing_assistance_enrollment | ✅ | ❌ | Excluded from MVM |
| account_cycle | billing_cycle | ✅ | ❌ | Excluded from MVM |
| account_cycle | revenue_recognition_event | ✅ | ❌ | Excluded from MVM |
| collections_enforcement | collection_notice | ✅ | ✅ |  |
| collections_enforcement | delinquency_notice | ✅ | ❌ | Excluded from MVM |
| collections_enforcement | dispute | ✅ | ❌ | Excluded from MVM |
| collections_enforcement | lien | ✅ | ❌ | Excluded from MVM |
| collections_enforcement | payment_plan | ✅ | ✅ |  |
| collections_enforcement | write_off | ✅ | ❌ | Excluded from MVM |
| invoice_payment | adjustment | ✅ | ✅ |  |
| invoice_payment | invoice | ✅ | ✅ |  |
| invoice_payment | invoice_line | ✅ | ✅ |  |
| invoice_payment | payment | ✅ | ✅ |  |
| invoice_payment | payment_application | ✅ | ✅ |  |
| rate_pricing | rate_schedule | ❌ | ✅ | MVM only (stub or new) |
| rate_structure | billing_rate_schedule | ✅ | ❌ | Excluded from MVM |
| rate_structure | rate_component | ✅ | ✅ |  |
| rate_structure | rate_tier | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| enforcement_monitoring | violation | ❌ | ✅ | MVM only (stub or new) |
| enforcement_oversight | compliance_corrective_action | ✅ | ❌ | Excluded from MVM |
| enforcement_oversight | compliance_violation | ✅ | ❌ | Excluded from MVM |
| enforcement_oversight | enforcement_action | ✅ | ✅ |  |
| enforcement_oversight | inspection_finding | ✅ | ❌ | Excluded from MVM |
| enforcement_oversight | overflow_event | ✅ | ❌ | Excluded from MVM |
| enforcement_oversight | regulatory_inspection | ✅ | ✅ |  |
| permit_authorization | compliance_permit | ✅ | ✅ |  |
| permit_authorization | compliance_schedule | ✅ | ❌ | Excluded from MVM |
| permit_authorization | crew_assignment | ✅ | ❌ | Excluded from MVM |
| permit_authorization | industrial_user | ✅ | ❌ | Excluded from MVM |
| permit_authorization | material_compliance_certification | ✅ | ❌ | Excluded from MVM |
| permit_authorization | obligation | ✅ | ❌ | Excluded from MVM |
| permit_authorization | permit_condition | ✅ | ✅ |  |
| permit_authorization | permit_grant_allocation | ✅ | ❌ | Excluded from MVM |
| permit_authorization | permit_vendor_service | ✅ | ❌ | Excluded from MVM |
| permit_authorization | pretreatment_iup | ✅ | ❌ | Excluded from MVM |
| permit_authorization | regulatory_requirement | ✅ | ✅ |  |
| regulatory_reporting | ccr | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | compliance_public_notification | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | dmr | ✅ | ✅ |  |
| regulatory_reporting | dmr_result | ✅ | ✅ |  |
| regulatory_reporting | mor | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_agency | ✅ | ✅ |  |
| regulatory_reporting | regulatory_correspondence | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_submission | ✅ | ❌ | Excluded from MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_asset_responsibility | ✅ | ❌ | Excluded from MVM |
| account_management | account_document | ✅ | ❌ | Excluded from MVM |
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | account_person_rel | ✅ | ❌ | Excluded from MVM |
| account_management | account_status_history | ✅ | ❌ | Excluded from MVM |
| account_management | customer_account | ✅ | ✅ |  |
| account_management | organization | ✅ | ✅ |  |
| account_management | parcel | ✅ | ❌ | Excluded from MVM |
| account_management | person | ✅ | ✅ |  |
| account_management | premise | ✅ | ✅ |  |
| account_management | service_address | ✅ | ✅ |  |
| account_management | service_agreement | ✅ | ✅ |  |
| account_management | service_application | ✅ | ✅ |  |
| customer_engagement | complaint | ❌ | ✅ | MVM only (stub or new) |
| engagement_programs | account_note | ✅ | ❌ | Excluded from MVM |
| engagement_programs | account_segment_assignment | ✅ | ❌ | Excluded from MVM |
| engagement_programs | case | ✅ | ❌ | Excluded from MVM |
| engagement_programs | communication_preference | ✅ | ❌ | Excluded from MVM |
| engagement_programs | contact | ✅ | ❌ | Excluded from MVM |
| engagement_programs | customer_complaint | ✅ | ❌ | Excluded from MVM |
| engagement_programs | interaction | ✅ | ✅ |  |
| engagement_programs | outreach_campaign | ✅ | ❌ | Excluded from MVM |
| engagement_programs | project_stakeholder | ✅ | ❌ | Excluded from MVM |
| engagement_programs | rotation_pool | ✅ | ❌ | Excluded from MVM |
| engagement_programs | segment | ✅ | ❌ | Excluded from MVM |
| engagement_programs | third_party_notification | ✅ | ❌ | Excluded from MVM |
| financial_assistance | account_enforcement_impact | ✅ | ❌ | Excluded from MVM |
| financial_assistance | assistance_program | ✅ | ❌ | Excluded from MVM |
| financial_assistance | customer_assistance_enrollment | ✅ | ❌ | Excluded from MVM |
| financial_assistance | customer_program_enrollment | ✅ | ❌ | Excluded from MVM |
| financial_assistance | deposit | ✅ | ❌ | Excluded from MVM |
| financial_assistance | grant_enrollment | ✅ | ❌ | Excluded from MVM |
| financial_assistance | premise_overflow_impact | ✅ | ❌ | Excluded from MVM |
| financial_assistance | sampling_participation | ✅ | ❌ | Excluded from MVM |
| financial_assistance | sampling_site | ✅ | ❌ | Excluded from MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| maintenance_operations | dma_crew_coverage | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | flushing_event | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | main_break | ✅ | ✅ |  |
| maintenance_operations | network_isolation_event | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pipe_procurement | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | valve_exercise | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | zone_operator_assignment | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | dma | ✅ | ✅ |  |
| network_infrastructure | hydrant | ✅ | ✅ |  |
| network_infrastructure | maintenance_zone | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | network_node | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | network_valve | ✅ | ✅ |  |
| network_infrastructure | pipe_main | ✅ | ✅ |  |
| network_infrastructure | pressure_zone | ✅ | ✅ |  |
| network_infrastructure | prv_station | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | pump_station | ✅ | ✅ |  |
| network_infrastructure | service_line | ✅ | ✅ |  |
| network_infrastructure | storage_tank | ✅ | ✅ |  |
| operational_monitoring | distribution_nrw_water_balance | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | flow_reading | ✅ | ✅ |  |
| operational_monitoring | hydrant_flow_test | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | hydraulic_model_run | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | leak_detection_survey | ✅ | ✅ |  |
| operational_monitoring | network_reading | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | nrw_program | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | pipe_condition_assessment | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | encumbrance | ✅ | ❌ | Domain not in MVM |
| budget_planning | finance_budget | ✅ | ❌ | Domain not in MVM |
| budget_planning | finance_rate_case | ✅ | ❌ | Domain not in MVM |
| budget_planning | fixed_asset | ✅ | ❌ | Domain not in MVM |
| budget_planning | revenue_requirement | ✅ | ❌ | Domain not in MVM |
| debt_grants | debt_instrument | ✅ | ❌ | Domain not in MVM |
| debt_grants | debt_service_payment | ✅ | ❌ | Domain not in MVM |
| debt_grants | drawdown_request | ✅ | ❌ | Domain not in MVM |
| debt_grants | grant | ✅ | ❌ | Domain not in MVM |
| debt_grants | grant_allocation | ✅ | ❌ | Domain not in MVM |
| debt_grants | grant_expenditure | ✅ | ❌ | Domain not in MVM |
| debt_grants | grant_funded_segment | ✅ | ❌ | Domain not in MVM |
| debt_grants | project_funding_allocation | ✅ | ❌ | Domain not in MVM |
| general_accounting | cost_allocation | ✅ | ❌ | Domain not in MVM |
| general_accounting | cost_center | ✅ | ❌ | Domain not in MVM |
| general_accounting | fund | ✅ | ❌ | Domain not in MVM |
| general_accounting | general_ledger | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_accounting | recurring_entry_template | ✅ | ❌ | Domain not in MVM |
| treasury_transactions | ap_invoice | ✅ | ❌ | Domain not in MVM |
| treasury_transactions | ap_payment | ✅ | ❌ | Domain not in MVM |
| treasury_transactions | ar_transaction | ✅ | ❌ | Domain not in MVM |
| treasury_transactions | bank_account | ✅ | ❌ | Domain not in MVM |
| treasury_transactions | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| treasury_transactions | interfund_transfer | ✅ | ❌ | Domain not in MVM |
| treasury_transactions | payment_run | ✅ | ❌ | Domain not in MVM |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accreditation_credentialing | analyst_grant_allocation | ✅ | ❌ | Domain not in MVM |
| accreditation_credentialing | analyst_method_qualification | ✅ | ❌ | Domain not in MVM |
| accreditation_credentialing | analyst_training_completion | ✅ | ❌ | Domain not in MVM |
| accreditation_credentialing | certified_analyst | ✅ | ❌ | Domain not in MVM |
| accreditation_credentialing | lab_accreditation | ✅ | ❌ | Domain not in MVM |
| accreditation_credentialing | lab_accreditation_grant | ✅ | ❌ | Domain not in MVM |
| analytical_testing | analyte | ✅ | ❌ | Domain not in MVM |
| analytical_testing | analytical_test | ✅ | ❌ | Domain not in MVM |
| analytical_testing | calibration_curve | ✅ | ❌ | Domain not in MVM |
| analytical_testing | certificate_of_analysis | ✅ | ❌ | Domain not in MVM |
| analytical_testing | lab_instrument | ✅ | ❌ | Domain not in MVM |
| analytical_testing | laboratory | ✅ | ❌ | Domain not in MVM |
| analytical_testing | method_detection_limit | ✅ | ❌ | Domain not in MVM |
| analytical_testing | method_material_usage | ✅ | ❌ | Domain not in MVM |
| analytical_testing | test_method | ✅ | ❌ | Domain not in MVM |
| analytical_testing | test_result | ✅ | ❌ | Domain not in MVM |
| quality_assurance | laboratory_corrective_action | ✅ | ❌ | Domain not in MVM |
| quality_assurance | laboratory_instrument_calibration | ✅ | ❌ | Domain not in MVM |
| quality_assurance | proficiency_test | ✅ | ❌ | Domain not in MVM |
| quality_assurance | pt_provider | ✅ | ❌ | Domain not in MVM |
| quality_assurance | qc_batch | ✅ | ❌ | Domain not in MVM |
| quality_assurance | qc_sample | ✅ | ❌ | Domain not in MVM |
| quality_assurance | reagent_standard | ✅ | ❌ | Domain not in MVM |
| quality_assurance | result_validation | ✅ | ❌ | Domain not in MVM |
| quality_assurance | validation_batch | ✅ | ❌ | Domain not in MVM |
| sample_management | chain_of_custody | ✅ | ❌ | Domain not in MVM |
| sample_management | lab_sample | ✅ | ❌ | Domain not in MVM |
| sample_management | lab_work_order | ✅ | ❌ | Domain not in MVM |
| sample_management | plan_analyte_requirement | ✅ | ❌ | Domain not in MVM |
| sample_management | sample_collection_event | ✅ | ❌ | Domain not in MVM |
| sample_management | sampling_location | ✅ | ❌ | Domain not in MVM |
| sample_management | sampling_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-metering"></a>
### metering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| anomaly_detection | alert_rule | ✅ | ❌ | Excluded from MVM |
| anomaly_detection | high_usage_alert | ✅ | ✅ |  |
| anomaly_detection | leak_detection_event | ✅ | ❌ | Excluded from MVM |
| anomaly_detection | metering_complaint | ✅ | ❌ | Excluded from MVM |
| anomaly_detection | tamper_event | ✅ | ❌ | Excluded from MVM |
| anomaly_detection | validation_rule | ✅ | ❌ | Excluded from MVM |
| consumption_reads | consumption_profile | ✅ | ❌ | Excluded from MVM |
| consumption_reads | interval_consumption | ✅ | ✅ |  |
| consumption_reads | metering_dma_zone | ✅ | ❌ | Excluded from MVM |
| consumption_reads | metering_nrw_water_balance | ✅ | ❌ | Excluded from MVM |
| consumption_reads | read | ✅ | ✅ |  |
| consumption_reads | read_exception | ✅ | ❌ | Excluded from MVM |
| consumption_reads | read_route | ✅ | ✅ |  |
| field_maintenance | accuracy_test | ✅ | ✅ |  |
| field_maintenance | endpoint_procurement | ✅ | ❌ | Excluded from MVM |
| field_maintenance | meter_field_inspection | ✅ | ❌ | Excluded from MVM |
| field_maintenance | meter_procurement | ✅ | ❌ | Excluded from MVM |
| field_maintenance | replacement_order | ✅ | ❌ | Excluded from MVM |
| field_maintenance | replacement_program | ✅ | ❌ | Excluded from MVM |
| meter_assets | ami_endpoint | ✅ | ✅ |  |
| meter_assets | ami_network_collector | ✅ | ❌ | Excluded from MVM |
| meter_assets | installation | ✅ | ✅ |  |
| meter_assets | meter | ❌ | ✅ | MVM only (stub or new) |
| meter_assets | meter_size_type | ✅ | ❌ | Excluded from MVM |
| meter_assets | metering_meter | ✅ | ❌ | Excluded from MVM |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| construction_delivery | asset_handover | ✅ | ❌ | Domain not in MVM |
| construction_delivery | closeout_record | ✅ | ❌ | Domain not in MVM |
| construction_delivery | commissioning_activity | ✅ | ❌ | Domain not in MVM |
| construction_delivery | construction_submittal | ✅ | ❌ | Domain not in MVM |
| construction_delivery | design_submittal | ✅ | ❌ | Domain not in MVM |
| construction_delivery | inspection_report | ✅ | ❌ | Domain not in MVM |
| construction_delivery | nonconformance_report | ✅ | ❌ | Domain not in MVM |
| construction_delivery | punch_list | ✅ | ❌ | Domain not in MVM |
| construction_delivery | request_for_information | ✅ | ❌ | Domain not in MVM |
| contract_procurement | change_order | ✅ | ❌ | Domain not in MVM |
| contract_procurement | construction_contract | ✅ | ❌ | Domain not in MVM |
| contract_procurement | design_contract | ✅ | ❌ | Domain not in MVM |
| contract_procurement | land_acquisition | ✅ | ❌ | Domain not in MVM |
| contract_procurement | project_permit | ✅ | ❌ | Domain not in MVM |
| financial_funding | budget_amendment | ✅ | ❌ | Domain not in MVM |
| financial_funding | cost_transaction | ✅ | ❌ | Domain not in MVM |
| financial_funding | funding_allocation | ✅ | ❌ | Domain not in MVM |
| financial_funding | funding_source | ✅ | ❌ | Domain not in MVM |
| financial_funding | pay_application | ✅ | ❌ | Domain not in MVM |
| financial_funding | project_budget | ✅ | ❌ | Domain not in MVM |
| project_planning | cip_project | ✅ | ❌ | Domain not in MVM |
| project_planning | issue | ✅ | ❌ | Domain not in MVM |
| project_planning | milestone | ✅ | ❌ | Domain not in MVM |
| project_planning | project_schedule | ✅ | ❌ | Domain not in MVM |
| project_planning | risk | ✅ | ❌ | Domain not in MVM |
| project_planning | wbs_element | ✅ | ❌ | Domain not in MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contaminant_standards | bacteriological_result | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | contaminant | ✅ | ✅ |  |
| contaminant_standards | contaminant_group | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | contaminant_limit | ✅ | ✅ |  |
| contaminant_standards | dbp_monitoring_event | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | fog_monitoring_event | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | iup_monitoring_result | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | lead_copper_result | ✅ | ✅ |  |
| contaminant_standards | monitoring_context | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | pfas_compound | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | pfas_monitoring | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | territory_contaminant_monitoring_requirement | ✅ | ❌ | Excluded from MVM |
| contaminant_standards | water_system | ✅ | ❌ | Excluded from MVM |
| instrument_calibration | online_instrument | ✅ | ❌ | Excluded from MVM |
| instrument_calibration | qaqc_batch | ✅ | ❌ | Excluded from MVM |
| instrument_calibration | quality_instrument_calibration | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | ccr_contaminant_disclosure | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | ccr_detected_contaminant | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | ccr_period | ✅ | ✅ |  |
| regulatory_compliance | compliance_determination | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | exceedance | ✅ | ✅ |  |
| regulatory_compliance | monitoring_waiver | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | quality_public_notification | ✅ | ❌ | Excluded from MVM |
| sampling_monitoring | sampling_point | ❌ | ✅ | MVM only (stub or new) |
| sampling_operations | analytical_result | ✅ | ✅ |  |
| sampling_operations | ct_calculation | ✅ | ❌ | Excluded from MVM |
| sampling_operations | effluent_quality | ✅ | ❌ | Excluded from MVM |
| sampling_operations | quality_sampling_point | ✅ | ❌ | Excluded from MVM |
| sampling_operations | residual_chlorine_reading | ✅ | ❌ | Excluded from MVM |
| sampling_operations | sampling_round | ✅ | ❌ | Excluded from MVM |
| sampling_operations | sampling_schedule | ✅ | ✅ |  |
| sampling_operations | source_water_quality | ✅ | ❌ | Excluded from MVM |
| sampling_operations | turbidity_reading | ✅ | ❌ | Excluded from MVM |
| sampling_operations | water_sample | ✅ | ✅ |  |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_programs | affordability_plan | ✅ | ❌ | Domain not in MVM |
| customer_programs | conservation_program | ✅ | ❌ | Domain not in MVM |
| customer_programs | program_material_eligibility | ✅ | ❌ | Domain not in MVM |
| customer_programs | service_program_enrollment | ✅ | ❌ | Domain not in MVM |
| rate_regulation | bulk_water_agreement | ✅ | ❌ | Domain not in MVM |
| rate_regulation | service_rate_case | ✅ | ❌ | Domain not in MVM |
| rate_regulation | service_rate_schedule | ✅ | ❌ | Domain not in MVM |
| rate_regulation | special_contract | ✅ | ❌ | Domain not in MVM |
| rate_regulation | tariff | ✅ | ❌ | Domain not in MVM |
| service_catalog | agreement | ✅ | ❌ | Domain not in MVM |
| service_catalog | connection_application | ✅ | ❌ | Domain not in MVM |
| service_catalog | offering | ✅ | ❌ | Domain not in MVM |
| service_catalog | offering_territory_availability | ✅ | ❌ | Domain not in MVM |
| service_catalog | order | ✅ | ❌ | Domain not in MVM |
| service_catalog | point | ✅ | ❌ | Domain not in MVM |
| service_catalog | service_class | ✅ | ❌ | Domain not in MVM |
| service_catalog | sla_definition | ✅ | ❌ | Domain not in MVM |
| service_catalog | territory | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_materials | goods_receipt | ✅ | ❌ | Domain not in MVM |
| inventory_materials | inventory_stock | ✅ | ❌ | Domain not in MVM |
| inventory_materials | material_master | ✅ | ❌ | Domain not in MVM |
| inventory_materials | material_requisition | ✅ | ❌ | Domain not in MVM |
| inventory_materials | stock_movement | ✅ | ❌ | Domain not in MVM |
| inventory_materials | warehouse_location | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | po_line_item | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | procurement_category | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | rfq | ✅ | ❌ | Domain not in MVM |
| procurement_sourcing | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| vendor_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| vendor_management | procurement_contract | ✅ | ❌ | Domain not in MVM |
| vendor_management | project_vendor_engagement | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_performance | ✅ | ❌ | Domain not in MVM |

<a id="domain-treatment"></a>
### treatment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capital_contracts | chemical_supply_agreement | ✅ | ❌ | Excluded from MVM |
| capital_contracts | facility_project | ✅ | ❌ | Excluded from MVM |
| capital_contracts | facility_service_allocation | ✅ | ❌ | Excluded from MVM |
| facility_assets | chemical | ✅ | ✅ |  |
| facility_assets | chemical_inventory | ✅ | ❌ | Excluded from MVM |
| facility_assets | discharge_point | ✅ | ✅ |  |
| facility_assets | facility | ✅ | ✅ |  |
| facility_assets | filter_unit | ✅ | ❌ | Excluded from MVM |
| facility_assets | process_control_setpoint | ✅ | ❌ | Excluded from MVM |
| facility_assets | process_unit | ✅ | ✅ |  |
| facility_assets | scada_tag | ✅ | ❌ | Excluded from MVM |
| facility_assets | treatment_technology | ✅ | ❌ | Excluded from MVM |
| facility_assets | water_source | ✅ | ✅ |  |
| process_operations | backwash_event | ✅ | ❌ | Excluded from MVM |
| process_operations | chemical_dose_event | ✅ | ✅ |  |
| process_operations | ct_compliance_record | ✅ | ✅ |  |
| process_operations | filter_run | ✅ | ❌ | Excluded from MVM |
| process_operations | finished_water_production | ✅ | ✅ |  |
| process_operations | membrane_performance | ✅ | ❌ | Excluded from MVM |
| process_operations | process_maintenance_plan | ✅ | ❌ | Excluded from MVM |
| process_operations | process_reading | ✅ | ✅ |  |
| process_operations | sludge_production | ✅ | ❌ | Excluded from MVM |
| process_operations | source_water_intake | ✅ | ✅ |  |
| process_operations | uv_disinfection_event | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | mor_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | operator_qualification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | permit_compliance_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | process_compliance_monitoring | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | treatment_permit | ✅ | ✅ |  |
| regulatory_compliance | treatment_violation | ✅ | ❌ | Excluded from MVM |

<a id="domain-wastewater"></a>
### wastewater

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| collection_system | collection_system_blockage | ✅ | ❌ | Excluded from MVM |
| collection_system | ii_flow_measurement | ✅ | ❌ | Excluded from MVM |
| collection_system | ii_monitoring_point | ✅ | ❌ | Excluded from MVM |
| collection_system | lift_station | ✅ | ❌ | Excluded from MVM |
| collection_system | manhole | ✅ | ✅ |  |
| collection_system | sewer_inspection | ✅ | ❌ | Excluded from MVM |
| collection_system | sewer_network | ✅ | ✅ |  |
| collection_system | sewer_repair | ✅ | ❌ | Excluded from MVM |
| collection_system | sewer_service_connection | ✅ | ✅ |  |
| collection_system | sses_study | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | cso_event | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | dmr_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | fog_inspection | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | fog_source | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | grease_interceptor | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | industrial_user_permit | ✅ | ✅ |  |
| regulatory_compliance | iup_compliance_sample | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | sso_event | ✅ | ✅ |  |
| treatment_operations | biosolids_batch | ✅ | ✅ |  |
| treatment_operations | biosolids_land_application | ✅ | ❌ | Excluded from MVM |
| treatment_operations | effluent_discharge_event | ✅ | ✅ |  |
| treatment_operations | effluent_parameter_result | ✅ | ✅ |  |
| treatment_operations | facility_grant_allocation | ✅ | ❌ | Excluded from MVM |
| treatment_operations | facility_vendor_contract | ✅ | ❌ | Excluded from MVM |
| treatment_operations | land_application_site | ✅ | ❌ | Excluded from MVM |
| treatment_operations | outfall | ✅ | ❌ | Excluded from MVM |
| treatment_operations | wwtp | ✅ | ✅ |  |
| watershed_management | sewershed_basin | ✅ | ❌ | Excluded from MVM |
| watershed_management | storm_event | ✅ | ❌ | Excluded from MVM |
| watershed_management | watershed | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_operations | crew | ✅ | ❌ | Domain not in MVM |
| field_operations | field_service_dispatch | ✅ | ❌ | Domain not in MVM |
| field_operations | labor_timesheet | ✅ | ❌ | Domain not in MVM |
| field_operations | shift_assignment | ✅ | ❌ | Domain not in MVM |
| field_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| field_operations | swap_request | ✅ | ❌ | Domain not in MVM |
| training_credentialing | certification | ✅ | ❌ | Domain not in MVM |
| training_credentialing | operator_license | ✅ | ❌ | Domain not in MVM |
| training_credentialing | safety_incident | ✅ | ❌ | Domain not in MVM |
| training_credentialing | training_course | ✅ | ❌ | Domain not in MVM |
| training_credentialing | training_record | ✅ | ❌ | Domain not in MVM |
| workforce_administration | employee | ✅ | ❌ | Domain not in MVM |
| workforce_administration | labor_relations_case | ✅ | ❌ | Domain not in MVM |
| workforce_administration | labor_union | ✅ | ❌ | Domain not in MVM |
| workforce_administration | leave_request | ✅ | ❌ | Domain not in MVM |
| workforce_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_administration | performance_review | ✅ | ❌ | Domain not in MVM |
| workforce_administration | position | ✅ | ❌ | Domain not in MVM |
