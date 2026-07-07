# Restaurants Lakehouse Data Model

**v2_ecm** generated using Vibe Modelling Agent on July 02, 2026 at 02:40 AM

This document outlines a vibed Lakehouse data model for the Restaurants business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Foodsafety](#domain-foodsafety)
  - [Inventory](#domain-inventory)
  - [Order](#domain-order)
  - [Restaurant](#domain-restaurant)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)
  - [Franchise](#domain-franchise)
  - [Guest](#domain-guest)
  - [Loyalty](#domain-loyalty)
  - [Menu](#domain-menu)
  - [Finance](#domain-finance)
  - [Marketing](#domain-marketing)
  - [Procurement](#domain-procurement)
  - [Realestate](#domain-realestate)
- [Metric Views](#metric-views)

## Output Folder Structure

All artifacts for version **v2_ecm** are organized as follows:

```
v2/ecm/
  schemas/          DDL SQL files (one per domain)
  metrics/          Metric view SQL files (one per domain)
  samples/          Sample data CSV files (one per data product)
  docs/             Excel workbook, model CSV, release notes
  diagram/          DBML schema
  vibes/            Current & next vibes context
  ontology/         RDF/Turtle ontology schema
  model.json        Full model with requirements, metadata, and model data
  readme.md         This file
```

| Folder | Contents |
|---|---|
| `schemas/` | `restaurants_<domain>_schema_v2_ecm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `restaurants_catalogs_v2_ecm.sql` (catalog-level DDL) |
| `metrics/` | `restaurants_<domain>_metrics_v2_ecm.sql` (one file per domain) |
| `docs/` | `restaurants_model_v2_ecm.xlsx`, `restaurants_model_v2_ecm.csv`, `releasenotes.txt` |
| `diagram/` | `restaurants_dbml_v2_ecm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `restaurants_rdf_v2_ecm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | ECM (Expanded Coverage Model) |
| Total Domains | 14 |
| Total Subdomains | 55 |
| Total Products | 289 |
| Total Attributes | 9602 |
| Primary Keys | 289 |
| Foreign Keys | 1161 |
| Avg Attributes/Product | 33.2 |
| Metric Views | 163 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Restaurants | Restaurants | ECM (Expanded Coverage Model) | restaurants industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-foodsafety"></a>

### Domain: Foodsafety

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| foodsafety | operations | 6 | Governs HACCP plan management, food safety audit results, health inspection records, corrective action tracking, temperature monitoring logs, sanitation schedules, allergen management, and SOP compliance via Zenput. Ensures adherence to FDA FSMA, local health department requirements, ISO 22000, and ServSafe standards across all restaurant units. | 22 |

**Subdomains:** allergen_incident, audit_compliance, hazard_control, recall_response, sanitation_monitoring, training_certification


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| allergen_incident | allergen_incident |  | Allergen-related incidents including guest reactions and cross-contamination events | 41 |
| allergen_incident | foodsafety_allergen_profile |  | Allergen profiles for ingredients and menu items documenting allergen presence and cross-contact risks | 32 |
| allergen_incident | illness_report |  | Reports of foodborne illness or employee illness that may impact food safety | 32 |
| audit_compliance | audit_finding |  | Individual findings from food safety audits | 21 |
| audit_compliance | food_safety_audit |  | Food safety audits conducted at restaurant units or supplier facilities | 29 |
| audit_compliance | foodsafety_corrective_action |  | Corrective actions taken in response to food safety findings, deviations, or non-conformances | 33 |
| audit_compliance | health_inspection |  | Health department inspections of restaurant units | 34 |
| audit_compliance | inspection_violation |  | Individual violations found during health inspections | 25 |
| hazard_control | critical_control_point |  | Critical control points within HACCP plans where hazards can be prevented or eliminated | 29 |
| hazard_control | haccp_plan |  | HACCP (Hazard Analysis Critical Control Points) plan documents for food safety management | 38 |
| recall_response | food_recall |  | Food recall events initiated by suppliers, manufacturers, or regulatory agencies | 37 |
| recall_response | recall_unit_response |  | Individual restaurant unit responses to food recall events | 34 |
| recall_response | receiving_inspection |  | Food safety inspections performed during goods receiving | 30 |
| sanitation_monitoring | environmental_monitoring |  | Environmental monitoring samples and test results for pathogen detection | 31 |
| sanitation_monitoring | pest_control_log |  | Log of pest control services and inspections at restaurant units | 30 |
| sanitation_monitoring | sanitation_schedule |  | Sanitation schedules defining cleaning tasks, frequencies, and responsibilities | 33 |
| sanitation_monitoring | sanitation_task_log |  | Log of completed sanitation tasks with results and verification | 32 |
| sanitation_monitoring | temperature_log |  | Temperature readings for food safety monitoring of equipment and storage areas | 29 |
| training_certification | food_safety_certification |  | Food safety certifications held by employees | 24 |
| training_certification | food_safety_training |  | Food safety training records for employees | 18 |
| training_certification | foodsafety_supplier_certification |  | Food safety certifications held by suppliers (e.g., SQF, BRC, FSSC 22000) | 24 |
| training_certification | sop_document |  | Standard Operating Procedure documents for food safety processes | 26 |

<a id="domain-inventory"></a>

### Domain: Inventory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| inventory | operations | 3 | Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units. | 17 |

**Subdomains:** cost_analysis, item_management, stock_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| cost_analysis | food_cost_period | transactional_data | Periodic food cost calculations for restaurant units including actual vs theoretical cost, variance analysis, and COGS percentages. | 38 |
| cost_analysis | inventory_ingredient_usage | association_data | Aggregated ingredient usage records linking inventory consumption to orders, tracking actual vs theoretical usage and variances. | 25 |
| cost_analysis | prep_usage | transactional_data | Records of ingredient usage during food preparation, tracking actual vs theoretical consumption and variances. | 37 |
| cost_analysis | yield_record | transactional_data | Records of ingredient yield from prep activities, tracking actual vs standard yield and associated costs. | 36 |
| item_management | item_category | master_data | Hierarchical categorization of inventory items with associated management parameters and compliance requirements. | 49 |
| item_management | lot_tracking | master_data | Lot-level tracking of inventory for traceability, recall management, and HACCP compliance. | 42 |
| item_management | on_hand_balance | master_data | Current on-hand inventory balance for each stock item at each location, including valuation and par-level tracking. | 37 |
| item_management | stock_item | master_data | Master record for each stockable item tracked in restaurant inventory including allergen flags, storage requirements, and reorder parameters. | 46 |
| item_management | stock_location | master_data | Physical storage locations within restaurants, distribution centers, or facilities where inventory is held. | 40 |
| item_management | uom | reference_data | Unit of measure reference table with conversion factors, categorization, and applicability flags. | 30 |
| item_management | vendor_item | master_data | Mapping of stock items to vendor/supplier catalog items including pricing, lead times, and ordering parameters. | 42 |
| stock_operations | inventory_adjustment | transactional_data | Records of inventory quantity adjustments including reason codes, approval workflow, and financial impact. | 45 |
| stock_operations | physical_count | transactional_data | Physical inventory count events performed at restaurant units, tracking count results, variances, and GL postings. | 34 |
| stock_operations | receiving_order | transactional_data | Records of goods received at a restaurant unit or facility, including quality checks and temperature verification. | 38 |
| stock_operations | replenishment_order | transactional_data | Orders placed to replenish inventory at restaurant units, including approval workflow and delivery tracking. | 43 |
| stock_operations | stock_transfer | transactional_data | Records of inventory transfers between locations, units, or facilities including shipping and quality inspection details. | 42 |
| stock_operations | waste_log | transactional_data | Records of inventory waste events including reason, quantity, cost impact, and HACCP compliance. | 38 |

<a id="domain-order"></a>

### Domain: Order

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| order | operations | 3 | Core transactional domain managing order capture, fulfillment, and delivery across all service channels including POS (Oracle MICROS), drive-thru (DT), online ordering (OLO), third-party delivery (3PD), and catering. Tracks order lifecycle, KDS routing, ticket time, speed of service (SOS), average transaction count (ATC), and average check value (ACV). | 18 |

**Subdomains:** catering_services, fulfillment_channels, transaction_core


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| catering_services | catering_order | transactional_data | Catering order with event details, headcount, and delivery logistics. | 45 |
| catering_services | catering_package | master_data | Pre-configured catering package template with pricing and constraints. | 25 |
| catering_services | sos_target | reference_data | Speed-of-service target configuration by channel, daypart, and format. | 33 |
| fulfillment_channels | channel | reference_data | Order channel reference (dine-in, drive-thru, OLO, delivery, etc.). | 27 |
| fulfillment_channels | daypart | reference_data | Time-window definition for restaurant operations (breakfast, lunch, dinner, late-night). | 19 |
| fulfillment_channels | delivery_order | transactional_data | Delivery-specific details for an order fulfilled via delivery. | 42 |
| fulfillment_channels | delivery_platform | master_data | Third-party delivery platform reference (e.g., DoorDash, UberEats). | 17 |
| fulfillment_channels | drive_thru_event | transactional_data | Sensor-based event capturing vehicle progression through drive-thru lanes. | 30 |
| fulfillment_channels | kds_ticket | transactional_data | Kitchen display system ticket tracking preparation of an order. | 30 |
| transaction_core | discount | transactional_data | Discount applied to an order or order item. | 39 |
| transaction_core | guest_order | transactional_data | Core order transaction capturing a guest purchase at a restaurant unit. | 53 |
| transaction_core | order_ingredient_usage | association_data | Ingredient consumption record tied to an order item for food cost and waste tracking. | 21 |
| transaction_core | order_item | transactional_data | Individual line item within a guest order. | 45 |
| transaction_core | order_modifier | transactional_data | Modifier applied to an order item such as add-ons, substitutions, or removals. | 40 |
| transaction_core | payment | transactional_data | Payment tendered against a guest order. | 46 |
| transaction_core | refund | transactional_data | Refund issued against a guest order. | 42 |
| transaction_core | status_event | transactional_data | State transition event in the order lifecycle. | 41 |
| transaction_core | tax | transactional_data | Tax line applied to a guest order. | 40 |

<a id="domain-restaurant"></a>

### Domain: Restaurant

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| restaurant | operations | 3 | Master record for every restaurant unit — company-owned and franchised — including location attributes, format (QSR/casual/fine-dining), FOH/BOH configuration, operating hours, daypart schedules, equipment, throughput capacity, speed-of-service (SOS) benchmarks, table turns, cover counts, AUV, SSS, and comp sales. Operational anchor for brand standards and SOPs. | 24 |

**Subdomains:** facility_management, operational_performance, unit_identity


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| facility_management | checklist_template | master_data | Master reference table for checklist_template. Referenced by checklist_template_id. | 43 |
| facility_management | ops_visit | transactional_data | Records operational field visits conducted by area managers, brand consultants, or corporate operations teams at each restaurant unit. Captures visit date, visit type (scheduled, unannounced, follow-up, NRO opening support), visitor name and role, overall visit score, sub-scores by category (food quality, cleanliness, service, speed, safety), critical findings count, corrective actions required flag, and follow-up visit scheduled date. Sourced from Zenput operational compliance platform. | 39 |
| facility_management | ops_visit_finding | transactional_data | Line-item findings recorded during an operational field visit at a restaurant unit. Each record captures the parent visit reference, finding category (food safety, cleanliness, equipment, service, brand standard, labor), finding description, severity level (critical, major, minor, observation), brand standard violated, corrective action required, corrective action due date, corrective action completed flag, and completion date. Enables granular compliance gap tracking and repeat-finding trend analysis. | 38 |
| facility_management | renovation_project | transactional_data | Tracks restaurant unit renovation, remodel, and refresh projects including project type (full remodel, refresh, equipment upgrade, ADA retrofit, brand reimaging), project status (planned, approved, in-progress, completed, cancelled), planned start date, actual start date, planned completion date, actual completion date, estimated CapEx, actual CapEx, contractor name, closure duration (days), and expected AUV lift post-renovation. Coordinates with realestate domain for facility management and finance domain for CapEx tracking. | 43 |
| facility_management | store_campaign_assignment | association_data | Represents the assignment of a marketing campaign to a specific restaurant unit. Each record captures spend, performance, compliance, and other campaign‑specific attributes that exist only in the context of that unit‑campaign pairing.. Existence Justification: A restaurant unit can participate in multiple marketing campaigns, and each campaign is executed across many units. The business actively tracks per‑unit spend, performance metrics, compliance flags, and other campaign‑specific details, making the relationship a managed entity rather than a simple reference. | 34 |
| operational_performance | brand_standard | master_data | Defines the brand standards and SOPs (Standard Operating Procedures) applicable to each restaurant unit by concept type and ownership model. Captures standard code, standard name, standard category (food quality, cleanliness, service, safety, brand presentation), applicable format (QSR/casual/fine-dining), compliance requirement level (mandatory/recommended), effective date, expiry date, governing body reference (NRA, FDA, OSHA), and linked SOP document reference. Operational anchor for audit and compliance workflows. | 32 |
| operational_performance | equipment_asset | master_data | Inventory of all BOH and FOH equipment assets installed at each restaurant unit including all equipment types (fryer, grill, oven, KDS stations, POS terminals, refrigeration units, ice machines, espresso machines, drive-thru timers). Captures make, model, serial number, installation date, warranty expiry, last service date, next scheduled maintenance date, asset condition rating, replacement cost, software version (for digital equipment), and equipment-specific configuration attributes. Supports R&M (Repairs and Maintenance) planning, CapEx forecasting, PCI DSS compliance for payment terminals, and food safety compliance for temperature-critical equipment. | 41 |
| operational_performance | kitchen_station | master_data | Master reference table for kitchen_station. Referenced by station_id. | 45 |
| operational_performance | performance_period | master_data | Master reference table for performance_period.  | 42 |
| operational_performance | pos_terminal | master_data | Master reference table for pos_terminal. Referenced by: loyalty.offer_redemption.pos_terminal_id, loyalty.payment_method_link.pos_terminal_id, loyalty.redemption.pos_terminal_id, loyalty.visit.pos_terminal_id, order.drive_thru_event.pos_terminal_id | 62 |
| operational_performance | sos_measurement | transactional_data | Transactional records of actual speed-of-service (SOS), throughput measurements, and table turn events captured per service event at each restaurant unit across all channels. For drive-thru/counter/kiosk/OLO: captures measurement timestamp, service channel, daypart, order-to-ready time, order-to-delivery time, ticket time, queue wait time, and measurement source (POS timer, KDS, sensor). For dine-in table service: captures table identifier, cover count, seating time, order-placed time, food-delivered time, check-presented time, table-cleared time, total turn time, server station, party size, and table status transitions. This is the single source of truth for all operational timing and throughput measurements across every service model. Enables unified SOS trend analysis, table turn rate optimization, cover count tracking, FOH throughput benchmarking, and benchmark gap identification. | 29 |
| operational_performance | table_turn_log | transactional_data | Transactional log of table turn events at each restaurant unit capturing table identifier, cover count seated, seating time, order-placed time, food-delivered time, check-presented time, table-cleared time, total turn time (minutes), daypart, server station, and party size. Enables table turn rate analysis, cover count optimization, and FOH throughput benchmarking for casual and fine-dining formats. | 40 |
| operational_performance | throughput_benchmark | master_data | Defines throughput capacity benchmarks and speed-of-service (SOS) targets for each restaurant unit by service channel (DT drive-thru, counter, OLO online, 3PD third-party delivery) and daypart. Captures target ticket time (seconds), target throughput (covers/hour or transactions/hour), ADT (Average Daily Transactions) target, ATC (Average Transaction Count) target, ACV (Average Check Value) target, table turn target (minutes), and cover count capacity. Used for operational performance benchmarking and SOS compliance. | 33 |
| operational_performance | unit_performance | transactional_data | Periodic operational and financial performance record for each restaurant unit capturing AUV (Average Unit Volume), SSS (Same-Store Sales) growth %, comp sales (Comparable Store Sales) vs. prior period, ADT (Average Daily Transactions), ATC (Average Transaction Count), ACV (Average Check Value), COGS% (Cost of Goods Sold Percentage), Labor% (Labor Cost Percentage), Waste% (Food Waste Percentage), EBITDA, and net revenue. Sourced from Oracle MICROS POS and SAP S/4HANA. Primary performance scorecard for unit-level P&L management. | 36 |
| unit_identity | area_management | master_data | Defines the operational management hierarchy above the restaurant unit level. Captures area/district/region boundaries, area manager assignment (name, employee ID, assignment effective dates), number of units in area, geographic region, division, brand, and area performance targets (AUV target, SSS target, CSAT target, Labor% target). Supports multi-unit management accountability, area manager performance reviews, regional performance rollups, and franchise territory alignment. One row per area/district assignment period. | 34 |
| unit_identity | brand | master_data | Master reference table for brand. Referenced by brand_id. | 47 |
| unit_identity | capacity_config | master_data | Defines the seating and service capacity configuration for each restaurant unit including total indoor seating capacity, outdoor/patio seating capacity, bar seating count, private dining room capacity, drive-thru stacking capacity (number of vehicles), kiosk count, counter service positions, maximum cover count per daypart, and ADA-compliant seating count. Used for throughput planning, labor staffing ratios, and health department permit compliance. | 33 |
| unit_identity | department | master_data | Organizational departments within a restaurant unit (kitchen, front-of-house, drive-thru); used for operational management. | 41 |
| unit_identity | format_config | master_data | Defines the operational format, physical configuration, and total capacity of a restaurant unit. Includes dining format (QSR, fast-casual, casual, fine-dining), service model (counter, table, drive-thru, kiosk), FOH layout (total indoor seating capacity, outdoor/patio seating capacity, bar seating count, private dining room capacity, ADA-compliant seating count, table count, cover count), BOH layout (kitchen footprint sq ft, cooking lines, prep stations), drive-thru configuration (lane count, stacking capacity for vehicles), kiosk count, counter service positions, and maximum cover count per daypart. This is the single source of truth for all physical capacity and layout attributes of a unit — governs brand standard compliance, throughput benchmarking, labor staffing ratios, health department permit compliance, and fire marshal occupancy limits. | 38 |
| unit_identity | location_profile | master_data | Physical and geographic attributes of each restaurant unit including full street address, city, state, province, postal code, country, DMA (Designated Market Area), trade area classification, latitude/longitude, timezone, locale, accessibility features, parking capacity, drive-thru lane count, patio seating availability, and proximity to key landmarks. Supports site analytics, delivery radius configuration, and regional reporting. | 43 |
| unit_identity | operating_hours | master_data | Scheduled operating hours for each restaurant unit by day of week and daypart (breakfast, lunch, dinner, late-night, 24hr). Captures open time, close time, daypart start/end times, holiday schedule overrides, seasonal hour adjustments, drive-thru-specific hours, delivery window hours, and last-order cutoff times. Used for order routing, labor scheduling, and SSS (Same-Store Sales) period alignment. | 37 |
| unit_identity | unit | master_data | Master record for every restaurant unit — company-owned and franchised. The authoritative identity of each physical location including unit number, brand, concept type (QSR/casual/fine-dining), ownership model (company-owned vs. franchised), legal entity name, trade name, opening date, closure date, current operational status, and geographic coordinates. This is the operational anchor for the entire restaurant domain and the primary FK target for all cross-domain joins (order, inventory, workforce, finance, franchise). One row per physical restaurant location. All other restaurant domain products reference this entity. | 53 |
| unit_identity | unit_ownership | master_data | Tracks the ownership and operational control history of each restaurant unit including ownership type (company-owned, franchised, licensed, joint-venture), franchise partner reference, ownership effective start date, ownership effective end date, transfer reason (new franchise award, resale, corporate acquisition, closure), and operating entity legal name. Provides the authoritative ownership timeline for royalty calculation, P&L attribution, and franchise compliance reporting. Complements the franchise domain without duplicating franchise partner master data. | 39 |
| unit_identity | unit_status_history | transactional_data | Tracks the full lifecycle status history of each restaurant unit including status transitions (active, temporarily closed, permanently closed, under renovation, pre-opening, soft-open, NRO new restaurant opening), effective date of each status change, reason code, change initiated by (franchise partner, corporate operations, health department), and expected reopen date where applicable. Provides audit trail for unit lifecycle management and SSS eligibility determination. | 32 |

<a id="domain-supply"></a>

### Domain: Supply

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| supply | operations | 4 | Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement. | 17 |

**Subdomains:** ingredient_catalog, logistics_network, procurement_operations, supplier_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| ingredient_catalog | ingredient | master_data | Master catalog of ingredients used in restaurant recipes and menu items. | 38 |
| ingredient_catalog | ingredient_lot | master_data | Lot-level tracking of ingredients for traceability, quality, and recall management. | 34 |
| ingredient_catalog | quality_inspection | transactional_data | Quality inspections performed on received ingredients and supplies. | 25 |
| ingredient_catalog | recall_event | transactional_data | Product and ingredient recall events tracking affected items, severity, and resolution. | 28 |
| logistics_network | distribution_center | master_data | Physical distribution centers and warehouses that store and ship ingredients to restaurant units. | 31 |
| logistics_network | inbound_shipment | transactional_data | Tracking of inbound shipments from suppliers to distribution centers or restaurant units. | 34 |
| procurement_operations | goods_receipt | transactional_data | Header record for receiving goods against a purchase order at a restaurant or distribution center. | 24 |
| procurement_operations | goods_receipt_line | transactional_data | Line-level detail for goods received, including quantity, quality, and cost information. | 29 |
| procurement_operations | invoice | transactional_data | Supplier invoices received for goods and services, linked to POs and goods receipts for three-way matching. | 20 |
| procurement_operations | purchase_order_line | transactional_data | Individual line items on a supply purchase order specifying ingredient, quantity, and price. | 19 |
| procurement_operations | supply_purchase_order | transactional_data | Purchase orders placed with suppliers for ingredients and supplies. | 24 |
| supplier_management | commodity_category | master_data | Hierarchical classification of commodities for spend analysis, sourcing strategy, and supplier categorization. | 25 |
| supplier_management | contract_price | master_data | Price schedules within supplier contracts, supporting tiered and time-bound pricing. | 18 |
| supplier_management | supplier_contract | master_data | Detailed contract records with suppliers including pricing, terms, compliance, and renewal information. | 36 |
| supplier_management | supplier_performance | transactional_data | Periodic performance measurements for suppliers covering delivery, quality, and compliance metrics. | 21 |
| supplier_management | supply_contract | association_data | Supply-specific contracts linking suppliers to sites/categories with pricing and delivery terms. | 20 |
| supplier_management | supply_supplier | master_data | Master record for suppliers providing ingredients and goods to the restaurant supply chain. | 28 |

<a id="domain-workforce"></a>

### Domain: Workforce

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| workforce | operations | 3 | Manages employee lifecycle including recruiting, onboarding, scheduling, time and attendance, labor forecasting, Labor% optimization, FTE tracking, certifications (ServSafe), performance management, and payroll integration via Workday HCM and Planday. Optimizes labor deployment across dayparts, BOH/FOH staffing ratios, and restaurant locations. | 20 |

**Subdomains:** employee_management, labor_scheduling, payroll_compliance


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| employee_management | certification | master_data | Single source of truth for all employee learning credentials, training completions, and regulatory certifications required for foodservice operations. Covers external certifications (ServSafe Food Handler, ServSafe Manager, allergen awareness, HACCP, alcohol service permits, OSHA safety) and internal training completions (new hire orientation, food safety modules, POS/KDS operation, BOH/FOH SOPs, LTO product training, management development). Captures credential type, issuing body (NRA ServSafe, local health department, internal L&D), delivery method (in-person, e-learning, OJT), issue/completion date, expiration date, assessment score, trainer/facilitator, and compliance status. Critical for food safety regulatory compliance, health department inspections, scheduling eligibility validation, and employee development tracking. | 19 |
| employee_management | employee | master_data | Master record for every restaurant employee across company-owned and franchised locations. Captures full employee lifecycle data including personal details, employment type (FTE/PTE), BOH/FOH role classification, hire date, termination date, employment status, pay grade, home restaurant assignment, Workday HCM employee ID, declared availability windows (preferred dayparts, max weekly hours, blackout dates, cross-location availability), and current benefit enrollment summary. Single source of truth for workforce identity and worker profile across the enterprise. | 41 |
| employee_management | leave_request | transactional_data | Tracks employee requests for time off including vacation, sick leave, FMLA, personal days, and unpaid leave. Captures request type, requested dates, approved dates, leave balance consumed, approval status, approving manager, and return-to-work date. Integrates with Planday scheduling to flag coverage gaps and trigger backfill shift assignments. | 24 |
| employee_management | onboarding | transactional_data | Tracks the onboarding process for newly hired employees, including completion status of required tasks (I-9 verification, food handler card submission, uniform issuance, POS system access provisioning, ServSafe enrollment), onboarding start/end dates, assigned onboarding buddy, and manager sign-off. Ensures compliance with FDA food safety and OSHA workplace safety requirements at point of hire. | 30 |
| employee_management | performance_review | transactional_data | Captures all formal employee performance and conduct events including scheduled evaluations (90-day, annual), corrective actions (verbal warnings, written warnings, PIPs, suspensions), and promotion assessments. Records event type, overall rating, competency scores (speed, accuracy, guest service, food safety adherence), infraction details where applicable, reviewer identity, review period, development goals, progressive discipline step, and acknowledgment status. Sourced from Workday HCM Performance module. Serves as the single record of all formal employee assessments for both development and legal compliance. | 39 |
| employee_management | position | master_data | Defines authorized job positions within the restaurant organization, including role title (e.g., Crew Member, Shift Lead, Kitchen Manager, FOH Supervisor), BOH/FOH classification, pay band, FLSA exemption status, required certifications (e.g., ServSafe), FTE equivalency factor, and whether the position is eligible for overtime. Serves as the job catalog for workforce planning and scheduling. | 27 |
| employee_management | recruitment | transactional_data | Tracks the full recruiting lifecycle for open positions across restaurant locations, including job requisition details, posting channels, candidate information (demographics, source, experience, availability), interview stages, offer status, and time-to-fill metrics. Captures both the requisition workflow and candidate pipeline in a single record per applicant-requisition combination. Sourced from Workday HCM Recruiting module. Supports NRO staffing ramp-up planning, turnover backfill management, diversity hiring tracking, and talent pipeline analytics. | 32 |
| employee_management | training_completion | transactional_data | Records completion of training programs by employees, including new hire orientation, food safety modules, POS operation, KDS usage, BOH/FOH SOPs, LTO product training, and management development programs. Captures training program name, delivery method (in-person, e-learning, OJT), completion date, assessment score, and trainer/facilitator. Supports compliance tracking and performance development. | 25 |
| employee_management | workforce_department | master_data | Workforce departments for labor scheduling, payroll allocation, and HR organizational structure. [SSOT: canonical source is restaurant.department] | 18 |
| labor_scheduling | labor_forecast | master_data | Projected labor demand by restaurant, daypart, and week based on historical transaction volume (ADT/ATC), seasonal patterns, and planned promotions or LTOs. Captures forecasted cover count, expected throughput, recommended FTE count by BOH/FOH, projected Labor%, and the forecasting model version used. Drives Planday schedule generation and labor budget alignment. | 24 |
| labor_scheduling | labor_violation | transactional_data | Records instances of labor compliance violations detected during operations, including missed meal/rest breaks, overtime threshold breaches, minor labor law violations (under-18 hour restrictions), predictive scheduling violations (where applicable), tip credit violations (failure to meet minimum wage with tips, improper tip pool inclusions), scheduling conflicts with certified food handler requirements, and OSHA-reportable workplace incidents. Captures violation type, severity, regulatory framework violated (FLSA, OSHA, state labor code), restaurant location, employee affected, detection source (automated time system, manager report, employee complaint), remediation deadline, and corrective action taken. Supports OSHA 300 log maintenance, DOL Wage & Hour Division audit responses, and state labor board compliance reporting. | 27 |
| labor_scheduling | schedule | master_data | Weekly or period-level labor schedule published for a restaurant location, representing the planned staffing plan across all dayparts. Captures schedule period (start/end dates), restaurant unit, total scheduled hours, scheduled Labor%, FTE count by daypart, publication status (draft/published/locked), and the manager who approved the schedule. Links to individual shifts for granular staffing detail. | 25 |
| labor_scheduling | scheduling_template | master_data | Master reference table for scheduling_template. Referenced by labor_scheduling_template_id. | 20 |
| labor_scheduling | shift | transactional_data | Represents a scheduled work shift for an employee at a specific restaurant location, daypart (breakfast, lunch, dinner, late-night), and station assignment (grill, fry, drive-thru, expo, host, bar, dish). Captures planned start/end times, actual clock-in/clock-out times, assigned BOH/FOH station, shift type (regular, overtime, on-call, training), break duration, scheduling source (Planday), and swap/coverage details (original assignee, covering employee, swap request reason, swap approval status, approval timestamp) when shift reassignment occurs. Core operational record for labor deployment, station coverage planning, Speed of Service (SOS) staffing optimization, and Planday shift coverage workflows. | 28 |
| labor_scheduling | time_entry | transactional_data | Captures actual clock-in and clock-out events for each employee per shift, sourced from Workday HCM time tracking or POS-integrated time clocks. Records regular hours, overtime hours, break time, missed punch flags, and manager approval status. Foundation for payroll processing, Labor% calculation, and compliance with FLSA/OSHA labor regulations. | 29 |
| payroll_compliance | labor_budget | master_data | Period-level labor budget targets by restaurant location, capturing budgeted Labor%, budgeted total labor dollars, budgeted FTE count by BOH/FOH, budgeted hours by daypart, budgeted SPLH (Sales Per Labor Hour), and the fiscal period. Serves as the financial target against which actual labor spend (from payroll_record and time_entry) and forecasted demand (from labor_forecast) are measured. Supports P&L management, AUV optimization, and manager accountability for labor cost control. | 34 |
| payroll_compliance | payroll_group | master_data | Master reference table for payroll_group. Referenced by payroll_group_id. | 19 |
| payroll_compliance | payroll_record | transactional_data | Period-level payroll summary for each employee, capturing gross pay, net pay, regular hours paid, overtime hours paid, tips declared, deductions (benefits, taxes, garnishments), pay period dates, and payroll run status. Sourced from Workday HCM payroll module. Serves as the authoritative payroll transaction record for finance integration and Labor% reporting. | 39 |
| payroll_compliance | payroll_run | master_data | Master reference table for payroll_run. Referenced by payroll_run_id. | 27 |
| payroll_compliance | tip_compliance | master_data | Tracks tip pooling arrangements, tip credit elections, tip sharing ratios, and employee-level tip declarations required for DOL FLSA §3(m) compliance. Captures tip pool participant roster, contribution percentages, distribution method (hours-based, points-based), tip credit amount claimed per pay period, employee tip declaration forms, and audit trail for tip pool changes. Supports compliance with federal and state tip credit regulations, tip pooling legality verification (front-of-house vs back-of-house eligibility per 2021 DOL final rule), and provides evidence for DOL Wage & Hour Division audits. | 50 |

<a id="domain-franchise"></a>

### Domain: Franchise

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| franchise | business | 5 | SSOT for franchise partner identity, FDD agreements, territory management, royalty rate calculations, franchise fees, compliance tracking, NRO (New Restaurant Opening) pipeline, franchisee performance metrics, and development lifecycle via FranConnect. Ensures adherence to brand standards, IFA best practices, and FTC Franchise Rule. | 22 |

**Subdomains:** agreement_lifecycle, compliance_support, development_operations, financial_reporting, partner_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| agreement_lifecycle | fee_schedule | transactional_data | Fee schedules defining the various fees (royalty, marketing, technology) applicable to franchise agreements. | 34 |
| agreement_lifecycle | lease_agreement | association_data | Lease agreements for franchise restaurant locations linking franchisees to their real estate leases. | 30 |
| agreement_lifecycle | renewal_event | transactional_data | Renewal events tracking the renewal of franchise agreements including terms, fees, and compliance review. | 23 |
| agreement_lifecycle | termination_event | transactional_data | Termination events recording the termination of franchise agreements including reason, notice, and financial obligations. | 23 |
| agreement_lifecycle | transfer_event | transactional_data | Transfer events recording the transfer of franchise ownership from one franchisee to another. | 31 |
| compliance_support | compliance_audit | transactional_data | Compliance audits conducted on franchise locations to assess adherence to brand standards, food safety, and operational requirements. | 24 |
| compliance_support | franchise_corrective_action | transactional_data | Corrective actions issued to franchisees as a result of compliance audits, requiring remediation of identified issues. | 29 |
| compliance_support | support_visit | transactional_data | Support visits conducted by franchise consultants to franchisee locations for operational support, training, and compliance review. | 33 |
| compliance_support | training_enrollment | transactional_data | Training enrollments for franchise employees tracking required training programs, completion, and certification. | 22 |
| development_operations | development_schedule | master_data | Development schedule defining the committed timeline for opening new franchise units within a territory. | 22 |
| development_operations | franchise_remodel_project | transactional_data | Remodel projects for franchise restaurant units tracking scope, budget, timeline, and completion status. | 27 |
| development_operations | nro_pipeline | transactional_data | New Restaurant Opening pipeline tracking projects from site selection through grand opening. | 39 |
| financial_reporting | billing | transactional_data | Franchise billing records representing invoices sent to franchisees for royalties, marketing fees, and technology fees. | 28 |
| financial_reporting | marketing_fund_contribution | transactional_data | Marketing fund contributions collected from franchisees based on gross sales for cooperative advertising and brand marketing. | 29 |
| financial_reporting | performance_scorecard | transactional_data | Performance scorecards evaluating franchisee performance across multiple dimensions including sales, compliance, and customer satisfaction. | 24 |
| financial_reporting | sales_report | transactional_data | Periodic sales reports submitted by franchisees to the franchisor for royalty calculation and performance tracking. | 30 |
| partner_management | agreement | master_data | A franchise agreement governing the relationship between franchisor and franchisee including terms, fees, and obligations. | 29 |
| partner_management | area_representative | master_data | Area representatives who manage and support franchisees within assigned territories on behalf of the franchisor. | 30 |
| partner_management | fdd_disclosure | transactional_data | Franchise Disclosure Document (FDD) records tracking the delivery and acknowledgment of disclosure documents to prospects. | 24 |
| partner_management | franchisee | master_data | A franchisee entity representing an individual or organization that operates one or more franchise restaurant units under a franchise agreement. | 38 |
| partner_management | prospect | master_data | Franchise prospects representing potential franchisees in the sales pipeline from initial inquiry through approval. | 41 |
| partner_management | territory | master_data | A geographic territory assigned to a franchisee defining the exclusive or protected area for franchise operations. | 30 |

<a id="domain-guest"></a>

### Domain: Guest

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| guest | business | 3 | Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves. | 23 |

**Subdomains:** engagement_insights, feedback_analytics, identity_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| engagement_insights | consent_policy |  | Consent policies defining data processing rules and permissions | 27 |
| engagement_insights | consent_record |  | Records of guest consent for marketing, data processing, and privacy | 28 |
| engagement_insights | guest_allergen_profile |  | Guest allergen profiles for food safety and personalization | 34 |
| engagement_insights | guest_segment |  | Guest segments for targeted marketing and personalization | 36 |
| engagement_insights | guest_segment_membership |  | Guest membership in segments with assignment details and scores | 28 |
| engagement_insights | lifetime_value |  | Guest lifetime value calculations and predictions | 23 |
| engagement_insights | preference |  | Guest preferences for dietary restrictions, communication, and service | 36 |
| feedback_analytics | communication |  | Communications sent to guests across channels | 27 |
| feedback_analytics | complaint |  | Guest complaints and resolution tracking | 30 |
| feedback_analytics | guest_visit |  | Guest visit records with transaction and experience details | 32 |
| feedback_analytics | interaction |  | Guest interactions across all touchpoints | 15 |
| feedback_analytics | satisfaction_survey |  | Guest satisfaction surveys with NPS and CSAT scores | 23 |
| feedback_analytics | survey_question |  | Survey questions for guest feedback collection | 19 |
| feedback_analytics | survey_response |  | Individual responses to survey questions | 26 |
| identity_management | address |  | Guest addresses for delivery, billing, and correspondence | 34 |
| identity_management | channel_identity |  | Guest identities across different channels and platforms | 29 |
| identity_management | corporate_account |  | Corporate accounts for business guests and catering | 43 |
| identity_management | demographic |  | Guest demographic information for segmentation and analytics | 27 |
| identity_management | digital_account |  | Guest digital accounts for app and online ordering | 24 |
| identity_management | household |  | Household groupings of guest profiles for family marketing | 30 |
| identity_management | household_member |  | Individual members within a household | 19 |
| identity_management | identity_resolution |  | Identity resolution records for matching and merging guest profiles across systems | 39 |
| identity_management | profile |  | Core guest profile containing personal information, contact details, preferences, and loyalty status | 44 |

<a id="domain-loyalty"></a>

### Domain: Loyalty

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| loyalty | business | 4 | Manages guest loyalty program enrollment, membership tiers, points accrual and redemption, rewards catalog, promotional offers, personalized campaigns, member engagement, and loyalty analytics. Drives repeat visits, ACV lift, and customer lifetime value through targeted incentives and gamification across OLO and POS channels. | 19 |

**Subdomains:** member_engagement, offer_campaigns, points_rewards, program_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| member_engagement | loyalty_segment | master_data | Behavioral and value-based segments for targeting loyalty members | 40 |
| member_engagement | loyalty_visit | transactional_data | Loyalty-qualifying visits by members linked to orders and restaurant units | 19 |
| member_engagement | member | master_data | Loyalty program member profile linking guest identity to program participation | 46 |
| member_engagement | referral | transactional_data | Member-to-member referral tracking with bonus point awards | 29 |
| offer_campaigns | challenge | master_data | Gamification challenges that incentivize specific member behaviors | 40 |
| offer_campaigns | challenge_enrollment | transactional_data | Member enrollment and progress tracking for loyalty challenges | 36 |
| offer_campaigns | offer | master_data | Targeted offers available to loyalty members based on segments, tiers, and behavior | 44 |
| offer_campaigns | offer_assignment | transactional_data | Assignment of offers to individual loyalty members with tracking of delivery and redemption status | 31 |
| offer_campaigns | offer_redemption | transactional_data | Record of offer redemptions by loyalty members at restaurant units | 32 |
| offer_campaigns | program_campaign_allocation | association_data | Budget and resource allocation from loyalty programs to marketing campaigns | 18 |
| points_rewards | loyalty_adjustment | transactional_data | Manual and system-initiated adjustments to member point balances | 25 |
| points_rewards | points_ledger | transactional_data | Detailed ledger of all points transactions including earnings, redemptions, adjustments, and expirations | 35 |
| points_rewards | redemption | transactional_data | Record of reward redemptions by loyalty members | 36 |
| points_rewards | reward | master_data | Catalog of rewards available for redemption by loyalty members | 41 |
| program_management | accrual_rule | reference_data | Rules governing how loyalty points are earned across channels, dayparts, and member tiers | 39 |
| program_management | enrollment_event | transactional_data | Record of member enrollment events with channel, verification, and opt-in details | 38 |
| program_management | program | master_data | Loyalty program configuration including earning rules, tiers, and program-level settings | 36 |
| program_management | tier | reference_data | Loyalty program tier definitions with qualification criteria and benefits | 35 |
| program_management | tier_history | transactional_data | Historical record of member tier changes including upgrades, downgrades, and manual overrides | 35 |

<a id="domain-menu"></a>

### Domain: Menu

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| menu | business | 4 | Single source of truth for all menu items, recipes, BOMs (Bill of Materials), nutritional data, allergen declarations, pricing, product mix (PMIX), limited time offers (LTO), and menu engineering decisions across dayparts, channels (DT, OLO, 3PD), and restaurant formats (QSR, casual, fine-dining). Governs what the business sells. | 18 |

**Subdomains:** dietary_compliance, item_catalog, performance_costing, promotional_engineering


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| dietary_compliance | allergen_declaration |  | Allergen declarations for menu items | 42 |
| dietary_compliance | dietary_tag |  | Dietary tags for categorizing menu items | 18 |
| dietary_compliance | dietary_tag_assignment |  | Assignments of dietary tags to menu items | 27 |
| dietary_compliance | nutrition_profile |  | Nutritional information for menu items and recipes | 46 |
| item_catalog | item_price |  | Pricing information for menu items across locations and channels | 46 |
| item_catalog | menu |  | Menu definitions containing collections of menu items | 47 |
| item_catalog | menu_item |  | Individual food or beverage items available for sale on menus | 45 |
| item_catalog | recipe |  | Recipe definitions for menu items including preparation instructions | 48 |
| item_catalog | recipe_ingredient |  | Ingredients used in recipes with quantities and specifications | 38 |
| performance_costing | engineering_review |  | Menu engineering reviews and analysis | 43 |
| performance_costing | item_86_event |  | Events when menu items are marked as unavailable (86ed) | 41 |
| performance_costing | item_cost |  | Cost information for menu items | 41 |
| performance_costing | pmix_record |  | Product mix records tracking sales performance of menu items | 42 |
| promotional_engineering | combo_component |  | Components that make up combo meals | 44 |
| promotional_engineering | combo_meal |  | Combo meal definitions bundling multiple menu items | 45 |
| promotional_engineering | menu_lto |  | Limited time offer menu items and promotions | 43 |
| promotional_engineering | menu_modifier |  | Individual modifiers that can be applied to menu items | 43 |
| promotional_engineering | modifier_group |  | Groups of modifiers that can be applied to menu items | 41 |

<a id="domain-finance"></a>

### Domain: Finance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| finance | corporate | 6 | Authoritative domain for general ledger (GL), accounts payable (AP), accounts receivable (AR), fixed assets (FA), cost center management, budgeting, P&L reporting, EBITDA tracking, CapEx/OpEx classification, revenue management, royalty income accounting, and multi-entity consolidation via SAP S/4HANA. GAAP/IFRS compliant financial statements. | 33 |

**Subdomains:** asset_capital, banking_treasury, budget_planning, journal_posting, ledger_structure, payables_receivables


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| asset_capital | asset_depreciation | transactional_data | Periodic depreciation calculation and posting record for fixed assets. | 37 |
| asset_capital | capex_project | master_data | Capital expenditure project tracking investments in new restaurant builds, remodels, and equipment. | 33 |
| asset_capital | fixed_asset | master_data | Fixed asset master record representing capitalized equipment, furniture, and improvements at restaurant locations. | 36 |
| asset_capital | lease_liability | master_data | Lease liability record per ASC 842/IFRS 16 representing the present value of future lease payments for restaurant locations. | 61 |
| banking_treasury | bank_account | master_data | Bank account master data representing corporate bank accounts used for payments and receipts. | 22 |
| banking_treasury | bank_statement | master_data | Bank statement header representing a periodic statement from a banking institution. | 19 |
| banking_treasury | bank_statement_line | transactional_data | Individual line item on a bank statement representing a single transaction. | 25 |
| banking_treasury | house_bank | master_data | House bank master data representing banking relationships and routing information. | 16 |
| budget_planning | budget | master_data | Budget header representing an approved financial plan for a specific period, unit, or cost center. | 34 |
| budget_planning | budget_line | master_data | Budget line item representing a specific allocation within a budget for a GL account, period, or category. | 36 |
| journal_posting | allocation_rule | master_data | Allocation rule definition specifying how shared costs are distributed across organizational units. | 23 |
| journal_posting | cost_allocation | transactional_data | Cost allocation record representing the distribution of shared costs across cost centers or profit centers. | 26 |
| journal_posting | intercompany_transaction | transactional_data | Intercompany transaction record for transactions between legal entities requiring elimination in consolidation. | 37 |
| journal_posting | journal_entry | transactional_data | Journal entry header representing a complete accounting document posted to the general ledger. | 49 |
| journal_posting | journal_entry_line | transactional_data | Individual line item within a journal entry representing a debit or credit posting to a GL account. | 42 |
| journal_posting | period_close | transactional_data | Period close record tracking the financial close process for each accounting period. | 35 |
| journal_posting | royalty_accrual | transactional_data | Royalty accrual record representing periodic royalty revenue recognition from franchisees. | 37 |
| journal_posting | tax_posting | transactional_data | Tax posting record representing sales tax, use tax, or VAT postings associated with transactions. | 42 |
| ledger_structure | chart_of_accounts | master_data | Chart of accounts master representing the complete account structure for a legal entity or group. | 18 |
| ledger_structure | cost_center | master_data | Cost center master data representing organizational units that incur costs, mapped to restaurant locations. | 39 |
| ledger_structure | financial_period | master_data | Financial period definition representing accounting periods (months, quarters, years) for the fiscal calendar. | 22 |
| ledger_structure | gl_account | master_data | General ledger account master record defining the chart of accounts structure for financial reporting and posting. | 40 |
| ledger_structure | hierarchy_node | master_data | Hierarchy node representing a position in the organizational or financial reporting hierarchy. | 21 |
| ledger_structure | ledger | master_data | Ledger master data representing different accounting ledgers (leading, non-leading, extension) for parallel accounting. | 17 |
| ledger_structure | legal_entity | master_data | Legal entity master data representing corporate entities for financial consolidation and regulatory reporting. | 44 |
| ledger_structure | profit_center | master_data | Profit center master data representing organizational units responsible for revenue and profit, typically mapped to restaurant units. | 38 |
| payables_receivables | ap_invoice | transactional_data | Accounts payable invoice header representing vendor invoices received for goods and services. | 46 |
| payables_receivables | ap_invoice_line | transactional_data | Line item detail for accounts payable invoices specifying individual charges, quantities, and account assignments. | 51 |
| payables_receivables | ap_payment | transactional_data | Accounts payable payment record representing disbursements to vendors/suppliers. | 41 |
| payables_receivables | ar_invoice | transactional_data | Accounts receivable invoice representing amounts owed by franchisees or customers to the organization. | 46 |
| payables_receivables | ar_payment | transactional_data | Accounts receivable payment record representing cash receipts from franchisees or customers. | 39 |
| payables_receivables | payment_run | master_data | Payment run batch record representing a scheduled execution of vendor payments. | 22 |
| payables_receivables | pos_settlement_batch | master_data | POS settlement batch representing daily credit card and payment processor settlement for restaurant units. | 27 |

<a id="domain-marketing"></a>

### Domain: Marketing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| marketing | corporate | 5 | Manages promotional campaign planning, LTO execution, advertising spend, media channel performance (digital, social, traditional), brand positioning, local store marketing, guest segmentation, and campaign ROI measurement. Drives traffic, average daily transactions (ADT), and comparable store sales (comp sales) lift. | 20 |

**Subdomains:** audience_targeting, campaign_planning, fund_management, media_buying, promotional_engagement


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| audience_targeting | local_store_marketing |  | Local store marketing initiative tracking spend, compliance, and performance at the unit level. | 33 |
| audience_targeting | marketing_guest_segment |  | Marketing-specific guest segment definition with targeting criteria, estimated reach, and campaign association. | 23 |
| campaign_planning | campaign |  | Marketing campaign master record tracking objectives, budgets, timelines, and performance metrics for brand and franchise campaigns. | 39 |
| campaign_planning | campaign_execution |  | Execution-level detail for a campaign at a specific unit or market, tracking channel performance and deviations. | 38 |
| campaign_planning | campaign_roi |  | Campaign ROI measurement record with incremental revenue, profit, spend, and attribution methodology. | 24 |
| campaign_planning | campaign_spend |  | Campaign spend line items tracking invoices, payments, vendors, and budget variance by channel and fiscal period. | 37 |
| campaign_planning | marketing_lto |  | Limited time offer marketing details including pricing, targets, and actual performance metrics. | 29 |
| fund_management | fund |  | Marketing fund (national ad fund, local marketing fund, co-op fund) with balance tracking and legal entity ownership. | 22 |
| fund_management | fund_contribution |  | Individual contribution to a marketing fund from a franchisee or unit, with period and reconciliation details. | 23 |
| media_buying | ad_creative |  | Creative asset record for advertisements including format, compliance status, production cost, and digital asset management references. | 42 |
| media_buying | digital_campaign_performance |  | Daily/periodic digital campaign performance metrics including impressions, clicks, conversions, spend, and ROI by platform and audience. | 41 |
| media_buying | media_buy |  | Individual media purchase record with contracted impressions, spend, flight dates, and reconciliation status. | 40 |
| media_buying | media_channel |  | Reference table of media channels (TV, radio, digital, OOH, etc.) with cost models and targeting capabilities. | 26 |
| media_buying | media_plan |  | Media planning document detailing channel allocation, spend budgets, reach/frequency targets, and approval workflow. | 27 |
| promotional_engagement | content_template |  | Reusable content template for marketing communications with channel, format, language, and compliance attributes. | 21 |
| promotional_engagement | coupon |  | Coupon master record with discount mechanics, redemption limits, eligibility, and fraud prevention controls. | 28 |
| promotional_engagement | influencer |  | Influencer profile with platform metrics, contract details, engagement rates, and brand safety ratings. | 31 |
| promotional_engagement | influencer_activation |  | Individual influencer activation event with deliverables, performance metrics, payment, and FTC compliance tracking. | 31 |
| promotional_engagement | promotion |  | Promotion master record with discount mechanics, eligibility criteria, redemption limits, and channel applicability. | 30 |
| promotional_engagement | promotion_redemption |  | Individual promotion redemption event recording guest, order, discount applied, and channel details. | 24 |

<a id="domain-procurement"></a>

### Domain: Procurement

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| procurement | corporate | 4 | Owns sourcing events, supplier contracts, spend analytics, purchase requisition-to-order workflows, approved vendor lists, contract compliance, and category management for food, packaging, equipment, and services via Coupa Procurement. Distinct from supply domain which tracks physical inventory movement — procurement owns the commercial supplier relationship and contractual terms. | 18 |

**Subdomains:** contract_administration, purchase_execution, sourcing_strategy, supplier_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| contract_administration | contract | master_data | Procurement contracts governing supplier relationships, pricing, terms, and compliance requirements. | 38 |
| contract_administration | contract_line | master_data | Individual line items within a procurement contract specifying items, pricing, and terms. | 38 |
| contract_administration | supplier_category_contract | association_data | Contracts linking suppliers to specific procurement categories with pricing and volume commitments. | 25 |
| contract_administration | supply_agreement | association_data | Supply agreements with suppliers for specific ingredients or products with pricing tiers and commitment values. | 27 |
| contract_administration | vendor_rebate | master_data | Vendor rebate programs tracking volume-based or spend-based rebates from suppliers. | 28 |
| purchase_execution | po_line | transactional_data | Individual line items on a purchase order specifying items, quantities, prices, and delivery details. | 38 |
| purchase_execution | procurement_purchase_order | transactional_data | Purchase orders issued to suppliers for goods and services in the procurement process. | 44 |
| purchase_execution | requisition | transactional_data | Purchase requisitions initiated by restaurant units or departments requesting goods or services. | 40 |
| purchase_execution | supplier_invoice | transactional_data | Invoices received from suppliers for goods and services delivered. | 41 |
| sourcing_strategy | category | reference_data | Procurement spend categories used to classify and manage sourcing activities and supplier relationships. | 27 |
| sourcing_strategy | item_specification | master_data | Detailed specifications for procured items including quality, packaging, storage, and compliance requirements. | 40 |
| sourcing_strategy | product |  | Catalog of procurable products with specifications, dimensions, pricing, and lifecycle management. | 40 |
| sourcing_strategy | sourcing_event | transactional_data | Sourcing events such as RFPs, RFQs, and reverse auctions used to competitively select suppliers. | 27 |
| sourcing_strategy | sourcing_response | transactional_data | Supplier responses/bids submitted to sourcing events including pricing, terms, and evaluation scores. | 35 |
| supplier_management | approved_vendor_list | master_data | Approved vendor list entries tracking which suppliers are authorized to provide goods/services. | 37 |
| supplier_management | procurement_supplier | master_data | Master record for suppliers used in procurement, containing contact, financial, compliance, and contract details. | 42 |
| supplier_management | supplier_risk | master_data | Risk assessments for suppliers covering financial, operational, compliance, and geographic risks. | 22 |
| supplier_management | supplier_scorecard | transactional_data | Periodic supplier performance scorecards measuring delivery, quality, cost, and compliance metrics. | 29 |

<a id="domain-realestate"></a>

### Domain: Realestate

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| realestate | corporate | 3 | Manages site selection, lease negotiations, property acquisition, facility design and construction, CAM (Common Area Maintenance) charges, landlord relationships, lease administration, NRO development pipeline, facility R&M (Repairs and Maintenance), and CapEx planning for new builds and remodels. Tracks lease obligations for IFRS 16 / ASC 842 compliance. | 18 |

**Subdomains:** facility_operations, lease_management, site_development


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| facility_operations | facility |  | Physical building or structure at a site including condition, compliance, and maintenance details. | 37 |
| facility_operations | maintenance_contract |  | Service contract with a vendor for ongoing maintenance of restaurant facilities. | 43 |
| facility_operations | maintenance_work_order |  | Work order for maintenance or repair activities at a restaurant facility. | 23 |
| facility_operations | menu_item_site_offering |  | Mapping of menu items available at specific sites with local pricing and availability. | 24 |
| lease_management | cam_reconciliation |  | Common area maintenance reconciliation between estimated and actual charges. | 26 |
| lease_management | landlord |  | Property owner or management company that leases space to the restaurant brand. | 36 |
| lease_management | lease |  | Lease agreement for a restaurant site between the tenant (franchisee or corporate) and the landlord. | 40 |
| lease_management | lease_amendment |  | Amendment to an existing lease agreement modifying terms, rent, or space. | 29 |
| lease_management | rent_payment |  | Actual rent payment made to a landlord for a lease period. | 38 |
| lease_management | rent_schedule |  | Scheduled rent payments and occupancy cost breakdown for a lease period. | 39 |
| lease_management | tenant |  | Tenant entity representing the occupant of a leased property. | 23 |
| site_development | capex_budget |  | Capital expenditure budget for real estate projects including construction and renovation. | 33 |
| site_development | nro_project |  | New restaurant opening project tracking construction, permitting, and launch milestones. | 37 |
| site_development | property_acquisition |  | Acquisition of real property for restaurant development or investment. | 32 |
| site_development | site |  | Physical location or property where a restaurant unit operates or is planned. | 40 |
| site_development | site_permit |  | Permits and licenses required for operating a restaurant at a specific site. | 29 |
| site_development | site_selection |  | Evaluation and scoring of potential sites for new restaurant development. | 31 |
| site_development | trade_area |  | Geographic trade area analysis including demographics, competition, and market potential. | 42 |

## Metric Views

Total metric views generated: **163**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | foodsafety_allergen_incident | foodsafety | allergen_incident | KPIs for allergen incidents — frequency, severity, regulatory notification rates, and resolution times to manage allergen risk and guest safety. |
| 2 | foodsafety_corrective_action | foodsafety | foodsafety_corrective_action | KPIs for food safety corrective actions — closure rates, cost of remediation, severity distribution, and overdue actions to manage compliance remediation effectiveness. |
| 3 | foodsafety_critical_control_point | foodsafety | critical_control_point | KPIs for critical control points — deviation rates, monitoring compliance, and verification currency to manage HACCP program effectiveness. |
| 4 | foodsafety_environmental_monitoring | foodsafety | environmental_monitoring | KPIs for environmental monitoring — pathogen detection rates, positive test rates, and corrective action triggers to manage facility hygiene and food safety risk. |
| 5 | foodsafety_food_recall | foodsafety | food_recall | KPIs for food recall events — recall volume, severity distribution, scope, and resolution status to manage supply chain food safety risk. |
| 6 | foodsafety_food_safety_audit | foodsafety | food_safety_audit | Operational KPIs for food safety audits — compliance scores, pass rates, and corrective action tracking to steer food safety program performance. |
| 7 | foodsafety_food_safety_training | foodsafety | food_safety_training | KPIs for food safety training — completion rates, assessment scores, and compliance status to manage workforce food safety competency. |
| 8 | foodsafety_haccp_plan | foodsafety | haccp_plan | KPIs for HACCP plan management — approval rates, compliance status, and review currency to ensure food safety management system integrity. |
| 9 | foodsafety_health_inspection | foodsafety | health_inspection | KPIs for regulatory health inspections — scores, violation rates, closure orders, and fee exposure to manage regulatory compliance risk. |
| 10 | foodsafety_illness_report | foodsafety | illness_report | KPIs for foodborne illness reports — incidence rates, investigation completion, health department notifications, and severity to manage public health risk. |
| 11 | foodsafety_inspection_violation | foodsafety | inspection_violation | KPIs for individual inspection violations — severity distribution, penalty exposure, and resolution rates to prioritize compliance remediation. |
| 12 | foodsafety_pest_control_log | foodsafety | pest_control_log | KPIs for pest control activities — service compliance, findings severity, and corrective action rates to manage facility pest risk. |
| 13 | foodsafety_recall_unit_response | foodsafety | recall_unit_response | KPIs for unit-level recall responses — affected quantity, compliance rates, and verification status to manage recall execution effectiveness across the restaurant estate. |
| 14 | foodsafety_receiving_inspection | foodsafety | receiving_inspection | KPIs for receiving inspections — temperature compliance, rejection rates, and supplier quality at point of receipt to manage inbound food safety risk. |
| 15 | foodsafety_sanitation_task_log | foodsafety | sanitation_task_log | KPIs for sanitation task execution — completion rates, compliance, chemical usage, and deviation tracking to manage sanitation program effectiveness. |
| 16 | foodsafety_temperature_log | foodsafety | temperature_log | KPIs for temperature monitoring — deviation rates, critical limit breaches, and compliance status to manage food safety temperature control programs. |
| 17 | inventory_adjustment | inventory | inventory_adjustment | Inventory adjustment analytics tracking the volume, value, and nature of stock corrections. Drives shrinkage control, HACCP compliance, and financial accuracy programs. |
| 18 | inventory_food_cost_period | inventory | food_cost_period | Strategic food cost performance metrics by period, unit, and franchisee. Tracks actual vs theoretical food cost, variance, and waste to drive margin management decisions. |
| 19 | inventory_ingredient_usage | inventory | inventory_ingredient_usage | Ingredient usage efficiency metrics comparing actual vs theoretical consumption. Drives food cost variance analysis, waste reduction, and recipe compliance programs. |
| 20 | inventory_on_hand_balance | inventory | on_hand_balance | Real-time inventory position metrics tracking stock levels, valuation, and reorder status. Drives replenishment decisions, working capital management, and stockout prevention. |

*... and 143 more metric views. See the `metrics/` folder for full details.*