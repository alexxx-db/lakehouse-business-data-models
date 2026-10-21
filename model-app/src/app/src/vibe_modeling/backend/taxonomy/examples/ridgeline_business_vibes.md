## Company and segments
Ridgeline Energy is a regional, investor-owned electric and gas utility (fictional) with ~1.9M electric meters and ~850K gas meters across three Midwest states, regulated by each state's public utility commission (PUC) and by FERC for transmission. Two businesses: Ridgeline Electric (a 2.1 GW regulated generation fleet of gas peakers, one coal unit being retired in 2028, and utility-scale solar; 4,800 miles of transmission; 41,000 miles of distribution; a fast-growing distributed energy resource (DER) portfolio) and Ridgeline Gas (6,200 miles of gas main, regulator stations, ~900K service lines). Customer segments: residential, small commercial, large commercial and industrial (C&I, some on interval-billed demand tariffs), and municipal street lighting.

## Channels and customer touchpoints
Customers interact through a self-service portal and mobile app, a contact center, field visits, and third-party payment agents. C&I accounts have dedicated account managers. Programs (energy efficiency rebates, income-qualified assistance, budget billing, net metering for rooftop solar) change how a customer is billed and must be modeled as program enrollments, not as customer flags.

## Core business processes
Meter-to-cash: meter installation and exchange (AMI rollout ~80% complete), interval reads every 15 minutes, validation/estimation/editing (VEE), rate application, bill calculation, payment, collections, payment arrangements, and disconnect/reconnect. Grid and gas asset lifecycle: plan, design, construct, inspect, maintain, retire, all driven by work orders with tasks, crews, materials, and contractors. Outage management: trouble tickets, outage events predicted from AMI last-gasp messages, crew dispatch, switching and restoration steps, and IEEE 1366 reliability reporting (SAIDI, SAIFI, CAIDI) with major event day exclusion. Gas integrity: leak surveys, leak grading and repair, and integrity assessments under PHMSA. Energy supply: generation dispatch and output, power purchase agreements, gas supply contracts, load forecasting, and MISO market settlement. Finance and regulatory: general ledger, capital projects (rate base), supplier management, rate cases, and regulatory filings. People: employees, organizations, crews, craft certifications (lineworker, gas operator qualification), fleet vehicles. Safety and environmental: safety incidents, corrective actions, environmental permits, emissions records, and NERC CIP cyber and physical security controls.

Strategic priorities: a 2027 rate case (needs rate base and reliability evidence), AMI-driven outage prediction, and a CIS migration from Oracle CC&B to SAP S/4HANA Utilities that must not change the model.

## Industry terminology
ami (advanced metering infrastructure), mdm (meter data management), vee (validation, estimation, editing), cis (customer information system), premise, service_point, service_agreement, sa, rate_schedule, tariff_rider, kwh, kw_demand, therm, ccf, interval_read, register_read, last_gasp, net_metering, der (distributed energy resource), interconnection_queue, feeder, substation, transformer, recloser, oms (outage management system), adms (advanced distribution management system), saidi, saifi, caidi, med (major event day), ci (customers interrupted), cmi (customer minutes interrupted), gis, eam, work_order, crew, lineworker, oq (operator qualification), phmsa, dimp, leak_grade, ppa (power purchase agreement), lmp (locational marginal price), miso, etrm, rate_base, rate_case, puc, ferc, nerc_cip.

## Systems of record
Oracle Customer Care & Billing (CIS, current source of truth for customers, premises, service agreements, billing; legacy, being replaced by SAP S/4HANA Utilities by 2028). Itron head-end and Itron MDM (meter reads, interval usage, VEE). Esri ArcGIS Utility Network (GIS: connectivity model for electric and gas assets). IBM Maximo (EAM: assets, work orders, maintenance plans, materials, storerooms). GE ADMS/OMS (outage events, switching, restoration). ServiceNow Field Service (dispatch and field work). AVEVA PI (SCADA and substation historian). Allegro ETRM (PPAs, gas contracts, market settlement). SAP S/4HANA Finance (GL, capital projects, suppliers). Workday (HR). Intelex (EHS incidents, permits). Salesforce (C&I account management and program enrollment).

## Regulatory and compliance
State PUC tariff and rate case rules, FERC transmission, NERC CIP (critical infrastructure protection), PHMSA 49 CFR Part 192 and DIMP (gas distribution integrity), IEEE 1366 reliability reporting, EPA emissions reporting (Part 75 and 98), OSHA, SOX, PCI DSS for card payments, and customer PII privacy rules. Customer names, contact details, and bank/card data are restricted. Critical grid asset locations are confidential (NERC CIP).

## Conformance clamp (load-bearing)
Produce EXACTLY these 10 domains - do NOT rename, merge, split, drop, or invent domains. Model each concept in ONE domain. Keep source_system and a stable business_key on every product; never strip them. Do NOT invent placeholder entities - use the REAL entities named below. Tag every table with its sub_domain.

Shared masters (model ONCE in the canonical home; elsewhere use foreign keys, never duplicate tables):
- premise, service_point, customer_account -> customer
- supplier -> finance
- employee, organization -> workforce
- grid and gas physical assets keep their own tables in grid / gas; asset references them by asset key.

Domains, sub-domains, and required entities:
1 customer - party_master: customer, customer_account, contact; service_location: premise, service_point, service_agreement; assistance_programs: energy_efficiency_program, low_income_assistance, budget_billing_plan.
2 billing - meter_reading: meter, meter_read, interval_usage; tariff_schedules: rate_schedule, tariff_rider; bill_production: bill, bill_line_item; payment_collections: payment, payment_arrangement, collection_case.
3 grid - transmission_grid: substation, transmission_line; distribution_network: feeder, distribution_transformer, pole, switching_device; distributed_generation: der_asset, interconnection_request.
4 gas - pipeline_network: gas_main, gas_service_line, regulator_station; integrity_management: leak_survey, gas_leak, integrity_assessment.
5 asset - work_execution: work_order, work_task; maintenance_planning: maintenance_plan, asset_inspection; material_inventory: material, storeroom_inventory.
6 outage - outage_response: outage_event, trouble_ticket, restoration_step; reliability_performance: reliability_index, major_event_day.
7 supply - generation_fleet: generation_unit, generation_output; energy_procurement: power_purchase_agreement, gas_supply_contract; market_operations: market_settlement, load_forecast.
8 finance - financial_accounting: general_ledger, capital_project, supplier; rate_regulation: rate_case, regulatory_filing.
9 workforce - workforce_management: employee, organization, craft_certification; field_operations: crew, field_dispatch, contractor, fleet_vehicle.
10 safety - incident_management: safety_incident, corrective_action; environmental_permits: environmental_permit, emissions_record; security_controls: nerc_cip_control.

Key relationships: service_point -> premise; meter -> service_point; service_agreement -> customer_account + service_point + rate_schedule; bill -> service_agreement; interval_usage -> meter; outage_event -> feeder; trouble_ticket -> service_point; work_order -> asset (grid or gas) + crew; gas_leak -> gas_main or gas_service_line; der_asset -> service_point + feeder; capital_project -> work_order; safety_incident -> employee.
