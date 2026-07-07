-- Metric views for domain: fabrication | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_equipment_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment group capacity, utilization targets, and operational status KPIs. Drives equipment investment, maintenance planning, and capacity allocation decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`equipment_group`"
  dimensions:
    - name: "equipment_group_status"
      expr: equipment_group_status
      comment: "Current operational status of the equipment group — primary status dimension for availability analysis."
    - name: "equipment_class"
      expr: equipment_class
      comment: "Class of equipment in the group (lithography, etch, deposition, etc.) — used for equipment-type capacity analysis."
    - name: "group_type"
      expr: group_type
      comment: "Type of equipment group — used for group portfolio classification."
    - name: "process_area"
      expr: process_area
      comment: "Process area where the equipment group is located — used for area-level capacity analysis."
    - name: "process_technology"
      expr: process_technology
      comment: "Process technology supported by the equipment group — used for technology-specific capacity planning."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the equipment group — used for availability and downtime analysis."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy applied to the group (preventive, predictive, reactive) — used for maintenance effectiveness analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the equipment group is currently active — used to filter active vs. inactive groups."
  measures:
    - name: "total_equipment_groups"
      expr: COUNT(1)
      comment: "Total number of equipment groups — baseline metric for fab equipment portfolio size."
    - name: "active_equipment_group_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN equipment_group_id END)
      comment: "Number of active equipment groups — measures available equipment capacity for production planning."
    - name: "avg_utilization_target_percent"
      expr: AVG(CAST(utilization_target_percent AS DOUBLE))
      comment: "Average utilization target across equipment groups — used to benchmark capacity planning assumptions."
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum operating temperature across equipment groups — used for thermal management and safety planning."
    - name: "avg_voltage_rating_v"
      expr: AVG(CAST(voltage_rating_v AS DOUBLE))
      comment: "Average voltage rating across equipment groups — used for electrical infrastructure capacity planning."
    - name: "distinct_process_areas"
      expr: COUNT(DISTINCT process_area)
      comment: "Number of distinct process areas covered by equipment groups — measures fab process coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_equipment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilization and process performance metrics for tool efficiency and process control"
  source: "`vibe_semiconductors_v1`.`fabrication`.`equipment_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of equipment run (completed, aborted, in-progress)"
    - name: "process_type"
      expr: process_type
      comment: "Type of process operation (deposition, etch, lithography, implant, CMP)"
    - name: "abort_reason"
      expr: abort_reason
      comment: "Reason for run abort if applicable"
    - name: "deposition_film_material"
      expr: deposition_film_material
      comment: "Material deposited in deposition processes"
    - name: "implant_species"
      expr: implant_species
      comment: "Ion species used in implant processes"
    - name: "cmp_slurry_type"
      expr: cmp_slurry_type
      comment: "Slurry type used in CMP processes"
    - name: "run_start_month"
      expr: DATE_TRUNC('MONTH', run_start_timestamp)
      comment: "Month when run started"
    - name: "run_start_quarter"
      expr: DATE_TRUNC('QUARTER', run_start_timestamp)
      comment: "Quarter when run started"
  measures:
    - name: "total_equipment_runs"
      expr: COUNT(DISTINCT equipment_run_id)
      comment: "Total number of equipment runs"
    - name: "total_run_duration_hours"
      expr: SUM(CAST(run_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total equipment run time in hours"
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_seconds AS DOUBLE)) / 60.0
      comment: "Average run duration in minutes"
    - name: "total_wafers_processed"
      expr: SUM(CAST(wafer_count AS DOUBLE))
      comment: "Total wafers processed across all runs"
    - name: "avg_wafers_per_run"
      expr: AVG(CAST(wafer_count AS DOUBLE))
      comment: "Average wafer count per equipment run"
    - name: "avg_deposition_rate_angstrom_per_min"
      expr: AVG(CAST(deposition_rate_angstrom_per_min AS DOUBLE))
      comment: "Average deposition rate for deposition processes"
    - name: "avg_deposition_uniformity_pct"
      expr: AVG(CAST(deposition_uniformity_percent AS DOUBLE))
      comment: "Average film uniformity percentage for deposition"
    - name: "avg_cmp_removal_rate"
      expr: AVG(CAST(cmp_removal_rate_angstrom_per_min AS DOUBLE))
      comment: "Average material removal rate for CMP processes"
    - name: "avg_cmp_wiwnu_pct"
      expr: AVG(CAST(cmp_wiwnu_percent AS DOUBLE))
      comment: "Average within-wafer non-uniformity for CMP"
    - name: "avg_lithography_cd_nm"
      expr: AVG(CAST(lithography_cd_measurement_nm AS DOUBLE))
      comment: "Average critical dimension measurement for lithography"
    - name: "avg_actual_temperature_c"
      expr: AVG(CAST(actual_temperature_celsius AS DOUBLE))
      comment: "Average actual process temperature in Celsius"
    - name: "avg_actual_pressure_torr"
      expr: AVG(CAST(actual_pressure_torr AS DOUBLE))
      comment: "Average actual process pressure in Torr"
    - name: "abort_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN abort_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs that were aborted"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab facility capacity, utilization, and operational performance metrics for strategic planning and resource allocation"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_facility`"
  dimensions:
    - name: "facility_name"
      expr: facility_name
      comment: "Name of fabrication facility"
    - name: "facility_code"
      expr: facility_code
      comment: "Unique facility identifier code"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (production, R&D, pilot)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, idle, maintenance, shutdown)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage (ramp, mature, sunset)"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom classification"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Primary lithography technology (DUV, EUV)"
    - name: "process_technology_node"
      expr: process_technology_node
      comment: "Primary technology node supported"
    - name: "country_code"
      expr: country_code
      comment: "Country where facility is located"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status"
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT fab_facility_id)
      comment: "Total number of fabrication facilities"
    - name: "total_capacity_wafers_per_month"
      expr: SUM(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Total monthly wafer capacity across all facilities"
    - name: "avg_capacity_per_facility"
      expr: AVG(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Average monthly wafer capacity per facility"
    - name: "total_fab_area_sqft"
      expr: SUM(CAST(fab_area_sqft AS DOUBLE))
      comment: "Total fabrication floor area in square feet"
    - name: "avg_fab_area_sqft"
      expr: AVG(CAST(fab_area_sqft AS DOUBLE))
      comment: "Average fabrication floor area per facility"
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in megawatt-hours"
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average energy consumption per facility"
    - name: "total_carbon_footprint_kgco2e"
      expr: SUM(CAST(carbon_footprint_kgco2e AS DOUBLE))
      comment: "Total carbon footprint in kg CO2 equivalent"
    - name: "avg_carbon_footprint_kgco2e"
      expr: AVG(CAST(carbon_footprint_kgco2e AS DOUBLE))
      comment: "Average carbon footprint per facility"
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_m3 AS DOUBLE))
      comment: "Total water usage in cubic meters"
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons"
    - name: "energy_intensity_mwh_per_wafer"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE)) / NULLIF(SUM(CAST(capacity_wafer_per_month AS DOUBLE)), 0)
      comment: "Energy consumption per wafer capacity unit"
    - name: "carbon_intensity_kgco2e_per_wafer"
      expr: SUM(CAST(carbon_footprint_kgco2e AS DOUBLE)) / NULLIF(SUM(CAST(capacity_wafer_per_month AS DOUBLE)), 0)
      comment: "Carbon footprint per wafer capacity unit"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_run_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Run card cycle time, compliance, and deviation KPIs. Drives run card governance, on-time completion, and regulatory compliance decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_run_card`"
  dimensions:
    - name: "run_card_status"
      expr: run_card_status
      comment: "Current status of the run card (open, completed, on-hold) — primary run card lifecycle dimension."
    - name: "run_card_type"
      expr: run_card_type
      comment: "Type of run card (production, engineering, qualification) — used to separate production from non-production activity."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the run card — used for capacity allocation and expedite analysis."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Indicates whether a process deviation was recorded — used to track deviation frequency and impact."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the run card is on hold — used to track hold-driven cycle time impact."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates ITAR-controlled run cards — used for export compliance tracking."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Indicates RoHS compliance status — used for environmental regulatory compliance tracking."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the run card — used for quality-tiered analysis of production output."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month the run card was started — primary time dimension for run card volume and cycle time trending."
  measures:
    - name: "total_run_cards"
      expr: COUNT(1)
      comment: "Total number of run cards — baseline metric for production order volume and fab loading."
    - name: "deviation_run_card_count"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN fab_run_card_id END)
      comment: "Number of run cards with process deviations — high deviation rates signal process instability or recipe issues."
    - name: "on_hold_run_card_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN fab_run_card_id END)
      comment: "Number of run cards currently on hold — directly impacts WIP cycle time and delivery commitments."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average run card cycle time in days — primary fab efficiency KPI for on-time delivery performance."
    - name: "itar_controlled_run_card_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN fab_run_card_id END)
      comment: "Number of ITAR-controlled run cards — used for export compliance production volume monitoring."
    - name: "distinct_process_flows"
      expr: COUNT(DISTINCT fabrication_process_flow_id)
      comment: "Number of distinct process flows across run cards — measures production complexity and multi-flow fab loading."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site-level capacity and resource utilization."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_site`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Region of the fab site."
    - name: "site_type"
      expr: site_type
      comment: "Type of site (e.g., main, satellite)."
    - name: "is_primary_site"
      expr: is_primary_site
      comment: "Flag indicating primary site."
    - name: "site_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of record creation."
  measures:
    - name: "total_power_capacity_mw"
      expr: SUM(CAST(power_capacity_mw AS DOUBLE))
      comment: "Total power capacity across sites (MW)."
    - name: "avg_water_capacity_m3_per_day"
      expr: AVG(CAST(water_capacity_m3_per_day AS DOUBLE))
      comment: "Average water capacity per day (m3)."
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of sites."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer-level yield and die quality metrics for production monitoring and process control"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_yield_record`"
  dimensions:
    - name: "checkpoint_code"
      expr: checkpoint_code
      comment: "Yield measurement checkpoint in process flow"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Wafer disposition decision (pass, fail, rework, scrap)"
    - name: "yield_excursion_flag"
      expr: yield_excursion_flag
      comment: "Indicates if yield fell outside control limits"
    - name: "excursion_severity_level"
      expr: excursion_severity_level
      comment: "Severity classification of yield excursion"
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates if wafer requires rework"
    - name: "scrap_flag"
      expr: scrap_flag
      comment: "Indicates if wafer is scrapped"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code if wafer is placed on hold"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when yield was measured"
    - name: "measurement_quarter"
      expr: DATE_TRUNC('QUARTER', measurement_timestamp)
      comment: "Quarter when yield was measured"
  measures:
    - name: "total_yield_records"
      expr: COUNT(DISTINCT fab_yield_record_id)
      comment: "Total number of yield measurement records"
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across all measurements"
    - name: "total_gross_die"
      expr: SUM(CAST(gross_die_count AS DOUBLE))
      comment: "Total gross die count before yield loss"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total good die passing all tests"
    - name: "total_design_loss_die"
      expr: SUM(CAST(design_loss_die_count AS DOUBLE))
      comment: "Total die lost due to design-related issues"
    - name: "total_process_loss_die"
      expr: SUM(CAST(process_loss_die_count AS DOUBLE))
      comment: "Total die lost due to process defects"
    - name: "total_random_defect_die"
      expr: SUM(CAST(random_defect_die_count AS DOUBLE))
      comment: "Total die lost to random defects"
    - name: "total_systematic_defect_die"
      expr: SUM(CAST(systematic_defect_die_count AS DOUBLE))
      comment: "Total die lost to systematic defects"
    - name: "yield_excursion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN yield_excursion_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements with yield excursions"
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rework_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wafers requiring rework"
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN scrap_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wafers scrapped"
    - name: "process_loss_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(process_loss_die_count AS DOUBLE)) / NULLIF(SUM(CAST(gross_die_count AS DOUBLE)), 0), 2)
      comment: "Percentage of die lost due to process issues"
    - name: "design_loss_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(design_loss_die_count AS DOUBLE)) / NULLIF(SUM(CAST(gross_die_count AS DOUBLE)), 0), 2)
      comment: "Percentage of die lost due to design issues"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_genealogy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot genealogy traceability, split/merge activity, and compliance KPIs. Drives lot traceability governance, quality investigation, and regulatory compliance decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_genealogy`"
  dimensions:
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of genealogy relationship (split, merge, rework, transfer) — primary genealogy event classification."
    - name: "process_stage"
      expr: process_stage
      comment: "Process stage at which the genealogy event occurred — used for stage-level traceability analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of the lots in the genealogy relationship — used for node-level traceability analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the genealogy event is compliance-relevant — used for regulatory traceability reporting."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Indicates whether a quality hold is associated with the genealogy event — used for quality investigation traceability."
    - name: "is_reversible"
      expr: is_reversible
      comment: "Indicates whether the genealogy relationship is reversible — used for rework and reversal planning."
    - name: "relationship_month"
      expr: DATE_TRUNC('month', relationship_timestamp)
      comment: "Month of the genealogy relationship event — used for traceability event volume trending."
  measures:
    - name: "total_genealogy_events"
      expr: COUNT(1)
      comment: "Total number of lot genealogy events — baseline metric for lot traceability activity volume."
    - name: "compliance_genealogy_event_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN fabrication_lot_genealogy_id END)
      comment: "Number of compliance-relevant genealogy events — used for regulatory traceability coverage reporting."
    - name: "quality_hold_genealogy_count"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN fabrication_lot_genealogy_id END)
      comment: "Number of genealogy events associated with quality holds — used to assess quality-driven lot split/merge activity."
    - name: "distinct_primary_lots"
      expr: COUNT(DISTINCT primary_fabrication_wafer_lot_id)
      comment: "Number of distinct primary lots with genealogy records — measures traceability coverage across the lot population."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot hold and quality containment metrics tracking hold reasons, durations, and resolution effectiveness"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of hold (active, released, escalated)"
    - name: "hold_type"
      expr: hold_type
      comment: "Classification of hold (quality, engineering, customer, equipment)"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardized reason code for hold placement"
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken to resolve hold (release, scrap, rework, waiver)"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause category identified during investigation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for hold resolution"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates if hold was escalated to management"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Indicates if customer notification is required"
    - name: "approval_required"
      expr: approval_required
      comment: "Indicates if management approval is required for release"
    - name: "hold_placement_month"
      expr: DATE_TRUNC('MONTH', hold_placement_timestamp)
      comment: "Month when hold was placed"
    - name: "hold_release_month"
      expr: DATE_TRUNC('MONTH', hold_release_timestamp)
      comment: "Month when hold was released"
  measures:
    - name: "total_lot_holds"
      expr: COUNT(DISTINCT fabrication_lot_hold_id)
      comment: "Total number of lot hold events"
    - name: "total_wafers_on_hold"
      expr: SUM(CAST(wafer_count AS DOUBLE))
      comment: "Total wafer count affected by holds"
    - name: "avg_hold_cycle_time_hours"
      expr: AVG(CAST(hold_cycle_time_hours AS DOUBLE))
      comment: "Average duration from hold placement to release in hours"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds requiring escalation"
    - name: "customer_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds requiring customer notification"
    - name: "approval_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds requiring management approval"
    - name: "defect_threshold_exceeded_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN defect_density_threshold_exceeded = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds due to defect density threshold exceedance"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow definition and qualification metrics tracking flow complexity, cycle time targets, and qualification status"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`"
  dimensions:
    - name: "flow_name"
      expr: flow_name
      comment: "Name of fabrication process flow"
    - name: "flow_code"
      expr: flow_code
      comment: "Unique flow identifier code"
    - name: "flow_type"
      expr: flow_type
      comment: "Type of flow (production, development, qualification)"
    - name: "flow_status"
      expr: flow_status
      comment: "Current status (active, deprecated, under development)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status (qualified, in qualification, not qualified)"
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for this flow"
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture type (FinFET, GAA, planar)"
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology used (DUV, EUV)"
    - name: "substrate_type"
      expr: substrate_type
      comment: "Substrate material type"
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer size in millimeters"
    - name: "is_customer_specific"
      expr: is_customer_specific
      comment: "Indicates if flow is customer-specific"
    - name: "requires_nre"
      expr: requires_nre
      comment: "Indicates if flow requires non-recurring engineering"
    - name: "environmental_classification"
      expr: environmental_classification
      comment: "Environmental compliance classification"
  measures:
    - name: "total_process_flows"
      expr: COUNT(DISTINCT fabrication_process_flow_id)
      comment: "Total number of defined process flows"
    - name: "avg_total_process_steps"
      expr: AVG(CAST(total_process_steps AS DOUBLE))
      comment: "Average total number of process steps per flow"
    - name: "avg_metal_layer_count"
      expr: AVG(CAST(metal_layer_count AS DOUBLE))
      comment: "Average number of metal layers per flow"
    - name: "avg_feol_step_count"
      expr: AVG(CAST(feol_step_count AS DOUBLE))
      comment: "Average front-end-of-line step count"
    - name: "avg_beol_step_count"
      expr: AVG(CAST(beol_step_count AS DOUBLE))
      comment: "Average back-end-of-line step count"
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time in days"
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage"
    - name: "customer_specific_flow_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_customer_specific = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flows that are customer-specific"
    - name: "nre_required_flow_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_nre = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flows requiring non-recurring engineering"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process recipe qualification status, parameter targets, and compliance KPIs. Drives recipe governance, requalification scheduling, and process control decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (active, obsolete, under-review) — primary recipe lifecycle dimension."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the recipe — used to ensure only qualified recipes are used in production."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the recipe — used for change control governance tracking."
    - name: "process_operation_type"
      expr: process_operation_type
      comment: "Type of process operation (etch, deposition, implant, anneal) — enables operation-type performance analysis."
    - name: "process_layer_type"
      expr: process_layer_type
      comment: "Layer type the recipe targets — used for layer-specific process control analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type the recipe is qualified for — used for equipment-recipe compatibility analysis."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicates ITAR-controlled recipes — used for export compliance recipe inventory management."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates environmental compliance status of the recipe — used for regulatory compliance tracking."
    - name: "product_family"
      expr: product_family
      comment: "Product family the recipe supports — used for product-line recipe coverage analysis."
  measures:
    - name: "total_recipes"
      expr: COUNT(1)
      comment: "Total number of process recipes — baseline metric for recipe library size and governance coverage."
    - name: "qualified_recipe_count"
      expr: COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN fabrication_process_recipe_id END)
      comment: "Number of fully qualified recipes — measures recipe readiness for production use."
    - name: "unqualified_recipe_count"
      expr: COUNT(CASE WHEN qualification_status != 'QUALIFIED' THEN fabrication_process_recipe_id END)
      comment: "Number of recipes not yet qualified — identifies qualification backlog and production readiness risk."
    - name: "avg_yield_target_percent"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average yield target across recipes — used to benchmark recipe quality expectations and identify low-target recipes."
    - name: "avg_uniformity_target_percent"
      expr: AVG(CAST(uniformity_target_percent AS DOUBLE))
      comment: "Average uniformity target across recipes — measures process control stringency across the recipe library."
    - name: "avg_target_thickness_nm"
      expr: AVG(CAST(target_thickness_nm AS DOUBLE))
      comment: "Average target film thickness in nm — used for process capability and specification compliance analysis."
    - name: "avg_defect_density_target"
      expr: AVG(CAST(defect_density_target_per_cm2 AS DOUBLE))
      comment: "Average defect density target per cm² — measures quality stringency of the recipe portfolio."
    - name: "itar_controlled_recipe_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN fabrication_process_recipe_id END)
      comment: "Number of ITAR-controlled recipes — used for export compliance recipe inventory and access control."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_step`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process step configuration, cycle time targets, and critical step coverage KPIs. Drives process flow optimization and step-level quality governance."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`"
  dimensions:
    - name: "step_status"
      expr: step_status
      comment: "Current status of the process step (active, obsolete, under-review) — primary step lifecycle dimension."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the process step — used for change control governance."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation performed at this step (etch, deposition, metrology, etc.) — enables operation-type analysis."
    - name: "process_category"
      expr: process_category
      comment: "Process category (FEOL, MOL, BEOL) — used for front-end vs. back-end process analysis."
    - name: "critical_step_flag"
      expr: critical_step_flag
      comment: "Indicates whether this is a critical process step — used to prioritize monitoring and control resources."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates whether inspection is required at this step — used for inspection coverage analysis."
    - name: "rework_loop_indicator"
      expr: rework_loop_indicator
      comment: "Indicates whether this step is part of a rework loop — used to identify rework-prone process areas."
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class required for this step — used for equipment capacity planning by step type."
  measures:
    - name: "total_process_steps"
      expr: COUNT(1)
      comment: "Total number of process steps — baseline metric for process flow complexity and governance coverage."
    - name: "critical_step_count"
      expr: COUNT(CASE WHEN critical_step_flag = TRUE THEN fabrication_process_step_id END)
      comment: "Number of critical process steps — used to assess process risk concentration and monitoring resource allocation."
    - name: "inspection_required_step_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN fabrication_process_step_id END)
      comment: "Number of steps requiring inspection — drives inspection capacity planning and quality gate coverage."
    - name: "avg_target_cycle_time_minutes"
      expr: AVG(CAST(target_cycle_time_minutes AS DOUBLE))
      comment: "Average target cycle time per step in minutes — used for process flow cycle time modeling and bottleneck identification."
    - name: "avg_step_cost_per_wafer"
      expr: AVG(CAST(step_cost_per_wafer AS DOUBLE))
      comment: "Average cost per wafer per process step — used for cost-of-goods-sold modeling and step-level cost optimization."
    - name: "avg_sampling_rate_percent"
      expr: AVG(CAST(sampling_rate_percent AS DOUBLE))
      comment: "Average sampling rate across process steps — measures quality monitoring intensity and statistical coverage."
    - name: "avg_max_queue_time_minutes"
      expr: AVG(CAST(max_queue_time_minutes AS DOUBLE))
      comment: "Average maximum allowed queue time per step — used to assess process sensitivity to WIP queuing."
    - name: "rework_loop_step_count"
      expr: COUNT(CASE WHEN rework_loop_indicator = TRUE THEN fabrication_process_step_id END)
      comment: "Number of steps that are part of rework loops — high counts indicate process areas with chronic quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_technology_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology node qualification status, cost, and compliance KPIs. Drives node investment decisions, qualification roadmap, and export control compliance."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the technology node — primary dimension for production readiness analysis."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (planar, FinFET, GAA) — used for technology generation analysis."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology used for the node — used for technology capability and investment analysis."
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates whether the node is currently active — used to filter active vs. legacy node analysis."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicates ITAR-controlled technology nodes — used for export compliance capacity and customer eligibility analysis."
    - name: "iso9001_certified_flag"
      expr: iso9001_certified_flag
      comment: "Indicates ISO 9001 certification status — used for quality management system compliance tracking."
    - name: "node_generation"
      expr: node_generation
      comment: "Generation of the technology node — used for roadmap and investment planning by generation."
  measures:
    - name: "total_technology_nodes"
      expr: COUNT(1)
      comment: "Total number of technology nodes in the portfolio — baseline metric for technology breadth."
    - name: "qualified_node_count"
      expr: COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN fabrication_technology_node_id END)
      comment: "Number of fully qualified technology nodes — measures production-ready technology capacity."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size in nm across nodes — measures technology portfolio advancement level."
    - name: "avg_mask_set_cost_usd"
      expr: AVG(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Average mask set cost per technology node — key NRE cost input for customer pricing and investment decisions."
    - name: "total_nre_cost_estimate_usd"
      expr: SUM(CAST(nre_cost_estimate_usd AS DOUBLE))
      comment: "Total NRE cost estimate across technology nodes — measures total technology development investment required."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percent across technology nodes — used to benchmark yield expectations by node generation."
    - name: "itar_controlled_node_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN fabrication_technology_node_id END)
      comment: "Number of ITAR-controlled technology nodes — used for export compliance capacity planning and customer eligibility."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core wafer lot production metrics tracking throughput, cycle time, and work-in-process status across fabrication operations"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`"
  dimensions:
    - name: "lot_number"
      expr: lot_number
      comment: "Unique lot identifier for traceability"
    - name: "lot_type"
      expr: lot_type
      comment: "Classification of lot (production, engineering, qualification, etc.)"
    - name: "wip_status"
      expr: wip_status
      comment: "Current work-in-process status of the lot"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority tier for scheduling and resource allocation"
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Final disposition status (pass, fail, scrap, rework)"
    - name: "current_process_area"
      expr: current_process_area
      comment: "Current fabrication area where lot is located"
    - name: "fab_facility_code"
      expr: fab_facility_code
      comment: "Facility where lot is being processed"
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Technology node in nanometers"
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter in millimeters"
    - name: "is_hot_lot"
      expr: is_hot_lot
      comment: "Flag indicating expedited processing requirement"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates if lot is currently on hold"
    - name: "lot_start_month"
      expr: DATE_TRUNC('MONTH', wafer_start_timestamp)
      comment: "Month when wafer lot was started"
    - name: "lot_start_quarter"
      expr: DATE_TRUNC('QUARTER', wafer_start_timestamp)
      comment: "Quarter when wafer lot was started"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_timestamp)
      comment: "Month when lot was completed"
  measures:
    - name: "total_lots"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Total number of unique wafer lots"
    - name: "total_wafers_started"
      expr: SUM(CAST(wafer_count AS DOUBLE))
      comment: "Total wafer count across all lots"
    - name: "total_wafers_scrapped"
      expr: SUM(CAST(scrap_wafer_count AS DOUBLE))
      comment: "Total number of scrapped wafers"
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average cycle time from start to completion in days"
    - name: "avg_process_time_hours"
      expr: AVG(CAST(process_time_hours AS DOUBLE))
      comment: "Average active processing time in hours"
    - name: "avg_queue_time_hours"
      expr: AVG(CAST(queue_time_hours AS DOUBLE))
      comment: "Average queue time waiting between operations in hours"
    - name: "wafer_scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_wafer_count AS DOUBLE)) / NULLIF(SUM(CAST(wafer_count AS DOUBLE)), 0), 2)
      comment: "Percentage of wafers scrapped relative to total started"
    - name: "hot_lot_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hot_lot = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots flagged as hot lots requiring expedited processing"
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hold_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots currently on hold"
    - name: "avg_rework_count"
      expr: AVG(CAST(rework_count AS DOUBLE))
      comment: "Average number of rework cycles per lot"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot disposition and quality decision metrics tracking scrap, rework, and waiver decisions with financial impact"
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition decision (accept, reject, rework, scrap, waiver)"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of disposition (pending, approved, executed)"
    - name: "disposition_authority"
      expr: disposition_authority
      comment: "Authority level that made disposition decision"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for non-conformance"
    - name: "defect_code"
      expr: defect_code
      comment: "Defect classification code"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrap decision"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates if corrective action is required"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Indicates if customer notification is required"
    - name: "customer_approval_received"
      expr: customer_approval_received
      comment: "Indicates if customer approved disposition"
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month when disposition was made"
    - name: "disposition_quarter"
      expr: DATE_TRUNC('QUARTER', disposition_date)
      comment: "Quarter when disposition was made"
  measures:
    - name: "total_dispositions"
      expr: COUNT(DISTINCT lot_disposition_id)
      comment: "Total number of lot disposition decisions"
    - name: "total_affected_wafers"
      expr: SUM(CAST(affected_wafer_count AS DOUBLE))
      comment: "Total wafers affected by disposition decisions"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total good die from dispositioned lots"
    - name: "total_defect_die"
      expr: SUM(CAST(defect_die_count AS DOUBLE))
      comment: "Total defective die from dispositioned lots"
    - name: "avg_lot_yield_pct"
      expr: AVG(CAST(lot_yield_percent AS DOUBLE))
      comment: "Average lot yield percentage for dispositioned lots"
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of disposition decisions in USD"
    - name: "avg_financial_impact_per_disposition"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per disposition decision"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispositions requiring corrective action"
    - name: "customer_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispositions requiring customer notification"
    - name: "customer_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_approval_received = true THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN customer_notification_required = true THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of customer-notified dispositions that received approval"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot move throughput, process parameter adherence, and rework/scrap KPIs at the step level. Drives step-level bottleneck analysis and process control decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_move`"
  dimensions:
    - name: "move_status"
      expr: move_status
      comment: "Status of the lot move transaction (completed, aborted, rework) — primary move outcome dimension."
    - name: "process_layer"
      expr: process_layer
      comment: "Process layer at which the move occurred — enables layer-level throughput and yield analysis."
    - name: "process_module"
      expr: process_module
      comment: "Process module (FEOL, MOL, BEOL) — used for module-level WIP flow analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of the lot being moved — enables node-level throughput analysis."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates whether the move was a rework move — used to quantify rework-driven cycle time impact."
    - name: "sampling_flag"
      expr: sampling_flag
      comment: "Indicates whether the lot was sampled at this move — used for sampling coverage analysis."
    - name: "move_in_month"
      expr: DATE_TRUNC('month', move_in_timestamp)
      comment: "Month of move-in — primary time dimension for step-level throughput trending."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the lot move — used for priority-based throughput analysis."
  measures:
    - name: "total_lot_moves"
      expr: COUNT(1)
      comment: "Total number of lot move transactions — primary fab throughput metric; directly measures WIP flow velocity."
    - name: "rework_move_count"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN lot_move_id END)
      comment: "Number of rework moves — rework moves inflate cycle time and cost; high counts signal process quality issues."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average in-line measurement value at lot move — used to monitor process parameter trends at step level."
    - name: "avg_actual_temperature_c"
      expr: AVG(CAST(actual_temperature_c AS DOUBLE))
      comment: "Average actual process temperature at lot move — used for step-level thermal process control monitoring."
    - name: "avg_actual_pressure_torr"
      expr: AVG(CAST(actual_pressure_torr AS DOUBLE))
      comment: "Average actual process pressure at lot move — used for step-level pressure process control monitoring."
    - name: "avg_actual_power_watts"
      expr: AVG(CAST(actual_power_watts AS DOUBLE))
      comment: "Average actual RF/process power at lot move — used for power-sensitive process step control analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_mask_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mask set inventory, utilization, and cost metrics for lithography asset management"
  source: "`vibe_semiconductors_v1`.`fabrication`.`mask_set`"
  dimensions:
    - name: "mask_set_name"
      expr: mask_set_name
      comment: "Name of mask set"
    - name: "mask_set_code"
      expr: mask_set_code
      comment: "Unique mask set identifier"
    - name: "mask_set_status"
      expr: mask_set_status
      comment: "Current status (active, retired, under inspection)"
    - name: "mask_type"
      expr: mask_type
      comment: "Type of mask (reticle, photomask)"
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology (DUV, EUV, i-line)"
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade classification"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status"
    - name: "mask_set_category"
      expr: mask_set_category
      comment: "Category classification"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Latest inspection result"
  measures:
    - name: "total_mask_sets"
      expr: COUNT(DISTINCT mask_set_id)
      comment: "Total number of mask sets"
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set acquisition cost in USD"
    - name: "avg_mask_cost_usd"
      expr: AVG(CAST(mask_cost_usd AS DOUBLE))
      comment: "Average mask set cost in USD"
    - name: "avg_mask_layer_count"
      expr: AVG(CAST(mask_layer_count AS DOUBLE))
      comment: "Average number of mask layers per set"
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total cumulative usage count across all mask sets"
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage count per mask set"
    - name: "avg_mask_thickness_nm"
      expr: AVG(CAST(mask_thickness_nm AS DOUBLE))
      comment: "Average mask thickness in nanometers"
    - name: "avg_wafer_size_mm"
      expr: AVG(CAST(wafer_size_mm AS DOUBLE))
      comment: "Average wafer size supported in millimeters"
    - name: "avg_wavelength_nm"
      expr: AVG(CAST(wavelength_nm AS DOUBLE))
      comment: "Average lithography wavelength in nanometers"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_photomask`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Photomask lifecycle, usage, defect, and cost KPIs. Drives mask retirement decisions, inspection scheduling, and mask cost management."
  source: "`vibe_semiconductors_v1`.`fabrication`.`photomask`"
  dimensions:
    - name: "mask_status"
      expr: mask_status
      comment: "Current status of the photomask (active, retired, in-inspection) — primary mask lifecycle dimension."
    - name: "mask_type"
      expr: mask_type
      comment: "Type of photomask (binary, PSM, EUV) — used for mask-type cost and performance analysis."
    - name: "pellicle_status"
      expr: pellicle_status
      comment: "Status of the pellicle on the mask — pellicle degradation is a leading indicator of mask retirement need."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node the mask supports — used for node-level mask inventory and cost analysis."
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer the mask is used for — enables layer-specific mask utilization and defect analysis."
    - name: "lithography_wavelength"
      expr: lithography_wavelength
      comment: "Lithography wavelength (DUV, EUV) — used for wavelength-specific mask fleet analysis."
    - name: "mask_generation"
      expr: mask_generation
      comment: "Generation of the mask (tape-out revision) — used for mask revision tracking and cost amortization."
  measures:
    - name: "total_photomasks"
      expr: COUNT(1)
      comment: "Total number of photomasks in inventory — baseline metric for mask fleet size and management."
    - name: "active_mask_count"
      expr: COUNT(CASE WHEN mask_status = 'ACTIVE' THEN photomask_id END)
      comment: "Number of active photomasks — measures available mask capacity for production scheduling."
    - name: "retired_mask_count"
      expr: COUNT(CASE WHEN mask_status = 'RETIRED' THEN photomask_id END)
      comment: "Number of retired masks — used for mask fleet turnover and replacement cost planning."
    - name: "total_mask_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all photomasks — key capital asset metric for mask investment tracking."
    - name: "avg_mask_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per photomask — used for mask cost benchmarking and NRE cost modeling."
    - name: "avg_cumulative_exposure_hours"
      expr: AVG(CAST(cumulative_exposure_hours AS DOUBLE))
      comment: "Average cumulative exposure hours per mask — used to assess mask wear and predict retirement timing."
    - name: "avg_meef_value"
      expr: AVG(CAST(meef_value AS DOUBLE))
      comment: "Average Mask Error Enhancement Factor — high MEEF values indicate masks that amplify CD errors, impacting yield."
    - name: "avg_critical_dimension_target_nm"
      expr: AVG(CAST(critical_dimension_target_nm AS DOUBLE))
      comment: "Average critical dimension target in nm — used to assess mask precision requirements across the fleet."
    - name: "masks_near_retirement"
      expr: COUNT(CASE WHEN retirement_date IS NOT NULL AND mask_status = 'ACTIVE' THEN photomask_id END)
      comment: "Number of active masks with a retirement date set — used for proactive mask replacement planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_reticle_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reticle set lifecycle, utilization, defect rate, and cost KPIs. Drives reticle retirement scheduling, qualification status, and lithography asset management."
  source: "`vibe_semiconductors_v1`.`fabrication`.`reticle_set`"
  dimensions:
    - name: "reticle_set_status"
      expr: reticle_set_status
      comment: "Current status of the reticle set (active, retired, in-maintenance) — primary lifecycle dimension."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the reticle set — ensures only qualified reticles are used in production."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology (DUV, EUV, i-line) — used for technology-specific reticle fleet analysis."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the reticle set — used for maintenance scheduling and availability analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the reticle set is on a critical layer — used to prioritize monitoring and spare management."
    - name: "reticle_set_type"
      expr: reticle_set_type
      comment: "Type of reticle set — used for reticle portfolio classification and cost analysis."
    - name: "fab_location"
      expr: fab_location
      comment: "Fab location where the reticle set is deployed — used for site-level reticle inventory management."
  measures:
    - name: "total_reticle_sets"
      expr: COUNT(1)
      comment: "Total number of reticle sets — baseline metric for reticle fleet size and asset management."
    - name: "qualified_reticle_set_count"
      expr: COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN reticle_set_id END)
      comment: "Number of qualified reticle sets — measures production-ready reticle availability."
    - name: "total_reticle_set_cost"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of all reticle sets — key capital asset metric for lithography investment tracking."
    - name: "avg_reticle_set_cost"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per reticle set — used for NRE cost modeling and reticle investment benchmarking."
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in PPM across reticle sets — key quality metric; high defect rates drive yield loss."
    - name: "avg_current_cycle_count"
      expr: AVG(CAST(current_cycle_count AS DOUBLE))
      comment: "Average current cycle count across reticle sets — used to assess fleet wear and predict retirement timing."
    - name: "avg_expected_lifetime_cycles"
      expr: AVG(CAST(expected_lifetime_cycles AS DOUBLE))
      comment: "Average expected lifetime cycles — used for reticle replacement planning and capital budgeting."
    - name: "avg_storage_humidity_percent"
      expr: AVG(CAST(storage_humidity_percent AS DOUBLE))
      comment: "Average storage humidity for reticle sets — used to monitor storage condition compliance and prevent degradation."
    - name: "critical_reticle_set_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN reticle_set_id END)
      comment: "Number of critical reticle sets — used to prioritize spare management and availability monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_spc_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SPC control plan coverage, specification limits, and governance KPIs. Drives process control quality, plan currency, and critical parameter monitoring decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`spc_control_plan`"
  dimensions:
    - name: "spc_control_plan_status"
      expr: spc_control_plan_status
      comment: "Current status of the SPC control plan (active, superseded, draft) — primary plan lifecycle dimension."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of SPC control plan (process, product, equipment) — used for plan portfolio analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the plan covers a critical process parameter — used to prioritize monitoring resources."
    - name: "target_metric"
      expr: target_metric
      comment: "The process metric being controlled — used for parameter-level SPC coverage analysis."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the controlled parameter — used for dimensional analysis and reporting."
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Frequency of sampling for the control plan — used to assess monitoring intensity and statistical power."
  measures:
    - name: "total_spc_control_plans"
      expr: COUNT(1)
      comment: "Total number of SPC control plans — baseline metric for process control coverage breadth."
    - name: "active_spc_plan_count"
      expr: COUNT(CASE WHEN spc_control_plan_status = 'ACTIVE' THEN spc_control_plan_id END)
      comment: "Number of active SPC control plans — measures current process control governance coverage."
    - name: "critical_spc_plan_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN spc_control_plan_id END)
      comment: "Number of SPC plans covering critical parameters — used to assess critical process monitoring coverage."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across SPC control plans — used for process centering analysis."
    - name: "avg_control_limit_upper"
      expr: AVG(CAST(control_limit_upper AS DOUBLE))
      comment: "Average upper control limit across plans — used to assess process control window tightness."
    - name: "avg_control_limit_lower"
      expr: AVG(CAST(control_limit_lower AS DOUBLE))
      comment: "Average lower control limit across plans — paired with upper limit for control window analysis."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit — used to assess margin between control limits and specification limits."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit — used for process capability (Cpk) planning and spec compliance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_start`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer start volume, authorization, and planning KPIs. Drives capacity loading, demand fulfillment, and fab utilization decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`wafer_start`"
  dimensions:
    - name: "wafer_start_status"
      expr: wafer_start_status
      comment: "Status of the wafer start authorization (authorized, released, cancelled) — primary start lifecycle dimension."
    - name: "wafer_start_type"
      expr: wafer_start_type
      comment: "Type of wafer start (production, engineering, qualification, MPW) — used to separate revenue-generating from non-revenue starts."
    - name: "priority_class"
      expr: priority_class
      comment: "Priority class of the wafer start — used for capacity allocation and hot-lot planning."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for the wafer start — key dimension for node-level capacity and demand analysis."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter in mm — used for equipment compatibility and capacity planning by wafer size."
    - name: "substrate_type"
      expr: substrate_type
      comment: "Substrate material type (bulk silicon, SOI, etc.) — used for material planning and cost analysis."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicates ITAR-controlled wafer starts — used for export compliance capacity tracking."
    - name: "wafer_start_month"
      expr: DATE_TRUNC('month', wafer_start_date)
      comment: "Month of wafer start — primary time dimension for capacity loading and demand trend analysis."
    - name: "production_line"
      expr: production_line
      comment: "Production line assigned to the wafer start — used for line-level capacity and utilization analysis."
  measures:
    - name: "total_wafer_starts"
      expr: COUNT(1)
      comment: "Total number of wafer start authorizations — primary fab loading and demand volume metric."
    - name: "released_wafer_starts"
      expr: COUNT(CASE WHEN wafer_start_status = 'RELEASED' THEN wafer_start_id END)
      comment: "Number of wafer starts that have been released to the fab — measures actual fab loading vs. authorized demand."
    - name: "cancelled_wafer_starts"
      expr: COUNT(CASE WHEN wafer_start_status = 'CANCELLED' THEN wafer_start_id END)
      comment: "Number of cancelled wafer starts — cancellation rate signals demand volatility and planning accuracy issues."
    - name: "itar_controlled_start_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN wafer_start_id END)
      comment: "Number of ITAR-controlled wafer starts — used for export compliance capacity monitoring and reporting."
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time for wafer starts — used for delivery date planning and customer commitment accuracy."
    - name: "distinct_process_flows"
      expr: COUNT(DISTINCT fabrication_process_flow_id)
      comment: "Number of distinct process flows in wafer starts — measures fab process complexity and multi-flow loading."
    - name: "mpw_shuttle_start_count"
      expr: COUNT(CASE WHEN mpw_shuttle_id IS NOT NULL THEN wafer_start_id END)
      comment: "Number of wafer starts associated with MPW shuttles — used to track MPW program utilization and revenue."
$$;
