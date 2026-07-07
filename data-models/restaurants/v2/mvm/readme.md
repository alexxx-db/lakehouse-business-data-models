# Restaurants Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on July 02, 2026 at 04:02 AM

This document outlines a vibed Lakehouse data model for the Restaurants business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Inventory](#domain-inventory)
  - [Order](#domain-order)
  - [Restaurant](#domain-restaurant)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)
  - [Guest](#domain-guest)
  - [Loyalty](#domain-loyalty)
  - [Menu](#domain-menu)
- [Metric Views](#metric-views)

## Output Folder Structure

All artifacts for version **v2_mvm** are organized as follows:

```
v2/mvm/
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
| `schemas/` | `restaurants_<domain>_schema_v2_mvm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `restaurants_catalogs_v2_mvm.sql` (catalog-level DDL) |
| `metrics/` | `restaurants_<domain>_metrics_v2_mvm.sql` (one file per domain) |
| `docs/` | `restaurants_model_v2_mvm.xlsx`, `restaurants_model_v2_mvm.csv`, `releasenotes.txt` |
| `diagram/` | `restaurants_dbml_v2_mvm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `restaurants_rdf_v2_mvm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | MVM (Minimum Viable Model) |
| Total Domains | 8 |
| Total Subdomains | 24 |
| Total Products | 85 |
| Total Attributes | 2897 |
| Primary Keys | 85 |
| Foreign Keys | 393 |
| Avg Attributes/Product | 34.1 |
| Metric Views | 65 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Restaurants | Restaurants | MVM (Minimum Viable Model) | restaurants industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-inventory"></a>

### Domain: Inventory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| inventory | operations | 2 | Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units. | 10 |

**Subdomains:** inventory_operations, stock_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| inventory_operations | adjustment | transactional_data | Records of inventory quantity adjustments including reason codes, approval workflow, and financial impact. | 43 |
| inventory_operations | food_cost_period | transactional_data | Periodic food cost calculations for restaurant units including actual vs theoretical cost, variance analysis, and COGS percentages. | 35 |
| inventory_operations | physical_count | transactional_data | Physical inventory count events performed at restaurant units, tracking count results, variances, and GL postings. | 32 |
| inventory_operations | receiving_order | transactional_data | Records of goods received at a restaurant unit or facility, including quality checks and temperature verification. | 37 |
| inventory_operations | stock_transfer | transactional_data | Records of inventory transfers between locations, units, or facilities including shipping and quality inspection details. | 40 |
| inventory_operations | waste_log | transactional_data | Records of inventory waste events including reason, quantity, cost impact, and HACCP compliance. | 32 |
| stock_management | on_hand_balance | master_data | Current on-hand inventory balance for each stock item at each location, including valuation and par-level tracking. | 34 |
| stock_management | stock_item | master_data | Master record for each stockable item tracked in restaurant inventory including allergen flags, storage requirements, and reorder parameters. | 40 |
| stock_management | stock_location | master_data | Physical storage locations within restaurants, distribution centers, or facilities where inventory is held. | 36 |
| stock_management | vendor_item | master_data | Mapping of stock items to vendor/supplier catalog items including pricing, lead times, and ordering parameters. | 39 |

<a id="domain-order"></a>

### Domain: Order

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| order | operations | 3 | Core transactional domain managing order capture, fulfillment, and delivery across all service channels including POS (Oracle MICROS), drive-thru (DT), online ordering (OLO), third-party delivery (3PD), and catering. Tracks order lifecycle, KDS routing, ticket time, speed of service (SOS), average transaction count (ATC), and average check value (ACV). | 12 |

**Subdomains:** fulfillment_reference, order_transactions, payment_settlement


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| fulfillment_reference | channel | reference_data | Order channel reference (dine-in, drive-thru, OLO, delivery, etc.). | 27 |
| fulfillment_reference | daypart | reference_data | Time-window definition for restaurant operations (breakfast, lunch, dinner, late-night). | 19 |
| fulfillment_reference | delivery_order | transactional_data | Delivery-specific details for an order fulfilled via delivery. | 41 |
| fulfillment_reference | kds_ticket | transactional_data | Kitchen display system ticket tracking preparation of an order. | 30 |
| order_transactions | guest_order | transactional_data | Core order transaction capturing a guest purchase at a restaurant unit. | 45 |
| order_transactions | order_item | transactional_data | Individual line item within a guest order. | 47 |
| order_transactions | order_modifier | transactional_data | Modifier applied to an order item such as add-ons, substitutions, or removals. | 38 |
| order_transactions | status_event | transactional_data | State transition event in the order lifecycle. | 41 |
| payment_settlement | discount | transactional_data | Discount applied to an order or order item. | 39 |
| payment_settlement | payment | transactional_data | Payment tendered against a guest order. | 46 |
| payment_settlement | refund | transactional_data | Refund issued against a guest order. | 43 |
| payment_settlement | tax | transactional_data | Tax line applied to a guest order. | 40 |

<a id="domain-restaurant"></a>

### Domain: Restaurant

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| restaurant | operations | 3 | Master record for every restaurant unit — company-owned and franchised — including location attributes, format (QSR/casual/fine-dining), FOH/BOH configuration, operating hours, daypart schedules, equipment, throughput capacity, speed-of-service (SOS) benchmarks, table turns, cover counts, AUV, SSS, and comp sales. Operational anchor for brand standards and SOPs. | 8 |

**Subdomains:** brand_standards, kitchen_operations, location_identity


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| brand_standards | brand | master_data | Master reference table for brand. Referenced by brand_id. | 45 |
| brand_standards | brand_standard | master_data | Defines the brand standards and SOPs (Standard Operating Procedures) applicable to each restaurant unit by concept type and ownership model. Captures standard code, standard name, standard category (food quality, cleanliness, service, safety, brand presentation), applicable format (QSR/casual/fine-dining), compliance requirement level (mandatory/recommended), effective date, expiry date, governing body reference (NRA, FDA, OSHA), and linked SOP document reference. Operational anchor for audit and compliance workflows. | 31 |
| kitchen_operations | equipment_asset | master_data | Inventory of all BOH and FOH equipment assets installed at each restaurant unit including all equipment types (fryer, grill, oven, KDS stations, POS terminals, refrigeration units, ice machines, espresso machines, drive-thru timers). Captures make, model, serial number, installation date, warranty expiry, last service date, next scheduled maintenance date, asset condition rating, replacement cost, software version (for digital equipment), and equipment-specific configuration attributes. Supports R&M (Repairs and Maintenance) planning, CapEx forecasting, PCI DSS compliance for payment terminals, and food safety compliance for temperature-critical equipment. | 39 |
| kitchen_operations | kitchen_station | master_data | Master reference table for kitchen_station. Referenced by station_id. | 44 |
| kitchen_operations | pos_terminal | master_data | Master reference table for pos_terminal. Referenced by: loyalty.offer_redemption.pos_terminal_id, loyalty.payment_method_link.pos_terminal_id, loyalty.redemption.pos_terminal_id, loyalty.visit.pos_terminal_id, order.drive_thru_event.pos_terminal_id | 61 |
| location_identity | location_profile | master_data | Physical and geographic attributes of each restaurant unit including full street address, city, state, province, postal code, country, DMA (Designated Market Area), trade area classification, latitude/longitude, timezone, locale, accessibility features, parking capacity, drive-thru lane count, patio seating availability, and proximity to key landmarks. Supports site analytics, delivery radius configuration, and regional reporting. | 42 |
| location_identity | operating_hours | master_data | Scheduled operating hours for each restaurant unit by day of week and daypart (breakfast, lunch, dinner, late-night, 24hr). Captures open time, close time, daypart start/end times, holiday schedule overrides, seasonal hour adjustments, drive-thru-specific hours, delivery window hours, and last-order cutoff times. Used for order routing, labor scheduling, and SSS (Same-Store Sales) period alignment. | 34 |
| location_identity | unit | master_data | Master record for every restaurant unit — company-owned and franchised. The authoritative identity of each physical location including unit number, brand, concept type (QSR/casual/fine-dining), ownership model (company-owned vs. franchised), legal entity name, trade name, opening date, closure date, current operational status, and geographic coordinates. This is the operational anchor for the entire restaurant domain and the primary FK target for all cross-domain joins (order, inventory, workforce, finance, franchise). One row per physical restaurant location. All other restaurant domain products reference this entity. | 42 |

<a id="domain-supply"></a>

### Domain: Supply

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| supply | operations | 3 | Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement. | 12 |

**Subdomains:** ingredient_sourcing, procurement_operations, supplier_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| ingredient_sourcing | ingredient | master_data | Master catalog of ingredients used in restaurant recipes and menu items. | 36 |
| ingredient_sourcing | ingredient_lot | master_data | Lot-level tracking of ingredients for traceability, quality, and recall management. | 34 |
| ingredient_sourcing | quality_inspection | transactional_data | Quality inspections performed on received ingredients and supplies. | 26 |
| procurement_operations | goods_receipt | transactional_data | Header record for receiving goods against a purchase order at a restaurant or distribution center. | 19 |
| procurement_operations | goods_receipt_line | transactional_data | Line-level detail for goods received, including quantity, quality, and cost information. | 29 |
| procurement_operations | invoice | transactional_data | Supplier invoices received for goods and services, linked to POs and goods receipts for three-way matching. | 19 |
| procurement_operations | purchase_order | transactional_data | Purchase orders placed with suppliers for ingredients and supplies. | 20 |
| procurement_operations | purchase_order_line | transactional_data | Individual line items on a supply purchase order specifying ingredient, quantity, and price. | 19 |
| supplier_management | contract_line_item | association_data | This association product represents the Contract between supplier_contract and ingredient. It captures the specific terms negotiated for each ingredient covered under a supplier contract, including contracted pricing, minimum order quantities, volume discounts, and validity periods. Each record links one supplier_contract to one ingredient with attributes that exist only in the context of this contract-ingredient pairing and cannot be attributed to either entity alone.. Existence Justification: In restaurant procurement, a single supplier contract routinely covers multiple ingredients (e.g., a produce supplier contract covering tomatoes, lettuce, and onions), and a single ingredient can be covered by multiple contracts over time or simultaneously from different suppliers. The contract-line-item concept — where each ingredient covered by a contract has its own negotiated price, minimum order quantity, and volume discount — is a well-recognized operational entity in procurement systems. This is not an analytical correlation; procurement teams actively create, update, and terminate these contract line items as part of daily supply chain operations. | 9 |
| supplier_management | supplier | master_data | Master record for suppliers providing ingredients and goods to the restaurant supply chain. | 28 |
| supplier_management | supplier_contract | master_data | Detailed contract records with suppliers including pricing, terms, compliance, and renewal information. | 35 |
| supplier_management | supplier_ingredient_catalog | association_data | This association product represents the Sourcing Agreement (Contract) between supply_supplier and ingredient. It captures the approved supplier list — the operational record of which suppliers are authorized to provide which ingredients, at what price, lead time, and minimum order quantity. Each record links one supply_supplier to one ingredient with attributes that exist only in the context of this supplier-ingredient sourcing relationship, forming the foundation of procurement, COGS management, and supplier diversification strategy.. Existence Justification: In restaurant supply chain operations, a supplier can provide multiple ingredients (e.g., a produce distributor supplies tomatoes, lettuce, and onions), and a single ingredient can be sourced from multiple suppliers at different prices, lead times, and minimum order quantities. Procurement teams actively manage this supplier-ingredient sourcing catalog — known as an Approved Supplier List or Vendor Item Catalog — as a first-class operational entity with its own pricing, lead time, and approval data. This relationship cannot be collapsed into a 1:N without losing critical per-combination sourcing terms. | 9 |

<a id="domain-workforce"></a>

### Domain: Workforce

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| workforce | operations | 3 | Manages employee lifecycle including recruiting, onboarding, scheduling, time and attendance, labor forecasting, Labor% optimization, FTE tracking, certifications (ServSafe), performance management, and payroll integration via Workday HCM and Planday. Optimizes labor deployment across dayparts, BOH/FOH staffing ratios, and restaurant locations. | 9 |

**Subdomains:** employee_records, labor_scheduling, training_development


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| employee_records | employee | master_data | Master record for every restaurant employee across company-owned and franchised locations. Captures full employee lifecycle data including personal details, employment type (FTE/PTE), BOH/FOH role classification, hire date, termination date, employment status, pay grade, home restaurant assignment, Workday HCM employee ID, declared availability windows (preferred dayparts, max weekly hours, blackout dates, cross-location availability), and current benefit enrollment summary. Single source of truth for workforce identity and worker profile across the enterprise. | 40 |
| employee_records | leave_request | transactional_data | Tracks employee requests for time off including vacation, sick leave, FMLA, personal days, and unpaid leave. Captures request type, requested dates, approved dates, leave balance consumed, approval status, approving manager, and return-to-work date. Integrates with Planday scheduling to flag coverage gaps and trigger backfill shift assignments. | 23 |
| employee_records | payroll_record | transactional_data | Period-level payroll summary for each employee, capturing gross pay, net pay, regular hours paid, overtime hours paid, tips declared, deductions (benefits, taxes, garnishments), pay period dates, and payroll run status. Sourced from Workday HCM payroll module. Serves as the authoritative payroll transaction record for finance integration and Labor% reporting. | 34 |
| labor_scheduling | labor_forecast | master_data | Projected labor demand by restaurant, daypart, and week based on historical transaction volume (ADT/ATC), seasonal patterns, and planned promotions or LTOs. Captures forecasted cover count, expected throughput, recommended FTE count by BOH/FOH, projected Labor%, and the forecasting model version used. Drives Planday schedule generation and labor budget alignment. | 24 |
| labor_scheduling | schedule | master_data | Weekly or period-level labor schedule published for a restaurant location, representing the planned staffing plan across all dayparts. Captures schedule period (start/end dates), restaurant unit, total scheduled hours, scheduled Labor%, FTE count by daypart, publication status (draft/published/locked), and the manager who approved the schedule. Links to individual shifts for granular staffing detail. | 26 |
| labor_scheduling | shift | transactional_data | Represents a scheduled work shift for an employee at a specific restaurant location, daypart (breakfast, lunch, dinner, late-night), and station assignment (grill, fry, drive-thru, expo, host, bar, dish). Captures planned start/end times, actual clock-in/clock-out times, assigned BOH/FOH station, shift type (regular, overtime, on-call, training), break duration, scheduling source (Planday), and swap/coverage details (original assignee, covering employee, swap request reason, swap approval status, approval timestamp) when shift reassignment occurs. Core operational record for labor deployment, station coverage planning, Speed of Service (SOS) staffing optimization, and Planday shift coverage workflows. | 28 |
| labor_scheduling | time_entry | transactional_data | Captures actual clock-in and clock-out events for each employee per shift, sourced from Workday HCM time tracking or POS-integrated time clocks. Records regular hours, overtime hours, break time, missed punch flags, and manager approval status. Foundation for payroll processing, Labor% calculation, and compliance with FLSA/OSHA labor regulations. | 29 |
| training_development | certification | master_data | Single source of truth for all employee learning credentials, training completions, and regulatory certifications required for foodservice operations. Covers external certifications (ServSafe Food Handler, ServSafe Manager, allergen awareness, HACCP, alcohol service permits, OSHA safety) and internal training completions (new hire orientation, food safety modules, POS/KDS operation, BOH/FOH SOPs, LTO product training, management development). Captures credential type, issuing body (NRA ServSafe, local health department, internal L&D), delivery method (in-person, e-learning, OJT), issue/completion date, expiration date, assessment score, trainer/facilitator, and compliance status. Critical for food safety regulatory compliance, health department inspections, scheduling eligibility validation, and employee development tracking. | 19 |
| training_development | training_completion | transactional_data | Records completion of training programs by employees, including new hire orientation, food safety modules, POS operation, KDS usage, BOH/FOH SOPs, LTO product training, and management development programs. Captures training program name, delivery method (in-person, e-learning, OJT), completion date, assessment score, and trainer/facilitator. Supports compliance tracking and performance development. | 23 |

<a id="domain-guest"></a>

### Domain: Guest

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| guest | business | 3 | Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves. | 11 |

**Subdomains:** experience_feedback, guest_identity, marketing_personalization


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| experience_feedback | complaint | master_data | Guest complaints and resolution tracking | 35 |
| experience_feedback | interaction | master_data | Guest interactions across all touchpoints | 16 |
| experience_feedback | satisfaction_survey | master_data | Guest satisfaction surveys with NPS and CSAT scores | 25 |
| experience_feedback | visit | master_data | Guest visit records with transaction and experience details | 35 |
| guest_identity | address | master_data | Guest addresses for delivery, billing, and correspondence | 35 |
| guest_identity | consent_record | master_data | Records of guest consent for marketing, data processing, and privacy | 28 |
| guest_identity | preference | master_data | Guest preferences for dietary restrictions, communication, and service | 36 |
| guest_identity | profile | master_data | Core guest profile containing personal information, contact details, preferences, and loyalty status | 41 |
| marketing_personalization | digital_account | master_data | Guest digital accounts for app and online ordering | 26 |
| marketing_personalization | segment | master_data | Guest segments for targeted marketing and personalization | 38 |
| marketing_personalization | segment_membership | master_data | Guest membership in segments with assignment details and scores | 28 |

<a id="domain-loyalty"></a>

### Domain: Loyalty

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| loyalty | business | 4 | Manages guest loyalty program enrollment, membership tiers, points accrual and redemption, rewards catalog, promotional offers, personalized campaigns, member engagement, and loyalty analytics. Drives repeat visits, ACV lift, and customer lifetime value through targeted incentives and gamification across OLO and POS channels. | 10 |

**Subdomains:** member_enrollment, offer_engagement, points_activity, program_configuration


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| member_enrollment | enrollment_event | transactional_data | Record of member enrollment events with channel, verification, and opt-in details | 37 |
| member_enrollment | member | master_data | Loyalty program member profile linking guest identity to program participation | 44 |
| offer_engagement | offer | master_data | Targeted offers available to loyalty members based on segments, tiers, and behavior | 43 |
| offer_engagement | offer_redemption | transactional_data | Record of offer redemptions by loyalty members at restaurant units | 32 |
| points_activity | points_ledger | transactional_data | Detailed ledger of all points transactions including earnings, redemptions, adjustments, and expirations | 33 |
| points_activity | redemption | transactional_data | Record of reward redemptions by loyalty members | 35 |
| points_activity | reward | master_data | Catalog of rewards available for redemption by loyalty members | 39 |
| program_configuration | accrual_rule | reference_data | Rules governing how loyalty points are earned across channels, dayparts, and member tiers | 39 |
| program_configuration | program | master_data | Loyalty program configuration including earning rules, tiers, and program-level settings | 37 |
| program_configuration | tier | reference_data | Loyalty program tier definitions with qualification criteria and benefits | 35 |

<a id="domain-menu"></a>

### Domain: Menu

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| menu | business | 3 | Single source of truth for all menu items, recipes, BOMs (Bill of Materials), nutritional data, allergen declarations, pricing, product mix (PMIX), limited time offers (LTO), and menu engineering decisions across dayparts, channels (DT, OLO, 3PD), and restaurant formats (QSR, casual, fine-dining). Governs what the business sells. | 13 |

**Subdomains:** item_costing, menu_catalog, recipe_nutrition


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| item_costing | item_cost | master_data | Cost information for menu items | 41 |
| item_costing | item_price | master_data | Pricing information for menu items across locations and channels | 43 |
| menu_catalog | combo_component | association_data | This association product represents the Component Role between combo_meal and menu_item. It captures which menu items are included in each combo meal, in what quantity, in what role (main/side/drink), and under what substitution and pricing rules. Each record links one combo_meal to one menu_item and carries attributes that exist only in the context of that specific combo-item pairing — such as component type, sort order, and upcharge amount.. Existence Justification: In restaurant operations, a combo meal is explicitly defined as a bundle of multiple menu items (e.g., a burger + fries + drink), and a single menu item (e.g., 'Medium Fries') can appear in many different combo meals simultaneously. This is a genuine operational M:N relationship: the business actively creates, manages, and prices these component assignments, and the composition of a combo is a core business concept that menu engineers and product managers work with daily. | 10 |
| menu_catalog | combo_meal | master_data | Combo meal definitions bundling multiple menu items | 45 |
| menu_catalog | item_listing | association_data | This association product represents the Listing (role-based assignment) between menu and menu_item. It captures the operational fact that a specific menu item has been placed on a specific menu, along with the display, pricing, and availability rules that govern that particular pairing. Each record links one menu to one menu_item with attributes — sort order, featured status, channel price override, effective dates, and daypart override — that exist only in the context of this menu-item combination and cannot reside on either entity alone.. Existence Justification: In restaurant operations, menu items are not owned by a single menu — a cheeseburger appears on the Breakfast menu, the All-Day menu, the Drive-Thru menu, and the Digital menu simultaneously, each with potentially different sort orders, featured status, and pricing overrides. Conversely, a single menu contains many items. The business actively manages these listings: items are added to or removed from menus, featured placements are curated, and channel-specific price overrides are applied per listing. This is a first-class operational concept called a 'menu item listing' or 'menu item assignment' that restaurant operators create, update, and delete as part of daily menu management. | 10 |
| menu_catalog | menu | master_data | Menu definitions containing collections of menu items | 43 |
| menu_catalog | menu_item | master_data | Individual food or beverage items available for sale on menus | 41 |
| menu_catalog | menu_modifier | master_data | Individual modifiers that can be applied to menu items | 44 |
| menu_catalog | modifier_group | master_data | Groups of modifiers that can be applied to menu items | 41 |
| recipe_nutrition | allergen_declaration | master_data | Allergen declarations for menu items | 43 |
| recipe_nutrition | nutrition_profile | master_data | Nutritional information for menu items and recipes | 46 |
| recipe_nutrition | recipe | master_data | Recipe definitions for menu items including preparation instructions | 46 |
| recipe_nutrition | recipe_ingredient | master_data | Ingredients used in recipes with quantities and specifications | 36 |

## Metric Views

Total metric views generated: **65**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | inventory_adjustment | inventory | adjustment | Tracks inventory adjustment events including waste, shrinkage, corrections, and reversals. Provides visibility into inventory accuracy, shrinkage cost, and adjustment approval compliance. |
| 2 | inventory_food_cost_period | inventory | food_cost_period | Captures period-level food cost accounting metrics including actual vs. theoretical cost, variance, and sales revenue. The primary domain for food cost percentage management, a core restaurant profitability KPI. |
| 3 | inventory_on_hand_balance | inventory | on_hand_balance | Snapshot-level inventory position metrics tracking on-hand quantities, valuation, par compliance, and expiration risk. Drives replenishment decisions, shrinkage control, and working capital optimization. |
| 4 | inventory_physical_count | inventory | physical_count | Measures physical inventory count accuracy, variance detection, and process compliance. Drives inventory accuracy programs, shrinkage investigation, and period-end close quality. |
| 5 | inventory_receiving_order | inventory | receiving_order | Tracks inbound goods receiving performance including delivery timeliness, quality inspection outcomes, quantity accuracy, and total received value. Drives supplier performance management and receiving process efficiency. |
| 6 | inventory_stock_transfer | inventory | stock_transfer | Tracks inter-unit and inter-location inventory transfer activity including transfer value, quantity, timeliness, and quality compliance. Supports supply chain balancing, inter-unit cost allocation, and HACCP cold-chain monitoring. |
| 7 | inventory_vendor_item | inventory | vendor_item | Tracks vendor item catalog performance including pricing, quality ratings, delivery performance, and contract compliance. Drives supplier rationalization, preferred vendor programs, and procurement cost optimization. |
| 8 | inventory_waste_log | inventory | waste_log | Tracks food and material waste events at the restaurant unit level. Drives waste reduction initiatives, HACCP compliance monitoring, and cost-of-goods optimization by surfacing waste cost, quantity, and category trends. |
| 9 | order_delivery_order | order | delivery_order | Delivery-specific KPIs covering fulfillment speed, delivery distance, platform commission costs, customer satisfaction, and exception rates. Used by delivery ops, finance, and guest experience teams. |
| 10 | order_discount | order | discount | Discount and promotional KPIs covering discount volume, value, void rates, loyalty redemption, and authorization patterns. Used by marketing, finance, and operations to govern promotional spend. |
| 11 | order_guest_order | order | guest_order | Core order-level KPIs covering revenue, volume, discounting, tipping, and order mix. Primary steering dashboard for restaurant GMs, ops VPs, and finance leadership. |
| 12 | order_item | order | order_item | Item-level KPIs covering product mix, revenue contribution, cost, margin, waste, and refund performance. Used by menu engineers, ops leaders, and finance for product portfolio decisions. |
| 13 | order_kds_ticket | order | kds_ticket | Kitchen Display System (KDS) ticket KPIs covering speed of service, re-fire rates, SOS compliance, and kitchen throughput. Used by kitchen ops, GMs, and ops VPs to manage kitchen performance. |
| 14 | order_payment | order | payment | Payment transaction KPIs covering tender mix, processing costs, split tender behavior, tip collection, and settlement performance. Used by finance, treasury, and operations leadership. |
| 15 | order_refund | order | refund | Refund KPIs covering refund volume, value, loyalty point reversals, fraud flags, and guest contact patterns. Used by guest experience, finance, and fraud teams to manage refund risk and cost. |
| 16 | order_tax | order | tax | Tax collection and compliance KPIs covering tax amounts, exemptions, refunds, and remittance status by authority and jurisdiction. Used by finance and tax compliance teams. |
| 17 | restaurant_brand | restaurant | brand | Strategic brand portfolio metrics covering market position, financial performance, and franchise economics. Used by brand leadership and executives to evaluate brand health, franchise attractiveness, and market penetration. |
| 18 | restaurant_brand_standard | restaurant | brand_standard | Brand standard compliance and governance metrics. Used by quality assurance, operations, and brand leadership to monitor standard coverage, certification requirements, and compliance risk across the brand portfolio. |
| 19 | restaurant_equipment_asset | restaurant | equipment_asset | Restaurant equipment asset lifecycle, cost, and compliance metrics. Used by facilities, operations, and finance teams to manage capital asset health, maintenance efficiency, and compliance risk. |
| 20 | restaurant_kitchen_station | restaurant | kitchen_station | Kitchen station throughput, capacity, and operational efficiency metrics. Used by operations and culinary leadership to optimize kitchen layout, staffing, and speed-of-service performance. |

*... and 45 more metric views. See the `metrics/` folder for full details.*