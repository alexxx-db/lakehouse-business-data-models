# Semiconductors Lakehouse Data Models

**Version 2** | Generated on July 10, 2026 at 02:03 PM

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
| Domains | 12 | 19 |
| Subdomains | 31 | 68 |
| Products (Tables) | 113 | 386 |
| Attributes (Columns) | 4593 | 13683 |
| Foreign Keys | 987 | 2027 |
| Avg Attributes/Product | 40.6 | 35.4 |

## Domain & Product Comparison

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_obligations | audit_event | ✅ | ❌ | Domain not in MVM |
| audit_obligations | certification | ✅ | ❌ | Domain not in MVM |
| audit_obligations | chips_act_obligation | ✅ | ❌ | Domain not in MVM |
| audit_obligations | compliance_audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_obligations | obligation_register | ✅ | ❌ | Domain not in MVM |
| audit_obligations | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| substance_regulatory | conflict_minerals_declaration | ✅ | ❌ | Domain not in MVM |
| substance_regulatory | declaration_substance | ✅ | ❌ | Domain not in MVM |
| substance_regulatory | reach_svhc_declaration | ✅ | ❌ | Domain not in MVM |
| substance_regulatory | substance_inventory | ✅ | ❌ | Domain not in MVM |
| trade_controls | eccn_classification | ✅ | ❌ | Domain not in MVM |
| trade_controls | export_license | ✅ | ❌ | Domain not in MVM |
| trade_controls | export_license_usage | ✅ | ❌ | Domain not in MVM |
| trade_controls | restricted_party_screening | ✅ | ❌ | Domain not in MVM |
| trade_controls | technology_control_plan | ✅ | ❌ | Domain not in MVM |
| trade_controls | trade_compliance_hold | ✅ | ❌ | Domain not in MVM |

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
| account_management | distributor_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | nda_agreement | ✅ | ✅ |  |
| account_management | price_agreement | ✅ | ✅ |  |
| account_management | qualification_status | ✅ | ❌ | Excluded from MVM |
| account_management | segment | ✅ | ❌ | Excluded from MVM |
| account_management | tool_allocation | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_design_registration | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_design_win | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_ltb_notification | ✅ | ❌ | Excluded from MVM |
| design_engagement | customer_sample_request | ✅ | ❌ | Excluded from MVM |
| design_engagement | design_registration | ❌ | ✅ | MVM only (stub or new) |
| design_engagement | design_win | ❌ | ✅ | MVM only (stub or new) |
| design_engagement | engagement_activity | ✅ | ❌ | Excluded from MVM |

<a id="domain-design"></a>
### design

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| ip_management | design_ip_core | ✅ | ✅ |  |
| ip_management | eda_tool | ✅ | ✅ |  |
| ip_management | pdk | ✅ | ✅ |  |
| ip_management | rtl_specification | ✅ | ✅ |  |
| ip_management | rule_set | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | change_request | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | design_milestone | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | design_revision | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | ic_design_project | ✅ | ✅ |  |
| project_lifecycle | mpw_shuttle | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | package_compatibility | ✅ | ❌ | Excluded from MVM |
| project_lifecycle | tapeout | ✅ | ✅ |  |
| verification_execution | ip_core_usage | ✅ | ✅ |  |
| verification_execution | netlist | ✅ | ✅ |  |
| verification_execution | physical_layout | ✅ | ✅ |  |
| verification_execution | simulation_run | ✅ | ❌ | Excluded from MVM |
| verification_execution | timing_analysis_run | ✅ | ❌ | Excluded from MVM |
| verification_execution | verification_plan | ✅ | ✅ |  |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| maintenance_operations | calibration_record | ✅ | ✅ |  |
| maintenance_operations | equipment_fab | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | maintenance_contract | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | maintenance_event | ✅ | ✅ |  |
| maintenance_operations | maintenance_plan | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | oee_record | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pm_schedule | ✅ | ✅ |  |
| maintenance_operations | spare_part | ✅ | ✅ |  |
| maintenance_operations | tool_downtime | ✅ | ✅ |  |
| metrology_calibration | equipment_site_map | ✅ | ❌ | Excluded from MVM |
| metrology_calibration | metrology_run | ✅ | ❌ | Excluded from MVM |
| metrology_calibration | part_substance_composition | ✅ | ❌ | Excluded from MVM |
| metrology_calibration | sensor | ✅ | ❌ | Excluded from MVM |
| process_control | equipment_process_recipe | ✅ | ❌ | Excluded from MVM |
| process_control | fdc_event | ✅ | ❌ | Excluded from MVM |
| process_control | recipe_execution | ✅ | ❌ | Excluded from MVM |
| process_control | spc_control | ✅ | ❌ | Excluded from MVM |
| process_control | tool_alarm | ✅ | ❌ | Excluded from MVM |
| shared_core | fab | ✅ | ❌ | Excluded from MVM |
| tool_management | fab_tool | ✅ | ✅ |  |
| tool_management | tool_capex | ✅ | ❌ | Excluded from MVM |
| tool_management | tool_chamber | ✅ | ✅ |  |
| tool_management | tool_installation | ✅ | ❌ | Excluded from MVM |
| tool_management | tool_qualification | ✅ | ✅ |  |
| tool_management | tool_safety_cert | ✅ | ❌ | Excluded from MVM |
| tool_management | tool_warranty | ✅ | ❌ | Excluded from MVM |

<a id="domain-fabrication"></a>
### fabrication

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_infrastructure | equipment_group | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | fab_facility | ✅ | ✅ |  |
| facility_infrastructure | fab_site | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | fabrication_area | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | plant | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | work_center | ✅ | ❌ | Excluded from MVM |
| lot_management | lot_hold | ❌ | ✅ | MVM only (stub or new) |
| mask_reticle | mask_set | ✅ | ❌ | Excluded from MVM |
| mask_reticle | photomask | ✅ | ✅ |  |
| mask_reticle | reticle_set | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_process_flow | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_process_recipe | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_process_step | ✅ | ❌ | Excluded from MVM |
| process_engineering | fabrication_technology_node | ✅ | ❌ | Excluded from MVM |
| process_engineering | process_flow | ❌ | ✅ | In ECM under domain(s): process |
| process_engineering | process_recipe | ❌ | ✅ | MVM only (stub or new) |
| wafer_production | equipment_run | ✅ | ✅ |  |
| wafer_production | fab_run_card | ✅ | ❌ | Excluded from MVM |
| wafer_production | fabrication_lot_genealogy | ✅ | ❌ | Excluded from MVM |
| wafer_production | fabrication_lot_hold | ✅ | ❌ | Excluded from MVM |
| wafer_production | fabrication_wafer_lot | ✅ | ✅ |  |
| wafer_production | lot_disposition | ✅ | ❌ | Excluded from MVM |
| wafer_production | lot_move | ✅ | ✅ |  |
| wafer_production | wafer | ✅ | ✅ |  |
| wafer_production | wafer_start | ✅ | ✅ |  |
| yield_control | fab_yield_record | ✅ | ✅ |  |
| yield_control | spc_control_plan | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_capital | amortization_schedule | ✅ | ❌ | Domain not in MVM |
| asset_capital | asset_depreciation | ✅ | ❌ | Domain not in MVM |
| asset_capital | capex_request | ✅ | ❌ | Domain not in MVM |
| asset_capital | depreciation_run | ✅ | ❌ | Domain not in MVM |
| asset_capital | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_capital | rd_capitalization | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_plan | ✅ | ❌ | Domain not in MVM |
| budget_planning | legal_entity | ✅ | ❌ | Domain not in MVM |
| cost_accounting | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| cost_accounting | cost_allocation | ✅ | ❌ | Domain not in MVM |
| cost_accounting | cost_center | ✅ | ❌ | Domain not in MVM |
| cost_accounting | internal_order | ✅ | ❌ | Domain not in MVM |
| cost_accounting | profit_center | ✅ | ❌ | Domain not in MVM |
| cost_accounting | wafer_cost_model | ✅ | ❌ | Domain not in MVM |
| cost_accounting | wbs_element | ✅ | ❌ | Domain not in MVM |
| intercompany_consolidation | consolidation_entry | ✅ | ❌ | Domain not in MVM |
| intercompany_consolidation | consolidation_group | ✅ | ❌ | Domain not in MVM |
| intercompany_consolidation | consolidation_unit | ✅ | ❌ | Domain not in MVM |
| intercompany_consolidation | intercompany_agreement | ✅ | ❌ | Domain not in MVM |
| intercompany_consolidation | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| intercompany_consolidation | tax_provision | ✅ | ❌ | Domain not in MVM |
| ledger_management | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_management | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_management | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| revenue_pricing | finance_nre_agreement | ✅ | ❌ | Domain not in MVM |
| revenue_pricing | finance_nre_milestone | ✅ | ❌ | Domain not in MVM |
| revenue_pricing | standard_cost | ✅ | ❌ | Domain not in MVM |
| revenue_pricing | transfer_price | ✅ | ❌ | Domain not in MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| material_management | consignment_stock | ✅ | ❌ | Excluded from MVM |
| material_management | finished_good | ✅ | ✅ |  |
| material_management | raw_material | ✅ | ✅ |  |
| material_management | stock_valuation | ✅ | ❌ | Excluded from MVM |
| stock_control | goods_movement | ✅ | ✅ |  |
| stock_control | physical_inventory | ✅ | ❌ | Excluded from MVM |
| stock_control | reservation | ✅ | ✅ |  |
| stock_control | stock_balance | ✅ | ✅ |  |
| stock_control | storage_location | ✅ | ✅ |  |
| wafer_tracking | die_bank | ✅ | ✅ |  |
| wafer_tracking | inventory_kgd_certification | ✅ | ❌ | Excluded from MVM |
| wafer_tracking | inventory_lot_genealogy | ✅ | ❌ | Excluded from MVM |
| wafer_tracking | inventory_lot_hold | ✅ | ❌ | Excluded from MVM |
| wafer_tracking | inventory_wafer_lot | ✅ | ✅ |  |
| wafer_tracking | photomask_asset | ✅ | ❌ | Excluded from MVM |

<a id="domain-invoice"></a>
### invoice

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_transactions | adjustment_memo | ✅ | ❌ | Domain not in MVM |
| billing_transactions | ar_invoice | ✅ | ❌ | Domain not in MVM |
| billing_transactions | invoice_line | ✅ | ❌ | Domain not in MVM |
| billing_transactions | nre_billing_milestone | ✅ | ❌ | Domain not in MVM |
| billing_transactions | royalty_billing | ✅ | ❌ | Domain not in MVM |
| collections_settlement | credit_hold | ✅ | ❌ | Domain not in MVM |
| collections_settlement | customer_credit_limit | ✅ | ❌ | Domain not in MVM |
| collections_settlement | dunning_notice | ✅ | ❌ | Domain not in MVM |
| collections_settlement | payment_receipt | ✅ | ❌ | Domain not in MVM |
| collections_settlement | payment_term | ✅ | ❌ | Domain not in MVM |
| collections_settlement | write_off | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | dispute | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | performance_obligation | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | pricing_agreement | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | recognition_schedule | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | tax_determination | ✅ | ❌ | Domain not in MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commitment_execution | allocation_record | ✅ | ✅ |  |
| commitment_execution | die_bank_order | ✅ | ❌ | Excluded from MVM |
| commitment_execution | mpw_order | ✅ | ❌ | Excluded from MVM |
| commitment_execution | nre_order | ✅ | ❌ | Excluded from MVM |
| commitment_execution | order_nre_milestone | ✅ | ❌ | Excluded from MVM |
| commitment_execution | wafer_start_authorization | ✅ | ❌ | Excluded from MVM |
| sales_fulfillment | amendment | ✅ | ❌ | Excluded from MVM |
| sales_fulfillment | backlog_position | ✅ | ✅ |  |
| sales_fulfillment | blanket_order | ✅ | ❌ | Excluded from MVM |
| sales_fulfillment | line | ❌ | ✅ | MVM only (stub or new) |
| sales_fulfillment | order | ✅ | ✅ |  |
| sales_fulfillment | order_hold | ✅ | ❌ | Excluded from MVM |
| sales_fulfillment | order_line | ✅ | ❌ | Excluded from MVM |
| sales_fulfillment | status_history | ✅ | ✅ |  |
| shipment_delivery | delivery_confirmation | ✅ | ❌ | Excluded from MVM |
| shipment_delivery | delivery_schedule | ✅ | ✅ |  |
| shipment_delivery | lot_assignment | ✅ | ❌ | Excluded from MVM |
| shipment_delivery | rma | ✅ | ✅ |  |
| shipment_delivery | shipment | ✅ | ✅ |  |
| shipment_delivery | shipment_line | ✅ | ✅ |  |

<a id="domain-packaging"></a>
### packaging

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | assembly_order_extended | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_defect | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_lot | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_order | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_process_flow | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_step_record | ✅ | ❌ | Domain not in MVM |
| assembly_operations | assembly_yield | ✅ | ❌ | Domain not in MVM |
| assembly_operations | osat_vendor | ✅ | ❌ | Domain not in MVM |
| assembly_operations | packaging_line | ✅ | ❌ | Domain not in MVM |
| package_engineering | assembly_change_notice | ✅ | ❌ | Domain not in MVM |
| package_engineering | customer_requirement | ✅ | ❌ | Domain not in MVM |
| package_engineering | material_lot | ✅ | ❌ | Domain not in MVM |
| package_engineering | package_type | ✅ | ❌ | Domain not in MVM |
| package_engineering | substrate_bom | ✅ | ❌ | Domain not in MVM |
| quality_reliability | inspection_result | ✅ | ❌ | Domain not in MVM |
| quality_reliability | package_qualification | ✅ | ❌ | Domain not in MVM |
| quality_reliability | qualification_plan | ✅ | ❌ | Domain not in MVM |
| quality_reliability | reliability_stress_test | ✅ | ❌ | Domain not in MVM |

<a id="domain-process"></a>
### process

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| condition_parameters | cmp_condition | ✅ | ❌ | Excluded from MVM |
| condition_parameters | deposition_condition | ✅ | ❌ | Excluded from MVM |
| condition_parameters | doe_experiment | ✅ | ❌ | Excluded from MVM |
| condition_parameters | etch_condition | ✅ | ❌ | Excluded from MVM |
| condition_parameters | implant_condition | ✅ | ❌ | Excluded from MVM |
| condition_parameters | litho_condition | ✅ | ❌ | Excluded from MVM |
| condition_parameters | meef_parameter | ✅ | ❌ | Excluded from MVM |
| condition_parameters | opc_rule_set | ✅ | ❌ | Excluded from MVM |
| condition_parameters | process_technology_node | ✅ | ❌ | Excluded from MVM |
| flow_management | change_notification | ✅ | ❌ | Excluded from MVM |
| flow_management | flow_qualification | ✅ | ❌ | Excluded from MVM |
| flow_management | lot_process_run | ✅ | ✅ |  |
| flow_management | process_flow | ✅ | ❌ | Excluded from MVM |
| flow_management | process_qualification | ✅ | ❌ | Excluded from MVM |
| flow_management | process_step | ✅ | ❌ | Excluded from MVM |
| flow_management | process_supply_agreement | ✅ | ❌ | Excluded from MVM |
| flow_management | recipe | ✅ | ✅ |  |
| inspection_metrology | defect_inspection_result | ✅ | ✅ |  |
| inspection_metrology | inspection_point | ✅ | ❌ | Excluded from MVM |
| inspection_metrology | metrology_plan | ✅ | ❌ | Excluded from MVM |
| inspection_metrology | process_metrology_measurement | ✅ | ❌ | Excluded from MVM |
| inspection_metrology | process_site_map | ✅ | ❌ | Excluded from MVM |
| inspection_metrology | sampling_plan | ✅ | ❌ | Excluded from MVM |
| inspection_metrology | yield_loss_event | ✅ | ✅ |  |
| manufacturing_execution | qualification | ❌ | ✅ | MVM only (stub or new) |
| quality_monitoring | metrology_measurement | ❌ | ✅ | MVM only (stub or new) |
| recipe_engineering | flow | ❌ | ✅ | MVM only (stub or new) |
| recipe_engineering | step | ❌ | ✅ | MVM only (stub or new) |
| statistical_control | capability | ✅ | ❌ | Excluded from MVM |
| statistical_control | excursion | ✅ | ✅ |  |
| statistical_control | ocap_action | ✅ | ❌ | Excluded from MVM |
| statistical_control | process_spc_control_plan | ✅ | ❌ | Excluded from MVM |
| statistical_control | spc_control_chart | ✅ | ✅ |  |
| statistical_control | spc_measurement | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_masters | bom | ✅ | ✅ |  |
| catalog_masters | bom_line | ✅ | ✅ |  |
| catalog_masters | configuration_rule | ✅ | ❌ | Excluded from MVM |
| catalog_masters | family | ✅ | ✅ |  |
| catalog_masters | ic_catalog | ✅ | ✅ |  |
| catalog_masters | process_node | ✅ | ❌ | Excluded from MVM |
| catalog_masters | product_spec | ✅ | ✅ |  |
| catalog_masters | sku | ✅ | ✅ |  |
| licensing_agreements | license_agreement | ✅ | ❌ | Excluded from MVM |
| licensing_agreements | license_allocation | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | compliance_cert | ✅ | ✅ |  |
| lifecycle_compliance | errata | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | pcn | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | product_ip_core | ✅ | ✅ |  |
| lifecycle_compliance | product_ltb_notification | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | product_qualification_program | ✅ | ❌ | Excluded from MVM |
| lifecycle_compliance | product_sample_request | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_governance | audit | ✅ | ❌ | Excluded from MVM |
| audit_governance | control_plan | ✅ | ✅ |  |
| audit_governance | customer_complaint | ✅ | ✅ |  |
| audit_governance | quality_audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_governance | quality_document | ✅ | ❌ | Excluded from MVM |
| audit_governance | quality_notification | ✅ | ❌ | Excluded from MVM |
| audit_governance | quality_spec | ✅ | ✅ |  |
| audit_governance | test_plan | ✅ | ❌ | Excluded from MVM |
| inspection_control | defect_cluster | ✅ | ❌ | Excluded from MVM |
| inspection_control | defect_record | ✅ | ✅ |  |
| inspection_control | inspection_lot | ✅ | ✅ |  |
| inspection_control | quality_metrology_measurement | ✅ | ❌ | Excluded from MVM |
| inspection_control | spc_chart | ✅ | ❌ | Excluded from MVM |
| inspection_control | wafer_map | ✅ | ✅ |  |
| inspection_control | wafer_zone | ✅ | ❌ | Excluded from MVM |
| inspection_control | yield_record | ✅ | ✅ |  |
| reliability_assurance | failure_analysis_report | ✅ | ✅ |  |
| reliability_assurance | fmea_record | ✅ | ❌ | Excluded from MVM |
| reliability_assurance | qualification_report | ✅ | ❌ | Excluded from MVM |
| reliability_assurance | quality_kgd_certification | ✅ | ❌ | Excluded from MVM |
| reliability_assurance | quality_qualification_program | ✅ | ❌ | Excluded from MVM |
| reliability_assurance | reliability_test | ✅ | ✅ |  |
| supplier_compliance | capa_record | ✅ | ✅ |  |
| supplier_compliance | dppm_record | ✅ | ✅ |  |
| supplier_compliance | mrb_meeting | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | nonconformance_report | ✅ | ✅ |  |
| supplier_compliance | quality_hold | ✅ | ❌ | Excluded from MVM |
| supplier_compliance | supplier_quality_scorecard | ✅ | ❌ | Excluded from MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| experimental_execution | characterization_result | ✅ | ❌ | Domain not in MVM |
| experimental_execution | experimental_lot | ✅ | ❌ | Domain not in MVM |
| experimental_execution | process_flow_experiment | ✅ | ❌ | Domain not in MVM |
| experimental_execution | process_integration_run | ✅ | ❌ | Domain not in MVM |
| experimental_execution | process_split | ✅ | ❌ | Domain not in MVM |
| experimental_execution | tapeout_experiment | ✅ | ❌ | Domain not in MVM |
| experimental_execution | yield_learning_record | ✅ | ❌ | Domain not in MVM |
| intellectual_property | invention_disclosure | ✅ | ❌ | Domain not in MVM |
| intellectual_property | ip_core_development | ✅ | ❌ | Domain not in MVM |
| intellectual_property | patent_filing | ✅ | ❌ | Domain not in MVM |
| intellectual_property | publication | ✅ | ❌ | Domain not in MVM |
| materials_innovation | materials_research | ✅ | ❌ | Domain not in MVM |
| materials_innovation | packaging_research | ✅ | ❌ | Domain not in MVM |
| program_management | budget_allocation | ✅ | ❌ | Domain not in MVM |
| program_management | collaboration | ✅ | ❌ | Domain not in MVM |
| program_management | compliance_assessment | ✅ | ❌ | Domain not in MVM |
| program_management | government_grant | ✅ | ❌ | Domain not in MVM |
| program_management | program_partner_collaboration | ✅ | ❌ | Domain not in MVM |
| program_management | project | ✅ | ❌ | Domain not in MVM |
| program_management | research_milestone | ✅ | ❌ | Domain not in MVM |
| program_management | research_program | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | competitive_benchmark | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | device_architecture | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | pdk_development | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | research_technology_node | ✅ | ❌ | Domain not in MVM |
| technology_roadmap | technology_roadmap | ✅ | ❌ | Domain not in MVM |
| test_characterization | research_test_plan | ✅ | ❌ | Domain not in MVM |
| test_characterization | test_structure | ✅ | ❌ | Domain not in MVM |
| test_characterization | test_suite | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_coverage | campaign | ✅ | ❌ | Excluded from MVM |
| channel_coverage | channel_partner | ✅ | ❌ | Excluded from MVM |
| channel_coverage | partner_inventory | ✅ | ❌ | Excluded from MVM |
| channel_coverage | territory | ✅ | ❌ | Excluded from MVM |
| commercial_pricing | nre_agreement | ❌ | ✅ | MVM only (stub or new) |
| contract_pricing | booking | ✅ | ✅ |  |
| contract_pricing | customer_contract | ✅ | ✅ |  |
| contract_pricing | price_list | ✅ | ✅ |  |
| contract_pricing | rebate_program | ✅ | ❌ | Excluded from MVM |
| contract_pricing | sales_forecast | ✅ | ❌ | Excluded from MVM |
| design_engagement | lead_program_interest | ✅ | ❌ | Excluded from MVM |
| design_engagement | opportunity_project_assignment | ✅ | ❌ | Excluded from MVM |
| design_engagement | sales_design_registration | ✅ | ❌ | Excluded from MVM |
| design_engagement | sales_design_win | ✅ | ❌ | Excluded from MVM |
| design_engagement | sales_nre_agreement | ✅ | ❌ | Excluded from MVM |
| pipeline_management | activity | ✅ | ❌ | Excluded from MVM |
| pipeline_management | forecast | ❌ | ✅ | MVM only (stub or new) |
| pipeline_management | lead | ✅ | ❌ | Excluded from MVM |
| pipeline_management | opportunity | ✅ | ✅ |  |
| pipeline_management | quote | ✅ | ✅ |  |
| pipeline_management | quote_line | ✅ | ✅ |  |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| shared_core | location | ✅ | ❌ | Domain not in MVM |
| shared_core | site | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| logistics_planning | carrier | ✅ | ❌ | Excluded from MVM |
| logistics_planning | inbound_shipment | ✅ | ✅ |  |
| logistics_planning | osat_work_order | ✅ | ✅ |  |
| logistics_planning | supply_forecast | ✅ | ❌ | Excluded from MVM |
| material_procurement | consignment_agreement | ✅ | ❌ | Excluded from MVM |
| material_procurement | goods_receipt | ✅ | ✅ |  |
| material_procurement | material_certification | ✅ | ❌ | Excluded from MVM |
| material_procurement | material_master | ✅ | ✅ |  |
| material_procurement | material_requirement_plan | ✅ | ✅ |  |
| material_procurement | po_line | ✅ | ✅ |  |
| material_procurement | purchase_order | ✅ | ✅ |  |
| material_procurement | sourcing_contract | ✅ | ❌ | Excluded from MVM |
| material_procurement | supply_agreement | ✅ | ❌ | Excluded from MVM |
| risk_operations | disruption_event | ✅ | ❌ | Excluded from MVM |
| risk_operations | product_change_notification | ✅ | ❌ | Excluded from MVM |
| risk_operations | risk_assessment | ✅ | ❌ | Excluded from MVM |
| vendor_management | approved_vendor | ✅ | ❌ | Excluded from MVM |
| vendor_management | approved_vendor_list | ❌ | ✅ | MVM only (stub or new) |
| vendor_management | supplier | ✅ | ✅ |  |
| vendor_management | supplier_audit | ✅ | ❌ | Excluded from MVM |
| vendor_management | supplier_corrective_action | ✅ | ❌ | Excluded from MVM |
| vendor_management | supplier_qualification | ✅ | ✅ |  |
| vendor_management | supplier_quotation | ✅ | ❌ | Excluded from MVM |
| vendor_management | supplier_scorecard | ✅ | ❌ | Excluded from MVM |

<a id="domain-test"></a>
### test

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_configuration | ate_configuration | ✅ | ✅ |  |
| equipment_configuration | probe_card | ✅ | ✅ |  |
| equipment_configuration | program | ❌ | ✅ | MVM only (stub or new) |
| execution_results | final_test_run | ✅ | ✅ |  |
| execution_results | parametric_measurement | ✅ | ✅ |  |
| execution_results | reliability_test_run | ✅ | ❌ | Excluded from MVM |
| execution_results | unit_test_result | ✅ | ✅ |  |
| execution_results | wafer_probe_run | ✅ | ✅ |  |
| program_management | adaptive_test_flow | ✅ | ❌ | Excluded from MVM |
| program_management | bin_definition | ✅ | ✅ |  |
| program_management | coverage | ✅ | ❌ | Excluded from MVM |
| program_management | insertion | ✅ | ❌ | Excluded from MVM |
| program_management | limit | ✅ | ✅ |  |
| program_management | program_assignment | ✅ | ❌ | Excluded from MVM |
| program_management | test_program | ✅ | ❌ | Excluded from MVM |
| quality_analysis | correlation_study | ✅ | ❌ | Excluded from MVM |
| quality_analysis | test_case | ✅ | ❌ | Excluded from MVM |
| quality_analysis | test_step | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | compensation | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | employment_event | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | time_entry | ✅ | ❌ | Domain not in MVM |
| fab_operations | cleanroom_access | ✅ | ❌ | Domain not in MVM |
| fab_operations | contractor_engagement | ✅ | ❌ | Domain not in MVM |
| fab_operations | shift_pattern | ✅ | ❌ | Domain not in MVM |
| fab_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| fab_operations | site_assignment | ✅ | ❌ | Domain not in MVM |
| personnel_records | competency | ✅ | ❌ | Domain not in MVM |
| personnel_records | employee | ✅ | ❌ | Domain not in MVM |
| personnel_records | job | ✅ | ❌ | Domain not in MVM |
| personnel_records | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_records | position | ✅ | ❌ | Domain not in MVM |
| personnel_records | skill | ✅ | ❌ | Domain not in MVM |
| safety_compliance | export_control | ✅ | ❌ | Domain not in MVM |
| safety_compliance | safety_event | ✅ | ❌ | Domain not in MVM |
| talent_development | fab_operator_qualification | ✅ | ❌ | Domain not in MVM |
| talent_development | talent_acquisition | ✅ | ❌ | Domain not in MVM |
| talent_development | training | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_qualification | ✅ | ❌ | Domain not in MVM |
