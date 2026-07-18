-- Metric views for domain: transmission | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_atc_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key ATC capacity metrics for transmission planning and reliability"
  source: "`energy_utilities_ecm`.`transmission`.`atc_calculation`"
  dimensions:
    - name: "path_id"
      expr: path_id
      comment: "Identifier of the transmission path associated with the ATC calculation"
    - name: "calculation_type"
      expr: calculation_type
      comment: "Methodology type of the ATC calculation"
    - name: "rto_iso_region"
      expr: rto_iso_region
      comment: "Regional transmission organization ISO/RTO region"
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_timestamp)
      comment: "Month of the ATC calculation"
  measures:
    - name: "total_atc_mw"
      expr: SUM(CAST(atc_mw AS DOUBLE))
      comment: "Total Available Transfer Capability (ATC) in megawatts across all calculations"
    - name: "total_firm_atc_mw"
      expr: SUM(CAST(firm_atc_mw AS DOUBLE))
      comment: "Sum of firm (non‑contingent) ATC MW"
    - name: "total_non_firm_atc_mw"
      expr: SUM(CAST(non_firm_atc_mw AS DOUBLE))
      comment: "Sum of non‑firm ATC MW"
    - name: "average_atc_mw"
      expr: AVG(CAST(atc_mw AS DOUBLE))
      comment: "Average ATC MW per calculation record"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of ATC calculation records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_congestion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational impact of transmission congestion events"
  source: "`energy_utilities_ecm`.`transmission`.`congestion_event`"
  dimensions:
    - name: "path_id"
      expr: path_id
      comment: "Path identifier where congestion occurred"
    - name: "rto_iso_region"
      expr: rto_iso_region
      comment: "ISO/RTO region of the congestion event"
    - name: "market_type"
      expr: market_type
      comment: "Market type (e.g., day‑ahead, real‑time)"
    - name: "congestion_month"
      expr: DATE_TRUNC('month', congestion_start_timestamp)
      comment: "Month when congestion started"
  measures:
    - name: "total_congestion_events"
      expr: COUNT(1)
      comment: "Count of congestion events recorded"
    - name: "total_congestion_cost_usd"
      expr: SUM(CAST(congestion_cost_usd AS DOUBLE))
      comment: "Aggregate cost of congestion in USD"
    - name: "total_curtailed_mw"
      expr: SUM(CAST(curtailed_mw AS DOUBLE))
      comment: "Total megawatts curtailed due to congestion"
    - name: "average_congestion_cost_usd"
      expr: AVG(CAST(congestion_cost_usd AS DOUBLE))
      comment: "Average cost per congestion event"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_path`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core capacity and efficiency metrics for transmission paths"
  source: "`energy_utilities_ecm`.`transmission`.`path`"
  dimensions:
    - name: "path_type"
      expr: path_type
      comment: "Classification of the transmission path (e.g., interstate, intrastate)"
    - name: "voltage_level_kv"
      expr: voltage_level_kv
      comment: "Nominal voltage level of the path in kV"
    - name: "creation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the path record was created"
  measures:
    - name: "total_paths"
      expr: COUNT(1)
      comment: "Number of transmission paths"
    - name: "total_transfer_capacity_mw"
      expr: SUM(CAST(total_transfer_capability_mw AS DOUBLE))
      comment: "Sum of total transfer capability across all paths"
    - name: "total_available_transfer_mw"
      expr: SUM(CAST(available_transfer_capability_mw AS DOUBLE))
      comment: "Sum of available transfer capability"
    - name: "average_loss_factor_percent"
      expr: AVG(CAST(average_loss_factor_percent AS DOUBLE))
      comment: "Average loss factor percentage across paths"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_outage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability and service continuity metrics for transmission outages"
  source: "`energy_utilities_ecm`.`transmission`.`transmission_outage`"
  dimensions:
    - name: "outage_type"
      expr: outage_type
      comment: "Classification of outage (e.g., forced, scheduled)"
    - name: "rto_iso_region"
      expr: rto_iso_region
      comment: "ISO/RTO region where outage occurred"
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code for the outage"
    - name: "outage_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month when outage started"
  measures:
    - name: "total_outages"
      expr: COUNT(1)
      comment: "Total number of transmission outages"
    - name: "total_mw_impact"
      expr: SUM(CAST(mw_impact AS DOUBLE))
      comment: "Aggregate megawatt impact of outages"
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Cumulative outage duration in hours"
    - name: "total_load_shed_mw"
      expr: SUM(CAST(load_shed_mw AS DOUBLE))
      comment: "Total megawatts of load shed due to outages"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial terms and capacity commitments in transmission service agreements"
  source: "`energy_utilities_ecm`.`transmission`.`transmission_service_agreement`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service (e.g., firm, non‑firm)"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement"
    - name: "rto_iso_region"
      expr: rto_iso_region
      comment: "ISO/RTO region of the agreement"
    - name: "agreement_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the agreement was created"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Count of active transmission service agreements"
    - name: "total_contracted_capacity_mw"
      expr: SUM(CAST(contracted_capacity_mw AS DOUBLE))
      comment: "Sum of contracted capacity across agreements"
    - name: "average_energy_charge_rate_usd_per_mwh"
      expr: AVG(CAST(energy_charge_rate_usd_per_mwh AS DOUBLE))
      comment: "Average energy charge rate per MWh"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_planning_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic planning metrics for transmission expansion and upgrades"
  source: "`energy_utilities_ecm`.`transmission`.`planning_study`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Category of planning study (e.g., feasibility, detailed)"
    - name: "rto_iso_region"
      expr: rto_iso_region
      comment: "ISO/RTO region covered by the study"
    - name: "planning_horizon_year"
      expr: planning_horizon_year
      comment: "Target planning horizon year"
    - name: "study_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the study record was created"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Number of transmission planning studies"
    - name: "total_estimated_capex_usd"
      expr: SUM(CAST(estimated_capex_usd AS DOUBLE))
      comment: "Aggregate estimated capital expenditure for studies"
    - name: "average_generation_additions_mw"
      expr: AVG(CAST(generation_additions_mw AS DOUBLE))
      comment: "Average planned generation additions per study"
$$;
