# Shipping_Ports Lakehouse Data Models

**Version 2** | Generated on July 13, 2026 at 10:24 AM

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
  - [Booking](#domain-booking)
  - [Cargo](#domain-cargo)
  - [Compliance](#domain-compliance)
  - [Contract](#domain-contract)
  - [Customer](#domain-customer)
  - [Finance](#domain-finance)
  - [Infrastructure](#domain-infrastructure)
  - [Intermodal](#domain-intermodal)
  - [Marine](#domain-marine)
  - [Masterdata](#domain-masterdata)
  - [Procurement](#domain-procurement)
  - [Safety](#domain-safety)
  - [Security](#domain-security)
  - [Sustainability](#domain-sustainability)
  - [Tariff](#domain-tariff)
  - [Terminal](#domain-terminal)
  - [Vessel](#domain-vessel)
  - [Workforce](#domain-workforce)


## Business Description

Shipping and Ports is a maritime logistics industry managing marine terminals, container handling, vessel operations, and port infrastructure at major seaports, facilitating international trade and global supply chain connectivity.

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
| Domains | 12 | 20 |
| Subdomains | 29 | 77 |
| Products (Tables) | 117 | 395 |
| Attributes (Columns) | 5216 | 16142 |
| Foreign Keys | 1105 | 2654 |
| Avg Attributes/Product | 44.6 | 40.9 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| equipment_registry | acquisition | ✅ | ❌ | Excluded from MVM |
| equipment_registry | asset_location | ✅ | ❌ | Excluded from MVM |
| equipment_registry | depreciation_schedule | ✅ | ❌ | Excluded from MVM |
| equipment_registry | disposal | ✅ | ❌ | Excluded from MVM |
| equipment_registry | equipment_class | ✅ | ✅ |  |
| equipment_registry | port_asset | ✅ | ✅ |  |
| equipment_registry | swl_certificate | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | downtime_record | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | failure_report | ✅ | ✅ |  |
| maintenance_operations | inspection_checklist | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | inspection_record | ✅ | ✅ |  |
| maintenance_operations | maintenance_plan | ✅ | ✅ |  |
| maintenance_operations | work_order | ✅ | ✅ |  |
| maintenance_operations | work_order_task | ✅ | ✅ |  |
| maintenance_operations | work_order_template | ✅ | ❌ | Excluded from MVM |
| parts_supply | meter | ✅ | ❌ | Excluded from MVM |
| parts_supply | plan_part_requirement | ✅ | ❌ | Excluded from MVM |
| parts_supply | spare_part | ✅ | ✅ |  |
| parts_supply | task_part_consumption | ✅ | ❌ | Excluded from MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| dispute_resolution | adjustment | ✅ | ✅ |  |
| dispute_resolution | debit_note | ✅ | ✅ |  |
| dispute_resolution | dispute | ✅ | ✅ |  |
| invoice_management | billing_cycle | ✅ | ❌ | Excluded from MVM |
| invoice_management | billing_run | ✅ | ❌ | Excluded from MVM |
| invoice_management | charge_event | ✅ | ✅ |  |
| invoice_management | invoice | ✅ | ✅ |  |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | proforma_invoice | ✅ | ❌ | Excluded from MVM |
| invoice_management | statement_of_account | ✅ | ❌ | Excluded from MVM |
| receivables_settlement | dunning_notice | ✅ | ❌ | Excluded from MVM |
| receivables_settlement | payment | ✅ | ✅ |  |
| receivables_settlement | payment_allocation | ✅ | ✅ |  |
| receivables_settlement | receivable_account | ✅ | ✅ |  |
| revenue_recognition | performance_obligation | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | revenue_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-booking"></a>
### booking

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_control | amendment | ✅ | ❌ | Domain not in MVM |
| booking_control | confirmation | ✅ | ❌ | Domain not in MVM |
| booking_control | vessel_call_security_assignment | ✅ | ❌ | Domain not in MVM |
| cargo_reservation | cargo_booking | ✅ | ❌ | Domain not in MVM |
| cargo_reservation | slot_reservation | ✅ | ❌ | Domain not in MVM |
| cargo_reservation | truck_gate_booking | ✅ | ❌ | Domain not in MVM |
| service_fulfillment | booking_service_order | ✅ | ❌ | Domain not in MVM |
| service_fulfillment | resource_allocation | ✅ | ❌ | Domain not in MVM |
| service_fulfillment | service_requirement | ✅ | ❌ | Domain not in MVM |
| vessel_scheduling | booking_anchorage_booking | ✅ | ❌ | Domain not in MVM |
| vessel_scheduling | booking_berth_reservation | ✅ | ❌ | Domain not in MVM |
| vessel_scheduling | call_booking | ✅ | ❌ | Domain not in MVM |
| vessel_scheduling | pre_arrival | ✅ | ❌ | Domain not in MVM |
| vessel_scheduling | voyage_nomination | ✅ | ❌ | Domain not in MVM |

<a id="domain-cargo"></a>
### cargo

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_exceptions | bol_discount_application | ✅ | ❌ | Excluded from MVM |
| billing_exceptions | container_surcharge_application | ✅ | ❌ | Excluded from MVM |
| billing_exceptions | damage_claim | ✅ | ❌ | Excluded from MVM |
| billing_exceptions | demurrage_detention | ✅ | ✅ |  |
| billing_exceptions | shipment_tariff_exception | ✅ | ❌ | Excluded from MVM |
| container_management | cargo_rail_wagon_load | ✅ | ❌ | Excluded from MVM |
| container_management | container | ✅ | ✅ |  |
| container_management | container_gate_transaction | ✅ | ❌ | Excluded from MVM |
| container_management | container_preadvice | ✅ | ❌ | Excluded from MVM |
| container_management | handling_order | ✅ | ✅ |  |
| container_management | move | ✅ | ✅ |  |
| container_management | stowage_plan | ✅ | ✅ |  |
| container_management | stowage_position | ✅ | ❌ | Excluded from MVM |
| hazardous_cargo | dangerous_goods_declaration | ✅ | ✅ |  |
| hazardous_cargo | verified_gross_mass | ✅ | ✅ |  |
| shipment_documentation | bill_of_lading | ✅ | ✅ |  |
| shipment_documentation | cargo_document | ✅ | ❌ | Excluded from MVM |
| shipment_documentation | delivery_order | ✅ | ✅ |  |
| shipment_documentation | lcl_consolidation | ✅ | ❌ | Excluded from MVM |
| shipment_documentation | manifest | ✅ | ✅ |  |
| shipment_documentation | manifest_line | ✅ | ✅ |  |
| shipment_documentation | shipment | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customs_clearance | customs_broker | ✅ | ✅ |  |
| customs_clearance | customs_declaration | ✅ | ✅ |  |
| customs_clearance | customs_hold | ✅ | ✅ |  |
| customs_clearance | declaration_screening | ✅ | ❌ | Excluded from MVM |
| customs_clearance | hs_code | ✅ | ✅ |  |
| customs_clearance | trade_document | ✅ | ✅ |  |
| facility_security | compliance_audit | ✅ | ❌ | Excluded from MVM |
| facility_security | isps_facility_record | ✅ | ✅ |  |
| facility_security | marpol_record | ✅ | ✅ |  |
| facility_security | violation | ✅ | ❌ | Excluded from MVM |
| trade_regulatory | import_export_permit | ✅ | ✅ |  |
| trade_regulatory | sanctions_screening | ✅ | ✅ |  |
| trade_regulatory | trade_restriction | ✅ | ❌ | Excluded from MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_lifecycle | agreement | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | agreement_party | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | agreement_version | ✅ | ❌ | Domain not in MVM |
| agreement_lifecycle | service_scope | ✅ | ❌ | Domain not in MVM |
| commercial_terms | contract_document | ✅ | ❌ | Domain not in MVM |
| commercial_terms | pil_arrangement | ✅ | ❌ | Domain not in MVM |
| commercial_terms | rate_schedule | ✅ | ❌ | Domain not in MVM |
| commercial_terms | volume_commitment | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | dispute_record | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | guarantee_bond | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | penalty_assessment | ✅ | ❌ | Domain not in MVM |
| dispute_resolution | penalty_clause | ✅ | ❌ | Domain not in MVM |
| performance_obligations | sla_breach | ✅ | ❌ | Domain not in MVM |
| performance_obligations | sla_definition | ✅ | ❌ | Domain not in MVM |
| performance_obligations | sla_measurement | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_compliance | accreditation | ✅ | ❌ | Excluded from MVM |
| access_compliance | commodity_handling_authorization | ✅ | ❌ | Excluded from MVM |
| access_compliance | location_access_authorization | ✅ | ❌ | Excluded from MVM |
| access_compliance | participant_trade_exemption | ✅ | ❌ | Excluded from MVM |
| access_compliance | port_access_permit | ✅ | ✅ |  |
| onboarding_relations | credit_assessment | ✅ | ✅ |  |
| onboarding_relations | edi_subscription | ✅ | ❌ | Excluded from MVM |
| onboarding_relations | onboarding_application | ✅ | ❌ | Excluded from MVM |
| onboarding_relations | participant_document | ✅ | ❌ | Excluded from MVM |
| onboarding_relations | relationship_manager | ✅ | ❌ | Excluded from MVM |
| participant_registry | contact_person | ✅ | ✅ |  |
| participant_registry | org_hierarchy | ✅ | ❌ | Excluded from MVM |
| participant_registry | participant_account | ✅ | ✅ |  |
| participant_registry | participant_address | ✅ | ✅ |  |
| participant_registry | port_community_participant | ✅ | ✅ |  |
| service_engagement | communication_log | ✅ | ❌ | Excluded from MVM |
| service_engagement | participant_service_agreement | ✅ | ✅ |  |
| service_engagement | service_request | ✅ | ✅ |  |
| service_engagement | sla_performance | ✅ | ❌ | Excluded from MVM |
| service_engagement | sla_profile | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_reporting | asset_transaction | ✅ | ❌ | Domain not in MVM |
| asset_reporting | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_reporting | lease_liability | ✅ | ❌ | Domain not in MVM |
| asset_reporting | provision | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_plan | ✅ | ❌ | Domain not in MVM |
| budget_planning | internal_order_gang_assignment | ✅ | ❌ | Domain not in MVM |
| budget_planning | investment_program | ✅ | ❌ | Domain not in MVM |
| budget_planning | project_gang_assignment | ✅ | ❌ | Domain not in MVM |
| ledger_control | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| ledger_control | company_code | ✅ | ❌ | Domain not in MVM |
| ledger_control | cost_centre | ✅ | ❌ | Domain not in MVM |
| ledger_control | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_control | internal_order | ✅ | ❌ | Domain not in MVM |
| ledger_control | profit_centre | ✅ | ❌ | Domain not in MVM |
| ledger_control | wbs_element | ✅ | ❌ | Domain not in MVM |
| transaction_processing | accrual | ✅ | ❌ | Domain not in MVM |
| transaction_processing | ap_invoice | ✅ | ❌ | Domain not in MVM |
| transaction_processing | ap_payment | ✅ | ❌ | Domain not in MVM |
| transaction_processing | cost_allocation | ✅ | ❌ | Domain not in MVM |
| transaction_processing | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| transaction_processing | journal_entry | ✅ | ❌ | Domain not in MVM |
| transaction_processing | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| transaction_processing | receivable | ✅ | ❌ | Domain not in MVM |

<a id="domain-infrastructure"></a>
### infrastructure

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| berth_facilities | berth | ✅ | ✅ |  |
| berth_facilities | berth_service_contract | ✅ | ❌ | Excluded from MVM |
| berth_facilities | infrastructure_berth_allocation | ✅ | ❌ | Excluded from MVM |
| berth_facilities | infrastructure_berth_reservation | ✅ | ❌ | Excluded from MVM |
| berth_facilities | infrastructure_terminal | ✅ | ❌ | Excluded from MVM |
| berth_facilities | quay_wall | ✅ | ✅ |  |
| berth_facilities | terminal_zone | ✅ | ✅ |  |
| capital_development | permit | ✅ | ❌ | Excluded from MVM |
| capital_development | project | ✅ | ❌ | Excluded from MVM |
| capital_development | project_permit | ✅ | ❌ | Excluded from MVM |
| capital_development | project_service_cost | ✅ | ❌ | Excluded from MVM |
| capital_development | structural_inspection | ✅ | ❌ | Excluded from MVM |
| marine_waterways | anchorage_area | ✅ | ✅ |  |
| marine_waterways | channel | ✅ | ✅ |  |
| marine_waterways | depth_survey | ✅ | ❌ | Excluded from MVM |
| marine_waterways | dredging_campaign | ✅ | ❌ | Excluded from MVM |
| marine_waterways | infrastructure_anchorage_booking | ✅ | ❌ | Excluded from MVM |
| marine_waterways | navigational_aid | ✅ | ❌ | Excluded from MVM |
| port_access | closure | ✅ | ❌ | Excluded from MVM |
| port_access | port | ✅ | ✅ |  |
| port_access | port_gate | ✅ | ✅ |  |
| port_access | utility_network | ✅ | ❌ | Excluded from MVM |
| storage_assets | facility | ✅ | ✅ |  |
| storage_assets | facility_building | ✅ | ❌ | Excluded from MVM |
| storage_assets | warehouse | ✅ | ✅ |  |
| storage_assets | warehouse_commodity_approval | ✅ | ❌ | Excluded from MVM |
| storage_assets | warehouse_imdg_approval | ✅ | ❌ | Excluded from MVM |
| storage_assets | waste_reception_facility | ✅ | ❌ | Excluded from MVM |
| storage_assets | weighing_station | ✅ | ❌ | Excluded from MVM |

<a id="domain-intermodal"></a>
### intermodal

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inland_logistics | facility_access_agreement | ✅ | ❌ | Excluded from MVM |
| inland_logistics | haulier_icd_service_agreement | ✅ | ❌ | Excluded from MVM |
| inland_logistics | icd_facility | ✅ | ✅ |  |
| inland_logistics | last_mile_event | ✅ | ❌ | Excluded from MVM |
| inland_logistics | transport_leg | ✅ | ❌ | Excluded from MVM |
| inland_logistics | transport_order | ✅ | ✅ |  |
| rail_operations | intermodal_rail_wagon_load | ✅ | ❌ | Excluded from MVM |
| rail_operations | rail_icd_service_agreement | ✅ | ❌ | Excluded from MVM |
| rail_operations | rail_operator | ✅ | ✅ |  |
| rail_operations | rail_visit | ✅ | ✅ |  |
| rail_operations | rail_wagon | ✅ | ✅ |  |
| rail_operations | wagon_consist | ❌ | ✅ | MVM only (stub or new) |
| road_transport | drayage_order | ✅ | ✅ |  |
| road_transport | driver_authorization | ✅ | ❌ | Excluded from MVM |
| road_transport | haulier | ✅ | ✅ |  |
| road_transport | truck_appointment | ✅ | ✅ |  |
| road_transport | truck_visit | ✅ | ✅ |  |
| service_capacity | edi_message | ✅ | ❌ | Excluded from MVM |
| service_capacity | intermodal_service | ✅ | ❌ | Excluded from MVM |
| service_capacity | service_subscription | ✅ | ❌ | Excluded from MVM |
| service_capacity | slot_booking | ✅ | ❌ | Excluded from MVM |
| service_management | service | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-marine"></a>
### marine

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| harbour_services | launch_dispatch | ✅ | ❌ | Excluded from MVM |
| harbour_services | marine_service_order | ✅ | ❌ | Excluded from MVM |
| harbour_services | mooring_operation | ✅ | ✅ |  |
| harbour_services | towage_order | ✅ | ✅ |  |
| harbour_services | tug | ✅ | ✅ |  |
| harbour_services | tug_assignment | ✅ | ✅ |  |
| harbour_services | weather_tide_window | ✅ | ❌ | Excluded from MVM |
| pilotage_operations | pilot | ✅ | ✅ |  |
| pilotage_operations | pilot_channel_authorisation | ✅ | ❌ | Excluded from MVM |
| pilotage_operations | pilot_duty_roster | ✅ | ❌ | Excluded from MVM |
| pilotage_operations | pilot_vessel_type_endorsement | ✅ | ❌ | Excluded from MVM |
| pilotage_operations | pilotage_assignment | ✅ | ✅ |  |
| pilotage_operations | pilotage_exemption | ✅ | ❌ | Excluded from MVM |
| pilotage_operations | pilotage_route | ✅ | ✅ |  |
| survey_compliance | marine_incident | ✅ | ❌ | Excluded from MVM |
| survey_compliance | marpol_operation | ✅ | ❌ | Excluded from MVM |
| survey_compliance | pni_club_notification | ✅ | ❌ | Excluded from MVM |
| survey_compliance | survey_appointment | ✅ | ❌ | Excluded from MVM |
| survey_compliance | surveyor | ✅ | ❌ | Excluded from MVM |
| survey_compliance | surveyor_authorization | ✅ | ❌ | Excluded from MVM |
| vessel_assistance | service_order | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-masterdata"></a>
### masterdata

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cargo_classification | cargo_category | ✅ | ❌ | Excluded from MVM |
| cargo_classification | commodity_code | ✅ | ✅ |  |
| cargo_classification | container_type | ✅ | ✅ |  |
| cargo_classification | imdg_class | ✅ | ✅ |  |
| cargo_classification | packaging_type | ✅ | ❌ | Excluded from MVM |
| geographic_reference | country | ✅ | ✅ |  |
| geographic_reference | equipment_type | ✅ | ❌ | Excluded from MVM |
| geographic_reference | port_location | ✅ | ✅ |  |
| geographic_reference | resource | ✅ | ❌ | Excluded from MVM |
| geographic_reference | service_code | ✅ | ❌ | Excluded from MVM |
| geographic_reference | un_locode | ✅ | ✅ |  |
| trading_partners | edi_partner | ✅ | ❌ | Excluded from MVM |
| trading_partners | shipping_line | ✅ | ✅ |  |
| vessel_registry | flag_state | ✅ | ✅ |  |
| vessel_registry | vessel_master | ✅ | ✅ |  |
| vessel_registry | vessel_type | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalogue_planning | material_group | ✅ | ❌ | Domain not in MVM |
| catalogue_planning | material_master | ✅ | ❌ | Domain not in MVM |
| catalogue_planning | procurement_plan | ✅ | ❌ | Domain not in MVM |
| catalogue_planning | purchasing_info | ✅ | ❌ | Domain not in MVM |
| contract_settlement | supplier_contract | ✅ | ❌ | Domain not in MVM |
| contract_settlement | supplier_contract_item | ✅ | ❌ | Domain not in MVM |
| order_fulfilment | goods_receipt | ✅ | ❌ | Domain not in MVM |
| order_fulfilment | purchase_order | ✅ | ❌ | Domain not in MVM |
| order_fulfilment | purchase_order_item | ✅ | ❌ | Domain not in MVM |
| order_fulfilment | service_entry_sheet | ✅ | ❌ | Domain not in MVM |
| order_fulfilment | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| requisition_sourcing | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| requisition_sourcing | purchase_requisition_item | ✅ | ❌ | Domain not in MVM |
| requisition_sourcing | rfq | ✅ | ❌ | Domain not in MVM |
| requisition_sourcing | tender | ✅ | ❌ | Domain not in MVM |
| requisition_sourcing | vendor_quotation | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_bank_account | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_certification | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_commodity_approval | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_evaluation | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_service_rate_card | ✅ | ❌ | Domain not in MVM |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| emergency_preparedness | contractor_safety | ✅ | ❌ | Domain not in MVM |
| emergency_preparedness | emergency_response_participant | ✅ | ❌ | Domain not in MVM |
| emergency_preparedness | emergency_response_plan | ✅ | ❌ | Domain not in MVM |
| emergency_preparedness | kpi | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | env_monitoring_reading | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | env_monitoring_station | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | ghg_emission_record | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | iso_compliance_register | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | marpol_waste_record | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | sustainability_initiative | ✅ | ❌ | Domain not in MVM |
| hazard_control | hazard_register | ✅ | ❌ | Domain not in MVM |
| hazard_control | material_hazard_control | ✅ | ❌ | Domain not in MVM |
| hazard_control | risk_assessment | ✅ | ❌ | Domain not in MVM |
| hazard_control | risk_assessment_participant | ✅ | ❌ | Domain not in MVM |
| incident_management | inspection | ✅ | ❌ | Domain not in MVM |
| incident_management | ohs_incident | ✅ | ❌ | Domain not in MVM |
| incident_management | ohs_investigation | ✅ | ❌ | Domain not in MVM |
| incident_management | permit_to_work | ✅ | ❌ | Domain not in MVM |
| incident_management | permit_vendor_authorization | ✅ | ❌ | Domain not in MVM |
| incident_management | safety_corrective_action | ✅ | ❌ | Domain not in MVM |

<a id="domain-security"></a>
### security

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_control | access_credential | ✅ | ❌ | Domain not in MVM |
| access_control | access_event | ✅ | ❌ | Domain not in MVM |
| access_control | access_point | ✅ | ❌ | Domain not in MVM |
| access_control | patrol | ✅ | ❌ | Domain not in MVM |
| access_control | patrol_route | ✅ | ❌ | Domain not in MVM |
| access_control | personnel | ✅ | ❌ | Domain not in MVM |
| access_control | post | ✅ | ❌ | Domain not in MVM |
| access_control | visitor_log | ✅ | ❌ | Domain not in MVM |
| access_control | zone_access_authorization | ✅ | ❌ | Domain not in MVM |
| cyber_risk | cyber_incident | ✅ | ❌ | Domain not in MVM |
| cyber_risk | cyber_risk_register | ✅ | ❌ | Domain not in MVM |
| incident_investigation | investigation | ✅ | ❌ | Domain not in MVM |
| incident_investigation | security_corrective_action | ✅ | ❌ | Domain not in MVM |
| incident_investigation | security_incident | ✅ | ❌ | Domain not in MVM |
| incident_investigation | stowaway_case | ✅ | ❌ | Domain not in MVM |
| isps_compliance | dos_record | ✅ | ❌ | Domain not in MVM |
| isps_compliance | drill | ✅ | ❌ | Domain not in MVM |
| isps_compliance | facility_security_plan | ✅ | ❌ | Domain not in MVM |
| isps_compliance | marsec_level_change | ✅ | ❌ | Domain not in MVM |
| isps_compliance | security_audit | ✅ | ❌ | Domain not in MVM |
| isps_compliance | threat_assessment | ✅ | ❌ | Domain not in MVM |
| isps_compliance | zone | ✅ | ❌ | Domain not in MVM |
| surveillance_equipment | cctv_camera | ✅ | ❌ | Domain not in MVM |
| surveillance_equipment | cctv_incident_clip | ✅ | ❌ | Domain not in MVM |
| surveillance_equipment | mda_observation | ✅ | ❌ | Domain not in MVM |
| surveillance_equipment | screening_record | ✅ | ❌ | Domain not in MVM |
| surveillance_equipment | security_equipment | ✅ | ❌ | Domain not in MVM |
| surveillance_equipment | watchlist_entry | ✅ | ❌ | Domain not in MVM |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | *(no products)* | ✅ | ❌ | |

<a id="domain-tariff"></a>
### tariff

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_negotiation | negotiation | ✅ | ❌ | Excluded from MVM |
| commercial_negotiation | tariff_filing | ✅ | ❌ | Excluded from MVM |
| commercial_negotiation | tariff_version | ✅ | ❌ | Excluded from MVM |
| pricing_adjustments | applicability | ✅ | ❌ | Excluded from MVM |
| pricing_adjustments | bunker_adjustment | ✅ | ❌ | Excluded from MVM |
| pricing_adjustments | currency_adjustment | ✅ | ❌ | Excluded from MVM |
| pricing_adjustments | discount_scheme | ✅ | ✅ |  |
| pricing_adjustments | exception | ✅ | ❌ | Excluded from MVM |
| pricing_adjustments | free_time_allowance | ✅ | ❌ | Excluded from MVM |
| pricing_adjustments | pricing_rule | ✅ | ❌ | Excluded from MVM |
| pricing_adjustments | sla_rate_card | ✅ | ❌ | Excluded from MVM |
| pricing_adjustments | surcharge_rule | ✅ | ✅ |  |
| pricing_agreements | item_surcharge_applicability | ❌ | ✅ | MVM only (stub or new) |
| rate_schedules | demurrage_schedule | ✅ | ❌ | Excluded from MVM |
| rate_schedules | detention_schedule | ✅ | ❌ | Excluded from MVM |
| rate_schedules | item | ✅ | ✅ |  |
| rate_schedules | mooring_tariff | ✅ | ❌ | Excluded from MVM |
| rate_schedules | pilotage_tariff | ✅ | ❌ | Excluded from MVM |
| rate_schedules | port_dues_schedule | ✅ | ✅ |  |
| rate_schedules | port_tariff | ✅ | ✅ |  |
| rate_schedules | rate_card | ✅ | ✅ |  |
| rate_schedules | rate_card_line | ✅ | ✅ |  |
| rate_schedules | storage_tariff | ✅ | ✅ |  |
| rate_schedules | thc_schedule | ✅ | ✅ |  |
| rate_schedules | towage_tariff | ✅ | ❌ | Excluded from MVM |
| rate_schedules | wharfage_schedule | ✅ | ✅ |  |

<a id="domain-terminal"></a>
### terminal

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_services | berth_discount_application | ✅ | ❌ | Excluded from MVM |
| commercial_services | cfs_activity | ✅ | ❌ | Excluded from MVM |
| commercial_services | container_tariff_exception_application | ✅ | ❌ | Excluded from MVM |
| commercial_services | hazmat_declaration | ✅ | ❌ | Excluded from MVM |
| commercial_services | terminal | ✅ | ✅ |  |
| commercial_services | terminal_service_order | ✅ | ❌ | Excluded from MVM |
| equipment_dispatch | equipment | ❌ | ✅ | MVM only (stub or new) |
| equipment_handling | equipment_dispatch | ✅ | ✅ |  |
| equipment_handling | roro_activity | ✅ | ❌ | Excluded from MVM |
| equipment_handling | terminal_equipment | ✅ | ❌ | Excluded from MVM |
| gate_management | gate_appointment | ✅ | ✅ |  |
| gate_management | gate_lane | ✅ | ❌ | Excluded from MVM |
| gate_management | gate_transaction | ✅ | ✅ |  |
| vessel_berth | terminal_berth_allocation | ✅ | ❌ | Excluded from MVM |
| vessel_berth | vessel_bay_plan | ✅ | ✅ |  |
| vessel_services | berth_allocation | ❌ | ✅ | MVM only (stub or new) |
| yard_operations | container_damage | ✅ | ❌ | Excluded from MVM |
| yard_operations | container_visit | ✅ | ✅ |  |
| yard_operations | reefer_monitoring | ✅ | ✅ |  |
| yard_operations | yard_block | ✅ | ✅ |  |
| yard_operations | yard_slot | ✅ | ✅ |  |

<a id="domain-vessel"></a>
### vessel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agency_disbursement | agent_appointment | ✅ | ✅ |  |
| agency_disbursement | service_agreement | ✅ | ❌ | Excluded from MVM |
| compliance_documentation | call_document | ✅ | ❌ | Excluded from MVM |
| compliance_documentation | certificate | ✅ | ✅ |  |
| compliance_documentation | isps_record | ✅ | ❌ | Excluded from MVM |
| compliance_documentation | psc_inspection | ✅ | ✅ |  |
| compliance_documentation | waste_declaration | ✅ | ❌ | Excluded from MVM |
| crew_surveys | bunker_operation | ✅ | ❌ | Excluded from MVM |
| crew_surveys | call_inspection | ✅ | ❌ | Excluded from MVM |
| crew_surveys | crew_list | ✅ | ❌ | Excluded from MVM |
| crew_surveys | draft_survey | ✅ | ❌ | Excluded from MVM |
| fleet_registry | agency_appointment | ✅ | ❌ | Excluded from MVM |
| fleet_registry | call_schedule | ✅ | ✅ |  |
| fleet_registry | charter | ✅ | ❌ | Excluded from MVM |
| fleet_registry | deployment | ✅ | ❌ | Excluded from MVM |
| fleet_registry | owner | ✅ | ✅ |  |
| fleet_registry | service_route | ✅ | ❌ | Excluded from MVM |
| fleet_registry | vessel | ✅ | ✅ |  |
| fleet_registry | voyage | ✅ | ✅ |  |
| port_operations | anchorage | ✅ | ❌ | Excluded from MVM |
| port_operations | call | ✅ | ✅ |  |
| port_operations | call_assignment | ✅ | ❌ | Excluded from MVM |
| port_operations | call_icd_allocation | ✅ | ❌ | Excluded from MVM |
| port_operations | movement | ✅ | ✅ |  |
| port_operations | port_call | ✅ | ✅ |  |
| port_operations | vts_log | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_relations | calibration_session | ✅ | ❌ | Domain not in MVM |
| employee_relations | disciplinary_case | ✅ | ❌ | Domain not in MVM |
| employee_relations | grievance_case | ✅ | ❌ | Domain not in MVM |
| employee_relations | labour_agreement | ✅ | ❌ | Domain not in MVM |
| employee_relations | mlc_compliance_record | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | headcount_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payslip | ✅ | ❌ | Domain not in MVM |
| personnel_records | employee | ✅ | ❌ | Domain not in MVM |
| personnel_records | medical_fitness | ✅ | ❌ | Domain not in MVM |
| personnel_records | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_records | pilot_licence | ✅ | ❌ | Domain not in MVM |
| personnel_records | position | ✅ | ❌ | Domain not in MVM |
| stevedore_operations | gang | ✅ | ❌ | Domain not in MVM |
| stevedore_operations | gang_assignment | ✅ | ❌ | Domain not in MVM |
| stevedore_operations | leave_request | ✅ | ❌ | Domain not in MVM |
| stevedore_operations | roster | ✅ | ❌ | Domain not in MVM |
| stevedore_operations | shift_pattern | ✅ | ❌ | Domain not in MVM |
| stevedore_operations | time_attendance | ✅ | ❌ | Domain not in MVM |
| talent_development | competency | ✅ | ❌ | Domain not in MVM |
| talent_development | employee_certification | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | position_competency_requirement | ✅ | ❌ | Domain not in MVM |
| talent_development | talent_profile | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_enrolment | ✅ | ❌ | Domain not in MVM |
