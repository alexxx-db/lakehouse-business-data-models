# Restaurants Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on July 10, 2026 at 08:02 PM

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
| Total Domains | 9 |
| Total Subdomains | 22 |
| Total Products | 87 |
| Total Attributes | 3022 |
| Primary Keys | 87 |
| Foreign Keys | 506 |
| Avg Attributes/Product | 34.7 |
| Metric Views | 70 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Restaurants | Restaurants | MVM (Minimum Viable Model) | restaurants industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-foodsafety"></a>

### Domain: Foodsafety

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| foodsafety | operations | 4 | Governs HACCP plan management, food safety audit results, health inspection records, corrective action tracking, temperature monitoring logs, sanitation schedules, allergen management, and SOP compliance via Zenput. Ensures adherence to FDA FSMA, local health department requirements, ISO 22000, and ServSafe standards across all restaurant units. | 10 |

**Subdomains:** compliance_inspection, hazard_control, incident_reporting, sanitation_monitoring


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| compliance_inspection | corrective_action | transactional_data | Tracks corrective and preventive actions (CAPA) initiated in response to food safety audit findings, health inspection violations, CCP deviations, temperature exceedances, pest control findings, or allergen incidents. Captures root cause analysis method (5-Why, fishbone), corrective action description, responsible manager, target and actual completion dates, verification method, effectiveness check outcome, and closure status. Serves as the central CAPA registry managed via Zenput task management, supporting FDA Food Code and ISO 22000 corrective action requirements. | 38 |
| compliance_inspection | food_safety_audit | transactional_data | Header-and-line transactional record of each food safety audit conducted at a restaurant unit, including audit metadata (type: internal/third-party/health-department, date, auditor, overall score, pass/fail) and individual findings (category: critical/major/minor, regulatory reference, corrective action required, responsible party, due date, resolution status). Managed via Zenput. Supports QA compliance tracking, trend analysis, and regulatory reporting. Each audit contains zero-to-many findings as line items. | 28 |
| compliance_inspection | health_inspection | transactional_data | Header-and-line record of official health inspections conducted by local health departments or regulatory authorities at restaurant units, including inspection header (date, inspector, agency, type: routine/follow-up/complaint-driven, overall grade, permit status, closure orders) and individual violations as line items (violation code, severity: critical/non-critical, FDA Food Code citation, corrective action required, compliance deadline, re-inspection outcome). This is the authoritative regulatory inspection record distinct from internal food safety audits. | 33 |
| hazard_control | audit_ccp_finding | association_data | This association product represents the Event between food_safety_audit and critical_control_point. It captures the individual finding recorded for each Critical Control Point evaluated during a specific food safety audit. Each record links one food_safety_audit to one critical_control_point and carries the outcome data — finding result, compliance status, deviation details, corrective action required, and finding score — that exists only in the context of evaluating a specific CCP within a specific audit. Food safety managers actively create, review, and close these records as part of the audit lifecycle.. Existence Justification: In HACCP-governed food safety operations, each audit systematically evaluates multiple Critical Control Points, and each CCP is evaluated across many audits over its lifecycle. The intersection — an 'audit CCP finding' — is a recognized operational record that auditors actively create during each audit, capturing whether each CCP passed or failed, any deviation observed, and what corrective action is required. This is not derivable from existing FKs; it is a first-class operational entity that food safety managers create, review, and act upon. | 10 |
| hazard_control | critical_control_point | master_data | Defines each Critical Control Point (CCP) within a HACCP plan, including the hazard type (biological, chemical, physical), critical limits (min/max temperature, pH, time), monitoring method, corrective action procedure, and verification frequency. Each CCP is tied to a specific process step (e.g., cooking, cooling, receiving) and HACCP plan version. | 31 |
| hazard_control | haccp_plan | master_data | Master record for each restaurant units Hazard Analysis and Critical Control Points (HACCP) plan, including plan version, scope, approval status, regulatory framework alignment (FDA FSMA, ISO 22000, Codex Alimentarius), effective and expiration dates, responsible food safety manager, team members, and prerequisite program references. Serves as the authoritative SSOT for HACCP program governance across all company-owned and franchised units. Each plan undergoes annual review and revalidation. | 39 |
| incident_reporting | allergen_incident | transactional_data | Transactional record of a reported allergen-related incident at a restaurant unit, including incident date, guest complaint details, allergen involved, menu item implicated, severity (mild reaction, anaphylaxis, hospitalization), immediate response actions taken, root cause determination, and regulatory notification status (FDA MedWatch if applicable). | 39 |
| incident_reporting | illness_report | transactional_data | Transactional record of a reported employee foodborne illness or suspected foodborne illness event at a restaurant unit, capturing report date, employee role, symptoms reported, onset date, suspected pathogen or food item, exclusion-from-work decision, return-to-work clearance date, and health department notification status. Supports FDA Food Code employee health policy compliance. | 34 |
| sanitation_monitoring | sanitation_schedule | master_data | Master sanitation schedule (MSS) with execution log for each restaurant unit, including schedule template (task name, target area: FOH/BOH zone/equipment, frequency: hourly/daily/weekly, chemical/sanitizer, concentration requirements, responsible role, SOP reference) and task execution records (completion timestamp, employee, actual concentration measured, pass/fail, deviation notes). Managed via Zenput task management. Serves as both the authoritative sanitation template and the compliance evidence of task completion. | 35 |
| sanitation_monitoring | temperature_log | transactional_data | Time-series log of temperature readings captured at critical monitoring points (walk-in coolers, freezers, hot-holding units, cooking equipment, receiving docks), including equipment ID, reading timestamp, measured temperature, unit of measure (°F/°C), critical limit thresholds, deviation flag, and monitoring method (manual probe, automated sensor). Core HACCP monitoring record per Principle 4. | 30 |

<a id="domain-inventory"></a>

### Domain: Inventory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| inventory | operations | 2 | Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units. | 8 |

**Subdomains:** inventory_operations, stock_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| inventory_operations | physical_count | transactional_data | Records scheduled or ad-hoc physical inventory count events at a restaurant unit, capturing both count-level header metadata and line-level SKU counts in a single consolidated entity. Header attributes: count date, count type (full/spot-check/cycle-count/pre-close/post-close), count status, count period, initiated-by/approved-by employees, total variance value and percentage. Line attributes (one per SKU-location counted): stock item reference, storage location, system quantity (book inventory), counted quantity, variance quantity and value ($), unit of measure, unit cost, count method (manual/scan), counted-by employee reference, and recount flag. Variance lines trigger investigation workflows and feed period-end food cost reconciliation and COGS% reporting. | 32 |
| inventory_operations | receiving_order | transactional_data | Records the receipt of goods delivered to a restaurant unit from a supplier or distribution center, capturing both delivery-level header information and line-level SKU detail in a single consolidated entity. Header attributes: purchase order reference, delivery date/time, supplier reference, driver name, invoice number, total received value, receiving status (pending/partial/complete/rejected), temperature check result, seal integrity check, and receiving manager reference. Line attributes (one per SKU received): stock item reference, ordered vs received vs rejected quantities, unit of measure, unit cost, extended cost, lot number, expiration date, temperature at receipt (°F/°C), condition code (acceptable/damaged/short-dated/rejected), and variance reason code. Links to MarketMan purchase order and SAP S/4HANA goods receipt. Drives on-hand balance updates, COGS% tracking, and supplier performance measurement. | 36 |
| inventory_operations | stock_transfer | transactional_data | Records the movement of inventory between restaurant units, between storage locations within a unit, or from a unit back to a distribution center — capturing both transfer header and line-level SKU detail in a single consolidated entity. Header attributes: transfer date, transfer type (inter-unit/intra-unit/return-to-vendor/return-to-DC), origin and destination units/locations, transfer status, requested-by/approved-by employees, and total transfer value. Line attributes (one per SKU transferred): stock item reference, transferred quantity, unit of measure, unit cost, extended cost, lot number, expiration date, and condition code. Maintains inventory accuracy across the restaurant network and supports inter-unit food cost allocation. | 42 |
| inventory_operations | waste_log | transactional_data | Records every food waste event at a restaurant unit — spoilage, overproduction, prep waste, expiration, and quality rejection. Captures waste date, waste time, stock item reference, waste quantity, unit of measure, waste cost ($), waste category (spoilage, overproduction, prep loss, expiration, quality-reject, theft/unknown), waste reason description, responsible station (BOH/FOH), recorded-by employee reference, and manager approval flag. Drives Waste% KPI calculation and supports yield management and COGS% optimization. | 35 |
| stock_management | on_hand_balance | master_data | Current stock-on-hand snapshot for each SKU at each storage location within a restaurant unit. Captures quantity on hand, quantity reserved (committed to prep), quantity available, last physical count date, last adjustment date, last received date, unit cost, extended value, and variance from PAR level. Updated by receiving, transfers, waste events, and physical counts. The authoritative real-time inventory position record used for replenishment decisions and food cost reporting. | 33 |
| stock_management | stock_item | master_data | Master record for every SKU tracked in restaurant inventory — food, beverage, packaging, and non-food supplies. Captures SKU code, item name, unit of measure (UOM), item category (protein, produce, dry goods, beverage, paper goods, cleaning), storage class (ambient, refrigerated, frozen), reorder point, reorder quantity, standard cost, vendor item code, shelf life days, HACCP temperature range, allergen flags, daypart applicability, seasonal adjustment flags, and active status. Also owns PAR-level configuration per unit-location: PAR quantity, minimum quantity (reorder point), maximum quantity (shelf capacity), day-of-week overrides, seasonal adjustment flags, and effective date range. This is the SSOT for all stockable items and their replenishment parameters managed through MarketMan. | 41 |
| stock_management | stock_location | master_data | Master record for every physical storage location within a restaurant unit where inventory is held — walk-in cooler, walk-in freezer, dry storage room, BOH prep area, FOH service station, bar storage. Captures location code, location name, location type (refrigerated, frozen, ambient, bar), temperature zone, capacity (cubic feet or shelf count), restaurant unit reference, and active status. Enables granular stock-on-hand tracking by storage zone. | 37 |
| stock_management | uom | reference_data | Reference master for all units of measure used in inventory transactions — ordering UOM, storage UOM, and recipe UOM — plus their conversion factors. Captures UOM code, UOM name, UOM type (weight/volume/count/length), base UOM flag, and applicable item categories. Conversion detail: from-UOM, to-UOM, stock-item-specific overrides (item-specific conversions override global defaults), conversion factor, effective date, and source (vendor spec/lab measurement/standard). Supports accurate translation between ordering (case of 6), storage (each), and recipe (ounce/gram) contexts — critical for inventory valuation and COGS% calculation across all restaurant units. | 30 |

<a id="domain-order"></a>

### Domain: Order

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| order | operations | 3 | Core transactional domain managing order capture, fulfillment, and delivery across all service channels including POS (Oracle MICROS), drive-thru (DT), online ordering (OLO), third-party delivery (3PD), and catering. Tracks order lifecycle, KDS routing, ticket time, speed of service (SOS), average transaction count (ATC), and average check value (ACV). | 12 |

**Subdomains:** fulfillment_execution, order_capture, payment_settlement


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| fulfillment_execution | delivery_order | transactional_data | Manages the delivery fulfillment record for orders dispatched via third-party delivery (3PD) platforms (DoorDash, Uber Eats, Grubhub) or first-party delivery. Captures 3PD platform reference ID, courier assignment, estimated and actual delivery times, delivery distance, delivery fee, platform commission rate, delivery status, and any delivery exception (late, missing item, cancelled). Bridges the Olo digital ordering platform data with internal order records. | 35 |
| fulfillment_execution | kds_ticket | transactional_data | Represents a kitchen display system (KDS) production ticket generated from a guest order, routed to a specific BOH station (grill, fryer, assembly, expo). Captures ticket creation time, station assignment, bump time, re-fire events, ticket time (seconds), SOS target compliance flag, and fulfillment handoff timestamp. Core operational record for kitchen throughput, ticket time compliance, BOH performance management, and FOH handoff coordination. | 30 |
| fulfillment_execution | status_event | transactional_data | Immutable event log tracking every lifecycle state transition of a guest order from placement through fulfillment or cancellation. States include: received, acknowledged, in_preparation, ready, dispatched, delivered, cancelled, voided. Captures the state, prior state, transition timestamp, triggering actor (POS, KDS, OLO, 3PD webhook), and any exception reason. Enables SOS (Speed of Service) and ticket time analytics. | 40 |
| order_capture | catering_order | transactional_data | Manages large-format catering orders placed by corporate, event, or group guests. Captures catering event date, headcount, delivery or pickup mode, setup requirements, special dietary accommodations, catering package selected, quoted price, deposit amount, balance due, and fulfillment status. Distinct from standard guest orders due to advance booking lead time, custom BOM requirements, and dedicated fulfillment workflow. | 38 |
| order_capture | channel | reference_data | Reference master defining all service channels through which guest orders are placed: POS (dine-in, counter), drive-thru (DT), online ordering (OLO), third-party delivery (3PD — DoorDash, Uber Eats, Grubhub), catering, kiosk, and mobile app. Captures channel code, channel category, integration platform, fulfillment mode (dine-in, takeout, delivery, curbside), and active status. Serves as the FK target for guest_order channel attribution, channel-mix reporting, and ACV benchmarking. | 28 |
| order_capture | guest_order | transactional_data | Core transactional header record for every guest order placed across all service channels (POS/MICROS, drive-thru, OLO, 3PD, catering, kiosk). Captures order-level attributes: ticket number, order type, service channel, daypart, order status, guest count, total amount, tax total, discount total, timestamps (placed, promised, completed), and source system reference. This is the authoritative SSOT for all order transactions — every order_item, order_payment, order_status_event, and kds_ticket FKs back to this record. | 46 |
| order_capture | order_item | transactional_data | Line-item detail for each menu item within a guest order. Captures the ordered menu item, quantity, unit price, modifiers applied, line-level discounts, PMIX contribution, preparation instructions, KDS station routing, and item-level fulfillment status. Supports PMIX analysis, COGS% calculation, and kitchen throughput reporting. | 48 |
| order_capture | order_modifier | transactional_data | Records all customizations and modifiers applied to individual order items, including add-ons, substitutions, removals, and special preparation requests. Captures modifier name, modifier group, price delta, and whether the modifier was guest-initiated or system-defaulted. Essential for accurate COGS% tracking and kitchen execution fidelity. | 44 |
| payment_settlement | discount | transactional_data | Records all discounts, promotions, coupons, and comp adjustments applied to a guest order or individual order items. Captures discount type (coupon, loyalty redemption, employee meal, manager comp, promotional LTO, bundle/combo deal), discount amount or percentage, promotion reference, authorization employee, and pre-approved vs. exception-based flag. Supports COGS% impact analysis, promotional ROI tracking, and combo savings attribution. | 39 |
| payment_settlement | payment | transactional_data | Captures all payment tender records associated with a guest order, supporting split-tender scenarios. Includes tender type (cash, credit, debit, gift card, loyalty redemption, 3PD settlement), amount tendered, change due, authorization code, PCI-compliant masked card data, payment processor reference, and payment status. Authoritative SSOT for order-level payment capture; financial settlement lives in the finance domain. | 46 |
| payment_settlement | refund | transactional_data | Captures refund and void transactions issued against a completed or in-progress guest order. Records refund reason (wrong item, quality complaint, missing item, guest dissatisfaction), refund amount, refund method (original tender, gift card, loyalty points), authorizing manager, refund timestamp, and whether the refund was full or partial. Supports CSAT root-cause analysis and exception management. | 44 |
| payment_settlement | tax | transactional_data | Records tax line details applied to a guest order, supporting multi-jurisdiction tax compliance. Captures tax authority (federal, state, county, city), tax type (sales tax, VAT, beverage tax, bag fee), tax rate, taxable amount, tax amount, and whether the tax was included in the menu price or added at checkout. Supports financial reconciliation and regulatory tax reporting across all restaurant locations. | 39 |

<a id="domain-restaurant"></a>

### Domain: Restaurant

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| restaurant | operations | 2 | Master record for every restaurant unit — company-owned and franchised — including location attributes, format (QSR/casual/fine-dining), FOH/BOH configuration, operating hours, daypart schedules, equipment, throughput capacity, speed-of-service (SOS) benchmarks, table turns, cover counts, AUV, SSS, and comp sales. Operational anchor for brand standards and SOPs. | 9 |

**Subdomains:** location_identity, operations_standards


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| location_identity | format_config | master_data | Defines the operational format, physical configuration, and total capacity of a restaurant unit. Includes dining format (QSR, fast-casual, casual, fine-dining), service model (counter, table, drive-thru, kiosk), FOH layout (total indoor seating capacity, outdoor/patio seating capacity, bar seating count, private dining room capacity, ADA-compliant seating count, table count, cover count), BOH layout (kitchen footprint sq ft, cooking lines, prep stations), drive-thru configuration (lane count, stacking capacity for vehicles), kiosk count, counter service positions, and maximum cover count per daypart. This is the single source of truth for all physical capacity and layout attributes of a unit — governs brand standard compliance, throughput benchmarking, labor staffing ratios, health department permit compliance, and fire marshal occupancy limits. | 40 |
| location_identity | location_profile | master_data | Physical and geographic attributes of each restaurant unit including full street address, city, state, province, postal code, country, DMA (Designated Market Area), trade area classification, latitude/longitude, timezone, locale, accessibility features, parking capacity, drive-thru lane count, patio seating availability, and proximity to key landmarks. Supports site analytics, delivery radius configuration, and regional reporting. | 42 |
| location_identity | operating_hours | master_data | Scheduled operating hours for each restaurant unit by day of week and daypart (breakfast, lunch, dinner, late-night, 24hr). Captures open time, close time, daypart start/end times, holiday schedule overrides, seasonal hour adjustments, drive-thru-specific hours, delivery window hours, and last-order cutoff times. Used for order routing, labor scheduling, and SSS (Same-Store Sales) period alignment. | 34 |
| location_identity | unit | master_data | Master record for every restaurant unit — company-owned and franchised. The authoritative identity of each physical location including unit number, brand, concept type (QSR/casual/fine-dining), ownership model (company-owned vs. franchised), legal entity name, trade name, opening date, closure date, current operational status, and geographic coordinates. This is the operational anchor for the entire restaurant domain and the primary FK target for all cross-domain joins (order, inventory, workforce, finance, franchise). One row per physical restaurant location. All other restaurant domain products reference this entity. | 43 |
| operations_standards | brand | master_data | Master reference table for brand. Referenced by brand_id. | 30 |
| operations_standards | brand_standard | master_data | Defines the brand standards and SOPs (Standard Operating Procedures) applicable to each restaurant unit by concept type and ownership model. Captures standard code, standard name, standard category (food quality, cleanliness, service, safety, brand presentation), applicable format (QSR/casual/fine-dining), compliance requirement level (mandatory/recommended), effective date, expiry date, governing body reference (NRA, FDA, OSHA), and linked SOP document reference. Operational anchor for audit and compliance workflows. | 32 |
| operations_standards | equipment_asset | master_data | Inventory of all BOH and FOH equipment assets installed at each restaurant unit including all equipment types (fryer, grill, oven, KDS stations, POS terminals, refrigeration units, ice machines, espresso machines, drive-thru timers). Captures make, model, serial number, installation date, warranty expiry, last service date, next scheduled maintenance date, asset condition rating, replacement cost, software version (for digital equipment), and equipment-specific configuration attributes. Supports R&M (Repairs and Maintenance) planning, CapEx forecasting, PCI DSS compliance for payment terminals, and food safety compliance for temperature-critical equipment. | 41 |
| operations_standards | kitchen_station | master_data | Master reference table for kitchen_station. Referenced by station_id. | 30 |
| operations_standards | pos_terminal | master_data | Master reference table for pos_terminal. Referenced by: loyalty.offer_redemption.pos_terminal_id, loyalty.payment_method_link.pos_terminal_id, loyalty.redemption.pos_terminal_id, loyalty.visit.pos_terminal_id, order.drive_thru_event.pos_terminal_id | 62 |

<a id="domain-supply"></a>

### Domain: Supply

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| supply | operations | 2 | Manages end-to-end food and non-food supply chain including supplier master data, vendor management, sourcing, purchase orders, inbound logistics, distribution center operations, and ingredient traceability. Tracks COGS, supplier performance, contract compliance, and spend analytics via Coupa Procurement. | 9 |

**Subdomains:** procurement_operations, supplier_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| procurement_operations | goods_receipt | transactional_data | Transactional record of inbound goods received at a distribution center or restaurant, including both header-level receipt information and line-level detail per SKU. Header captures receipt date/time, receiving location, PO reference, receiving condition, and inspector ID. Lines capture specific ingredient/SKU received, quantity accepted/rejected, lot number, expiration date, temperature at receipt (cold chain compliance), storage location assigned, and variance from PO quantity. Critical for three-way match (PO-receipt-invoice), HACCP traceability, and ingredient-level lot tracking. Sourced from SAP S/4HANA MM (MIGO) and MarketMan receiving module. | 24 |
| procurement_operations | goods_receipt_line | transactional_data | Line-level detail for each goods receipt event, capturing the specific ingredient/SKU received, quantity accepted, quantity rejected, unit of measure, lot number, expiration date, storage location assigned, and variance from PO quantity. Enables ingredient-level traceability from supplier to restaurant for HACCP and FDA recall compliance. | 36 |
| procurement_operations | purchase_order | transactional_data | Core transactional record for every purchase order issued to suppliers for food ingredients, beverages, packaging, and non-food supplies. Captures PO number, supplier reference, order date, requested delivery date, ship-to distribution center or restaurant, total PO value, currency, payment terms, approval status, and sourcing event linkage. Represents the contractual commitment to buy. Sourced from Coupa Procurement PO module and SAP S/4HANA MM purchasing. | 6 |
| procurement_operations | purchase_order_line | transactional_data | Line-item detail for each purchase order, capturing individual SKU/ingredient ordered, quantity ordered, unit of measure, agreed unit price, extended line value, COGS allocation, requested delivery date per line, and line status (open, partially received, closed, cancelled). Enables PMIX-level COGS tracking and ingredient-level spend analytics. Sourced from SAP S/4HANA MM (EKPO) and Coupa PO line items. | 5 |
| supplier_management | contract_price | master_data | Contracted unit price records tied to a supplier contract for specific ingredients or SKUs over a defined validity period. Captures ingredient/SKU reference, contracted unit price, currency, price validity start and end dates, price tier (volume break), and price type (fixed, indexed, market-based). Enables COGS% variance analysis against actual invoice prices and supports menu costing in the menu domain. | 22 |
| supplier_management | ingredient | master_data | Master catalog of all food ingredients, raw materials, beverages, and packaging SKUs procured across the foodservice supply chain. Captures SKU code, ingredient name, commodity category, unit of measure, allergen flags (Big 9), USDA grade, country of origin, shelf life days, storage temperature requirements (ambient/refrigerated/frozen), and HACCP critical control classification. Serves as the supply-side item master linking to menu domain BOM for recipe costing. SSOT for ingredient identity across supply, inventory, and menu domains. Sourced from SAP MM material master and MarketMan Inventory Management. | 40 |
| supplier_management | ingredient_lot | master_data | Lot and batch traceability record for received ingredients, enabling end-to-end traceability from supplier farm/plant through DC to restaurant for HACCP compliance and FDA recall management. Captures lot number, batch number, supplier lot reference, ingredient/SKU, production date, best-by date, country of origin, receiving DC, and lot disposition status (quarantine, released, consumed, recalled). Critical for food safety incident response. | 43 |
| supplier_management | supplier | master_data | Master record for every supplier and vendor in the foodservice supply chain, including food and non-food suppliers, distributors, co-manufacturers, and their key contacts. Captures supplier identity, classification (broadline, specialty, local), approval status, diversity certification, payment terms, lead times, regulatory compliance status (FDA, USDA, HACCP), and primary/secondary contact information. SSOT for supplier identity and contact details across supply chain operations. Sourced from Coupa Procurement supplier master and SAP S/4HANA vendor master (MM). | 9 |
| supplier_management | supplier_contract | master_data | Master record for negotiated supply agreements and their associated price schedules. Captures contract number, effective and expiration dates, volume commitments, rebate agreements, exclusivity terms, renewal type, and compliance status. Includes contracted unit prices per ingredient/SKU with validity periods, volume tiers, and price types (fixed, indexed, market-based). Used by supply chain for price validation during goods receipt and invoice matching, and for COGS variance analysis. Sourced from Coupa contract management module. | 42 |

<a id="domain-workforce"></a>

### Domain: Workforce

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| workforce | operations | 2 | Manages employee lifecycle including recruiting, onboarding, scheduling, time and attendance, labor forecasting, Labor% optimization, FTE tracking, certifications (ServSafe), performance management, and payroll integration via Workday HCM and Planday. Optimizes labor deployment across dayparts, BOH/FOH staffing ratios, and restaurant locations. | 9 |

**Subdomains:** employee_records, labor_scheduling


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| employee_records | certification | master_data | Single source of truth for all employee learning credentials, training completions, and regulatory certifications required for foodservice operations. Covers external certifications (ServSafe Food Handler, ServSafe Manager, allergen awareness, HACCP, alcohol service permits, OSHA safety) and internal training completions (new hire orientation, food safety modules, POS/KDS operation, BOH/FOH SOPs, LTO product training, management development). Captures credential type, issuing body (NRA ServSafe, local health department, internal L&D), delivery method (in-person, e-learning, OJT), issue/completion date, expiration date, assessment score, trainer/facilitator, and compliance status. Critical for food safety regulatory compliance, health department inspections, scheduling eligibility validation, and employee development tracking. | 21 |
| employee_records | department | master_data | Master reference table for department. Referenced by department_id. | 33 |
| employee_records | employee | master_data | Master record for every restaurant employee across company-owned and franchised locations. Captures full employee lifecycle data including personal details, employment type (FTE/PTE), BOH/FOH role classification, hire date, termination date, employment status, pay grade, home restaurant assignment, Workday HCM employee ID, declared availability windows (preferred dayparts, max weekly hours, blackout dates, cross-location availability), and current benefit enrollment summary. Single source of truth for workforce identity and worker profile across the enterprise. | 40 |
| employee_records | position | master_data | Defines authorized job positions within the restaurant organization, including role title (e.g., Crew Member, Shift Lead, Kitchen Manager, FOH Supervisor), BOH/FOH classification, pay band, FLSA exemption status, required certifications (e.g., ServSafe), FTE equivalency factor, and whether the position is eligible for overtime. Serves as the job catalog for workforce planning and scheduling. | 28 |
| employee_records | training_completion | transactional_data | Records completion of training programs by employees, including new hire orientation, food safety modules, POS operation, KDS usage, BOH/FOH SOPs, LTO product training, and management development programs. Captures training program name, delivery method (in-person, e-learning, OJT), completion date, assessment score, and trainer/facilitator. Supports compliance tracking and performance development. | 26 |
| labor_scheduling | payroll_record | transactional_data | Period-level payroll summary for each employee, capturing gross pay, net pay, regular hours paid, overtime hours paid, tips declared, deductions (benefits, taxes, garnishments), pay period dates, and payroll run status. Sourced from Workday HCM payroll module. Serves as the authoritative payroll transaction record for finance integration and Labor% reporting. | 34 |
| labor_scheduling | schedule | master_data | Weekly or period-level labor schedule published for a restaurant location, representing the planned staffing plan across all dayparts. Captures schedule period (start/end dates), restaurant unit, total scheduled hours, scheduled Labor%, FTE count by daypart, publication status (draft/published/locked), and the manager who approved the schedule. Links to individual shifts for granular staffing detail. | 26 |
| labor_scheduling | shift | transactional_data | Represents a scheduled work shift for an employee at a specific restaurant location, daypart (breakfast, lunch, dinner, late-night), and station assignment (grill, fry, drive-thru, expo, host, bar, dish). Captures planned start/end times, actual clock-in/clock-out times, assigned BOH/FOH station, shift type (regular, overtime, on-call, training), break duration, scheduling source (Planday), and swap/coverage details (original assignee, covering employee, swap request reason, swap approval status, approval timestamp) when shift reassignment occurs. Core operational record for labor deployment, station coverage planning, Speed of Service (SOS) staffing optimization, and Planday shift coverage workflows. | 28 |
| labor_scheduling | time_entry | transactional_data | Captures actual clock-in and clock-out events for each employee per shift, sourced from Workday HCM time tracking or POS-integrated time clocks. Records regular hours, overtime hours, break time, missed punch flags, and manager approval status. Foundation for payroll processing, Labor% calculation, and compliance with FLSA/OSHA labor regulations. | 29 |

<a id="domain-guest"></a>

### Domain: Guest

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| guest | business | 2 | Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves. | 8 |

**Subdomains:** engagement_feedback, guest_identity


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| engagement_feedback | complaint | transactional_data | Operational record of a guest complaint or service recovery case raised through any channel (in-restaurant, phone, digital, social media). Captures complaint category (food quality, speed of service/SOS, order accuracy, cleanliness, staff behavior), severity level, channel of receipt, restaurant unit, associated order reference, resolution status, resolution type (refund, replacement, apology), resolution timestamp, and escalation flag. Managed in Salesforce CRM service cloud. | 39 |
| engagement_feedback | interaction | transactional_data | Unified event stream capturing every recorded touchpoint between the brand and a guest across all channels. Covers inbound interactions (app sessions, loyalty check-ins, drive-thru visits, dine-in visits, OLO sessions, 3PD orders) and outbound communications (marketing emails, SMS messages, push notifications, direct mail). Captures interaction type, direction (inbound/outbound), channel, timestamp, restaurant unit (if applicable), campaign or trigger reference, subject/content reference, delivery status, open status, click-through status, unsubscribe action, and interaction outcome. Sourced from Salesforce CRM marketing automation, Oracle MICROS POS, and Olo. Provides the raw engagement timeline for RFM modeling, communication frequency capping, suppression list management, and guest engagement scoring. | 20 |
| engagement_feedback | satisfaction_survey | transactional_data | Records guest satisfaction survey instances with full question-level response detail. Captures survey type (CSAT, NPS, post-delivery, post-visit), delivery channel (email, SMS, in-app, receipt QR), delivery timestamp, completion status, NPS score (0-10), CSAT score, restaurant unit, daypart, and respondent profile. Includes granular question-level data: question text, question type (rating, open-text, multiple-choice), response value, response timestamp, and sentiment classification for open-text responses. Sourced from Salesforce CRM and Olo guest feedback flows. Enables CSAT/NPS driver analysis at both survey and question level, supporting operational improvement across FOH and BOH. | 26 |
| engagement_feedback | visit | transactional_data | Captures each confirmed guest visit to a restaurant unit across all service modes (dine-in, DT, OLO, 3PD). Distinct from the order domain's order transaction — this is the guest-centric visit record that may span multiple orders or be a zero-spend visit (e.g., complaint resolution visit). Captures visit date, daypart, service mode, restaurant unit, party size (cover count), table number (dine-in), DT lane (drive-thru), visit duration, and whether the visit was incentivized by a promotion. | 7 |
| guest_identity | address | master_data | Stores all physical and delivery addresses associated with a guest profile, including home address, saved delivery addresses, and billing addresses. Captures address type, street, city, state/province, postal code, country, geolocation coordinates, delivery instructions, and validation status. Supports OLO delivery fulfillment and personalized marketing by geography. | 34 |
| guest_identity | consent_record | transactional_data | Authoritative record of guest consent and privacy elections per regulatory requirement (GDPR, CCPA, CAN-SPAM). Tracks consent type (marketing email, SMS, data sharing, profiling), consent status (granted/withdrawn), consent timestamp, consent source channel, consent version/policy version, and expiry date. Mandatory for compliance with FDA labeling, FTC advertising regulations, and applicable data privacy laws. Immutable audit trail of all consent changes. | 29 |
| guest_identity | preference | master_data | Captures all guest-stated and inferred preferences, dietary restrictions, and food allergen declarations. Covers FDA major allergens (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame) with severity levels (intolerance vs. allergy), dietary restriction types (vegetarian, vegan, halal, kosher, gluten-free), declaration source (self-declared, healthcare provider), cuisine preferences, favorite menu items, preferred service channel (dine-in, DT, OLO), preferred daypart, communication channel preferences (email, SMS, push), and marketing opt-in/opt-out flags. Sourced from Salesforce CRM, Olo guest data, and guest self-declaration. Drives personalization, targeted marketing, and HACCP-aligned guest food safety compliance including FDA allergen labeling requirements. | 36 |
| guest_identity | profile | master_data | Master record for every guest identity across all service channels (dine-in, drive-thru, OLO, 3PD). Single source of truth for WHO the business serves — captures full identity and demographic attributes including name, contact details, date of birth, language preference, age band, gender identity, household income band, education level, employment status, geographic market classification, demographic data source (self-declared vs. third-party enrichment), enrichment provider and date. Also owns digital account attributes: username, account status (active/suspended/deactivated), registration date, registration channel, last login timestamp, device type, app version, two-factor authentication status, and account tier. Sourced primarily from Salesforce CRM, Olo Digital Ordering Platform, and brand mobile app. This is the anchor entity for the entire guest domain. | 41 |

<a id="domain-loyalty"></a>

### Domain: Loyalty

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| loyalty | business | 2 | Manages guest loyalty program enrollment, membership tiers, points accrual and redemption, rewards catalog, promotional offers, personalized campaigns, member engagement, and loyalty analytics. Drives repeat visits, ACV lift, and customer lifetime value through targeted incentives and gamification across OLO and POS channels. | 9 |

**Subdomains:** member_enrollment, points_redemption


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| member_enrollment | accrual_rule | reference_data | Business rules governing how loyalty points are earned across channels, dayparts, menu categories, and member tiers. Each rule defines the earning trigger (purchase, visit, referral, birthday, survey), points awarded per dollar spent or per qualifying event, applicable tier multipliers, menu item or category scope, channel scope (POS, OLO, 3PD), effective date range, and rule priority for conflict resolution. Managed by the loyalty program team and versioned for auditability. | 43 |
| member_enrollment | member | master_data | Master record for every enrolled loyalty program member. Captures member identity linkage (guest_id FK to guest domain), enrollment channel (OLO, POS, in-app, kiosk, staff-assisted), enrollment date, current tier assignment, lifetime points earned/redeemed, opt-in preferences, program assignment, auto-accrue payment linkage flag, and program status (active, suspended, churned). This is the SSOT for loyalty membership identity — distinct from the guest profile master in the guest domain. | 44 |
| member_enrollment | program | master_data | Master configuration record for each loyalty program operated by Restaurants — covering program name, program type (points-based, visit-based, hybrid, subscription), currency name (e.g., 'Stars', 'Points', 'Coins'), points-to-dollar conversion rate, program launch date, geographic scope (global, regional, country), applicable restaurant formats (QSR, casual, fine-dining), enrollment channels, and program status. Supports multi-program architectures across franchise and company-owned units. | 37 |
| member_enrollment | tier | reference_data | Reference catalog of all loyalty membership tiers (e.g., Bronze, Silver, Gold, Platinum) defined in the Restaurants loyalty program. Stores tier name, tier code, qualification threshold (points or visit count), tier benefits summary, tier multiplier for points accrual, tier validity period, and sort order. Drives tier assignment logic and benefit entitlement across the program. | 35 |
| points_redemption | member_offer_assignment | association_data | This association product represents the Assignment event between a loyalty member and a distributed offer. It captures the operational record of each offer being assigned to a specific member — the core of offer wallet management in the loyalty program. Each record links one member to one offer and owns the full lifecycle of that assignment: from distribution through delivery, engagement, and redemption or expiry. Sourced from Salesforce CRM campaign execution and POS/app redemption events. Enables offer wallet display, delivery tracking, redemption analytics, and personalization reporting.. Existence Justification: In restaurant loyalty programs, the marketing team actively distributes offers to specific members or segments, and each member can hold multiple offers in their 'offer wallet' simultaneously while each offer is distributed to many members. This is a core operational process — not an analytical correlation — where the business creates, tracks, and manages individual offer assignments with their own lifecycle (assigned → delivered → viewed → redeemed/expired). The relationship is explicitly recognized in loyalty platforms (Punchh, Paytronix, Olo Engage) as a first-class operational entity with its own attributes including assignment timestamp, delivery status, member-specific expiry, and redemption status. | 13 |
| points_redemption | offer | master_data | Master record for all personalized and mass loyalty offers distributed to members — targeted discounts, BOGO deals, bonus points events, LTO (Limited Time Offer) incentives, and gamification challenge rewards. Captures offer name, offer type (discount, bonus_points, free_item, challenge, sweepstakes), offer value, eligibility criteria (tier, segment, visit frequency), distribution channel (push notification, email, in-app, POS display), start/end dates, redemption limit per member, and offer status. Also owns member-level offer assignment detail: each assignment captures target member or segment, assignment channel, assignment timestamp, delivery status (sent, delivered, opened, clicked), member-specific expiry date, personalization flag, and engagement tracking. Sourced from Salesforce CRM campaign execution. Enables offer wallet management, delivery tracking, and distribution analytics. | 44 |
| points_redemption | points_ledger | transactional_data | Immutable financial-grade ledger recording every points movement for a loyalty member — accruals, redemptions, expirations, adjustments, bonus awards, goodwill credits, promotional credits, dispute resolutions, system error corrections, and fraud reversals. Each row captures transaction type (earn, redeem, expire, adjust, bonus, goodwill, reversal, correction), points delta, running balance, source channel (POS, OLO, 3PD), source order reference, campaign reference, expiry date of earned points, adjustment reason code, adjustment category (goodwill, dispute, error_correction, promotional, fraud), authorizing agent (for manual adjustments), approval status (auto_approved, pending_review, approved, rejected), processing timestamp, and related original transaction reference (for reversals/corrections). This is the single SSOT for ALL member point balance movements — no other product in this domain records points changes of any kind. | 32 |
| points_redemption | redemption | transactional_data | Transactional record of every burn event by a loyalty member — both reward catalog redemptions (member-initiated pull from rewards catalog) and offer redemptions (program-initiated push incentives). Captures member reference, redemption type (reward, offer), reward or offer reference, redemption channel (POS, OLO, drive-thru, kiosk), restaurant unit, order reference, redemption timestamp, points deducted, monetary discount applied, offer assignment reference (for offer-type), delivery confirmation details, redemption status (pending, fulfilled, voided, expired, duplicate_attempt), and fulfillment confirmation. Unified SSOT for ALL burn events — no other product in this domain records redemption transactions. Enables holistic redemption analytics, PMIX impact analysis, offer ROI measurement, and reward popularity tracking. | 36 |
| points_redemption | reward | master_data | Master catalog of all redeemable rewards available in the Restaurants loyalty rewards catalog — free menu items, discounts, merchandise, experiences, and partner offers. Captures reward name, reward type (food, discount, merchandise, experience), points cost, monetary value equivalent, redemption channel eligibility (POS, OLO, app), availability window (start/end date), quantity limit, restaurant applicability scope (all units, specific markets, specific formats), and active status. Distinct from promotional offers which are push-based incentives. | 45 |

<a id="domain-menu"></a>

### Domain: Menu

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| menu | business | 3 | Single source of truth for all menu items, recipes, BOMs (Bill of Materials), nutritional data, allergen declarations, pricing, product mix (PMIX), limited time offers (LTO), and menu engineering decisions across dayparts, channels (DT, OLO, 3PD), and restaurant formats (QSR, casual, fine-dining). Governs what the business sells. | 13 |

**Subdomains:** item_catalog, recipe_formulation, regulatory_compliance


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| item_catalog | combo_meal | master_data | Master record for bundled combo meal offerings — pre-defined combinations of menu items sold together at a bundle price (e.g., Value Meal, Family Pack, Kids Meal). Captures combo name, component items, bundle price, individual item price sum, bundle discount amount, applicable channels, daypart availability, and active status. Distinct from LTOs in that combos are permanent or semi-permanent menu fixtures. | 46 |
| item_catalog | item_listing | association_data | This association product represents the Menu Item Listing — the operational contract between a menu_item and a menu. It captures the authoritative record of which menu items appear on which published menus, under what display and pricing rules, and for what effective date range. Each record links one menu_item to one menu and carries relationship-level attributes (sort order, featured flag, price override, display category, channel override, effective dates) that exist only in the context of this specific item-menu pairing. This is the SSOT for menu publication workflows, POS configuration, and digital menu board management.. Existence Justification: In restaurant operations, a menu item can appear on multiple menus (e.g., a burger on the Lunch menu, the Drive-Thru menu, and the OLO menu simultaneously), and each menu contains many menu items. This is not a derivable analytical correlation — it is an actively managed operational process called 'menu item listing' or 'menu item assignment,' where menu engineers explicitly place items on menus with specific pricing overrides, display order, featured flags, and effective date ranges. The relationship itself is a recognized business concept in menu engineering and POS configuration workflows. | 11 |
| item_catalog | menu | master_data | Master record for each published menu — the container that groups menu items for a specific restaurant format, daypart, channel, and effective date range. Tracks menu name, version, format (QSR/casual/fine-dining), channel (DT/OLO/3PD/dine-in), daypart (breakfast/lunch/dinner/late-night), effective start/end dates, approval status, and publishing state. Enables menu versioning and rollout governance. | 44 |
| item_catalog | menu_item | master_data | Master record for every sellable item on the menu across all restaurant formats (QSR, casual, fine-dining) and service channels (DT, OLO, 3PD, dine-in). Captures item identity, guest-facing name, internal name, description, PLU/SKU code, category, sub-category, daypart availability flags, format eligibility flags, channel availability flags, item status (active/inactive/seasonal/LTO), prep time estimate, portion size, serving temperature, calorie display value, image asset reference, and lifecycle dates (created, launched, discontinued). This is the SSOT for what the business sells — the anchor entity for the entire menu domain. | 43 |
| item_catalog | menu_modifier | master_data | Master record for each individual modifier option within a modifier group — e.g., 'Extra Cheese', 'No Onions', 'Large Size', 'Gluten-Free Bun'. Captures modifier name, modifier group reference, price delta (upcharge or discount), calorie delta, default selection flag, availability status, and channel applicability. Feeds Oracle MICROS POS and Olo Digital Ordering Platform for guest customization. | 45 |
| item_catalog | modifier_group | master_data | Master record for groups of customization options (modifiers) applicable to menu items — e.g., Protein Choice, Sauce Selection, Size Upgrade, Add-Ons. Captures group name, selection type (single/multi-select), min/max selections, display name, and item applicability rules (which menu items this group attaches to, display order, required/optional flag, channel-specific overrides). Drives POS and OLO customization logic and item-to-modifier mapping. | 42 |
| recipe_formulation | item_cost | transactional_data | Transactional record capturing the theoretical COGS (Cost of Goods Sold) for each menu item at a point in time, derived from recipe BOM and current ingredient purchase prices. Tracks theoretical food cost amount, theoretical CoGS%, actual CoGS% (from inventory management systems like MarketMan), variance amount, variance percentage, cost calculation date, ingredient price snapshot reference, and cost approval status. Updated when ingredient prices change (weekly/daily frequency) — distinct from pmix_record which captures periodic sales performance. Feeds menu engineering decisions, pricing optimization, P&L reporting, and franchise profitability benchmarking. | 41 |
| recipe_formulation | item_price | transactional_data | Transactional pricing record capturing the effective price of a menu item for a specific restaurant, channel, daypart, and date range. Tracks base price, promotional price, price tier, currency, effective start/end dates, price change reason, approval status, 3PD commission markup percentage, delivery surcharge amount, and dynamic pricing eligibility flag. Supports channel-specific pricing (DT vs OLO vs 3PD with commission pass-through), daypart pricing, regional price variation, and franchise price compliance monitoring. SSOT for what the guest pays per item per context. | 45 |
| recipe_formulation | recipe | master_data | Master record for each standardized recipe (SOP) associated with a menu item. Captures recipe name, version, yield quantity, yield unit, prep method, cook method, cook temperature, cook time, plating instructions, BOH preparation notes, and recipe status. Serves as the culinary SSOT linking menu items to their production specifications and BOM components. | 51 |
| recipe_formulation | recipe_ingredient | master_data | Bill of Materials (BOM) line-item record for each ingredient within a recipe. Captures ingredient SKU reference, ingredient name, quantity, unit of measure, preparation state (raw/cooked/prepped), waste factor percentage, yield percentage, sequence order, and substitution flag. Drives COGS calculations, procurement planning, and PAR level management. | 38 |
| regulatory_compliance | allergen_declaration | master_data | Regulatory master record capturing the allergen profile for each menu item per FDA Food Allergen Labeling and Consumer Protection Act (FALCPA) requirements. Tracks the presence, may-contain, and absence status for the 9 major FDA allergens (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame), cross-contact risk level, declaration date, and regulatory review status. | 42 |
| regulatory_compliance | nutrition_profile | master_data | Master nutritional data record for each menu item as required by FDA menu labeling regulations. Captures calories, total fat, saturated fat, trans fat, cholesterol, sodium, total carbohydrates, dietary fiber, total sugars, added sugars, protein, and serving size per FDA Nutrition Facts panel standards. Includes data source, lab analysis date, and regulatory approval status. | 45 |
| regulatory_compliance | pmix_record | transactional_data | Transactional menu performance record capturing the sales volume, revenue contribution, and margin performance of each menu item at a restaurant for a given reporting period (day/week/daypart). Tracks units sold, gross sales, net sales, discount amount, void count, contribution margin amount, contribution margin percentage, rank within category, daypart breakdown, channel breakdown, and menu engineering classification (star/plow-horse/puzzle/dog). References item_cost for theoretical COGS comparison but does NOT own cost data. Core input for menu engineering reviews, pricing optimization, item lifecycle decisions, and LTO performance evaluation. | 42 |

## Metric Views

Total metric views generated: **70**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | foodsafety_allergen_incident | foodsafety | allergen_incident | Allergen incident tracking and severity analysis for guest safety and regulatory compliance |
| 2 | foodsafety_corrective_action | foodsafety | corrective_action | Corrective action effectiveness and closure tracking for continuous improvement |
| 3 | foodsafety_critical_control_point | foodsafety | critical_control_point | Critical control point monitoring and deviation management for HACCP compliance |
| 4 | foodsafety_food_safety_audit | foodsafety | food_safety_audit | Food safety audit performance and compliance tracking for operational excellence |
| 5 | foodsafety_haccp_plan | foodsafety | haccp_plan | HACCP plan compliance and lifecycle management for food safety program governance |
| 6 | foodsafety_health_inspection | foodsafety | health_inspection | Health inspection outcomes and regulatory compliance tracking for risk management |
| 7 | foodsafety_illness_report | foodsafety | illness_report | Foodborne illness reporting and investigation tracking for public health and risk mitigation |
| 8 | foodsafety_temperature_log | foodsafety | temperature_log | Temperature monitoring compliance and deviation tracking for critical control point management |
| 9 | inventory_on_hand_balance | inventory | on_hand_balance | Inventory on-hand balance metrics tracking stock levels, valuation, and inventory health across locations and SKUs |
| 10 | inventory_physical_count | inventory | physical_count | Physical inventory count metrics tracking count accuracy, variance, and cycle count performance |
| 11 | inventory_receiving_order | inventory | receiving_order | Receiving order metrics tracking delivery performance, quality inspection, and receiving accuracy |
| 12 | inventory_stock_location | inventory | stock_location | Stock location metrics tracking storage capacity utilization, location performance, and compliance |
| 13 | inventory_stock_transfer | inventory | stock_transfer | Stock transfer metrics tracking inter-location transfer efficiency, accuracy, and value movement |
| 14 | inventory_waste_log | inventory | waste_log | Waste log metrics tracking food waste, cost of waste, and waste prevention opportunities |
| 15 | order_catering_order | order | catering_order | Catering Order business metrics |
| 16 | order_channel | order | channel | Channel business metrics |
| 17 | order_delivery_order | order | delivery_order | Delivery Order business metrics |
| 18 | order_discount | order | discount | Discount business metrics |
| 19 | order_guest_order | order | guest_order | Guest Order business metrics |
| 20 | order_kds_ticket | order | kds_ticket | Kds Ticket business metrics |

*... and 50 more metric views. See the `metrics/` folder for full details.*