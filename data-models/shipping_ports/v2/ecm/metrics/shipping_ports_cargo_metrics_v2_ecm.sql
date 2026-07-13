-- Metric views for domain: cargo | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the shipment lifecycle — volume throughput, cargo mix, declared value, and transshipment share. Used by port operations and commercial leadership to monitor cargo flow, revenue exposure, and service mix."
  source: "`vibe_shipping_ports_v1`.`cargo`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current lifecycle status of the shipment (e.g. in-transit, discharged, delivered) for pipeline stage analysis."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Broad cargo classification (FCL, LCL, bulk, breakbulk) for mix analysis."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Incoterm / freight terms (CIF, FOB, etc.) indicating commercial responsibility split."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm code governing risk and cost transfer point for the shipment."
    - name: "is_transshipment"
      expr: is_transshipment
      comment: "Flag indicating whether the shipment is a transshipment move — critical for hub-port volume classification."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating presence of IMDG dangerous goods — drives regulatory and operational segmentation."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating reefer (temperature-controlled) cargo — premium service segment."
    - name: "is_oversized"
      expr: is_oversized
      comment: "Flag for out-of-gauge / oversized cargo requiring special handling."
    - name: "pod_port_code"
      expr: pod_port_code
      comment: "Port of discharge code — enables trade lane and destination analysis."
    - name: "pol_port_code"
      expr: pol_port_code
      comment: "Port of loading code — enables origin trade lane analysis."
    - name: "discharge_date_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month of discharge date for time-series throughput trending."
    - name: "cargo_condition"
      expr: cargo_condition
      comment: "Condition of cargo at time of recording — used for quality and claims analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment records — baseline throughput volume KPI for port operations."
    - name: "total_teu_count"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU volume across all shipments — primary capacity and throughput KPI for container terminals."
    - name: "total_feu_count"
      expr: SUM(CAST(feu_count AS DOUBLE))
      comment: "Total FEU (40-foot equivalent unit) volume — complements TEU for equipment planning."
    - name: "total_gross_weight_mt"
      expr: SUM(CAST(gross_weight_mt AS DOUBLE))
      comment: "Total gross cargo weight in metric tonnes — drives berth, crane, and structural load planning."
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared cargo value in USD — revenue exposure and insurance risk KPI."
    - name: "avg_declared_value_per_teu_usd"
      expr: AVG(CAST(declared_value_usd AS DOUBLE) / NULLIF(CAST(teu_count AS DOUBLE), 0))
      comment: "Average declared cargo value per TEU — cargo yield and premium cargo mix indicator."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres — warehouse and vessel capacity utilisation driver."
    - name: "transshipment_shipment_count"
      expr: COUNT(CASE WHEN is_transshipment = TRUE THEN 1 END)
      comment: "Count of transshipment shipments — critical KPI for hub ports where T/S is 50%+ of volume."
    - name: "dangerous_goods_shipment_count"
      expr: COUNT(CASE WHEN is_dangerous_goods = TRUE THEN 1 END)
      comment: "Count of shipments carrying IMDG dangerous goods — regulatory compliance and risk exposure KPI."
    - name: "reefer_shipment_count"
      expr: COUNT(CASE WHEN is_reefer = TRUE THEN 1 END)
      comment: "Count of reefer shipments — premium service segment volume for commercial planning."
    - name: "avg_teu_per_shipment"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU per shipment — indicates average shipment size and vessel utilisation efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_container`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container fleet and yard KPIs — condition, type mix, reefer utilisation, hazmat exposure, and dwell. Used by terminal operations, equipment planning, and compliance teams."
  source: "`vibe_shipping_ports_v1`.`cargo`.`container`"
  dimensions:
    - name: "container_status"
      expr: container_status
      comment: "Current operational status of the container (e.g. in-yard, on-vessel, gated-out) for inventory tracking."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the container — drives M&R decisions and liability assessment."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Reefer flag — segments the fleet into temperature-controlled vs standard for plug capacity planning."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Hazmat flag — identifies containers carrying dangerous goods for IMDG compliance monitoring."
    - name: "is_oversize"
      expr: is_oversize
      comment: "Oversize / out-of-gauge flag — drives special handling and yard planning."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Overweight flag — triggers VGM and structural compliance checks."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class — enables segregation compliance analysis by hazard class."
    - name: "operator_code"
      expr: operator_code
      comment: "Container operator / shipping line code — enables fleet analysis by operator."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code — destination analysis for yard planning."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code — origin analysis for container flow."
    - name: "gate_in_month"
      expr: DATE_TRUNC('MONTH', gate_in_timestamp)
      comment: "Month of gate-in event — time-series analysis of container intake volumes."
  measures:
    - name: "total_containers"
      expr: COUNT(1)
      comment: "Total container count in scope — baseline fleet inventory KPI."
    - name: "total_teu_capacity"
      expr: SUM(CAST(size_teu AS DOUBLE))
      comment: "Total TEU capacity of containers in scope — fleet size in standard units."
    - name: "total_tare_weight_kg"
      expr: SUM(CAST(tare_weight_kg AS DOUBLE))
      comment: "Total tare weight of containers — structural and berth load planning input."
    - name: "total_max_payload_kg"
      expr: SUM(CAST(max_payload_kg AS DOUBLE))
      comment: "Total maximum payload capacity across containers — fleet payload capacity KPI."
    - name: "reefer_container_count"
      expr: COUNT(CASE WHEN is_reefer = TRUE THEN 1 END)
      comment: "Count of reefer containers — reefer fleet size for plug capacity and revenue planning."
    - name: "hazmat_container_count"
      expr: COUNT(CASE WHEN is_hazmat = TRUE THEN 1 END)
      comment: "Count of hazmat containers — IMDG compliance exposure and segregation planning KPI."
    - name: "oversize_container_count"
      expr: COUNT(CASE WHEN is_oversize = TRUE THEN 1 END)
      comment: "Count of out-of-gauge containers — special handling resource planning KPI."
    - name: "avg_max_gross_weight_kg"
      expr: AVG(CAST(max_gross_weight_kg AS DOUBLE))
      comment: "Average maximum gross weight per container — fleet weight profile for structural planning."
    - name: "avg_cubic_capacity_cbm"
      expr: AVG(CAST(cubic_capacity_cbm AS DOUBLE))
      comment: "Average cubic capacity per container — volume utilisation benchmarking."
    - name: "containers_with_reefer_plug_required"
      expr: COUNT(CASE WHEN reefer_plug_required = TRUE THEN 1 END)
      comment: "Count of containers requiring reefer plug connection — active reefer plug demand KPI."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_demurrage_detention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demurrage and detention revenue, dispute, and waiver KPIs. Used by commercial, billing, and customer service teams to manage free-time compliance, revenue leakage, and dispute resolution performance."
  source: "`vibe_shipping_ports_v1`.`cargo`.`demurrage_detention`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Distinguishes demurrage (port/terminal dwell) from detention (off-dock dwell) charges."
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge (invoiced, disputed, waived, settled) for AR pipeline analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement outcome status — tracks collection efficiency and outstanding balances."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating the charge is under dispute — drives dispute resolution workload analysis."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo type associated with the demurrage/detention event — enables segment-level analysis."
    - name: "container_size_type"
      expr: container_size_type
      comment: "Container size/type (20GP, 40HC, etc.) — rate and volume analysis by equipment type."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge — trade lane analysis for demurrage concentration."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading — origin analysis for detention patterns."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the charge (per-diem, slab, etc.) — tariff structure analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date — time-series revenue trending for demurrage/detention."
  measures:
    - name: "total_demurrage_detention_charges"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total gross demurrage and detention charges invoiced — primary revenue KPI for this income stream."
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after waivers — actual collectible revenue KPI."
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total waiver amount granted — revenue leakage KPI; high values trigger commercial policy review."
    - name: "total_daily_rate_amount"
      expr: SUM(CAST(daily_rate_amount AS DOUBLE))
      comment: "Sum of daily rates across active charges — run-rate revenue exposure indicator."
    - name: "disputed_charge_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Count of charges under dispute — customer satisfaction and billing quality KPI."
    - name: "total_disputed_charge_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(total_charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of disputed charges — financial risk exposure from billing disputes."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(waiver_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross charges waived — commercial discipline KPI; high rates indicate policy abuse or poor tariff enforcement."
    - name: "avg_net_charge_per_event"
      expr: AVG(CAST(net_charge_amount AS DOUBLE))
      comment: "Average net charge per demurrage/detention event — benchmarks charge intensity by segment."
    - name: "total_charge_events"
      expr: COUNT(1)
      comment: "Total number of demurrage/detention charge events — volume baseline for rate and trend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_damage_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo damage claim KPIs covering claim volume, estimated loss, settlement efficiency, and liability. Used by risk, legal, and operations teams to manage cargo liability exposure and claims resolution performance."
  source: "`vibe_shipping_ports_v1`.`cargo`.`damage_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the damage claim (open, under-investigation, settled, rejected) — pipeline stage analysis."
    - name: "damage_type"
      expr: damage_type
      comment: "Type of damage (physical, moisture, contamination, theft, etc.) — root cause and prevention analysis."
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (shipper, consignee, insurer, etc.) — liability and relationship management segmentation."
    - name: "liability_assessment"
      expr: liability_assessment
      comment: "Liability determination outcome — drives apportionment and recovery analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the claim — multi-currency exposure analysis."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge associated with the claim — geographic concentration of damage events."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading associated with the claim — origin-side damage pattern analysis."
    - name: "claim_lodgement_month"
      expr: DATE_TRUNC('MONTH', claim_lodgement_date)
      comment: "Month of claim lodgement — time-series claims frequency trending."
  measures:
    - name: "total_damage_claims"
      expr: COUNT(1)
      comment: "Total number of damage claims lodged — baseline claims frequency KPI for risk management."
    - name: "total_estimated_loss_value"
      expr: SUM(CAST(estimated_loss_value AS DOUBLE))
      comment: "Total estimated loss value across all claims — gross financial exposure KPI for risk and insurance."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled across closed claims — actual cash outflow for cargo liability."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim — benchmarks claim severity and negotiation outcomes."
    - name: "settlement_to_estimate_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_loss_value AS DOUBLE)), 0), 2)
      comment: "Settlement amount as a percentage of estimated loss — measures claims provisioning accuracy and negotiation efficiency."
    - name: "open_claim_count"
      expr: COUNT(CASE WHEN claim_status NOT IN ('settled', 'rejected', 'closed') THEN 1 END)
      comment: "Count of open/unresolved damage claims — outstanding liability exposure KPI."
    - name: "open_claim_estimated_exposure"
      expr: SUM(CASE WHEN claim_status NOT IN ('settled', 'rejected', 'closed') THEN CAST(estimated_loss_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated loss value of open claims — current unresolved financial exposure for provisioning."
    - name: "avg_estimated_loss_per_claim"
      expr: AVG(CAST(estimated_loss_value AS DOUBLE))
      comment: "Average estimated loss per claim — claim severity indicator for risk appetite and insurance premium benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_handling_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel cargo handling operation KPIs — productivity, delay, TEU throughput, and operational efficiency. Used by terminal operations management and vessel planning teams to steer crane and gang performance."
  source: "`vibe_shipping_ports_v1`.`cargo`.`handling_order`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of cargo operation (load, discharge, restow, shift) — enables productivity analysis by operation."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the handling order (planned, in-progress, completed, cancelled) — pipeline analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the handling order — revenue recognition and unbilled work tracking."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag for dangerous goods operations — compliance and safety segmentation."
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Flag for reefer cargo operations — premium service segment productivity analysis."
    - name: "oversized_cargo_flag"
      expr: oversized_cargo_flag
      comment: "Flag for out-of-gauge cargo operations — special handling productivity impact."
    - name: "thc_applicable_flag"
      expr: thc_applicable_flag
      comment: "Flag indicating terminal handling charge applicability — revenue-linked operation segmentation."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('MONTH', planned_start_datetime)
      comment: "Month of planned operation start — time-series throughput and productivity trending."
  measures:
    - name: "total_handling_orders"
      expr: COUNT(1)
      comment: "Total number of handling orders — baseline operational volume KPI."
    - name: "total_teu_completed"
      expr: SUM(CAST(total_teu_completed AS DOUBLE))
      comment: "Total TEU moves completed across all handling orders — primary terminal throughput KPI."
    - name: "total_teu_planned"
      expr: SUM(CAST(total_teu_planned AS DOUBLE))
      comment: "Total TEU moves planned — plan vs actual comparison baseline."
    - name: "plan_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(total_teu_completed AS DOUBLE)) / NULLIF(SUM(CAST(total_teu_planned AS DOUBLE)), 0), 2)
      comment: "Percentage of planned TEU moves completed — operational plan achievement KPI for terminal management."
    - name: "total_equipment_delay_minutes"
      expr: SUM(CAST(equipment_delay_minutes AS DOUBLE))
      comment: "Total equipment delay minutes — equipment reliability and maintenance impact KPI."
    - name: "total_vessel_delay_minutes"
      expr: SUM(CAST(vessel_delay_minutes AS DOUBLE))
      comment: "Total vessel delay minutes attributable to cargo operations — vessel turnaround performance KPI."
    - name: "total_weather_delay_minutes"
      expr: SUM(CAST(weather_delay_minutes AS DOUBLE))
      comment: "Total weather delay minutes — force majeure impact quantification for SLA management."
    - name: "total_terminal_delay_minutes"
      expr: SUM(CAST(terminal_delay_minutes AS DOUBLE))
      comment: "Total terminal-attributable delay minutes — internal operational efficiency KPI."
    - name: "avg_gross_crane_productivity_target"
      expr: AVG(CAST(gross_crane_productivity_target AS DOUBLE))
      comment: "Average gross crane productivity target (moves/hour) — benchmarks planned vs achievable crane performance."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel manifest KPIs covering cargo declaration completeness, customs submission, and cargo mix. Used by port authority, customs, and shipping line teams to monitor regulatory compliance and cargo visibility."
  source: "`vibe_shipping_ports_v1`.`cargo`.`manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Current status of the manifest (draft, submitted, accepted, amended) — compliance pipeline analysis."
    - name: "manifest_type"
      expr: manifest_type
      comment: "Type of manifest (import, export, transshipment, coastal) — regulatory and operational segmentation."
    - name: "customs_submission_status"
      expr: customs_submission_status
      comment: "Customs submission status — regulatory compliance KPI for pre-arrival declaration timeliness."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag for manifests containing dangerous goods — IMDG compliance monitoring."
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Flag for manifests containing reefer cargo — premium cargo volume tracking."
    - name: "oversized_cargo_flag"
      expr: oversized_cargo_flag
      comment: "Flag for manifests containing out-of-gauge cargo — special handling planning."
    - name: "pod_port_code"
      expr: pod_port_code
      comment: "Port of discharge — trade lane analysis for manifest volumes."
    - name: "pol_port_code"
      expr: pol_port_code
      comment: "Port of loading — origin analysis for manifest flows."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of manifest submission — time-series compliance and volume trending."
  measures:
    - name: "total_manifests"
      expr: COUNT(1)
      comment: "Total number of manifests processed — baseline vessel call and cargo declaration volume KPI."
    - name: "total_teu_declared"
      expr: SUM(CAST(total_teu_count AS DOUBLE))
      comment: "Total TEU declared across all manifests — aggregate throughput volume from declaration data."
    - name: "total_declared_value_usd"
      expr: SUM(CAST(total_declared_value_usd AS DOUBLE))
      comment: "Total declared cargo value in USD across manifests — customs and insurance exposure KPI."
    - name: "total_weight_mt"
      expr: SUM(CAST(total_weight_mt AS DOUBLE))
      comment: "Total cargo weight in metric tonnes declared on manifests — port capacity and structural load KPI."
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres declared — warehouse and vessel stowage planning input."
    - name: "customs_submission_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customs_submission_status = 'accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of manifests with accepted customs submission — regulatory compliance rate KPI for port authority reporting."
    - name: "manifests_with_dangerous_goods"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Count of manifests containing dangerous goods — IMDG compliance workload and risk exposure KPI."
    - name: "avg_teu_per_manifest"
      expr: AVG(CAST(total_teu_count AS DOUBLE))
      comment: "Average TEU per manifest — vessel utilisation and cargo density indicator."
    - name: "avg_declared_value_per_manifest_usd"
      expr: AVG(CAST(total_declared_value_usd AS DOUBLE))
      comment: "Average declared cargo value per manifest — cargo value intensity benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_verified_gross_mass`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOLAS VGM compliance KPIs — submission timeliness, verification method mix, and compliance rate. Used by port authority, shipping lines, and terminal operators to ensure SOLAS Chapter VI VGM regulatory compliance."
  source: "`vibe_shipping_ports_v1`.`cargo`.`verified_gross_mass`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "VGM verification status (verified, rejected, pending) — compliance pipeline analysis."
    - name: "weighing_method"
      expr: weighing_method
      comment: "SOLAS VGM Method 1 (direct weighing) vs Method 2 (calculated) — method compliance and accuracy analysis."
    - name: "submission_compliance_flag"
      expr: submission_compliance_flag
      comment: "Flag indicating whether VGM was submitted within the required deadline — SOLAS compliance KPI."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge — trade lane VGM compliance analysis."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading — origin VGM submission compliance analysis."
    - name: "weighing_date_month"
      expr: DATE_TRUNC('MONTH', weighing_datetime)
      comment: "Month of weighing event — time-series VGM compliance trending."
  measures:
    - name: "total_vgm_submissions"
      expr: COUNT(1)
      comment: "Total VGM submissions — baseline SOLAS compliance volume KPI."
    - name: "vgm_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VGM submissions meeting the SOLAS deadline — primary regulatory compliance KPI reported to port authority."
    - name: "total_gross_mass_kg"
      expr: SUM(CAST(gross_mass_kg AS DOUBLE))
      comment: "Total verified gross mass in kg across all submissions — aggregate cargo weight for structural and stability planning."
    - name: "avg_gross_mass_kg"
      expr: AVG(CAST(gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass per container — weight profile benchmarking for vessel stability calculations."
    - name: "rejected_vgm_count"
      expr: COUNT(CASE WHEN verification_status = 'rejected' THEN 1 END)
      comment: "Count of rejected VGM submissions — data quality and shipper compliance failure KPI."
    - name: "non_compliant_submission_count"
      expr: COUNT(CASE WHEN submission_compliance_flag = FALSE THEN 1 END)
      comment: "Count of VGM submissions that missed the SOLAS deadline — regulatory breach exposure KPI."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_dangerous_goods_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IMDG dangerous goods declaration KPIs — declaration volume, inspection compliance, marine pollutant exposure, and acceptance rates. Used by port authority, HSSE, and compliance teams to manage DG regulatory obligations."
  source: "`vibe_shipping_ports_v1`.`cargo`.`dangerous_goods_declaration`"
  dimensions:
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG hazard class (1-9) — primary segmentation for DG risk and segregation analysis."
    - name: "packing_group"
      expr: packing_group
      comment: "IMDG packing group (I, II, III) — risk severity segmentation within each hazard class."
    - name: "stowage_category"
      expr: stowage_category
      comment: "IMDG stowage category (A-E) — vessel stowage compliance analysis."
    - name: "port_authority_acceptance_status"
      expr: port_authority_acceptance_status
      comment: "Port authority acceptance status of the DGD — regulatory approval pipeline analysis."
    - name: "marine_pollutant_flag"
      expr: marine_pollutant_flag
      comment: "MARPOL marine pollutant flag — environmental compliance and spill risk KPI segmentation."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Flag indicating physical inspection is required — inspection workload planning."
    - name: "limited_quantity_flag"
      expr: limited_quantity_flag
      comment: "Limited quantity exemption flag — regulatory treatment segmentation."
    - name: "excepted_quantity_flag"
      expr: excepted_quantity_flag
      comment: "Excepted quantity exemption flag — regulatory treatment segmentation."
    - name: "declaration_date_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month of DGD declaration — time-series DG volume and compliance trending."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge — trade lane DG risk concentration analysis."
  measures:
    - name: "total_dgd_count"
      expr: COUNT(1)
      comment: "Total dangerous goods declarations — baseline DG cargo volume KPI for regulatory reporting."
    - name: "total_gross_quantity"
      expr: SUM(CAST(gross_quantity AS DOUBLE))
      comment: "Total gross quantity of dangerous goods declared — aggregate DG volume for risk exposure assessment."
    - name: "total_net_quantity"
      expr: SUM(CAST(net_quantity AS DOUBLE))
      comment: "Total net quantity of dangerous goods — actual hazardous substance volume for MARPOL and IMDG reporting."
    - name: "marine_pollutant_declaration_count"
      expr: COUNT(CASE WHEN marine_pollutant_flag = TRUE THEN 1 END)
      comment: "Count of declarations involving MARPOL marine pollutants — environmental risk exposure KPI."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Count of DGDs requiring physical inspection — inspection resource demand KPI."
    - name: "port_authority_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN port_authority_acceptance_status = 'accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DGDs accepted by port authority — DG documentation quality and compliance rate KPI."
    - name: "avg_flash_point_celsius"
      expr: AVG(CAST(flash_point_celsius AS DOUBLE))
      comment: "Average flash point of flammable DG cargo — fire risk profile indicator for terminal safety planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_container_gate_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate throughput, turnaround time, and compliance KPIs. Used by terminal operations and security teams to monitor gate efficiency, damage detection rates, and hazmat gate compliance."
  source: "`vibe_shipping_ports_v1`.`cargo`.`container_gate_transaction`"
  dimensions:
    - name: "container_condition"
      expr: container_condition
      comment: "Container condition recorded at gate — damage detection and EIR quality analysis."
    - name: "container_size_type"
      expr: container_size_type
      comment: "Container size/type at gate — throughput analysis by equipment type."
    - name: "damage_report_indicator"
      expr: damage_report_indicator
      comment: "Flag indicating a damage report was raised at gate — damage detection rate KPI."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Hazmat flag at gate — DG gate compliance monitoring."
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Reefer flag at gate — reefer gate processing volume analysis."
    - name: "seal_verification_status"
      expr: seal_verification_status
      comment: "Seal verification outcome at gate — security compliance KPI."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class of hazmat containers at gate — DG gate compliance by hazard class."
    - name: "gate_in_date_month"
      expr: DATE_TRUNC('MONTH', gate_in_time)
      comment: "Month of gate-in event — time-series gate throughput trending."
  measures:
    - name: "total_gate_transactions"
      expr: COUNT(1)
      comment: "Total gate transactions processed — primary gate throughput KPI for terminal operations."
    - name: "avg_turnaround_time_minutes"
      expr: AVG(CAST(turnaround_time_minutes AS DOUBLE))
      comment: "Average truck turnaround time at gate in minutes — gate efficiency KPI; directly impacts truck queue and port congestion."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight processed through gate — aggregate weight throughput for structural and compliance monitoring."
    - name: "damage_report_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_report_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gate transactions with a damage report — cargo condition quality KPI and liability trigger rate."
    - name: "hazmat_gate_transaction_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END)
      comment: "Count of hazmat container gate transactions — DG gate compliance volume KPI."
    - name: "seal_verification_failure_count"
      expr: COUNT(CASE WHEN seal_verification_status NOT IN ('verified', 'ok', 'passed') THEN 1 END)
      comment: "Count of gate transactions with failed seal verification — security breach indicator and ISPS compliance KPI."
    - name: "max_turnaround_time_minutes"
      expr: MAX(CAST(turnaround_time_minutes AS DOUBLE))
      comment: "Maximum truck turnaround time — outlier detection for gate bottleneck and congestion management."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual cargo move KPIs — productivity, weight throughput, hazmat exposure, and operational efficiency at the move level. Used by terminal operations and equipment planning teams to manage crane and yard productivity."
  source: "`vibe_shipping_ports_v1`.`cargo`.`move`"
  dimensions:
    - name: "move_type"
      expr: move_type
      comment: "Type of move (load, discharge, shift, restow, yard-move) — productivity analysis by operation type."
    - name: "move_status"
      expr: move_status
      comment: "Current status of the move (planned, in-progress, completed, exception) — operational pipeline analysis."
    - name: "kind"
      expr: kind
      comment: "Move kind (laden, empty, reefer, hazmat) — cargo mix analysis at move level."
    - name: "stage"
      expr: stage
      comment: "Operational stage of the move (vessel, yard, gate) — stage-level productivity analysis."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Hazardous cargo flag — DG move volume and compliance segmentation."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Reefer move flag — premium cargo handling volume analysis."
    - name: "is_oversize"
      expr: is_oversize
      comment: "Oversize move flag — special handling productivity impact analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type used for the move (STS crane, RTG, reach stacker) — equipment utilisation analysis."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Destination location type (vessel, yard, gate, warehouse) — move flow analysis."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month of actual move start — time-series productivity trending."
  measures:
    - name: "total_moves"
      expr: COUNT(1)
      comment: "Total number of cargo moves — primary terminal productivity volume KPI (moves per hour basis)."
    - name: "total_teu_moved"
      expr: SUM(CAST(container_size_teu AS DOUBLE))
      comment: "Total TEU equivalent moved — aggregate throughput in standard units for terminal benchmarking."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight handled in kg — weight throughput KPI for equipment and structural planning."
    - name: "avg_move_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average move duration in minutes — crane and equipment cycle time KPI; drives gross crane productivity calculations."
    - name: "total_move_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total move duration in minutes — aggregate equipment utilisation time for shift planning."
    - name: "hazardous_move_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Count of hazardous cargo moves — DG handling volume for IMDG compliance and safety resource planning."
    - name: "exception_move_count"
      expr: COUNT(CASE WHEN move_status = 'exception' THEN 1 END)
      comment: "Count of moves with exceptions — operational quality KPI; high exception rates indicate equipment or process failures."
    - name: "moves_per_teu_ratio"
      expr: ROUND(COUNT(1) / NULLIF(SUM(CAST(container_size_teu AS DOUBLE)), 0), 4)
      comment: "Moves per TEU ratio — efficiency indicator; values above 1.0 indicate excessive rehandling or restow moves."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_stowage_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel stowage plan KPIs — TEU utilisation, reefer plug utilisation, hazmat compliance, and plan quality. Used by vessel planners, terminal operators, and shipping lines to optimise vessel loading and ensure SOLAS/IMDG compliance."
  source: "`vibe_shipping_ports_v1`.`cargo`.`stowage_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the stowage plan (draft, submitted, approved, active) — plan lifecycle analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of stowage plan (pre-load, final, BAPLIE) — plan type mix analysis."
    - name: "hazmat_segregation_compliant_flag"
      expr: hazmat_segregation_compliant_flag
      comment: "Flag indicating IMDG hazmat segregation compliance — critical safety and regulatory KPI."
    - name: "is_active"
      expr: is_active
      comment: "Flag for currently active stowage plans — filters to live operational plans."
    - name: "shipping_line_code"
      expr: shipping_line_code
      comment: "Shipping line code — enables per-operator stowage plan analysis."
    - name: "plan_submission_month"
      expr: DATE_TRUNC('MONTH', plan_submission_datetime)
      comment: "Month of plan submission — time-series plan volume and compliance trending."
  measures:
    - name: "total_stowage_plans"
      expr: COUNT(1)
      comment: "Total stowage plans created — baseline vessel planning volume KPI."
    - name: "total_teu_loaded"
      expr: SUM(CAST(total_teu_loaded AS DOUBLE))
      comment: "Total TEU loaded across all stowage plans — aggregate vessel loading throughput KPI."
    - name: "total_weight_mt"
      expr: SUM(CAST(total_weight_mt AS DOUBLE))
      comment: "Total cargo weight in metric tonnes across stowage plans — vessel structural load KPI."
    - name: "hazmat_segregation_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_segregation_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stowage plans with IMDG hazmat segregation compliance — critical safety and regulatory KPI for port authority reporting."
    - name: "avg_reefer_plug_utilisation_pct"
      expr: ROUND(100.0 * AVG(CAST(reefer_plug_count_used AS DOUBLE) / NULLIF(CAST(reefer_plug_capacity AS DOUBLE), 0)), 2)
      comment: "Average reefer plug utilisation percentage — reefer capacity planning KPI for vessel and terminal operators."
    - name: "total_hazmat_containers"
      expr: SUM(CAST(hazmat_container_count AS DOUBLE))
      comment: "Total hazmat containers across stowage plans — aggregate DG cargo volume for IMDG compliance reporting."
    - name: "avg_list_value_degrees"
      expr: AVG(CAST(list_value_degrees AS DOUBLE))
      comment: "Average vessel list value in degrees across stowage plans — stability compliance indicator; values outside tolerance trigger plan revision."
    - name: "avg_trim_value_meters"
      expr: AVG(CAST(trim_value_meters AS DOUBLE))
      comment: "Average vessel trim value in metres — stability and draft compliance KPI for SOLAS requirements."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`cargo_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of lading KPIs covering cargo documentation volume, freight revenue, weight/volume, and dangerous goods. Used by commercial, documentation, and compliance teams to monitor cargo documentation quality and freight revenue."
  source: "`vibe_shipping_ports_v1`.`cargo`.`bill_of_lading`"
  dimensions:
    - name: "bol_status"
      expr: bol_status
      comment: "Current status of the B/L (draft, issued, released, surrendered, telex-released) — documentation lifecycle analysis."
    - name: "bol_type"
      expr: bol_type
      comment: "Type of B/L (original, seaway, express, switch) — documentation type mix analysis."
    - name: "release_type"
      expr: release_type
      comment: "Release type (original surrender, telex release, sea waybill) — cargo release method analysis."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the B/L — cargo availability and documentation clearance KPI."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight terms (prepaid, collect) — revenue recognition and collection risk segmentation."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Dangerous goods flag on B/L — DG documentation compliance segmentation."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code — trade lane analysis for B/L volumes."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code — origin trade lane analysis."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of B/L issue — time-series documentation volume and freight revenue trending."
    - name: "freight_currency"
      expr: freight_currency
      comment: "Currency of freight amount — multi-currency revenue analysis."
  measures:
    - name: "total_bills_of_lading"
      expr: COUNT(1)
      comment: "Total bills of lading issued — baseline cargo documentation volume KPI."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight amount across all B/Ls — primary freight revenue KPI for commercial reporting."
    - name: "avg_freight_amount"
      expr: AVG(CAST(freight_amount AS DOUBLE))
      comment: "Average freight amount per B/L — freight yield benchmarking and commercial performance indicator."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross cargo weight declared on B/Ls — aggregate weight throughput from documentation."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres declared on B/Ls — vessel and warehouse capacity planning input."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net cargo weight — customs and duty calculation basis."
    - name: "dangerous_goods_bol_count"
      expr: COUNT(CASE WHEN is_dangerous_goods = TRUE THEN 1 END)
      comment: "Count of B/Ls covering dangerous goods — DG documentation compliance volume KPI."
    - name: "amended_bol_count"
      expr: COUNT(CASE WHEN CAST(amendment_count AS INT) > 0 THEN 1 END)
      comment: "Count of B/Ls with at least one amendment — documentation quality and rework KPI; high rates indicate booking or data quality issues."
    - name: "avg_freight_per_kg"
      expr: ROUND(SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_weight_kg AS DOUBLE)), 0), 4)
      comment: "Average freight rate per kg of gross cargo weight — freight yield density KPI for commercial benchmarking."
$$;