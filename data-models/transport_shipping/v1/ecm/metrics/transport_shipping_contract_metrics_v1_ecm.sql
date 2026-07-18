-- Metric views for domain: contract | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core contract agreement metrics tracking portfolio health, SLA targets, volume commitments, and financial exposure across the contract lifecycle."
  source: "`transport_shipping_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g., active, expired, terminated, draft)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Classification of agreement (e.g., master service agreement, spot, framework)"
    - name: "contract_tier"
      expr: contract_tier
      comment: "Strategic tier classification of the contract (e.g., platinum, gold, silver)"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial term governing delivery obligations"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the agreement"
    - name: "governing_jurisdiction"
      expr: governing_jurisdiction
      comment: "Legal jurisdiction governing the contract"
    - name: "auto_renewal_flag"
      expr: CAST(auto_renewal_flag AS STRING)
      comment: "Whether the agreement auto-renews at expiry"
    - name: "insurance_required_flag"
      expr: CAST(insurance_required_flag AS STRING)
      comment: "Whether insurance coverage is mandated under the agreement"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the agreement became effective"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of contract agreements in the portfolio"
    - name: "avg_sla_otd_target_percent"
      expr: AVG(CAST(sla_otd_target_percent AS DOUBLE))
      comment: "Average on-time delivery SLA target percentage across agreements"
    - name: "avg_sla_otif_target_percent"
      expr: AVG(CAST(sla_otif_target_percent AS DOUBLE))
      comment: "Average on-time-in-full SLA target percentage across agreements"
    - name: "total_volume_commitment_teu"
      expr: SUM(CAST(volume_commitment_teu AS DOUBLE))
      comment: "Total contracted volume commitment in TEU across all agreements"
    - name: "total_volume_commitment_weight_kg"
      expr: SUM(CAST(volume_commitment_weight_kg AS DOUBLE))
      comment: "Total contracted volume commitment in kilograms across all agreements"
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit exposure across all agreements"
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per agreement indicating financial exposure per contract"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers under contract, indicating network breadth"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA performance measurement metrics tracking attainment, breaches, penalties, and incentives to monitor contractual service quality compliance."
  source: "`transport_shipping_ecm`.`contract`.`sla_performance`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the SLA measurement (e.g., confirmed, pending, disputed)"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of SLA measurement (e.g., OTD, OTIF, transit time)"
    - name: "measurement_category"
      expr: measurement_category
      comment: "Category grouping of the SLA metric being measured"
    - name: "breach_flag"
      expr: CAST(breach_flag AS STRING)
      comment: "Whether the SLA target was breached in this measurement period"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the SLA breach (e.g., minor, major, critical)"
    - name: "service_type"
      expr: service_type
      comment: "Type of logistics service being measured (e.g., express, standard, freight)"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm applicable to the measured shipments"
    - name: "penalty_applicable_flag"
      expr: CAST(penalty_applicable_flag AS STRING)
      comment: "Whether a penalty clause applies to this SLA measurement"
    - name: "incentive_applicable_flag"
      expr: CAST(incentive_applicable_flag AS STRING)
      comment: "Whether an incentive clause applies to this SLA measurement"
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the SLA measurement result is under dispute"
    - name: "measurement_period_month"
      expr: DATE_TRUNC('month', measurement_period_start_date)
      comment: "Month of the SLA measurement period start"
  measures:
    - name: "total_sla_measurements"
      expr: COUNT(1)
      comment: "Total number of SLA performance measurement records"
    - name: "avg_attainment_percentage"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average SLA attainment percentage across all measurements — key indicator of service quality"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured SLA value across all records"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value for benchmarking against actuals"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty amount incurred from SLA breaches"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total financial incentive amount earned from exceeding SLA targets"
    - name: "avg_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average variance between actual and target SLA values — negative indicates underperformance"
    - name: "distinct_breached_agreements"
      expr: COUNT(DISTINCT CASE WHEN breach_flag = true THEN agreement_id END)
      comment: "Number of distinct agreements with at least one SLA breach"
    - name: "distinct_carriers_measured"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with SLA performance measurements"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_volume_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume commitment attainment metrics tracking actual vs committed volumes, shortfalls, surpluses, and associated financial impacts (penalties/incentives)."
  source: "`transport_shipping_ecm`.`contract`.`volume_actuals`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of volume commitment (e.g., compliant, non-compliant, at-risk)"
    - name: "record_status"
      expr: record_status
      comment: "Processing status of the volume actuals record"
    - name: "period_type"
      expr: period_type
      comment: "Measurement period granularity (e.g., monthly, quarterly, annual)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., ocean, air, road, rail)"
    - name: "service_level"
      expr: service_level
      comment: "Service level tier for the volume measurement"
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane corridor for the volume measurement"
    - name: "origin_region"
      expr: origin_region
      comment: "Origin region of the shipped volume"
    - name: "destination_region"
      expr: destination_region
      comment: "Destination region of the shipped volume"
    - name: "shortfall_flag"
      expr: CAST(shortfall_flag AS STRING)
      comment: "Whether actual volume fell below committed minimum"
    - name: "surplus_flag"
      expr: CAST(surplus_flag AS STRING)
      comment: "Whether actual volume exceeded committed maximum"
    - name: "measurement_period_month"
      expr: DATE_TRUNC('month', measurement_period_start_date)
      comment: "Month of the volume measurement period"
  measures:
    - name: "total_volume_records"
      expr: COUNT(1)
      comment: "Total number of volume actuals measurement records"
    - name: "total_actual_volume_shipped"
      expr: SUM(CAST(actual_volume_shipped AS DOUBLE))
      comment: "Total actual volume shipped across all commitments"
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total committed volume across all agreements"
    - name: "total_volume_variance"
      expr: SUM(CAST(volume_variance AS DOUBLE))
      comment: "Net volume variance (actual minus committed) — negative indicates shortfall"
    - name: "avg_attainment_percentage"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average volume commitment attainment percentage — key indicator of contract fulfillment"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount triggered by volume shortfalls"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount earned from volume surplus performance"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to volume measurements"
    - name: "distinct_agreements_measured"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements with volume actuals recorded"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_penalty_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Penalty event metrics tracking financial exposure from contract breaches, dispute rates, waiver patterns, and resolution effectiveness."
  source: "`transport_shipping_ecm`.`contract`.`penalty_event`"
  dimensions:
    - name: "penalty_event_status"
      expr: penalty_event_status
      comment: "Current status of the penalty event (e.g., pending, approved, disputed, waived)"
    - name: "event_type"
      expr: event_type
      comment: "Classification of the penalty event trigger type"
    - name: "trigger_category"
      expr: trigger_category
      comment: "Root cause category that triggered the penalty (e.g., late delivery, damage, volume shortfall)"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the penalty amount (e.g., flat rate, percentage, tiered)"
    - name: "party_type"
      expr: party_type
      comment: "Party responsible for the penalty (e.g., carrier, shipper, consignee)"
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the penalty event is under dispute"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the penalty amounts"
    - name: "sla_metric_code"
      expr: sla_metric_code
      comment: "SLA metric code that was breached triggering the penalty"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month when the penalty event occurred"
  measures:
    - name: "total_penalty_events"
      expr: COUNT(1)
      comment: "Total number of penalty events recorded"
    - name: "total_calculated_amount"
      expr: SUM(CAST(calculated_amount AS DOUBLE))
      comment: "Total calculated penalty amount before adjustments and waivers"
    - name: "total_final_amount"
      expr: SUM(CAST(final_amount AS DOUBLE))
      comment: "Total final penalty amount after adjustments, waivers, and disputes"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to penalty calculations"
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base penalty amounts before calculation method applied"
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate AS DOUBLE))
      comment: "Average penalty rate applied across events"
    - name: "distinct_agreements_penalized"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements that incurred penalty events"
    - name: "distinct_carriers_penalized"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers that incurred penalty events"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract dispute metrics tracking dispute volumes, financial exposure, resolution effectiveness, and escalation patterns for contract governance."
  source: "`transport_shipping_ecm`.`contract`.`contract_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, under review, resolved, closed)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Classification of the dispute (e.g., billing, SLA breach, damage, volume)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the dispute (e.g., critical, high, medium, low)"
    - name: "resolution_method"
      expr: resolution_method
      comment: "Method used to resolve the dispute (e.g., negotiation, mediation, arbitration)"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the dispute resolution (e.g., settled, withdrawn, escalated)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification of the dispute"
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether the dispute was escalated beyond initial resolution path"
    - name: "raised_by_party"
      expr: raised_by_party
      comment: "Party that raised the dispute (e.g., shipper, carrier, customer)"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm applicable to the disputed transaction"
    - name: "governing_jurisdiction"
      expr: governing_jurisdiction
      comment: "Legal jurisdiction governing the dispute"
    - name: "dispute_month"
      expr: DATE_TRUNC('month', dispute_date)
      comment: "Month when the dispute was raised"
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of contract disputes raised"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total monetary value of all disputed amounts"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid to resolve disputes"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact AS DOUBLE))
      comment: "Total financial impact of disputes on the business"
    - name: "total_penalty_waived_amount"
      expr: SUM(CAST(penalty_waived_amount AS DOUBLE))
      comment: "Total penalty amounts waived during dispute resolution"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute — indicates typical dispute magnitude"
    - name: "distinct_agreements_disputed"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements with active disputes"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_carrier_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier agreement portfolio metrics tracking contracted capacity, financial terms, SLA commitments, and carrier network coverage."
  source: "`transport_shipping_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the carrier agreement (e.g., active, expired, terminated)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the carrier agreement"
    - name: "auto_renewal_flag"
      expr: CAST(auto_renewal_flag AS STRING)
      comment: "Whether the carrier agreement auto-renews"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the carrier agreement became effective"
  measures:
    - name: "total_carrier_agreements"
      expr: COUNT(1)
      comment: "Total number of carrier agreements in the portfolio"
    - name: "avg_sla_otd_target_percent"
      expr: AVG(CAST(sla_otd_target_percent AS DOUBLE))
      comment: "Average on-time delivery SLA target across carrier agreements"
    - name: "avg_sla_otif_target_percent"
      expr: AVG(CAST(sla_otif_target_percent AS DOUBLE))
      comment: "Average on-time-in-full SLA target across carrier agreements"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers under agreement"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_volume_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume commitment tracking metrics measuring contracted targets, actual fulfillment, utilization rates, and financial incentive/penalty exposure."
  source: "`transport_shipping_ecm`.`contract`.`contract_volume_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the volume commitment (e.g., active, fulfilled, breached)"
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of volume commitment (e.g., minimum, target, maximum)"
    - name: "commitment_period"
      expr: commitment_period
      comment: "Period granularity of the commitment (e.g., monthly, quarterly, annual)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the volume commitment"
    - name: "service_type"
      expr: service_type
      comment: "Service type covered by the volume commitment"
    - name: "volume_unit"
      expr: volume_unit
      comment: "Unit of measure for volume (e.g., TEU, kg, cbm)"
    - name: "commitment_party_type"
      expr: commitment_party_type
      comment: "Party responsible for fulfilling the volume commitment"
    - name: "rollover_allowed_flag"
      expr: CAST(rollover_allowed_flag AS STRING)
      comment: "Whether unfulfilled volume can roll over to next period"
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How frequently the commitment is measured"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the volume commitment became effective"
  measures:
    - name: "total_commitments"
      expr: COUNT(1)
      comment: "Total number of volume commitment records"
    - name: "total_target_volume"
      expr: SUM(CAST(target_volume AS DOUBLE))
      comment: "Total target volume across all commitments"
    - name: "total_actual_volume"
      expr: SUM(CAST(actual_volume AS DOUBLE))
      comment: "Total actual volume delivered against commitments"
    - name: "total_minimum_volume"
      expr: SUM(CAST(minimum_volume AS DOUBLE))
      comment: "Total minimum volume thresholds across all commitments"
    - name: "total_maximum_volume"
      expr: SUM(CAST(maximum_volume AS DOUBLE))
      comment: "Total maximum volume caps across all commitments"
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average utilization percentage of volume commitments — key capacity efficiency indicator"
    - name: "total_rollover_volume"
      expr: SUM(CAST(rollover_volume AS DOUBLE))
      comment: "Total volume rolled over from prior periods"
    - name: "total_shortfall_penalty_rate"
      expr: SUM(CAST(shortfall_penalty_rate AS DOUBLE))
      comment: "Total shortfall penalty rate exposure across commitments"
    - name: "total_excess_incentive_rate"
      expr: SUM(CAST(excess_incentive_rate AS DOUBLE))
      comment: "Total excess incentive rate opportunity across commitments"
    - name: "distinct_agreements"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements with volume commitments"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_renewal_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract renewal event metrics tracking renewal outcomes, rate changes, performance-based decisions, and portfolio continuity."
  source: "`transport_shipping_ecm`.`contract`.`renewal_event`"
  dimensions:
    - name: "renewal_outcome"
      expr: renewal_outcome
      comment: "Outcome of the renewal decision (e.g., renewed, terminated, renegotiated)"
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (e.g., auto, manual, competitive rebid)"
    - name: "renewal_approval_status"
      expr: renewal_approval_status
      comment: "Approval status of the renewal (e.g., approved, pending, rejected)"
    - name: "auto_renewal_flag"
      expr: CAST(auto_renewal_flag AS STRING)
      comment: "Whether this was an automatic renewal"
    - name: "prior_contract_performance_rating"
      expr: prior_contract_performance_rating
      comment: "Performance rating of the prior contract term informing renewal decision"
    - name: "competitive_bid_conducted_flag"
      expr: CAST(competitive_bid_conducted_flag AS STRING)
      comment: "Whether a competitive bid was conducted before renewal"
    - name: "sla_change_flag"
      expr: CAST(sla_change_flag AS STRING)
      comment: "Whether SLA terms changed during renewal"
    - name: "volume_commitment_change_flag"
      expr: CAST(volume_commitment_change_flag AS STRING)
      comment: "Whether volume commitments changed during renewal"
    - name: "renewal_year"
      expr: YEAR(renewal_effective_date)
      comment: "Year the renewed contract becomes effective"
  measures:
    - name: "total_renewal_events"
      expr: COUNT(1)
      comment: "Total number of contract renewal events"
    - name: "avg_rate_change_percentage"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average rate change percentage at renewal — indicates pricing trend direction"
    - name: "total_contract_value_change"
      expr: SUM(CAST(contract_value_change_amount AS DOUBLE))
      comment: "Total net change in contract value from renewals"
    - name: "avg_otd_compliance_percentage"
      expr: AVG(CAST(otd_compliance_percentage AS DOUBLE))
      comment: "Average OTD compliance percentage of contracts at renewal — indicates service quality trend"
    - name: "avg_otif_compliance_percentage"
      expr: AVG(CAST(otif_compliance_percentage AS DOUBLE))
      comment: "Average OTIF compliance percentage of contracts at renewal"
    - name: "distinct_agreements_renewed"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements that went through renewal"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate schedule metrics tracking contracted pricing, surcharge exposure, and rate structure across the logistics network."
  source: "`transport_shipping_ecm`.`contract`.`rate_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the rate schedule (e.g., active, expired, pending approval)"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of rate schedule (e.g., contract, spot, promotional)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate schedule"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport the rate applies to"
    - name: "service_type"
      expr: service_type
      comment: "Service type the rate applies to (e.g., FCL, LCL, express)"
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for rate calculation (e.g., per kg, per TEU, per shipment)"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm applicable to the rate schedule"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate schedule"
    - name: "origin_zone"
      expr: origin_zone
      comment: "Origin zone for the rate schedule"
    - name: "destination_zone"
      expr: destination_zone
      comment: "Destination zone for the rate schedule"
    - name: "fuel_surcharge_applicable"
      expr: CAST(fuel_surcharge_applicable AS STRING)
      comment: "Whether fuel surcharge applies to this rate schedule"
  measures:
    - name: "total_rate_schedules"
      expr: COUNT(1)
      comment: "Total number of rate schedules"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across all schedules — key pricing benchmark"
    - name: "total_base_rate_value"
      expr: SUM(CAST(base_rate AS DOUBLE))
      comment: "Sum of base rates for aggregate pricing analysis"
    - name: "avg_fuel_surcharge_rate"
      expr: AVG(CAST(fuel_surcharge_rate AS DOUBLE))
      comment: "Average fuel surcharge rate across applicable schedules"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge floor across rate schedules"
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum charge cap across rate schedules"
    - name: "avg_peak_season_surcharge_rate"
      expr: AVG(CAST(peak_season_surcharge_rate AS DOUBLE))
      comment: "Average peak season surcharge rate indicating seasonal cost pressure"
    - name: "distinct_carriers_rated"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with rate schedules"
    - name: "distinct_agreements_rated"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements with rate schedules"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation metrics tracking regulatory adherence, verification status, penalty exposure, and compliance scoring across the contract portfolio."
  source: "`transport_shipping_ecm`.`contract`.`compliance_obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the compliance obligation (e.g., active, fulfilled, overdue)"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., regulatory, environmental, safety, customs)"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard or framework (e.g., ISO, IATA, IMO, C-TPAT)"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing the obligation"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify compliance (e.g., audit, self-certification, third-party)"
    - name: "verification_frequency"
      expr: verification_frequency
      comment: "How frequently compliance is verified"
    - name: "certification_required_flag"
      expr: CAST(certification_required_flag AS STRING)
      comment: "Whether formal certification is required"
    - name: "waiver_granted_flag"
      expr: CAST(waiver_granted_flag AS STRING)
      comment: "Whether a compliance waiver has been granted"
    - name: "training_required_flag"
      expr: CAST(training_required_flag AS STRING)
      comment: "Whether training is required for this obligation"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations tracked"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all obligations — key governance health indicator"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount exposure from non-compliance"
    - name: "distinct_agreements_with_obligations"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements with compliance obligations"
    - name: "distinct_suppliers_obligated"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with compliance obligations"
$$;
