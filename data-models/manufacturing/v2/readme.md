# Manufacturing Lakehouse Data Models

**Version 2** | Generated on July 10, 2026 at 02:44 PM

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
| Subdomains | 32 | 78 |
| Products (Tables) | 114 | 414 |
| Attributes (Columns) | 4766 | 15566 |
| Foreign Keys | 860 | 2288 |
| Avg Attributes/Product | 41.8 | 37.6 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_lifecycle | asset_certification | ✅ | ❌ | Excluded from MVM |
| asset_lifecycle | asset_warranty | ✅ | ❌ | Excluded from MVM |
| asset_lifecycle | capex_asset_record | ✅ | ❌ | Excluded from MVM |
| asset_lifecycle | equipment_allocation | ✅ | ❌ | Excluded from MVM |
| asset_lifecycle | equipment_shipment | ✅ | ❌ | Excluded from MVM |
| asset_lifecycle | spare_part | ✅ | ✅ |  |
| equipment_registry | asset_plant | ✅ | ✅ |  |
| equipment_registry | equipment_register | ✅ | ✅ |  |
| equipment_registry | location | ✅ | ✅ |  |
| maintenance_operations | asset_downtime_event | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | asset_pm_schedule | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | asset_work_order | ✅ | ✅ |  |
| maintenance_operations | craft_skill | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | failure_record | ✅ | ✅ |  |
| maintenance_operations | job_plan | ✅ | ✅ |  |
| maintenance_operations | job_plan_material_requirement | ❌ | ✅ | MVM only (stub or new) |
| maintenance_operations | lubrication_route | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | maintenance_strategy | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pm_parts_requirement | ❌ | ✅ | MVM only (stub or new) |
| maintenance_operations | pm_schedule | ❌ | ✅ | MVM only (stub or new) |
| maintenance_operations | work_order_type | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | compliance_assessment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_applicability | ✅ | ❌ | Excluded from MVM |
| reliability_monitoring | calibration_record | ✅ | ✅ |  |
| reliability_monitoring | calibration_standard | ✅ | ❌ | Excluded from MVM |
| reliability_monitoring | condition_reading | ✅ | ❌ | Excluded from MVM |
| reliability_monitoring | inspection_checklist | ✅ | ❌ | Excluded from MVM |
| reliability_monitoring | inspection_event | ✅ | ❌ | Excluded from MVM |
| reliability_monitoring | reliability_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-automation"></a>
### automation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| batch_production | batch_execution | ✅ | ❌ | Domain not in MVM |
| batch_production | batch_schedule | ✅ | ❌ | Domain not in MVM |
| control_programming | alarm_definition | ✅ | ❌ | Domain not in MVM |
| control_programming | automation_script | ✅ | ❌ | Domain not in MVM |
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
| operational_events | alarm_event | ✅ | ❌ | Domain not in MVM |
| operational_events | control_mode_event | ✅ | ❌ | Domain not in MVM |
| operational_events | device_config_snapshot | ✅ | ❌ | Domain not in MVM |
| operational_events | device_connectivity_event | ✅ | ❌ | Domain not in MVM |
| operational_events | firmware_update | ✅ | ❌ | Domain not in MVM |
| operational_events | scada_session | ✅ | ❌ | Domain not in MVM |
| operational_events | setpoint_change | ✅ | ❌ | Domain not in MVM |
| project_management | automation_change_request | ✅ | ❌ | Domain not in MVM |
| project_management | automation_project | ✅ | ❌ | Domain not in MVM |
| safety_assurance | fat_sat_record | ✅ | ❌ | Domain not in MVM |
| safety_assurance | proof_test_record | ✅ | ❌ | Domain not in MVM |
| safety_assurance | safety_function | ✅ | ❌ | Domain not in MVM |
| safety_assurance | test_case | ✅ | ❌ | Domain not in MVM |
| safety_assurance | test_procedure | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_scheduling | billing_account | ✅ | ✅ |  |
| account_scheduling | billing_cycle | ✅ | ❌ | Excluded from MVM |
| account_scheduling | billing_schedule | ✅ | ❌ | Excluded from MVM |
| account_scheduling | credit_limit | ✅ | ✅ |  |
| cash_application | payment_application | ❌ | ✅ | MVM only (stub or new) |
| invoice_management | intercompany_invoice | ✅ | ❌ | Excluded from MVM |
| invoice_management | invoice | ✅ | ✅ |  |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | tax_determination | ✅ | ✅ |  |
| payment_collections | advance_payment | ✅ | ❌ | Excluded from MVM |
| payment_collections | collections | ✅ | ❌ | Excluded from MVM |
| payment_collections | payment | ✅ | ✅ |  |
| payment_collections | write_off | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | dispute | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | payment_term | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | revenue_recognition_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit_event | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_plan | ✅ | ❌ | Domain not in MVM |
| audit_management | compliance_audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | compliance_capa_record | ✅ | ❌ | Domain not in MVM |
| audit_management | controlled_document | ✅ | ❌ | Domain not in MVM |
| cybersecurity_certification | compliance_product_certification | ✅ | ❌ | Domain not in MVM |
| cybersecurity_certification | cybersecurity_assessment | ✅ | ❌ | Domain not in MVM |
| cybersecurity_certification | cybersecurity_control | ✅ | ❌ | Domain not in MVM |
| cybersecurity_certification | hazardous_substance | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | periodic_evaluation | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | permit | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| safety_environmental | emission_source | ✅ | ❌ | Domain not in MVM |
| safety_environmental | emissions_record | ✅ | ❌ | Domain not in MVM |
| safety_environmental | environmental_aspect | ✅ | ❌ | Domain not in MVM |
| safety_environmental | facility | ✅ | ❌ | Domain not in MVM |
| safety_environmental | process_hazard | ✅ | ❌ | Domain not in MVM |
| safety_environmental | safety_checklist | ✅ | ❌ | Domain not in MVM |
| safety_environmental | safety_incident | ✅ | ❌ | Domain not in MVM |
| safety_environmental | safety_inspection | ✅ | ❌ | Domain not in MVM |
| safety_environmental | waste_record | ✅ | ❌ | Domain not in MVM |

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
| engagement_lifecycle | credit_profile | ✅ | ✅ |  |
| engagement_lifecycle | customer_certification | ✅ | ❌ | Excluded from MVM |
| engagement_lifecycle | customer_document | ✅ | ❌ | Excluded from MVM |
| engagement_lifecycle | customer_entitlement | ✅ | ❌ | Excluded from MVM |
| engagement_lifecycle | customer_lead | ✅ | ❌ | Excluded from MVM |
| engagement_lifecycle | customer_onboarding | ✅ | ❌ | Excluded from MVM |
| engagement_lifecycle | interaction | ✅ | ✅ |  |
| engagement_lifecycle | sla_agreement | ✅ | ✅ |  |

<a id="domain-engineering"></a>
### engineering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_governance | certification_requirement | ✅ | ❌ | Excluded from MVM |
| change_governance | design_review | ✅ | ❌ | Excluded from MVM |
| change_governance | dfm_analysis | ✅ | ❌ | Excluded from MVM |
| change_governance | dfmea | ✅ | ❌ | Excluded from MVM |
| change_governance | ecn | ✅ | ❌ | Excluded from MVM |
| change_governance | eco | ✅ | ✅ |  |
| change_governance | engineering_project | ✅ | ❌ | Excluded from MVM |
| change_governance | test_result | ✅ | ✅ |  |
| change_management | eco_affected_item | ❌ | ✅ | MVM only (stub or new) |
| development_initiatives | project | ❌ | ✅ | MVM only (stub or new) |
| product_design | bom | ✅ | ✅ |  |
| product_design | cad_model | ✅ | ✅ |  |
| product_design | component | ✅ | ✅ |  |
| product_design | component_installation | ✅ | ❌ | Excluded from MVM |
| product_design | configuration_baseline | ✅ | ❌ | Excluded from MVM |
| product_design | drawing | ✅ | ✅ |  |
| product_design | engineering_bom_line | ✅ | ✅ |  |
| product_design | engineering_revision | ✅ | ❌ | Excluded from MVM |
| product_design | engineering_specification | ✅ | ✅ |  |
| product_design | project_material_allocation | ✅ | ❌ | Excluded from MVM |
| product_structure | revision | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_treasury | bank_account | ✅ | ❌ | Domain not in MVM |
| asset_treasury | business_partner | ✅ | ❌ | Domain not in MVM |
| asset_treasury | fixed_asset | ✅ | ❌ | Domain not in MVM |
| controlling_master | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| controlling_master | allocation_rule | ✅ | ❌ | Domain not in MVM |
| controlling_master | cost_allocation | ✅ | ❌ | Domain not in MVM |
| controlling_master | cost_center | ✅ | ❌ | Domain not in MVM |
| controlling_master | cost_element | ✅ | ❌ | Domain not in MVM |
| controlling_master | cost_estimate | ✅ | ❌ | Domain not in MVM |
| controlling_master | cost_object | ✅ | ❌ | Domain not in MVM |
| controlling_master | internal_order | ✅ | ❌ | Domain not in MVM |
| controlling_master | profit_center | ✅ | ❌ | Domain not in MVM |
| controlling_master | statistical_key_figure | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | company_code | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | ledger | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_item | ✅ | ❌ | Domain not in MVM |
| planning_budgeting | capex_request | ✅ | ❌ | Domain not in MVM |
| planning_budgeting | finance_budget | ✅ | ❌ | Domain not in MVM |
| planning_budgeting | financial_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cycle_counting | cycle_count | ✅ | ✅ |  |
| cycle_counting | cycle_count_line | ✅ | ❌ | Excluded from MVM |
| material_control | lot_batch | ✅ | ✅ |  |
| material_control | material_master | ✅ | ✅ |  |
| material_control | quarantine_stock | ✅ | ❌ | Excluded from MVM |
| material_control | serialized_unit | ✅ | ❌ | Excluded from MVM |
| material_control | wip_stock | ✅ | ❌ | Excluded from MVM |
| movement_replenishment | kanban_card | ✅ | ❌ | Excluded from MVM |
| movement_replenishment | replenishment_order | ✅ | ✅ |  |
| movement_replenishment | stock_movement | ✅ | ✅ |  |
| stock_valuation | inventory_safety_stock_policy | ✅ | ❌ | Excluded from MVM |
| stock_valuation | stock_balance | ✅ | ✅ |  |
| stock_valuation | stock_valuation | ✅ | ❌ | Excluded from MVM |
| warehouse_management | control_cycle | ✅ | ❌ | Excluded from MVM |
| warehouse_management | inventory_plant | ✅ | ✅ |  |
| warehouse_management | stock_location | ✅ | ✅ |  |
| warehouse_management | supply_area | ✅ | ❌ | Excluded from MVM |
| warehouse_management | warehouse | ✅ | ✅ |  |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_network | carrier | ✅ | ❌ | Domain not in MVM |
| carrier_network | carrier_certification | ✅ | ❌ | Domain not in MVM |
| carrier_network | carrier_contract | ✅ | ❌ | Domain not in MVM |
| carrier_network | lane | ✅ | ❌ | Domain not in MVM |
| carrier_network | node | ✅ | ❌ | Domain not in MVM |
| carrier_network | transport_route | ✅ | ❌ | Domain not in MVM |
| freight_management | freight_claim | ✅ | ❌ | Domain not in MVM |
| freight_management | freight_invoice | ✅ | ❌ | Domain not in MVM |
| freight_management | freight_order | ✅ | ❌ | Domain not in MVM |
| freight_management | freight_rate | ✅ | ❌ | Domain not in MVM |
| shipment_execution | bill_of_lading | ✅ | ❌ | Domain not in MVM |
| shipment_execution | delivery_appointment | ✅ | ❌ | Domain not in MVM |
| shipment_execution | delivery_note | ✅ | ❌ | Domain not in MVM |
| shipment_execution | inbound_delivery | ✅ | ❌ | Domain not in MVM |
| shipment_execution | load_plan | ✅ | ❌ | Domain not in MVM |
| shipment_execution | shipment | ✅ | ❌ | Domain not in MVM |
| shipment_execution | shipment_leg | ✅ | ❌ | Domain not in MVM |
| shipment_execution | shipment_tracking_event | ✅ | ❌ | Domain not in MVM |
| trade_compliance | customs_broker | ✅ | ❌ | Domain not in MVM |
| trade_compliance | customs_declaration | ✅ | ❌ | Domain not in MVM |
| trade_compliance | dangerous_goods_declaration | ✅ | ❌ | Domain not in MVM |
| trade_compliance | trade_compliance_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fulfillment_delivery | delivery | ✅ | ✅ |  |
| fulfillment_delivery | delivery_item | ✅ | ✅ |  |
| fulfillment_delivery | fulfillment_sla | ✅ | ❌ | Excluded from MVM |
| fulfillment_delivery | goods_issue | ✅ | ✅ |  |
| fulfillment_delivery | proof_of_delivery | ✅ | ❌ | Excluded from MVM |
| fulfillment_execution | rma | ❌ | ✅ | MVM only (stub or new) |
| lifecycle_planning | order_line | ✅ | ✅ |  |
| order_management | blanket_order | ✅ | ❌ | Excluded from MVM |
| order_management | blanket_order_release | ✅ | ❌ | Excluded from MVM |
| order_management | header | ❌ | ✅ | MVM only (stub or new) |
| order_management | line | ✅ | ❌ | Excluded from MVM |
| order_management | order_amendment | ✅ | ❌ | Excluded from MVM |
| order_management | order_header | ✅ | ❌ | Excluded from MVM |
| order_management | order_hold | ✅ | ❌ | Excluded from MVM |
| order_management | order_status_event | ✅ | ❌ | Excluded from MVM |
| order_management | schedule_line | ✅ | ✅ |  |
| returns_pricing | condition_type | ✅ | ❌ | Excluded from MVM |
| returns_pricing | order_rma | ✅ | ❌ | Excluded from MVM |
| returns_pricing | pricing_condition | ✅ | ✅ |  |
| returns_pricing | rma_line | ✅ | ❌ | Excluded from MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_settlement | invoice_line_item | ✅ | ❌ | Excluded from MVM |
| invoice_settlement | service_entry_sheet | ✅ | ❌ | Excluded from MVM |
| invoice_settlement | spend_record | ✅ | ❌ | Excluded from MVM |
| invoice_settlement | supplier_invoice | ✅ | ✅ |  |
| order_fulfillment | goods_receipt | ❌ | ✅ | MVM only (stub or new) |
| purchase_operations | approval_workflow | ✅ | ❌ | Excluded from MVM |
| purchase_operations | contract_release_order | ✅ | ❌ | Excluded from MVM |
| purchase_operations | po_line_item | ✅ | ✅ |  |
| purchase_operations | procurement_goods_receipt | ✅ | ❌ | Excluded from MVM |
| purchase_operations | purchase_order | ✅ | ✅ |  |
| purchase_operations | purchase_requisition | ✅ | ✅ |  |
| sourcing_strategy | procurement_contract | ✅ | ✅ |  |
| sourcing_strategy | rfq | ✅ | ✅ |  |
| sourcing_strategy | sourcing_event | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | sourcing_strategy | ✅ | ❌ | Excluded from MVM |
| sourcing_strategy | supplier_quotation | ✅ | ✅ |  |
| supplier_master | commodity_category | ✅ | ❌ | Excluded from MVM |
| supplier_master | purchase_info_record | ✅ | ❌ | Excluded from MVM |
| supplier_master | source_list | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assembly_structure | certification | ❌ | ✅ | MVM only (stub or new) |
| catalog_management | bundle | ✅ | ❌ | Excluded from MVM |
| catalog_management | catalog_entry | ✅ | ✅ |  |
| catalog_management | classification | ✅ | ❌ | Excluded from MVM |
| catalog_management | configuration | ✅ | ❌ | Excluded from MVM |
| catalog_management | family | ✅ | ✅ |  |
| catalog_management | option_set | ✅ | ❌ | Excluded from MVM |
| catalog_management | sku_master | ✅ | ✅ |  |
| catalog_management | substitution | ✅ | ❌ | Excluded from MVM |
| engineering_structure | bom_header | ✅ | ✅ |  |
| engineering_structure | change_order | ✅ | ❌ | Excluded from MVM |
| engineering_structure | product_bom_line | ✅ | ✅ |  |
| engineering_structure | product_certification | ✅ | ❌ | Excluded from MVM |
| engineering_structure | product_revision | ✅ | ❌ | Excluded from MVM |
| engineering_structure | product_specification | ✅ | ✅ |  |
| lifecycle_planning | lifecycle_stage | ✅ | ✅ |  |
| lifecycle_planning | plant_data | ✅ | ❌ | Excluded from MVM |
| lifecycle_planning | supply_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capacity_planning | calendar | ✅ | ❌ | Excluded from MVM |
| capacity_planning | production_schedule | ✅ | ❌ | Excluded from MVM |
| capacity_planning | shift | ✅ | ❌ | Excluded from MVM |
| capacity_planning | shift_report | ✅ | ❌ | Excluded from MVM |
| capacity_planning | shift_sequence | ✅ | ❌ | Excluded from MVM |
| order_execution | run | ❌ | ✅ | MVM only (stub or new) |
| planning_resources | schedule | ❌ | ✅ | MVM only (stub or new) |
| resource_master | production_line | ✅ | ✅ |  |
| resource_master | production_plant | ✅ | ✅ |  |
| resource_master | resource_tool | ✅ | ❌ | Excluded from MVM |
| resource_master | routing | ✅ | ✅ |  |
| resource_master | version | ✅ | ❌ | Excluded from MVM |
| resource_master | work_center | ✅ | ✅ |  |
| resource_master | work_center_group | ✅ | ❌ | Excluded from MVM |
| shop_execution | bom_consumption | ✅ | ✅ |  |
| shop_execution | order_confirmation | ✅ | ✅ |  |
| shop_execution | production_downtime_event | ✅ | ❌ | Excluded from MVM |
| shop_execution | production_goods_receipt | ✅ | ❌ | Excluded from MVM |
| shop_execution | production_run | ✅ | ❌ | Excluded from MVM |
| shop_execution | production_work_order | ✅ | ✅ |  |
| shop_execution | wip_lot | ✅ | ✅ |  |
| shop_execution | work_order_allocation | ✅ | ❌ | Excluded from MVM |

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
| cost_control | timesheet | ✅ | ❌ | Domain not in MVM |
| delivery_execution | commissioning_checklist | ✅ | ❌ | Domain not in MVM |
| delivery_execution | handover | ✅ | ❌ | Domain not in MVM |
| delivery_execution | progress_report | ✅ | ❌ | Domain not in MVM |
| delivery_execution | project_document | ✅ | ❌ | Domain not in MVM |
| delivery_execution | project_issue | ✅ | ❌ | Domain not in MVM |
| delivery_execution | punch_list_item | ✅ | ❌ | Domain not in MVM |
| project_governance | gate_review | ✅ | ❌ | Domain not in MVM |
| project_governance | project_change_request | ✅ | ❌ | Domain not in MVM |
| project_governance | project_contract | ✅ | ❌ | Domain not in MVM |
| project_governance | project_header | ✅ | ❌ | Domain not in MVM |
| project_governance | project_phase | ✅ | ❌ | Domain not in MVM |
| project_governance | project_status_event | ✅ | ❌ | Domain not in MVM |
| project_governance | team_member | ✅ | ❌ | Domain not in MVM |
| schedule_planning | activity | ✅ | ❌ | Domain not in MVM |
| schedule_planning | milestone | ✅ | ❌ | Domain not in MVM |
| schedule_planning | plan_version | ✅ | ❌ | Domain not in MVM |
| schedule_planning | resource_assignment | ✅ | ❌ | Domain not in MVM |
| schedule_planning | wbs_element | ✅ | ❌ | Domain not in MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit_checklist | ✅ | ❌ | Excluded from MVM |
| audit_management | audit_program | ✅ | ❌ | Excluded from MVM |
| audit_management | quality_audit | ✅ | ❌ | Excluded from MVM |
| audit_management | supplier_quality_audit | ✅ | ❌ | Excluded from MVM |
| certification_compliance | certificate_of_conformance | ✅ | ✅ |  |
| certification_compliance | compliance_test | ✅ | ✅ |  |
| certification_compliance | measurement_system | ✅ | ❌ | Excluded from MVM |
| inspection_control | inspection_characteristic | ✅ | ❌ | Excluded from MVM |
| inspection_control | inspection_lot | ✅ | ✅ |  |
| inspection_control | inspection_plan | ✅ | ✅ |  |
| inspection_control | inspection_result | ✅ | ✅ |  |
| nonconformance_resolution | capa | ✅ | ✅ |  |
| nonconformance_resolution | customer_complaint | ✅ | ✅ |  |
| nonconformance_resolution | ncr | ✅ | ✅ |  |
| nonconformance_resolution | notification | ✅ | ❌ | Excluded from MVM |
| nonconformance_resolution | rma_disposition | ✅ | ❌ | Excluded from MVM |
| process_assurance | apqp_project | ✅ | ❌ | Excluded from MVM |
| process_assurance | control_plan | ✅ | ✅ |  |
| process_assurance | fmea | ✅ | ❌ | Excluded from MVM |
| process_assurance | ppap_submission | ✅ | ❌ | Excluded from MVM |
| process_assurance | spc | ✅ | ❌ | Excluded from MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_performance | channel_partner | ✅ | ❌ | Excluded from MVM |
| channel_performance | project_rep_assignment | ✅ | ❌ | Excluded from MVM |
| channel_performance | quota | ✅ | ❌ | Excluded from MVM |
| channel_performance | rep | ✅ | ✅ |  |
| channel_performance | sales_team | ✅ | ❌ | Excluded from MVM |
| channel_performance | territory | ✅ | ❌ | Excluded from MVM |
| channel_performance | territory_assignment | ✅ | ❌ | Excluded from MVM |
| contract_revenue | device_contract_assignment | ✅ | ❌ | Excluded from MVM |
| contract_revenue | forecast | ✅ | ❌ | Excluded from MVM |
| contract_revenue | order_intake | ✅ | ✅ |  |
| contract_revenue | sales_contract | ✅ | ✅ |  |
| pipeline_management | campaign | ✅ | ❌ | Excluded from MVM |
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

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_management | entitlement | ❌ | ✅ | MVM only (stub or new) |
| agreement_management | warranty | ❌ | ✅ | MVM only (stub or new) |
| contract_entitlement | contract_line | ✅ | ❌ | Excluded from MVM |
| contract_entitlement | service_contract | ✅ | ✅ |  |
| contract_entitlement | service_contract_line | ✅ | ❌ | Excluded from MVM |
| contract_entitlement | service_entitlement | ✅ | ❌ | Excluded from MVM |
| contract_entitlement | service_pm_schedule | ✅ | ❌ | Excluded from MVM |
| field_operations | engineer | ✅ | ✅ |  |
| field_operations | engineer_assignment | ✅ | ❌ | Excluded from MVM |
| field_operations | field_service_order | ✅ | ✅ |  |
| field_operations | part_consumption | ✅ | ✅ |  |
| field_operations | task_checklist | ✅ | ❌ | Excluded from MVM |
| field_operations | zone | ✅ | ❌ | Excluded from MVM |
| knowledge_support | bulletin | ✅ | ❌ | Excluded from MVM |
| knowledge_support | holiday_calendar | ✅ | ❌ | Excluded from MVM |
| knowledge_support | knowledge_article | ✅ | ❌ | Excluded from MVM |
| knowledge_support | service_center | ✅ | ❌ | Excluded from MVM |
| request_management | remote_diagnostic_session | ✅ | ❌ | Excluded from MVM |
| request_management | request | ✅ | ✅ |  |
| request_management | satisfaction_survey | ✅ | ❌ | Excluded from MVM |
| request_management | service_capa_record | ✅ | ❌ | Excluded from MVM |
| request_management | sla_milestone | ✅ | ❌ | Excluded from MVM |
| warranty_coverage | installed_base | ✅ | ✅ |  |
| warranty_coverage | service_rma | ✅ | ❌ | Excluded from MVM |
| warranty_coverage | service_warranty | ✅ | ❌ | Excluded from MVM |

<a id="domain-supplier"></a>
### supplier

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| corrective_development | change_notification | ✅ | ❌ | Domain not in MVM |
| corrective_development | corrective_action | ✅ | ❌ | Domain not in MVM |
| corrective_development | development_plan | ✅ | ❌ | Domain not in MVM |
| corrective_development | supplier_onboarding | ✅ | ❌ | Domain not in MVM |
| performance_quality | qualification | ✅ | ❌ | Domain not in MVM |
| performance_quality | risk_rating | ✅ | ❌ | Domain not in MVM |
| performance_quality | scorecard | ✅ | ❌ | Domain not in MVM |
| performance_quality | supplier_audit | ✅ | ❌ | Domain not in MVM |
| performance_quality | supplier_audit_finding | ✅ | ❌ | Domain not in MVM |
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
| demand_planning | demand_plan_version | ✅ | ❌ | Excluded from MVM |
| demand_planning | material_requirement | ✅ | ✅ |  |
| demand_planning | mrp_run | ✅ | ✅ |  |
| demand_planning | planned_order | ✅ | ✅ |  |
| demand_planning | sop_cycle | ✅ | ❌ | Excluded from MVM |
| inventory_replenishment | allocation | ✅ | ❌ | Excluded from MVM |
| inventory_replenishment | inventory_position | ✅ | ❌ | Excluded from MVM |
| inventory_replenishment | replenishment_proposal | ✅ | ❌ | Excluded from MVM |
| inventory_replenishment | supply_safety_stock_policy | ✅ | ❌ | Excluded from MVM |
| network_configuration | moq_constraint | ✅ | ❌ | Excluded from MVM |
| network_configuration | network_node | ✅ | ❌ | Excluded from MVM |
| network_configuration | sourcing_rule | ✅ | ✅ |  |
| network_configuration | supply_plant | ✅ | ✅ |  |
| planning_execution | order_pegging | ❌ | ✅ | MVM only (stub or new) |
| sourcing_configuration | plan | ❌ | ✅ | MVM only (stub or new) |
| supply_scheduling | aps_scenario | ✅ | ❌ | Excluded from MVM |
| supply_scheduling | aps_schedule | ✅ | ❌ | Excluded from MVM |
| supply_scheduling | capacity_plan | ✅ | ✅ |  |
| supply_scheduling | planning_calendar | ✅ | ❌ | Excluded from MVM |
| supply_scheduling | planning_exception | ✅ | ❌ | Excluded from MVM |
| supply_scheduling | planning_parameter | ✅ | ❌ | Excluded from MVM |
| supply_scheduling | risk_register | ✅ | ❌ | Excluded from MVM |
| supply_scheduling | supply_plan | ✅ | ❌ | Excluded from MVM |

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
| employee_records | workforce_certification | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_period | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_result | ✅ | ❌ | Domain not in MVM |
| shift_planning | absence_record | ✅ | ❌ | Domain not in MVM |
| shift_planning | shift_pattern | ✅ | ❌ | Domain not in MVM |
| shift_planning | shift_schedule | ✅ | ❌ | Domain not in MVM |
| shift_planning | time_entry | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | certification_type | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | training_course | ✅ | ❌ | Domain not in MVM |
