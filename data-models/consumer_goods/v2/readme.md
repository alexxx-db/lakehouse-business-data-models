# Consumer_Goods Lakehouse Data Models

**Version 2** | Generated on June 27, 2026 at 07:48 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Consumer](#domain-consumer)
  - [Customer](#domain-customer)
  - [Distribution](#domain-distribution)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Manufacturing](#domain-manufacturing)
  - [Marketing](#domain-marketing)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Promotion](#domain-promotion)
  - [Quality](#domain-quality)
  - [Regulatory](#domain-regulatory)
  - [Research](#domain-research)
  - [Sales](#domain-sales)
  - [Shared](#domain-shared)
  - [Supply](#domain-supply)
  - [Sustainability](#domain-sustainability)
  - [Workforce](#domain-workforce)


## Business Description

consumer goods industry enterprise data model.

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
| Domains | 11 | 19 |
| Subdomains | 29 | 70 |
| Products (Tables) | 115 | 405 |
| Attributes (Columns) | 6705 | 22358 |
| Foreign Keys | 791 | 2363 |
| Avg Attributes/Product | 58.3 | 55.2 |

## Domain & Product Comparison

<a id="domain-consumer"></a>
### consumer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| direct_commerce | dtc_order | ✅ | ✅ |  |
| direct_commerce | dtc_order_line | ✅ | ✅ |  |
| direct_commerce | dtc_return | ✅ | ❌ | Excluded from MVM |
| direct_commerce | subscription | ✅ | ✅ |  |
| engagement_preferences | communication_preference | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | consent_event | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | consent_record | ✅ | ✅ |  |
| engagement_preferences | consent_session | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | data_subject_request | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | preference | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | preference_center | ✅ | ❌ | Excluded from MVM |
| identity_management | address | ✅ | ✅ |  |
| identity_management | household | ✅ | ✅ |  |
| identity_management | identity_link | ✅ | ❌ | Excluded from MVM |
| identity_management | segment | ✅ | ✅ |  |
| identity_management | segment_membership | ✅ | ✅ |  |
| identity_management | shopper | ✅ | ✅ |  |
| loyalty_programs | cltv_record | ✅ | ❌ | Excluded from MVM |
| loyalty_programs | loyalty_account | ✅ | ✅ |  |
| loyalty_programs | loyalty_program | ✅ | ❌ | Excluded from MVM |
| loyalty_programs | loyalty_tier | ✅ | ❌ | Excluded from MVM |
| loyalty_programs | loyalty_transaction | ✅ | ✅ |  |
| loyalty_programs | referral | ✅ | ❌ | Excluded from MVM |
| research_insights | interaction | ✅ | ❌ | Excluded from MVM |
| research_insights | interaction_session | ✅ | ❌ | Excluded from MVM |
| research_insights | nps_response | ✅ | ❌ | Excluded from MVM |
| research_insights | panel | ✅ | ❌ | Excluded from MVM |
| research_insights | research_participation | ✅ | ❌ | Excluded from MVM |
| research_insights | survey | ✅ | ❌ | Excluded from MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | channel_classification | ✅ | ❌ | Domain not in MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | service_day_pattern_ref | ✅ | ❌ | Excluded from MVM |
| direct_delivery | distribution_dsd_delivery | ✅ | ❌ | Excluded from MVM |
| direct_delivery | distribution_dsd_route | ✅ | ❌ | Excluded from MVM |
| direct_delivery | dsd_delivery_line | ✅ | ❌ | Excluded from MVM |
| facility_operations | distribution_cycle_count | ✅ | ❌ | Excluded from MVM |
| facility_operations | distribution_facility | ✅ | ✅ |  |
| facility_operations | distribution_offset_allocation | ✅ | ❌ | Excluded from MVM |
| facility_operations | distribution_storage_location | ✅ | ❌ | Excluded from MVM |
| facility_operations | inventory_position | ✅ | ✅ |  |
| facility_operations | storage_location | ❌ | ✅ | MVM only (stub or new) |
| facility_operations | wave | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | dock_appointment | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | inbound_receipt | ✅ | ✅ |  |
| inbound_receiving | inbound_receipt_line | ✅ | ✅ |  |
| inbound_receiving | putaway_task | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | returns_receipt | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | distribution_shipment | ✅ | ✅ |  |
| outbound_fulfillment | load_plan | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | otif_event | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | outbound_order | ✅ | ✅ |  |
| outbound_fulfillment | outbound_order_line | ✅ | ✅ |  |
| outbound_fulfillment | pack_task | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | pick_task | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_compliance | fixed_asset | ✅ | ❌ | Excluded from MVM |
| asset_compliance | sox_control | ✅ | ❌ | Excluded from MVM |
| controlling_structure | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| controlling_structure | cogs_allocation | ✅ | ❌ | Excluded from MVM |
| controlling_structure | company_code | ✅ | ✅ |  |
| controlling_structure | controlling_area | ✅ | ❌ | Excluded from MVM |
| controlling_structure | cost_center | ✅ | ✅ |  |
| controlling_structure | gl_account | ✅ | ✅ |  |
| controlling_structure | ledger | ✅ | ✅ |  |
| controlling_structure | profit_center | ✅ | ✅ |  |
| controlling_structure | standard_cost | ✅ | ✅ |  |
| ledger_posting | finance_accrual | ✅ | ❌ | Excluded from MVM |
| ledger_posting | finance_budget | ✅ | ❌ | Excluded from MVM |
| ledger_posting | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| ledger_posting | journal_entry | ✅ | ✅ |  |
| ledger_posting | journal_entry_line | ✅ | ✅ |  |
| ledger_posting | material_ledger_posting | ✅ | ❌ | Excluded from MVM |
| ledger_posting | revenue_recognition | ✅ | ❌ | Excluded from MVM |
| payables_settlement | ap_invoice | ✅ | ✅ |  |
| payables_settlement | ap_payment | ✅ | ✅ |  |
| payables_settlement | bank_account | ✅ | ❌ | Excluded from MVM |
| payables_settlement | netting_run | ✅ | ❌ | Excluded from MVM |
| payables_settlement | payment_run | ✅ | ❌ | Excluded from MVM |
| revenue_management | ar_invoice | ✅ | ✅ |  |
| revenue_management | ar_payment | ✅ | ✅ |  |
| revenue_management | contract_party | ✅ | ❌ | Excluded from MVM |
| revenue_management | party | ✅ | ❌ | Excluded from MVM |
| revenue_management | performance_obligation | ✅ | ❌ | Excluded from MVM |
| revenue_management | revenue_contract | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| availability_management | oos_event | ✅ | ❌ | Domain not in MVM |
| availability_management | recall_event | ✅ | ❌ | Domain not in MVM |
| availability_management | warehouse | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | intransit_shipment | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | inventory_cycle_count | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | inventory_replenishment_order | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | inventory_vmi_agreement | ✅ | ❌ | Domain not in MVM |
| replenishment_planning | safety_stock_policy | ✅ | ❌ | Domain not in MVM |
| stock_control | inventory_storage_location | ✅ | ❌ | Domain not in MVM |
| stock_control | lot_batch | ✅ | ❌ | Domain not in MVM |
| stock_control | reservation | ✅ | ❌ | Domain not in MVM |
| stock_control | stock_adjustment | ✅ | ❌ | Domain not in MVM |
| stock_control | stock_hold | ✅ | ❌ | Domain not in MVM |
| stock_control | stock_movement | ✅ | ❌ | Domain not in MVM |
| stock_control | stock_position | ✅ | ❌ | Domain not in MVM |
| stock_control | stock_valuation | ✅ | ❌ | Domain not in MVM |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_contract | ✅ | ✅ |  |
| carrier_management | carrier_performance | ✅ | ✅ |  |
| carrier_management | freight_rate | ✅ | ❌ | Excluded from MVM |
| carrier_management | lane | ✅ | ✅ |  |
| carrier_management | third_party_provider | ✅ | ❌ | Excluded from MVM |
| delivery_operations | cold_chain_log | ✅ | ❌ | Excluded from MVM |
| delivery_operations | delivery | ✅ | ✅ |  |
| delivery_operations | proof_of_delivery | ✅ | ✅ |  |
| delivery_operations | route | ✅ | ❌ | Excluded from MVM |
| delivery_operations | route_stop | ✅ | ❌ | Excluded from MVM |
| delivery_operations | tracking_event | ✅ | ❌ | Excluded from MVM |
| delivery_operations | transport_exception | ✅ | ❌ | Excluded from MVM |
| delivery_operations | vehicle | ✅ | ❌ | Excluded from MVM |
| freight_costing | freight_audit_result | ✅ | ❌ | Excluded from MVM |
| freight_costing | freight_cost | ✅ | ❌ | Excluded from MVM |
| freight_costing | freight_invoice | ✅ | ✅ |  |
| shipment_execution | consolidation | ✅ | ❌ | Excluded from MVM |
| shipment_execution | customs_declaration | ✅ | ❌ | Excluded from MVM |
| shipment_execution | freight_order | ✅ | ✅ |  |
| shipment_execution | handling_unit | ✅ | ❌ | Excluded from MVM |
| shipment_execution | logistics_shipment | ✅ | ✅ |  |
| shipment_execution | shipment_item | ✅ | ✅ |  |
| shipment_execution | shipment_leg | ✅ | ✅ |  |
| shipment_execution | transport_unit | ✅ | ❌ | Excluded from MVM |

<a id="domain-manufacturing"></a>
### manufacturing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_operations | equipment | ✅ | ✅ |  |
| facility_operations | manufacturing_facility | ✅ | ✅ |  |
| facility_operations | production_line | ✅ | ✅ |  |
| facility_operations | work_center | ✅ | ✅ |  |
| performance_quality | downtime_event | ✅ | ❌ | Excluded from MVM |
| performance_quality | gmp_event | ✅ | ❌ | Excluded from MVM |
| performance_quality | oee_record | ✅ | ❌ | Excluded from MVM |
| performance_quality | process_parameter | ✅ | ❌ | Excluded from MVM |
| production_planning | manufacturing_bom | ✅ | ✅ |  |
| production_planning | planned_order | ✅ | ✅ |  |
| production_planning | routing | ✅ | ✅ |  |
| shop_execution | batch_record | ✅ | ✅ |  |
| shop_execution | changeover | ✅ | ❌ | Excluded from MVM |
| shop_execution | production_confirmation | ✅ | ✅ |  |
| shop_execution | production_order | ✅ | ✅ |  |
| shop_execution | yield_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_insights | consumer_segment | ✅ | ✅ |  |
| audience_insights | event_participation | ✅ | ❌ | Excluded from MVM |
| audience_insights | market_research_study | ✅ | ❌ | Excluded from MVM |
| audience_insights | market_share_record | ✅ | ❌ | Excluded from MVM |
| audience_insights | nielsen_panel_insight | ✅ | ❌ | Excluded from MVM |
| audience_insights | social_listening_record | ✅ | ❌ | Excluded from MVM |
| brand_strategy | agency | ✅ | ✅ |  |
| brand_strategy | brand_assignment | ✅ | ❌ | Excluded from MVM |
| brand_strategy | brand_distribution_allocation | ✅ | ❌ | Excluded from MVM |
| brand_strategy | brand_health_tracker | ✅ | ❌ | Excluded from MVM |
| brand_strategy | influencer | ✅ | ❌ | Excluded from MVM |
| brand_strategy | marketing_brand | ✅ | ✅ |  |
| brand_strategy | marketing_event | ✅ | ❌ | Excluded from MVM |
| brand_strategy | sponsorship | ✅ | ❌ | Excluded from MVM |
| campaign_execution | attribution | ✅ | ❌ | Excluded from MVM |
| campaign_execution | budget | ❌ | ✅ | MVM only (stub or new) |
| campaign_execution | campaign | ✅ | ✅ |  |
| campaign_execution | campaign_assignment | ✅ | ❌ | Excluded from MVM |
| campaign_execution | campaign_flight | ✅ | ✅ |  |
| campaign_execution | campaign_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| campaign_execution | campaign_submission_link | ✅ | ❌ | Excluded from MVM |
| campaign_execution | creative_asset | ✅ | ✅ |  |
| campaign_execution | digital_performance | ✅ | ❌ | Excluded from MVM |
| media_investment | marketing_budget | ✅ | ❌ | Excluded from MVM |
| media_investment | marketing_offset_allocation | ✅ | ❌ | Excluded from MVM |
| media_investment | media_plan | ✅ | ✅ |  |
| media_investment | media_spend | ✅ | ✅ |  |
| media_investment | sov_measurement | ✅ | ❌ | Excluded from MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_agreements | procurement_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| inventory_agreements | vmi_agreement_type | ✅ | ❌ | Excluded from MVM |
| invoice_processing | compliance_document | ✅ | ❌ | Excluded from MVM |
| invoice_processing | invoice_line | ✅ | ✅ |  |
| invoice_processing | service | ✅ | ❌ | Excluded from MVM |
| invoice_processing | service_entry_sheet | ✅ | ❌ | Excluded from MVM |
| invoice_processing | service_entry_sheet_line | ✅ | ❌ | Excluded from MVM |
| invoice_processing | supplier_invoice | ✅ | ✅ |  |
| procurement_order_fulfillment | delivery_schedule | ✅ | ❌ | Excluded from MVM |
| procurement_order_fulfillment | goods_receipt | ✅ | ✅ |  |
| procurement_order_fulfillment | po_confirmation | ✅ | ❌ | Excluded from MVM |
| procurement_order_fulfillment | po_line | ✅ | ✅ |  |
| procurement_order_fulfillment | purchase_order | ✅ | ✅ |  |
| procurement_order_fulfillment | purchase_requisition | ✅ | ✅ |  |
| sourcing_events | rfq | ✅ | ❌ | Excluded from MVM |
| sourcing_events | rfq_response | ✅ | ❌ | Excluded from MVM |
| sourcing_events | sourcing_event | ✅ | ❌ | Excluded from MVM |
| supplier_management | approved_supplier_list | ✅ | ✅ |  |
| supplier_management | contract_line | ✅ | ✅ |  |
| supplier_management | price_condition | ✅ | ❌ | Excluded from MVM |
| supplier_management | spend_category | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | supplier_contract | ✅ | ✅ |  |
| supplier_management | supplier_qualification | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_scorecard | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_site | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| brand_portfolio | certification | ✅ | ❌ | Excluded from MVM |
| brand_portfolio | label_spec | ✅ | ✅ |  |
| brand_portfolio | product_brand | ✅ | ✅ |  |
| brand_portfolio | product_claim | ✅ | ❌ | Excluded from MVM |
| brand_portfolio | product_registration | ✅ | ❌ | Excluded from MVM |
| formulation_composition | formulation | ❌ | ✅ | MVM only (stub or new) |
| formulation_specification | bom_line | ✅ | ✅ |  |
| formulation_specification | plm_transition | ✅ | ❌ | Excluded from MVM |
| formulation_specification | product_bom | ✅ | ✅ |  |
| formulation_specification | product_formulation | ✅ | ❌ | Excluded from MVM |
| formulation_specification | product_formulation_ingredient | ✅ | ❌ | Excluded from MVM |
| formulation_specification | product_packaging_spec | ✅ | ❌ | Excluded from MVM |
| packaging_labeling | packaging_spec | ❌ | ✅ | MVM only (stub or new) |
| packaging_labeling | registration | ❌ | ✅ | MVM only (stub or new) |
| sku_master | category | ✅ | ✅ |  |
| sku_master | gtin_registry | ✅ | ✅ |  |
| sku_master | hierarchy | ✅ | ✅ |  |
| sku_master | material | ✅ | ✅ |  |
| sku_master | pack_hierarchy | ✅ | ❌ | Excluded from MVM |
| sku_master | sku | ✅ | ✅ |  |
| sku_master | sku_group | ✅ | ❌ | Excluded from MVM |
| sku_master | sku_substitution | ✅ | ❌ | Excluded from MVM |
| supply_agreements | freight_contract_assignment | ✅ | ❌ | Excluded from MVM |
| supply_agreements | supply_agreement | ✅ | ❌ | Excluded from MVM |
| supply_agreements | vmi_sku_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-promotion"></a>
### promotion

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| performance_measurement | baseline_volume | ✅ | ❌ | Domain not in MVM |
| performance_measurement | lift_measurement | ✅ | ❌ | Domain not in MVM |
| performance_measurement | pos_redemption | ✅ | ❌ | Domain not in MVM |
| performance_measurement | post_event_analysis | ✅ | ❌ | Domain not in MVM |
| performance_measurement | retailer_compliance | ✅ | ❌ | Domain not in MVM |
| spend_settlement | deduction_settlement | ✅ | ❌ | Domain not in MVM |
| spend_settlement | funding_agreement | ✅ | ❌ | Domain not in MVM |
| spend_settlement | promotion_accrual | ✅ | ❌ | Domain not in MVM |
| spend_settlement | promotion_deduction | ✅ | ❌ | Domain not in MVM |
| spend_settlement | promotion_rebate_agreement | ✅ | ❌ | Domain not in MVM |
| spend_settlement | rebate_settlement | ✅ | ❌ | Domain not in MVM |
| spend_settlement | trade_spend_allocation | ✅ | ❌ | Domain not in MVM |
| trade_planning | consumer_offer | ✅ | ❌ | Domain not in MVM |
| trade_planning | event_sku | ✅ | ❌ | Domain not in MVM |
| trade_planning | flight_allocation | ✅ | ❌ | Domain not in MVM |
| trade_planning | promoted_price | ✅ | ❌ | Domain not in MVM |
| trade_planning | promotion_event | ✅ | ❌ | Domain not in MVM |
| trade_planning | tpo_scenario | ✅ | ❌ | Domain not in MVM |
| trade_planning | trade_calendar | ✅ | ❌ | Domain not in MVM |
| trade_planning | trade_promotion | ✅ | ❌ | Domain not in MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_compliance | audit_checklist | ✅ | ❌ | Excluded from MVM |
| audit_compliance | audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_compliance | audit_program | ✅ | ❌ | Excluded from MVM |
| audit_compliance | gmp_audit | ✅ | ❌ | Excluded from MVM |
| audit_compliance | supplier_assessment | ✅ | ❌ | Excluded from MVM |
| deviation_management | batch_release | ✅ | ✅ |  |
| deviation_management | capa | ✅ | ✅ |  |
| deviation_management | change_control | ✅ | ❌ | Excluded from MVM |
| deviation_management | nonconformance | ✅ | ✅ |  |
| deviation_management | notification | ✅ | ❌ | Excluded from MVM |
| deviation_management | product_complaint | ✅ | ✅ |  |
| deviation_management | regulatory_hold | ✅ | ❌ | Excluded from MVM |
| inspection_control | control_chart | ✅ | ❌ | Excluded from MVM |
| inspection_control | inspection_lot | ✅ | ✅ |  |
| inspection_control | inspection_plan | ✅ | ✅ |  |
| inspection_control | inspection_result | ✅ | ✅ |  |
| inspection_control | specification | ✅ | ✅ |  |
| inspection_control | usage_decision | ✅ | ✅ |  |
| laboratory_testing | certificate_of_analysis | ✅ | ✅ |  |
| laboratory_testing | lab_test_request | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | laboratory | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | quality_stability_study | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | sample | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | stability_result | ✅ | ❌ | Excluded from MVM |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| label_integrity | label_version | ✅ | ❌ | Domain not in MVM |
| label_integrity | regulatory_claim | ✅ | ❌ | Domain not in MVM |
| obligation_management | change | ✅ | ❌ | Domain not in MVM |
| obligation_management | compliance_assessment | ✅ | ❌ | Domain not in MVM |
| obligation_management | compliance_obligation | ✅ | ❌ | Domain not in MVM |
| obligation_management | jurisdiction | ✅ | ❌ | Domain not in MVM |
| registration_compliance | dossier | ✅ | ❌ | Domain not in MVM |
| registration_compliance | epa_registration | ✅ | ❌ | Domain not in MVM |
| registration_compliance | regulatory_registration | ✅ | ❌ | Domain not in MVM |
| registration_compliance | submission | ✅ | ❌ | Domain not in MVM |
| submission_tracking | action | ✅ | ❌ | Domain not in MVM |
| submission_tracking | cpsc_filing | ✅ | ❌ | Domain not in MVM |
| submission_tracking | product_recall | ✅ | ❌ | Domain not in MVM |
| submission_tracking | surveillance_event | ✅ | ❌ | Domain not in MVM |
| substance_control | ifra_compliance_record | ✅ | ❌ | Domain not in MVM |
| substance_control | ingredient_list | ✅ | ❌ | Domain not in MVM |
| substance_control | reach_substance | ✅ | ❌ | Domain not in MVM |
| substance_control | restricted_substance | ✅ | ❌ | Domain not in MVM |
| substance_control | sds | ✅ | ❌ | Domain not in MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| consumer_insights | consumer_test | ✅ | ❌ | Domain not in MVM |
| consumer_insights | consumer_test_result | ✅ | ❌ | Domain not in MVM |
| consumer_insights | panel_session | ✅ | ❌ | Domain not in MVM |
| consumer_insights | respondent | ✅ | ❌ | Domain not in MVM |
| consumer_insights | sensory_evaluation | ✅ | ❌ | Domain not in MVM |
| consumer_insights | study_protocol | ✅ | ❌ | Domain not in MVM |
| formulation_science | inci_library | ✅ | ❌ | Domain not in MVM |
| formulation_science | raw_material_spec | ✅ | ❌ | Domain not in MVM |
| formulation_science | research_formulation | ✅ | ❌ | Domain not in MVM |
| formulation_science | research_formulation_ingredient | ✅ | ❌ | Domain not in MVM |
| formulation_science | research_packaging_spec | ✅ | ❌ | Domain not in MVM |
| innovation_pipeline | innovation_brief | ✅ | ❌ | Domain not in MVM |
| innovation_pipeline | prototype | ✅ | ❌ | Domain not in MVM |
| innovation_pipeline | rd_project | ✅ | ❌ | Domain not in MVM |
| innovation_pipeline | scale_up_trial | ✅ | ❌ | Domain not in MVM |
| innovation_pipeline | stage_gate_milestone | ✅ | ❌ | Domain not in MVM |
| intellectual_property | patent_family | ✅ | ❌ | Domain not in MVM |
| intellectual_property | patent_filing | ✅ | ❌ | Domain not in MVM |
| intellectual_property | regulatory_dossier | ✅ | ❌ | Domain not in MVM |
| intellectual_property | research_sample | ✅ | ❌ | Domain not in MVM |
| safety_testing | claim_substantiation | ✅ | ❌ | Domain not in MVM |
| safety_testing | lab_test | ✅ | ❌ | Domain not in MVM |
| safety_testing | research_stability_study | ✅ | ❌ | Domain not in MVM |
| safety_testing | safety_assessment | ✅ | ❌ | Domain not in MVM |
| safety_testing | stability_timepoint | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_address | ✅ | ✅ |  |
| account_management | account_assortment | ✅ | ❌ | Excluded from MVM |
| account_management | account_compliance_record | ✅ | ❌ | Excluded from MVM |
| account_management | account_contact | ✅ | ✅ |  |
| account_management | account_credit_profile | ✅ | ❌ | Excluded from MVM |
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | account_onboarding | ✅ | ❌ | Excluded from MVM |
| account_management | account_pricing_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | account_segment | ✅ | ❌ | Excluded from MVM |
| account_management | account_sla | ✅ | ❌ | Excluded from MVM |
| account_management | account_status_history | ✅ | ❌ | Excluded from MVM |
| account_management | account_team | ✅ | ❌ | Excluded from MVM |
| account_management | edi_trading_partner | ✅ | ❌ | Excluded from MVM |
| account_management | retail_store | ✅ | ✅ |  |
| account_management | trade_account | ✅ | ✅ |  |
| direct_delivery | customer_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| direct_delivery | sales_dsd_delivery | ✅ | ❌ | Excluded from MVM |
| direct_delivery | sales_dsd_route | ✅ | ❌ | Excluded from MVM |
| direct_delivery | sales_vmi_agreement | ✅ | ❌ | Excluded from MVM |
| field_execution | account_call | ✅ | ❌ | Excluded from MVM |
| field_execution | call | ✅ | ❌ | Excluded from MVM |
| field_execution | compliance_assignment | ✅ | ❌ | Excluded from MVM |
| field_execution | distribution_point | ✅ | ❌ | Excluded from MVM |
| field_execution | opportunity | ✅ | ❌ | Excluded from MVM |
| field_execution | planogram_compliance | ✅ | ❌ | Excluded from MVM |
| field_execution | pos_transaction | ✅ | ❌ | Excluded from MVM |
| field_execution | quota | ✅ | ❌ | Excluded from MVM |
| field_execution | rep | ✅ | ❌ | Excluded from MVM |
| field_execution | territory | ✅ | ❌ | Excluded from MVM |
| order_revenue | invoice | ✅ | ✅ |  |
| order_revenue | order | ✅ | ✅ |  |
| order_revenue | price_list | ✅ | ✅ |  |
| order_revenue | price_list_item | ✅ | ✅ |  |
| order_revenue | pricing_agreement | ✅ | ✅ |  |
| order_revenue | return_order | ✅ | ✅ |  |
| order_revenue | sales_deduction | ✅ | ❌ | Excluded from MVM |
| order_revenue | sales_rebate_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | region | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_planning | consensus_demand | ✅ | ✅ |  |
| demand_planning | demand_event | ✅ | ❌ | Excluded from MVM |
| demand_planning | demand_plan | ✅ | ✅ |  |
| demand_planning | forecast_accuracy | ✅ | ❌ | Excluded from MVM |
| demand_planning | forecast_version | ✅ | ✅ |  |
| demand_planning | sop_cycle | ✅ | ✅ |  |
| inventory_optimization | atp_record | ✅ | ✅ |  |
| inventory_optimization | atp_rule | ✅ | ❌ | Excluded from MVM |
| inventory_optimization | inventory_policy | ✅ | ✅ |  |
| inventory_optimization | inventory_projection | ✅ | ❌ | Excluded from MVM |
| inventory_optimization | safety_stock | ✅ | ✅ |  |
| network_configuration | network_lane | ✅ | ✅ |  |
| network_configuration | network_node | ✅ | ✅ |  |
| network_configuration | otif_target | ✅ | ❌ | Excluded from MVM |
| network_configuration | sku_planning_param | ✅ | ❌ | Excluded from MVM |
| network_replenishment | replenishment_order | ❌ | ✅ | MVM only (stub or new) |
| risk_management | constraint | ✅ | ❌ | Excluded from MVM |
| risk_management | risk_register | ✅ | ❌ | Excluded from MVM |
| supply_execution | drp_run | ✅ | ❌ | Excluded from MVM |
| supply_execution | plan | ✅ | ❌ | Excluded from MVM |
| supply_execution | planning_exception | ✅ | ❌ | Excluded from MVM |
| supply_execution | planning_period | ✅ | ❌ | Excluded from MVM |
| supply_execution | planning_run | ✅ | ❌ | Excluded from MVM |
| supply_execution | supply_replenishment_order | ✅ | ❌ | Excluded from MVM |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carbon_management | carbon_emission | ✅ | ❌ | Domain not in MVM |
| carbon_management | carbon_offset | ✅ | ❌ | Domain not in MVM |
| carbon_management | energy_certificate | ✅ | ❌ | Domain not in MVM |
| carbon_management | energy_consumption | ✅ | ❌ | Domain not in MVM |
| carbon_management | product_lca | ✅ | ❌ | Domain not in MVM |
| environmental_operations | biodiversity_impact | ✅ | ❌ | Domain not in MVM |
| environmental_operations | environmental_incident | ✅ | ❌ | Domain not in MVM |
| environmental_operations | environmental_permit | ✅ | ❌ | Domain not in MVM |
| environmental_operations | waste_generation | ✅ | ❌ | Domain not in MVM |
| environmental_operations | water_consumption | ✅ | ❌ | Domain not in MVM |
| esg_governance | commitment_progress | ✅ | ❌ | Domain not in MVM |
| esg_governance | esg_audit | ✅ | ❌ | Domain not in MVM |
| esg_governance | esg_commitment | ✅ | ❌ | Domain not in MVM |
| esg_governance | esg_disclosure | ✅ | ❌ | Domain not in MVM |
| esg_governance | materiality_assessment | ✅ | ❌ | Domain not in MVM |
| esg_governance | social_impact_program | ✅ | ❌ | Domain not in MVM |
| responsible_sourcing | circular_initiative | ✅ | ❌ | Domain not in MVM |
| responsible_sourcing | deforestation_assessment | ✅ | ❌ | Domain not in MVM |
| responsible_sourcing | packaging_profile | ✅ | ❌ | Domain not in MVM |
| responsible_sourcing | sourcing_certification | ✅ | ❌ | Domain not in MVM |
| responsible_sourcing | supplier_esg_eval | ✅ | ❌ | Domain not in MVM |
| responsible_sourcing | supply_chain_activity | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_group | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_period | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | time_entry | ✅ | ❌ | Domain not in MVM |
| people_management | employee | ✅ | ❌ | Domain not in MVM |
| people_management | job_profile | ✅ | ❌ | Domain not in MVM |
| people_management | labor_relation | ✅ | ❌ | Domain not in MVM |
| people_management | org_unit | ✅ | ❌ | Domain not in MVM |
| people_management | position | ✅ | ❌ | Domain not in MVM |
| people_management | shift_schedule | ✅ | ❌ | Domain not in MVM |
| people_management | work_location | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | applicant | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruiting_requisition | ✅ | ❌ | Domain not in MVM |
| training_safety | enrollment | ✅ | ❌ | Domain not in MVM |
| training_safety | safety_incident | ✅ | ❌ | Domain not in MVM |
| training_safety | training_course | ✅ | ❌ | Domain not in MVM |
| training_safety | training_record | ✅ | ❌ | Domain not in MVM |
