# Automotive Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on July 14, 2026 at 04:30 AM

This document outlines a vibed Lakehouse data model for the Automotive business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Manufacturing](#domain-manufacturing)
  - [Procurement](#domain-procurement)
  - [Quality](#domain-quality)
  - [Supply](#domain-supply)
  - [Vehicle](#domain-vehicle)
  - [Aftersales](#domain-aftersales)
  - [Customer](#domain-customer)
  - [Dealer](#domain-dealer)
  - [Sales](#domain-sales)
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
| `schemas/` | `automotive_<domain>_schema_v2_mvm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `automotive_catalogs_v2_mvm.sql` (catalog-level DDL) |
| `metrics/` | `automotive_<domain>_metrics_v2_mvm.sql` (one file per domain) |
| `docs/` | `automotive_model_v2_mvm.xlsx`, `automotive_model_v2_mvm.csv`, `releasenotes.txt` |
| `diagram/` | `automotive_dbml_v2_mvm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `automotive_rdf_v2_mvm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | MVM (Minimum Viable Model) |
| Total Domains | 11 |
| Total Subdomains | 31 |
| Total Products | 114 |
| Total Attributes | 3945 |
| Primary Keys | 114 |
| Foreign Keys | 707 |
| Avg Attributes/Product | 34.6 |
| Metric Views | 90 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Automotive | Automotive | MVM (Minimum Viable Model) | Automotive is a major manufacturing industry producing cars, trucks, SUVs, and commercial vehicles along with hybrid and electric powertrains, connected mobility services, and autonomous driving technology, spanning R&D, purchasing, production, logistics, sales, aftersales, and field services. |  | 2 |

## Business Domains & Subdomains

<a id="domain-inventory"></a>

### Domain: Inventory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| inventory | operations | 3 | Inventory management for raw materials, components, WIP (Work in Progress), finished goods, and service parts across plants, warehouses, and dealer networks. Manages stock levels, inventory movements, cycle counting, MRP (Material Requirements Planning) execution, and SKU master data. Tracks inventory accuracy, turnover rates, obsolescence, and safety stock levels. Includes warehouse management (SAP WM), lot traceability, and serialized inventory for high-value components (ECU, batteries). | 10 |

**Subdomains:** material_master, product_inventory, stock_transactions


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| material_master | sku_master | master_data | SSOT for all Stock Keeping Unit (SKU) definitions across the enterprise. Owns the material master record for raw materials, production components, WIP sub-assemblies, finished vehicles, and service parts. Aligned with SAP MM material master (MARA/MARC). Captures SKU identity, classification, unit of measure, weight/dimensions, hazardous material flags, shelf-life, and MRP planning parameters. Referenced by all inventory movement and stock transactions. | 43 |
| material_master | stock_balance | master_data | Current on-hand stock balance snapshot for each SKU at each storage location, plant, and valuation area. Captures unrestricted stock, quality inspection stock, blocked stock, consignment stock, in-transit stock, and safety stock levels. Aligned with SAP MM stock overview (MMBE / MARD). Supports MRP execution, inventory turnover analysis, and obsolescence monitoring. Updated by every goods movement transaction. | 32 |
| material_master | storage_location | master_data | Master record for all physical and logical storage locations within plants, warehouses, distribution centers, and dealer parts depots. Captures location hierarchy (plant → warehouse → storage type → storage bin), location type (bulk, rack, floor, cold-chain), capacity constraints, and WM (Warehouse Management) configuration. Aligned with SAP WM storage location and bin master. Enables precise bin-level inventory tracking and AGV routing. | 37 |
| material_master | warehouse | master_data | Master reference table for warehouse. Referenced by warehouse_id. | 32 |
| product_inventory | finished_vehicle_stock | master_data | Finished vehicle inventory record tracking completed vehicles from end-of-line (EOL) through PDI (Pre-Delivery Inspection), compound storage, and dealer allocation. Captures VIN, model/trim/color configuration, plant of manufacture, current compound or yard location, stock status (in-production, PDI-pending, PDI-complete, allocated, in-transit, delivered), hold codes, and aging days. Bridges manufacturing and logistics domains for vehicle order fulfillment. | 34 |
| product_inventory | service_parts_stock | master_data | After-sales service parts inventory record tracking spare parts and accessories across the central parts distribution center (PDC), regional warehouses, and dealer parts rooms. Captures part number, supersession chain, current stock level by location, min/max replenishment levels, fill rate, backorder quantity, and obsolescence classification. Supports dealer parts ordering, warranty repair fulfillment, and TSB (Technical Service Bulletin) parts pre-positioning. | 41 |
| stock_transactions | goods_movement | transactional_data | Transactional record of every inventory movement event including goods receipts (GR), goods issues (GI), stock transfers, returns, and scrapping. Aligned with SAP MM material document (MSEG/MKPF). Captures movement type, quantity, source and destination storage locations, reference document (purchase order, production order, delivery), posting date, and batch/serial number. Provides full audit trail for lot traceability and IATF 16949 compliance. | 38 |
| stock_transactions | mrp_requirement | transactional_data | MRP (Material Requirements Planning) planned requirement record generated by SAP MRP run (MD04/MD05). Captures dependent and independent demand requirements for each SKU, planned order proposals, reorder points, lot sizes, lead times, and exception messages. Drives procurement requisitions and production orders. Supports safety stock calculation, demand smoothing, and supply gap analysis across the manufacturing network. | 28 |
| stock_transactions | replenishment_order | transactional_data | Internal replenishment order triggering stock movement from a supplying storage location (warehouse, supermarket, PDC) to a consuming location (line-side, assembly station, dealer parts room). Captures replenishment type (kanban, min-max, JIT pull, JIS sequence), trigger source, requested SKU and quantity, source and destination locations, priority, requested delivery time, and fulfillment status. Supports lean manufacturing pull systems and dealer parts replenishment cycles. | 36 |
| stock_transactions | stock_transfer_order | transactional_data | Warehouse Management transfer order governing the physical movement of stock between storage bins, storage types, or plants. Aligned with SAP WM transfer order (LT0A). Captures source and destination bin, transfer quantity, movement reason, AGV assignment, picker assignment, confirmation status, and execution timestamps. Supports JIT/JIS sequencing for line-side replenishment and inter-plant stock balancing. | 38 |

<a id="domain-logistics"></a>

### Domain: Logistics

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| logistics | operations | 2 | Outbound logistics and distribution including finished vehicle transportation, vehicle storage yards, compound operations, carrier management, and delivery scheduling. Manages vehicle shipment from plant to dealer, rail/truck/vessel logistics, port processing, last-mile delivery, and CKD/SKD kit logistics. Tracks in-transit inventory, delivery lead times, transportation costs, carrier performance, and OTD metrics. Includes export/import operations for global distribution. | 10 |

**Subdomains:** facility_operations, transport_execution


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| facility_operations | compound_movement | transactional_data | Transactional record of a vehicle's physical movement into, within, or out of a compound or yard. Captures VIN, movement type (inbound/outbound/internal transfer), origin bay/zone, destination bay/zone, movement timestamp, operator ID, and associated transport order. Provides granular yard management traceability and supports compound throughput analysis. | 29 |
| facility_operations | in_transit_inventory | master_data | Real-time and point-in-time snapshot of finished vehicles currently in transit between plant and dealer, including vehicles on rail, truck, vessel, or staged at intermediate compounds. Captures VIN, current location (last known compound or leg), transport mode, origin, destination, estimated arrival date, days in transit, and transit status. Critical for dealer allocation visibility and OTD monitoring. | 48 |
| facility_operations | vehicle_compound | master_data | Master record for vehicle storage compounds, yards, and staging areas used in the outbound logistics network (plant yards, rail yards, port compounds, regional distribution centers). Captures compound name, location, type (plant/port/regional/dealer prep), storage capacity (units), current occupancy, operator, PDI capability flag, and compound status. Enables compound capacity planning and in-transit inventory tracking. | 33 |
| facility_operations | vehicle_handover | transactional_data | Record of formal vehicle handover from logistics/compound to dealer or end customer. Captures VIN, handover date, handover location, receiving party (dealer/customer), handover type (dealer stock/retail customer), odometer reading at handover, handover condition, PDI reference, and acceptance signature status. Marks the transfer of custody and triggers downstream billing and warranty start events. | 49 |
| transport_execution | carrier | master_data | Master record for transport carriers (road haulers, rail operators, ocean shipping lines, port logistics providers) engaged for finished vehicle and CKD/SKD kit logistics. Captures carrier legal name, SCAC code, DOT number, transport modes supported, operating regions, contract reference, insurance certificate details, IATF 16949 compliance status, carrier tier classification, and performance rating. SSOT for carrier identity within the logistics domain. Referenced by transport orders, shipment legs, freight invoices, damage claims, and rate contracts. | 38 |
| transport_execution | freight_invoice | transactional_data | Carrier freight invoice received for transport services rendered on finished vehicle or CKD/SKD shipments. Captures invoice number, carrier, invoice date, transport order references, lane, transport mode, invoiced amount, currency, agreed rate, variance amount, approval status, and payment reference. Supports freight cost management, carrier invoice verification against contracted rates, and logistics cost accounting. | 41 |
| transport_execution | lane | master_data | Master record defining a logistics lane as an origin-destination pair for finished vehicle or CKD/SKD transport. Captures origin facility (plant/compound/port), destination facility (dealer/compound/port), transport mode, distance, standard transit time, lane status, and assigned primary/backup carriers. Serves as the reference for route planning, rate assignment, and OTD benchmarking. | 6 |
| transport_execution | shipment | master_data | Core master record for each outbound vehicle shipment from plant to dealer or distribution point. Captures shipment origin (plant/compound), destination (dealer/port/yard), transport mode (rail, truck, vessel, CKD/SKD), shipment status, planned and actual departure/arrival dates, OTD tracking, and associated VINs. Primary operational entity for finished vehicle logistics. Sourced from SAP SD outbound delivery and MES traceability. | 45 |
| transport_execution | shipment_leg | transactional_data | Individual transport leg within a multi-modal shipment, representing a discrete movement segment (e.g., plant to rail yard, rail yard to port, port to dealer compound). Tracks leg sequence, transport mode, carrier assignment, origin/destination facility, planned and actual departure/arrival timestamps, distance, leg-level status, and mode-specific details (rail car number/type for rail legs, vessel name/IMO/voyage for ocean legs). After merges, this product also carries rail car assignment details and vessel voyage references for their respective transport modes. Enables end-to-end multi-modal visibility for each VIN or batch. | 41 |
| transport_execution | vehicle_transport_order | transactional_data | Transport order issued to a carrier for the movement of finished vehicles. Captures order number, issuing plant, carrier reference, transport mode, vehicle count, VIN list, origin compound, destination, requested pickup date, confirmed pickup date, and order status. Represents the contractual instruction to move vehicles and is the primary document linking shipments to carrier execution. Sourced from SAP TM or SAP SD. | 43 |

<a id="domain-manufacturing"></a>

### Domain: Manufacturing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| manufacturing | operations | 3 | Core production and assembly operations across all manufacturing plants. Manages shop floor execution via MES (Manufacturing Execution System), work order scheduling, production line sequencing (JIS - Just-in-Sequence), WIP (Work in Progress) tracking, and build traceability. Includes stamping, body shop, paint, and final assembly processes. Integrates with AGV (Automated Guided Vehicle), PLC (Programmable Logic Controller), and SCADA systems for real-time production control. | 11 |

**Subdomains:** build_execution, facility_operations, planning_configuration


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| build_execution | build_sequence | transactional_data | JIS (Just-in-Sequence) build sequence record defining the ordered sequence of vehicles to be assembled on a production line for a given shift or production run. Captures sequence number, planned build date, shift, line assignment, vehicle configuration reference (model, trim, powertrain, color), sequence status, and freeze timestamp. Critical for JIS supplier call-offs and AGV routing. Sourced from Apriso MES sequencing module. | 43 |
| build_execution | material_consumption | transactional_data | Transactional record capturing actual material consumption (goods issue) against a production order on the shop floor. Tracks consumed part number, quantity consumed, unit of measure, consumption timestamp, work center, production order reference, storage location, batch number, and variance from planned BOM quantity. Feeds SAP MM goods movement and cost accounting for production variance reporting. | 45 |
| build_execution | production_order | transactional_data | Core transactional record representing a manufacturing work order issued to produce a specific vehicle or sub-assembly. Captures order number, order type (vehicle build, sub-assembly, rework), planned and actual start/finish dates, target quantity, produced quantity, order status, priority, shift assignment, and MES order reference. Links to plant, production line, and vehicle configuration. SSOT for shop floor execution tracking in SAP PP and Apriso MES. | 51 |
| build_execution | vehicle_build | transactional_data | Transactional record capturing the actual build event for a single vehicle unit on the shop floor, from body-in-white through final assembly. Tracks VIN assignment, production order reference, actual start and completion timestamps per build stage (stamping, body shop, paint, trim, chassis, final), build status, shift, operator team, and any hold or rework flags. SSOT for vehicle-level build traceability and genealogy in the manufacturing domain. | 49 |
| facility_operations | capacity_plan | master_data | Master record for plant and line capacity planning, capturing planned production capacity by plant, production line, shift pattern, and planning period (weekly/monthly). Includes rated capacity (JPH × available hours), demonstrated capacity, capacity utilization percentage, bottleneck work center, planned overtime hours, and capacity plan version. Supports S&OP (Sales and Operations Planning) and capital investment decisions. | 47 |
| facility_operations | plant | master_data | Master record for each manufacturing plant or assembly facility operated by Automotive. Captures plant identity, location, type (stamping, body shop, paint, final assembly, CKD/SKD), production capacity, SOP/EOP dates, plant code, and operational status. SSOT for plant-level identity referenced across MES, SAP PP, and logistics domains. | 46 |
| facility_operations | production_line | master_data | Master record for each production line within a plant, including stamping lines, body shop lines, paint booths, and final assembly lines. Tracks line code, line type, designed throughput (JPH - Jobs Per Hour), current shift configuration, AGV integration flags, PLC/SCADA system references, and operational status. Owned by manufacturing as the SSOT for line-level capacity and configuration. | 42 |
| facility_operations | work_center | master_data | Master record for individual work centers (stations) within a production line. Captures work center code, name, type (manual, automated, robotic), cycle time standard, takt time, capacity category, shift availability, and associated PLC/SCADA node identifiers. Supports JIS sequencing and MES shop floor execution at the station level. | 45 |
| planning_configuration | production_bom | master_data | Manufacturing Bill of Materials (BOM) record representing the production-level BOM used on the shop floor for a specific vehicle configuration and model year. Distinct from the engineering BOM (eBOM) in the engineering domain — this is the manufacturing BOM (mBOM) as released to production. Captures BOM header (vehicle model, MY, plant, effectivity dates), BOM status, and reference to the engineering change order that authorized it. Managed via SAP PP and Teamcenter PLM BOM transfer. | 46 |
| planning_configuration | production_schedule | master_data | Master production schedule (MPS) record defining planned vehicle production volumes by plant, production line, model, MY (Model Year), and time period (daily, weekly, monthly). Captures scheduled quantity, confirmed quantity, schedule version, freeze horizon, schedule status, and MRP run reference. Integrates with SAP PP MRP and supports capacity planning and supplier call-off generation. | 44 |
| planning_configuration | routing | master_data | Master reference table for routing. Referenced by routing_id. | 31 |

<a id="domain-procurement"></a>

### Domain: Procurement

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| procurement | operations | 2 | Strategic sourcing and procurement operations for direct materials (production parts) and indirect materials (MRO, tooling, services). Manages supplier contracts, SOR (Statement of Requirements), purchase requisitions, purchase orders, goods receipt, invoice verification, and spend analytics. Includes global sourcing strategies, supplier development programs, and CapEx procurement workflows. Integrates with SAP MM and Ariba for procure-to-pay processes. | 9 |

**Subdomains:** order_processing, vendor_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| order_processing | procurement_goods_receipt | transactional_data | Record of physical receipt of materials or services at an Automotive plant or warehouse against a purchase order or scheduling agreement. Captures GR document number, posting date, material document number, plant, storage location, received quantity, unit of measure, batch number, quality inspection lot reference, GR slip number, and movement type (101 standard GR, 103 GR blocked stock). Triggers inventory update and initiates three-way match for invoice verification. Sourced from SAP MM material document (MSEG/MKPF). | 34 |
| order_processing | procurement_po_line | transactional_data | Individual line item within a purchase order, representing a specific material, service, or part number being procured. Captures line number, material number, short text, quantity ordered, unit of measure, net price, delivery date, storage location, batch management flag, PPAP level required, over/under-delivery tolerance, and line-level confirmation status. Enables granular spend tracking and goods receipt matching at the part level. Sourced from SAP MM PO item table (EKPO). | 45 |
| order_processing | procurement_purchase_order | transactional_data | Legally binding procurement document issued to a supplier for delivery of direct materials, indirect materials, MRO, tooling, or services. Captures PO number, PO type (standard, blanket, consignment, subcontracting, service), supplier, plant, delivery date, incoterms, payment terms, total net value, currency, tax code, account assignment, approval workflow status, and GR/IR (Goods Receipt/Invoice Receipt) control flags. Core transactional entity of the procure-to-pay process. Sourced from SAP MM (EKKO/EKPO). | 31 |
| order_processing | purchase_requisition | transactional_data | Internal request to procure direct or indirect materials, tooling, or services. Captures requisition number, requestor, cost center, plant, material/service description, quantity, required delivery date, estimated value, account assignment category (cost center, project, asset), approval status, and conversion-to-PO status. Represents the demand signal that initiates the procure-to-pay cycle. Sourced from SAP MM MRP-generated or manually created purchase requisitions (BANF/EBAN). | 33 |
| order_processing | supplier_invoice | transactional_data | Supplier-submitted invoice for goods or services delivered to Automotive, processed through SAP MM invoice verification (Logistics Invoice Verification - LIV). Captures invoice number, supplier invoice reference, invoice date, posting date, gross amount, tax amount, currency, payment terms, due date, three-way match status (PO/GR/Invoice), tolerance check result, blocking reason, and payment status. Enables accounts payable processing and spend actuals capture. Sourced from SAP MM invoice document (RBKP/RSEG). | 45 |
| vendor_management | approved_vendor_list | master_data | Formally approved supplier-material combination (AVL) authorizing a specific supplier to supply a specific part number or commodity to Automotive plants. Captures AVL entry date, approval status (approved, conditional, disqualified), PPAP approval level, quality rating threshold, preferred supplier flag, backup supplier flag, single-source justification, and expiry date. Governs which suppliers are eligible to receive purchase orders for specific materials. Integrates with SAP MM source list (EORD). | 31 |
| vendor_management | info_record | master_data | Purchasing info record storing the commercial relationship between a supplier and a specific material or service category, including the last negotiated price, price validity period, planned delivery time, over/under-delivery tolerance, reminder days, and vendor evaluation score. Serves as the default pricing and delivery condition source when creating purchase orders. Sourced from SAP MM purchasing info record (EINE/EINA/ME11). | 28 |
| vendor_management | procurement_supplier | master_data | Master record for all suppliers and vendors providing direct materials (production parts, raw materials) and indirect materials (MRO, tooling, services) to Automotive. Captures supplier identity, classification (tier-1, tier-2, tier-3), business registration details, DUNS number, tax identifiers, payment terms, currency, incoterms, preferred language, supplier status (active, blocked, under-development), IATF 16949 certification status, ISO 9001/14001 certification flags, geographic footprint, commodity specialization, and strategic sourcing category. SSOT for supplier identity within the procurement domain; integrates with SAP MM vendor master. | 45 |
| vendor_management | supplier_contract | master_data | Long-term procurement contract (outline agreement) with a supplier covering pricing, volume commitments, delivery schedules, quality requirements, and commercial terms for direct or indirect materials. Captures contract type (value contract, quantity contract, scheduling agreement), validity period, target value, release order documentation requirement, price escalation clauses, penalty terms, and contract status. Supports blanket PO releases and scheduling agreement delivery lines. Sourced from SAP MM contract (EKKO with doc type MK/WK). | 32 |

<a id="domain-quality"></a>

### Domain: Quality

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| quality | operations | 3 | End-to-end quality assurance and control across design, manufacturing, and field operations. Owns APQP plans, FMEA (Failure Mode and Effects Analysis), SPC (Statistical Process Control) data, inspection plans, quality audits, defect tracking, and PPM rates. Includes incoming material inspection, in-process quality gates, final vehicle PDI (Pre-Delivery Inspection), NCAP/WLTP test results, and corrective action (8D, 5-Why) processes. Supports IATF 16949 compliance. | 11 |

**Subdomains:** issue_resolution, process_control, supplier_validation


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| issue_resolution | corrective_action | transactional_data | Corrective and Preventive Action (CAPA) record managing the structured problem-solving process for quality escapes and non-conformances. Supports 8D (Eight Disciplines) and 5-Why methodologies. Captures problem statement, containment actions (D3), root cause analysis (D4/5-Why), permanent corrective actions (D5), verification of effectiveness (D6), and preventive action deployment (D7). Tracks open/closed status and due dates. | 20 |
| issue_resolution | defect_record | transactional_data | Operational record of a quality defect or non-conformance identified at any stage — incoming material, in-process assembly, final inspection, or field. Captures defect code, defect description, location on vehicle (zone/component), severity classification, detection method, quantity affected, containment action taken, and disposition (rework, scrap, use-as-is). Sourced from Apriso/Dassault MES quality control module. | 45 |
| issue_resolution | root_cause_analysis | master_data | Master reference table for root_cause_analysis. Referenced by root_cause_analysis_id. | 27 |
| process_control | characteristic | master_data | Master reference table for characteristic. Referenced by characteristic_id. | 21 |
| process_control | control_plan | master_data | Quality control plan defining the process controls, inspection methods, measurement systems, reaction plans, and control characteristics for each manufacturing operation or assembly step. Links to PFMEA and inspection plans. Specifies sample sizes, frequencies, control methods (SPC, attribute, visual), and responsible functions per IATF 16949 requirements. | 36 |
| process_control | inspection_characteristic | association_data | This association product represents the inspection requirement between an inspection plan and a characteristic. It captures the specific measurement instructions, tolerances, sampling rules, and acceptance criteria that apply when a particular characteristic is inspected under a particular inspection plan. Each record links one inspection_plan to one characteristic with attributes that exist only in the context of this inspection requirement.. Existence Justification: In automotive quality management (IATF 16949 / VDA standards), an inspection plan is explicitly structured as a collection of multiple characteristics to be inspected, and each characteristic can appear in multiple inspection plans (e.g., 'bore diameter' is inspected in incoming material plans, in-process plans, and final vehicle PDI plans). The business actively manages 'inspection characteristics' or 'inspection plan lines' as operational entities with plan-specific measurement instructions, tolerances, sampling rules, and acceptance criteria that vary by context. | 16 |
| process_control | inspection_lot | transactional_data | Transactional record of a quality inspection event triggered for a batch of incoming materials, WIP assemblies, or finished vehicles. Captures lot origin (goods receipt, production order, delivery), inspection type, quantity inspected, inspection start/end timestamps, assigned inspector, and overall usage decision (accept, reject, conditional release). Sourced from SAP QM inspection lot management. | 39 |
| process_control | inspection_plan | master_data | Detailed inspection plan specifying the characteristics to be measured, measurement methods, gauges/instruments, tolerances, sample sizes, and acceptance criteria for incoming material, in-process, and final vehicle inspections. Supports incoming material inspection (IQC), in-process quality gates, and PDI (Pre-Delivery Inspection). Linked to SAP QM inspection lots. | 43 |
| process_control | inspection_result | transactional_data | Individual characteristic measurement result recorded during an inspection lot. Captures the measured value or attribute outcome, tolerance limits, pass/fail status, measurement instrument used, and inspector ID for each characteristic within an inspection plan. Supports SPC data collection and statistical analysis of process capability (Cp, Cpk). | 29 |
| supplier_validation | audit | transactional_data | Quality system and process audit record capturing planned and unplanned audits conducted at plants, supplier facilities, or dealer service centers. Tracks audit type (system, process, product, layered process audit — LPA), audit scope, audit date, lead auditor, findings count by severity, overall audit score, and closure status. Supports IATF 16949 internal audit requirements and customer-specific requirements (CSR). | 44 |
| supplier_validation | quality_ppap_submission | transactional_data | Production Part Approval Process submission record for a supplier part or internally manufactured component. Tracks PPAP level (1-5), submission reason (new part, engineering change, tooling change), submission date, approval status, and the 18 PPAP elements status (design records, PFMEA, control plan, MSA, capability study, etc.). Supports IATF 16949 supplier quality management. | 9 |

<a id="domain-supply"></a>

### Domain: Supply

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| supply | operations | 3 | Governs the inbound supply chain from tier-1 and tier-2 suppliers through to plant receiving. Owns supplier master data, RFQ (Request for Quotation) events, PPAP (Production Part Approval Process) records, JIT/JIS delivery schedules, inbound logistics, supplier performance metrics (PPM - Parts Per Million defect rates, OTD - On-Time Delivery), and CKD/SKD kit management for global assembly operations. Integrates with SAP MM and PTC Windchill. | 11 |

**Subdomains:** logistics_receiving, procurement_operations, supplier_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| logistics_receiving | inbound_shipment | transactional_data | Tracks an inbound shipment of parts from a supplier plant to an OEM receiving dock. Captures ASN (Advance Shipping Notice) number, carrier, mode of transport (road, rail, air, sea), departure date/time, estimated arrival date/time, actual arrival date/time, total weight, total volume, number of containers/pallets, customs declaration number, and shipment status (in transit, arrived, cleared, received). Integrates with SAP MM inbound delivery (VL31N). | 39 |
| logistics_receiving | supply_goods_receipt | transactional_data | Records the physical receipt and system confirmation of parts delivered by a supplier to an OEM plant. Captures GR document number, posting date, received quantity, accepted quantity, rejected quantity, storage location, batch number, GR type (standard, return, subsequent delivery), and posting status. Triggers inventory update and initiates 3-way invoice matching in SAP MM (MIGO). SSOT for inbound goods confirmation. | 7 |
| procurement_operations | delivery_schedule | transactional_data | JIT/JIS delivery schedule line issued against a scheduling agreement, specifying exact quantities and delivery dates/times for a part to a plant dock. Captures schedule line date, time, required quantity, cumulative quantity, schedule type (firm, forecast, JIS sequence), dock door, and transmission status (sent, acknowledged, revised). Drives supplier production and logistics planning. Sourced from SAP MM schedule lines (EKET). | 10 |
| procurement_operations | scheduling_agreement | master_data | Long-term supply agreement with a supplier defining the framework for JIT/JIS delivery of parts over a model year or contract period. Captures agreement number, validity start/end dates, target annual volume, release horizon (firm/forecast weeks), delivery rhythm (daily, weekly), Kanban flag, and agreement status. The scheduling agreement is the backbone of JIT supply in SAP MM (ME31L/ME32L). | 37 |
| procurement_operations | supply_po_line | transactional_data | Individual line item within a purchase order representing a specific part number, quantity, unit price, delivery date, and plant destination. Captures line number, material number, ordered quantity, confirmed quantity, net price, delivery date, goods receipt quantity, and invoice quantity. Enables line-level tracking of delivery performance and invoice matching (3-way match) in SAP MM. | 6 |
| procurement_operations | supply_purchase_order | transactional_data | Legally binding procurement document issued to a supplier authorizing delivery of parts or materials at agreed price and schedule. Captures PO number, PO type (standard, blanket, scheduling agreement), supplier, plant, delivery terms (Incoterms), payment terms, total value, currency, and PO status (open, partially delivered, closed, cancelled). SSOT for purchase commitments; sourced from SAP MM (ME21N/ME22N). | 7 |
| supplier_management | inbound_part | master_data | Master record for every purchased part number sourced from external suppliers. Captures OEM part number, supplier part number cross-reference, commodity group, material type (raw, sub-assembly, CKD kit), unit of measure, PPAP approval status, engineering change level, hazardous material flag, country of origin, and customs tariff code. Bridges SAP MM material master and PTC Windchill parts classification for supply-domain-owned purchased parts. | 35 |
| supplier_management | sourcing_nomination | master_data | Records the formal OEM decision to nominate a specific supplier for a given part or commodity within a model year program. Captures nomination date, program/platform code, nominated supplier, awarded annual volume, target piece price, SOR (Statement of Requirements) reference, nomination status (nominated, confirmed, withdrawn), and the responsible commodity buyer. Precedes the RFQ and PPAP process. SSOT for sourcing award decisions; distinct from procurement domain's strategic sourcing strategy — this is the operational award record. | 26 |
| supplier_management | supplier_scorecard | transactional_data | Periodic (monthly/quarterly) performance evaluation record for a supplier across key KPIs including PPM (Parts Per Million defect rate), OTD (On-Time Delivery percentage), delivery quantity accuracy, PPAP on-time completion rate, responsiveness score, and overall supplier rating. Captures evaluation period, scoring methodology version, individual KPI values, weighted total score, performance tier (preferred, approved, conditional, disqualified), and corrective action flag. | 29 |
| supplier_management | supply_ppap_submission | transactional_data | Production Part Approval Process submission record tracking the formal approval of a supplier's manufacturing process for a specific part. Captures PPAP level (1–5), submission date, part number, supplier, engineering change level, submission reason (new part, engineering change, tooling move), PPAP elements checklist status, PSW (Part Submission Warrant) status, and approval/rejection date. Integrates with PTC Windchill and SAP QM. SSOT for PPAP compliance. | 10 |
| supplier_management | supply_supplier | master_data | Master record for all tier-1 and tier-2 suppliers in the automotive supply chain. Captures supplier identity, classification (direct/indirect, tier level), IATF 16949 certification status, DUNS number, geographic footprint, commodity codes, preferred currency, payment terms, and supplier lifecycle status (active, probation, disqualified). SSOT for supplier identity within the supply domain; integrates with SAP MM vendor master and PTC Windchill supplier collaboration. | 2 |

<a id="domain-vehicle"></a>

### Domain: Vehicle

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| vehicle | operations | 3 | SSOT for all vehicle master data across the enterprise. Owns VIN-level vehicle identity, model configurations, trim levels, MY (Model Year) lifecycle from SOP (Start of Production) to EOP (End of Production), powertrain variants (ICE, HEV, PHEV, EV), platform architectures, and ADAS feature sets. Serves as the authoritative reference for every downstream domain that needs to identify or describe a vehicle instance. | 11 |

**Subdomains:** commercial_terms, physical_inventory, product_catalog


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| commercial_terms | msrp_pricing | master_data | Manages the MSRP (Manufacturer Suggested Retail Price) schedule for vehicle configurations, trim levels, and option packages by market and MY. Captures base MSRP, destination and delivery charge, gas guzzler tax (if applicable), federal EV tax credit eligibility, effective date, expiry date, currency, and market region. Provides the authoritative pricing reference for dealer ordering, window sticker generation, and sales analytics. Distinct from dealer invoice pricing (owned by billing domain). | 30 |
| commercial_terms | ownership | association_data | This association product represents the ownership relationship between a vehicle (vin_registry) and a party (customer). It captures acquisition and disposition dates, ownership type, and ownership number, tracking the history of which parties own which vehicles.. Existence Justification: A vehicle can be owned by multiple parties over its lifecycle (e.g., resale), and a party can own multiple vehicles simultaneously. The business actively records each ownership event with dates, type, and ownership number, and users query ownership history for warranty, service, recall, and resale analytics. | 9 |
| physical_inventory | build_spec | master_data | The as-built specification record for a specific VIN, capturing the exact combination of configuration, options, colors, powertrain, and features installed on that vehicle unit as it rolled off the production line. Captures VIN reference, configuration code, exterior color, interior trim selection, all installed option codes, actual build date, plant code, production sequence number, and any deviation from standard specification (e.g., special order, fleet spec, running change). This is the definitive as-built record used by aftersales, warranty, recall population identification, and residual value analytics. | 31 |
| physical_inventory | lifecycle_event | transactional_data | Transactional log of significant lifecycle state transitions for a specific VIN throughout its life. Captures event type (manufactured, PDI-completed, shipped-to-dealer, sold-retail, sold-fleet, exported, titled, re-acquired, scrapped, stolen, total-loss), event timestamp, event location, responsible party, odometer reading at event, and triggering system. Provides the complete lifecycle audit trail for a vehicle unit from production to end-of-life, supporting title history, recall tracking, and residual value analytics. | 29 |
| physical_inventory | vin_registry | master_data | SSOT for every physical vehicle instance identified by its 17-character VIN per ISO 3779. Captures decoded VIN structure (WMI, VDS, VIS), manufacturing plant code, production sequence number, build date, model year (MY), line-off timestamp, homologation market, and current lifecycle status (pre-production, in-production, in-transit, in-service, end-of-life). This is the enterprise anchor record — the single identity key — that every downstream domain (sales, aftersales, logistics, mobility, finance) references to identify a specific vehicle unit. | 33 |
| product_catalog | configuration | master_data | The fully specified, buildable vehicle configuration combining model, MY, trim, powertrain, and market. Each record represents a unique orderable specification (analogous to a manufacturing SKU or dealer order code). Captures configuration code, market region, build feasibility status, MSRP, destination charge, fuel economy label values, emissions certification status, and production plant assignment. This is the master configuration record that bridges product planning to manufacturing BOM explosion and dealer order management. | 37 |
| product_catalog | homologation | master_data | Tracks the regulatory type-approval and homologation status of vehicle configurations for each target market. Captures homologation type (whole vehicle type approval, component approval), regulatory framework (FMVSS, ECE, NCAP, CARB, EPA), approval authority, certificate number, approval date, expiry date, applicable model/MY/market, emissions standard tier (e.g., EPA Tier 3, Euro 6d), and compliance status. Critical for market launch readiness and regulatory reporting. | 27 |
| product_catalog | model | master_data | Defines the commercial vehicle model (nameplate) as a business entity — e.g., F-150, Camry, Model 3. Captures model name, brand/marque, vehicle segment (sedan, SUV, pickup, commercial), body style, drive configuration (FWD, RWD, AWD, 4WD), primary market, launch MY, EOP MY, and program code. Serves as the top-level classification anchor for all vehicle configurations and trim hierarchies. | 45 |
| product_catalog | option_package | master_data | Defines factory-installed option packages, standalone options, exterior colors, and interior trim selections available for vehicle configurations. Captures option code, option name, option type (package, standalone, accessory, exterior color, interior trim), MSRP uplift, content description, availability constraints (trim/market/powertrain restrictions), mutually exclusive options, and required prerequisite options. Drives dealer order configuration, window sticker (Monroney label) generation, and BOM explosion in manufacturing. | 6 |
| product_catalog | platform | master_data | Defines the vehicle platform (architecture) that underpins one or more models. Captures platform code, platform name, architecture generation, wheelbase range, track width range, structural material strategy (steel, aluminum, mixed), compatible powertrain families, maximum GVW rating, and platform owner business unit. Platforms are shared across multiple nameplates and model years, making this a critical cross-model reference for engineering, manufacturing, and supply chain. | 37 |
| product_catalog | powertrain_variant | master_data | Authoritative catalog of all powertrain configurations available across the vehicle lineup. Captures powertrain type (ICE, HEV, PHEV, BEV, FCEV), engine displacement, cylinder count, fuel type, electric motor peak power (kW), combined system power, transmission type, drive type, EPA/WLTP fuel economy or range rating, CO2 emissions (g/km), battery capacity (kWh for EV/PHEV), and charging standard (CCS, CHAdeMO, NACS). Used for homologation, CAFE compliance, and consumer-facing specifications. | 31 |

<a id="domain-aftersales"></a>

### Domain: Aftersales

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| aftersales | business | 3 | Post-sale customer support including warranty management, service campaigns, recall execution, and parts distribution. Manages service appointments, repair orders, TSB (Technical Service Bulletin) distribution, DTC (Diagnostic Trouble Code) analysis, and labor time standards. Tracks warranty claims, parts consumption, service revenue, and customer retention. Includes field service operations and authorized service center network management. Integrates with CDK Global DMS and OBD (On-Board Diagnostics) systems. | 11 |

**Subdomains:** parts_distribution, service_operations, warranty_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| parts_distribution | parts_order | transactional_data | Parts order placed by a dealer or service center to the OEM parts distribution center (PDC) or regional warehouse. Captures order number, ordering dealer code, PDC fulfillment location, order date, requested delivery date, order type (stock, emergency, campaign/recall, special), order status (submitted, confirmed, picked, shipped, received, invoiced), total order value, freight terms, and backorder flags. Integrates with SAP MM and dealer DMS parts ordering module. | 26 |
| parts_distribution | service_part | master_data | Aftersales service parts master record for parts stocked and consumed in dealer service and repair operations. Captures OEM part number, supersession chain (current and all prior part numbers), part description, part category (mechanical, electrical, body, consumable, fluid, accessory), unit of measure, standard list price, dealer net price, core charge amount, weight, hazmat flag, country of origin, minimum order quantity, and lifecycle status (active, superseded, discontinued, obsolete). Serves as the aftersales-specific view of the parts catalog optimized for service ordering and warranty claims — distinct from the manufacturing BOM parts master in the engineering domain. | 35 |
| service_operations | aftersales_repair_order | transactional_data | Core transactional record capturing a vehicle service or repair event at an authorized service center or dealership. Tracks RO number, vehicle VIN, customer, service advisor, open/close dates, labor operations performed, parts consumed, total labor cost, total parts cost, total RO value, payment method, warranty vs. customer pay vs. internal pay type, DMS source (CDK Global), mileage at write-up, promised completion time, actual completion time, technician assignments, and RO status lifecycle (open, in-progress, quality-check, closed, invoiced). | 51 |
| service_operations | aftersales_service_appointment | transactional_data | Scheduled service appointment record for a vehicle at a dealership or authorized service center. Captures appointment date/time, customer contact, VIN, service type (maintenance, warranty repair, recall, PDI, customer pay), service advisor assigned, estimated duration, transportation option (loaner, shuttle, wait), appointment source (online, phone, DMS, mobile app), confirmation status, check-in time, and no-show flag. Sourced from CDK Global DMS scheduling module. | 44 |
| service_operations | repair_order_line | transactional_data | Individual labor operation or job line within a repair order. Captures operation code, labor time standard (flat-rate hours), actual technician hours, labor rate, line total, technician ID, cause/complaint/correction (3C) narrative, warranty flag, sublet flag, and line status. Supports granular cost analysis and technician productivity tracking per CDK Global DMS job line structure. | 37 |
| service_operations | service_center | master_data | Master record for authorized service centers and dealership service departments in the OEM aftersales network. Captures service center code, name, address, dealer group affiliation, authorization level (warranty, recall, certified collision, EV-certified, ADAS-calibration), service bay count, technician headcount, CDK Global DMS instance ID, operating hours, loaner fleet size, and network status (active, suspended, terminated). Distinct from the dealer domain's dealer profile — this is the service-operations-specific view. | 40 |
| service_operations | technician | master_data | Master record for service technicians employed at authorized service centers. Captures technician ID, name, service center assignment, certification level (ASE, OEM-certified, EV-certified, ADAS-certified), specialization (powertrain, electrical, body, diagnostics), flat-rate efficiency rating, current active RO count, hire date, and certification expiry dates. This is the aftersales-specific technician profile focused on service capacity and certification — distinct from the workforce domain's employee record. | 26 |
| warranty_management | service_campaign | master_data | Master record for a service campaign (recall or non-safety field action) issued by the OEM. Captures NHTSA recall number, campaign code, campaign type (safety recall, emissions recall, customer satisfaction program, technical service bulletin action), affected nameplate/model year range, affected VIN population count, remedy description, estimated repair time, parts required, campaign open date, campaign close date, regulatory reporting status, and NHTSA/UNECE compliance flags. Integrates with NHTSA recall database and SAP QM. | 35 |
| warranty_management | vehicle_warranty | master_data | VIN-level warranty entitlement record linking a specific vehicle to its applicable warranty policies. Tracks warranty start date (in-service date), expiration date, remaining months, remaining mileage, warranty status (active, expired, voided), extended warranty flag, CPO (Certified Pre-Owned) warranty flag, and any warranty transfer history. This is the SSOT for whether a specific vehicle is under warranty at any point in time. | 47 |
| warranty_management | warranty_claim | transactional_data | Warranty claim submitted by a dealer or authorized service center to the OEM for reimbursement of warranty-covered repairs. Tracks claim number, VIN, repair order reference, failure date, repair date, claim submission date, claim status (submitted, approved, rejected, adjusted, paid), approved labor hours, approved parts cost, total claim amount, rejection reason code, goodwill flag, campaign/recall linkage, and OEM adjudication outcome. Integrates with SAP SD warranty module and CDK Global DMS. | 42 |
| warranty_management | warranty_policy | master_data | Master definition of warranty coverage terms applicable to a vehicle nameplate, model year, powertrain type, or market. Captures warranty type (basic/bumper-to-bumper, powertrain, corrosion, emissions, EV battery, ADAS), coverage duration in months, coverage distance in miles/km, deductible amount, transferability flag, market/region applicability, SOP and EOP dates, and governing regulatory body (NHTSA, EPA). Serves as the authoritative reference for warranty eligibility determination. | 33 |

<a id="domain-customer"></a>

### Domain: Customer

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| customer | business | 3 | SSOT for all customer identities including retail buyers, fleet operators, corporate accounts, and government entities. Manages customer profiles, contact information, preferences, vehicle ownership history, loyalty program membership, household linkages, and customer segmentation. Tracks NPS (Net Promoter Score), CLTV (Customer Lifetime Value), and customer journey touchpoints. Supports both B2C and B2B customer types with unified identity management. Integrates with Salesforce Automotive Cloud. | 10 |

**Subdomains:** identity_management, ownership_services, support_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| identity_management | contact_point | master_data | Stores all contact information for a party (individual or organization) including email addresses, phone numbers, mailing addresses, and social media handles. Each record captures: contact point type (email/phone/address/social), contact point value, is_primary flag, is_verified flag, verification date, verification method, opt-in status, opt-out date, channel (voice/SMS/email/mail/push), preferred time zone, preferred contact hours, source system, and effective/expiry dates. Supports omnichannel communication, regulatory compliance (TCPA, CAN-SPAM, GDPR), and Salesforce Automotive Cloud contact synchronization. | 32 |
| identity_management | individual | master_data | B2C retail customer profile extending the party master for natural persons. Captures personal identity attributes: first name, middle name, last name, suffix, gender, marital status, employment status, occupation, annual income band, education level, driver license number, driver license state/country, driver license expiry, primary spoken language, nationality, country of residence, household_id (FK to household), loyalty tier, NPS score (latest), CLTV estimate, preferred contact method, marketing opt-in flags, and Salesforce Contact ID. Supports personalized marketing, loyalty management, and customer journey analytics for retail vehicle buyers. | 44 |
| identity_management | organization_account | master_data | B2B customer profile for corporate accounts, fleet operators, government entities, and leasing companies. Extends the party master with organization-specific attributes: legal entity name, DBA name, parent company party_id (for corporate hierarchy), DUNS number, SIC/NAICS code, annual revenue, number of employees, fleet size, procurement contact name, accounts payable contact, credit limit, payment terms, preferred OEM programs, government entity type (federal/state/municipal), contract vehicle type (GSA/state contract), Salesforce Account ID, SAP customer number, and account tier (strategic/key/standard). Enables B2B fleet sales, government procurement, and corporate account management. | 35 |
| identity_management | party | master_data | SSOT master entity for all customer identities served by Automotive — retail buyers (B2C), fleet operators, corporate accounts, government entities, and dealer principals. Stores the unified identity record including party type (individual/organization), legal name, tax identification, registration number, preferred language, preferred currency, date of birth (for individuals), incorporation date (for organizations), industry classification (NAICS/SIC), credit rating, KYC status, GDPR consent flags, data residency region, source system (Salesforce Automotive Cloud party ID), onboarding channel, onboarding date, lifecycle status (prospect/active/inactive/churned), and last verified date. This is the anchor entity for all customer-domain relationships. | 43 |
| identity_management | preference | master_data | Stores customer-declared and inferred preferences for communications, vehicle features, service scheduling, and digital experiences. Each record captures: party_id, preference category (communication/vehicle/service/digital/privacy), preference key (e.g., preferred_fuel_type, preferred_body_style, preferred_service_day, email_frequency), preference value, value data type (string/boolean/integer/list), source (self-declared/inferred/imported), confidence score, effective date, expiry date, and last updated timestamp. Supports personalized marketing, product recommendation engines, and connected vehicle feature configuration. | 16 |
| ownership_services | connected_vehicle | master_data | Master registry of all connected vehicles enrolled in mobility and telematics services. Owns the connected device identity per VIN, connectivity hardware profile (Geotab/Bosch IoT device), SIM/eSIM identifiers, connectivity tier, activation status, OTA capability flags, V2X capability flags, and TPMS sensor registration. This is the SSOT for connected vehicle device identity within the mobility domain, distinct from the vehicle master in the vehicle domain which owns VIN-level manufacturing identity. Links to telematics_device for hardware asset details. | 48 |
| ownership_services | loyalty_membership | master_data | Manages customer enrollment and status in Automotive loyalty programs (e.g., owner rewards, EV early adopter program, fleet loyalty). Captures: program_id, party_id, membership number, enrollment date, enrollment channel, current tier (bronze/silver/gold/platinum), tier qualification date, tier expiry date, points balance, lifetime points earned, points expiry date, redemption eligibility flag, referral code, referred_by party_id, preferred redemption category, program status (active/suspended/expired/cancelled), and Salesforce Loyalty Management program member ID. Enables tier-based benefits, points accrual/redemption, and retention marketing. | 33 |
| ownership_services | vehicle_ownership | transactional_data | Tracks the ownership history of vehicles by customers — the authoritative record linking a customer (party) to a VIN. Captures: VIN, party_id (owner), ownership type (retail purchase/lease/fleet/government), acquisition date, acquisition channel (dealer/direct/auction/fleet), acquisition dealer code, purchase price, trade-in VIN, registration state/country, registration number, registration expiry, title number, title state, lien holder name, insurance carrier, insurance policy number, insurance expiry, odometer at acquisition, current odometer (last reported), is_primary_vehicle flag, disposition type (sold/traded/totaled/repossessed), disposition date, and disposition odometer. SSOT for customer-vehicle relationship; cross-references vehicle domain VIN master. | 35 |
| support_operations | case | transactional_data | Customer service case record tracking complaints, inquiries, warranty claims, recall notifications, and roadside assistance requests raised by customers through any channel. Captures: party_id, VIN (if vehicle-related), case number, case type (complaint/inquiry/warranty_claim/recall/roadside/goodwill/lemon_law/regulatory), case category, case sub-category, subject, description, priority (P1-P4), status (new/in_progress/pending_customer/resolved/closed/escalated), opened date, SLA due date, resolved date, closed date, resolution code, resolution description, dealer code (if dealer-handled), assigned agent ID, escalation level, escalation reason, total handle time (minutes), customer satisfaction score (post-resolution), Salesforce Case ID, and Microsoft Dynamics 365 Case ID. SSOT for customer service operations. | 32 |
| support_operations | predictive_maintenance_alert | transactional_data | Operational alert record generated when telematics and DTC data patterns indicate an impending vehicle component failure or maintenance need. Captures alert generation timestamp, VIN reference, affected component or system, predicted failure window, confidence level, alert severity, recommended service action, alert status (open/acknowledged/resolved/expired), and resolution timestamp. Distinct from a DTC event (which is a raw fault code) — this is a processed, actionable maintenance recommendation. | 21 |

<a id="domain-dealer"></a>

### Domain: Dealer

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| dealer | business | 4 | Dealer network management including dealer profiles, franchise agreements, territory assignments, and dealer performance scorecards. Manages dealer inventory allocation, vehicle allocation rules, dealer incentive programs, and DMS (Dealer Management System) integration. Tracks dealer sales performance, customer satisfaction scores, service capacity, and parts inventory at dealer locations. Supports both OEM-owned and independent franchise dealer models. Integrates with CDK Global DMS. | 10 |

**Subdomains:** inventory_operations, network_management, sales_transactions, service_delivery


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| inventory_operations | dealer_inventory | master_data | Real-time inventory of vehicles physically on-hand or in-transit at a dealership. Tracks VIN, nameplate, model year, trim, exterior/interior color, powertrain, days-on-lot, acquisition cost, current asking price, inventory status (available, sold, demo, loaner, in-transit), and PDI (Pre-Delivery Inspection) completion flag. Sourced from CDK Global DMS inventory module. | 47 |
| inventory_operations | parts_inventory | master_data | Dealer-level parts and accessories inventory managed through the CDK Global DMS parts module. Tracks OEM part number, SKU, description, quantity on hand, quantity on order, bin location, reorder point, supersession chain, price, and parts classification (mechanical, body, electrical, accessories). Supports service operations and parts counter sales. | 46 |
| inventory_operations | vehicle_allocation | transactional_data | Records the OEM's allocation of specific vehicle units (by VIN or allocation batch) to a dealership for a given model year and production period. Captures allocation quantity, nameplate, trim, powertrain type (ICE/HEV/PHEV/EV), allocation rule applied, priority tier, acceptance status, and delivery window. Core operational record linking manufacturing output to dealer inventory pipeline. | 39 |
| network_management | dealership | master_data | Master record for each dealer location in the OEM franchise network. Captures dealer legal entity, DMS (Dealer Management System) integration identifiers (CDK Global), franchise type (OEM-owned vs independent), physical address, contact details, operational status, market region, and channel classification. This is the SSOT for dealer identity across the enterprise. | 47 |
| network_management | franchise_agreement | master_data | Formal franchise contract between the OEM and an independent or OEM-owned dealer. Tracks agreement effective dates, expiration, renewal terms, franchise tier, authorized vehicle lines (nameplates), territory rights, performance obligations, and agreement status. Supports both new franchise grants and renewals. | 45 |
| network_management | territory | master_data | Geographic sales territory assigned to a dealership. Defines primary area of responsibility (PAR), zip/postal code coverage, county or region boundaries, territory type (exclusive, shared, open), effective dates, and overlap rules. Used for vehicle allocation, market representation planning, and dealer performance benchmarking. | 40 |
| sales_transactions | demo_vehicle | master_data | Dealer demonstrator vehicle program records tracking vehicles designated as demos for test drives and sales staff use. Captures VIN, demo designation date, assigned salesperson or manager, mileage allowance, demo period end date, demo status, and disposition (converted to used sale, returned to stock, auctioned). Governed by OEM demo vehicle policy. | 38 |
| sales_transactions | retail_sale | transactional_data | Records the retail sale of a new or used vehicle by a dealership to an end customer. Captures VIN, sale date, sale price, MSRP, discount amount, trade-in details, financing type (cash, retail finance, lease), F&I products sold, salesperson, and deal status. Sourced from CDK Global DMS F&I module. SSOT for dealer-level vehicle sales transactions. | 47 |
| service_delivery | dealer_repair_order | transactional_data | Detailed repair order (RO) record for each vehicle service event at a dealership. Captures RO number, open/close dates, VIN, mileage-in, complaint/cause/correction (3C), labor operations, technician assignments, parts consumed, warranty vs customer-pay vs internal split, total labor hours, total parts cost, and RO status. Core operational record for dealer service operations sourced from CDK Global DMS. | 8 |
| service_delivery | dealer_service_appointment | transactional_data | Scheduled service appointments at a dealership for vehicle maintenance, warranty repair, recall service, or customer-pay work. Tracks appointment date/time, customer, VIN, service type, advisor assigned, estimated duration, appointment status (scheduled, checked-in, in-progress, completed, no-show), and transportation option (loaner, shuttle, wait). Sourced from CDK Global DMS service scheduling module. | 8 |

<a id="domain-sales"></a>

### Domain: Sales

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| sales | business | 3 | Sales operations including lead management, opportunity tracking, quote generation, order capture, and sales performance analytics. Manages MSRP (Manufacturer Suggested Retail Price), incentive programs, fleet sales, and commercial vehicle contracts. Tracks sales pipeline, conversion rates, and regional sales performance. Integrates with dealer networks and Salesforce Automotive Cloud for unified sales execution across direct and indirect channels. Interfaces with SAP SD. | 10 |

**Subdomains:** commercial_accounts, order_fulfillment, revenue_pipeline


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| commercial_accounts | fleet_contract | master_data | Commercial agreement governing the sale or lease of multiple vehicles to a fleet customer (corporate, government, rental, utility). Captures fleet account reference, contracted volume commitments, agreed pricing tiers, eligible nameplates and model years, contract term, delivery schedule, fleet incentive program linkage, and contract status. Supports national fleet accounts and government procurement contracts. Distinct from retail sales orders due to volume pricing, multi-delivery scheduling, and contract lifecycle management. | 47 |
| commercial_accounts | telemetry_event | transactional_data | High-frequency transactional record of raw and processed telematics events streamed from connected vehicles via Geotab or Bosch IoT. Each record captures event timestamp, VIN reference, GPS coordinates (latitude, longitude, altitude), vehicle speed, heading, ignition state, odometer reading, fuel level, battery state of charge (for EV/HEV), engine RPM, and event type code. Silver layer record represents cleansed and deduplicated stream from the bronze ingestion layer. | 38 |
| order_fulfillment | delivery_appointment | transactional_data | Scheduled vehicle delivery appointment for a confirmed vehicle order, coordinating the handover of a new vehicle to the customer at a dealer or direct delivery point. Captures scheduled delivery date and time, delivery location, assigned delivery specialist, PDI (Pre-Delivery Inspection) completion status, customer confirmation status, and actual delivery completion timestamp. Triggers post-delivery customer satisfaction follow-up. | 47 |
| order_fulfillment | order_line | transactional_data | Individual line item within a vehicle order representing a specific vehicle unit, accessory, extended warranty, or service contract. Captures VIN assignment (when available), model code, trim level, exterior/interior color, option packages, unit net price, quantity, and line fulfillment status. Supports multi-unit fleet orders with individual VIN-level tracking per line. | 44 |
| order_fulfillment | trade_in | transactional_data | Record of a customer vehicle trade-in evaluated and accepted as part of a new vehicle purchase transaction. Captures trade-in vehicle details (VIN, make, model, year, mileage, condition grade), appraised value, agreed trade-in allowance, appraisal date, appraising dealer, and disposition (wholesale auction, certified pre-owned, retail resale). Links to the associated vehicle order. | 41 |
| order_fulfillment | vehicle_order | transactional_data | Confirmed customer vehicle purchase order capturing the commercial commitment to buy a specific configured vehicle. Records order type (retail, fleet, government, export), ordered VIN or build-to-order configuration, agreed selling price, payment method, financing reference, delivery commitment date, and order status lifecycle (placed, confirmed, in-production, shipped, delivered). Interfaces with SAP SD sales order (VA01) and triggers manufacturing scheduling. | 45 |
| revenue_pipeline | incentive_program | master_data | Master record for OEM-sponsored sales incentive programs including customer cash rebates, dealer cash allowances, low-APR financing offers, lease support, conquest bonuses, loyalty rewards, and fleet incentives. Captures program code, program type, eligible model year and nameplate, start and end dates, maximum incentive amount, funding source (OEM vs regional), stackability rules, and eligibility criteria. Managed centrally and distributed to dealer network. | 15 |
| revenue_pipeline | opportunity | transactional_data | Core sales opportunity record tracking a potential vehicle sale from initial identification through close. Captures prospect vehicle interest, estimated deal value, probability of close, sales stage, assigned sales representative, source channel, and expected close date. Aligns with Salesforce Automotive Cloud Opportunity object and SAP SD pre-sales pipeline. Covers retail, fleet, and commercial vehicle opportunities. | 44 |
| revenue_pipeline | quote | transactional_data | Formal vehicle sales quotation issued to a prospect or customer, detailing configured vehicle, MSRP, applied incentives, trade-in allowance, financing terms, accessories, and net selling price. Tracks quote version, expiry date, quote status, and issuing dealer or direct sales channel. Supports retail, fleet, and CKD/SKD export quotes. Linked to SAP SD quotation (VA21) and Salesforce Automotive Cloud Quote. | 64 |
| revenue_pipeline | quote_line | transactional_data | Individual line item within a vehicle sales quote, representing a specific vehicle configuration, accessory, service package, or fee. Captures line type, configured model code, option packages, unit price, discount amount, incentive applied, and line-level tax. Enables multi-vehicle fleet quotes and accessory bundling. Child entity of quote. | 43 |

## Metric Views

Total metric views generated: **90**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | inventory_finished_vehicle_stock | inventory | finished_vehicle_stock | Finished Vehicle Stock business metrics |
| 2 | inventory_goods_movement | inventory | goods_movement | Goods Movement business metrics |
| 3 | inventory_mrp_requirement | inventory | mrp_requirement | Mrp Requirement business metrics |
| 4 | inventory_replenishment_order | inventory | replenishment_order | Replenishment Order business metrics |
| 5 | inventory_service_parts_stock | inventory | service_parts_stock | Service Parts Stock business metrics |
| 6 | inventory_sku_master | inventory | sku_master | Sku Master business metrics |
| 7 | inventory_stock_balance | inventory | stock_balance | Stock Balance business metrics |
| 8 | inventory_stock_transfer_order | inventory | stock_transfer_order | Stock Transfer Order business metrics |
| 9 | inventory_storage_location | inventory | storage_location | Storage Location business metrics |
| 10 | inventory_warehouse | inventory | warehouse | Warehouse business metrics |
| 11 | logistics_carrier | logistics | carrier | Carrier performance and capacity metrics tracking cost efficiency, on-time delivery, safety ratings, and fleet utilization |
| 12 | logistics_freight_invoice | logistics | freight_invoice | Freight invoice financial metrics tracking invoiced amounts, payment status, variances, and approval rates for cost control |
| 13 | logistics_in_transit_inventory | logistics | in_transit_inventory | In-transit inventory metrics tracking transit times, delays, transport costs, and environmental impact for supply chain visibility |
| 14 | logistics_shipment | logistics | shipment | Core shipment performance metrics tracking on-time delivery, freight costs, volume, and weight across transport modes and lanes |
| 15 | logistics_vehicle_handover | logistics | vehicle_handover | Vehicle handover metrics tracking handover completion rates, costs, environmental impact, and on-time delivery for final-mile logistics |
| 16 | logistics_vehicle_transport_order | logistics | vehicle_transport_order | Vehicle transport order metrics tracking delivery performance, transport costs, emissions, and expedited shipment rates |
| 17 | manufacturing_build_sequence | manufacturing | build_sequence | Build Sequence business metrics |
| 18 | manufacturing_capacity_plan | manufacturing | capacity_plan | Capacity Plan business metrics |
| 19 | manufacturing_material_consumption | manufacturing | material_consumption | Material Consumption business metrics |
| 20 | manufacturing_plant | manufacturing | plant | Plant business metrics |

*... and 70 more metric views. See the `metrics/` folder for full details.*