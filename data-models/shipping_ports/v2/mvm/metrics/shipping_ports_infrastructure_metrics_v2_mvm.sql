-- Metric views for domain: infrastructure | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:23:26

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_anchorage_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anchorage Area business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`anchorage_area`"
  dimensions:
    - name: "Ais Monitoring Required Flag"
      expr: ais_monitoring_required_flag
    - name: "Anchorage Category"
      expr: anchorage_category
    - name: "Anchorage Code"
      expr: anchorage_code
    - name: "Anchorage Name"
      expr: anchorage_name
    - name: "Chart Reference"
      expr: chart_reference
    - name: "Communication Channel Vhf"
      expr: communication_channel_vhf
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Designated Use Restrictions"
      expr: designated_use_restrictions
    - name: "Designation Authority"
      expr: designation_authority
    - name: "Designation Date"
      expr: designation_date
    - name: "Dredging Maintenance Frequency"
      expr: dredging_maintenance_frequency
    - name: "Emergency Anchorage Flag"
      expr: emergency_anchorage_flag
    - name: "Environmental Sensitivity Flag"
      expr: environmental_sensitivity_flag
    - name: "Geographic Boundary Polygon"
      expr: geographic_boundary_polygon
    - name: "Holding Ground Type"
      expr: holding_ground_type
    - name: "Isps Security Zone"
      expr: isps_security_zone
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Anchorage Area"
      expr: COUNT(DISTINCT anchorage_area_id)
    - name: "Total Area Size Square Meters"
      expr: SUM(area_size_square_meters)
    - name: "Average Area Size Square Meters"
      expr: AVG(area_size_square_meters)
    - name: "Total Current Speed Max Knots"
      expr: SUM(current_speed_max_knots)
    - name: "Average Current Speed Max Knots"
      expr: AVG(current_speed_max_knots)
    - name: "Total Distance To Berth Nm"
      expr: SUM(distance_to_berth_nm)
    - name: "Average Distance To Berth Nm"
      expr: AVG(distance_to_berth_nm)
    - name: "Total Distance To Pilot Boarding Nm"
      expr: SUM(distance_to_pilot_boarding_nm)
    - name: "Average Distance To Pilot Boarding Nm"
      expr: AVG(distance_to_pilot_boarding_nm)
    - name: "Total Latitude Center Decimal"
      expr: SUM(latitude_center_decimal)
    - name: "Average Latitude Center Decimal"
      expr: AVG(latitude_center_decimal)
    - name: "Total Longitude Center Decimal"
      expr: SUM(longitude_center_decimal)
    - name: "Average Longitude Center Decimal"
      expr: AVG(longitude_center_decimal)
    - name: "Total Maximum Vessel Beam Meters"
      expr: SUM(maximum_vessel_beam_meters)
    - name: "Average Maximum Vessel Beam Meters"
      expr: AVG(maximum_vessel_beam_meters)
    - name: "Total Maximum Vessel Dwt"
      expr: SUM(maximum_vessel_dwt)
    - name: "Average Maximum Vessel Dwt"
      expr: AVG(maximum_vessel_dwt)
    - name: "Total Maximum Vessel Loa Meters"
      expr: SUM(maximum_vessel_loa_meters)
    - name: "Average Maximum Vessel Loa Meters"
      expr: AVG(maximum_vessel_loa_meters)
    - name: "Total Swinging Circle Radius Meters"
      expr: SUM(swinging_circle_radius_meters)
    - name: "Average Swinging Circle Radius Meters"
      expr: AVG(swinging_circle_radius_meters)
    - name: "Total Tidal Range Meters"
      expr: SUM(tidal_range_meters)
    - name: "Average Tidal Range Meters"
      expr: AVG(tidal_range_meters)
    - name: "Total Water Depth Maximum Meters"
      expr: SUM(water_depth_maximum_meters)
    - name: "Average Water Depth Maximum Meters"
      expr: AVG(water_depth_maximum_meters)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_berth`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`berth`"
  dimensions:
    - name: "Annual Throughput Capacity Teu"
      expr: annual_throughput_capacity_teu
    - name: "Aveva Reference Code"
      expr: aveva_reference_code
    - name: "Berth Number"
      expr: berth_number
    - name: "Berth Type"
      expr: berth_type
    - name: "Bollard Count"
      expr: bollard_count
    - name: "Cfs Proximity Flag"
      expr: cfs_proximity_flag
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Fender Condition"
      expr: fender_condition
    - name: "Fender System Type"
      expr: fender_system_type
    - name: "Isps Compliant Flag"
      expr: isps_compliant_flag
    - name: "Last Dredging Date"
      expr: last_dredging_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Mooring Fitting Types"
      expr: mooring_fitting_types
    - name: "Name"
      expr: berth_name
    - name: "Next Maintenance Date"
      expr: next_maintenance_date
    - name: "Operational Status"
      expr: operational_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Berth"
      expr: COUNT(DISTINCT berth_id)
    - name: "Total Bollard Swl Tonnes"
      expr: SUM(bollard_swl_tonnes)
    - name: "Average Bollard Swl Tonnes"
      expr: AVG(bollard_swl_tonnes)
    - name: "Total Fender Energy Absorption Kj"
      expr: SUM(fender_energy_absorption_kj)
    - name: "Average Fender Energy Absorption Kj"
      expr: AVG(fender_energy_absorption_kj)
    - name: "Total Fender Reaction Force Kn"
      expr: SUM(fender_reaction_force_kn)
    - name: "Average Fender Reaction Force Kn"
      expr: AVG(fender_reaction_force_kn)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Length M"
      expr: SUM(length_m)
    - name: "Average Length M"
      expr: AVG(length_m)
    - name: "Total Loa Capacity M"
      expr: SUM(loa_capacity_m)
    - name: "Average Loa Capacity M"
      expr: AVG(loa_capacity_m)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Max Draft M"
      expr: SUM(max_draft_m)
    - name: "Average Max Draft M"
      expr: AVG(max_draft_m)
    - name: "Total Max Dwt Tonnes"
      expr: SUM(max_dwt_tonnes)
    - name: "Average Max Dwt Tonnes"
      expr: AVG(max_dwt_tonnes)
    - name: "Total Shore Power Capacity Kw"
      expr: SUM(shore_power_capacity_kw)
    - name: "Average Shore Power Capacity Kw"
      expr: AVG(shore_power_capacity_kw)
    - name: "Total Tidal Range M"
      expr: SUM(tidal_range_m)
    - name: "Average Tidal Range M"
      expr: AVG(tidal_range_m)
    - name: "Total Water Depth Alongside M"
      expr: SUM(water_depth_alongside_m)
    - name: "Average Water Depth Alongside M"
      expr: AVG(water_depth_alongside_m)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`channel`"
  dimensions:
    - name: "Channel Type"
      expr: channel_type
    - name: "Chart Reference"
      expr: chart_reference
    - name: "Code"
      expr: channel_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dredging Authority"
      expr: dredging_authority
    - name: "Environmental Sensitivity Flag"
      expr: environmental_sensitivity_flag
    - name: "Last Dredging Date"
      expr: last_dredging_date
    - name: "Last Survey Date"
      expr: last_survey_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Name"
      expr: channel_name
    - name: "Navigational Aids Description"
      expr: navigational_aids_description
    - name: "Next Scheduled Survey Date"
      expr: next_scheduled_survey_date
    - name: "Operational Status"
      expr: operational_status
    - name: "Pilotage Required Flag"
      expr: pilotage_required_flag
    - name: "Remarks"
      expr: remarks
    - name: "Survey Frequency Months"
      expr: survey_frequency_months
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel"
      expr: COUNT(DISTINCT channel_id)
    - name: "Total Bearing Degrees"
      expr: SUM(bearing_degrees)
    - name: "Average Bearing Degrees"
      expr: AVG(bearing_degrees)
    - name: "Total Current Maintained Depth Cd M"
      expr: SUM(current_maintained_depth_cd_m)
    - name: "Average Current Maintained Depth Cd M"
      expr: AVG(current_maintained_depth_cd_m)
    - name: "Total Design Depth Cd M"
      expr: SUM(design_depth_cd_m)
    - name: "Average Design Depth Cd M"
      expr: AVG(design_depth_cd_m)
    - name: "Total Design Width M"
      expr: SUM(design_width_m)
    - name: "Average Design Width M"
      expr: AVG(design_width_m)
    - name: "Total Max Permissible Beam M"
      expr: SUM(max_permissible_beam_m)
    - name: "Average Max Permissible Beam M"
      expr: AVG(max_permissible_beam_m)
    - name: "Total Max Permissible Draft M"
      expr: SUM(max_permissible_draft_m)
    - name: "Average Max Permissible Draft M"
      expr: AVG(max_permissible_draft_m)
    - name: "Total Max Permissible Dwt"
      expr: SUM(max_permissible_dwt)
    - name: "Average Max Permissible Dwt"
      expr: AVG(max_permissible_dwt)
    - name: "Total Max Permissible Loa M"
      expr: SUM(max_permissible_loa_m)
    - name: "Average Max Permissible Loa M"
      expr: AVG(max_permissible_loa_m)
    - name: "Total Minimum Depth Cd M"
      expr: SUM(minimum_depth_cd_m)
    - name: "Average Minimum Depth Cd M"
      expr: AVG(minimum_depth_cd_m)
    - name: "Total Sedimentation Rate M Per Year"
      expr: SUM(sedimentation_rate_m_per_year)
    - name: "Average Sedimentation Rate M Per Year"
      expr: AVG(sedimentation_rate_m_per_year)
    - name: "Total Total Length Nm"
      expr: SUM(total_length_nm)
    - name: "Average Total Length Nm"
      expr: AVG(total_length_nm)
    - name: "Total Under Keel Clearance M"
      expr: SUM(under_keel_clearance_m)
    - name: "Average Under Keel Clearance M"
      expr: AVG(under_keel_clearance_m)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`facility`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Aveva Asset Reference"
      expr: aveva_asset_reference
    - name: "City"
      expr: city
    - name: "Code"
      expr: facility_code
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dangerous Goods Certified"
      expr: dangerous_goods_certified
    - name: "Environmental Certification"
      expr: environmental_certification
    - name: "Facility Status"
      expr: facility_status
    - name: "Facility Type"
      expr: facility_type
    - name: "Fender System Type"
      expr: fender_system_type
    - name: "Isps Compliant"
      expr: isps_compliant
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Facility"
      expr: COUNT(DISTINCT facility_id)
    - name: "Total Annual Throughput Tonnes"
      expr: SUM(annual_throughput_tonnes)
    - name: "Average Annual Throughput Tonnes"
      expr: AVG(annual_throughput_tonnes)
    - name: "Total Berth Length M"
      expr: SUM(berth_length_m)
    - name: "Average Berth Length M"
      expr: AVG(berth_length_m)
    - name: "Total Bollard Pull Capacity Tonnes"
      expr: SUM(bollard_pull_capacity_tonnes)
    - name: "Average Bollard Pull Capacity Tonnes"
      expr: AVG(bollard_pull_capacity_tonnes)
    - name: "Total Capacity Teu"
      expr: SUM(capacity_teu)
    - name: "Average Capacity Teu"
      expr: AVG(capacity_teu)
    - name: "Total Construction Cost Usd"
      expr: SUM(construction_cost_usd)
    - name: "Average Construction Cost Usd"
      expr: AVG(construction_cost_usd)
    - name: "Total Crane Capacity Tonnes"
      expr: SUM(crane_capacity_tonnes)
    - name: "Average Crane Capacity Tonnes"
      expr: AVG(crane_capacity_tonnes)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Max Vessel Beam M"
      expr: SUM(max_vessel_beam_m)
    - name: "Average Max Vessel Beam M"
      expr: AVG(max_vessel_beam_m)
    - name: "Total Max Vessel Draft M"
      expr: SUM(max_vessel_draft_m)
    - name: "Average Max Vessel Draft M"
      expr: AVG(max_vessel_draft_m)
    - name: "Total Max Vessel Loa M"
      expr: SUM(max_vessel_loa_m)
    - name: "Average Max Vessel Loa M"
      expr: AVG(max_vessel_loa_m)
    - name: "Total Storage Area Sqm"
      expr: SUM(storage_area_sqm)
    - name: "Average Storage Area Sqm"
      expr: AVG(storage_area_sqm)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_port`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`port`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Bunkering Available"
      expr: bunkering_available
    - name: "City"
      expr: city
    - name: "Code"
      expr: port_code
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Facility"
      expr: customs_facility
    - name: "Environmental Certification"
      expr: environmental_certification
    - name: "Established Date"
      expr: established_date
    - name: "Free Trade Zone"
      expr: free_trade_zone
    - name: "Hazmat Certified"
      expr: hazmat_certified
    - name: "Iso Certified"
      expr: iso_certified
    - name: "Isps Compliant"
      expr: isps_compliant
    - name: "Last Dredging Date"
      expr: last_dredging_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Port"
      expr: COUNT(DISTINCT port_id)
    - name: "Total Annual Cargo Tonnage"
      expr: SUM(annual_cargo_tonnage)
    - name: "Average Annual Cargo Tonnage"
      expr: AVG(annual_cargo_tonnage)
    - name: "Total Annual Throughput Teu"
      expr: SUM(annual_throughput_teu)
    - name: "Average Annual Throughput Teu"
      expr: AVG(annual_throughput_teu)
    - name: "Total Channel Depth M"
      expr: SUM(channel_depth_m)
    - name: "Average Channel Depth M"
      expr: AVG(channel_depth_m)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Max Vessel Beam M"
      expr: SUM(max_vessel_beam_m)
    - name: "Average Max Vessel Beam M"
      expr: AVG(max_vessel_beam_m)
    - name: "Total Max Vessel Draft M"
      expr: SUM(max_vessel_draft_m)
    - name: "Average Max Vessel Draft M"
      expr: AVG(max_vessel_draft_m)
    - name: "Total Max Vessel Length M"
      expr: SUM(max_vessel_length_m)
    - name: "Average Max Vessel Length M"
      expr: AVG(max_vessel_length_m)
    - name: "Total Storage Capacity Sqm"
      expr: SUM(storage_capacity_sqm)
    - name: "Average Storage Capacity Sqm"
      expr: AVG(storage_capacity_sqm)
    - name: "Total Total Area Sqm"
      expr: SUM(total_area_sqm)
    - name: "Average Total Area Sqm"
      expr: AVG(total_area_sqm)
    - name: "Total Total Quay Length M"
      expr: SUM(total_quay_length_m)
    - name: "Average Total Quay Length M"
      expr: AVG(total_quay_length_m)
    - name: "Total Water Area Sqm"
      expr: SUM(water_area_sqm)
    - name: "Average Water Area Sqm"
      expr: AVG(water_area_sqm)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_port_gate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port Gate business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`port_gate`"
  dimensions:
    - name: "Access Control System Reference"
      expr: access_control_system_reference
    - name: "Appointment Required Flag"
      expr: appointment_required_flag
    - name: "Cctv Coverage Flag"
      expr: cctv_coverage_flag
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Inspection Point Flag"
      expr: customs_inspection_point_flag
    - name: "Daily Throughput Capacity"
      expr: daily_throughput_capacity
    - name: "Description"
      expr: port_gate_description
    - name: "Emergency Access Flag"
      expr: emergency_access_flag
    - name: "Gate Code"
      expr: gate_code
    - name: "Gate Direction"
      expr: gate_direction
    - name: "Gate Name"
      expr: gate_name
    - name: "Gate Type"
      expr: gate_type
    - name: "Hazmat Clearance Required Flag"
      expr: hazmat_clearance_required_flag
    - name: "Inbound Lanes"
      expr: inbound_lanes
    - name: "Isps Security Zone"
      expr: isps_security_zone
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Port Gate"
      expr: COUNT(DISTINCT port_gate_id)
    - name: "Total Average Processing Time Minutes"
      expr: SUM(average_processing_time_minutes)
    - name: "Average Average Processing Time Minutes"
      expr: AVG(average_processing_time_minutes)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Maximum Vehicle Height Meters"
      expr: SUM(maximum_vehicle_height_meters)
    - name: "Average Maximum Vehicle Height Meters"
      expr: AVG(maximum_vehicle_height_meters)
    - name: "Total Maximum Vehicle Length Meters"
      expr: SUM(maximum_vehicle_length_meters)
    - name: "Average Maximum Vehicle Length Meters"
      expr: AVG(maximum_vehicle_length_meters)
    - name: "Total Maximum Vehicle Width Meters"
      expr: SUM(maximum_vehicle_width_meters)
    - name: "Average Maximum Vehicle Width Meters"
      expr: AVG(maximum_vehicle_width_meters)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_quay_wall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quay Wall business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`quay_wall`"
  dimensions:
    - name: "Asset Owner"
      expr: asset_owner
    - name: "Construction Material"
      expr: construction_material
    - name: "Crane Rail Gauge Mm"
      expr: crane_rail_gauge_mm
    - name: "Crane Rail Present"
      expr: crane_rail_present
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Standard"
      expr: design_standard
    - name: "Environmental Monitoring"
      expr: environmental_monitoring
    - name: "Fender System Type"
      expr: fender_system_type
    - name: "Geographic Coordinates"
      expr: geographic_coordinates
    - name: "Imdg Compliant"
      expr: imdg_compliant
    - name: "Insurance Policy Number"
      expr: insurance_policy_number
    - name: "Isps Compliant"
      expr: isps_compliant
    - name: "Last Dredging Date"
      expr: last_dredging_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lighting System Type"
      expr: lighting_system_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quay Wall"
      expr: COUNT(DISTINCT quay_wall_id)
    - name: "Total Bollard Spacing M"
      expr: SUM(bollard_spacing_m)
    - name: "Average Bollard Spacing M"
      expr: AVG(bollard_spacing_m)
    - name: "Total Bollard Swl Tonnes"
      expr: SUM(bollard_swl_tonnes)
    - name: "Average Bollard Swl Tonnes"
      expr: AVG(bollard_swl_tonnes)
    - name: "Total Current Depth M"
      expr: SUM(current_depth_m)
    - name: "Average Current Depth M"
      expr: AVG(current_depth_m)
    - name: "Total Design Depth M"
      expr: SUM(design_depth_m)
    - name: "Average Design Depth M"
      expr: AVG(design_depth_m)
    - name: "Total Design Load Capacity Kn Per M2"
      expr: SUM(design_load_capacity_kn_per_m2)
    - name: "Average Design Load Capacity Kn Per M2"
      expr: AVG(design_load_capacity_kn_per_m2)
    - name: "Total Max Vessel Dwt Tonnes"
      expr: SUM(max_vessel_dwt_tonnes)
    - name: "Average Max Vessel Dwt Tonnes"
      expr: AVG(max_vessel_dwt_tonnes)
    - name: "Total Max Vessel Loa M"
      expr: SUM(max_vessel_loa_m)
    - name: "Average Max Vessel Loa M"
      expr: AVG(max_vessel_loa_m)
    - name: "Total Replacement Value Usd"
      expr: SUM(replacement_value_usd)
    - name: "Average Replacement Value Usd"
      expr: AVG(replacement_value_usd)
    - name: "Total Tidal Range M"
      expr: SUM(tidal_range_m)
    - name: "Average Tidal Range M"
      expr: AVG(tidal_range_m)
    - name: "Total Total Length M"
      expr: SUM(total_length_m)
    - name: "Average Total Length M"
      expr: AVG(total_length_m)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_terminal_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal Zone business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`terminal_zone`"
  dimensions:
    - name: "Access Control System"
      expr: access_control_system
    - name: "Active Flag"
      expr: active_flag
    - name: "Boundary Coordinates Wkt"
      expr: boundary_coordinates_wkt
    - name: "Cctv Coverage Flag"
      expr: cctv_coverage_flag
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Customs Controlled Flag"
      expr: customs_controlled_flag
    - name: "Drainage System Type"
      expr: drainage_system_type
    - name: "Environmental Monitoring Flag"
      expr: environmental_monitoring_flag
    - name: "Fire Suppression System"
      expr: fire_suppression_system
    - name: "Ground Slot Capacity Teu"
      expr: ground_slot_capacity_teu
    - name: "Handling Equipment Type"
      expr: handling_equipment_type
    - name: "Hazmat Approved Flag"
      expr: hazmat_approved_flag
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Resurfacing Date"
      expr: last_resurfacing_date
    - name: "Lease Status"
      expr: lease_status
    - name: "Lighting Type"
      expr: lighting_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Terminal Zone"
      expr: COUNT(DISTINCT terminal_zone_id)
    - name: "Total Centroid Latitude"
      expr: SUM(centroid_latitude)
    - name: "Average Centroid Latitude"
      expr: AVG(centroid_latitude)
    - name: "Total Centroid Longitude"
      expr: SUM(centroid_longitude)
    - name: "Average Centroid Longitude"
      expr: AVG(centroid_longitude)
    - name: "Total Design Capacity Utilization Pct"
      expr: SUM(design_capacity_utilization_pct)
    - name: "Average Design Capacity Utilization Pct"
      expr: AVG(design_capacity_utilization_pct)
    - name: "Total Paved Area Sqm"
      expr: SUM(paved_area_sqm)
    - name: "Average Paved Area Sqm"
      expr: AVG(paved_area_sqm)
    - name: "Total Total Area Sqm"
      expr: SUM(total_area_sqm)
    - name: "Average Total Area Sqm"
      expr: AVG(total_area_sqm)
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`infrastructure_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse business metrics"
  source: "`vibe_shipping_ports_v1`.`infrastructure`.`warehouse`"
  dimensions:
    - name: "Access Control System"
      expr: access_control_system
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Bonded Status"
      expr: bonded_status
    - name: "Cctv Coverage"
      expr: cctv_coverage
    - name: "City"
      expr: city
    - name: "Code"
      expr: warehouse_code
    - name: "Construction Year"
      expr: construction_year
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs License Number"
      expr: customs_license_number
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Environmental Certification"
      expr: environmental_certification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Warehouse"
      expr: COUNT(DISTINCT warehouse_id)
    - name: "Total Floor Load Capacity Kn Per Sqm"
      expr: SUM(floor_load_capacity_kn_per_sqm)
    - name: "Average Floor Load Capacity Kn Per Sqm"
      expr: AVG(floor_load_capacity_kn_per_sqm)
    - name: "Total Geo Latitude"
      expr: SUM(geo_latitude)
    - name: "Average Geo Latitude"
      expr: AVG(geo_latitude)
    - name: "Total Geo Longitude"
      expr: SUM(geo_longitude)
    - name: "Average Geo Longitude"
      expr: AVG(geo_longitude)
    - name: "Total Height Clearance M"
      expr: SUM(height_clearance_m)
    - name: "Average Height Clearance M"
      expr: AVG(height_clearance_m)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total Max Forklift Capacity Tonnes"
      expr: SUM(max_forklift_capacity_tonnes)
    - name: "Average Max Forklift Capacity Tonnes"
      expr: AVG(max_forklift_capacity_tonnes)
    - name: "Total Temperature Range Max C"
      expr: SUM(temperature_range_max_c)
    - name: "Average Temperature Range Max C"
      expr: AVG(temperature_range_max_c)
    - name: "Total Temperature Range Min C"
      expr: SUM(temperature_range_min_c)
    - name: "Average Temperature Range Min C"
      expr: AVG(temperature_range_min_c)
    - name: "Total Total Floor Area Sqm"
      expr: SUM(total_floor_area_sqm)
    - name: "Average Total Floor Area Sqm"
      expr: AVG(total_floor_area_sqm)
    - name: "Total Usable Storage Area Sqm"
      expr: SUM(usable_storage_area_sqm)
    - name: "Average Usable Storage Area Sqm"
      expr: AVG(usable_storage_area_sqm)
$$;
