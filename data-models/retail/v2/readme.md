# Retail Lakehouse Data Models

**Version 2** | Generated on July 12, 2026 at 03:25 PM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Analytics](#domain-analytics)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Ecommerce](#domain-ecommerce)
  - [Finance](#domain-finance)
  - [Fulfillment](#domain-fulfillment)
  - [Inventory](#domain-inventory)
  - [Linkage](#domain-linkage)
  - [Loyalty](#domain-loyalty)
  - [Marketing](#domain-marketing)
  - [Merchandising](#domain-merchandising)
  - [Order](#domain-order)
  - [Pricing](#domain-pricing)
  - [Product](#domain-product)
  - [Promotion](#domain-promotion)
  - [Returns](#domain-returns)
  - [Service](#domain-service)
  - [Store](#domain-store)
  - [Supplier](#domain-supplier)
  - [Supplychain](#domain-supplychain)
  - [Workforce](#domain-workforce)


## Business Description

Retail is a massive consumer-facing industry operating hypermarkets, department stores, discount outlets, and e-commerce platforms, offering groceries, apparel, electronics, and household goods at competitive prices to diverse demographics.

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
| Subdomains | 34 | 74 |
| Products (Tables) | 125 | 404 |
| Attributes (Columns) | 4994 | 14727 |
| Foreign Keys | 1079 | 2470 |
| Avg Attributes/Product | 40.0 | 36.5 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| performance_measurement | alert | ✅ | ❌ | Domain not in MVM |
| performance_measurement | analytics_kpi_target | ✅ | ❌ | Domain not in MVM |
| performance_measurement | kpi_definition | ✅ | ❌ | Domain not in MVM |
| performance_measurement | kpi_dimensionality | ✅ | ❌ | Domain not in MVM |
| performance_measurement | kpi_value | ✅ | ❌ | Domain not in MVM |
| performance_measurement | sla_kpi_measurement | ✅ | ❌ | Domain not in MVM |
| quality_control | access_policy | ✅ | ❌ | Domain not in MVM |
| quality_control | dq_issue | ✅ | ❌ | Domain not in MVM |
| quality_control | dq_result | ✅ | ❌ | Domain not in MVM |
| quality_control | dq_rule | ✅ | ❌ | Domain not in MVM |
| reference_data | retail_calendar | ✅ | ❌ | Domain not in MVM |
| reference_data | workspace | ✅ | ❌ | Domain not in MVM |
| reporting_governance | dashboard_config | ✅ | ❌ | Domain not in MVM |
| reporting_governance | dashboard_widget | ✅ | ❌ | Domain not in MVM |
| reporting_governance | report_composition | ✅ | ❌ | Domain not in MVM |
| reporting_governance | report_definition | ✅ | ❌ | Domain not in MVM |
| reporting_governance | report_subscription | ✅ | ❌ | Domain not in MVM |
| reporting_governance | self_service_query | ✅ | ❌ | Domain not in MVM |
| semantic_catalog | glossary_term | ✅ | ❌ | Domain not in MVM |
| semantic_catalog | metric_dimension | ✅ | ❌ | Domain not in MVM |
| semantic_catalog | metric_entity_dependency | ✅ | ❌ | Domain not in MVM |
| semantic_catalog | reporting_hierarchy | ✅ | ❌ | Domain not in MVM |
| semantic_catalog | semantic_layer_entity | ✅ | ❌ | Domain not in MVM |
| semantic_catalog | semantic_metric | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_control | audit_checklist_template | ✅ | ❌ | Domain not in MVM |
| audit_control | audit_event | ✅ | ❌ | Domain not in MVM |
| audit_control | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_control | audit_schedule | ✅ | ❌ | Domain not in MVM |
| audit_control | corrective_action | ✅ | ❌ | Domain not in MVM |
| audit_control | third_party_assessment | ✅ | ❌ | Domain not in MVM |
| privacy_compliance | consent | ✅ | ❌ | Domain not in MVM |
| privacy_protection | pci_assessment | ✅ | ❌ | Domain not in MVM |
| privacy_protection | pci_control | ✅ | ❌ | Domain not in MVM |
| privacy_protection | privacy_assessment | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | certification | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | compliance_program | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | license_permit | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | policy | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_agency | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | requirement | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | risk_register | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | violation_notice | ✅ | ❌ | Domain not in MVM |
| safety_operations | environmental_event | ✅ | ❌ | Domain not in MVM |
| safety_operations | food_safety_log | ✅ | ❌ | Domain not in MVM |
| safety_operations | food_safety_plan | ✅ | ❌ | Domain not in MVM |
| safety_operations | haccp_control_point | ✅ | ❌ | Domain not in MVM |
| safety_operations | osha_incident | ✅ | ❌ | Domain not in MVM |
| safety_operations | safety_inspection | ✅ | ❌ | Domain not in MVM |
| training_workforce | facility_compliance_certification | ✅ | ❌ | Domain not in MVM |
| training_workforce | facility_training_requirement | ✅ | ❌ | Domain not in MVM |
| training_workforce | training_completion | ✅ | ❌ | Domain not in MVM |
| training_workforce | training_program | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_relationships | b2b_contract | ✅ | ❌ | Excluded from MVM |
| commercial_relationships | client_relationship | ✅ | ❌ | Excluded from MVM |
| commercial_relationships | contract_template | ✅ | ❌ | Excluded from MVM |
| commercial_relationships | segment_banner_targeting | ✅ | ❌ | Excluded from MVM |
| commercial_relationships | targeting | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | communication_preference | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | customer_attribute | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | interaction | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | preference | ✅ | ❌ | Excluded from MVM |
| engagement_preferences | wishlist | ✅ | ❌ | Excluded from MVM |
| identity_master | account | ✅ | ✅ |  |
| identity_master | address | ✅ | ✅ |  |
| identity_master | contact | ✅ | ✅ |  |
| identity_master | corporate_account | ✅ | ❌ | Excluded from MVM |
| identity_master | household | ✅ | ❌ | Excluded from MVM |
| identity_master | identity_link | ✅ | ❌ | Excluded from MVM |
| identity_master | profile | ✅ | ✅ |  |
| privacy_compliance | issuance | ✅ | ❌ | Excluded from MVM |
| privacy_compliance | privacy_request | ✅ | ❌ | Excluded from MVM |

<a id="domain-ecommerce"></a>
### ecommerce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_management | catalog_node_inventory | ✅ | ❌ | Excluded from MVM |
| channel_management | digital_catalog | ✅ | ✅ |  |
| channel_management | marketplace_listing | ✅ | ✅ |  |
| channel_management | message_template | ✅ | ❌ | Excluded from MVM |
| channel_management | personalization_rule | ✅ | ❌ | Excluded from MVM |
| channel_management | promotion_banner | ✅ | ❌ | Excluded from MVM |
| channel_management | storefront | ✅ | ✅ |  |
| channel_management | storefront_assortment | ✅ | ✅ |  |
| channel_management | storefront_fulfillment_network | ✅ | ❌ | Excluded from MVM |
| channel_management | storefront_responsibility | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | ab_test | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | abandoned_cart_recovery | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | cart | ✅ | ✅ |  |
| shopper_engagement | cart_item | ✅ | ✅ |  |
| shopper_engagement | checkout | ✅ | ✅ |  |
| shopper_engagement | digital_payment | ✅ | ✅ |  |
| shopper_engagement | product_page_view | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | product_review | ✅ | ✅ |  |
| shopper_engagement | recommendation | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | search_query | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | site_notification | ✅ | ❌ | Excluded from MVM |
| shopper_engagement | web_session | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_treasury | bank_account | ✅ | ❌ | Domain not in MVM |
| asset_treasury | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_treasury | lease_contract | ✅ | ❌ | Domain not in MVM |
| asset_treasury | payment_method | ✅ | ❌ | Domain not in MVM |
| ledger_transactions | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| ledger_transactions | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_transactions | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| ledger_transactions | tax_posting | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | cost_center | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | gl_account | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | ledger | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | legal_entity | ✅ | ❌ | Domain not in MVM |
| organizational_accounting | profit_center | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | netting_run | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_run | ✅ | ❌ | Domain not in MVM |
| payables_receivables | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | finance_budget | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | financial_period | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | plan_version | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | scenario | ✅ | ❌ | Domain not in MVM |

<a id="domain-fulfillment"></a>
### fulfillment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_facility_contract | ✅ | ❌ | Excluded from MVM |
| carrier_management | carrier_rate | ✅ | ❌ | Excluded from MVM |
| carrier_management | carrier_service | ✅ | ✅ |  |
| network_configuration | fulfillment_node | ✅ | ✅ |  |
| network_configuration | node_carrier_service | ❌ | ✅ | MVM only (stub or new) |
| network_configuration | sla | ✅ | ❌ | Excluded from MVM |
| order_execution | bopis_appointment | ✅ | ✅ |  |
| order_execution | drop_ship_order | ✅ | ❌ | Excluded from MVM |
| order_execution | exception | ✅ | ❌ | Excluded from MVM |
| order_execution | fulfillment_line | ✅ | ✅ |  |
| order_execution | fulfillment_order | ✅ | ✅ |  |
| order_execution | pack_task | ✅ | ✅ |  |
| order_execution | pick_task | ✅ | ✅ |  |
| shipping_delivery | delivery_route | ✅ | ❌ | Excluded from MVM |
| shipping_delivery | delivery_stop | ✅ | ❌ | Excluded from MVM |
| shipping_delivery | proof_of_delivery | ✅ | ❌ | Excluded from MVM |
| shipping_delivery | shipment | ✅ | ✅ |  |
| shipping_delivery | shipment_package | ✅ | ✅ |  |
| shipping_delivery | shipment_tracking_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| network_operations | asn | ✅ | ❌ | Excluded from MVM |
| network_operations | assortment_deployment | ✅ | ❌ | Excluded from MVM |
| network_operations | goods_receipt | ✅ | ✅ |  |
| network_operations | inventory_node | ✅ | ✅ |  |
| network_operations | location_assignment | ✅ | ❌ | Excluded from MVM |
| network_operations | node_assortment | ✅ | ✅ |  |
| network_operations | reorder_policy | ✅ | ✅ |  |
| network_operations | replenishment_order | ✅ | ✅ |  |
| quality_tracking | cycle_count | ✅ | ✅ |  |
| quality_tracking | expiry_tracking | ✅ | ❌ | Excluded from MVM |
| quality_tracking | lot | ✅ | ✅ |  |
| quality_tracking | rfid_tag | ✅ | ❌ | Excluded from MVM |
| quality_tracking | vmi_agreement | ✅ | ❌ | Excluded from MVM |
| stock_management | adjustment | ✅ | ✅ |  |
| stock_management | promo_stock_allocation | ✅ | ❌ | Excluded from MVM |
| stock_management | reservation | ✅ | ✅ |  |
| stock_management | stock_ledger | ✅ | ✅ |  |
| stock_management | stock_position | ✅ | ✅ |  |
| stock_management | stock_transfer | ✅ | ✅ |  |

<a id="domain-linkage"></a>
### linkage

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | *(no products)* | ✅ | ❌ | |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| member_engagement | clienteling_interaction | ✅ | ❌ | Domain not in MVM |
| member_engagement | engagement_campaign | ✅ | ❌ | Domain not in MVM |
| member_engagement | loyalty_membership | ✅ | ❌ | Domain not in MVM |
| member_engagement | member_offer | ✅ | ❌ | Domain not in MVM |
| member_engagement | member_segment | ✅ | ❌ | Domain not in MVM |
| member_engagement | referral | ✅ | ❌ | Domain not in MVM |
| points_rewards | accrual_rule | ✅ | ❌ | Domain not in MVM |
| points_rewards | points_ledger | ✅ | ❌ | Domain not in MVM |
| points_rewards | redemption | ✅ | ❌ | Domain not in MVM |
| points_rewards | redemption_rule | ✅ | ❌ | Domain not in MVM |
| points_rewards | reward | ✅ | ❌ | Domain not in MVM |
| program_management | campaign_storefront_deployment | ✅ | ❌ | Domain not in MVM |
| program_management | loyalty_program | ✅ | ❌ | Domain not in MVM |
| program_management | partner_program | ✅ | ❌ | Domain not in MVM |
| program_management | partner_transaction | ✅ | ❌ | Domain not in MVM |
| program_management | tier | ✅ | ❌ | Domain not in MVM |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_intelligence | attribution_model | ✅ | ❌ | Domain not in MVM |
| audience_intelligence | attribution_touchpoint | ✅ | ❌ | Domain not in MVM |
| audience_intelligence | audience_segment | ✅ | ❌ | Domain not in MVM |
| audience_intelligence | conversion_event | ✅ | ❌ | Domain not in MVM |
| audience_intelligence | customer_membership | ✅ | ❌ | Domain not in MVM |
| audience_intelligence | segment | ✅ | ❌ | Domain not in MVM |
| brand_partnerships | channel | ✅ | ❌ | Domain not in MVM |
| brand_partnerships | influencer | ✅ | ❌ | Domain not in MVM |
| brand_partnerships | influencer_engagement | ✅ | ❌ | Domain not in MVM |
| brand_partnerships | marketing_brand | ✅ | ❌ | Domain not in MVM |
| brand_partnerships | marketing_budget | ✅ | ❌ | Domain not in MVM |
| brand_partnerships | opt_in_record | ✅ | ❌ | Domain not in MVM |
| campaign_planning | ab_test_campaign | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_audience | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_brief | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_deployment | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_fulfillment | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_performance | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_policy_compliance | ✅ | ❌ | Domain not in MVM |
| content_delivery | automation_enrollment | ✅ | ❌ | Domain not in MVM |
| content_delivery | automation_flow | ✅ | ❌ | Domain not in MVM |
| content_delivery | automation_step | ✅ | ❌ | Domain not in MVM |
| content_delivery | creative_asset | ✅ | ❌ | Domain not in MVM |
| content_delivery | email_send | ✅ | ❌ | Domain not in MVM |
| content_delivery | email_template | ✅ | ❌ | Domain not in MVM |
| content_delivery | push_notification_send | ✅ | ❌ | Domain not in MVM |
| content_delivery | sms_send | ✅ | ❌ | Domain not in MVM |
| content_delivery | social_post | ✅ | ❌ | Domain not in MVM |
| media_execution | agency_brief | ✅ | ❌ | Domain not in MVM |
| media_execution | media_buy | ✅ | ❌ | Domain not in MVM |
| media_execution | media_plan | ✅ | ❌ | Domain not in MVM |
| media_execution | publisher | ✅ | ❌ | Domain not in MVM |
| media_execution | utm_parameter | ✅ | ❌ | Domain not in MVM |

<a id="domain-merchandising"></a>
### merchandising

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assortment_strategy | assortment_item | ✅ | ✅ |  |
| assortment_strategy | assortment_plan | ✅ | ✅ |  |
| assortment_strategy | category | ✅ | ✅ |  |
| assortment_strategy | category_accrual_rule | ✅ | ❌ | Excluded from MVM |
| assortment_strategy | private_label_program | ✅ | ❌ | Excluded from MVM |
| financial_planning | markdown_event | ✅ | ❌ | Excluded from MVM |
| financial_planning | merch_plan | ✅ | ✅ |  |
| financial_planning | otb_budget | ✅ | ✅ |  |
| financial_planning | season | ✅ | ✅ |  |
| space_execution | category_campaign_placement | ✅ | ❌ | Excluded from MVM |
| space_execution | merchandising_planogram | ✅ | ❌ | Excluded from MVM |
| space_execution | planogram_position | ✅ | ❌ | Excluded from MVM |
| vendor_buying | buyer | ✅ | ✅ |  |
| vendor_buying | buyer_profit_center_assignment | ✅ | ❌ | Excluded from MVM |
| vendor_buying | buying_order | ✅ | ✅ |  |
| vendor_buying | buying_order_line | ✅ | ✅ |  |
| vendor_buying | vendor_negotiation | ✅ | ❌ | Excluded from MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_management | cancellation | ✅ | ✅ |  |
| order_management | header | ✅ | ✅ |  |
| order_management | hold | ✅ | ❌ | Excluded from MVM |
| order_management | line_status_history | ✅ | ❌ | Excluded from MVM |
| order_management | order_line | ✅ | ✅ |  |
| order_management | promise | ✅ | ❌ | Excluded from MVM |
| order_management | status_history | ✅ | ✅ |  |
| store_transactions | discount | ✅ | ✅ |  |
| store_transactions | payment | ✅ | ✅ |  |
| store_transactions | pos_transaction | ✅ | ✅ |  |
| store_transactions | pos_transaction_line | ✅ | ✅ |  |
| value_instruments | gift_card | ✅ | ✅ |  |
| value_instruments | gift_card_transaction | ✅ | ✅ |  |
| value_instruments | subscription | ✅ | ✅ |  |

<a id="domain-pricing"></a>
### pricing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| markdown_control | markdown | ✅ | ✅ |  |
| markdown_control | price_approval | ✅ | ✅ |  |
| markdown_control | price_audit_log | ✅ | ❌ | Excluded from MVM |
| markdown_control | price_change | ✅ | ✅ |  |
| markdown_control | price_override | ✅ | ❌ | Excluded from MVM |
| price_management | cost_price | ✅ | ✅ |  |
| price_management | cost_zone | ✅ | ❌ | Excluded from MVM |
| price_management | price_list | ✅ | ✅ |  |
| price_management | price_zone | ✅ | ✅ |  |
| price_management | sku_price | ✅ | ✅ |  |
| price_management | zone_price_list_assignment | ✅ | ❌ | Excluded from MVM |
| strategy_analytics | competitive_price | ✅ | ✅ |  |
| strategy_analytics | margin_target | ✅ | ❌ | Excluded from MVM |
| strategy_analytics | price_sensitivity | ✅ | ❌ | Excluded from MVM |
| strategy_analytics | price_strategy | ✅ | ❌ | Excluded from MVM |
| strategy_analytics | rule | ✅ | ✅ |  |
| strategy_analytics | rule_application | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assortment_planning | assortment | ✅ | ✅ |  |
| assortment_planning | category_campaign_plan | ✅ | ❌ | Excluded from MVM |
| assortment_planning | category_kpi_target | ✅ | ❌ | Excluded from MVM |
| content_enrichment | image | ✅ | ✅ |  |
| content_enrichment | item_nutritional | ✅ | ❌ | Excluded from MVM |
| item_identity | attribute | ❌ | ✅ | MVM only (stub or new) |
| item_identity | brand | ❌ | ✅ | MVM only (stub or new) |
| item_master | gtin_registry | ✅ | ✅ |  |
| item_master | item_bundle | ✅ | ✅ |  |
| item_master | item_cross_reference | ✅ | ❌ | Excluded from MVM |
| item_master | item_hierarchy | ✅ | ✅ |  |
| item_master | item_variant | ✅ | ✅ |  |
| item_master | product_attribute | ✅ | ❌ | Excluded from MVM |
| item_master | product_brand | ✅ | ❌ | Excluded from MVM |
| item_master | sku | ✅ | ✅ |  |
| item_master | uom | ✅ | ✅ |  |
| regulatory_safety | item_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| regulatory_safety | product_compliance | ✅ | ❌ | Excluded from MVM |
| regulatory_safety | recall | ✅ | ❌ | Excluded from MVM |
| regulatory_standards | compliance | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-promotion"></a>
### promotion

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_management | promo_budget | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_calendar | ✅ | ✅ |  |
| campaign_management | promo_campaign | ✅ | ✅ |  |
| campaign_management | promo_conflict_rule | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_group | ✅ | ❌ | Excluded from MVM |
| campaign_management | promo_offer | ✅ | ✅ |  |
| campaign_management | promotion_stack | ✅ | ❌ | Excluded from MVM |
| offer_execution | circular_ad | ✅ | ✅ |  |
| offer_execution | circular_ad_category_feature | ✅ | ❌ | Excluded from MVM |
| offer_execution | coupon | ✅ | ✅ |  |
| offer_execution | coupon_distribution | ✅ | ❌ | Excluded from MVM |
| offer_execution | promo_forecast | ✅ | ❌ | Excluded from MVM |
| offer_execution | promo_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| offer_execution | promo_redemption | ✅ | ✅ |  |
| vendor_funding | promo_performance | ✅ | ✅ |  |
| vendor_funding | rebate | ✅ | ❌ | Excluded from MVM |
| vendor_funding | rebate_claim | ✅ | ❌ | Excluded from MVM |
| vendor_funding | vendor_promo_agreement | ✅ | ✅ |  |
| vendor_funding | vendor_promo_claim | ✅ | ❌ | Excluded from MVM |

<a id="domain-returns"></a>
### returns

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_management | return_policy | ✅ | ✅ |  |
| authorization_management | return_receipt | ✅ | ✅ |  |
| authorization_management | return_request | ✅ | ✅ |  |
| authorization_management | return_shipment | ✅ | ❌ | Excluded from MVM |
| authorization_management | rma | ✅ | ✅ |  |
| authorization_management | rma_line | ✅ | ✅ |  |
| financial_settlement | exchange_order | ✅ | ✅ |  |
| financial_settlement | refund | ✅ | ✅ |  |
| financial_settlement | return_fraud_case | ✅ | ❌ | Excluded from MVM |
| financial_settlement | store_credit | ✅ | ✅ |  |
| financial_settlement | vendor_credit | ✅ | ❌ | Excluded from MVM |
| merchandise_recovery | disposition | ✅ | ✅ |  |
| merchandise_recovery | liquidation_batch | ✅ | ❌ | Excluded from MVM |
| merchandise_recovery | liquidation_item | ✅ | ❌ | Excluded from MVM |
| merchandise_recovery | restock_event | ✅ | ❌ | Excluded from MVM |
| merchandise_recovery | rtv_line | ✅ | ❌ | Excluded from MVM |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | service_case | ✅ | ❌ | Domain not in MVM |

<a id="domain-store"></a>
### store

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_performance | comparable_sales | ✅ | ❌ | Excluded from MVM |
| financial_performance | store_profit_loss | ✅ | ❌ | Excluded from MVM |
| location_management | cluster | ✅ | ✅ |  |
| location_management | cluster_membership | ✅ | ❌ | Excluded from MVM |
| location_management | department | ✅ | ✅ |  |
| location_management | format | ✅ | ✅ |  |
| location_management | location | ✅ | ✅ |  |
| location_management | region | ✅ | ✅ |  |
| location_management | sales_territory | ✅ | ❌ | Excluded from MVM |
| physical_infrastructure | assignment | ❌ | ✅ | MVM only (stub or new) |
| store_operations | audit | ✅ | ❌ | Excluded from MVM |
| store_operations | carrier_agreement | ✅ | ❌ | Excluded from MVM |
| store_operations | direct_store_delivery | ✅ | ❌ | Excluded from MVM |
| store_operations | fixture | ✅ | ❌ | Excluded from MVM |
| store_operations | format_offer_eligibility | ✅ | ❌ | Excluded from MVM |
| store_operations | license | ✅ | ❌ | Excluded from MVM |
| store_operations | pos_terminal | ✅ | ✅ |  |
| store_operations | remodel | ✅ | ❌ | Excluded from MVM |
| store_operations | ship_from_store_node | ✅ | ✅ |  |
| store_operations | shrinkage_event | ✅ | ✅ |  |
| store_operations | store_planogram | ✅ | ❌ | Excluded from MVM |
| store_operations | traffic_count | ✅ | ✅ |  |

<a id="domain-supplier"></a>
### supplier

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_compliance | lead_time_agreement | ✅ | ✅ |  |
| contract_compliance | routing_guide | ✅ | ❌ | Excluded from MVM |
| contract_compliance | vendor_allowance | ✅ | ✅ |  |
| contract_compliance | vendor_category_sourcing | ✅ | ❌ | Excluded from MVM |
| contract_compliance | vendor_contract | ✅ | ✅ |  |
| performance_risk | chargeback | ✅ | ✅ |  |
| performance_risk | risk_assessment | ✅ | ❌ | Excluded from MVM |
| performance_risk | rtv_request | ✅ | ✅ |  |
| performance_risk | vendor_dispute | ✅ | ❌ | Excluded from MVM |
| performance_risk | vendor_scorecard | ✅ | ✅ |  |
| trading_operations | edi_config | ✅ | ❌ | Excluded from MVM |
| trading_operations | onboarding_request | ✅ | ❌ | Excluded from MVM |
| trading_operations | supplier_edi_transaction | ✅ | ❌ | Excluded from MVM |
| trading_operations | supply_lane | ✅ | ❌ | Excluded from MVM |
| trading_operations | vendor_program_enrollment | ✅ | ❌ | Excluded from MVM |
| trading_operations | vendor_training_requirement | ✅ | ❌ | Excluded from MVM |
| trading_operations | vmi_config | ✅ | ❌ | Excluded from MVM |
| vendor_master | vendor | ✅ | ✅ |  |
| vendor_master | vendor_address | ✅ | ✅ |  |
| vendor_master | vendor_certification | ✅ | ❌ | Excluded from MVM |
| vendor_master | vendor_contact | ✅ | ✅ |  |
| vendor_master | vendor_item | ✅ | ✅ |  |

<a id="domain-supplychain"></a>
### supplychain

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_operations | dc_facility | ✅ | ✅ |  |
| facility_operations | handling_unit | ✅ | ❌ | Excluded from MVM |
| facility_operations | quality_hold | ✅ | ❌ | Excluded from MVM |
| facility_operations | warehouse_zone | ✅ | ✅ |  |
| inbound_receiving | dock_appointment | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | inbound_appointment | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | inbound_shipment | ✅ | ✅ |  |
| inbound_receiving | receiving_event | ✅ | ✅ |  |
| outbound_fulfillment | outbound_order | ✅ | ✅ |  |
| outbound_fulfillment | outbound_order_line | ✅ | ✅ |  |
| outbound_fulfillment | outbound_shipment | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | warehouse_task | ✅ | ❌ | Excluded from MVM |
| outbound_fulfillment | wave | ✅ | ✅ |  |
| procurement_execution | po_line | ✅ | ✅ |  |
| procurement_execution | po_shipment_receipt | ✅ | ❌ | Excluded from MVM |
| procurement_execution | purchase_order | ✅ | ✅ |  |
| procurement_execution | sla_definition | ✅ | ❌ | Excluded from MVM |
| procurement_execution | sla_performance | ✅ | ❌ | Excluded from MVM |
| procurement_execution | supplychain_edi_transaction | ✅ | ❌ | Excluded from MVM |
| supply_planning | demand_forecast | ✅ | ✅ |  |
| supply_planning | plan | ✅ | ❌ | Excluded from MVM |
| supply_planning | replenishment_plan | ✅ | ✅ |  |
| transfer_movement | cross_dock_plan | ✅ | ❌ | Excluded from MVM |
| transfer_movement | crossdock_transaction | ✅ | ❌ | Excluded from MVM |
| transfer_movement | inventory_transfer | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_master | associate | ✅ | ❌ | Domain not in MVM |
| employee_master | candidate | ✅ | ❌ | Domain not in MVM |
| employee_master | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_master | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_master | wf_certification | ✅ | ❌ | Domain not in MVM |
| labor_relations | bargaining_unit | ✅ | ❌ | Domain not in MVM |
| labor_relations | collective_bargaining_agreement | ✅ | ❌ | Domain not in MVM |
| labor_relations | dashboard_access | ✅ | ❌ | Domain not in MVM |
| labor_relations | org_unit_compliance_scope | ✅ | ❌ | Domain not in MVM |
| labor_relations | union | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation_change | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | labor_budget | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | merit_cycle | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | pay_period | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | coverage_request | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | leave_request | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | shift_swap_request | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | staffing_plan | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | time_entry | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | workforce_kpi_target | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | training_enrollment | ✅ | ❌ | Domain not in MVM |
