# Semiconductors Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on June 27, 2026 at 11:13 AM

This document outlines a vibed Lakehouse data model for the Semiconductors business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Design](#domain-design)
  - [Equipment](#domain-equipment)
  - [Fabrication](#domain-fabrication)
  - [Inventory](#domain-inventory)
  - [Packaging](#domain-packaging)
  - [Process](#domain-process)
  - [Quality](#domain-quality)
  - [Test](#domain-test)
  - [Customer](#domain-customer)
  - [Invoice](#domain-invoice)
  - [Order](#domain-order)
  - [Product](#domain-product)
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
| `schemas/` | `semiconductors_<domain>_schema_v2_mvm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `semiconductors_catalogs_v2_mvm.sql` (catalog-level DDL) |
| `metrics/` | `semiconductors_<domain>_metrics_v2_mvm.sql` (one file per domain) |
| `docs/` | `semiconductors_model_v2_mvm.xlsx`, `semiconductors_model_v2_mvm.csv`, `releasenotes.txt` |
| `diagram/` | `semiconductors_dbml_v2_mvm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `semiconductors_rdf_v2_mvm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | MVM (Minimum Viable Model) |
| Total Domains | 13 |
| Total Subdomains | 32 |
| Total Products | 122 |
| Total Attributes | 5403 |
| Primary Keys | 122 |
| Foreign Keys | 874 |
| Avg Attributes/Product | 44.3 |
| Metric Views | 104 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Semiconductors | Semiconductors | MVM (Minimum Viable Model) | semiconductors industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-design"></a>

### Domain: Design

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| design | operations | 2 | IC design and architecture lifecycle from RTL specification through GDS/GDSII tapeout. Manages IP cores, PDK libraries, EDA tool flows, DFM and DFT rule sets, logic synthesis, physical design, timing closure data, and MPW shuttle assignments. Integrates with Cadence Virtuoso, Synopsys Design Compiler, and PrimeTime for design data provenance. | 9 |

**Subdomains:** physical_implementation, project_lifecycle


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| physical_implementation | netlist | transactional_data | Synthesized netlist artifact produced by logic synthesis tools (Synopsys Design Compiler) from RTL. Captures netlist type (pre-synthesis, post-synthesis, post-layout), gate count, cell library version, synthesis constraints file reference, timing slack summary, power estimate, and linkage to the RTL specification and PDK version used. Tracks netlist versions across design iterations for design provenance. | 41 |
| physical_implementation | physical_layout | transactional_data | Physical design layout record representing the floorplan, placement, clock tree, and routing state of an IC design at a specific stage in the physical implementation flow. Captures die dimensions and core area, cell utilization percentage, routing congestion metrics by metal layer, DRC violation count and categories, LVS clean status, metal layer stack usage and fill density, power grid IR-drop analysis results, clock tree synthesis (CTS) metrics (skew, insertion delay), electromigration compliance status, antenna rule violations, and GDS/GDSII or OASIS file reference. Tracks physical design iterations from initial floorplan through final tapeout-ready layout in Cadence Innovus, Synopsys ICC2, or Siemens Aprisa. SSOT for physical design state at each iteration checkpoint. | 44 |
| physical_implementation | tapeout | transactional_data | Tapeout event record capturing the final design submission milestone for manufacturing. Records tapeout date, GDS/GDSII file version, mask set identifier, foundry submission reference, PDK version used, final DRC/LVS clean status, OPC/RET processing status, design sign-off checklist completion, NRE cost committed, and MPW shuttle assignment if applicable. SSOT for tapeout provenance linking design to fabrication domain. | 44 |
| project_lifecycle | ic_design_project | master_data | Master record for an IC design project lifecycle from RTL specification through GDS/GDSII tapeout. Captures project identity, target process node, design type (ASIC, SoC, FPGA), PPA targets (power budget, clock frequency, die area), tapeout milestone dates, NRE budget, design team assignments, EDA tool suite version, hierarchical block decomposition, and PLM integration references. SSOT for all design project metadata including block-level partitioning. Managed in Siemens Teamcenter PLM and Oracle Agile PLM. | 43 |
| project_lifecycle | ip_core | master_data | Master catalog of reusable Intellectual Property (IP) cores available for integration into IC designs. Tracks IP type (hard macro, soft IP, firm IP), function category (CPU, GPU, NPU, SerDes, PHY, memory controller, analog, RF), process node compatibility matrix, PPA characterization data, licensing terms and royalty structure, version history, silicon-proven status, EDA tool compatibility, and compliance with industry interface standards (AMBA, PCIe, USB). Sourced from internal IP library and third-party vendors (ARM, Synopsys DesignWare, Cadence Tensilica). SSOT for IP core definitions used across design projects. | 43 |
| project_lifecycle | ip_integration | association_data | This association product represents the integration instance of a reusable IP core into a specific IC design project. It captures the operational relationship between IP cores and design projects, tracking version compatibility, licensing consumption, integration status, and sign-off gates. Each record represents one IP core integrated into one design project with attributes that exist only in the context of this specific integration instance.. Existence Justification: In semiconductor IC design, IP core integration is a recognized operational business process with dedicated workflows, sign-off gates, and license tracking managed in EDA tools (Cadence Virtuoso, Synopsys). A single IP core (e.g., ARM CPU, Synopsys DDR controller) is reused across multiple design projects simultaneously, and each design project integrates multiple IP cores to compose the complete SoC. The business actively manages each integration instance with version selection, license consumption tracking, verification status, and design review sign-offs. | 15 |
| project_lifecycle | pdk | master_data | Process Design Kit (PDK) master record defining the foundry-specific design rules, device models, standard cell libraries, and technology files required for IC design at a given process node. Captures PDK version, foundry name, process node (e.g., 3nm, 5nm, 7nm), SPICE model sets, DRC/LVS rule decks, layer stack definitions, and EDA tool compatibility matrix. SSOT for PDK versioning used in Cadence Virtuoso and Synopsys Design Compiler flows. | 44 |
| project_lifecycle | revision | master_data | Master reference table for design_revision. Referenced by design_revision_id. | 36 |
| project_lifecycle | verification_plan | master_data | Design verification plan master record defining the pre-silicon verification strategy for an IC design project. Captures verification methodology (UVM, formal, emulation, FPGA prototyping), coverage goals (functional, code, toggle, assertion), testbench architecture, simulation environment configuration, DFT strategy (ATPG, BIST, scan chain, boundary scan), verification milestones and schedule, tool assignments, regression suite definitions, bug tracking integration, and sign-off criteria. For automotive and safety-critical designs, captures ISO 26262 functional safety verification requirements including ASIL decomposition, safety mechanism coverage targets, fault injection campaign plans, and FMEDA linkage. Ensures systematic verification coverage and regulatory compliance before tapeout. | 41 |

<a id="domain-equipment"></a>

### Domain: Equipment

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| equipment | operations | 3 | Semiconductor manufacturing equipment assets including lithography scanners, deposition systems, etchers, CMP tools, ATE platforms, and metrology/inspection systems. Manages equipment qualification, utilization, preventive/corrective maintenance schedules, calibration, and tool performance metrics supporting OEE. | 12 |

**Subdomains:** asset_registry, inventory_logistics, maintenance_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| asset_registry | equipment_process_recipe | master_data | Master and execution records for process recipes on fab tools. Defines complete recipe parameters (temperature, pressure, gas flows, RF power, spin speed, exposure dose, focus offset, etc.) for each process step and tool type, including recipe name, version, process node target, tool compatibility, recipe owner, approval status, and effective date range. Also captures each recipe execution instance linking a specific wafer lot run to the recipe version used, actual as-run vs as-set parameter values, execution start/end timestamps, operator ID, chamber used, and pass/fail outcome. SSOT for recipe configuration, version management, recipe execution history, and recipe-to-yield correlation analysis. Sourced from SmartFactory MES and Camstar recipe management. | 50 |
| asset_registry | fab_tool | master_data | Master record for all semiconductor manufacturing equipment assets including lithography scanners (EUV/DUV), CVD/PVD/ALD deposition systems, etch chambers, CMP tools, ion implanters, ATE platforms, and metrology/inspection systems. Authoritative SSOT for tool identity, classification, OEM specifications, process node compatibility, FAB location, install date, and asset lifecycle status. Sourced from Applied Materials SmartFactory MES and SAP S/4HANA Fixed Assets. | 37 |
| asset_registry | tool_chamber | master_data | Individual process chamber or module within a multi-chamber fab tool (e.g., a CVD cluster tool with 4 deposition chambers, or an etch system with multiple etch modules). Tracks chamber-level qualification status, process recipe assignments, chamber-specific utilization, and maintenance history independently from the parent tool. Essential for chamber-level SPC and yield correlation in multi-chamber tools. | 49 |
| asset_registry | tool_qualification | transactional_data | Qualification and certification records for fab tools and chambers against specific process nodes, recipes, and product families. Captures qualification type (initial qual, re-qual, process change qual), qualification protocol, pass/fail criteria, baseline metrology results, approving process engineer, and qualification validity period. A tool must be qualified before it can run production wafer lots. Sourced from Oracle Agile PLM and SmartFactory MES. | 48 |
| inventory_logistics | maintenance_parts_consumed | association_data | This association product represents the consumption event between maintenance_event and spare_part. It captures the specific parts and consumables used during each maintenance activity, including quantity consumed, cost at time of use, part condition assessment, and replacement rationale. Each record links one maintenance_event to one spare_part with attributes that exist only in the context of this consumption relationship. This is the SSOT for parts consumption tracking, maintenance cost attribution, inventory replenishment triggers, and warranty claim validation.. Existence Justification: In semiconductor fab maintenance operations, a single maintenance event (PM, CM, breakdown repair, upgrade) routinely consumes multiple spare parts and consumables (e.g., focus rings, edge rings, quartz liners, lamp assemblies, pump kits), and each spare part is consumed across many maintenance events over time. The business explicitly tracks parts consumption as a core CMMS function for cost accounting, inventory replenishment, warranty management, and total cost of ownership analysis. This is an operational M:N relationship that humans actively create and manage. | 16 |
| inventory_logistics | spare_part | master_data | Master record for spare parts and consumables inventory specific to fab tool maintenance, including critical spare parts (e.g., focus rings, edge rings, quartz liners, lamp assemblies, pump kits), their OEM part numbers, compatible tool types, minimum stock levels, lead times, and storage location in the FAB stockroom. Supports PM planning and emergency repair readiness. Sourced from SAP S/4HANA MM module. | 48 |
| inventory_logistics | tool_spare_part_compatibility | association_data | This association product represents the compatibility matrix between fab tools and spare parts in semiconductor manufacturing. It captures which spare parts are compatible with which tools, along with maintenance-specific attributes such as quantity required per preventive maintenance cycle, criticality rating for each tool-part combination, and tool-specific lead times. Each record links one fab_tool to one spare_part with attributes that exist only in the context of this compatibility relationship. This replaces the denormalized equipment_compatible STRING field in spare_part and enables proper many-to-many equipment BOM management.. Existence Justification: In semiconductor fab equipment management, spare parts are compatible with multiple tool types (e.g., O-rings, filters, and electronic components used across lithography, etch, and deposition tools), and each tool requires multiple spare parts for maintenance. Equipment engineers actively manage the tool-to-spare-part compatibility matrix (equipment BOM for maintenance) with tool-specific attributes like quantity per PM cycle, criticality rating per tool, and installation procedures. This is a core operational relationship managed in MES and CMMS systems. | 13 |
| maintenance_operations | calibration_record | transactional_data | Calibration and metrology verification records for fab tools and measurement instruments. Tracks calibration type (in-situ, offline, periodic), calibration standard used, measured vs. nominal values, calibration pass/fail result, calibration interval, next due date, calibrating technician, and traceability to NIST or SEMI standards. Mandatory for ISO 9001 and IATF 16949 compliance. Sourced from KLA ICOS and SmartFactory MES calibration modules. | 42 |
| maintenance_operations | maintenance_event | transactional_data | Transactional record of every maintenance activity executed on a fab tool or chamber, including preventive maintenance (PM), corrective maintenance (CM), emergency breakdown repair, engineering-driven modifications, tool upgrades/retrofits, and hardware/software modifications. Captures event type, trigger (scheduled PM, alarm, operator-reported, FDC event, ECO), start/end timestamps, actual downtime duration, root cause classification (5-why, fishbone), repair actions taken, spare parts and consumables consumed (part ID, quantity, unit cost, planned vs unplanned), technician IDs, upgrade/retrofit details (upgrade type, ECO reference, pre/post configuration, performance improvement targets, baseline change flag), and return-to-service sign-off including re-qualification requirements. SSOT for tool downtime attribution, MTTR/MTBF calculation, parts consumption tracking, upgrade history, and total cost of ownership. Sourced from SAP S/4HANA PM and SmartFactory MES. | 57 |
| maintenance_operations | oee_record | transactional_data | Periodic equipment productivity measurement and state tracking records for each fab tool combining SEMI E10 equipment state model data and OEE (Overall Equipment Effectiveness) metrics. Captures granular state transitions (Productive, Standby, Engineering, Scheduled Downtime, Unscheduled Downtime, Non-Scheduled), state transition timestamps, downtime reason codes, responsible party attribution (maintenance, engineering, facilities, scheduling), WIP lot impact, measurement period (shift, day, week), availability rate, performance rate, quality rate, composite OEE percentage, productive hours, available hours, idle hours, engineering hours, wafer throughput (WPH), and downtime breakdown. SSOT for all equipment state tracking, downtime attribution, productivity reporting, capacity consumption analysis, bottleneck identification, and fab scheduling inputs. Sourced from SmartFactory MES run data and OEE calculation engine. | 43 |
| maintenance_operations | pm_schedule | master_data | Preventive maintenance (PM) schedule master defining planned PM activities for each fab tool or chamber. Specifies PM type (daily, weekly, monthly, wafer-count-based, run-count-based), PM procedure reference, estimated downtime window, required spare parts, required technician skill level, and scheduling constraints relative to production WIP. Drives the PM work order generation cadence in SAP PM module. | 42 |
| maintenance_operations | tool_downtime | transactional_data | Granular downtime records for each fab tool and chamber classified per SEMI E10 equipment state model (Productive, Standby, Engineering, Scheduled Downtime, Unscheduled Downtime, Non-Scheduled). Captures state transition timestamps, downtime reason code, responsible party (maintenance, engineering, facilities, scheduling), and impact on WIP lots. Feeds OEE (Overall Equipment Effectiveness) calculation and capacity planning models. | 39 |

<a id="domain-fabrication"></a>

### Domain: Fabrication

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| fabrication | operations | 2 | Core wafer fabrication and processing domain governing all FAB operations including FEOL, MOL, and BEOL process steps. Owns wafer lot tracking, WIP management, process recipe execution, and fab line scheduling across CVD, PVD, ALD, CMP, ion implantation, and EUV/DUV lithography operations. Authoritative source for wafer genealogy and lot disposition via MES integration. | 11 |

**Subdomains:** process_engineering, wafer_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| process_engineering | fab_yield_record | transactional_data | Transactional record capturing wafer-level and lot-level yield outcomes at key FAB inline checkpoints (post-FEOL, post-MOL, post-BEOL, pre-probe), recording gross die count, good die count, yield percentage, yield loss pareto by category (process, design, random defect, systematic), bin-level yield breakdown, and yield excursion flags. SSOT for FAB inline yield data distinct from final test yield (owned by test domain) and distinct from SPC/metrology analysis (owned by quality domain). | 37 |
| process_engineering | fabrication_process_recipe | master_data | Master record for a validated process recipe defining the exact sequence of process parameters, tool settings, gas flows, temperatures, pressures, and timing for a specific FAB operation (CVD, PVD, ALD, CMP, implant, etch, lithography). Includes recipe version history, approval status, change control reference, qualification status, and effective date range. Versioning managed within this entity via version number and effective dates. Sourced from Applied Materials SmartFactory MES recipe management and integrated with engineering change order workflow. | 38 |
| process_engineering | photomask | master_data | Master record for photomasks (reticles) used in EUV and DUV lithography operations, capturing mask set ID, layer name, technology node, mask type (binary, PSM, EUV pellicle), OPC version, MEEF value, mask generation, pellicle status, inspection history summary, usage count, cleaning cycle count, and retirement threshold. SSOT for mask inventory, lithography step qualification, and reticle lifecycle management within the FAB. | 43 |
| process_engineering | process_flow | master_data | Ordered sequence of process steps defining the complete manufacturing route for a product on a given technology node. Captures flow revision, node generation (e.g., 5nm, 7nm, 28nm), flow type (standard, MPW, engineering), effective dates, and approval status. SSOT for FAB routing and WIP scheduling. Aligned with SEMI E40 process management standard for flow-level routing definition. | 41 |
| process_engineering | process_flow_step_recipe | association_data | This association product represents the assignment of a specific fabrication process recipe to a step within a fabrication process flow. It captures the ordered sequence of recipes that define the complete manufacturing route for a semiconductor product. Each record links one recipe to one flow step with step-specific attributes including sequence order, step type classification, mandatory execution flag, and effective date range for change control and versioning.. Existence Justification: In semiconductor FAB operations, process flows are constructed by assigning specific recipes to ordered steps within the manufacturing route. A single recipe (e.g., a CVD oxide deposition recipe) is reused across multiple flows (5nm logic, 7nm SRAM, 28nm analog) to reduce qualification costs and ensure process consistency. Conversely, a single flow contains dozens to hundreds of recipe steps spanning FEOL, MOL, and BEOL phases. This is a core MES concept actively managed by process engineers through route definition and change control workflows. | 12 |
| process_engineering | technology_node | reference_data | Reference master for semiconductor technology nodes supported in the FAB, capturing node name (e.g., 5nm, 7nm, 28nm, 65nm), node generation, transistor architecture (planar, FinFET, GAA), minimum feature size, metal layer count, PDK version reference, qualification status, and production readiness date. SSOT for node-level process and product classification. | 32 |
| wafer_management | fabrication_wafer_lot | master_data | Core master entity representing a wafer lot (batch of wafers) tracked through the FAB from wafer start to lot disposition. Authoritative source for lot identity, wafer count, lot type (production, engineering, qualification, MPW), process node, technology node, product code, priority class, WIP status, hold flags, and genealogy linkage. Sourced from Camstar MES and Applied Materials SmartFactory MES. SSOT for all WIP lot tracking across FEOL, MOL, and BEOL operations. Quality and metrology data for this lot is owned by the quality domain and referenced via cross-domain FK. | 46 |
| wafer_management | lot_hold | transactional_data | Transactional record capturing all hold events placed on a wafer lot, including hold reason code, hold type (engineering, quality, process excursion, customer), initiating system or operator, hold placement timestamp, release timestamp, and disposition action taken. Enables hold cycle time tracking and excursion management. | 40 |
| wafer_management | lot_move | transactional_data | Transactional record of each WIP lot movement through a process step in the FAB, capturing move-in timestamp, move-out timestamp, operator ID, equipment used, recipe executed, actual process parameters, pass/fail disposition, and quantity in/out. Core MES transaction sourced from Camstar MES and SmartFactory MES. Enables cycle time analysis and WIP genealogy. | 40 |
| wafer_management | wafer | master_data | Individual silicon wafer entity within a lot, tracking wafer number, substrate type, diameter, orientation, resistivity, epitaxial layer specs, and current disposition. Enables per-wafer genealogy and yield tracking across all FAB process steps. Sourced from Camstar MES wafer tracking module. | 38 |
| wafer_management | wafer_start | transactional_data | Transactional record authorizing and recording the initiation of a new wafer lot into the FAB line, capturing wafer start date, authorized quantity, product code, technology node, priority class, customer order reference, and wafer start type (production, engineering, qualification, MPW). SSOT for FAB capacity consumption and WIP entry. | 41 |

<a id="domain-inventory"></a>

### Domain: Inventory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| inventory | operations | 2 | Inventory management for WIP wafer lots, raw materials (silicon wafers, chemicals, gases, photomasks), finished goods (packaged chips), die banks, and consignment stock at OSAT partners. Tracks lot traceability, KGD status, bin classifications, shelf life, storage conditions, and inventory valuation. | 7 |

**Subdomains:** inventory_transactions, material_master


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| inventory_transactions | goods_movement | transactional_data | Transactional record for every inventory movement event: goods receipts from suppliers, goods issues to production, inter-location transfers, scrap disposals, returns, and posting reversals. Captures movement type, date, material, quantity, UoM, source/destination locations, reference document (PO/production order/delivery note), posting date, and document number. Provides the complete inventory audit trail required for SOX Section 404 controls, IATF 16949 traceability, and real-time stock balance updates. | 64 |
| inventory_transactions | stock_balance | transactional_data | Transactional snapshot of on-hand inventory quantities by material, storage location, lot, and stock type (unrestricted, quality inspection, blocked, consignment). Captures quantity on hand, quantity available (unreserved), quantity reserved (linked to active inventory_reservation records), quantity in transit, quantity in WIP, unit of measure, last physical count date, and stock aging days. Supports real-time inventory visibility, ATP calculations, and production planning decisions. Financial valuation fields are maintained in stock_valuation. | 65 |
| material_master | die_bank | master_data | Master record for die bank inventory — singulated known-good dies (KGD) stored in waffle packs, gel packs, or tape-and-reel awaiting packaging or direct shipment. Tracks die bank ID, product code, process node, die revision, KGD certification status, bin classification, quantity available, storage location, storage temperature, wafer lot origin, tapeout version, and die bank creation date. Critical for fabless and OSAT-model inventory management. | 70 |
| material_master | finished_good | master_data | Master record for packaged semiconductor finished goods held in inventory including ICs, SoCs, ASICs, FPGAs, and discrete devices in final package form. Tracks SKU, product family, package type (WLCSP, BGA, QFN, CoWoS), device marking, date code, lot traceability code, HTS classification, RoHS compliance status, ECCN number for export control, and shelf life. Links to product domain SKU catalog. | 64 |
| material_master | inventory_wafer_lot | master_data | Master record for a wafer lot (batch of wafers) moving through the FAB as work-in-process inventory. Tracks lot ID, wafer count, process node, product code, lot type (production/engineering/qualification), priority class, current operation step, WIP status (active/hold/complete/scrapped), start date, target completion date, hold flags, cumulative scrap count, good wafer count, and MES lot reference. SSOT for WIP lot identity and traceability across FEOL, MOL, and BEOL process stages within the inventory domain. | 39 |
| material_master | raw_material | master_data | Master record for raw materials consumed in semiconductor manufacturing including silicon wafers (bare and epitaxial), process chemicals, specialty gases, photomasks, CMP slurries, and ALD precursors. Captures material code, description, material class, unit of measure, supplier part number, shelf life, storage temperature range, hazard classification (RoHS/REACH), reorder point, and safety stock level. SSOT for raw material identity in the inventory domain. | 59 |
| material_master | storage_location | master_data | Master record for physical and logical storage locations within FAB cleanrooms, chemical warehouses, gas cabinets, die bank vaults, and OSAT partner facilities. Captures location code, location name, facility type (cleanroom/warehouse/cold-storage/gas-cabinet/nitrogen-cabinet/die-vault), building, bay, row, shelf, temperature range, humidity range, ESD protection class, nitrogen purge capability, hazmat classification, maximum capacity, current utilization, and location status (active/blocked/decommissioned). Enables precise inventory placement, environmental compliance tracking, and MSD floor life management. | 62 |

<a id="domain-packaging"></a>

### Domain: Packaging

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| packaging | operations | 3 | Die packaging and assembly operations covering all package types including WLCSP, InFO, CoWoS, TSV-based 3D-IC, flip-chip, wire bonding, and traditional leadframe/BGA formats. Manages OSAT partnerships, assembly process flows, substrate BOMs, package qualification, and assembly yield data. | 10 |

**Subdomains:** production_operations, technical_standards, vendor_capability


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| production_operations | assembly_defect | transactional_data | Transactional record for assembly defects and non-conformances identified during in-process inspection, final visual inspection, or reliability testing. Captures defect type (delamination, voiding, wire sweep, solder bridge, package crack, marking error), detection step, lot ID, unit serial number, defect image reference, disposition (rework, scrap, use-as-is), corrective action reference, and hold flag for quality domain MRB escalation. Supports DPPM tracking, FMEA, and feeds quality domain for enterprise-wide non-conformance management. | 40 |
| production_operations | assembly_lot | master_data | Master tracking entity for an assembly lot progressing through OSAT or internal packaging operations. Captures lot number, parent wafer lot reference, die count, package type, assembly site (OSAT vendor), current process step, WIP status (queued, in-process, hold, complete), start/target/actual completion dates, cumulative yield, and hold flags. Central WIP identity that all step records, yield results, inspections, and defects reference. SSOT for assembly lot identity and real-time WIP status within the packaging domain. Equipment asset records are owned by the equipment domain; SPC charting is owned by the quality domain. | 50 |
| production_operations | assembly_order | transactional_data | Primary transactional record for die packaging and assembly work orders issued to OSAT partners or internal assembly lines. Captures assembly order number, package type (WLCSP, InFO, CoWoS, flip-chip, wire bond, BGA, leadframe), die lot reference, substrate lot, quantity ordered, target ship date, assembly site, process flow revision, and order status lifecycle (released, in-process, completed, on-hold). SSOT for all assembly execution events in the packaging domain. Shipment logistics and delivery tracking are owned by the order domain; cost accounting is owned by the finance domain. | 43 |
| production_operations | assembly_yield | transactional_data | Transactional record capturing assembly yield data at each major process step and at final assembly completion for each lot. Stores lot ID, process step, units in, units out, units scrapped, scrap reason codes, yield percentage, cumulative assembly yield, and DPPM. Also serves as the authoritative record for scrap quantities and loss reasons within the packaging domain. Feeds assembly yield trending, OSAT scorecard, cost of poor quality (COPQ) analysis, and product cost calculations. Distinct from wafer probe yield (owned by test domain). | 39 |
| technical_standards | assembly_process_flow | master_data | Master definition of the step-by-step assembly process flow for each package type and product combination. Captures flow revision, process steps (die attach, wire bond/flip-chip bump, underfill, molding, singulation, marking, final inspection), equipment class per step, material specifications, and DFM constraints. Linked to package type and product SKU. Enables traceability from assembly order to process specification. | 45 |
| technical_standards | package_qualification | master_data | Master record for package qualification programs executed to certify a new package type, package-product combination, or OSAT site for production release. Captures qualification plan ID, package type, product SKU, qualification standard (JEDEC JESD47, AEC-Q100/Q101, MIL-STD-883), stress test matrix (HTOL, TC, HAST, ESD, latch-up), pass/fail criteria, qualification status, and approval date. SSOT for package qualification certification. | 50 |
| technical_standards | package_type | reference_data | Reference master for all semiconductor package formats supported by Semiconductors, including WLCSP, InFO, CoWoS, TSV-based 3D-IC, flip-chip BGA, wire-bond QFN, leadframe DIP/QFP, and advanced heterogeneous integration formats. Stores package family, body dimensions, pin/ball count range, thermal resistance specs, moisture sensitivity level (MSL), JEDEC outline code, and qualification status. SSOT for package format classification used across assembly, product catalog, and qualification domains. | 62 |
| technical_standards | substrate_bom | master_data | Bill of Materials for packaging substrates and interposers used in advanced semiconductor packages. Captures substrate part number, layer count, core material (ABF, BT resin, silicon interposer, glass core), redistribution layer (RDL) specs, bump pitch, pad finish (ENIG, OSP, immersion tin), supplier, AVL status, unit cost reference, RoHS/REACH compliance flag, and revision history with ECO traceability. SSOT for substrate material specifications enabling procurement and assembly execution. | 54 |
| vendor_capability | osat_package_capability | association_data | This association product represents the qualification and capability relationship between OSAT vendors and package types in the semiconductor packaging domain. It captures vendor-specific qualifications, capacity allocations, lead times, and preferred status for each package type that a vendor is certified to assemble. Each record links one OSAT vendor to one package type with attributes that exist only in the context of this vendor-package qualification relationship. This is the operational SSOT for OSAT sourcing decisions, capacity planning, and dual-source strategies.. Existence Justification: In semiconductor manufacturing, OSAT (Outsourced Semiconductor Assembly and Test) vendor management is a formal, operationally-managed M:N business process. Each OSAT vendor is qualified for multiple package types (e.g., Vendor A qualified for WLCSP, BGA, and QFN), and each package type can be assembled by multiple qualified vendors to support dual-sourcing strategies and capacity risk mitigation. The business actively manages vendor-package qualifications through rigorous qualification programs, tracks capacity allocations per vendor-package combination, maintains quality metrics (DPPM, audit scores) per package type, and designates preferred vendors for specific packages. | 19 |
| vendor_capability | osat_vendor | master_data | Master record for Outsourced Semiconductor Assembly and Test (OSAT) partners and internal assembly sites used by Semiconductors. Captures vendor legal name, site locations, approved package type capabilities, quality certifications (IATF 16949, ISO 9001, AEC-Q100), historical DPPM performance, capacity tiers, standard lead times, NDA/IP protection status, export control classification (EAR/ITAR), and approved/preferred/probation status. SSOT for OSAT partner identity and qualification status within the packaging domain. | 41 |

<a id="domain-process"></a>

### Domain: Process

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| process | operations | 3 | Process engineering data for all semiconductor manufacturing process flows including photolithography, etch, diffusion, implant, deposition, and metrology steps. Manages SPC control charts, process capability indices, OPC rule sets, MEEF parameters, process qualification, yield optimization, and technology node readiness. | 10 |

**Subdomains:** manufacturing_execution, quality_monitoring, recipe_engineering


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| manufacturing_execution | lot_process_run | transactional_data | Transactional record of a wafer lot executing a specific process step on a specific piece of equipment. Captures lot ID reference, process step reference, equipment ID, operator ID, actual start and end timestamps, actual recipe used, chamber ID, lot disposition (pass/hold/scrap), and any in-line measurement results collected at that step. This is the core WIP tracking event for process engineering analysis. SSOT boundary: process domain owns the process-step-level execution record for engineering analysis; fabrication domain owns the lot lifecycle (lot creation, split, merge, hold, scrap, ship) and overall WIP status. Sourced from Camstar MES and Applied SmartFactory MES lot history. | 38 |
| manufacturing_execution | qualification | transactional_data | Process qualification program record tracking the formal qualification of a new process flow, process step, or process change against defined acceptance criteria. Captures qualification type (new process, process change, tool qualification, node readiness), qualification plan reference, start date, target completion date, actual completion date, qualification status (in-progress, passed, failed, waived), sign-off engineer, and disposition. Sourced from Oracle Agile PLM and Siemens Teamcenter PLM qualification workflows. | 48 |
| manufacturing_execution | yield_loss_event | transactional_data | Transactional record of a yield loss event identified at a specific process step or inspection point for a wafer lot. Captures lot reference, process step, yield loss mode (parametric, systematic, random, electrical), defect density, affected die count, estimated yield impact, root cause category, corrective action reference, and resolution status. Primary input to yield optimization workflows and SPC out-of-control action plans (OCAPs). | 49 |
| quality_monitoring | defect_inspection_result | transactional_data | Wafer-level defect inspection result record from in-line inspection tools (KLA brightfield/darkfield scanners, e-beam inspection) captured at process engineering inspection steps for process monitoring and excursion detection. Captures wafer lot reference, inspection step, tool ID, inspection recipe, total defect count, defect density (defects/cm²), defect map file reference, defect classification breakdown by type and size, nuisance filter applied, and disposition. SSOT boundary: process domain owns in-line defect inspection results used for process monitoring, SPC, and excursion detection during manufacturing; quality domain owns outgoing quality inspection, reliability defect analysis, and customer-reported defect records. Sourced from KLA 29xx/39xx series and Applied Materials SEMVision. | 45 |
| quality_monitoring | metrology_measurement | transactional_data | In-line metrology measurement record capturing critical dimension (CD), overlay, film thickness, resistivity, or other physical parameter measurements taken on a wafer at a specific process step. Captures measurement type (CD-SEM, OCD, XRF, ellipsometry, overlay), tool ID, wafer lot reference, wafer number, measurement site map, per-site values, mean, 3-sigma, range, and pass/fail disposition against spec limits. Sourced from KLA ICOS and in-line metrology tools. | 45 |
| quality_monitoring | spc_control_chart | master_data | Statistical Process Control (SPC) control chart definition and complete measurement history for a monitored process parameter at a specific process step. Chart definition captures chart type (Xbar-R, Xbar-S, EWMA, CUSUM, IMR), monitored parameter name, control limits (UCL, LCL, UWL, LWL), target value, sample size, sampling frequency, chart owner, and current chart status. Measurement detail (header+line pattern) captures all individual data points: measured value, measurement timestamp, lot reference, wafer number, site coordinates, measurement tool ID, chart rule violations triggered (Western Electric rules, Nelson rules), and resulting process action (none, warning, OCAP triggered). Implements SEMI E10 and JEDEC SPC guidelines. Sourced from KLA ICOS and in-line metrology tools. SSOT for all SPC monitoring definitions and measurement data in the process domain. | 41 |
| quality_monitoring | spc_measurement | transactional_data | Individual SPC data point recorded against a control chart for a specific lot or wafer at a process step. Captures the measured value, measurement timestamp, lot reference, wafer number, site coordinates, measurement tool ID, chart rule violations triggered (Western Electric rules, Nelson rules), and resulting process action (none, warning, out-of-control action plan triggered). Primary transactional feed for real-time SPC monitoring sourced from KLA ICOS and in-line metrology tools. | 36 |
| recipe_engineering | flow | master_data | Master definition of a semiconductor manufacturing process flow (recipe sequence) for a given technology node. Captures the ordered sequence of unit process steps from FEOL through MOL and BEOL, including process node designation (e.g., 5nm, 3nm, 28nm), flow revision, qualification status, applicable device families, and PDK linkage. SSOT for all process flow definitions used in wafer fabrication. | 38 |
| recipe_engineering | recipe | master_data | Detailed equipment-level process recipe defining all controllable parameters for a specific unit process step on a specific tool class. Captures recipe name, version, tool class, chamber configuration, and all process parameter setpoints organized by process type: implant conditions (species, energy, dose, tilt, twist, beam current, anneal recipe), deposition conditions (method such as LPCVD/PECVD/ALD/PVD/EPI, target material, thickness, temperature, pressure, precursor flows, RF power, deposition rate, uniformity spec), etch conditions (type, chemistry, gas flows, pressure, RF source/bias power, etch rate, selectivity, CD bias, endpoint detection), CMP conditions (slurry, pad, platen pressure, carrier speed, table speed, endpoint detection, removal target, post-CMP clean, uniformity spec), and lithography conditions (scanner, wavelength, NA, sigma, illumination mode, resist type/thickness, exposure dose, focus offset, develop process, bake temperatures, OPC rule set reference). Includes recipe approval status, effective date range, qualification linkage, and full revision history. Sourced from Applied Materials SmartFactory MES and Camstar MES recipe management modules. SSOT for ALL equipment-level process parameters and conditions; no separate condition products exist — all process-type-specific parameters are attributes within this unified recipe entity. | 44 |
| recipe_engineering | step | master_data | Individual unit process step within a process flow, representing a discrete manufacturing operation such as photolithography exposure, CVD deposition, CMP planarization, ion implantation, dry etch, wet clean, or metrology measurement. Captures step sequence number, operation type, tool class, target layer, nominal recipe parameters, and step classification (FEOL/MOL/BEOL). Owned by the process domain as the atomic building block of all process flows. | 36 |

<a id="domain-quality"></a>

### Domain: Quality

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| quality | operations | 2 | Quality assurance, reliability testing, defect inspection, metrology, DPPM tracking, FMEA, and qualification programs. Manages KGD certification, yield analysis, customer quality notifications, and compliance with ISO 9001, IATF 16949, and JEDEC reliability standards. Integrates with KLA ICOS inspection systems. | 11 |

**Subdomains:** issue_resolution, material_inspection


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| issue_resolution | capa_record | transactional_data | Corrective and preventive action record tracking root cause analysis, containment, and effectiveness verification. | 50 |
| issue_resolution | customer_complaint | master_data | Customer complaint record tracking reported issues, investigation, and resolution with customer satisfaction metrics. | 64 |
| issue_resolution | failure_analysis_report | transactional_data | Failure analysis report documenting physical analysis techniques, findings, and root cause for failed devices. | 48 |
| issue_resolution | nonconformance_report | transactional_data | Nonconformance report documenting material or process deviations from specification with disposition decisions. | 56 |
| material_inspection | defect_record | transactional_data | Individual defect observation record with classification, location, and root cause analysis. | 55 |
| material_inspection | inspection_lot | master_data | Quality inspection lot for incoming, in-process, or outgoing material with sampling plan and disposition tracking. | 47 |
| material_inspection | quality_hold | transactional_data | Quality hold record preventing material movement pending investigation or disposition decision. | 43 |
| material_inspection | quality_spec | master_data | Quality specification defining acceptance criteria, measurement methods, and control limits for product parameters. | 53 |
| material_inspection | reliability_test | master_data | Reliability test execution record for HTOL, HAST, TC, and other stress tests with pass/fail results. | 63 |
| material_inspection | wafer_map | transactional_data | Spatial defect and yield map for a wafer showing die-level pass/fail and defect distribution patterns. | 48 |
| material_inspection | yield_record | transactional_data | Yield measurement record tracking die yield, parametric yield, and bin distributions at lot or wafer level. | 64 |

<a id="domain-test"></a>

### Domain: Test

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| test | operations | 2 | Wafer probing, die sort, final test, and reliability testing operations. Manages ATPG programs, ATE configurations, test coverage, bin mapping, test yield, parametric test data, and correlation studies between wafer-level and package-level test. Distinct from quality domain which focuses on QMS and compliance. | 9 |

**Subdomains:** equipment_configuration, execution_results


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| equipment_configuration | ate_configuration | master_data | Master configuration record for Automatic Test Equipment (ATE) platform setups used across wafer probe and final test operations. Captures tester model and platform type (e.g., Advantest V93000, Teradyne UltraFlex), hardware configuration revision, pin electronics card map, load board/DIB (Device Interface Board) revision and qualification status, instrument resource allocation, calibration status and due date, supported device families, maximum parallel site count, and configuration effective dates. SSOT for ATE setup definitions that test runs reference for full equipment traceability. Links to equipment domain for physical asset and maintenance tracking. | 40 |
| equipment_configuration | bin_definition | reference_data | Reference master defining all test bin codes used in wafer sort and final test. Captures bin number, bin name, bin category (pass, functional fail, parametric fail, contact fail, leakage fail), disposition rule (ship, scrap, rework, hold), yield impact classification, and associated failure mode. Provides standardized bin taxonomy across all test programs and device families per JEDEC and internal standards. | 29 |
| equipment_configuration | limit | master_data | Master record defining parametric test limits for each test parameter by device type, product revision, and test condition. Captures parameter name, LSL, USL, target value, measurement unit, test condition set, limit revision history, effective date, and approval status. SSOT for all test specification limits used across ATPG programs and ATE test flows. Supports limit change management and PCN-driven limit updates. | 49 |
| equipment_configuration | probe_card | master_data | Master record for probe cards used in wafer probing operations, owned by test engineering for qualification, assignment, and performance tracking. Captures probe card type (cantilever, vertical, MEMS, advanced), needle/pin count, pitch, technology node compatibility, die site layout, touchdown count, maintenance cycle, current condition status, and assigned prober tool. Tracks probe card lifecycle from incoming qualification through active use to retirement, including needle replacement history and contact resistance trending. Links to equipment domain for physical asset management while test domain owns operational qualification and assignment decisions. | 43 |
| equipment_configuration | program | master_data | Master record for ATPG-generated and manually authored test programs used on ATE platforms, with full version lifecycle management. Captures program name, target device family, test type (wafer probe, die sort, final test, burn-in, SLT), ATE platform compatibility, ATPG tool used, coverage targets, and program lifecycle status. Includes version-level tracking: version number, change description, changed test flows or limits, validation status, release date, approved-by engineer, associated PCN/ECO reference, and change impact assessment. SSOT for all test program definitions and their complete evolution history across test operations. | 38 |
| execution_results | final_test_run | transactional_data | Transactional record for package-level test execution events on ATE including final test and system-level test (SLT). Captures device lot ID, package type, test type discriminator (final_test, SLT), test configuration (socket, ATE, handler, SLT board), test program version, test temperature, test time, pass/fail counts, bin distribution, power consumption (SLT), boot success (SLT), and test site count. Covers all post-packaging test operations distinct from wafer-level probing. | 49 |
| execution_results | parametric_measurement | transactional_data | Transactional record storing individual parametric test measurements captured during wafer probe and final test. Records test parameter name, measured value, lower specification limit (LSL), upper specification limit (USL), pass/fail status, measurement unit, test condition (voltage, temperature, frequency), and associated die or device result. Enables SPC analysis, parametric yield optimization, and process-test correlation studies. | 57 |
| execution_results | unit_test_result | transactional_data | Transactional record capturing individual unit-level test results from all test insertions including wafer probing, die sort, final test, and system-level test (SLT). Records unit identifier (X/Y die coordinates for wafer-level or device serial/unit position for package-level), test insertion stage discriminator, assigned hard-bin and soft-bin codes per bin_definition, pass/fail status, total test time, parametric measurement summary flags, retest indicator and retest count, KGD (Known Good Die) qualification status, multi-die/chiplet assembly position, and test temperature/voltage condition. Serves as the single source of truth for all unit-level test outcomes across the entire test flow, enabling wafer map generation, unit-level yield analysis, full lot traceability, and die-to-package correlation. Aligns with STDF PTR/FTR/MPR record concepts. | 44 |
| execution_results | wafer_probe_run | transactional_data | Transactional record capturing each wafer probing execution event. Records wafer lot ID, wafer sequence number, probe card used, ATE configuration, test program version, prober tool, start and end timestamps, total die count, pass die count, fail die count, contact yield, gross die count, and operator ID. Core operational event for wafer-level electrical test and die sort operations. | 40 |

<a id="domain-customer"></a>

### Domain: Customer

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| customer | business | 2 | Single source of truth for all customer identity, account hierarchy, and relationship data. Manages OEM, fabless design house, ODM, distributor, and automotive customer profiles, contacts, segmentation, design-win engagement records, and customer qualification status. Integrates with Salesforce CRM. | 9 |

**Subdomains:** account_management, contract_administration


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| account_management | account | master_data | Master record for all customer accounts in the semiconductor ecosystem, including OEMs, fabless design houses, ODMs, distributors, and automotive Tier-1 suppliers. SSOT for customer identity, legal entity name, DUNS number, account type, industry vertical, revenue tier, strategic classification, credit rating, payment terms, export control classification (EAR/ITAR), account status, preferred communication settings, packaging/labeling requirements, and Salesforce CRM account ID. Integrates with SAP S/4HANA SD module and Salesforce CRM Account object. | 36 |
| account_management | account_hierarchy | master_data | Defines parent-child corporate hierarchy relationships between customer accounts, enabling roll-up of revenue, design-wins, and engagement metrics across global enterprise accounts. Captures parent account, child account, hierarchy level, relationship type (subsidiary, division, affiliate, distributor branch), effective date, and end date. Critical for global OEM and distributor account management. | 21 |
| account_management | address | master_data | Physical and mailing addresses associated with customer accounts and contacts, including headquarters, ship-to, bill-to, and design center locations. Captures address type, street lines, city, state/province, postal code, country (ISO 3166), region, time zone, and geolocation coordinates. Supports multi-site global accounts with multiple address records per account. Used for logistics, tax jurisdiction, and export control screening. | 46 |
| account_management | contact | master_data | Individual contact persons associated with customer accounts, including design engineers, procurement managers, FAE (Field Application Engineers) counterparts, and executive sponsors. Captures full name, title, department, role type (technical, commercial, executive), email, phone, preferred communication channel, LinkedIn profile, GDPR consent status, and active/inactive status. Maps to Salesforce CRM Contact object. | 38 |
| account_management | design_win | transactional_data | Unified record tracking the full design-in lifecycle from initial registration through confirmed design-win for semiconductor products selected by customers. SSOT for the complete design-in pipeline from early registration through revenue forecasting — distinct from sales-domain opportunity records which track revenue probability and sales stage. Captures design project name, target end product/application (e.g., smartphone SoC, ADAS ECU, AI accelerator), platform generation, process node, package type, device/part number selected, design-win stage (registered, evaluating, sampling, won, lost, on-hold), registration date, design-win confirmation date, tapeout target date, production ramp date, estimated annual unit volume (AUV), estimated annual revenue, competitive displacement flag, associated distributor (if channel-sourced), FAE owner, and NRE requirements. Integrates with Salesforce CRM Opportunity. | 45 |
| account_management | segment | reference_data | Reference data defining market segmentation classifications for customer accounts. Each segment represents a strategic grouping used for go-to-market planning, pricing strategy, and resource allocation. Attributes include segment code, segment name (e.g., Hyperscaler, Automotive Tier-1, Consumer Electronics OEM, Industrial IoT, Government/Defense), vertical market, sub-vertical, strategic priority tier, TAM band, and assigned sales motion. Managed by sales strategy and marketing teams as controlled vocabulary. | 28 |
| contract_administration | credit_profile | master_data | Customer-facing credit and financial risk profile maintained by the customer domain as SSOT for customer creditworthiness assessment. Captures credit limit, credit rating (internal and external Dun & Bradstreet), payment terms (Net 30, Net 60, prepay), credit hold status, credit review date, outstanding balance, overdue amount, credit utilization percentage, currency, and credit analyst notes. Distinct from finance-domain AR aging and collections records — this product owns the customer's credit posture used for real-time order-to-cash credit checks. Integrates with SAP S/4HANA FI-AR (Accounts Receivable). | 52 |
| contract_administration | nda_agreement | master_data | Non-Disclosure Agreement records between the semiconductor company and customer accounts, capturing NDA type (mutual, one-way), execution date, expiry date, covered scope (product roadmap, process technology, pricing), signatory contacts, legal entity names, NDA status (active, expired, under renewal), and document reference ID. Required before sharing roadmap, PDK, or pre-production device information with customers. | 41 |
| contract_administration | price_agreement | master_data | Customer-specific pricing agreements and special price authorizations (SPAs) negotiated for specific part numbers. SSOT for customer-negotiated prices distinct from sales-domain standard list pricing and discount schedules. Captures agreed unit price, currency, minimum order quantity (MOQ), volume tiers, effective date, expiry date, approval chain, SPA reference number, and associated design-win or contract. These are customer-committed prices that flow into order entry — not sales pipeline pricing assumptions. Integrates with SAP S/4HANA SD pricing conditions. | 54 |

<a id="domain-invoice"></a>

### Domain: Invoice

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| invoice | business | 4 | Billing, invoicing, payment processing, and revenue collection. SSOT for customer invoices, NRE billing milestones, credit memos, payment terms, credit management, accounts receivable, pricing models including volume discounts, royalty billing for IP licensing, and revenue recognition. | 9 |

**Subdomains:** billing_operations, credit_management, payment_processing, revenue_accounting


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| billing_operations | ar_invoice | transactional_data | Authoritative accounts receivable invoice record for all customer billing transactions in the semiconductor business. Captures the full invoice lifecycle from draft through posted, sent, disputed, and paid states. Covers commercial product shipment invoices, NRE milestone billing, IP royalty invoices, service invoices, and pro-forma documents for customs/LC/advance payment purposes. Includes document_type classification (commercial, proforma, intercompany) with proforma-specific attributes for HS/HTS codes, ECCN classification, incoterms, and export control documentation. Sourced from SAP S/4HANA SD and FI modules. SSOT for all customer-facing billing documents. | 46 |
| billing_operations | dispute | transactional_data | Customer invoice dispute records tracking formal challenges raised against billed amounts, pricing, quantities, or delivery conditions. Captures dispute type (pricing error, quantity discrepancy, quality claim, duplicate billing, delivery shortfall), disputed amount, dispute open date, responsible owner, resolution status, and final settlement amount. Supports dispute workflow management and root cause tracking for billing quality improvement. | 42 |
| billing_operations | invoice_line | transactional_data | Individual line items on a customer invoice, each representing a distinct billable element such as a specific IC product SKU shipment, an NRE milestone charge, an IP royalty fee, a wafer lot charge, or a packaging service fee. Captures quantity, unit price, extended amount, tax code, revenue recognition category, and product/service reference. Supports multi-line invoices with mixed billing types. | 57 |
| credit_management | credit_hold | transactional_data | Records of credit hold events placed on customer accounts due to overdue invoices, exceeded credit limits, or financial risk triggers. Captures hold placement date, hold reason, blocking level (order block, delivery block, billing block), responsible credit analyst, customer notification status, and hold release date with authorization. Directly impacts order fulfillment and shipment release workflows. | 37 |
| credit_management | customer_credit_limit | master_data | Credit limit master records for each customer account defining the maximum outstanding AR exposure permitted. Captures approved credit limit amount, credit currency, credit risk classification, credit review date, credit hold status, credit insurance coverage details, and credit analyst assignment. Supports dynamic credit limit adjustments based on payment history and financial health reviews. SSOT for credit management decisions. | 40 |
| payment_processing | payment_receipt | transactional_data | Records of customer payments received, their line-level allocation against outstanding invoices, and cash application status. Captures payment header (date, method — wire/ACH/check/LC, amount, currency, bank reference, remittance advice) and line-level allocation details (allocated amount per invoice, allocation date, clearing document reference, partial payment flag, discount taken, residual open amount). Supports partial payments, overpayments, multi-invoice payment runs, on-account payments, payment reversals, and complex allocation scenarios. Enables accurate AR aging, cash application tracking, and bank reconciliation. SSOT for all customer payment receipts, their invoice clearing allocations, and cash application — subsumes all payment_allocation concepts. | 46 |
| payment_processing | payment_term | reference_data | Master reference for customer payment terms governing invoice due dates, early payment discount structures, and late payment penalty rules. Defines net payment days (e.g., Net 30, Net 60, Net 90), cash discount percentages and qualifying windows (e.g., 2/10 Net 30), letter of credit requirements, and currency-specific term variants. Assigned at customer account level with order-level override capability. | 38 |
| revenue_accounting | revenue_recognition_event | transactional_data | Revenue recognition event records capturing when and how revenue from customer invoices is recognized under applicable accounting standards (ASC 606 / IFRS 15). Each record links a billing event (invoice, NRE milestone, royalty) to its revenue recognition schedule, performance obligation, recognition method (point-in-time vs. over-time), recognized amount, deferred revenue amount, and accounting period. SSOT for revenue recognition compliance. | 35 |
| revenue_accounting | tax_determination | transactional_data | Tax determination records for each invoice capturing applicable tax codes, jurisdictions, rates, and calculated tax amounts for semiconductor product sales across global markets. Covers VAT, GST, sales/use tax, withholding tax, and customs duty components. Captures determination inputs (ship-from/ship-to jurisdiction, product tax classification, customer tax status, free trade zone applicability, bonded warehouse status) and resulting tax line amounts. Supports withholding tax certificate tracking for Asian semiconductor markets (Taiwan, Korea, China, India) where WHT documentation is required for payment release. | 50 |

<a id="domain-order"></a>

### Domain: Order

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| order | business | 3 | Customer orders, order fulfillment, delivery schedules, and shipment tracking. SSOT for order-to-cash lifecycle including order entry, wafer start authorizations, die bank orders, allocation, backlog management, and delivery confirmation. Manages MPW orders and production lot assignments. | 9 |

**Subdomains:** commitment_management, fulfillment_execution, sales_processing


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| commitment_management | allocation_record | transactional_data | Inventory, capacity, and lot allocation record that reserves specific wafer lots, die bank inventory, finished goods, or fab capacity against a customer order line. Captures allocated quantity, allocation type (hard/soft), allocated lot or inventory batch, lot number, lot type (wafer lot, die lot, packaged goods lot), assignment status (tentative, confirmed, shipped), assignment date, lot-specific quality disposition notes, allocation expiry date, and priority rank. SSOT for all allocation and lot-to-order assignment decisions in the order fulfillment process. Manages constrained supply allocation across competing customer orders during supply shortages. Supports automotive (IATF 16949) and aerospace lot-level traceability requirements from order through shipment. | 53 |
| commitment_management | backlog_position | transactional_data | Point-in-time snapshot of open order backlog for a specific order line, capturing unshipped committed quantity, backlog value, original promise date, current commit date, and backlog aging in days. Used for backlog management, revenue forecasting, customer escalation prioritization, and quarterly book-to-bill ratio reporting. Tracks push-outs, pull-ins, and cancellations affecting committed backlog. Critical for semiconductor revenue recognition, quarterly close processes, and investor guidance on backlog coverage. | 54 |
| fulfillment_execution | delivery_schedule | transactional_data | Planned and confirmed delivery schedule for customer orders, capturing multiple delivery windows per order line. Records scheduled delivery date, confirmed quantity, ship-from location (fab, OSAT, warehouse), ship-to customer location, carrier, incoterms, and schedule line status. Supports rolling delivery schedules for high-volume customers with blanket orders and periodic call-offs. Sourced from SAP S/4HANA SD schedule lines. | 52 |
| fulfillment_execution | shipment | transactional_data | Physical shipment record tracking the outbound movement of semiconductor products from origin (fab, OSAT, distribution center) to customer destination. Header captures shipment number, carrier, tracking number, ship date, estimated and actual arrival dates, package count, gross weight, HS tariff codes, export license reference, and shipment status. Line-level detail captures shipped quantity per order line, lot numbers, wafer lot IDs, package types, serial numbers, unit of measure, and inspection certificate references. Delivery confirmation section captures proof of delivery (POD) including confirmed receipt date, receiving location, confirmed quantity, customer PO reference, discrepancy flags (quantity shortage, wrong part, damaged goods), and customer signoff reference. POD receipt triggers downstream invoice release and revenue recognition. Supports multi-leg shipments, cross-border trade compliance (EAR, ITAR), RMA dispute resolution, and full traceability from order line through physical delivery. Sourced from SAP S/4HANA SD outbound delivery, carrier POD data, and customer EDI 856 ASN acknowledgements. | 52 |
| fulfillment_execution | shipment_line | transactional_data | Line-level detail of a shipment record, linking specific order lines and quantities to a physical shipment. Captures shipped quantity, unit of measure, lot number, wafer lot ID, package type, serial numbers (where applicable), and inspection certificate references. Enables traceability from customer order line to physical shipment and supports RMA and quality dispute resolution. | 51 |
| sales_processing | order | transactional_data | Master record for all customer sales orders in the semiconductor order-to-cash lifecycle. Captures order header information including customer identity, order type (standard IC, ASIC, FPGA, MPW, NRE), order date, requested delivery date, priority, incoterms, payment terms, currency, total order value, and order status. SSOT for all customer-placed orders including wafer start authorizations, die bank orders, and production lot assignments. Sourced from SAP S/4HANA SD module. | 48 |
| sales_processing | order_hold | transactional_data | Record of holds placed on a sales order or order line that prevent further processing or shipment. Captures hold type (credit hold, export compliance hold, quality hold, customer request hold), hold reason, hold date, hold owner, release date, release approver, and resolution notes. Supports order management workflows where orders must be paused pending credit approval, export license verification, or quality disposition. Sourced from SAP S/4HANA SD order block management. | 51 |
| sales_processing | order_line | transactional_data | Individual line items within a customer sales order, each representing a distinct semiconductor product SKU, quantity, unit price, requested ship date, confirmed ship date, and line-level status. Captures product configuration details such as package type, speed grade, temperature range, and special handling requirements. Supports partial shipments and line-level allocation tracking. Sourced from SAP S/4HANA SD order line items. | 57 |
| sales_processing | rma | transactional_data | RMA (Return Material Authorization) record managing customer returns of semiconductor products for quality issues, shipping damage, or end-of-life returns. Captures RMA number, return reason code, defect description, returned product and quantity, original order reference, disposition instruction (scrap, rework, credit, replacement), credit memo reference, and failure analysis request flag. SSOT for customer return workflows and DPPM tracking inputs. | 53 |

<a id="domain-product"></a>

### Domain: Product

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| product | business | 2 | Authoritative semiconductor product catalog encompassing ICs, SoCs, ASICs, FPGAs, IP cores, and discrete devices. SSOT for product specifications, SKUs, BOM, process node assignments, PPA metrics, product lifecycle status (NPI through EOL), PCN management, and LTB notifications. Integrates with PLM systems. | 8 |

**Subdomains:** portfolio_management, technical_specification


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| portfolio_management | family | master_data | Product family grouping related IC products by architecture, process node, and market segment for portfolio management. | 44 |
| portfolio_management | ic_catalog | master_data | Master catalog of all IC products with lifecycle, compliance, and technical specifications. Authoritative source for product identity. | 47 |
| portfolio_management | process_node | reference_data | Semiconductor process technology node definition with lithography, architecture, and qualification parameters. | 35 |
| portfolio_management | sku | master_data | Stock-keeping unit representing an orderable, shippable product variant with pricing, compliance, and logistics attributes. | 42 |
| technical_specification | bom | master_data | Bill of materials header defining the component structure for an IC product with compliance and cost tracking. | 38 |
| technical_specification | bom_line | master_data | Individual line item in a bill of materials specifying component, quantity, sourcing, and compliance details. | 40 |
| technical_specification | compliance_cert | master_data | Compliance certification record for environmental, safety, and export control standards applicable to IC products. | 45 |
| technical_specification | product_spec | master_data | Detailed product specification covering electrical, thermal, and mechanical parameters with target vs achieved metrics. | 45 |

<a id="domain-sales"></a>

### Domain: Sales

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| sales | business | 2 | Sales pipeline, opportunities, quotes, design-win campaigns, NRE agreements, pricing, and customer contracts. Manages sales territories, account assignments, forecast accuracy, revenue targets by product family, end market, and geography. Integrates with Salesforce CRM and SAP SD. | 8 |

**Subdomains:** commercial_pricing, pipeline_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| commercial_pricing | customer_contract | master_data | Master record: Long-term commercial contract with a semiconductor customer covering supply commitments, pricing agreements, volume guarantees, last-time-buy (LTB) provisions, product change notification (PCN) obligations, and end-of-life (EOL) terms. Distinct from NRE agreements — governs ongoing product supply rather than development services. Linked to SAP SD outline agreements. | 52 |
| commercial_pricing | price_list | master_data | Master record: Master pricing repository defining standard and customer-specific pricing for semiconductor products by product family, package type, volume tier, and end market. Supports list price, distributor price, OEM price, and spot price variants. Contains price adjustment records capturing negotiated deviations, special bids, volume rebate adjustments, design-win incentives, and distributor markdowns with adjustment type, approved deviation amount, approval authority, validity windows, and SAP SD pricing condition override references. Integrates with SAP SD condition records and Salesforce CRM pricing engine. Tracks effective dates, supersession history, and full adjustment audit trail. SSOT for all semiconductor product pricing and price deviations. | 40 |
| commercial_pricing | quote | transactional_data | Transaction record: Commercial price quotation issued to a customer or prospect for semiconductor products including ICs, packaged devices, wafer-level products, and IP licensing. Captures quoted unit price, volume tiers, lead time, validity period, incoterms, currency, and SAP SD quotation reference. Tracks quote-to-order conversion and win/loss outcomes. | 42 |
| commercial_pricing | quote_line | transactional_data | Detail record: Individual line item within a sales quotation specifying a single semiconductor SKU, die, or IP core with its quoted quantity, unit price, discount, package type, lead time, and applicable pricing tier. Supports multi-line quotes covering mixed product families and end-market configurations. | 39 |
| pipeline_management | booking | transactional_data | Transaction record: Confirmed sales booking representing a firm customer purchase order commitment for semiconductor devices. Captures booking date, booked revenue, booked units, device part number, customer account, ship-to location, requested delivery date, backlog status, and SAP SD sales order reference. Represents the commercial booking event — distinct from shipment or invoice. SSOT for bookings-to-billings (B2B) ratio, book-to-ship analysis, and revenue waterfall reporting critical to semiconductor quarterly earnings. | 51 |
| pipeline_management | forecast | transactional_data | Transaction record: Sales demand forecast capturing expected unit volume and revenue by product family, customer, end market, geography, and fiscal period. Supports rolling 12-month and 18-month forecast horizons used in semiconductor S&OP and wafer-start authorization processes. Tracks forecast version (commit, upside, best-case), submission date, confidence level, and variance against actuals. Integrates with SAP APO/IBP demand planning. Enables forecast accuracy KPI tracking (MAPE, bias) critical for fab capacity planning decisions. | 49 |
| pipeline_management | opportunity | transactional_data | Master record: Core sales opportunity tracking design-win campaigns, pipeline stages (Prospecting→Design-In→Design-Win→Production Ramp→Won/Lost), probability, and expected revenue for semiconductor IC, SoC, ASIC, and FPGA engagements. Sourced from Salesforce CRM Opportunity object. Captures end market (automotive, mobile, AI, IoT, computing), product family, target application, competitive landscape, NRE potential, design-win status, campaign grouping (campaign type, target segment, effectiveness metrics), and stage transition history for pipeline velocity analysis. SSOT for all sales pipeline activity including campaign-level aggregation for design-in programs, product launches, and competitive displacement initiatives. | 36 |
| pipeline_management | territory | master_data | Master record: Sales territory definition and quota management assigning geographic regions, end markets, or named accounts to sales representatives and field application engineers (FAEs). Captures territory code, region hierarchy (global→regional→country→district), assigned sales rep, FAE coverage, revenue and unit targets by fiscal period (quarterly, half-year, annual), quota amounts, stretch targets, attainment tracking, and effective dates. Includes account-to-territory assignment details with assignment type (direct, distribution, rep firm), primary/secondary coverage flags, channel tier, and multi-rep coverage models. Supports territory realignment, overlay models (product specialists, strategic account managers), quota assignment workflows, and sales performance management common in semiconductor distribution channels. Used for compensation planning and quarterly business review (QBR) reporting. | 26 |

## Metric Views

Total metric views generated: **104**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | design_ic_design_project | design | ic_design_project | Core IC design project performance metrics tracking budget adherence, schedule performance, and design complexity targets across semiconductor design initiatives. |
| 2 | design_ip_core | design | ip_core | IP core portfolio metrics tracking reusability, licensing economics, and design quality for semiconductor intellectual property assets. |
| 3 | design_physical_layout | design | physical_layout | Physical layout quality and efficiency metrics tracking design rule compliance, area utilization, and timing closure for place-and-route execution. |
| 4 | design_tapeout | design | tapeout | Tapeout execution metrics tracking design quality, manufacturing readiness, and mask cost efficiency for semiconductor production handoff. |
| 5 | design_verification_plan | design | verification_plan | Verification planning and coverage metrics tracking test completeness, quality targets, and functional safety compliance for design validation. |
| 6 | equipment_calibration_record | equipment | calibration_record | Calibration Record business metrics |
| 7 | equipment_equipment_process_recipe | equipment | equipment_process_recipe | Equipment Process Recipe business metrics |
| 8 | equipment_fab_tool | equipment | fab_tool | Fab Tool business metrics |
| 9 | equipment_maintenance_event | equipment | maintenance_event | Maintenance Event business metrics |
| 10 | equipment_maintenance_parts_consumed | equipment | maintenance_parts_consumed | Maintenance Parts Consumed business metrics |
| 11 | equipment_oee_record | equipment | oee_record | Oee Record business metrics |
| 12 | equipment_pm_schedule | equipment | pm_schedule | Pm Schedule business metrics |
| 13 | equipment_spare_part | equipment | spare_part | Spare Part business metrics |
| 14 | equipment_tool_chamber | equipment | tool_chamber | Tool Chamber business metrics |
| 15 | equipment_tool_downtime | equipment | tool_downtime | Tool Downtime business metrics |
| 16 | equipment_tool_qualification | equipment | tool_qualification | Tool Qualification business metrics |
| 17 | equipment_tool_spare_part_compatibility | equipment | tool_spare_part_compatibility | Tool Spare Part Compatibility business metrics |
| 18 | fabrication_fab_yield_record | fabrication | fab_yield_record | Fab Yield Record business metrics |
| 19 | fabrication_fabrication_process_recipe | fabrication | fabrication_process_recipe | Fabrication Process Recipe business metrics |
| 20 | fabrication_fabrication_wafer_lot | fabrication | fabrication_wafer_lot | Fabrication Wafer Lot business metrics |

*... and 84 more metric views. See the `metrics/` folder for full details.*