-- Metric views for domain: treatment | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_finished_water_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over daily finished water production records. Tracks treatment plant throughput, efficiency, disinfection compliance, and water quality outcomes to support operational steering and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Calendar date of the production record, used for daily/monthly trend analysis."
    - name: "production_status"
      expr: production_status
      comment: "Operational status of the production record (e.g., Approved, Pending, Rejected) for filtering valid records."
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Type of treatment process applied (e.g., conventional, membrane, UV) to compare efficiency across process types."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Disinfection method used (e.g., chlorination, UV, ozone) for compliance and cost benchmarking."
    - name: "shift_code"
      expr: shift_code
      comment: "Operational shift identifier to support shift-level performance analysis."
    - name: "regulatory_exceedance"
      expr: regulatory_exceedance
      comment: "Flag indicating whether a regulatory exceedance occurred during this production period."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Flag indicating data quality issues in the production record, used to filter reliable data."
  measures:
    - name: "total_finished_water_volume_mg"
      expr: SUM(CAST(finished_water_volume_mg AS DOUBLE))
      comment: "Total volume of finished (treated) water produced in million gallons. Core throughput KPI for capacity planning and demand management."
    - name: "total_source_water_volume_mg"
      expr: SUM(CAST(source_water_volume_mg AS DOUBLE))
      comment: "Total volume of raw source water withdrawn for treatment in million gallons. Used to compute plant efficiency ratio."
    - name: "total_volume_pumped_to_distribution_mg"
      expr: SUM(CAST(volume_pumped_to_distribution_mg AS DOUBLE))
      comment: "Total volume of finished water delivered to the distribution system in million gallons. Measures effective supply delivery."
    - name: "total_backwash_volume_mg"
      expr: SUM(CAST(backwash_volume_mg AS DOUBLE))
      comment: "Total water volume lost to filter backwash operations in million gallons. Tracks non-revenue process water consumption."
    - name: "total_plant_ops_water_volume_mg"
      expr: SUM(CAST(plant_ops_water_volume_mg AS DOUBLE))
      comment: "Total water volume consumed for plant operations (non-revenue) in million gallons. Supports operational cost and efficiency analysis."
    - name: "avg_plant_efficiency_ratio"
      expr: AVG(CAST(plant_efficiency_ratio AS DOUBLE))
      comment: "Average plant efficiency ratio (finished water / source water). A key operational KPI — low efficiency signals excessive process water loss."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity in NTU across production records. Regulatory compliance indicator — must remain below permitted limits."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_max_ntu)
      comment: "Maximum turbidity spike recorded in NTU. Identifies worst-case exceedance events for regulatory and operational review."
    - name: "avg_cl2_residual_mg_l"
      expr: AVG(CAST(cl2_residual_avg_mg_l AS DOUBLE))
      comment: "Average chlorine residual in finished water (mg/L). Critical disinfection compliance KPI — must stay within regulatory bounds."
    - name: "min_cl2_residual_mg_l"
      expr: MIN(cl2_residual_min_mg_l)
      comment: "Minimum chlorine residual recorded (mg/L). Identifies periods of under-disinfection risk requiring immediate operational response."
    - name: "avg_ct_achieved_mg_min_l"
      expr: AVG(CAST(ct_achieved_mg_min_l AS DOUBLE))
      comment: "Average CT value achieved (mg·min/L) for disinfection efficacy. Regulatory compliance metric for pathogen inactivation credit."
    - name: "avg_ct_required_mg_min_l"
      expr: AVG(CAST(ct_required_mg_min_l AS DOUBLE))
      comment: "Average CT value required by permit (mg·min/L). Paired with avg_ct_achieved to assess compliance margin."
    - name: "avg_ph"
      expr: AVG(CAST(ph_avg AS DOUBLE))
      comment: "Average finished water pH. Regulatory and corrosion-control KPI — deviations trigger treatment adjustments."
    - name: "avg_fluoride_mg_l"
      expr: AVG(CAST(fluoride_avg_mg_l AS DOUBLE))
      comment: "Average fluoride concentration in finished water (mg/L). Public health compliance metric with strict regulatory limits."
    - name: "avg_toc_mg_l"
      expr: AVG(CAST(toc_avg_mg_l AS DOUBLE))
      comment: "Average total organic carbon in finished water (mg/L). Precursor to disinfection by-product formation — drives treatment strategy decisions."
    - name: "avg_production_rate_gpm"
      expr: AVG(CAST(avg_production_rate_gpm AS DOUBLE))
      comment: "Average production flow rate in gallons per minute. Operational throughput KPI for capacity utilization benchmarking."
    - name: "peak_production_rate_gpm"
      expr: MAX(peak_production_rate_gpm)
      comment: "Maximum peak production rate recorded in GPM. Used for capacity headroom analysis and infrastructure investment decisions."
    - name: "regulatory_exceedance_count"
      expr: SUM(CASE WHEN regulatory_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of production records with a regulatory exceedance. Directly informs compliance risk posture and enforcement exposure."
    - name: "production_record_count"
      expr: COUNT(1)
      comment: "Total number of production records. Baseline volume metric for normalizing other KPIs and assessing data completeness."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_dose_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and compliance KPI layer over chemical dosing events. Tracks chemical consumption, cost, CT compliance, disinfection by-product risk, and dosing effectiveness to support treatment optimization and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "chemical_type"
      expr: chemical_type
      comment: "Type of chemical applied (e.g., chlorine, alum, fluoride) for cost and consumption analysis by chemical category."
    - name: "treatment_process_stage"
      expr: treatment_process_stage
      comment: "Stage of the treatment process where dosing occurred (e.g., pre-treatment, primary, secondary) for process-level analysis."
    - name: "dosing_method"
      expr: dosing_method
      comment: "Method used for chemical dosing (e.g., continuous, batch, slug) to compare operational approaches."
    - name: "dose_trigger_type"
      expr: dose_trigger_type
      comment: "Trigger that initiated the dose event (e.g., scheduled, alarm, manual) for root-cause and automation analysis."
    - name: "dose_event_status"
      expr: dose_event_status
      comment: "Status of the dose event (e.g., completed, aborted, in-progress) for operational quality filtering."
    - name: "ct_compliance_flag"
      expr: ct_compliance_flag
      comment: "Indicates whether the CT requirement was met for this dose event. Critical regulatory compliance dimension."
    - name: "dbp_formation_risk_flag"
      expr: dbp_formation_risk_flag
      comment: "Flags events with elevated disinfection by-product formation risk. Drives treatment adjustment decisions."
    - name: "regulatory_event_flag"
      expr: regulatory_event_flag
      comment: "Indicates whether this dose event is subject to regulatory reporting requirements."
    - name: "target_parameter"
      expr: target_parameter
      comment: "The water quality parameter targeted by the dose event (e.g., turbidity, chlorine residual, pH)."
    - name: "dose_start_timestamp"
      expr: DATE_TRUNC('day', dose_start_timestamp)
      comment: "Date of dose event start, truncated to day for daily trend analysis."
  measures:
    - name: "total_chemical_mass_applied_kg"
      expr: SUM(CAST(chemical_mass_applied_kg AS DOUBLE))
      comment: "Total mass of chemical applied across dose events in kilograms. Core chemical consumption KPI for procurement and cost management."
    - name: "total_volume_applied_l"
      expr: SUM(CAST(volume_applied_l AS DOUBLE))
      comment: "Total volume of chemical solution applied in liters. Supports dosing efficiency and inventory drawdown analysis."
    - name: "total_event_dose_cost_usd"
      expr: SUM(CAST(event_dose_cost_usd AS DOUBLE))
      comment: "Total chemical dosing cost in USD across all events. Direct operational cost KPI for treatment budget management."
    - name: "avg_dose_rate_mg_per_l"
      expr: AVG(CAST(dose_rate_mg_per_l AS DOUBLE))
      comment: "Average actual dose rate in mg/L. Compared against target dose rate to assess dosing precision and process control."
    - name: "avg_target_dose_rate_mg_per_l"
      expr: AVG(CAST(target_dose_rate_mg_per_l AS DOUBLE))
      comment: "Average target dose rate in mg/L. Baseline for measuring dosing accuracy and process adherence."
    - name: "avg_ct_value_mg_min_per_l"
      expr: AVG(CAST(ct_value_mg_min_per_l AS DOUBLE))
      comment: "Average CT value achieved during dose events (mg·min/L). Regulatory disinfection efficacy KPI."
    - name: "avg_ct_required_mg_min_per_l"
      expr: AVG(CAST(ct_required_mg_min_per_l AS DOUBLE))
      comment: "Average CT value required by regulation (mg·min/L). Paired with avg_ct_value to compute compliance margin."
    - name: "avg_post_dose_residual_mg_per_l"
      expr: AVG(CAST(post_dose_residual_mg_per_l AS DOUBLE))
      comment: "Average chemical residual measured after dosing (mg/L). Indicates dosing effectiveness and distribution system protection."
    - name: "avg_pre_dose_residual_mg_per_l"
      expr: AVG(CAST(pre_dose_residual_mg_per_l AS DOUBLE))
      comment: "Average chemical residual measured before dosing (mg/L). Baseline for assessing residual decay and dosing need."
    - name: "avg_unit_cost_per_kg"
      expr: AVG(CAST(unit_cost_per_kg AS DOUBLE))
      comment: "Average unit cost of chemical per kilogram. Procurement benchmarking KPI for supplier and contract management."
    - name: "ct_non_compliance_event_count"
      expr: SUM(CASE WHEN ct_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of dose events where CT compliance was not achieved. Regulatory risk KPI — high counts trigger enforcement and process review."
    - name: "dbp_risk_event_count"
      expr: SUM(CASE WHEN dbp_formation_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dose events with elevated disinfection by-product formation risk. Public health and regulatory compliance KPI."
    - name: "avg_water_flow_rate_mgd"
      expr: AVG(CAST(water_flow_rate_mgd AS DOUBLE))
      comment: "Average water flow rate during dose events in MGD. Contextualizes chemical consumption relative to throughput."
    - name: "dose_event_count"
      expr: COUNT(1)
      comment: "Total number of chemical dose events. Baseline operational volume metric for normalizing cost and compliance KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_source_water_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over source water intake events. Tracks raw water quality, withdrawal volumes, permit compliance, and supply risk to support source water management and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`source_water_intake`"
  dimensions:
    - name: "source_type"
      expr: source_type
      comment: "Type of water source (e.g., surface water, groundwater, reservoir) for supply portfolio analysis."
    - name: "intake_status"
      expr: intake_status
      comment: "Operational status of the intake event (e.g., active, suspended, emergency) for availability analysis."
    - name: "intake_method"
      expr: intake_method
      comment: "Method used for water intake (e.g., gravity, pumped) for operational cost benchmarking."
    - name: "permit_compliance_status"
      expr: permit_compliance_status
      comment: "Compliance status relative to intake permit conditions. Regulatory risk dimension."
    - name: "source_water_alert_active"
      expr: source_water_alert_active
      comment: "Indicates whether a source water quality alert was active during the intake event. Drives treatment escalation decisions."
    - name: "source_water_protection_zone"
      expr: source_water_protection_zone
      comment: "Protection zone classification of the source water area. Informs risk-based source water management."
    - name: "intake_timestamp"
      expr: DATE_TRUNC('day', intake_timestamp)
      comment: "Date of the intake event, truncated to day for daily and seasonal trend analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during intake. Correlates with raw water quality variability and treatment demand."
  measures:
    - name: "total_volume_withdrawn_mg"
      expr: SUM(CAST(volume_withdrawn_mg AS DOUBLE))
      comment: "Total raw water volume withdrawn in million gallons. Core supply KPI for permit compliance and demand forecasting."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average intake flow rate in gallons per minute. Operational throughput KPI for pump and infrastructure capacity planning."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average raw water turbidity in NTU. Key raw water quality indicator — high turbidity increases treatment chemical demand and cost."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_ntu)
      comment: "Maximum raw water turbidity spike in NTU. Identifies worst-case raw water quality events requiring treatment escalation."
    - name: "avg_toc_mg_per_l"
      expr: AVG(CAST(toc_mg_per_l AS DOUBLE))
      comment: "Average total organic carbon in raw water (mg/L). Precursor to disinfection by-product formation — drives treatment strategy."
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average raw water pH. Influences coagulation chemistry and chemical dosing requirements."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average raw water temperature in Celsius. Affects disinfection efficacy (CT calculations) and seasonal treatment planning."
    - name: "avg_dissolved_oxygen_mg_per_l"
      expr: AVG(CAST(dissolved_oxygen_mg_per_l AS DOUBLE))
      comment: "Average dissolved oxygen in raw water (mg/L). Indicator of source water health and biological treatment demand."
    - name: "avg_algae_count_cells_per_ml"
      expr: AVG(CAST(algae_count_cells_per_ml AS DOUBLE))
      comment: "Average algae cell count in raw water (cells/mL). Elevated counts signal cyanotoxin risk and treatment escalation needs."
    - name: "permit_non_compliance_event_count"
      expr: SUM(CASE WHEN permit_compliance_status != 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of intake events where permit compliance was not achieved. Regulatory risk KPI with direct enforcement implications."
    - name: "source_water_alert_event_count"
      expr: SUM(CASE WHEN source_water_alert_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intake events with an active source water quality alert. Operational risk KPI for supply security management."
    - name: "intake_event_count"
      expr: COUNT(1)
      comment: "Total number of intake events. Baseline volume metric for normalizing quality and compliance KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_filter_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset performance KPI layer over treatment filter units. Tracks filtration efficiency, maintenance compliance, operational status, and capacity utilization to support asset management and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`filter_unit`"
  dimensions:
    - name: "filter_type"
      expr: filter_type
      comment: "Type of filter unit (e.g., rapid sand, slow sand, membrane) for technology-level performance benchmarking."
    - name: "filter_media_type"
      expr: filter_media_type
      comment: "Filter media material (e.g., anthracite, sand, GAC) for media-level performance and replacement analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the filter unit (e.g., online, offline, maintenance). Fleet availability dimension."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the filter unit. Drives maintenance scheduling and compliance decisions."
    - name: "filter_condition"
      expr: filter_condition
      comment: "Physical condition rating of the filter unit. Asset health dimension for capital replacement planning."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the filter unit is classified as critical infrastructure. Prioritizes maintenance and monitoring resources."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the filter unit instrumentation. Regulatory data quality dimension."
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility housing the filter unit. Enables facility-level fleet performance analysis."
  measures:
    - name: "avg_filter_efficiency_percent"
      expr: AVG(CAST(filter_efficiency_percent AS DOUBLE))
      comment: "Average filtration efficiency percentage across filter units. Core treatment performance KPI — declining efficiency signals media degradation or operational issues."
    - name: "min_filter_efficiency_percent"
      expr: MIN(filter_efficiency_percent)
      comment: "Minimum filter efficiency recorded. Identifies worst-performing units requiring immediate maintenance or replacement."
    - name: "avg_flow_rate_m3_per_hour"
      expr: AVG(CAST(flow_rate_m3_per_hour AS DOUBLE))
      comment: "Average actual flow rate through filter units (m³/hour). Throughput KPI for capacity utilization analysis."
    - name: "total_capacity_m3_per_hour"
      expr: SUM(CAST(capacity_m3_per_hour AS DOUBLE))
      comment: "Total design capacity of all filter units (m³/hour). Fleet capacity KPI for infrastructure planning."
    - name: "avg_pressure_drop_kpa"
      expr: AVG(CAST(pressure_drop_kpa AS DOUBLE))
      comment: "Average pressure drop across filter units (kPa). Elevated pressure drop indicates media fouling and drives backwash or replacement decisions."
    - name: "avg_compliance_ct_value_mg_per_l"
      expr: AVG(CAST(compliance_ct_value_mg_per_l AS DOUBLE))
      comment: "Average CT compliance value associated with filter units (mg·min/L). Regulatory disinfection credit KPI for filter-based CT calculations."
    - name: "total_asset_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total capital cost of filter unit assets in USD. Asset base KPI for depreciation, insurance, and capital planning."
    - name: "offline_unit_count"
      expr: SUM(CASE WHEN operational_status != 'Online' THEN 1 ELSE 0 END)
      comment: "Count of filter units not currently online. Fleet availability KPI — high counts reduce treatment capacity and increase compliance risk."
    - name: "overdue_maintenance_count"
      expr: SUM(CASE WHEN next_maintenance_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of filter units with overdue maintenance. Asset compliance KPI — overdue maintenance increases failure risk and regulatory exposure."
    - name: "critical_unit_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of filter units classified as critical infrastructure. Risk management KPI for prioritizing maintenance and redundancy investments."
    - name: "filter_unit_count"
      expr: COUNT(1)
      comment: "Total number of filter units in the fleet. Baseline asset count for normalizing performance and maintenance KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_process_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time and historical process monitoring KPI layer over treatment process readings. Tracks parameter compliance, exceedance rates, CT performance, and data quality to support operational control and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`process_reading`"
  dimensions:
    - name: "parameter_type"
      expr: parameter_type
      comment: "Type of process parameter measured (e.g., turbidity, chlorine, pH, CT) for parameter-level compliance analysis."
    - name: "process_stage"
      expr: process_stage
      comment: "Treatment process stage where the reading was taken (e.g., raw water, post-filtration, finished water)."
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Type of treatment process associated with the reading for process-level performance benchmarking."
    - name: "reading_status"
      expr: reading_status
      comment: "Status of the process reading (e.g., valid, suspect, rejected) for data quality filtering."
    - name: "is_regulatory_exceedance"
      expr: is_regulatory_exceedance
      comment: "Indicates whether the reading exceeded a regulatory limit. Core compliance dimension."
    - name: "dmr_reporting_flag"
      expr: dmr_reporting_flag
      comment: "Indicates whether the reading is required for Discharge Monitoring Report submission."
    - name: "is_manual_entry"
      expr: is_manual_entry
      comment: "Distinguishes manual entries from automated SCADA readings. Data quality and audit dimension."
    - name: "reading_date"
      expr: reading_date
      comment: "Date of the process reading for daily and monthly trend analysis."
    - name: "regulatory_limit_type"
      expr: regulatory_limit_type
      comment: "Type of regulatory limit applicable to the reading (e.g., MCL, action level, treatment technique) for compliance categorization."
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility where the reading was recorded. Enables facility-level compliance and process performance analysis."
  measures:
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured process parameter value. Central tendency KPI for process stability and compliance margin analysis."
    - name: "max_measured_value"
      expr: MAX(measured_value)
      comment: "Maximum measured process parameter value. Identifies worst-case readings for exceedance risk assessment."
    - name: "avg_ct_value"
      expr: AVG(CAST(ct_value AS DOUBLE))
      comment: "Average CT value recorded in process readings. Disinfection efficacy KPI for regulatory compliance tracking."
    - name: "avg_ct_required"
      expr: AVG(CAST(ct_required AS DOUBLE))
      comment: "Average CT value required by regulation. Paired with avg_ct_value to assess disinfection compliance margin."
    - name: "avg_regulatory_limit_value"
      expr: AVG(CAST(regulatory_limit_value AS DOUBLE))
      comment: "Average regulatory limit value applicable to readings. Contextualizes measured values against permitted thresholds."
    - name: "regulatory_exceedance_count"
      expr: SUM(CASE WHEN is_regulatory_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of process readings that exceeded a regulatory limit. Primary compliance risk KPI — drives enforcement and corrective action."
    - name: "dmr_reportable_reading_count"
      expr: SUM(CASE WHEN dmr_reporting_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readings flagged for DMR regulatory reporting. Compliance workload and reporting completeness KPI."
    - name: "data_quality_issue_count"
      expr: SUM(CASE WHEN quality_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of readings with data quality issues. Data integrity KPI — high counts undermine regulatory reporting reliability."
    - name: "process_reading_count"
      expr: COUNT(1)
      comment: "Total number of process readings. Baseline monitoring volume metric for coverage and data completeness assessment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory and compliance KPI layer over treatment permits. Tracks permit status, flow limit utilization, water quality limit thresholds, and renewal risk to support regulatory compliance management and enforcement risk mitigation."
  source: "`vibe_water_utilities_v1`.`treatment`.`treatment_permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the treatment permit (e.g., active, expired, under review). Core compliance posture dimension."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of treatment permit (e.g., NPDES, drinking water, surface water) for regulatory program segmentation."
    - name: "permit_category"
      expr: permit_category
      comment: "Category of the permit for grouping and compliance reporting purposes."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of the permit renewal process. Identifies permits at risk of lapsing without timely renewal."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility covered by the permit (e.g., surface water treatment plant, groundwater facility)."
    - name: "compliance_schedule_flag"
      expr: compliance_schedule_flag
      comment: "Indicates whether the permit includes a compliance schedule. Signals facilities under active regulatory scrutiny."
    - name: "pfas_monitoring_required"
      expr: pfas_monitoring_required
      comment: "Indicates whether PFAS monitoring is required under the permit. Emerging contaminant compliance dimension."
    - name: "npdes_major_minor_class"
      expr: npdes_major_minor_class
      comment: "NPDES permit classification (major or minor discharger). Determines regulatory oversight intensity."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Permit expiration date for renewal timeline management and lapse risk identification."
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility covered by the permit. Enables facility-level permit portfolio analysis."
  measures:
    - name: "avg_permitted_flow_mgd"
      expr: AVG(CAST(permitted_flow_mgd AS DOUBLE))
      comment: "Average permitted peak flow limit in MGD across permits. Capacity constraint KPI for infrastructure planning."
    - name: "avg_permitted_avg_flow_mgd"
      expr: AVG(CAST(permitted_avg_flow_mgd AS DOUBLE))
      comment: "Average permitted average daily flow in MGD. Baseline for assessing flow utilization against permit limits."
    - name: "avg_turbidity_limit_ntu"
      expr: AVG(CAST(turbidity_limit_ntu AS DOUBLE))
      comment: "Average permitted turbidity limit in NTU across permits. Regulatory stringency KPI for treatment process design."
    - name: "avg_ct_requirement_mg_min_l"
      expr: AVG(CAST(ct_requirement_mg_min_l AS DOUBLE))
      comment: "Average CT requirement in mg·min/L across permits. Disinfection compliance baseline for treatment process adequacy assessment."
    - name: "avg_chlorine_residual_limit_mg_l"
      expr: AVG(CAST(chlorine_residual_limit_mg_l AS DOUBLE))
      comment: "Average permitted chlorine residual limit in mg/L. Disinfection compliance threshold KPI."
    - name: "avg_tthm_mcl_ug_l"
      expr: AVG(CAST(tthm_mcl_ug_l AS DOUBLE))
      comment: "Average TTHM maximum contaminant level in µg/L across permits. Disinfection by-product regulatory limit KPI."
    - name: "avg_haa5_mcl_ug_l"
      expr: AVG(CAST(haa5_mcl_ug_l AS DOUBLE))
      comment: "Average HAA5 maximum contaminant level in µg/L across permits. Disinfection by-product regulatory limit KPI."
    - name: "expiring_permit_count"
      expr: SUM(CASE WHEN expiration_date <= ADD_MONTHS(CURRENT_DATE(), 6) THEN 1 ELSE 0 END)
      comment: "Count of permits expiring within the next 6 months. Renewal urgency KPI — lapsed permits create immediate regulatory and operational risk."
    - name: "active_violation_permit_count"
      expr: SUM(CASE WHEN CAST(violation_count_active AS INT) > 0 THEN 1 ELSE 0 END)
      comment: "Count of permits with one or more active violations. Regulatory enforcement risk KPI requiring executive attention."
    - name: "compliance_schedule_permit_count"
      expr: SUM(CASE WHEN compliance_schedule_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of permits with active compliance schedules. Indicates facilities under heightened regulatory oversight."
    - name: "pfas_monitoring_permit_count"
      expr: SUM(CASE WHEN pfas_monitoring_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of permits requiring PFAS monitoring. Emerging contaminant compliance exposure KPI for regulatory risk management."
    - name: "permit_count"
      expr: COUNT(1)
      comment: "Total number of treatment permits. Baseline portfolio metric for regulatory compliance program scope."
$$;