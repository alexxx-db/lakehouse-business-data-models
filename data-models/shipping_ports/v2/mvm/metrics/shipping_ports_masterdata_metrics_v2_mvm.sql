-- Metric views for domain: masterdata | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:21:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_vessel_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vessel fleet performance and compliance metrics for operational and strategic decision-making"
  source: "`vibe_shipping_ports_v1`.`masterdata`.`vessel_master`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the vessel (active, inactive, under maintenance)"
    - name: "flag_state"
      expr: flag_state_id
      comment: "Flag state identifier for regulatory and compliance segmentation"
    - name: "vessel_type"
      expr: vessel_type_id
      comment: "Vessel type identifier for fleet composition analysis"
    - name: "ice_class"
      expr: ice_class
      comment: "Ice class rating for operational capability segmentation"
    - name: "classification_society"
      expr: classification_society_code
      comment: "Classification society code for quality and compliance tracking"
    - name: "compliance_status"
      expr: CASE WHEN isps_compliant = TRUE AND marpol_compliant = TRUE AND solas_compliant = TRUE THEN 'Fully Compliant' WHEN isps_compliant = FALSE OR marpol_compliant = FALSE OR solas_compliant = FALSE THEN 'Non-Compliant' ELSE 'Unknown' END
      comment: "Consolidated compliance status across ISPS, MARPOL, and SOLAS regulations"
    - name: "vessel_age_category"
      expr: CASE WHEN CAST(year_built AS INT) >= YEAR(CURRENT_DATE()) - 5 THEN 'New (0-5 years)' WHEN CAST(year_built AS INT) >= YEAR(CURRENT_DATE()) - 15 THEN 'Modern (6-15 years)' WHEN CAST(year_built AS INT) >= YEAR(CURRENT_DATE()) - 25 THEN 'Mature (16-25 years)' ELSE 'Aging (25+ years)' END
      comment: "Vessel age category for fleet modernization and replacement planning"
    - name: "capacity_tier"
      expr: CASE WHEN CAST(teu_capacity AS INT) >= 10000 THEN 'Ultra Large (10k+ TEU)' WHEN CAST(teu_capacity AS INT) >= 5000 THEN 'Large (5k-10k TEU)' WHEN CAST(teu_capacity AS INT) >= 2000 THEN 'Medium (2k-5k TEU)' WHEN CAST(teu_capacity AS INT) > 0 THEN 'Small (<2k TEU)' ELSE 'Non-Container' END
      comment: "TEU capacity tier for fleet capacity planning and berth allocation"
    - name: "psc_risk_category"
      expr: CASE WHEN CAST(psc_deficiency_count AS INT) = 0 THEN 'Low Risk' WHEN CAST(psc_deficiency_count AS INT) <= 5 THEN 'Medium Risk' WHEN CAST(psc_deficiency_count AS INT) > 5 THEN 'High Risk' ELSE 'Unknown' END
      comment: "Port State Control risk category based on deficiency count"
  measures:
    - name: "total_fleet_count"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Total number of unique vessels in the fleet for capacity planning"
    - name: "total_teu_capacity"
      expr: SUM(CAST(teu_capacity AS DOUBLE))
      comment: "Total TEU capacity across the fleet for strategic capacity management"
    - name: "total_dwt_capacity"
      expr: SUM(CAST(summer_dwt AS DOUBLE))
      comment: "Total deadweight tonnage capacity for cargo volume planning"
    - name: "total_grt"
      expr: SUM(CAST(grt AS DOUBLE))
      comment: "Total gross registered tonnage for regulatory and port fee calculations"
    - name: "avg_vessel_age_years"
      expr: AVG(YEAR(CURRENT_DATE()) - CAST(year_built AS INT))
      comment: "Average vessel age in years for fleet modernization strategy"
    - name: "avg_teu_per_vessel"
      expr: AVG(CAST(teu_capacity AS DOUBLE))
      comment: "Average TEU capacity per vessel for fleet efficiency benchmarking"
    - name: "avg_dwt_per_vessel"
      expr: AVG(CAST(summer_dwt AS DOUBLE))
      comment: "Average deadweight tonnage per vessel for operational efficiency analysis"
    - name: "compliance_rate_isps"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN isps_compliant = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fleet compliant with ISPS security standards - critical for port access"
    - name: "compliance_rate_marpol"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN marpol_compliant = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fleet compliant with MARPOL environmental standards - regulatory risk indicator"
    - name: "compliance_rate_solas"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN solas_compliant = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fleet compliant with SOLAS safety standards - operational risk metric"
    - name: "full_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN isps_compliant = TRUE AND marpol_compliant = TRUE AND solas_compliant = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fleet fully compliant across all three major regulations - executive KPI for regulatory risk"
    - name: "avg_psc_deficiencies"
      expr: AVG(CAST(psc_deficiency_count AS DOUBLE))
      comment: "Average Port State Control deficiency count per vessel - quality and safety performance indicator"
    - name: "total_propulsion_power_mw"
      expr: SUM(CAST(propulsion_power_kw AS DOUBLE)) / 1000.0
      comment: "Total propulsion power in megawatts for fuel cost modeling and environmental impact assessment"
    - name: "avg_beam_meters"
      expr: AVG(CAST(beam_meters AS DOUBLE))
      comment: "Average vessel beam for berth compatibility and infrastructure planning"
    - name: "avg_loa_meters"
      expr: AVG(CAST(loa_meters AS DOUBLE))
      comment: "Average length overall for berth allocation and port infrastructure requirements"
    - name: "avg_draft_meters"
      expr: AVG(CAST(maximum_draft_meters AS DOUBLE))
      comment: "Average maximum draft for channel depth and dredging investment decisions"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_shipping_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipping line partner performance and operational readiness metrics for commercial and operational decision-making"
  source: "`vibe_shipping_ports_v1`.`masterdata`.`shipping_line`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the shipping line"
    - name: "alliance_membership"
      expr: alliance_membership
      comment: "Alliance membership for strategic partnership analysis"
    - name: "service_type"
      expr: service_type
      comment: "Type of service offered (e.g., liner, tramp, feeder)"
    - name: "fleet_size_category"
      expr: fleet_size_category
      comment: "Fleet size category for partner capacity segmentation"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating for financial risk assessment"
    - name: "compliance_status"
      expr: CASE WHEN isps_compliant_flag = TRUE AND dangerous_goods_approved_flag = TRUE THEN 'Fully Compliant' WHEN isps_compliant_flag = FALSE OR dangerous_goods_approved_flag = FALSE THEN 'Non-Compliant' ELSE 'Unknown' END
      comment: "Consolidated compliance status for operational risk management"
    - name: "digital_readiness"
      expr: CASE WHEN api_integration_enabled_flag = TRUE AND edi_enabled_flag = TRUE THEN 'Fully Digital' WHEN api_integration_enabled_flag = TRUE OR edi_enabled_flag = TRUE THEN 'Partially Digital' ELSE 'Manual' END
      comment: "Digital integration readiness for operational efficiency and automation"
    - name: "capability_profile"
      expr: CASE WHEN reefer_capable_flag = TRUE AND dangerous_goods_approved_flag = TRUE THEN 'Full Service' WHEN reefer_capable_flag = TRUE THEN 'Reefer Only' WHEN dangerous_goods_approved_flag = TRUE THEN 'DG Only' ELSE 'Standard' END
      comment: "Service capability profile for cargo type allocation"
  measures:
    - name: "total_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Total number of active shipping line partners for network diversity assessment"
    - name: "total_fleet_capacity_teu"
      expr: SUM(CAST(total_fleet_teu_capacity AS DOUBLE))
      comment: "Total fleet TEU capacity across all shipping line partners for port capacity planning"
    - name: "total_vessel_count"
      expr: SUM(CAST(vessel_count AS DOUBLE))
      comment: "Total vessel count across all shipping lines for berth demand forecasting"
    - name: "avg_vessel_calls_per_month"
      expr: AVG(CAST(average_vessel_calls_per_month AS DOUBLE))
      comment: "Average vessel calls per month per shipping line for operational planning"
    - name: "avg_teu_per_call"
      expr: AVG(CAST(average_teu_per_call AS DOUBLE))
      comment: "Average TEU per vessel call for crane and yard resource allocation"
    - name: "total_monthly_vessel_calls"
      expr: SUM(CAST(average_vessel_calls_per_month AS DOUBLE))
      comment: "Total monthly vessel calls across all shipping lines for port throughput capacity planning"
    - name: "isps_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN isps_compliant_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping lines ISPS compliant - security risk indicator"
    - name: "dangerous_goods_approval_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN dangerous_goods_approved_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping lines approved for dangerous goods - hazmat capacity indicator"
    - name: "reefer_capability_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN reefer_capable_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping lines with reefer capability - cold chain capacity metric"
    - name: "api_integration_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN api_integration_enabled_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping lines with API integration - digital transformation KPI"
    - name: "edi_integration_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN edi_enabled_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping lines with EDI integration - operational efficiency indicator"
    - name: "full_digital_integration_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN api_integration_enabled_flag = TRUE AND edi_enabled_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping lines with both API and EDI integration - automation readiness KPI"
    - name: "iso_certification_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN iso_certification_status = 'Certified' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping lines with ISO certification - quality assurance metric"
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days for cash flow and working capital planning"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_port_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port infrastructure capacity and operational capability metrics for strategic investment and operational planning"
  source: "`vibe_shipping_ports_v1`.`masterdata`.`port_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of port location (berth, anchorage, terminal, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the port location"
    - name: "location_zone"
      expr: location_zone
      comment: "Port zone for spatial analysis and resource allocation"
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level for risk management and access control"
    - name: "environmental_zone"
      expr: environmental_zone
      comment: "Environmental zone classification for regulatory compliance"
    - name: "crane_type"
      expr: crane_type
      comment: "Type of crane equipment for cargo handling capability analysis"
    - name: "gate_lane_type"
      expr: gate_lane_type
      comment: "Gate lane type for truck throughput capacity planning"
    - name: "capacity_tier"
      expr: CASE WHEN CAST(container_yard_capacity_teu AS INT) >= 50000 THEN 'Mega Terminal (50k+ TEU)' WHEN CAST(container_yard_capacity_teu AS INT) >= 20000 THEN 'Large Terminal (20k-50k TEU)' WHEN CAST(container_yard_capacity_teu AS INT) >= 5000 THEN 'Medium Terminal (5k-20k TEU)' WHEN CAST(container_yard_capacity_teu AS INT) > 0 THEN 'Small Terminal (<5k TEU)' ELSE 'Non-Container' END
      comment: "Container yard capacity tier for infrastructure investment prioritization"
    - name: "vessel_size_capability"
      expr: CASE WHEN maximum_vessel_loa_meters >= 400 THEN 'Ultra Large Vessel Capable' WHEN maximum_vessel_loa_meters >= 300 THEN 'Large Vessel Capable' WHEN maximum_vessel_loa_meters >= 200 THEN 'Medium Vessel Capable' ELSE 'Small Vessel Only' END
      comment: "Vessel size capability for berth allocation and dredging investment"
  measures:
    - name: "total_port_locations"
      expr: COUNT(DISTINCT port_location_id)
      comment: "Total number of port locations for infrastructure asset inventory"
    - name: "total_yard_capacity_teu"
      expr: SUM(CAST(container_yard_capacity_teu AS DOUBLE))
      comment: "Total container yard capacity in TEU for port throughput capacity planning"
    - name: "total_rail_capacity_teu"
      expr: SUM(CAST(rail_siding_capacity_teu AS DOUBLE))
      comment: "Total rail siding capacity in TEU for intermodal connectivity assessment"
    - name: "avg_water_depth_meters"
      expr: AVG(CAST(water_depth_meters AS DOUBLE))
      comment: "Average water depth for vessel draft capability and dredging requirements"
    - name: "avg_max_vessel_loa_meters"
      expr: AVG(CAST(maximum_vessel_loa_meters AS DOUBLE))
      comment: "Average maximum vessel length overall for berth design standards"
    - name: "avg_max_vessel_beam_meters"
      expr: AVG(CAST(maximum_vessel_beam_meters AS DOUBLE))
      comment: "Average maximum vessel beam for berth width requirements"
    - name: "avg_max_vessel_dwt_tonnes"
      expr: AVG(CAST(maximum_vessel_dwt_tonnes AS DOUBLE))
      comment: "Average maximum vessel deadweight tonnage for cargo handling capacity"
    - name: "avg_bollard_swl_tonnes"
      expr: AVG(CAST(bollard_swl_tonnes AS DOUBLE))
      comment: "Average bollard safe working load for mooring infrastructure adequacy"
    - name: "avg_fender_energy_kj"
      expr: AVG(CAST(fender_energy_absorption_kj AS DOUBLE))
      comment: "Average fender energy absorption capacity for berthing safety assessment"
    - name: "rfid_enabled_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN rfid_enabled = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations with RFID enabled - automation and tracking capability"
    - name: "shore_crane_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN shore_crane_coverage = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations with shore crane coverage - cargo handling capacity indicator"
    - name: "avg_yard_block_tiers"
      expr: AVG(CAST(yard_block_tiers AS DOUBLE))
      comment: "Average yard block stacking tiers for vertical capacity utilization"
    - name: "avg_yard_block_rows"
      expr: AVG(CAST(yard_block_rows AS DOUBLE))
      comment: "Average yard block rows for horizontal capacity layout"
    - name: "avg_yard_block_bays"
      expr: AVG(CAST(yard_block_bays AS DOUBLE))
      comment: "Average yard block bays for container storage density"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_commodity_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity regulatory compliance and handling complexity metrics for risk management and operational planning"
  source: "`vibe_shipping_ports_v1`.`masterdata`.`commodity_code`"
  dimensions:
    - name: "commodity_code_status"
      expr: commodity_code_status
      comment: "Status of the commodity code (active, deprecated, pending)"
    - name: "hs_chapter"
      expr: hs_chapter
      comment: "Harmonized System chapter for trade classification"
    - name: "packing_group"
      expr: packing_group
      comment: "Packing group for dangerous goods classification"
    - name: "segregation_group"
      expr: segregation_group
      comment: "Segregation group for cargo stowage planning"
    - name: "storage_area_type"
      expr: storage_area_type
      comment: "Required storage area type for yard planning"
    - name: "handling_method"
      expr: handling_method
      comment: "Required handling method for operational procedures"
    - name: "marpol_category"
      expr: marpol_category
      comment: "MARPOL category for environmental compliance"
    - name: "regulatory_complexity"
      expr: CASE WHEN export_license_required = TRUE AND import_license_required = TRUE THEN 'High Regulatory' WHEN export_license_required = TRUE OR import_license_required = TRUE THEN 'Medium Regulatory' ELSE 'Standard' END
      comment: "Regulatory complexity tier for customs and compliance planning"
    - name: "handling_complexity"
      expr: CASE WHEN temperature_controlled = TRUE AND fumigation_required = TRUE AND quarantine_required = TRUE THEN 'High Complexity' WHEN temperature_controlled = TRUE OR fumigation_required = TRUE OR quarantine_required = TRUE THEN 'Medium Complexity' ELSE 'Standard' END
      comment: "Handling complexity tier for operational resource allocation"
    - name: "hazmat_profile"
      expr: CASE WHEN marine_pollutant = TRUE AND excepted_quantity = FALSE THEN 'High Hazard' WHEN marine_pollutant = TRUE OR excepted_quantity = FALSE THEN 'Medium Hazard' ELSE 'Low Hazard' END
      comment: "Hazardous material risk profile for safety and environmental management"
  measures:
    - name: "total_commodity_codes"
      expr: COUNT(DISTINCT commodity_code_id)
      comment: "Total number of commodity codes for cargo type diversity assessment"
    - name: "prohibited_goods_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN prohibited_goods_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commodities flagged as prohibited - regulatory risk indicator"
    - name: "export_license_required_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN export_license_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commodities requiring export license - trade compliance complexity"
    - name: "import_license_required_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN import_license_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commodities requiring import license - customs clearance complexity"
    - name: "temperature_controlled_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN temperature_controlled = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commodities requiring temperature control - reefer infrastructure demand"
    - name: "fumigation_required_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN fumigation_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commodities requiring fumigation - biosecurity service demand"
    - name: "quarantine_required_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN quarantine_required = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commodities requiring quarantine - inspection facility capacity planning"
    - name: "marine_pollutant_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN marine_pollutant = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commodities classified as marine pollutants - environmental risk metric"
    - name: "avg_tariff_rate_percent"
      expr: AVG(CAST(tariff_rate_percent AS DOUBLE))
      comment: "Average tariff rate for trade cost modeling and competitiveness analysis"
    - name: "avg_flash_point_celsius"
      expr: AVG(CAST(flash_point_celsius AS DOUBLE))
      comment: "Average flash point for fire safety risk assessment"
    - name: "avg_temp_range_min_celsius"
      expr: AVG(CAST(temperature_range_min_celsius AS DOUBLE))
      comment: "Average minimum temperature requirement for reefer capacity planning"
    - name: "avg_temp_range_max_celsius"
      expr: AVG(CAST(temperature_range_max_celsius AS DOUBLE))
      comment: "Average maximum temperature requirement for reefer capacity planning"
    - name: "wco_control_flag_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN wco_control_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commodities under WCO control - customs inspection intensity indicator"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_container_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container equipment capability and operational suitability metrics for fleet planning and cargo matching"
  source: "`vibe_shipping_ports_v1`.`masterdata`.`container_type`"
  dimensions:
    - name: "container_category"
      expr: container_category
      comment: "Container category for equipment type segmentation"
    - name: "iso_type_code"
      expr: iso_type_code
      comment: "ISO type code for standardized equipment classification"
    - name: "size_code"
      expr: size_code
      comment: "Size code (20ft, 40ft, 45ft) for capacity planning"
    - name: "height_category"
      expr: height_category
      comment: "Height category (standard, high-cube) for stacking and clearance planning"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the container type"
    - name: "handling_equipment_type"
      expr: handling_equipment_type
      comment: "Required handling equipment type for operational resource matching"
    - name: "ventilation_setting"
      expr: ventilation_setting
      comment: "Ventilation setting for cargo compatibility"
    - name: "special_capability_profile"
      expr: CASE WHEN is_reefer = TRUE AND is_hazmat_approved = TRUE AND is_oog_capable = TRUE THEN 'Full Special Capability' WHEN is_reefer = TRUE AND is_hazmat_approved = TRUE THEN 'Reefer + Hazmat' WHEN is_reefer = TRUE AND is_oog_capable = TRUE THEN 'Reefer + OOG' WHEN is_hazmat_approved = TRUE AND is_oog_capable = TRUE THEN 'Hazmat + OOG' WHEN is_reefer = TRUE THEN 'Reefer Only' WHEN is_hazmat_approved = TRUE THEN 'Hazmat Only' WHEN is_oog_capable = TRUE THEN 'OOG Only' ELSE 'Standard' END
      comment: "Special capability profile for cargo type matching and fleet composition"
  measures:
    - name: "total_container_types"
      expr: COUNT(DISTINCT container_type_id)
      comment: "Total number of container types for equipment diversity assessment"
    - name: "avg_teu_equivalent"
      expr: AVG(CAST(teu_equivalent AS DOUBLE))
      comment: "Average TEU equivalent for capacity normalization"
    - name: "avg_max_payload_kg"
      expr: AVG(CAST(max_payload_kg AS DOUBLE))
      comment: "Average maximum payload capacity for cargo weight planning"
    - name: "avg_tare_weight_kg"
      expr: AVG(CAST(tare_weight_kg AS DOUBLE))
      comment: "Average tare weight for vessel weight distribution calculations"
    - name: "avg_internal_capacity_cbm"
      expr: AVG(CAST(internal_capacity_cbm AS DOUBLE))
      comment: "Average internal capacity in cubic meters for volumetric cargo planning"
    - name: "reefer_capable_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_reefer = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of container types with reefer capability - cold chain capacity indicator"
    - name: "hazmat_approved_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_hazmat_approved = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of container types approved for hazmat - dangerous goods capacity"
    - name: "oog_capable_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_oog_capable = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of container types capable of out-of-gauge cargo - oversized cargo capacity"
    - name: "collapsible_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_collapsible = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of container types that are collapsible - repositioning efficiency indicator"
    - name: "avg_reefer_temp_min_celsius"
      expr: AVG(CAST(reefer_temp_min_celsius AS DOUBLE))
      comment: "Average minimum reefer temperature for cold chain capability assessment"
    - name: "avg_reefer_temp_max_celsius"
      expr: AVG(CAST(reefer_temp_max_celsius AS DOUBLE))
      comment: "Average maximum reefer temperature for cold chain capability assessment"
    - name: "avg_swl_kg"
      expr: AVG(CAST(swl_kg AS DOUBLE))
      comment: "Average safe working load for lifting equipment specification"
    - name: "avg_max_gross_weight_kg"
      expr: AVG(CAST(max_gross_weight_kg AS DOUBLE))
      comment: "Average maximum gross weight for handling equipment capacity requirements"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`masterdata_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country regulatory compliance and maritime governance metrics for trade risk assessment and route planning"
  source: "`vibe_shipping_ports_v1`.`masterdata`.`country`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Geographic region for trade route and market analysis"
    - name: "sub_region"
      expr: sub_region
      comment: "Geographic sub-region for detailed market segmentation"
    - name: "record_status"
      expr: record_status
      comment: "Record status for data quality management"
    - name: "imo_member_status"
      expr: imo_member_status
      comment: "IMO membership status for maritime regulatory alignment"
    - name: "fatf_status"
      expr: fatf_status
      comment: "FATF status for financial crime risk assessment"
    - name: "flag_state_performance_list"
      expr: flag_state_performance_list
      comment: "Flag state performance list classification for vessel quality assessment"
    - name: "maritime_compliance_profile"
      expr: CASE WHEN marpol_ratified = TRUE AND solas_ratified = TRUE AND mlc_ratified = TRUE THEN 'Fully Compliant' WHEN marpol_ratified = TRUE AND solas_ratified = TRUE THEN 'Safety + Environment' WHEN marpol_ratified = TRUE OR solas_ratified = TRUE THEN 'Partial Compliance' ELSE 'Non-Compliant' END
      comment: "Maritime convention compliance profile for regulatory risk assessment"
    - name: "psc_mou_membership"
      expr: CASE WHEN paris_mou_member = TRUE AND tokyo_mou_member = TRUE AND indian_ocean_mou_member = TRUE THEN 'Multi-MOU Member' WHEN paris_mou_member = TRUE OR tokyo_mou_member = TRUE OR indian_ocean_mou_member = TRUE THEN 'Single MOU Member' ELSE 'Non-Member' END
      comment: "Port State Control MOU membership for inspection regime classification"
    - name: "sanctions_risk"
      expr: CASE WHEN sanctions_list_flag = TRUE THEN 'Sanctioned' ELSE 'Clear' END
      comment: "Sanctions risk flag for trade compliance screening"
  measures:
    - name: "total_countries"
      expr: COUNT(DISTINCT country_id)
      comment: "Total number of countries for trade network coverage assessment"
    - name: "marpol_ratification_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN marpol_ratified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries with MARPOL ratification - environmental compliance coverage"
    - name: "solas_ratification_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN solas_ratified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries with SOLAS ratification - safety compliance coverage"
    - name: "mlc_ratification_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN mlc_ratified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries with MLC ratification - labor standards compliance coverage"
    - name: "isps_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN isps_code_compliant = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries ISPS compliant - port security risk indicator"
    - name: "flag_state_indicator_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN flag_state_indicator = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries operating as flag states - vessel registration market size"
    - name: "sanctions_list_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN sanctions_list_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries on sanctions lists - trade compliance risk exposure"
    - name: "wco_member_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN wco_member = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries that are WCO members - customs harmonization coverage"
    - name: "paris_mou_member_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN paris_mou_member = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries in Paris MOU - European PSC regime coverage"
    - name: "tokyo_mou_member_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN tokyo_mou_member = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries in Tokyo MOU - Asia-Pacific PSC regime coverage"
    - name: "indian_ocean_mou_member_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN indian_ocean_mou_member = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries in Indian Ocean MOU - Indian Ocean PSC regime coverage"
    - name: "avg_psc_targeting_factor"
      expr: AVG(CAST(psc_targeting_factor AS DOUBLE))
      comment: "Average PSC targeting factor for inspection risk assessment"
    - name: "full_maritime_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN marpol_ratified = TRUE AND solas_ratified = TRUE AND mlc_ratified = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of countries with full maritime convention compliance - comprehensive regulatory quality indicator"
$$;