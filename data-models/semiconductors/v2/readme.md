# Semiconductors Lakehouse Data Models

**Version 2** | Generated on June 27, 2026 at 11:13 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Design](#domain-design)
  - [Equipment](#domain-equipment)
  - [Fabrication](#domain-fabrication)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Invoice](#domain-invoice)
  - [Order](#domain-order)
  - [Packaging](#domain-packaging)
  - [Process](#domain-process)
  - [Product](#domain-product)
  - [Quality](#domain-quality)
  - [Research](#domain-research)
  - [Sales](#domain-sales)
  - [Shared](#domain-shared)
  - [Supply](#domain-supply)
  - [Test](#domain-test)
  - [Workforce](#domain-workforce)


## Business Description

semiconductors industry enterprise data model.

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
| Domains | 13 | 19 |
| Subdomains | 32 | 67 |
| Products (Tables) | 122 | 387 |
| Attributes (Columns) | 5403 | 17610 |
| Foreign Keys | 874 | 2555 |
| Avg Attributes/Product | 44.3 | 45.5 |

## Domain & Product Comparison

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| regulatory_assurance | audit_event | ✅ | ❌ | Domain not in MVM |
| regulatory_assurance | certification | ✅ | ❌ | Domain not in MVM |
| regulatory_assurance | chips_act_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_assurance | compliance_audit_finding | ✅ | ❌ | Domain not in MVM |
| regulatory_assurance | obligation_register | ✅ | ❌ | Domain not in MVM |
| regulatory_assurance | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| substance_management | conflict_minerals_declaration | ✅ | ❌ | Domain not in MVM |
| substance_management | declaration_substance | ✅ | ❌ | Domain not in MVM |
| substance_management | reach_svhc_declaration | ✅ | ❌ | Domain not in MVM |
| substance_management | substance_inventory | ✅ | ❌ | Domain not in MVM |
| trade_control | eccn_classification | ✅ | ❌ | Domain not in MVM |
| trade_control | export_license | ✅ | ❌ | Domain not in MVM |
| trade_control | export_license_usage | ✅ | ❌ | Domain not in MVM |
| trade_control | restricted_party_screening | ✅ | ❌ | Domain not in MVM |
| trade_control | technology_control_plan | ✅ | ❌ | Domain not in MVM |
| trade_control | trade_compliance_hold | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | account_team | ✅ | ❌ | Excluded from MVM |
| account_management | address | ✅ | ✅ |  |
| account_management | contact | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ✅ |  |
| account_management | design_win | ❌ | ✅ | MVM only (stub or new) |
| account_management | segment | ✅ | ✅ |  |
| contract_administration | customer_ltb_notification | ✅ | ❌ | Excluded from MVM |
| contract_administration | distributor_agreement | ✅ | ❌ | Excluded from MVM |
| contract_administration | nda_agreement | ✅ | ✅ |  |
| contract_administration | price_agreement | ✅ | ✅ |  |
| contract_administration | tool_allocation | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_design_registration | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_design_win | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_sample_request | ✅ | ❌ | Excluded from MVM |
| design_engagement | engagement_activity | ✅ | ❌ | Excluded from MVM |
| design_engagement | qualification_status | ✅ | ❌ | Excluded from MVM |

<a id="domain-design"></a>
### design

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| project_lifecycle | change_request | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | design_milestone | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | design_revision | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | ic_design_project | ✅ | ✅ |  |
| project_lifecycle | ip_core | ❌ | ✅ | MVM only (stub or new) |
| project_lifecycle | ip_core_usage | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | ip_integration | ❌ | ✅ | MVM only (stub or new) |
| project_lifecycle | mpw_shuttle | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | netlist | ✅ | ✅ |  |
| project_lifecycle | physical_layout | ✅ | ✅ |  |
| project_lifecycle | revision | ❌ | ✅ | MVM only (stub or new) |
| project_lifecycle | rtl_specification | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | tapeout | ✅ | ✅ |  |
| reusable_assets | design_ip_core | ✅ | ❌ | Excluded from MVM |
| reusable_assets | eda_tool | ✅ | ❌ | Excluded from MVM |
| reusable_assets | package_compatibility | ✅ | ❌ | Excluded from MVM |
| reusable_assets | pdk | ✅ | ✅ |  |
| reusable_assets | rule_set | ✅ | ❌ | Excluded from MVM |
| verification_execution | simulation_run | ✅ | ❌ | Excluded from MVM |
| verification_execution | timing_analysis_run | ✅ | ❌ | Excluded from MVM |
| verification_execution | verification_plan | ✅ | ✅ |  |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | equipment_fab | ✅ | ❌ | Excluded from MVM |
| asset_management | fab_tool | ✅ | ✅ |  |
| asset_management | part_substance_composition | ✅ | ❌ | Excluded from MVM |
| asset_management | spare_part | ✅ | ✅ |  |
| asset_management | tool_capex | ✅ | ❌ | Excluded from MVM |
| asset_management | tool_chamber | ✅ | ✅ |  |
| asset_management | tool_installation | ✅ | ❌ | Excluded from MVM |
| asset_management | tool_qualification | ✅ | ✅ |  |
| asset_management | tool_safety_cert | ✅ | ❌ | Excluded from MVM |
| asset_management | tool_warranty | ✅ | ❌ | Excluded from MVM |
| inventory_logistics | maintenance_parts_consumed | ❌ | ✅ | MVM only (stub or new) |
| inventory_logistics | tool_spare_part_compatibility | ❌ | ✅ | MVM only (stub or new) |
| maintenance_operations | maintenance_contract | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | maintenance_event | ✅ | ✅ |  |
| maintenance_operations | maintenance_plan | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pm_schedule | ✅ | ✅ |  |
| performance_monitoring | calibration_record | ✅ | ✅ |  |
| performance_monitoring | fdc_event | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | metrology_run | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | oee_record | ✅ | ✅ |  |
| performance_monitoring | sensor | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | spc_control | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | tool_alarm | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | tool_downtime | ✅ | ✅ |  |
| recipe_execution | equipment_process_recipe | ✅ | ✅ |  |
| recipe_execution | equipment_site_map | ✅ | ❌ | Excluded from MVM |
| recipe_execution | recipe_execution | ✅ | ❌ | Excluded from MVM |

<a id="domain-fabrication"></a>
### fabrication

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_operations | equipment_group | ✅ | ❌ | Excluded from MVM |
| equipment_operations | equipment_run | ✅ | ❌ | Excluded from MVM |
| equipment_operations | fabrication_fab | ✅ | ❌ | Excluded from MVM |
| equipment_operations | work_center | ✅ | ❌ | Excluded from MVM |
| lot_management | fab_run_card | ✅ | ❌ | Excluded from MVM |
| lot_management | fab_yield_record | ✅ | ✅ |  |
| lot_management | fabrication_lot_genealogy | ✅ | ❌ | Excluded from MVM |
| lot_management | fabrication_lot_hold | ✅ | ❌ | Excluded from MVM |
| lot_management | fabrication_wafer_lot | ✅ | ✅ |  |
| lot_management | lot_disposition | ✅ | ❌ | Excluded from MVM |
| lot_management | lot_move | ✅ | ✅ |  |
| lot_management | wafer | ✅ | ✅ |  |
| lot_management | wafer_start | ✅ | ✅ |  |
| process_engineering | fabrication_process_flow | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_process_recipe | ✅ | ✅ |  |
| process_engineering | fabrication_process_step | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_technology_node | ✅ | ❌ | Excluded from MVM |
| process_engineering | process_flow | ❌ | ✅ | In ECM under domain(s): process |
| process_engineering | process_flow_step_recipe | ❌ | ✅ | MVM only (stub or new) |
| process_engineering | spc_control_plan | ✅ | ❌ | Excluded from MVM |
| process_engineering | technology_node | ❌ | ✅ | MVM only (stub or new) |
| tooling_resources | fab_facility | ✅ | ❌ | Excluded from MVM |
| tooling_resources | fab_site | ✅ | ❌ | Excluded from MVM |
| tooling_resources | mask_set | ✅ | ❌ | Excluded from MVM |
| tooling_resources | photomask | ✅ | ✅ |  |
| tooling_resources | plant | ✅ | ❌ | Excluded from MVM |
| tooling_resources | reticle_set | ✅ | ❌ | Excluded from MVM |
| wafer_management | lot_hold | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_operations | consolidation_entry | ✅ | ❌ | Domain not in MVM |
| accounting_operations | consolidation_group | ✅ | ❌ | Domain not in MVM |
| accounting_operations | consolidation_unit | ✅ | ❌ | Domain not in MVM |
| accounting_operations | cost_center | ✅ | ❌ | Domain not in MVM |
| accounting_operations | gl_account | ✅ | ❌ | Domain not in MVM |
| accounting_operations | intercompany_agreement | ✅ | ❌ | Domain not in MVM |
| accounting_operations | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| accounting_operations | journal_entry | ✅ | ❌ | Domain not in MVM |
| accounting_operations | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| accounting_operations | legal_entity | ✅ | ❌ | Domain not in MVM |
| accounting_operations | profit_center | ✅ | ❌ | Domain not in MVM |
| accounting_operations | tax_provision | ✅ | ❌ | Domain not in MVM |
| asset_management | amortization_schedule | ✅ | ❌ | Domain not in MVM |
| asset_management | asset_depreciation | ✅ | ❌ | Domain not in MVM |
| asset_management | capex_request | ✅ | ❌ | Domain not in MVM |
| asset_management | depreciation_run | ✅ | ❌ | Domain not in MVM |
| asset_management | fixed_asset | ✅ | ❌ | Domain not in MVM |
| planning_budgeting | budget_line | ✅ | ❌ | Domain not in MVM |
| planning_budgeting | budget_plan | ✅ | ❌ | Domain not in MVM |
| planning_budgeting | rd_capitalization | ✅ | ❌ | Domain not in MVM |
| product_costing | standard_cost | ✅ | ❌ | Domain not in MVM |
| product_costing | transfer_price | ✅ | ❌ | Domain not in MVM |
| product_costing | wafer_cost_model | ✅ | ❌ | Domain not in MVM |
| project_controlling | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| project_controlling | cost_allocation | ✅ | ❌ | Domain not in MVM |
| project_controlling | internal_order | ✅ | ❌ | Domain not in MVM |
| project_controlling | wbs_element | ✅ | ❌ | Domain not in MVM |
| revenue_billing | finance_nre_agreement | ✅ | ❌ | Domain not in MVM |
| revenue_billing | finance_nre_milestone | ✅ | ❌ | Domain not in MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| material_tracking | die_bank | ✅ | ✅ |  |
| material_tracking | finished_good | ✅ | ✅ |  |
| material_tracking | inventory_wafer_lot | ✅ | ✅ |  |
| material_tracking | photomask_asset | ✅ | ❌ | Excluded from MVM |
| material_tracking | raw_material | ✅ | ✅ |  |
| quality_certification | inventory_kgd_certification | ✅ | ❌ | Excluded from MVM |
| quality_certification | inventory_lot_genealogy | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | consignment_stock | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | goods_movement | ✅ | ✅ |  |
| warehouse_operations | inventory_lot_hold | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | physical_inventory | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | reservation | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | stock_balance | ✅ | ✅ |  |
| warehouse_operations | stock_valuation | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | storage_location | ✅ | ✅ |  |

<a id="domain-invoice"></a>
### invoice

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_operations | adjustment_memo | ✅ | ❌ | Excluded from MVM |
| billing_operations | ar_invoice | ✅ | ✅ |  |
| billing_operations | invoice_line | ✅ | ✅ |  |
| billing_operations | nre_billing_milestone | ✅ | ❌ | Excluded from MVM |
| billing_operations | royalty_billing | ✅ | ❌ | Excluded from MVM |
| commercial_terms | payment_term | ✅ | ✅ |  |
| commercial_terms | pricing_agreement | ✅ | ❌ | Excluded from MVM |
| credit_management | credit_hold | ✅ | ✅ |  |
| credit_management | customer_credit_limit | ✅ | ✅ |  |
| credit_management | write_off | ✅ | ❌ | Excluded from MVM |
| payment_processing | dispute | ✅ | ✅ |  |
| payment_processing | dunning_notice | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment_receipt | ✅ | ✅ |  |
| revenue_accounting | performance_obligation | ✅ | ❌ | Excluded from MVM |
| revenue_accounting | recognition_schedule | ✅ | ❌ | Excluded from MVM |
| revenue_accounting | revenue_recognition_event | ✅ | ✅ |  |
| revenue_accounting | tax_determination | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engineering_services | nre_order | ✅ | ❌ | Excluded from MVM |
| engineering_services | order_nre_milestone | ✅ | ❌ | Excluded from MVM |
| engineering_services | rma | ✅ | ✅ |  |
| fulfillment_logistics | backlog_position | ✅ | ✅ |  |
| fulfillment_logistics | delivery_confirmation | ✅ | ❌ | Excluded from MVM |
| fulfillment_logistics | delivery_schedule | ✅ | ✅ |  |
| fulfillment_logistics | shipment | ✅ | ✅ |  |
| fulfillment_logistics | shipment_line | ✅ | ✅ |  |
| order_management | amendment | ✅ | ❌ | Excluded from MVM |
| order_management | blanket_order | ✅ | ❌ | Excluded from MVM |
| order_management | order | ✅ | ✅ |  |
| order_management | order_hold | ✅ | ✅ |  |
| order_management | order_line | ✅ | ✅ |  |
| order_management | status_history | ✅ | ❌ | Excluded from MVM |
| production_authorization | allocation_record | ✅ | ✅ |  |
| production_authorization | die_bank_order | ✅ | ❌ | Excluded from MVM |
| production_authorization | lot_assignment | ✅ | ❌ | Excluded from MVM |
| production_authorization | mpw_order | ✅ | ❌ | Excluded from MVM |
| production_authorization | wafer_start_authorization | ✅ | ❌ | Excluded from MVM |

<a id="domain-packaging"></a>
### packaging

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engineering_standards | assembly_process_flow | ✅ | ✅ |  |
| engineering_standards | package_type | ✅ | ✅ |  |
| engineering_standards | packaging_line | ✅ | ❌ | Excluded from MVM |
| engineering_standards | substrate_bom | ✅ | ✅ |  |
| production_operations | assembly_defect | ✅ | ✅ |  |
| production_operations | assembly_lot | ✅ | ✅ |  |
| production_operations | assembly_order | ✅ | ✅ |  |
| production_operations | assembly_step_record | ✅ | ❌ | Excluded from MVM |
| production_operations | assembly_yield | ✅ | ✅ |  |
| production_operations | inspection_result | ✅ | ❌ | Excluded from MVM |
| production_operations | material_lot | ✅ | ❌ | Excluded from MVM |
| quality_certification | assembly_change_notice | ✅ | ❌ | Excluded from MVM |
| quality_certification | package_qualification | ✅ | ✅ |  |
| quality_certification | qualification_plan | ✅ | ❌ | Excluded from MVM |
| quality_certification | reliability_stress_test | ✅ | ❌ | Excluded from MVM |
| supplier_management | customer_requirement | ✅ | ❌ | Excluded from MVM |
| supplier_management | osat_vendor | ✅ | ✅ |  |
| vendor_capability | osat_package_capability | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-process"></a>
### process

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_conditions | cmp_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | cooling_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | cooling_process_flow | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | deposition_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | etch_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | implant_condition | ✅ | ❌ | Excluded from MVM |
| equipment_conditions | litho_condition | ✅ | ❌ | Excluded from MVM |
| execution_tracking | defect_inspection_result | ✅ | ✅ |  |
| execution_tracking | excursion | ✅ | ❌ | Excluded from MVM |
| execution_tracking | lot_process_run | ✅ | ✅ |  |
| execution_tracking | process_metrology_measurement | ✅ | ❌ | Excluded from MVM |
| execution_tracking | yield_loss_event | ✅ | ✅ |  |
| flow_definition | inspection_point | ✅ | ❌ | Excluded from MVM |
| flow_definition | meef_parameter | ✅ | ❌ | Excluded from MVM |
| flow_definition | opc_rule_set | ✅ | ❌ | Excluded from MVM |
| flow_definition | process_flow | ✅ | ❌ | Excluded from MVM |
| flow_definition | process_site_map | ✅ | ❌ | Excluded from MVM |
| flow_definition | process_step | ✅ | ❌ | Excluded from MVM |
| flow_definition | process_technology_node | ✅ | ❌ | Excluded from MVM |
| flow_definition | recipe | ✅ | ✅ |  |
| manufacturing_execution | qualification | ❌ | ✅ | MVM only (stub or new) |
| qualification_management | change_notification | ✅ | ❌ | Excluded from MVM |
| qualification_management | doe_experiment | ✅ | ❌ | Excluded from MVM |
| qualification_management | flow_qualification | ✅ | ❌ | Excluded from MVM |
| qualification_management | process_qualification | ✅ | ❌ | Excluded from MVM |
| qualification_management | process_supply_agreement | ✅ | ❌ | Excluded from MVM |
| quality_monitoring | metrology_measurement | ❌ | ✅ | MVM only (stub or new) |
| recipe_engineering | flow | ❌ | ✅ | MVM only (stub or new) |
| recipe_engineering | step | ❌ | ✅ | MVM only (stub or new) |
| statistical_control | capability | ✅ | ❌ | Excluded from MVM |
| statistical_control | metrology_plan | ✅ | ❌ | Excluded from MVM |
| statistical_control | ocap_action | ✅ | ❌ | Excluded from MVM |
| statistical_control | process_spc_control_plan | ✅ | ❌ | Excluded from MVM |
| statistical_control | sampling_plan | ✅ | ❌ | Excluded from MVM |
| statistical_control | spc_control_chart | ✅ | ✅ |  |
| statistical_control | spc_measurement | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | family | ✅ | ✅ |  |
| catalog_management | ic_catalog | ✅ | ✅ |  |
| catalog_management | process_node | ✅ | ✅ |  |
| catalog_management | product_spec | ✅ | ✅ |  |
| catalog_management | sku | ✅ | ✅ |  |
| change_notification | pcn | ✅ | ❌ | Excluded from MVM |
| change_notification | product_ip_core | ✅ | ❌ | Excluded from MVM |
| change_notification | product_ltb_notification | ✅ | ❌ | Excluded from MVM |
| configuration_structure | bom | ✅ | ✅ |  |
| configuration_structure | bom_line | ✅ | ✅ |  |
| configuration_structure | configuration_rule | ✅ | ❌ | Excluded from MVM |
| licensing_samples | license_agreement | ✅ | ❌ | Excluded from MVM |
| licensing_samples | license_allocation | ✅ | ❌ | Excluded from MVM |
| licensing_samples | product_sample_request | ✅ | ❌ | Excluded from MVM |
| qualification_compliance | compliance_cert | ✅ | ✅ |  |
| qualification_compliance | errata | ✅ | ❌ | Excluded from MVM |
| qualification_compliance | product_qualification_program | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| defect_analysis | defect_cluster | ✅ | ❌ | Excluded from MVM |
| defect_analysis | defect_record | ✅ | ✅ |  |
| defect_analysis | failure_analysis_report | ✅ | ✅ |  |
| defect_analysis | wafer_map | ✅ | ✅ |  |
| defect_analysis | wafer_zone | ✅ | ❌ | Excluded from MVM |
| inspection_management | audit | ✅ | ❌ | Excluded from MVM |
| inspection_management | control_plan | ✅ | ❌ | Excluded from MVM |
| inspection_management | fmea_record | ✅ | ❌ | Excluded from MVM |
| inspection_management | inspection_lot | ✅ | ✅ |  |
| inspection_management | quality_audit_finding | ✅ | ❌ | Excluded from MVM |
| inspection_management | quality_document | ✅ | ❌ | Excluded from MVM |
| inspection_management | quality_metrology_measurement | ✅ | ❌ | Excluded from MVM |
| issue_resolution | capa_record | ✅ | ✅ |  |
| issue_resolution | customer_complaint | ✅ | ✅ |  |
| issue_resolution | mrb_meeting | ✅ | ❌ | Excluded from MVM |
| issue_resolution | nonconformance_report | ✅ | ✅ |  |
| issue_resolution | quality_hold | ✅ | ✅ |  |
| issue_resolution | quality_notification | ✅ | ❌ | Excluded from MVM |
| performance_measurement | dppm_record | ✅ | ❌ | Excluded from MVM |
| performance_measurement | spc_chart | ✅ | ❌ | Excluded from MVM |
| performance_measurement | supplier_quality_scorecard | ✅ | ❌ | Excluded from MVM |
| performance_measurement | yield_record | ✅ | ✅ |  |
| testing_validation | qualification_report | ✅ | ❌ | Excluded from MVM |
| testing_validation | quality_kgd_certification | ✅ | ❌ | Excluded from MVM |
| testing_validation | quality_qualification_program | ✅ | ❌ | Excluded from MVM |
| testing_validation | quality_spec | ✅ | ✅ |  |
| testing_validation | reliability_test | ✅ | ✅ |  |
| testing_validation | test_plan | ✅ | ❌ | Excluded from MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| experimentation_execution | characterization_result | ✅ | ❌ | Domain not in MVM |
| experimentation_execution | experimental_lot | ✅ | ❌ | Domain not in MVM |
| experimentation_execution | process_flow_experiment | ✅ | ❌ | Domain not in MVM |
| experimentation_execution | process_integration_run | ✅ | ❌ | Domain not in MVM |
| experimentation_execution | research_test_plan | ✅ | ❌ | Domain not in MVM |
| experimentation_execution | tapeout_experiment | ✅ | ❌ | Domain not in MVM |
| experimentation_execution | test_structure | ✅ | ❌ | Domain not in MVM |
| experimentation_execution | test_suite | ✅ | ❌ | Domain not in MVM |
| experimentation_execution | yield_learning_record | ✅ | ❌ | Domain not in MVM |
| intellectual_property | competitive_benchmark | ✅ | ❌ | Domain not in MVM |
| intellectual_property | compliance_assessment | ✅ | ❌ | Domain not in MVM |
| intellectual_property | invention_disclosure | ✅ | ❌ | Domain not in MVM |
| intellectual_property | ip_core_development | ✅ | ❌ | Domain not in MVM |
| intellectual_property | patent_filing | ✅ | ❌ | Domain not in MVM |
| intellectual_property | publication | ✅ | ❌ | Domain not in MVM |
| program_management | budget_allocation | ✅ | ❌ | Domain not in MVM |
| program_management | collaboration | ✅ | ❌ | Domain not in MVM |
| program_management | government_grant | ✅ | ❌ | Domain not in MVM |
| program_management | program_partner_collaboration | ✅ | ❌ | Domain not in MVM |
| program_management | project | ✅ | ❌ | Domain not in MVM |
| program_management | research_milestone | ✅ | ❌ | Domain not in MVM |
| program_management | research_program | ✅ | ❌ | Domain not in MVM |
| technology_development | device_architecture | ✅ | ❌ | Domain not in MVM |
| technology_development | materials_research | ✅ | ❌ | Domain not in MVM |
| technology_development | packaging_research | ✅ | ❌ | Domain not in MVM |
| technology_development | pdk_development | ✅ | ❌ | Domain not in MVM |
| technology_development | process_split | ✅ | ❌ | Domain not in MVM |
| technology_development | research_technology_node | ✅ | ❌ | Domain not in MVM |
| technology_development | technology_roadmap | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | customer_contract | ✅ | ✅ |  |
| contract_administration | price_list | ✅ | ✅ |  |
| contract_administration | sales_nre_agreement | ✅ | ❌ | Excluded from MVM |
| contract_administration | territory | ✅ | ✅ |  |
| partner_enablement | channel_partner | ✅ | ❌ | Excluded from MVM |
| partner_enablement | partner_inventory | ✅ | ❌ | Excluded from MVM |
| partner_enablement | rebate_program | ✅ | ❌ | Excluded from MVM |
| partner_enablement | sales_design_registration | ✅ | ❌ | Excluded from MVM |
| pipeline_management | activity | ✅ | ❌ | Excluded from MVM |
| pipeline_management | booking | ✅ | ✅ |  |
| pipeline_management | campaign | ✅ | ❌ | Excluded from MVM |
| pipeline_management | forecast | ❌ | ✅ | MVM only (stub or new) |
| pipeline_management | lead | ✅ | ❌ | Excluded from MVM |
| pipeline_management | lead_program_interest | ✅ | ❌ | Excluded from MVM |
| pipeline_management | opportunity | ✅ | ✅ |  |
| pipeline_management | opportunity_project_assignment | ✅ | ❌ | Excluded from MVM |
| pipeline_management | quote | ✅ | ✅ |  |
| pipeline_management | quote_line | ✅ | ✅ |  |
| pipeline_management | sales_design_win | ✅ | ❌ | Excluded from MVM |
| pipeline_management | sales_forecast | ✅ | ❌ | Excluded from MVM |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| shared_core | fab | ✅ | ❌ | Domain not in MVM |
| shared_core | location | ✅ | ❌ | Domain not in MVM |
| shared_core | site | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| logistics_coordination | carrier | ✅ | ❌ | Domain not in MVM |
| logistics_coordination | consignment_agreement | ✅ | ❌ | Domain not in MVM |
| logistics_coordination | disruption_event | ✅ | ❌ | Domain not in MVM |
| logistics_coordination | inbound_shipment | ✅ | ❌ | Domain not in MVM |
| logistics_coordination | osat_work_order | ✅ | ❌ | Domain not in MVM |
| logistics_coordination | product_change_notification | ✅ | ❌ | Domain not in MVM |
| material_planning | material_certification | ✅ | ❌ | Domain not in MVM |
| material_planning | material_master | ✅ | ❌ | Domain not in MVM |
| material_planning | material_requirement_plan | ✅ | ❌ | Domain not in MVM |
| material_planning | supply_forecast | ✅ | ❌ | Domain not in MVM |
| procurement_operations | goods_receipt | ✅ | ❌ | Domain not in MVM |
| procurement_operations | po_line | ✅ | ❌ | Domain not in MVM |
| procurement_operations | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_operations | sourcing_contract | ✅ | ❌ | Domain not in MVM |
| procurement_operations | supplier_quotation | ✅ | ❌ | Domain not in MVM |
| procurement_operations | supply_agreement | ✅ | ❌ | Domain not in MVM |
| vendor_management | approved_vendor | ✅ | ❌ | Domain not in MVM |
| vendor_management | risk_assessment | ✅ | ❌ | Domain not in MVM |
| vendor_management | supplier | ✅ | ❌ | Domain not in MVM |
| vendor_management | supplier_audit | ✅ | ❌ | Domain not in MVM |
| vendor_management | supplier_corrective_action | ✅ | ❌ | Domain not in MVM |
| vendor_management | supplier_qualification | ✅ | ❌ | Domain not in MVM |
| vendor_management | supplier_scorecard | ✅ | ❌ | Domain not in MVM |

<a id="domain-test"></a>
### test

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_configuration | ate_configuration | ✅ | ✅ |  |
| equipment_configuration | probe_card | ✅ | ✅ |  |
| equipment_configuration | program | ❌ | ✅ | MVM only (stub or new) |
| execution_operations | final_test_run | ✅ | ✅ |  |
| execution_operations | parametric_measurement | ✅ | ✅ |  |
| execution_operations | reliability_test_run | ✅ | ❌ | Excluded from MVM |
| execution_operations | unit_test_result | ✅ | ✅ |  |
| execution_operations | wafer_probe_run | ✅ | ✅ |  |
| program_management | adaptive_test_flow | ✅ | ❌ | Excluded from MVM |
| program_management | bin_definition | ✅ | ✅ |  |
| program_management | correlation_study | ✅ | ❌ | Excluded from MVM |
| program_management | coverage | ✅ | ❌ | Excluded from MVM |
| program_management | insertion | ✅ | ❌ | Excluded from MVM |
| program_management | limit | ✅ | ✅ |  |
| program_management | program_assignment | ✅ | ❌ | Excluded from MVM |
| program_management | test_case | ✅ | ❌ | Excluded from MVM |
| program_management | test_program | ✅ | ❌ | Excluded from MVM |
| program_management | test_step | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| operational_compliance | cleanroom_access | ✅ | ❌ | Domain not in MVM |
| operational_compliance | export_control | ✅ | ❌ | Domain not in MVM |
| operational_compliance | fab_operator_qualification | ✅ | ❌ | Domain not in MVM |
| operational_compliance | safety_event | ✅ | ❌ | Domain not in MVM |
| operational_compliance | shift_pattern | ✅ | ❌ | Domain not in MVM |
| operational_compliance | shift_schedule | ✅ | ❌ | Domain not in MVM |
| operational_compliance | skill | ✅ | ❌ | Domain not in MVM |
| operational_compliance | time_entry | ✅ | ❌ | Domain not in MVM |
| operational_compliance | training | ✅ | ❌ | Domain not in MVM |
| operational_compliance | training_course | ✅ | ❌ | Domain not in MVM |
| operational_compliance | workforce_qualification | ✅ | ❌ | Domain not in MVM |
| personnel_management | compensation | ✅ | ❌ | Domain not in MVM |
| personnel_management | compensation_plan | ✅ | ❌ | Domain not in MVM |
| personnel_management | competency | ✅ | ❌ | Domain not in MVM |
| personnel_management | contractor_engagement | ✅ | ❌ | Domain not in MVM |
| personnel_management | employee | ✅ | ❌ | Domain not in MVM |
| personnel_management | employment_event | ✅ | ❌ | Domain not in MVM |
| personnel_management | job | ✅ | ❌ | Domain not in MVM |
| personnel_management | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_management | position | ✅ | ❌ | Domain not in MVM |
| personnel_management | site_assignment | ✅ | ❌ | Domain not in MVM |
| personnel_management | talent_acquisition | ✅ | ❌ | Domain not in MVM |
