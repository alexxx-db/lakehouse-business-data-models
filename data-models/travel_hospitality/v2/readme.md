# Travel_Hospitality Lakehouse Data Models

**Version 2** | Generated on June 27, 2026 at 02:37 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Channel](#domain-channel)
  - [Compliance](#domain-compliance)
  - [Event](#domain-event)
  - [Experience](#domain-experience)
  - [Finance](#domain-finance)
  - [Fnb](#domain-fnb)
  - [Guest](#domain-guest)
  - [Housekeeping](#domain-housekeeping)
  - [Inventory](#domain-inventory)
  - [Loyalty](#domain-loyalty)
  - [Marketing](#domain-marketing)
  - [Procurement](#domain-procurement)
  - [Property](#domain-property)
  - [Reservation](#domain-reservation)
  - [Revenue](#domain-revenue)
  - [Spa](#domain-spa)
  - [Workforce](#domain-workforce)


## Business Description

travel hospitality industry enterprise data model.

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
| Domains | 11 | 17 |
| Subdomains | 25 | 73 |
| Products (Tables) | 107 | 363 |
| Attributes (Columns) | 4087 | 13510 |
| Foreign Keys | 602 | 2086 |
| Avg Attributes/Product | 38.2 | 37.2 |

## Domain & Product Comparison

<a id="domain-channel"></a>
### channel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_operations | channel_booking | ✅ | ✅ |  |
| booking_operations | metasearch_listing | ✅ | ❌ | Excluded from MVM |
| booking_operations | ota_campaign_participation | ✅ | ❌ | Excluded from MVM |
| booking_revenue | inventory_allocation | ❌ | ✅ | MVM only (stub or new) |
| channel_inventory_control | channel_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| channel_inventory_control | channel_wholesale_inventory_allocation | ✅ | ❌ | Excluded from MVM |
| channel_inventory_control | stop_sell | ✅ | ❌ | Excluded from MVM |
| channel_inventory_control | wholesale_allotment | ✅ | ❌ | Excluded from MVM |
| cost_tracking | commission_accrual | ✅ | ✅ |  |
| cost_tracking | commission_schedule | ✅ | ✅ |  |
| cost_tracking | connectivity_fee | ✅ | ❌ | Excluded from MVM |
| distribution_setup | booking_source | ✅ | ❌ | Excluded from MVM |
| distribution_setup | channel | ✅ | ✅ |  |
| distribution_setup | channel_contract | ✅ | ✅ |  |
| distribution_setup | crs_channel_mapping | ✅ | ❌ | Excluded from MVM |
| distribution_setup | gds_connection | ✅ | ✅ |  |
| distribution_setup | ota_partner | ✅ | ✅ |  |
| rate_management | channel_negotiated_rate | ✅ | ❌ | Excluded from MVM |
| rate_management | channel_rate_plan | ✅ | ✅ |  |
| rate_management | package_rate | ✅ | ❌ | Excluded from MVM |
| rate_management | rate_parity_audit | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_control | audit | ✅ | ❌ | Domain not in MVM |
| audit_control | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_control | compliance_calendar | ✅ | ❌ | Domain not in MVM |
| audit_control | corrective_action | ✅ | ❌ | Domain not in MVM |
| audit_control | risk_register | ✅ | ❌ | Domain not in MVM |
| audit_control | third_party_due_diligence | ✅ | ❌ | Domain not in MVM |
| policy_training | compliance_training_completion | ✅ | ❌ | Domain not in MVM |
| policy_training | policy | ✅ | ❌ | Domain not in MVM |
| policy_training | policy_acknowledgment | ✅ | ❌ | Domain not in MVM |
| policy_training | sanction_screening | ✅ | ❌ | Domain not in MVM |
| policy_training | whistleblower_report | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | environmental_compliance | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | permit | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | permit_renewal | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_governance | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| safety_privacy | ada_assessment | ✅ | ❌ | Domain not in MVM |
| safety_privacy | dpia | ✅ | ❌ | Domain not in MVM |
| safety_privacy | fire_safety_record | ✅ | ❌ | Domain not in MVM |
| safety_privacy | food_safety_cert | ✅ | ❌ | Domain not in MVM |
| safety_privacy | health_safety_incident | ✅ | ❌ | Domain not in MVM |
| safety_privacy | incident_investigation | ✅ | ❌ | Domain not in MVM |
| safety_privacy | privacy_incident | ✅ | ❌ | Domain not in MVM |

<a id="domain-event"></a>
### event

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| attendee_services | attendee | ✅ | ❌ | Excluded from MVM |
| attendee_services | beo_attendant_assignment | ✅ | ❌ | Excluded from MVM |
| attendee_services | event_class_enrollment | ✅ | ❌ | Excluded from MVM |
| attendee_services | experience_enrollment | ✅ | ❌ | Excluded from MVM |
| attendee_services | staffing_assignment | ✅ | ❌ | Excluded from MVM |
| attendee_services | treatment_allocation | ✅ | ❌ | Excluded from MVM |
| booking_management | event_booking | ✅ | ✅ |  |
| booking_management | event_contract | ✅ | ✅ |  |
| booking_management | event_group_block | ✅ | ❌ | Excluded from MVM |
| booking_management | event_revenue | ✅ | ✅ |  |
| booking_management | invoice | ✅ | ❌ | Excluded from MVM |
| client_development | account | ✅ | ✅ |  |
| client_development | inquiry | ✅ | ✅ |  |
| client_development | lost_business | ✅ | ❌ | Excluded from MVM |
| client_development | proposal | ✅ | ✅ |  |
| space_operations | beo | ✅ | ✅ |  |
| space_operations | beo_item | ✅ | ✅ |  |
| space_operations | catering_menu | ✅ | ✅ |  |
| space_operations | event_space_allocation | ✅ | ❌ | Excluded from MVM |
| space_operations | function_space | ✅ | ✅ |  |
| venue_operations | space_allocation | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-experience"></a>
### experience

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | feedback_topic_extraction | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | feedback_review_topic_assignment | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | feedback_topic | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | gss_score | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | guest_feedback | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | nps_survey | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | online_review | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | reputation_alert | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | review_topic_extraction | ✅ | ❌ | Domain not in MVM |
| feedback_intelligence | survey_template | ✅ | ❌ | Domain not in MVM |
| guest_programs | experience_special_request | ✅ | ❌ | Domain not in MVM |
| guest_programs | guest_experience_enrollment | ✅ | ❌ | Domain not in MVM |
| guest_programs | program | ✅ | ❌ | Domain not in MVM |
| guest_programs | program_fitness_inclusion | ✅ | ❌ | Domain not in MVM |
| guest_programs | program_treatment_inclusion | ✅ | ❌ | Domain not in MVM |
| journey_touchpoints | amenity_fulfillment | ✅ | ❌ | Domain not in MVM |
| journey_touchpoints | guest_interaction | ✅ | ❌ | Domain not in MVM |
| journey_touchpoints | touchpoint | ✅ | ❌ | Domain not in MVM |
| service_recovery | case_activity | ✅ | ❌ | Domain not in MVM |
| service_recovery | quality_audit | ✅ | ❌ | Domain not in MVM |
| service_recovery | service_case | ✅ | ❌ | Domain not in MVM |
| service_recovery | service_recovery_action | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | capex_request | ✅ | ❌ | Domain not in MVM |
| asset_management | fixed_asset | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | finance_budget | ✅ | ❌ | Domain not in MVM |
| general_ledger | allocation_rule_set | ✅ | ❌ | Domain not in MVM |
| general_ledger | allocation_run | ✅ | ❌ | Domain not in MVM |
| general_ledger | cost_center | ✅ | ❌ | Domain not in MVM |
| general_ledger | fiscal_period | ✅ | ❌ | Domain not in MVM |
| general_ledger | gl_batch | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | ledger | ✅ | ❌ | Domain not in MVM |
| general_ledger | profit_center | ✅ | ❌ | Domain not in MVM |
| general_ledger | recurring_entry_template | ✅ | ❌ | Domain not in MVM |
| owner_reporting | hma_contract | ✅ | ❌ | Domain not in MVM |
| owner_reporting | management_fee | ✅ | ❌ | Domain not in MVM |
| owner_reporting | owner_distribution | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | bank_account | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_run | ✅ | ❌ | Domain not in MVM |
| payables_receivables | tax_posting | ✅ | ❌ | Domain not in MVM |

<a id="domain-fnb"></a>
### fnb

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| banquet_catering | banquet_event_order | ✅ | ❌ | Excluded from MVM |
| banquet_catering | banquet_menu_package | ✅ | ❌ | Excluded from MVM |
| menu_catalog | menu | ✅ | ✅ |  |
| menu_catalog | menu_item | ✅ | ✅ |  |
| menu_catalog | recipe | ✅ | ✅ |  |
| menu_catalog | recipe_ingredient | ✅ | ✅ |  |
| outlet_operations | discount | ✅ | ❌ | Excluded from MVM |
| outlet_operations | fnb_outlet | ✅ | ✅ |  |
| outlet_operations | pos_check | ✅ | ✅ |  |
| outlet_operations | pos_check_line | ✅ | ✅ |  |
| outlet_operations | revenue_center | ✅ | ❌ | Excluded from MVM |
| outlet_operations | room_service_order | ✅ | ✅ |  |
| outlet_operations | void_transaction | ✅ | ❌ | Excluded from MVM |
| safety_quality | food_safety_inspection | ✅ | ✅ |  |
| safety_quality | waste_log | ✅ | ❌ | Excluded from MVM |
| supply_inventory | fnb_supply_agreement | ✅ | ❌ | Excluded from MVM |
| supply_inventory | inventory_item | ✅ | ✅ |  |
| supply_inventory | physical_count | ✅ | ❌ | Excluded from MVM |
| supply_inventory | stock_transaction | ✅ | ✅ |  |
| supply_inventory | storage_location | ✅ | ❌ | Excluded from MVM |
| supply_inventory | wine_cellar | ✅ | ❌ | Excluded from MVM |

<a id="domain-guest"></a>
### guest

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| group_enrollment | group_function_space_booking | ✅ | ❌ | Excluded from MVM |
| group_enrollment | guest_enrollment | ✅ | ❌ | Excluded from MVM |
| group_enrollment | guest_group_block | ✅ | ❌ | Excluded from MVM |
| identity_management | communication_consent | ✅ | ✅ |  |
| identity_management | contact_info | ✅ | ✅ |  |
| identity_management | identity_document | ✅ | ✅ |  |
| identity_management | preference | ✅ | ✅ |  |
| identity_management | privacy_request | ✅ | ❌ | Excluded from MVM |
| identity_management | profile | ✅ | ✅ |  |
| identity_management | profile_merge_history | ✅ | ❌ | Excluded from MVM |
| relationship_value | corporate_account | ✅ | ✅ |  |
| relationship_value | corporate_property_contract | ✅ | ❌ | Excluded from MVM |
| relationship_value | household | ✅ | ❌ | Excluded from MVM |
| relationship_value | lifetime_value | ✅ | ❌ | Excluded from MVM |
| relationship_value | relationship | ✅ | ❌ | Excluded from MVM |
| relationship_value | vip_designation | ✅ | ✅ |  |
| stay_analytics | note | ✅ | ❌ | Excluded from MVM |
| stay_analytics | predictive_score | ✅ | ❌ | Excluded from MVM |
| stay_analytics | segment | ✅ | ✅ |  |
| stay_analytics | segment_membership | ✅ | ❌ | Excluded from MVM |
| stay_analytics | stay_history | ✅ | ✅ |  |

<a id="domain-housekeeping"></a>
### housekeeping

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_maintenance | housekeeping_training_completion | ✅ | ❌ | Excluded from MVM |
| facility_maintenance | maintenance_handoff | ✅ | ❌ | Excluded from MVM |
| facility_maintenance | maintenance_request | ✅ | ✅ |  |
| facility_maintenance | public_area | ✅ | ❌ | Excluded from MVM |
| facility_maintenance | work_order | ✅ | ✅ |  |
| quality_control | cleaning_standard | ✅ | ❌ | Excluded from MVM |
| quality_control | deep_clean_plan | ✅ | ❌ | Excluded from MVM |
| quality_control | inspection | ✅ | ✅ |  |
| quality_control | inspection_deficiency | ✅ | ❌ | Excluded from MVM |
| room_operations | attendant | ✅ | ✅ |  |
| room_operations | cleaning_task | ✅ | ✅ |  |
| room_operations | hk_assignment | ✅ | ✅ |  |
| room_operations | hk_schedule | ✅ | ✅ |  |
| room_operations | lost_and_found | ✅ | ✅ |  |
| room_operations | team | ✅ | ❌ | Excluded from MVM |
| supply_inventory | laundry_order | ✅ | ❌ | Excluded from MVM |
| supply_inventory | linen_management | ✅ | ❌ | Excluded from MVM |
| supply_inventory | supply_consumption | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| availability_control | availability_snapshot | ✅ | ✅ |  |
| availability_control | change_audit | ✅ | ❌ | Excluded from MVM |
| availability_control | channel_inventory_map | ✅ | ❌ | Excluded from MVM |
| availability_control | control | ✅ | ✅ |  |
| availability_control | inventory_overbooking_policy | ✅ | ❌ | Excluded from MVM |
| availability_control | los_restriction | ✅ | ✅ |  |
| block_allotment | allotment | ✅ | ❌ | Excluded from MVM |
| block_allotment | block_pickup | ✅ | ❌ | Excluded from MVM |
| block_allotment | block_wash_factor_application | ✅ | ❌ | Excluded from MVM |
| block_allotment | room_block | ✅ | ✅ |  |
| rate_assignment | rate_plan_room_type_assignment | ✅ | ❌ | Excluded from MVM |
| rate_assignment | room_type_competitive_benchmark | ✅ | ❌ | Excluded from MVM |
| rate_assignment | room_type_promotion | ✅ | ❌ | Excluded from MVM |
| room_configuration | out_of_order | ✅ | ✅ |  |
| room_configuration | room | ✅ | ✅ |  |
| room_configuration | room_amenity | ✅ | ✅ |  |
| room_configuration | room_material_installation | ✅ | ❌ | Excluded from MVM |
| room_configuration | room_status | ✅ | ✅ |  |
| room_configuration | room_type | ✅ | ✅ |  |
| room_configuration | room_type_vendor_supply | ✅ | ❌ | Excluded from MVM |

<a id="domain-loyalty"></a>
### loyalty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefit_rewards | benefit_entitlement | ✅ | ✅ |  |
| benefit_rewards | benefit_redemption | ✅ | ❌ | Excluded from MVM |
| benefit_rewards | certificate | ✅ | ❌ | Excluded from MVM |
| benefit_rewards | reward_catalog | ✅ | ✅ |  |
| fraud_compliance | fraud_alert | ✅ | ❌ | Excluded from MVM |
| fraud_compliance | package_purchase | ✅ | ❌ | Excluded from MVM |
| member_management | loyalty_enrollment | ✅ | ❌ | Excluded from MVM |
| member_management | member | ✅ | ✅ |  |
| member_management | member_preference | ✅ | ❌ | Excluded from MVM |
| member_management | member_segment | ✅ | ❌ | Excluded from MVM |
| member_management | tier | ✅ | ✅ |  |
| member_management | tier_history | ✅ | ✅ |  |
| partner_promotions | partner_program | ✅ | ❌ | Excluded from MVM |
| partner_promotions | program_config | ✅ | ❌ | Excluded from MVM |
| partner_promotions | promotion | ✅ | ✅ |  |
| partner_promotions | promotion_distribution | ✅ | ❌ | Excluded from MVM |
| partner_promotions | promotion_enrollment | ✅ | ✅ |  |
| partner_promotions | promotion_treatment_rule | ✅ | ❌ | Excluded from MVM |
| points_engine | accrual_rule | ✅ | ✅ |  |
| points_engine | points_ledger | ✅ | ✅ |  |
| points_engine | points_transfer | ✅ | ❌ | Excluded from MVM |
| points_engine | redemption | ✅ | ✅ |  |
| points_engine | redemption_rule | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_targeting | attribution_event | ✅ | ❌ | Domain not in MVM |
| audience_targeting | consent | ✅ | ❌ | Domain not in MVM |
| audience_targeting | guest_communication | ✅ | ❌ | Domain not in MVM |
| audience_targeting | guest_segment | ✅ | ❌ | Domain not in MVM |
| audience_targeting | offer_redemption | ✅ | ❌ | Domain not in MVM |
| brand_content | brand | ✅ | ❌ | Domain not in MVM |
| brand_content | communication_template | ✅ | ❌ | Domain not in MVM |
| brand_content | content_asset | ✅ | ❌ | Domain not in MVM |
| brand_content | marketing_calendar | ✅ | ❌ | Domain not in MVM |
| brand_content | social_post | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_execution | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_offer | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_treatment_promotion | ✅ | ❌ | Domain not in MVM |
| survey_intelligence | experiment | ✅ | ❌ | Domain not in MVM |
| survey_intelligence | survey_program | ✅ | ❌ | Domain not in MVM |
| survey_intelligence | survey_response | ✅ | ❌ | Domain not in MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefits_administration | procurement_benefit_plan | ✅ | ❌ | Domain not in MVM |
| contract_sourcing | procurement_contract | ✅ | ❌ | Domain not in MVM |
| contract_sourcing | procurement_supply_agreement | ✅ | ❌ | Domain not in MVM |
| contract_sourcing | procurement_therapist_certification | ✅ | ❌ | Domain not in MVM |
| contract_sourcing | request_for_quotation | ✅ | ❌ | Domain not in MVM |
| contract_sourcing | vendor_quotation | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | goods_receipt | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | material_master | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | po_line | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | purchase_order | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | purchase_return | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | requisition_line | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| project_delivery | delivery_address | ✅ | ❌ | Domain not in MVM |
| project_delivery | procurement_work_order | ✅ | ❌ | Domain not in MVM |
| project_delivery | program_assignment | ✅ | ❌ | Domain not in MVM |
| project_delivery | project | ✅ | ❌ | Domain not in MVM |
| vendor_management | category | ✅ | ❌ | Domain not in MVM |
| vendor_management | category_buyer_assignment | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_category_qualification | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_certification | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_performance | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_program_participation | ✅ | ❌ | Domain not in MVM |
| vendor_management | vendor_touchpoint_service | ✅ | ❌ | Domain not in MVM |

<a id="domain-property"></a>
### property

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | hierarchy | ✅ | ✅ |  |
| asset_registry | property | ✅ | ✅ |  |
| asset_registry | property_facility | ✅ | ✅ |  |
| capital_improvement | certification | ✅ | ❌ | Excluded from MVM |
| capital_improvement | pip_item | ✅ | ❌ | Excluded from MVM |
| capital_improvement | pip_plan | ✅ | ❌ | Excluded from MVM |
| commercial_agreements | channel_connection | ✅ | ❌ | Excluded from MVM |
| commercial_agreements | gds_profile | ✅ | ✅ |  |
| commercial_agreements | vendor_agreement | ✅ | ❌ | Excluded from MVM |
| ownership_governance | franchise_agreement | ✅ | ✅ |  |
| ownership_governance | legal_entity | ✅ | ❌ | Excluded from MVM |
| ownership_governance | ownership_entity | ✅ | ❌ | Excluded from MVM |
| ownership_governance | party | ✅ | ❌ | Excluded from MVM |
| space_operations | currency | ✅ | ✅ |  |
| space_operations | media | ✅ | ❌ | Excluded from MVM |
| space_operations | meeting_space | ✅ | ✅ |  |
| space_operations | property_outlet | ✅ | ✅ |  |
| space_operations | property_space_allocation | ✅ | ❌ | Excluded from MVM |
| space_operations | seasonal_calendar | ✅ | ❌ | Excluded from MVM |

<a id="domain-reservation"></a>
### reservation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_management | booking_status_history | ✅ | ✅ |  |
| booking_management | cancellation | ✅ | ✅ |  |
| booking_management | group_block | ❌ | ✅ | MVM only (stub or new) |
| booking_management | reservation_booking | ✅ | ✅ |  |
| group_blocks | group_block_pickup | ✅ | ❌ | Excluded from MVM |
| group_blocks | group_spa_package_contract | ✅ | ❌ | Excluded from MVM |
| group_blocks | reservation_group_block | ✅ | ❌ | Excluded from MVM |
| guest_services | deposit_ledger | ✅ | ✅ |  |
| guest_services | reservation_special_request | ✅ | ❌ | Excluded from MVM |
| guest_services | special_request | ❌ | ✅ | MVM only (stub or new) |
| guest_services | travel_agent | ✅ | ✅ |  |
| guest_services | waitlist | ✅ | ❌ | Excluded from MVM |
| rate_policy | cancellation_policy | ✅ | ✅ |  |
| rate_policy | reservation_rate_plan | ✅ | ✅ |  |
| room_allocation | booking_package | ✅ | ❌ | Excluded from MVM |
| room_allocation | program_enrollment | ✅ | ❌ | Excluded from MVM |
| room_allocation | room_assignment | ✅ | ✅ |  |
| room_allocation | walk_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-revenue"></a>
### revenue

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| competitive_intelligence | competitive_set | ✅ | ❌ | Excluded from MVM |
| competitive_intelligence | competitor_rate | ✅ | ❌ | Excluded from MVM |
| competitive_intelligence | str_benchmark | ✅ | ❌ | Excluded from MVM |
| demand_performance | budget | ❌ | ✅ | MVM only (stub or new) |
| demand_strategy | demand_forecast | ✅ | ✅ |  |
| demand_strategy | displacement_analysis | ✅ | ❌ | Excluded from MVM |
| demand_strategy | group_evaluation | ✅ | ❌ | Excluded from MVM |
| demand_strategy | inventory_control | ✅ | ❌ | Excluded from MVM |
| demand_strategy | pickup_report | ✅ | ❌ | Excluded from MVM |
| demand_strategy | strategy | ✅ | ❌ | Excluded from MVM |
| demand_strategy | wash_factor | ✅ | ❌ | Excluded from MVM |
| rate_pricing | dynamic_rate_rule | ✅ | ✅ |  |
| rate_pricing | negotiated_rate | ❌ | ✅ | MVM only (stub or new) |
| rate_pricing | pricing_override | ✅ | ❌ | Excluded from MVM |
| rate_pricing | rate_availability | ✅ | ✅ |  |
| rate_pricing | rate_restriction | ✅ | ✅ |  |
| rate_pricing | revenue_negotiated_rate | ✅ | ❌ | Excluded from MVM |
| rate_pricing | revenue_overbooking_policy | ✅ | ❌ | Excluded from MVM |
| rate_pricing | revenue_rate_plan | ✅ | ✅ |  |
| segment_performance | channel_contribution | ✅ | ❌ | Excluded from MVM |
| segment_performance | market_segment | ✅ | ✅ |  |
| segment_performance | performance_actuals | ✅ | ✅ |  |
| segment_performance | revenue_budget | ✅ | ❌ | Excluded from MVM |
| segment_performance | segment_program_eligibility | ✅ | ❌ | Excluded from MVM |
| segment_performance | total_revenue_actuals | ✅ | ❌ | Excluded from MVM |

<a id="domain-spa"></a>
### spa

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| appointment_booking | appointment | ✅ | ✅ |  |
| appointment_booking | appointment_package | ✅ | ❌ | Excluded from MVM |
| appointment_booking | cancellation_log | ✅ | ❌ | Excluded from MVM |
| appointment_booking | package | ✅ | ✅ |  |
| appointment_booking | spa_class_enrollment | ✅ | ❌ | Excluded from MVM |
| appointment_booking | therapist_schedule | ✅ | ✅ |  |
| fitness_recreation | day_pass | ✅ | ❌ | Excluded from MVM |
| fitness_recreation | equipment | ✅ | ❌ | Excluded from MVM |
| fitness_recreation | fitness_class | ✅ | ❌ | Excluded from MVM |
| fitness_recreation | fitness_class_session | ✅ | ❌ | Excluded from MVM |
| fitness_recreation | golf_tee_time | ✅ | ❌ | Excluded from MVM |
| fitness_recreation | spa_facility | ✅ | ✅ |  |
| retail_membership | membership | ✅ | ✅ |  |
| retail_membership | membership_visit | ✅ | ❌ | Excluded from MVM |
| retail_membership | product | ✅ | ❌ | Excluded from MVM |
| retail_membership | product_line | ✅ | ❌ | Excluded from MVM |
| retail_membership | retail_inventory | ✅ | ❌ | Excluded from MVM |
| retail_membership | retail_product | ✅ | ❌ | Excluded from MVM |
| retail_membership | retail_transaction | ✅ | ❌ | Excluded from MVM |
| revenue_pricing | amenity_pricing | ✅ | ❌ | Excluded from MVM |
| revenue_pricing | charge | ✅ | ✅ |  |
| revenue_pricing | group_booking | ✅ | ❌ | Excluded from MVM |
| treatment_catalog | package_treatment_inclusion | ❌ | ✅ | MVM only (stub or new) |
| treatment_catalog | treatment_menu_item | ❌ | ✅ | MVM only (stub or new) |
| treatment_services | intake_form | ✅ | ❌ | Excluded from MVM |
| treatment_services | package_treatment | ✅ | ❌ | Excluded from MVM |
| treatment_services | program_treatment | ✅ | ❌ | Excluded from MVM |
| treatment_services | spa_therapist_certification | ✅ | ❌ | Excluded from MVM |
| treatment_services | therapist | ✅ | ✅ |  |
| treatment_services | treatment | ✅ | ✅ |  |
| treatment_services | treatment_menu | ✅ | ✅ |  |
| treatment_services | treatment_room | ✅ | ✅ |  |
| treatment_services | wellness_program | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | workforce_training_completion | ✅ | ❌ | Domain not in MVM |
| benefits_administration | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| benefits_payroll | leave_request | ✅ | ❌ | Domain not in MVM |
| benefits_payroll | payroll_period | ✅ | ❌ | Domain not in MVM |
| benefits_payroll | payroll_run | ✅ | ❌ | Domain not in MVM |
| benefits_payroll | workforce_benefit_plan | ✅ | ❌ | Domain not in MVM |
| employee_records | compensation_plan | ✅ | ❌ | Domain not in MVM |
| employee_records | employee | ✅ | ❌ | Domain not in MVM |
| employee_records | learning_course | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| scheduling_attendance | schedule | ✅ | ❌ | Domain not in MVM |
| scheduling_attendance | shift_template | ✅ | ❌ | Domain not in MVM |
| scheduling_attendance | time_entry | ✅ | ❌ | Domain not in MVM |
| scheduling_attendance | workforce_safety_incident | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | performance_review | ✅ | ❌ | Domain not in MVM |
