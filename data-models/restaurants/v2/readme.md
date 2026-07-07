# Restaurants Lakehouse Data Models

**Version 2** | Generated on July 02, 2026 at 04:02 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Finance](#domain-finance)
  - [Foodsafety](#domain-foodsafety)
  - [Franchise](#domain-franchise)
  - [Guest](#domain-guest)
  - [Inventory](#domain-inventory)
  - [Loyalty](#domain-loyalty)
  - [Marketing](#domain-marketing)
  - [Menu](#domain-menu)
  - [Order](#domain-order)
  - [Procurement](#domain-procurement)
  - [Realestate](#domain-realestate)
  - [Restaurant](#domain-restaurant)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

restaurants industry enterprise data model.

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
| Domains | 8 | 14 |
| Subdomains | 24 | 55 |
| Products (Tables) | 85 | 290 |
| Attributes (Columns) | 2897 | 9603 |
| Foreign Keys | 393 | 1169 |
| Avg Attributes/Product | 34.1 | 33.1 |

## Domain & Product Comparison

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_capital | asset_depreciation | ✅ | ❌ | Domain not in MVM |
| asset_capital | capex_project | ✅ | ❌ | Domain not in MVM |
| asset_capital | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_capital | lease_liability | ✅ | ❌ | Domain not in MVM |
| banking_treasury | bank_account | ✅ | ❌ | Domain not in MVM |
| banking_treasury | bank_statement | ✅ | ❌ | Domain not in MVM |
| banking_treasury | bank_statement_line | ✅ | ❌ | Domain not in MVM |
| banking_treasury | house_bank | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| journal_posting | allocation_rule | ✅ | ❌ | Domain not in MVM |
| journal_posting | cost_allocation | ✅ | ❌ | Domain not in MVM |
| journal_posting | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| journal_posting | journal_entry | ✅ | ❌ | Domain not in MVM |
| journal_posting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| journal_posting | period_close | ✅ | ❌ | Domain not in MVM |
| journal_posting | royalty_accrual | ✅ | ❌ | Domain not in MVM |
| journal_posting | tax_posting | ✅ | ❌ | Domain not in MVM |
| ledger_structure | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| ledger_structure | cost_center | ✅ | ❌ | Domain not in MVM |
| ledger_structure | financial_period | ✅ | ❌ | Domain not in MVM |
| ledger_structure | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_structure | hierarchy_node | ✅ | ❌ | Domain not in MVM |
| ledger_structure | ledger | ✅ | ❌ | Domain not in MVM |
| ledger_structure | legal_entity | ✅ | ❌ | Domain not in MVM |
| ledger_structure | profit_center | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice_line | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_run | ✅ | ❌ | Domain not in MVM |
| payables_receivables | pos_settlement_batch | ✅ | ❌ | Domain not in MVM |

<a id="domain-foodsafety"></a>
### foodsafety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| allergen_incident | allergen_incident | ✅ | ❌ | Domain not in MVM |
| allergen_incident | foodsafety_allergen_profile | ✅ | ❌ | Domain not in MVM |
| allergen_incident | illness_report | ✅ | ❌ | Domain not in MVM |
| audit_compliance | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_compliance | food_safety_audit | ✅ | ❌ | Domain not in MVM |
| audit_compliance | foodsafety_corrective_action | ✅ | ❌ | Domain not in MVM |
| audit_compliance | health_inspection | ✅ | ❌ | Domain not in MVM |
| audit_compliance | inspection_violation | ✅ | ❌ | Domain not in MVM |
| hazard_control | critical_control_point | ✅ | ❌ | Domain not in MVM |
| hazard_control | haccp_plan | ✅ | ❌ | Domain not in MVM |
| recall_response | food_recall | ✅ | ❌ | Domain not in MVM |
| recall_response | recall_unit_response | ✅ | ❌ | Domain not in MVM |
| recall_response | receiving_inspection | ✅ | ❌ | Domain not in MVM |
| sanitation_monitoring | environmental_monitoring | ✅ | ❌ | Domain not in MVM |
| sanitation_monitoring | pest_control_log | ✅ | ❌ | Domain not in MVM |
| sanitation_monitoring | sanitation_schedule | ✅ | ❌ | Domain not in MVM |
| sanitation_monitoring | sanitation_task_log | ✅ | ❌ | Domain not in MVM |
| sanitation_monitoring | temperature_log | ✅ | ❌ | Domain not in MVM |
| training_certification | food_safety_certification | ✅ | ❌ | Domain not in MVM |
| training_certification | food_safety_training | ✅ | ❌ | Domain not in MVM |
| training_certification | foodsafety_supplier_certification | ✅ | ❌ | Domain not in MVM |
| training_certification | sop_document | ✅ | ❌ | Domain not in MVM |

<a id="domain-franchise"></a>
### franchise

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_lifecycle | fee_schedule | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | lease_agreement | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | renewal_event | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | termination_event | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | transfer_event | ✅ | ❌ | Domain not in MVM |
| compliance_support | compliance_audit | ✅ | ❌ | Domain not in MVM |
| compliance_support | franchise_corrective_action | ✅ | ❌ | Domain not in MVM |
| compliance_support | support_visit | ✅ | ❌ | Domain not in MVM |
| compliance_support | training_enrollment | ✅ | ❌ | Domain not in MVM |
| development_operations | development_schedule | ✅ | ❌ | Domain not in MVM |
| development_operations | franchise_remodel_project | ✅ | ❌ | Domain not in MVM |
| development_operations | nro_pipeline | ✅ | ❌ | Domain not in MVM |
| financial_reporting | billing | ✅ | ❌ | Domain not in MVM |
| financial_reporting | marketing_fund_contribution | ✅ | ❌ | Domain not in MVM |
| financial_reporting | performance_scorecard | ✅ | ❌ | Domain not in MVM |
| financial_reporting | sales_report | ✅ | ❌ | Domain not in MVM |
| partner_management | agreement | ✅ | ❌ | Domain not in MVM |
| partner_management | area_representative | ✅ | ❌ | Domain not in MVM |
| partner_management | fdd_disclosure | ✅ | ❌ | Domain not in MVM |
| partner_management | franchisee | ✅ | ❌ | Domain not in MVM |
| partner_management | prospect | ✅ | ❌ | Domain not in MVM |
| partner_management | territory | ✅ | ❌ | Domain not in MVM |

<a id="domain-guest"></a>
### guest

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_insights | consent_policy | ✅ | ❌ | Excluded from MVM |
| engagement_insights | consent_record | ✅ | ✅ |  |
| engagement_insights | guest_allergen_profile | ✅ | ❌ | Excluded from MVM |
| engagement_insights | guest_segment | ✅ | ❌ | Excluded from MVM |
| engagement_insights | guest_segment_membership | ✅ | ❌ | Excluded from MVM |
| engagement_insights | lifetime_value | ✅ | ❌ | Excluded from MVM |
| engagement_insights | preference | ✅ | ✅ |  |
| experience_feedback | visit | ❌ | ✅ | MVM only (stub or new) |
| feedback_analytics | communication | ✅ | ❌ | Excluded from MVM |
| feedback_analytics | complaint | ✅ | ✅ |  |
| feedback_analytics | guest_visit | ✅ | ❌ | Excluded from MVM |
| feedback_analytics | interaction | ✅ | ✅ |  |
| feedback_analytics | satisfaction_survey | ✅ | ✅ |  |
| feedback_analytics | survey_question | ✅ | ❌ | Excluded from MVM |
| feedback_analytics | survey_response | ✅ | ❌ | Excluded from MVM |
| identity_management | address | ✅ | ✅ |  |
| identity_management | channel_identity | ✅ | ❌ | Excluded from MVM |
| identity_management | corporate_account | ✅ | ❌ | Excluded from MVM |
| identity_management | demographic | ✅ | ❌ | Excluded from MVM |
| identity_management | digital_account | ✅ | ✅ |  |
| identity_management | household | ✅ | ❌ | Excluded from MVM |
| identity_management | household_member | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_resolution | ✅ | ❌ | Excluded from MVM |
| identity_management | profile | ✅ | ✅ |  |
| marketing_personalization | segment | ❌ | ✅ | MVM only (stub or new) |
| marketing_personalization | segment_membership | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_analysis | food_cost_period | ✅ | ✅ |  |
| cost_analysis | inventory_ingredient_usage | ✅ | ❌ | Excluded from MVM |
| cost_analysis | prep_usage | ✅ | ❌ | Excluded from MVM |
| cost_analysis | yield_record | ✅ | ❌ | Excluded from MVM |
| inventory_operations | adjustment | ❌ | ✅ | MVM only (stub or new) |
| item_management | item_category | ✅ | ❌ | Excluded from MVM |
| item_management | lot_tracking | ✅ | ❌ | Excluded from MVM |
| item_management | on_hand_balance | ✅ | ✅ |  |
| item_management | stock_item | ✅ | ✅ |  |
| item_management | stock_location | ✅ | ✅ |  |
| item_management | uom | ✅ | ❌ | Excluded from MVM |
| item_management | vendor_item | ✅ | ✅ |  |
| stock_operations | inventory_adjustment | ✅ | ❌ | Excluded from MVM |
| stock_operations | physical_count | ✅ | ✅ |  |
| stock_operations | receiving_order | ✅ | ✅ |  |
| stock_operations | replenishment_order | ✅ | ❌ | Excluded from MVM |
| stock_operations | stock_transfer | ✅ | ✅ |  |
| stock_operations | waste_log | ✅ | ✅ |  |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| member_engagement | loyalty_segment | ✅ | ❌ | Excluded from MVM |
| member_engagement | loyalty_visit | ✅ | ❌ | Excluded from MVM |
| member_engagement | member | ✅ | ✅ |  |
| member_engagement | referral | ✅ | ❌ | Excluded from MVM |
| offer_campaigns | challenge | ✅ | ❌ | Excluded from MVM |
| offer_campaigns | challenge_enrollment | ✅ | ❌ | Excluded from MVM |
| offer_campaigns | offer | ✅ | ✅ |  |
| offer_campaigns | offer_assignment | ✅ | ❌ | Excluded from MVM |
| offer_campaigns | offer_redemption | ✅ | ✅ |  |
| offer_campaigns | program_campaign_allocation | ✅ | ❌ | Excluded from MVM |
| points_rewards | loyalty_adjustment | ✅ | ❌ | Excluded from MVM |
| points_rewards | points_ledger | ✅ | ✅ |  |
| points_rewards | redemption | ✅ | ✅ |  |
| points_rewards | reward | ✅ | ✅ |  |
| program_management | accrual_rule | ✅ | ✅ |  |
| program_management | enrollment_event | ✅ | ✅ |  |
| program_management | program | ✅ | ✅ |  |
| program_management | tier | ✅ | ✅ |  |
| program_management | tier_history | ✅ | ❌ | Excluded from MVM |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_targeting | local_store_marketing | ✅ | ❌ | Domain not in MVM |
| audience_targeting | marketing_guest_segment | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_execution | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_roi | ✅ | ❌ | Domain not in MVM |
| campaign_planning | campaign_spend | ✅ | ❌ | Domain not in MVM |
| campaign_planning | marketing_lto | ✅ | ❌ | Domain not in MVM |
| fund_management | fund | ✅ | ❌ | Domain not in MVM |
| fund_management | fund_contribution | ✅ | ❌ | Domain not in MVM |
| media_buying | ad_creative | ✅ | ❌ | Domain not in MVM |
| media_buying | digital_campaign_performance | ✅ | ❌ | Domain not in MVM |
| media_buying | media_buy | ✅ | ❌ | Domain not in MVM |
| media_buying | media_channel | ✅ | ❌ | Domain not in MVM |
| media_buying | media_plan | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | content_template | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | coupon | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | influencer | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | influencer_activation | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | promotion | ✅ | ❌ | Domain not in MVM |
| promotional_engagement | promotion_redemption | ✅ | ❌ | Domain not in MVM |

<a id="domain-menu"></a>
### menu

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| dietary_compliance | allergen_declaration | ✅ | ✅ |  |
| dietary_compliance | dietary_tag | ✅ | ❌ | Excluded from MVM |
| dietary_compliance | dietary_tag_assignment | ✅ | ❌ | Excluded from MVM |
| dietary_compliance | nutrition_profile | ✅ | ✅ |  |
| item_catalog | item_price | ✅ | ✅ |  |
| item_catalog | menu | ✅ | ✅ |  |
| item_catalog | menu_item | ✅ | ✅ |  |
| item_catalog | recipe | ✅ | ✅ |  |
| item_catalog | recipe_ingredient | ✅ | ✅ |  |
| menu_catalog | item_listing | ❌ | ✅ | MVM only (stub or new) |
| performance_costing | engineering_review | ✅ | ❌ | Excluded from MVM |
| performance_costing | item_86_event | ✅ | ❌ | Excluded from MVM |
| performance_costing | item_cost | ✅ | ✅ |  |
| performance_costing | pmix_record | ✅ | ❌ | Excluded from MVM |
| promotional_engineering | combo_component | ✅ | ✅ |  |
| promotional_engineering | combo_meal | ✅ | ✅ |  |
| promotional_engineering | menu_lto | ✅ | ❌ | Excluded from MVM |
| promotional_engineering | menu_modifier | ✅ | ✅ |  |
| promotional_engineering | modifier_group | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catering_services | catering_order | ✅ | ❌ | Excluded from MVM |
| catering_services | catering_package | ✅ | ❌ | Excluded from MVM |
| catering_services | sos_target | ✅ | ❌ | Excluded from MVM |
| fulfillment_channels | channel | ✅ | ✅ |  |
| fulfillment_channels | daypart | ✅ | ✅ |  |
| fulfillment_channels | delivery_order | ✅ | ✅ |  |
| fulfillment_channels | delivery_platform | ✅ | ❌ | Excluded from MVM |
| fulfillment_channels | drive_thru_event | ✅ | ❌ | Excluded from MVM |
| fulfillment_channels | kds_ticket | ✅ | ✅ |  |
| transaction_core | discount | ✅ | ✅ |  |
| transaction_core | guest_order | ✅ | ✅ |  |
| transaction_core | order_ingredient_usage | ✅ | ❌ | Excluded from MVM |
| transaction_core | order_item | ✅ | ✅ |  |
| transaction_core | order_modifier | ✅ | ✅ |  |
| transaction_core | payment | ✅ | ✅ |  |
| transaction_core | refund | ✅ | ✅ |  |
| transaction_core | status_event | ✅ | ✅ |  |
| transaction_core | tax | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | contract_line | ✅ | ❌ | Domain not in MVM |
| contract_administration | supplier_category_contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | supply_agreement | ✅ | ❌ | Domain not in MVM |
| contract_administration | vendor_rebate | ✅ | ❌ | Domain not in MVM |
| purchase_execution | po_line | ✅ | ❌ | Domain not in MVM |
| purchase_execution | procurement_purchase_order | ✅ | ❌ | Domain not in MVM |
| purchase_execution | requisition | ✅ | ❌ | Domain not in MVM |
| purchase_execution | supplier_invoice | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | category | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | item_specification | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | product | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | sourcing_event | ✅ | ❌ | Domain not in MVM |
| sourcing_strategy | sourcing_response | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | procurement_supplier | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_risk | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_scorecard | ✅ | ❌ | Domain not in MVM |

<a id="domain-realestate"></a>
### realestate

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | remodel_project | ✅ | ❌ | Domain not in MVM |
| facility_operations | facility | ✅ | ❌ | Domain not in MVM |
| facility_operations | maintenance_contract | ✅ | ❌ | Domain not in MVM |
| facility_operations | maintenance_work_order | ✅ | ❌ | Domain not in MVM |
| facility_operations | menu_item_site_offering | ✅ | ❌ | Domain not in MVM |
| lease_management | cam_reconciliation | ✅ | ❌ | Domain not in MVM |
| lease_management | landlord | ✅ | ❌ | Domain not in MVM |
| lease_management | lease | ✅ | ❌ | Domain not in MVM |
| lease_management | lease_amendment | ✅ | ❌ | Domain not in MVM |
| lease_management | rent_payment | ✅ | ❌ | Domain not in MVM |
| lease_management | rent_schedule | ✅ | ❌ | Domain not in MVM |
| lease_management | tenant | ✅ | ❌ | Domain not in MVM |
| site_development | capex_budget | ✅ | ❌ | Domain not in MVM |
| site_development | nro_project | ✅ | ❌ | Domain not in MVM |
| site_development | property_acquisition | ✅ | ❌ | Domain not in MVM |
| site_development | site | ✅ | ❌ | Domain not in MVM |
| site_development | site_permit | ✅ | ❌ | Domain not in MVM |
| site_development | site_selection | ✅ | ❌ | Domain not in MVM |
| site_development | trade_area | ✅ | ❌ | Domain not in MVM |

<a id="domain-restaurant"></a>
### restaurant

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_management | checklist_template | ✅ | ❌ | Excluded from MVM |
| facility_management | ops_visit | ✅ | ❌ | Excluded from MVM |
| facility_management | ops_visit_finding | ✅ | ❌ | Excluded from MVM |
| facility_management | renovation_project | ✅ | ❌ | Excluded from MVM |
| facility_management | store_campaign_assignment | ✅ | ❌ | Excluded from MVM |
| operational_performance | brand_standard | ✅ | ✅ |  |
| operational_performance | equipment_asset | ✅ | ✅ |  |
| operational_performance | kitchen_station | ✅ | ✅ |  |
| operational_performance | performance_period | ✅ | ❌ | Excluded from MVM |
| operational_performance | pos_terminal | ✅ | ✅ |  |
| operational_performance | sos_measurement | ✅ | ❌ | Excluded from MVM |
| operational_performance | table_turn_log | ✅ | ❌ | Excluded from MVM |
| operational_performance | throughput_benchmark | ✅ | ❌ | Excluded from MVM |
| operational_performance | unit_performance | ✅ | ❌ | Excluded from MVM |
| unit_identity | area_management | ✅ | ❌ | Excluded from MVM |
| unit_identity | brand | ✅ | ✅ |  |
| unit_identity | capacity_config | ✅ | ❌ | Excluded from MVM |
| unit_identity | department | ✅ | ❌ | Excluded from MVM |
| unit_identity | format_config | ✅ | ❌ | Excluded from MVM |
| unit_identity | location_profile | ✅ | ✅ |  |
| unit_identity | operating_hours | ✅ | ✅ |  |
| unit_identity | unit | ✅ | ✅ |  |
| unit_identity | unit_ownership | ✅ | ❌ | Excluded from MVM |
| unit_identity | unit_status_history | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| ingredient_catalog | ingredient | ✅ | ✅ |  |
| ingredient_catalog | ingredient_lot | ✅ | ✅ |  |
| ingredient_catalog | quality_inspection | ✅ | ✅ |  |
| ingredient_catalog | recall_event | ✅ | ❌ | Excluded from MVM |
| logistics_network | distribution_center | ✅ | ❌ | Excluded from MVM |
| logistics_network | inbound_shipment | ✅ | ❌ | Excluded from MVM |
| procurement_operations | goods_receipt | ✅ | ✅ |  |
| procurement_operations | goods_receipt_line | ✅ | ✅ |  |
| procurement_operations | invoice | ✅ | ✅ |  |
| procurement_operations | purchase_order | ❌ | ✅ | MVM only (stub or new) |
| procurement_operations | purchase_order_line | ✅ | ✅ |  |
| procurement_operations | supply_purchase_order | ✅ | ❌ | Excluded from MVM |
| supplier_management | commodity_category | ✅ | ❌ | Excluded from MVM |
| supplier_management | contract_line_item | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | contract_price | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | supplier_contract | ✅ | ✅ |  |
| supplier_management | supplier_ingredient_catalog | ❌ | ✅ | MVM only (stub or new) |
| supplier_management | supplier_performance | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_contract | ✅ | ❌ | Excluded from MVM |
| supplier_management | supply_supplier | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_management | certification | ✅ | ✅ |  |
| employee_management | employee | ✅ | ✅ |  |
| employee_management | leave_request | ✅ | ✅ |  |
| employee_management | onboarding | ✅ | ❌ | Excluded from MVM |
| employee_management | performance_review | ✅ | ❌ | Excluded from MVM |
| employee_management | position | ✅ | ❌ | Excluded from MVM |
| employee_management | recruitment | ✅ | ❌ | Excluded from MVM |
| employee_management | training_completion | ✅ | ✅ |  |
| employee_management | workforce_department | ✅ | ❌ | Excluded from MVM |
| labor_scheduling | labor_forecast | ✅ | ✅ |  |
| labor_scheduling | labor_violation | ✅ | ❌ | Excluded from MVM |
| labor_scheduling | schedule | ✅ | ✅ |  |
| labor_scheduling | scheduling_template | ✅ | ❌ | Excluded from MVM |
| labor_scheduling | shift | ✅ | ✅ |  |
| labor_scheduling | time_entry | ✅ | ✅ |  |
| payroll_compliance | labor_budget | ✅ | ❌ | Excluded from MVM |
| payroll_compliance | payroll_group | ✅ | ❌ | Excluded from MVM |
| payroll_compliance | payroll_record | ✅ | ✅ |  |
| payroll_compliance | payroll_run | ✅ | ❌ | Excluded from MVM |
| payroll_compliance | tip_compliance | ✅ | ❌ | Excluded from MVM |
