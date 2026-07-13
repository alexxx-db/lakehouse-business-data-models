-- Metric views for domain: masterdata | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_vessel_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the vessel master registry — fleet composition, compliance posture, capacity, and PSC risk profiling used by port operations, compliance, and commercial teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`vessel_master`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the vessel (Active, Laid-up, Scrapped, etc.) for fleet segmentation."
    - name: "vessel_type_id"
      expr: vessel_type_id
      comment: "FK to vessel type master — enables grouping fleet metrics by vessel category (container, bulk, tanker, RoRo, etc.)."
    - name: "flag_state_id"
      expr: flag_state_id
      comment: "FK to flag state — enables compliance and PSC risk analysis by flag of registration."
    - name: "shipping_line_id"
      expr: shipping_line_id
      comment: "FK to shipping line — enables fleet metrics segmented by carrier/operator."
    - name: "classification_society_code"
      expr: classification_society_code
      comment: "Classification society (Lloyd's, DNV, BV, etc.) for quality and compliance segmentation."
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "ISPS Code compliance flag — used to filter compliant vs non-compliant vessels for port access decisions."
    - name: "marpol_compliant"
      expr: marpol_compliant
      comment: "MARPOL compliance flag — environmental compliance segmentation for sustainability reporting."
    - name: "solas_compliant"
      expr: solas_compliant
      comment: "SOLAS compliance flag — safety compliance segmentation."
    - name: "is_current_record"
      expr: is_current_record
      comment: "Indicates whether this is the current active vessel master record (SCD Type 2 currency flag)."
    - name: "valid_from_date"
      expr: DATE_TRUNC('year', valid_from_date)
      comment: "Year the vessel master record became valid — for fleet vintage and registration trend analysis."
  measures:
    - name: "total_active_vessels"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Total distinct vessel master records — baseline fleet size KPI used in capacity planning and port call forecasting."
    - name: "total_fleet_teu_capacity"
      expr: SUM(CAST(teu_capacity AS DOUBLE))
      comment: "Aggregate TEU capacity across all vessels in the registry — primary fleet capacity KPI for commercial and operational planning. Requires teu_capacity to be castable to numeric."
    - name: "avg_vessel_loa_meters"
      expr: AVG(CAST(loa_meters AS DOUBLE))
      comment: "Average Length Overall (LOA) of vessels — informs berth allocation planning and infrastructure investment decisions."
    - name: "avg_vessel_beam_meters"
      expr: AVG(CAST(beam_meters AS DOUBLE))
      comment: "Average beam of vessels — critical for berth and channel width planning at the port."
    - name: "avg_summer_dwt"
      expr: AVG(CAST(summer_dwt AS DOUBLE))
      comment: "Average summer deadweight tonnage — indicates cargo-carrying capacity profile of the fleet calling the port."
    - name: "total_fleet_dwt"
      expr: SUM(CAST(summer_dwt AS DOUBLE))
      comment: "Total deadweight tonnage across all registered vessels — fleet capacity measure used in trade volume forecasting."
    - name: "avg_grt"
      expr: AVG(CAST(grt AS DOUBLE))
      comment: "Average Gross Register Tonnage — used for port dues calculation benchmarking and tariff analysis."
    - name: "isps_compliant_vessel_count"
      expr: COUNT(DISTINCT CASE WHEN isps_compliant = TRUE THEN vessel_master_id END)
      comment: "Number of ISPS-compliant vessels — security compliance KPI; non-compliant vessels may be denied port entry under ISPS Code."
    - name: "marpol_compliant_vessel_count"
      expr: COUNT(DISTINCT CASE WHEN marpol_compliant = TRUE THEN vessel_master_id END)
      comment: "Number of MARPOL-compliant vessels — environmental compliance KPI for port sustainability and regulatory reporting."
    - name: "isps_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN isps_compliant = TRUE THEN vessel_master_id END) / NULLIF(COUNT(DISTINCT vessel_master_id), 0), 2)
      comment: "Percentage of vessels that are ISPS Code compliant — strategic security KPI; low rates trigger port authority intervention."
    - name: "marpol_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marpol_compliant = TRUE THEN vessel_master_id END) / NULLIF(COUNT(DISTINCT vessel_master_id), 0), 2)
      comment: "Percentage of vessels that are MARPOL compliant — environmental compliance rate used in sustainability dashboards and regulatory submissions."
    - name: "solas_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN solas_compliant = TRUE THEN vessel_master_id END) / NULLIF(COUNT(DISTINCT vessel_master_id), 0), 2)
      comment: "Percentage of vessels that are SOLAS compliant — safety compliance rate; critical for port state control (PSC) risk management."
    - name: "avg_max_draft_meters"
      expr: AVG(CAST(maximum_draft_meters AS DOUBLE))
      comment: "Average maximum draft of vessels — used to assess channel and berth depth adequacy for the calling fleet."
    - name: "avg_propulsion_power_kw"
      expr: AVG(CAST(propulsion_power_kw AS DOUBLE))
      comment: "Average propulsion power (kW) across the fleet — proxy for fuel consumption and emissions intensity; feeds decarbonization planning."
    - name: "issc_expiry_within_90_days_count"
      expr: COUNT(DISTINCT CASE WHEN issc_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN vessel_master_id END)
      comment: "Number of vessels whose International Ship Security Certificate (ISSC) expires within 90 days — operational risk KPI requiring proactive renewal action."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_shipping_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial and operational KPIs over the shipping line registry — carrier performance, EDI connectivity, compliance posture, and fleet capacity used by commercial, operations, and compliance teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`shipping_line`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the shipping line (Active, Suspended, Terminated) for commercial segmentation."
    - name: "alliance_membership"
      expr: alliance_membership
      comment: "Shipping alliance membership (2M, THE Alliance, Ocean Alliance, etc.) — strategic grouping for volume and negotiation analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of service operated (Mainline, Feeder, Regional) — used to segment carrier metrics by service tier."
    - name: "fleet_size_category"
      expr: fleet_size_category
      comment: "Fleet size category (Mega, Large, Medium, Small) — for carrier tier analysis in commercial strategy."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Whether the shipping line has EDI integration enabled — digital connectivity KPI for port community system adoption."
    - name: "dangerous_goods_approved_flag"
      expr: dangerous_goods_approved_flag
      comment: "Whether the carrier is approved for dangerous goods (DG/IMDG) handling — compliance segmentation."
    - name: "isps_compliant_flag"
      expr: isps_compliant_flag
      comment: "ISPS compliance status of the shipping line — security compliance segmentation."
    - name: "country_id"
      expr: country_id
      comment: "Country of registration/headquarters — geographic segmentation for trade compliance and sanctions screening."
    - name: "tariff_group_code"
      expr: tariff_group_code
      comment: "Tariff group assigned to the shipping line — commercial segmentation for revenue analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the shipping line — financial risk segmentation for receivables management."
  measures:
    - name: "total_active_shipping_lines"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'Active' THEN shipping_line_id END)
      comment: "Total number of active shipping lines in the registry — baseline commercial KPI for port customer base size."
    - name: "avg_teu_per_call"
      expr: AVG(CAST(average_teu_per_call AS DOUBLE))
      comment: "Average TEU per vessel call across shipping lines — throughput intensity KPI used in berth and yard planning."
    - name: "avg_vessel_calls_per_month"
      expr: AVG(CAST(average_vessel_calls_per_month AS DOUBLE))
      comment: "Average monthly vessel calls per shipping line — call frequency KPI for resource and berth scheduling."
    - name: "total_monthly_vessel_calls"
      expr: SUM(CAST(average_vessel_calls_per_month AS DOUBLE))
      comment: "Total estimated monthly vessel calls across all active shipping lines — aggregate demand KPI for port capacity planning."
    - name: "edi_enabled_carrier_count"
      expr: COUNT(DISTINCT CASE WHEN edi_enabled_flag = TRUE THEN shipping_line_id END)
      comment: "Number of shipping lines with EDI integration enabled — digital adoption KPI for port community system (PCS) connectivity."
    - name: "edi_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN edi_enabled_flag = TRUE THEN shipping_line_id END) / NULLIF(COUNT(DISTINCT shipping_line_id), 0), 2)
      comment: "Percentage of shipping lines with EDI enabled — digital transformation KPI; low rates indicate manual processing risk and operational inefficiency."
    - name: "dg_approved_carrier_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dangerous_goods_approved_flag = TRUE THEN shipping_line_id END) / NULLIF(COUNT(DISTINCT shipping_line_id), 0), 2)
      comment: "Percentage of carriers approved for dangerous goods — IMDG compliance coverage KPI; informs DG cargo acceptance policy."
    - name: "isps_compliant_carrier_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN isps_compliant_flag = TRUE THEN shipping_line_id END) / NULLIF(COUNT(DISTINCT shipping_line_id), 0), 2)
      comment: "Percentage of ISPS-compliant shipping lines — security compliance KPI; non-compliant carriers may be restricted from port access."
    - name: "reefer_capable_carrier_count"
      expr: COUNT(DISTINCT CASE WHEN reefer_capable_flag = TRUE THEN shipping_line_id END)
      comment: "Number of carriers capable of handling reefer (temperature-controlled) cargo — cold chain capacity KPI for commercial planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_flag_state`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port State Control (PSC) risk, flag state compliance, and fleet registry KPIs — used by port authority, compliance, and marine operations teams for vessel vetting and risk-based inspection targeting."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`flag_state`"
  dimensions:
    - name: "active_status"
      expr: active_status
      comment: "Active/inactive status of the flag state registry entry."
    - name: "flag_of_convenience"
      expr: flag_of_convenience
      comment: "Flag of Convenience (FoC) indicator — FoC flags carry higher PSC targeting risk and require enhanced scrutiny."
    - name: "psc_list_classification"
      expr: psc_list_classification
      comment: "PSC MOU list classification (White, Grey, Black) — primary risk segmentation for port state control targeting."
    - name: "registry_type"
      expr: registry_type
      comment: "Type of ship registry (Open, National, Second) — regulatory and commercial segmentation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating of the flag state — used in vessel vetting and port access risk scoring."
    - name: "imo_member_status"
      expr: imo_member_status
      comment: "IMO membership status — compliance segmentation; non-IMO members have reduced regulatory oversight."
    - name: "marpol_ratified"
      expr: marpol_ratified
      comment: "Whether the flag state has ratified MARPOL — environmental compliance segmentation."
    - name: "mlc_ratified"
      expr: mlc_ratified
      comment: "Whether the flag state has ratified the Maritime Labour Convention (MLC 2006) — seafarer welfare compliance segmentation."
    - name: "solas_ratified"
      expr: solas_ratified
      comment: "Whether the flag state has ratified SOLAS — safety compliance segmentation."
  measures:
    - name: "total_flag_states"
      expr: COUNT(DISTINCT flag_state_id)
      comment: "Total number of flag states in the registry — baseline KPI for geographic and regulatory coverage."
    - name: "total_registered_dwt"
      expr: SUM(CAST(total_registered_dwt AS DOUBLE))
      comment: "Total deadweight tonnage registered under each flag state — fleet size KPI used in flag state risk weighting and PSC targeting."
    - name: "total_registered_grt"
      expr: SUM(CAST(total_registered_grt AS DOUBLE))
      comment: "Total Gross Register Tonnage under each flag state — fleet capacity KPI for port dues and tariff benchmarking."
    - name: "avg_psc_targeting_factor"
      expr: AVG(CAST(psc_targeting_factor AS DOUBLE))
      comment: "Average PSC targeting factor across flag states — risk intensity KPI; higher values indicate elevated inspection probability and port authority resource requirements."
    - name: "high_risk_flag_state_count"
      expr: COUNT(DISTINCT CASE WHEN psc_list_classification = 'Black' THEN flag_state_id END)
      comment: "Number of flag states on the PSC Black List — critical risk KPI; vessels under these flags receive priority inspection and may face port access restrictions."
    - name: "foc_flag_state_count"
      expr: COUNT(DISTINCT CASE WHEN flag_of_convenience = TRUE THEN flag_state_id END)
      comment: "Number of Flag of Convenience (FoC) registries — regulatory risk KPI; FoC flags are associated with lower compliance standards and higher PSC deficiency rates."
    - name: "marpol_ratification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marpol_ratified = TRUE THEN flag_state_id END) / NULLIF(COUNT(DISTINCT flag_state_id), 0), 2)
      comment: "Percentage of flag states that have ratified MARPOL — environmental compliance coverage KPI for port sustainability reporting."
    - name: "mlc_ratification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mlc_ratified = TRUE THEN flag_state_id END) / NULLIF(COUNT(DISTINCT flag_state_id), 0), 2)
      comment: "Percentage of flag states that have ratified MLC 2006 — seafarer welfare compliance KPI; non-ratified flags trigger enhanced crew welfare inspections."
    - name: "solas_ratification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN solas_ratified = TRUE THEN flag_state_id END) / NULLIF(COUNT(DISTINCT flag_state_id), 0), 2)
      comment: "Percentage of flag states that have ratified SOLAS — safety compliance coverage KPI for port authority risk management."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_commodity_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity master KPIs covering DG/IMDG classification coverage, trade control flags, temperature-controlled cargo prevalence, and tariff rate profiling — used by cargo operations, compliance, and commercial teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`commodity_code`"
  dimensions:
    - name: "commodity_code_status"
      expr: commodity_code_status
      comment: "Status of the commodity code (Active, Deprecated, Under Review) — for data quality and compliance monitoring."
    - name: "marpol_category"
      expr: marpol_category
      comment: "MARPOL Annex category of the commodity — environmental risk segmentation for port reception facility planning."
    - name: "packing_group"
      expr: packing_group
      comment: "IMDG packing group (I, II, III) — hazard severity segmentation for DG handling resource planning."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the commodity requires temperature control — reefer capacity planning segmentation."
    - name: "marine_pollutant"
      expr: marine_pollutant
      comment: "Marine pollutant flag per IMDG Code — environmental risk segmentation for spill response planning."
    - name: "prohibited_goods_flag"
      expr: prohibited_goods_flag
      comment: "Whether the commodity is prohibited — compliance and customs control segmentation."
    - name: "export_license_required"
      expr: export_license_required
      comment: "Whether an export license is required — trade compliance segmentation for customs processing workload."
    - name: "import_license_required"
      expr: import_license_required
      comment: "Whether an import license is required — trade compliance segmentation."
    - name: "wco_control_flag"
      expr: wco_control_flag
      comment: "WCO (World Customs Organization) control flag — customs risk segmentation for inspection targeting."
    - name: "hs_chapter"
      expr: hs_chapter
      comment: "HS Code chapter — high-level commodity classification for trade statistics and tariff analysis."
  measures:
    - name: "total_commodity_codes"
      expr: COUNT(DISTINCT commodity_code_id)
      comment: "Total number of commodity codes in the master registry — data completeness KPI for cargo classification coverage."
    - name: "dg_commodity_count"
      expr: COUNT(DISTINCT CASE WHEN imdg_class_id IS NOT NULL THEN commodity_code_id END)
      comment: "Number of commodity codes classified as dangerous goods (IMDG) — DG cargo scope KPI for safety planning and IMDG compliance resource allocation."
    - name: "dg_commodity_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN imdg_class_id IS NOT NULL THEN commodity_code_id END) / NULLIF(COUNT(DISTINCT commodity_code_id), 0), 2)
      comment: "Percentage of commodity codes classified as dangerous goods — DG prevalence KPI; high rates drive investment in DG handling infrastructure and trained personnel."
    - name: "temperature_controlled_commodity_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_controlled = TRUE THEN commodity_code_id END)
      comment: "Number of temperature-controlled commodity codes — reefer cargo scope KPI for cold chain infrastructure planning."
    - name: "marine_pollutant_commodity_count"
      expr: COUNT(DISTINCT CASE WHEN marine_pollutant = TRUE THEN commodity_code_id END)
      comment: "Number of commodity codes flagged as marine pollutants — environmental risk KPI for MARPOL compliance and spill response preparedness."
    - name: "avg_tariff_rate_pct"
      expr: AVG(CAST(tariff_rate_percent AS DOUBLE))
      comment: "Average tariff rate percentage across commodity codes — commercial benchmarking KPI for tariff structure analysis and revenue forecasting."
    - name: "avg_flash_point_celsius"
      expr: AVG(CAST(flash_point_celsius AS DOUBLE))
      comment: "Average flash point (°C) of flammable commodity codes — fire risk intensity KPI for terminal safety planning and fire suppression system sizing."
    - name: "export_license_required_count"
      expr: COUNT(DISTINCT CASE WHEN export_license_required = TRUE THEN commodity_code_id END)
      comment: "Number of commodity codes requiring export licenses — trade compliance workload KPI for customs processing capacity planning."
    - name: "prohibited_goods_count"
      expr: COUNT(DISTINCT CASE WHEN prohibited_goods_flag = TRUE THEN commodity_code_id END)
      comment: "Number of prohibited commodity codes in the registry — compliance risk KPI; any cargo movement against these codes triggers regulatory escalation."
    - name: "avg_temp_range_spread_celsius"
      expr: AVG(CAST(temperature_range_max_celsius AS DOUBLE) - CAST(temperature_range_min_celsius AS DOUBLE))
      comment: "Average temperature range spread (max minus min °C) for temperature-controlled commodities — reefer equipment specification KPI for procurement and asset management."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_container_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container type master KPIs covering fleet composition by ISO type, capacity profiling, reefer/hazmat/OOG capability mix, and weight class distribution — used by terminal operations, commercial, and asset management teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`container_type`"
  dimensions:
    - name: "container_category"
      expr: container_category
      comment: "Container category (Dry, Reefer, Tank, OOG, Flat Rack, etc.) — primary segmentation for yard planning and equipment allocation."
    - name: "size_code"
      expr: size_code
      comment: "ISO size code (20ft, 40ft, 45ft, etc.) — TEU/FEU conversion and berth/yard space planning segmentation."
    - name: "height_category"
      expr: height_category
      comment: "Height category (Standard, High Cube) — stacking and crane reach planning segmentation."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Reefer capability flag — cold chain capacity segmentation for reefer plug planning."
    - name: "is_hazmat_approved"
      expr: is_hazmat_approved
      comment: "Hazmat/IMDG approval flag — DG cargo handling capability segmentation."
    - name: "is_oog_capable"
      expr: is_oog_capable
      comment: "Out-of-Gauge (OOG) capability flag — special cargo handling segmentation."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the container type (Active, Phased Out) — data currency segmentation."
    - name: "iso_type_code"
      expr: iso_type_code
      comment: "ISO type code — standardized container classification for EDI messaging (COPARN, BAPLIE) and TOS integration."
  measures:
    - name: "total_container_types"
      expr: COUNT(DISTINCT container_type_id)
      comment: "Total number of distinct container types in the master registry — classification coverage KPI for TOS and EDI configuration completeness."
    - name: "avg_teu_equivalent"
      expr: AVG(CAST(teu_equivalent AS DOUBLE))
      comment: "Average TEU equivalent factor across container types — used to validate TEU conversion logic in throughput reporting."
    - name: "avg_max_payload_kg"
      expr: AVG(CAST(max_payload_kg AS DOUBLE))
      comment: "Average maximum payload capacity (kg) across container types — cargo weight planning KPI for VGM compliance and crane SWL management."
    - name: "avg_internal_capacity_cbm"
      expr: AVG(CAST(internal_capacity_cbm AS DOUBLE))
      comment: "Average internal cubic capacity (CBM) across container types — cargo volume planning KPI for stowage and load planning."
    - name: "avg_tare_weight_kg"
      expr: AVG(CAST(tare_weight_kg AS DOUBLE))
      comment: "Average tare weight (kg) — used in VGM (Verified Gross Mass) calculation benchmarking and axle load compliance for intermodal transport."
    - name: "reefer_type_count"
      expr: COUNT(DISTINCT CASE WHEN is_reefer = TRUE THEN container_type_id END)
      comment: "Number of reefer-capable container types — cold chain portfolio KPI for reefer plug capacity planning and commercial offering."
    - name: "hazmat_approved_type_count"
      expr: COUNT(DISTINCT CASE WHEN is_hazmat_approved = TRUE THEN container_type_id END)
      comment: "Number of IMDG/hazmat-approved container types — DG cargo capability KPI for compliance and commercial planning."
    - name: "oog_capable_type_count"
      expr: COUNT(DISTINCT CASE WHEN is_oog_capable = TRUE THEN container_type_id END)
      comment: "Number of OOG-capable container types — special cargo handling capability KPI for project cargo commercial strategy."
    - name: "avg_max_gross_weight_kg"
      expr: AVG(CAST(max_gross_weight_kg AS DOUBLE))
      comment: "Average maximum gross weight (kg) across container types — structural load planning KPI for yard surface, crane, and vessel stowage planning."
    - name: "avg_swl_kg"
      expr: AVG(CAST(swl_kg AS DOUBLE))
      comment: "Average Safe Working Load (SWL) in kg — crane and lifting equipment specification KPI for asset procurement and maintenance planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_equipment_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port equipment type master KPIs covering fleet capability, automation level, emissions compliance, and maintenance interval profiling — used by terminal operations, asset management, and sustainability teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`equipment_type`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category (STS Crane, RTG, Reach Stacker, Tractor, etc.) — primary segmentation for capacity and utilization analysis."
    - name: "equipment_subcategory"
      expr: equipment_subcategory
      comment: "Equipment subcategory for finer operational segmentation within each category."
    - name: "automation_level"
      expr: automation_level
      comment: "Automation level (Manual, Semi-Automated, Fully Automated) — strategic KPI for terminal modernization and labor planning."
    - name: "power_type"
      expr: power_type
      comment: "Power source (Diesel, Electric, Hybrid, LNG) — emissions and energy cost segmentation for sustainability reporting."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emission standard compliance (Tier III, Euro VI, etc.) — environmental compliance segmentation."
    - name: "equipment_type_status"
      expr: equipment_type_status
      comment: "Operational status of the equipment type (Active, Phased Out) — fleet currency segmentation."
    - name: "gps_tracking_enabled_flag"
      expr: gps_tracking_enabled_flag
      comment: "GPS tracking capability — digital asset visibility segmentation for TOS integration."
    - name: "iot_sensor_enabled_flag"
      expr: iot_sensor_enabled_flag
      comment: "IoT sensor capability — predictive maintenance readiness segmentation."
  measures:
    - name: "total_equipment_types"
      expr: COUNT(DISTINCT equipment_type_id)
      comment: "Total number of distinct equipment types in the master registry — fleet classification coverage KPI."
    - name: "avg_fuel_consumption_litres_per_hour"
      expr: AVG(CAST(fuel_consumption_litres_per_hour AS DOUBLE))
      comment: "Average fuel consumption (litres/hour) across equipment types — energy cost and emissions intensity KPI for sustainability and procurement planning."
    - name: "avg_power_consumption_kw"
      expr: AVG(CAST(power_consumption_kw AS DOUBLE))
      comment: "Average power consumption (kW) — energy demand KPI for shore power infrastructure planning and utility cost forecasting."
    - name: "avg_swl_rating_tonnes"
      expr: AVG(CAST(swl_rating_tonnes AS DOUBLE))
      comment: "Average Safe Working Load (SWL) in tonnes — lifting capacity KPI for cargo handling capability assessment and crane procurement decisions."
    - name: "avg_operational_speed_kmh"
      expr: AVG(CAST(operational_speed_kmh AS DOUBLE))
      comment: "Average operational speed (km/h) — productivity proxy KPI for terminal throughput modeling."
    - name: "avg_outreach_metres"
      expr: AVG(CAST(outreach_metres AS DOUBLE))
      comment: "Average crane outreach (metres) — vessel beam coverage KPI; determines which vessel classes can be served by the crane fleet."
    - name: "avg_lift_height_metres"
      expr: AVG(CAST(lift_height_metres AS DOUBLE))
      comment: "Average lift height (metres) — stacking tier capability KPI for yard density planning."
    - name: "automated_equipment_type_count"
      expr: COUNT(DISTINCT CASE WHEN automation_level IN ('Semi-Automated', 'Fully Automated') THEN equipment_type_id END)
      comment: "Number of automated or semi-automated equipment types — terminal automation KPI for modernization investment tracking."
    - name: "iot_enabled_equipment_type_count"
      expr: COUNT(DISTINCT CASE WHEN iot_sensor_enabled_flag = TRUE THEN equipment_type_id END)
      comment: "Number of IoT-sensor-enabled equipment types — predictive maintenance readiness KPI; drives maintenance cost reduction and uptime improvement."
    - name: "certification_required_equipment_count"
      expr: COUNT(DISTINCT CASE WHEN certification_required_flag = TRUE THEN equipment_type_id END)
      comment: "Number of equipment types requiring operator certification — workforce training demand KPI for HR and safety planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_port_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port location master KPIs covering infrastructure capacity, depth profiles, ISPS security levels, and operational readiness — used by port authority, infrastructure planning, and commercial teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`port_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of port location (Berth, Yard, Gate, Anchorage, ICD, etc.) — primary segmentation for infrastructure capacity analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the location (Active, Under Maintenance, Decommissioned) — availability segmentation."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "Current ISPS security level (1, 2, 3) at the location — security posture segmentation for MARSEC compliance reporting."
    - name: "environmental_zone"
      expr: environmental_zone
      comment: "Environmental zone classification (ECA, SECA, etc.) — emissions compliance segmentation for vessel fuel switching requirements."
    - name: "location_zone"
      expr: location_zone
      comment: "Operational zone within the port (FTZ, Bonded, General, Restricted) — customs and compliance segmentation."
    - name: "rfid_enabled"
      expr: rfid_enabled
      comment: "RFID tracking capability at the location — digital visibility segmentation for gate and yard automation."
    - name: "shore_crane_coverage"
      expr: shore_crane_coverage
      comment: "Whether the location has shore crane coverage — berth capability segmentation for vessel call planning."
  measures:
    - name: "total_port_locations"
      expr: COUNT(DISTINCT port_location_id)
      comment: "Total number of port locations in the master registry — infrastructure inventory KPI."
    - name: "avg_water_depth_meters"
      expr: AVG(CAST(water_depth_meters AS DOUBLE))
      comment: "Average water depth (metres) across port locations — critical infrastructure KPI; determines maximum vessel draft and constrains which vessel classes can call."
    - name: "max_water_depth_meters"
      expr: MAX(water_depth_meters)
      comment: "Maximum water depth available across all port locations — headline infrastructure capability KPI for attracting ultra-large container vessels (ULCV)."
    - name: "avg_max_vessel_loa_meters"
      expr: AVG(CAST(maximum_vessel_loa_meters AS DOUBLE))
      comment: "Average maximum vessel LOA (metres) accommodated across locations — berth length adequacy KPI for vessel size trend analysis."
    - name: "avg_max_vessel_dwt_tonnes"
      expr: AVG(CAST(maximum_vessel_dwt_tonnes AS DOUBLE))
      comment: "Average maximum vessel DWT (tonnes) accommodated — cargo throughput capacity KPI per location."
    - name: "avg_bollard_swl_tonnes"
      expr: AVG(CAST(bollard_swl_tonnes AS DOUBLE))
      comment: "Average bollard Safe Working Load (SWL) in tonnes — mooring infrastructure strength KPI for vessel size compatibility assessment."
    - name: "avg_fender_energy_absorption_kj"
      expr: AVG(CAST(fender_energy_absorption_kj AS DOUBLE))
      comment: "Average fender energy absorption (kJ) — berthing safety KPI; low values relative to vessel displacement indicate infrastructure upgrade need."
    - name: "rfid_enabled_location_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rfid_enabled = TRUE THEN port_location_id END) / NULLIF(COUNT(DISTINCT port_location_id), 0), 2)
      comment: "Percentage of port locations with RFID tracking enabled — digital infrastructure adoption KPI for gate and yard automation investment decisions."
    - name: "high_security_location_count"
      expr: COUNT(DISTINCT CASE WHEN isps_security_level IN ('2', '3') THEN port_location_id END)
      comment: "Number of port locations at elevated ISPS security levels (2 or 3) — security posture KPI; elevated levels trigger additional access controls and resource deployment."
    - name: "avg_max_vessel_beam_meters"
      expr: AVG(CAST(maximum_vessel_beam_meters AS DOUBLE))
      comment: "Average maximum vessel beam (metres) accommodated — channel and berth width adequacy KPI for next-generation vessel planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_imdg_class`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IMDG dangerous goods classification master KPIs — coverage, marine pollutant prevalence, and stowage category distribution used by cargo operations, safety, and compliance teams for DG handling governance."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`imdg_class`"
  dimensions:
    - name: "class_number"
      expr: class_number
      comment: "IMDG class number (1-9) — primary DG classification segmentation for segregation and stowage planning."
    - name: "division"
      expr: division
      comment: "IMDG class division (e.g., 1.1, 1.2, 2.1, 2.2) — sub-class segmentation for detailed DG risk analysis."
    - name: "stowage_category"
      expr: stowage_category
      comment: "IMDG stowage category (A-E) — vessel stowage planning segmentation; Category E requires on-deck stowage only."
    - name: "marine_pollutant_flag"
      expr: marine_pollutant_flag
      comment: "Marine pollutant flag — environmental risk segmentation for MARPOL compliance and spill response planning."
    - name: "packing_group"
      expr: packing_group
      comment: "IMDG packing group (I=high, II=medium, III=low hazard) — hazard severity segmentation for DG handling resource allocation."
    - name: "imdg_code_amendment_cycle"
      expr: imdg_code_amendment_cycle
      comment: "IMDG Code amendment cycle (e.g., 40-20, 41-22) — regulatory currency segmentation for compliance gap analysis."
  measures:
    - name: "total_imdg_classes"
      expr: COUNT(DISTINCT imdg_class_id)
      comment: "Total number of IMDG class/division entries in the master registry — classification completeness KPI for DG cargo acceptance governance."
    - name: "marine_pollutant_class_count"
      expr: COUNT(DISTINCT CASE WHEN marine_pollutant_flag = TRUE THEN imdg_class_id END)
      comment: "Number of IMDG classes flagged as marine pollutants — environmental risk scope KPI for MARPOL Annex III compliance and port reception facility planning."
    - name: "marine_pollutant_class_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marine_pollutant_flag = TRUE THEN imdg_class_id END) / NULLIF(COUNT(DISTINCT imdg_class_id), 0), 2)
      comment: "Percentage of IMDG classes that are marine pollutants — environmental risk prevalence KPI; drives investment in spill containment and response capability."
    - name: "on_deck_only_class_count"
      expr: COUNT(DISTINCT CASE WHEN stowage_category = 'E' THEN imdg_class_id END)
      comment: "Number of IMDG classes requiring on-deck stowage only (Category E) — vessel stowage constraint KPI; high counts reduce below-deck capacity utilization."
    - name: "high_hazard_class_count"
      expr: COUNT(DISTINCT CASE WHEN packing_group = 'I' THEN imdg_class_id END)
      comment: "Number of IMDG classes in Packing Group I (highest hazard) — safety risk intensity KPI for DG handling training and emergency response planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_edi_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDI partner connectivity and SLA KPIs for the Port Community System (PCS) — covering partner onboarding, message exchange health, encryption adoption, and SLA performance used by IT, operations, and commercial teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`edi_partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of EDI partner (Shipping Line, Customs, Freight Forwarder, Terminal, etc.) — segmentation for PCS connectivity analysis."
    - name: "edi_standard"
      expr: edi_standard
      comment: "EDI standard used (EDIFACT, XML, API, etc.) — technology segmentation for integration architecture planning."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol (AS2, SFTP, API, etc.) — connectivity method segmentation for infrastructure planning."
    - name: "connection_status"
      expr: connection_status
      comment: "Current connection status (Active, Inactive, Testing) — operational health segmentation."
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Whether encryption is enabled for this EDI partner — cybersecurity compliance segmentation."
    - name: "test_indicator"
      expr: test_indicator
      comment: "Whether this is a test/sandbox partner — production vs test environment segmentation."
    - name: "acknowledgment_required"
      expr: acknowledgment_required
      comment: "Whether message acknowledgment (CONTRL/997) is required — message reliability segmentation."
  measures:
    - name: "total_active_edi_partners"
      expr: COUNT(DISTINCT CASE WHEN connection_status = 'Active' THEN edi_partner_id END)
      comment: "Total number of active EDI partners — PCS connectivity KPI; baseline for port community digital integration coverage."
    - name: "avg_sla_availability_pct"
      expr: AVG(CAST(sla_availability_percentage AS DOUBLE))
      comment: "Average EDI SLA availability percentage across all partners — system reliability KPI; below-target values trigger SLA breach management and partner escalation."
    - name: "encryption_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN encryption_enabled = TRUE THEN edi_partner_id END) / NULLIF(COUNT(DISTINCT edi_partner_id), 0), 2)
      comment: "Percentage of EDI partners with encryption enabled — cybersecurity compliance KPI for data protection governance."
    - name: "active_partner_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN connection_status = 'Active' THEN edi_partner_id END) / NULLIF(COUNT(DISTINCT edi_partner_id), 0), 2)
      comment: "Percentage of EDI partners with active connections — PCS connectivity health KPI; low rates indicate integration gaps affecting cargo documentation flow."
    - name: "partners_with_recent_inbound_message_count"
      expr: COUNT(DISTINCT CASE WHEN last_inbound_message_timestamp >= DATE_SUB(CURRENT_TIMESTAMP(), 7) THEN edi_partner_id END)
      comment: "Number of EDI partners with inbound message activity in the last 7 days — active exchange health KPI; silent partners may indicate connectivity failures affecting cargo operations."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_service_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port service code master KPIs covering service portfolio composition, pricing benchmarks, billing configuration completeness, and SLA coverage — used by commercial, billing, and operations teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`service_code`"
  dimensions:
    - name: "service_category"
      expr: service_category
      comment: "Service category (Stevedoring, Pilotage, Towage, Storage, Gate, etc.) — primary segmentation for revenue and cost analysis."
    - name: "service_status"
      expr: service_status
      comment: "Status of the service code (Active, Deprecated, Pending) — portfolio currency segmentation."
    - name: "billing_basis"
      expr: billing_basis
      comment: "Billing basis (Per TEU, Per Move, Per Hour, Per Day, Per GRT, etc.) — revenue model segmentation for tariff analysis."
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Whether tax applies to this service — tax compliance segmentation for revenue reporting."
    - name: "surcharge_applicable_flag"
      expr: surcharge_applicable_flag
      comment: "Whether surcharges apply to this service — revenue complexity segmentation."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Whether the service is eligible for discounts — commercial flexibility segmentation."
    - name: "service_level_agreement_flag"
      expr: service_level_agreement_flag
      comment: "Whether an SLA governs this service — service quality commitment segmentation."
    - name: "is_bundled_service"
      expr: is_bundled_service
      comment: "Whether this is a bundled service offering — pricing complexity segmentation."
  measures:
    - name: "total_active_service_codes"
      expr: COUNT(DISTINCT CASE WHEN service_status = 'Active' THEN service_code_id END)
      comment: "Total number of active service codes — service portfolio size KPI for commercial and billing configuration completeness."
    - name: "avg_standard_rate"
      expr: AVG(CAST(standard_rate AS DOUBLE))
      comment: "Average standard rate across service codes — pricing benchmark KPI for tariff competitiveness analysis and commercial strategy."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge across service codes — revenue floor KPI for billing configuration review."
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum charge across service codes — revenue ceiling KPI for tariff cap analysis."
    - name: "sla_governed_service_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN service_level_agreement_flag = TRUE THEN service_code_id END) / NULLIF(COUNT(DISTINCT service_code_id), 0), 2)
      comment: "Percentage of service codes governed by an SLA — service quality commitment KPI; low rates indicate gaps in contractual service standards."
    - name: "tax_applicable_service_count"
      expr: COUNT(DISTINCT CASE WHEN tax_applicable_flag = TRUE THEN service_code_id END)
      comment: "Number of service codes subject to tax — tax compliance scope KPI for revenue reporting and VAT/GST configuration."
    - name: "bundled_service_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_bundled_service = TRUE THEN service_code_id END) / NULLIF(COUNT(DISTINCT service_code_id), 0), 2)
      comment: "Percentage of service codes that are bundled offerings — commercial packaging KPI; high rates indicate complex billing structures requiring careful revenue recognition."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country master KPIs covering sanctions exposure, maritime convention ratification, PSC MOU membership, and trade compliance posture — used by compliance, legal, and commercial teams for trade restriction and risk management."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`country`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Geographic region (Asia Pacific, Middle East, Europe, etc.) — regional trade and compliance segmentation."
    - name: "sub_region"
      expr: sub_region
      comment: "Geographic sub-region for finer geographic segmentation."
    - name: "sanctions_list_flag"
      expr: sanctions_list_flag
      comment: "Whether the country is on a sanctions list — critical compliance segmentation for trade restriction enforcement."
    - name: "imo_member_status"
      expr: imo_member_status
      comment: "IMO membership status — regulatory oversight segmentation."
    - name: "flag_state_indicator"
      expr: flag_state_indicator
      comment: "Whether the country operates as a flag state — vessel registry segmentation."
    - name: "fatf_status"
      expr: fatf_status
      comment: "FATF (Financial Action Task Force) status — financial crime risk segmentation for AML compliance."
    - name: "wco_member"
      expr: wco_member
      comment: "WCO membership — customs cooperation segmentation for trade facilitation analysis."
  measures:
    - name: "total_countries"
      expr: COUNT(DISTINCT country_id)
      comment: "Total number of countries in the master registry — geographic coverage KPI for trade compliance and sanctions screening completeness."
    - name: "sanctioned_country_count"
      expr: COUNT(DISTINCT CASE WHEN sanctions_list_flag = TRUE THEN country_id END)
      comment: "Number of sanctioned countries — trade compliance risk KPI; any cargo movement involving these countries triggers regulatory escalation and potential port access denial."
    - name: "avg_psc_targeting_factor"
      expr: AVG(CAST(psc_targeting_factor AS DOUBLE))
      comment: "Average PSC targeting factor across countries — fleet risk intensity KPI for port state control inspection resource planning."
    - name: "marpol_ratification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marpol_ratified = TRUE THEN country_id END) / NULLIF(COUNT(DISTINCT country_id), 0), 2)
      comment: "Percentage of countries that have ratified MARPOL — global environmental compliance coverage KPI for sustainability reporting."
    - name: "mlc_ratification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mlc_ratified = TRUE THEN country_id END) / NULLIF(COUNT(DISTINCT country_id), 0), 2)
      comment: "Percentage of countries that have ratified MLC 2006 — seafarer welfare compliance coverage KPI."
    - name: "solas_ratification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN solas_ratified = TRUE THEN country_id END) / NULLIF(COUNT(DISTINCT country_id), 0), 2)
      comment: "Percentage of countries that have ratified SOLAS — global safety compliance coverage KPI."
    - name: "isps_compliant_country_count"
      expr: COUNT(DISTINCT CASE WHEN isps_code_compliant = TRUE THEN country_id END)
      comment: "Number of ISPS Code compliant countries — port security compliance KPI; non-compliant origin/destination countries trigger enhanced security screening."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_vessel_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel type master KPIs covering fleet classification hierarchy, pilotage/towage requirements, DG capability, and environmental category distribution — used by marine operations, commercial, and compliance teams."
  source: "`vibe_shipping_ports_v1`.`masterdata`.`vessel_type`"
  dimensions:
    - name: "vessel_category"
      expr: vessel_category
      comment: "Vessel category (Container, Bulk, Tanker, RoRo, General Cargo, etc.) — primary fleet segmentation for berth and service planning."
    - name: "vessel_type_status"
      expr: vessel_type_status
      comment: "Status of the vessel type record (Active, Deprecated) — data currency segmentation."
    - name: "requires_pilotage"
      expr: requires_pilotage
      comment: "Whether vessels of this type require pilotage — marine services demand segmentation for pilot resource planning."
    - name: "requires_towage"
      expr: requires_towage
      comment: "Whether vessels of this type require towage — tug demand segmentation for tug fleet planning."
    - name: "dangerous_goods_capable"
      expr: dangerous_goods_capable
      comment: "Whether vessels of this type are capable of carrying dangerous goods — DG cargo acceptance segmentation."
    - name: "environmental_category"
      expr: environmental_category
      comment: "Environmental category of the vessel type — emissions and sustainability segmentation."
    - name: "cargo_handling_method"
      expr: cargo_handling_method
      comment: "Cargo handling method (LoLo, RoRo, LoRo, Bulk, etc.) — terminal equipment and berth type segmentation."
  measures:
    - name: "total_vessel_types"
      expr: COUNT(DISTINCT vessel_type_id)
      comment: "Total number of vessel types in the master registry — classification coverage KPI for TOS and marine services configuration."
    - name: "pilotage_required_type_count"
      expr: COUNT(DISTINCT CASE WHEN requires_pilotage = TRUE THEN vessel_type_id END)
      comment: "Number of vessel types requiring pilotage — marine services demand KPI for pilot resource planning and scheduling."
    - name: "towage_required_type_count"
      expr: COUNT(DISTINCT CASE WHEN requires_towage = TRUE THEN vessel_type_id END)
      comment: "Number of vessel types requiring towage — tug fleet demand KPI for tug procurement and scheduling."
    - name: "dg_capable_type_count"
      expr: COUNT(DISTINCT CASE WHEN dangerous_goods_capable = TRUE THEN vessel_type_id END)
      comment: "Number of vessel types capable of carrying dangerous goods — DG cargo acceptance scope KPI for IMDG compliance planning."
    - name: "avg_typical_teu_capacity_max"
      expr: AVG(CAST(typical_teu_capacity_max AS DOUBLE))
      comment: "Average maximum typical TEU capacity across vessel types — fleet capacity benchmark KPI for port throughput planning."
    - name: "avg_typical_loa_max_m"
      expr: AVG(CAST(typical_loa_max_m AS DOUBLE))
      comment: "Average maximum typical LOA (metres) across vessel types — berth length planning KPI for infrastructure investment decisions."
    - name: "avg_typical_draft_max_m"
      expr: AVG(CAST(typical_draft_max_m AS DOUBLE))
      comment: "Average maximum typical draft (metres) across vessel types — channel and berth depth planning KPI."
    - name: "avg_typical_dwt_max"
      expr: AVG(CAST(typical_dwt_max AS DOUBLE))
      comment: "Average maximum typical DWT across vessel types — cargo throughput capacity benchmark KPI."
    - name: "pilotage_required_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN requires_pilotage = TRUE THEN vessel_type_id END) / NULLIF(COUNT(DISTINCT vessel_type_id), 0), 2)
      comment: "Percentage of vessel types requiring pilotage — marine services demand intensity KPI; high rates drive pilot recruitment and training investment."
$$;