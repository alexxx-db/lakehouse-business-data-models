# Manufacturing Lakehouse Data Models

**Version 2** | Generated on July 03, 2026 at 07:49 AM

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
  - [Automation](#domain-automation)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Engineering](#domain-engineering)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Order](#domain-order)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Production](#domain-production)
  - [Project](#domain-project)
  - [Quality](#domain-quality)
  - [Sales](#domain-sales)
  - [Service](#domain-service)
  - [Supplier](#domain-supplier)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

manufacturing industry enterprise data model.

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
| Domains | 13 | 20 |
| Subdomains | 35 | 80 |
| Products (Tables) | 128 | 413 |
| Attributes (Columns) | 5405 | 17597 |
| Foreign Keys | 744 | 2446 |
| Avg Attributes/Product | 42.2 | 42.6 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| condition_monitoring | calibration_record | ✅ | ✅ |  |
| condition_monitoring | calibration_standard | ✅ | ❌ | Excluded from MVM |
| condition_monitoring | condition_reading | ✅ | ✅ |  |
| condition_monitoring | inspection_checklist | ✅ | ❌ | Excluded from MVM |
| condition_monitoring | inspection_event | ✅ | ❌ | Excluded from MVM |
| equipment_registry | asset_certification | ✅ | ❌ | Excluded from MVM |
| equipment_registry | asset_plant | ✅ | ❌ | Excluded from MVM |
| equipment_registry | asset_warranty | ✅ | ❌ | Excluded from MVM |
| equipment_registry | capex_asset_record | ✅ | ❌ | Excluded from MVM |
| equipment_registry | equipment_allocation | ✅ | ❌ | Excluded from MVM |
| equipment_registry | equipment_register | ✅ | ✅ |  |
| equipment_registry | equipment_shipment | ✅ | ❌ | Excluded from MVM |
| equipment_registry | location | ✅ | ✅ |  |
| equipment_registry | reliability_record | ✅ | ❌ | Excluded from MVM |
| equipment_registry | spare_part | ✅ | ✅ |  |
| maintenance_operations | asset_downtime_event | ✅ | ✅ |  |
| maintenance_operations | asset_pm_schedule | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | asset_work_order | ✅ | ✅ |  |
| maintenance_operations | craft_skill | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | failure_record | ✅ | ✅ |  |
| maintenance_operations | job_plan | ✅ | ✅ |  |
| maintenance_operations | lubrication_route | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | maintenance_strategy | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pm_schedule | ❌ | ✅ | MVM only (stub or new) |
| maintenance_operations | work_order_type | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | compliance_assessment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_applicability | ✅ | ❌ | Excluded from MVM |

<a id="domain-automation"></a>
### automation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| batch_processing | batch_execution | ✅ | ❌ | Domain not in MVM |
| batch_processing | batch_schedule | ✅ | ❌ | Domain not in MVM |
| control_programming | alarm_definition | ✅ | ❌ | Domain not in MVM |
| control_programming | equipment_phase | ✅ | ❌ | Domain not in MVM |
| control_programming | plc_program | ✅ | ❌ | Domain not in MVM |
| control_programming | process_parameter | ✅ | ❌ | Domain not in MVM |
| control_programming | recipe | ✅ | ❌ | Domain not in MVM |
| control_programming | tag_definition | ✅ | ❌ | Domain not in MVM |
| device_infrastructure | control_system | ✅ | ❌ | Domain not in MVM |
| device_infrastructure | device_registry | ✅ | ❌ | Domain not in MVM |
| device_infrastructure | edge_gateway | ✅ | ❌ | Domain not in MVM |
| device_infrastructure | historian_config | ✅ | ❌ | Domain not in MVM |
| device_infrastructure | io_mapping | ✅ | ❌ | Domain not in MVM |
| device_infrastructure | network_segment | ✅ | ❌ | Domain not in MVM |
| device_infrastructure | opc_server | ✅ | ❌ | Domain not in MVM |
| engineering_validation | automation_project | ✅ | ❌ | Domain not in MVM |
| engineering_validation | automation_script | ✅ | ❌ | Domain not in MVM |
| engineering_validation | test_case | ✅ | ❌ | Domain not in MVM |
| engineering_validation | test_procedure | ✅ | ❌ | Domain not in MVM |
| operational_events | alarm_event | ✅ | ❌ | Domain not in MVM |
| operational_events | control_mode_event | ✅ | ❌ | Domain not in MVM |
| operational_events | device_config_snapshot | ✅ | ❌ | Domain not in MVM |
| operational_events | device_connectivity_event | ✅ | ❌ | Domain not in MVM |
| operational_events | firmware_update | ✅ | ❌ | Domain not in MVM |
| operational_events | scada_session | ✅ | ❌ | Domain not in MVM |
| operational_events | setpoint_change | ✅ | ❌ | Domain not in MVM |
| safety_assurance | automation_change_request | ✅ | ❌ | Domain not in MVM |
| safety_assurance | fat_sat_record | ✅ | ❌ | Domain not in MVM |
| safety_assurance | proof_test_record | ✅ | ❌ | Domain not in MVM |
| safety_assurance | safety_function | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_setup | billing_account | ✅ | ✅ |  |
| account_setup | billing_cycle | ✅ | ❌ | Excluded from MVM |
| account_setup | billing_schedule | ✅ | ✅ |  |
| account_setup | credit_limit | ✅ | ✅ |  |
| account_setup | payment_term | ✅ | ✅ |  |
| invoice_management | intercompany_invoice | ✅ | ❌ | Excluded from MVM |
| invoice_management | invoice | ✅ | ✅ |  |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | tax_determination | ✅ | ❌ | Excluded from MVM |
| payment_collections | advance_payment | ✅ | ❌ | Excluded from MVM |
| payment_collections | collections | ✅ | ✅ |  |
| payment_collections | payment | ✅ | ✅ |  |
| payment_collections | write_off | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | dispute | ✅ | ✅ |  |
| revenue_recognition | payment_allocation | ❌ | ✅ | MVM only (stub or new) |
| revenue_recognition | revenue_recognition_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit_event | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_plan | ✅ | ❌ | Domain not in MVM |
| audit_management | compliance_audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | compliance_capa_record | ✅ | ❌ | Domain not in MVM |
| cybersecurity_governance | cybersecurity_assessment | ✅ | ❌ | Domain not in MVM |
| cybersecurity_governance | cybersecurity_control | ✅ | ❌ | Domain not in MVM |
| environmental_stewardship | emission_source | ✅ | ❌ | Domain not in MVM |
| environmental_stewardship | emissions_record | ✅ | ❌ | Domain not in MVM |
| environmental_stewardship | environmental_aspect | ✅ | ❌ | Domain not in MVM |
| environmental_stewardship | facility | ✅ | ❌ | Domain not in MVM |
| environmental_stewardship | hazardous_substance | ✅ | ❌ | Domain not in MVM |
| environmental_stewardship | waste_record | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | compliance_product_certification | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | controlled_document | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | periodic_evaluation | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | permit | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| safety_health | process_hazard | ✅ | ❌ | Domain not in MVM |
| safety_health | safety_checklist | ✅ | ❌ | Domain not in MVM |
| safety_health | safety_incident | ✅ | ❌ | Domain not in MVM |
| safety_health | safety_inspection | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | account_relationship | ✅ | ❌ | Excluded from MVM |
| account_management | account_site | ✅ | ✅ |  |
| account_management | account_team | ✅ | ❌ | Excluded from MVM |
| account_management | address | ✅ | ✅ |  |
| account_management | contact | ❌ | ✅ | MVM only (stub or new) |
| account_management | customer_account | ✅ | ✅ |  |
| account_management | customer_contact | ✅ | ❌ | Excluded from MVM |
| account_management | segment | ✅ | ✅ |  |
| customer_engagement | credit_profile | ✅ | ✅ |  |
| customer_engagement | customer_certification | ✅ | ❌ | Excluded from MVM |
| customer_engagement | customer_document | ✅ | ❌ | Excluded from MVM |
| customer_engagement | customer_entitlement | ✅ | ❌ | Excluded from MVM |
| customer_engagement | customer_lead | ✅ | ❌ | Excluded from MVM |
| customer_engagement | customer_onboarding | ✅ | ❌ | Excluded from MVM |
| customer_engagement | interaction | ✅ | ✅ |  |
| customer_engagement | sla_agreement | ✅ | ❌ | Excluded from MVM |
| sales_engagement | lead | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-engineering"></a>
### engineering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_management | design_review | ✅ | ❌ | Excluded from MVM |
| change_management | ecn | ✅ | ✅ |  |
| change_management | eco | ✅ | ✅ |  |
| change_management | engineering_project | ✅ | ❌ | Excluded from MVM |
| design_documentation | cad_model | ✅ | ✅ |  |
| design_documentation | dfm_analysis | ✅ | ❌ | Excluded from MVM |
| design_documentation | dfmea | ✅ | ❌ | Excluded from MVM |
| design_documentation | drawing | ✅ | ✅ |  |
| product_definition | bom | ✅ | ✅ |  |
| product_definition | component | ✅ | ✅ |  |
| product_definition | configuration_baseline | ✅ | ❌ | Excluded from MVM |
| product_definition | engineering_bom_line | ✅ | ❌ | Excluded from MVM |
| product_definition | engineering_revision | ✅ | ❌ | Excluded from MVM |
| product_definition | engineering_specification | ✅ | ✅ |  |
| product_structure | bom_line | ❌ | ✅ | MVM only (stub or new) |
| product_structure | revision | ❌ | ✅ | MVM only (stub or new) |
| project_execution | project | ❌ | ✅ | MVM only (stub or new) |
| project_execution | project_component_assignment | ❌ | ✅ | MVM only (stub or new) |
| validation_testing | certification_requirement | ✅ | ❌ | Excluded from MVM |
| validation_testing | component_installation | ✅ | ❌ | Excluded from MVM |
| validation_testing | project_material_allocation | ✅ | ❌ | Excluded from MVM |
| validation_testing | test_result | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capital_investment | capex_request | ✅ | ❌ | Domain not in MVM |
| capital_investment | fixed_asset | ✅ | ❌ | Domain not in MVM |
| controlling_structure | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| controlling_structure | allocation_rule | ✅ | ❌ | Domain not in MVM |
| controlling_structure | cost_allocation | ✅ | ❌ | Domain not in MVM |
| controlling_structure | cost_center | ✅ | ❌ | Domain not in MVM |
| controlling_structure | cost_element | ✅ | ❌ | Domain not in MVM |
| controlling_structure | cost_estimate | ✅ | ❌ | Domain not in MVM |
| controlling_structure | cost_object | ✅ | ❌ | Domain not in MVM |
| controlling_structure | internal_order | ✅ | ❌ | Domain not in MVM |
| controlling_structure | profit_center | ✅ | ❌ | Domain not in MVM |
| controlling_structure | statistical_key_figure | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | business_partner | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | company_code | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | ledger | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_item | ✅ | ❌ | Domain not in MVM |
| payables_receivables | bank_account | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | finance_budget | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | financial_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| material_control | lot_batch | ✅ | ✅ |  |
| material_control | material_master | ✅ | ✅ |  |
| material_control | quarantine_stock | ✅ | ❌ | Excluded from MVM |
| material_control | serialized_unit | ✅ | ✅ |  |
| material_control | wip_stock | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | inventory_safety_stock_policy | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | kanban_card | ✅ | ❌ | Excluded from MVM |
| replenishment_planning | replenishment_order | ✅ | ✅ |  |
| stock_tracking | cycle_count | ✅ | ✅ |  |
| stock_tracking | cycle_count_line | ✅ | ✅ |  |
| stock_tracking | stock_balance | ✅ | ✅ |  |
| stock_tracking | stock_movement | ✅ | ✅ |  |
| stock_tracking | stock_valuation | ✅ | ❌ | Excluded from MVM |
| warehouse_management | control_cycle | ✅ | ❌ | Excluded from MVM |
| warehouse_management | inventory_plant | ✅ | ❌ | Excluded from MVM |
| warehouse_management | stock_location | ✅ | ✅ |  |
| warehouse_management | supply_area | ✅ | ❌ | Excluded from MVM |
| warehouse_management | warehouse | ✅ | ✅ |  |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_certification | ✅ | ❌ | Excluded from MVM |
| carrier_management | carrier_contract | ✅ | ✅ |  |
| carrier_management | freight_claim | ✅ | ❌ | Excluded from MVM |
| carrier_management | freight_invoice | ✅ | ❌ | Excluded from MVM |
| carrier_management | freight_rate | ✅ | ❌ | Excluded from MVM |
| network_planning | lane | ✅ | ❌ | Excluded from MVM |
| network_planning | node | ✅ | ❌ | Excluded from MVM |
| network_planning | transport_route | ✅ | ✅ |  |
| shipment_execution | bill_of_lading | ✅ | ✅ |  |
| shipment_execution | delivery_appointment | ✅ | ❌ | Excluded from MVM |
| shipment_execution | delivery_note | ✅ | ✅ |  |
| shipment_execution | freight_order | ✅ | ✅ |  |
| shipment_execution | inbound_delivery | ✅ | ✅ |  |
| shipment_execution | load_plan | ✅ | ❌ | Excluded from MVM |
| shipment_execution | shipment | ✅ | ✅ |  |
| shipment_execution | shipment_leg | ✅ | ❌ | Excluded from MVM |
| shipment_execution | shipment_tracking_event | ✅ | ❌ | Excluded from MVM |
| trade_compliance | customs_broker | ✅ | ❌ | Excluded from MVM |
| trade_compliance | customs_declaration | ✅ | ❌ | Excluded from MVM |
| trade_compliance | dangerous_goods_declaration | ✅ | ❌ | Excluded from MVM |
| trade_compliance | trade_compliance_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fulfillment_execution | delivery | ✅ | ✅ |  |
| fulfillment_execution | delivery_item | ✅ | ✅ |  |
| fulfillment_execution | fulfillment_sla | ✅ | ✅ |  |
| fulfillment_execution | goods_issue | ✅ | ✅ |  |
| fulfillment_execution | proof_of_delivery | ✅ | ❌ | Excluded from MVM |
| order_management | amendment | ✅ | ❌ | Excluded from MVM |
| order_management | blanket_order | ✅ | ❌ | Excluded from MVM |
| order_management | blanket_order_release | ✅ | ❌ | Excluded from MVM |
| order_management | condition_type | ✅ | ❌ | Excluded from MVM |
| order_management | header | ❌ | ✅ | MVM only (stub or new) |
| order_management | hold | ✅ | ❌ | Excluded from MVM |
| order_management | line | ✅ | ✅ |  |
| order_management | order_header | ✅ | ❌ | Excluded from MVM |
| order_management | order_status_event | ✅ | ❌ | Excluded from MVM |
| order_management | pricing_condition | ✅ | ✅ |  |
| order_management | schedule_line | ✅ | ✅ |  |
| return_processing | rma | ❌ | ✅ | MVM only (stub or new) |
| returns_processing | order_rma | ✅ | ❌ | Excluded from MVM |
| returns_processing | rma_line | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_management | invoice_line_item | ✅ | ❌ | Excluded from MVM |
| invoice_management | spend_record | ✅ | ❌ | Excluded from MVM |
| invoice_management | supplier_invoice | ✅ | ✅ |  |
| purchase_execution | approval_workflow | ✅ | ❌ | Excluded from MVM |
| purchase_execution | contract_release_order | ✅ | ✅ |  |
| purchase_execution | po_line_item | ✅ | ✅ |  |
| purchase_execution | procurement_goods_receipt | ✅ | ✅ |  |
| purchase_execution | purchase_order | ✅ | ✅ |  |
| purchase_execution | purchase_requisition | ✅ | ✅ |  |
| purchase_execution | service_entry_sheet | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | commodity_category | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | procurement_contract | ✅ | ✅ |  |
| sourcing_strategy | purchase_info_record | ✅ | ✅ |  |
| sourcing_strategy | rfq | ✅ | ✅ |  |
| sourcing_strategy | source_list | ✅ | ✅ |  |
| sourcing_strategy | sourcing_event | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | sourcing_strategy | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | supplier_quotation | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_certification | order_line | ✅ | ✅ |  |
| compliance_certification | product_certification | ✅ | ❌ | Excluded from MVM |
| compliance_certification | supply_agreement | ✅ | ❌ | Excluded from MVM |
| engineering_change | change_order | ✅ | ❌ | Excluded from MVM |
| engineering_change | product_revision | ✅ | ❌ | Excluded from MVM |
| engineering_change | product_specification | ✅ | ✅ |  |
| product_master | catalog_entry | ✅ | ✅ |  |
| product_master | classification | ✅ | ✅ |  |
| product_master | family | ✅ | ✅ |  |
| product_master | lifecycle_stage | ✅ | ✅ |  |
| product_master | plant_data | ✅ | ✅ |  |
| product_master | sku_master | ✅ | ✅ |  |
| structure_configuration | bom_header | ✅ | ❌ | Excluded from MVM |
| structure_configuration | bundle | ✅ | ❌ | Excluded from MVM |
| structure_configuration | configuration | ✅ | ✅ |  |
| structure_configuration | option_set | ✅ | ❌ | Excluded from MVM |
| structure_configuration | product_bom_line | ✅ | ❌ | Excluded from MVM |
| structure_configuration | substitution | ✅ | ❌ | Excluded from MVM |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| resource_configuration | plant | ❌ | ✅ | MVM only (stub or new) |
| resource_configuration | routing_tool_assignment | ❌ | ✅ | MVM only (stub or new) |
| resource_master | production_line | ✅ | ✅ |  |
| resource_master | resource_tool | ✅ | ✅ |  |
| resource_master | routing | ✅ | ✅ |  |
| resource_master | version | ✅ | ❌ | Excluded from MVM |
| resource_master | work_center | ✅ | ✅ |  |
| resource_master | work_center_group | ✅ | ❌ | Excluded from MVM |
| shift_planning | calendar | ✅ | ❌ | Excluded from MVM |
| shift_planning | production_downtime_event | ✅ | ✅ |  |
| shift_planning | production_schedule | ✅ | ✅ |  |
| shift_planning | shift | ✅ | ✅ |  |
| shift_planning | shift_report | ✅ | ❌ | Excluded from MVM |
| shift_planning | shift_sequence | ✅ | ❌ | Excluded from MVM |
| work_execution | bom_consumption | ✅ | ✅ |  |
| work_execution | order_confirmation | ✅ | ❌ | Excluded from MVM |
| work_execution | production_goods_receipt | ✅ | ✅ |  |
| work_execution | production_plant | ✅ | ❌ | Excluded from MVM |
| work_execution | production_work_order | ✅ | ✅ |  |
| work_execution | run | ✅ | ❌ | Excluded from MVM |
| work_execution | wip_lot | ✅ | ✅ |  |
| work_execution | work_order_allocation | ✅ | ❌ | Excluded from MVM |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_control | commitment | ✅ | ❌ | Domain not in MVM |
| cost_control | cost_actual | ✅ | ❌ | Domain not in MVM |
| cost_control | earned_value_record | ✅ | ❌ | Domain not in MVM |
| cost_control | invoice_request | ✅ | ❌ | Domain not in MVM |
| cost_control | procurement_item | ✅ | ❌ | Domain not in MVM |
| cost_control | project_budget | ✅ | ❌ | Domain not in MVM |
| cost_control | settlement | ✅ | ❌ | Domain not in MVM |
| delivery_closeout | commissioning_checklist | ✅ | ❌ | Domain not in MVM |
| delivery_closeout | handover | ✅ | ❌ | Domain not in MVM |
| delivery_closeout | project_contract | ✅ | ❌ | Domain not in MVM |
| delivery_closeout | project_document | ✅ | ❌ | Domain not in MVM |
| delivery_closeout | punch_list_item | ✅ | ❌ | Domain not in MVM |
| project_governance | gate_review | ✅ | ❌ | Domain not in MVM |
| project_governance | issue | ✅ | ❌ | Domain not in MVM |
| project_governance | phase | ✅ | ❌ | Domain not in MVM |
| project_governance | plan_version | ✅ | ❌ | Domain not in MVM |
| project_governance | project_change_request | ✅ | ❌ | Domain not in MVM |
| project_governance | project_header | ✅ | ❌ | Domain not in MVM |
| project_governance | project_status_event | ✅ | ❌ | Domain not in MVM |
| project_governance | wbs_element | ✅ | ❌ | Domain not in MVM |
| schedule_execution | activity | ✅ | ❌ | Domain not in MVM |
| schedule_execution | milestone | ✅ | ❌ | Domain not in MVM |
| schedule_execution | progress_report | ✅ | ❌ | Domain not in MVM |
| schedule_execution | resource_assignment | ✅ | ❌ | Domain not in MVM |
| schedule_execution | team_member | ✅ | ❌ | Domain not in MVM |
| schedule_execution | timesheet | ✅ | ❌ | Domain not in MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_assurance | audit_checklist | ✅ | ❌ | Excluded from MVM |
| audit_assurance | audit_program | ✅ | ❌ | Excluded from MVM |
| audit_assurance | quality_audit | ✅ | ❌ | Excluded from MVM |
| audit_assurance | supplier_quality_audit | ✅ | ❌ | Excluded from MVM |
| inspection_control | control_plan | ✅ | ✅ |  |
| inspection_control | inspection_characteristic | ✅ | ✅ |  |
| inspection_control | inspection_lot | ✅ | ✅ |  |
| inspection_control | inspection_plan | ✅ | ✅ |  |
| inspection_control | inspection_result | ✅ | ✅ |  |
| inspection_control | measurement_system | ✅ | ❌ | Excluded from MVM |
| inspection_control | spc | ✅ | ❌ | Excluded from MVM |
| nonconformance_management | capa | ✅ | ✅ |  |
| nonconformance_management | customer_complaint | ✅ | ✅ |  |
| nonconformance_management | ncr | ✅ | ✅ |  |
| nonconformance_management | notification | ✅ | ❌ | Excluded from MVM |
| nonconformance_management | rma_disposition | ✅ | ✅ |  |
| risk_planning | apqp_project | ✅ | ❌ | Excluded from MVM |
| risk_planning | certificate_of_conformance | ✅ | ✅ |  |
| risk_planning | compliance_test | ✅ | ❌ | Excluded from MVM |
| risk_planning | fmea | ✅ | ✅ |  |
| risk_planning | ppap_submission | ✅ | ✅ |  |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_revenue | device_contract_assignment | ✅ | ❌ | Excluded from MVM |
| contract_revenue | forecast | ✅ | ❌ | Excluded from MVM |
| contract_revenue | order_intake | ✅ | ✅ |  |
| contract_revenue | sales_contract | ✅ | ✅ |  |
| partner_channels | campaign | ✅ | ❌ | Excluded from MVM |
| partner_channels | channel_partner | ✅ | ❌ | Excluded from MVM |
| pipeline_management | opportunity | ✅ | ✅ |  |
| pipeline_management | opportunity_component | ✅ | ❌ | Excluded from MVM |
| pipeline_management | proposal | ✅ | ❌ | Excluded from MVM |
| pipeline_management | sales_lead | ✅ | ❌ | Excluded from MVM |
| quote_pricing | discount_schedule | ✅ | ❌ | Excluded from MVM |
| quote_pricing | price_book | ✅ | ✅ |  |
| quote_pricing | price_book_entry | ✅ | ✅ |  |
| quote_pricing | quote | ✅ | ✅ |  |
| quote_pricing | quote_line | ✅ | ✅ |  |
| quote_pricing | quote_template | ✅ | ❌ | Excluded from MVM |
| territory_coverage | project_rep_assignment | ✅ | ❌ | Excluded from MVM |
| territory_coverage | quota | ✅ | ❌ | Excluded from MVM |
| territory_coverage | rep | ✅ | ✅ |  |
| territory_coverage | sales_team | ✅ | ❌ | Excluded from MVM |
| territory_coverage | territory | ✅ | ❌ | Excluded from MVM |
| territory_coverage | territory_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_entitlement | installed_base | ✅ | ❌ | Domain not in MVM |
| asset_entitlement | service_entitlement | ✅ | ❌ | Domain not in MVM |
| asset_entitlement | service_pm_schedule | ✅ | ❌ | Domain not in MVM |
| contract_coverage | contract_line | ✅ | ❌ | Domain not in MVM |
| contract_coverage | service_contract | ✅ | ❌ | Domain not in MVM |
| contract_coverage | service_contract_line | ✅ | ❌ | Domain not in MVM |
| contract_coverage | service_warranty | ✅ | ❌ | Domain not in MVM |
| field_operations | engineer | ✅ | ❌ | Domain not in MVM |
| field_operations | engineer_assignment | ✅ | ❌ | Domain not in MVM |
| field_operations | field_service_order | ✅ | ❌ | Domain not in MVM |
| field_operations | part_consumption | ✅ | ❌ | Domain not in MVM |
| field_operations | task_checklist | ✅ | ❌ | Domain not in MVM |
| field_operations | zone | ✅ | ❌ | Domain not in MVM |
| quality_improvement | satisfaction_survey | ✅ | ❌ | Domain not in MVM |
| quality_improvement | service_capa_record | ✅ | ❌ | Domain not in MVM |
| request_management | holiday_calendar | ✅ | ❌ | Domain not in MVM |
| request_management | request | ✅ | ❌ | Domain not in MVM |
| request_management | service_rma | ✅ | ❌ | Domain not in MVM |
| request_management | sla_milestone | ✅ | ❌ | Domain not in MVM |
| technical_support | bulletin | ✅ | ❌ | Domain not in MVM |
| technical_support | knowledge_article | ✅ | ❌ | Domain not in MVM |
| technical_support | remote_diagnostic_session | ✅ | ❌ | Domain not in MVM |
| technical_support | service_center | ✅ | ❌ | Domain not in MVM |

<a id="domain-supplier"></a>
### supplier

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_findings | supplier_audit | ✅ | ❌ | Domain not in MVM |
| audit_findings | supplier_audit_finding | ✅ | ❌ | Domain not in MVM |
| performance_risk | risk_rating | ✅ | ❌ | Domain not in MVM |
| performance_risk | scorecard | ✅ | ❌ | Domain not in MVM |
| qualification_development | change_notification | ✅ | ❌ | Domain not in MVM |
| qualification_development | corrective_action | ✅ | ❌ | Domain not in MVM |
| qualification_development | development_plan | ✅ | ❌ | Domain not in MVM |
| qualification_development | qualification | ✅ | ❌ | Domain not in MVM |
| qualification_development | supplier_onboarding | ✅ | ❌ | Domain not in MVM |
| vendor_master | agreement | ✅ | ❌ | Domain not in MVM |
| vendor_master | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| vendor_master | site | ✅ | ❌ | Domain not in MVM |
| vendor_master | supplier | ✅ | ❌ | Domain not in MVM |
| vendor_master | supplier_certification | ✅ | ❌ | Domain not in MVM |
| vendor_master | supplier_contact | ✅ | ❌ | Domain not in MVM |
| vendor_master | tooling_asset | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_planning | demand_forecast | ✅ | ✅ |  |
| demand_planning | demand_plan_version | ✅ | ✅ |  |
| demand_planning | mrp_run | ✅ | ✅ |  |
| demand_planning | plan | ✅ | ✅ |  |
| demand_planning | sop_cycle | ✅ | ❌ | Excluded from MVM |
| inventory_positioning | allocation | ✅ | ❌ | Excluded from MVM |
| inventory_positioning | inventory_position | ✅ | ❌ | Excluded from MVM |
| inventory_positioning | replenishment_proposal | ✅ | ❌ | Excluded from MVM |
| inventory_positioning | supply_safety_stock_policy | ✅ | ❌ | Excluded from MVM |
| network_configuration | moq_constraint | ✅ | ❌ | Excluded from MVM |
| network_configuration | network_node | ✅ | ❌ | Excluded from MVM |
| network_configuration | planning_calendar | ✅ | ❌ | Excluded from MVM |
| network_configuration | planning_parameter | ✅ | ❌ | Excluded from MVM |
| network_configuration | sourcing_rule | ✅ | ✅ |  |
| sourcing_policy | safety_stock_policy | ❌ | ✅ | MVM only (stub or new) |
| supply_execution | aps_scenario | ✅ | ❌ | Excluded from MVM |
| supply_execution | aps_schedule | ✅ | ❌ | Excluded from MVM |
| supply_execution | capacity_plan | ✅ | ❌ | Excluded from MVM |
| supply_execution | material_requirement | ✅ | ✅ |  |
| supply_execution | planned_order | ✅ | ✅ |  |
| supply_execution | planning_exception | ✅ | ❌ | Excluded from MVM |
| supply_execution | risk_register | ✅ | ❌ | Excluded from MVM |
| supply_execution | supply_plant | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_records | assignment | ✅ | ❌ | Domain not in MVM |
| employee_records | employee | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | labor_agreement | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| employee_records | requisition | ✅ | ❌ | Domain not in MVM |
| learning_development | certification_type | ✅ | ❌ | Domain not in MVM |
| learning_development | performance_review | ✅ | ❌ | Domain not in MVM |
| learning_development | training_course | ✅ | ❌ | Domain not in MVM |
| learning_development | workforce_certification | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_period | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_result | ✅ | ❌ | Domain not in MVM |
| shift_planning | absence_record | ✅ | ❌ | Domain not in MVM |
| shift_planning | shift_pattern | ✅ | ❌ | Domain not in MVM |
| shift_planning | shift_schedule | ✅ | ❌ | Domain not in MVM |
| shift_planning | time_entry | ✅ | ❌ | Domain not in MVM |
