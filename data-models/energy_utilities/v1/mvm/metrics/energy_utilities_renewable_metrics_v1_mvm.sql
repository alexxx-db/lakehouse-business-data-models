-- Metric views for domain: renewable | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_battery_storage_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance and cost metrics for battery storage assets"
  source: "`energy_utilities_ecm`.`renewable`.`battery_storage_asset`"
  dimensions:
    - name: "asset_name"
      expr: asset_name
      comment: "Descriptive name of the battery asset"
    - name: "storage_technology_type"
      expr: storage_technology_type
      comment: "Technology type of the storage system (e.g., Li‑ion, flow)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (e.g., utility‑owned, third‑party)"
    - name: "commissioning_date"
      expr: commissioning_date
      comment: "Date the asset was commissioned"
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of battery storage assets"
    - name: "total_rated_energy_capacity_mwh"
      expr: SUM(CAST(rated_energy_capacity_mwh AS DOUBLE))
      comment: "Total rated energy capacity across all battery assets (MWh)"
    - name: "average_round_trip_efficiency_percent"
      expr: AVG(CAST(round_trip_efficiency_percent AS DOUBLE))
      comment: "Average round‑trip efficiency of battery assets (%)"
    - name: "total_capital_cost_usd"
      expr: SUM(CAST(capital_cost_usd AS DOUBLE))
      comment: "Total capital cost invested in battery storage assets (USD)"
    - name: "average_current_state_of_charge_percent"
      expr: AVG(CAST(current_soc_percent AS DOUBLE))
      comment: "Average current state‑of‑charge across assets (%)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_curtailment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial impact of curtailment events"
  source: "`energy_utilities_ecm`.`renewable`.`curtailment_event`"
  dimensions:
    - name: "curtailment_type"
      expr: curtailment_type
      comment: "Classification of curtailment (e.g., market, reliability)"
    - name: "curtailment_reason_description"
      expr: curtailment_reason_description
      comment: "Narrative reason for curtailment"
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO jurisdiction code"
    - name: "curtailment_status"
      expr: curtailment_status
      comment: "Current status of the curtailment event"
    - name: "curtailment_start_timestamp"
      expr: curtailment_start_timestamp
      comment: "Timestamp when curtailment began"
  measures:
    - name: "curtailment_event_count"
      expr: COUNT(1)
      comment: "Number of curtailment events"
    - name: "total_curtailed_capacity_mw"
      expr: SUM(CAST(curtailed_capacity_mw AS DOUBLE))
      comment: "Sum of capacity curtailed during events (MW)"
    - name: "total_curtailed_energy_mwh"
      expr: SUM(CAST(curtailed_energy_mwh AS DOUBLE))
      comment: "Total energy curtailed across events (MWh)"
    - name: "average_curtailment_duration_minutes"
      expr: AVG(CAST(curtailment_duration_minutes AS DOUBLE))
      comment: "Average duration of curtailment events (minutes)"
    - name: "total_curtailment_credit_amount_usd"
      expr: SUM(CAST(curtailment_credit_amount_usd AS DOUBLE))
      comment: "Total monetary credit awarded for curtailments (USD)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_generation_meter_read`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation performance and curtailment visibility from meter reads"
  source: "`energy_utilities_ecm`.`renewable`.`generation_meter_read`"
  dimensions:
    - name: "der_registry_id"
      expr: der_registry_id
      comment: "DER registry identifier for the generating asset"
    - name: "meter_id"
      expr: meter_id
      comment: "Meter identifier used for the read"
    - name: "read_timestamp"
      expr: read_timestamp
      comment: "Timestamp of the meter reading"
  measures:
    - name: "meter_read_count"
      expr: COUNT(1)
      comment: "Number of generation meter reads recorded"
    - name: "total_gross_generation_kwh"
      expr: SUM(CAST(gross_generation_kwh AS DOUBLE))
      comment: "Total gross generation recorded (kWh)"
    - name: "total_net_generation_kwh"
      expr: SUM(CAST(net_generation_kwh AS DOUBLE))
      comment: "Total net generation after curtailment (kWh)"
    - name: "average_capacity_factor_percent"
      expr: AVG(CAST(capacity_factor_percent AS DOUBLE))
      comment: "Average capacity factor across reads (%)"
    - name: "total_curtailed_energy_kwh"
      expr: SUM(CAST(curtailed_energy_kwh AS DOUBLE))
      comment: "Total energy curtailed as recorded in meter reads (kWh)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_ppa_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and capacity commitments of Power Purchase Agreements"
  source: "`energy_utilities_ecm`.`renewable`.`ppa_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g., active, terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., fixed‑price, indexed)"
    - name: "contract_name"
      expr: contract_name
      comment: "Human‑readable name of the contract"
    - name: "contract_execution_date"
      expr: contract_execution_date
      comment: "Date the contract was executed"
  measures:
    - name: "ppa_contract_count"
      expr: COUNT(1)
      comment: "Number of Power Purchase Agreements"
    - name: "total_contracted_capacity_mw"
      expr: SUM(CAST(contracted_capacity_mw AS DOUBLE))
      comment: "Aggregate contracted capacity across all PPAs (MW)"
    - name: "total_contracted_energy_mwh_annual"
      expr: SUM(CAST(contracted_energy_volume_mwh_annual AS DOUBLE))
      comment: "Total annual energy volume contracted (MWh)"
    - name: "average_base_price_per_mwh"
      expr: AVG(CAST(base_price_per_mwh AS DOUBLE))
      comment: "Average base price across PPAs (USD per MWh)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_rec_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value and volume of Renewable Energy Certificates"
  source: "`energy_utilities_ecm`.`renewable`.`renewable_rec_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate (e.g., active, retired)"
    - name: "technology_type"
      expr: technology_type
      comment: "Technology class of the underlying asset (e.g., solar, wind)"
    - name: "compliance_year"
      expr: compliance_year
      comment: "Regulatory compliance year for the certificate"
    - name: "issuance_date"
      expr: issuance_date
      comment: "Date the certificate was issued"
  measures:
    - name: "rec_certificate_count"
      expr: COUNT(1)
      comment: "Number of Renewable Energy Certificates issued"
    - name: "total_market_value_usd"
      expr: SUM(CAST(market_value_usd AS DOUBLE))
      comment: "Aggregate market value of issued RECs (USD)"
    - name: "total_generation_mwh"
      expr: SUM(CAST(generation_mwh AS DOUBLE))
      comment: "Total generation represented by RECs (MWh)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_vpp_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial overview of Virtual Power Plant configurations"
  source: "`energy_utilities_ecm`.`renewable`.`vpp_configuration`"
  dimensions:
    - name: "vpp_status"
      expr: vpp_status
      comment: "Operational status of the VPP (e.g., active, inactive)"
    - name: "vpp_name"
      expr: vpp_name
      comment: "Descriptive name of the VPP configuration"
    - name: "dispatch_protocol"
      expr: dispatch_protocol
      comment: "Dispatch protocol used by the VPP"
    - name: "geographic_zone"
      expr: geographic_zone
      comment: "Geographic zone or region of the VPP"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the VPP configuration was created"
  measures:
    - name: "vpp_configuration_count"
      expr: COUNT(1)
      comment: "Number of VPP configurations defined"
    - name: "total_aggregated_capacity_mw"
      expr: SUM(CAST(total_aggregated_capacity_mw AS DOUBLE))
      comment: "Combined capacity of all DERs in the VPP (MW)"
    - name: "average_performance_score"
      expr: AVG(CAST(average_performance_score AS DOUBLE))
      comment: "Average performance score across VPP configurations"
    - name: "total_capacity_payment_rate_per_mw_month"
      expr: SUM(CAST(capacity_payment_rate_per_mw_month AS DOUBLE))
      comment: "Total capacity payment rate across VPPs (USD per MW‑month)"
$$;
