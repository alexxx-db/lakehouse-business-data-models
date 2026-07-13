-- Metric views for domain: compliance | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for compliance audits covering audit outcomes, PSC inspection results, corrective action tracking, and audit cost efficiency. Used by the Chief Compliance Officer and Port Authority leadership to steer audit programmes and regulatory standing."
  source: "`vibe_shipping_ports_v1`.`compliance`.`compliance_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit (e.g., ISPS, MARPOL, PSC, internal) for segmenting audit performance by programme."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g., planned, in-progress, closed) for pipeline visibility."
    - name: "overall_audit_outcome"
      expr: overall_audit_outcome
      comment: "Final outcome of the audit (e.g., satisfactory, unsatisfactory, conditional) for pass/fail analysis."
    - name: "auditing_body_type"
      expr: auditing_body_type
      comment: "Category of auditing body (e.g., flag state, classification society, port state control) to distinguish internal vs external audits."
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit (e.g., vessel, facility, process) for drill-down analysis."
    - name: "psc_inspection_flag"
      expr: psc_inspection_flag
      comment: "Indicates whether the audit was a Port State Control inspection, enabling PSC-specific KPI filtering."
    - name: "detention_issued_flag"
      expr: detention_issued_flag
      comment: "Indicates whether a vessel detention was issued as a result of the audit — a critical regulatory risk signal."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Flags audits requiring follow-up, used to track unresolved compliance gaps."
    - name: "regulatory_framework"
      expr: audit_type
      comment: "Regulatory framework dimension derived from audit type for grouping by SOLAS, MARPOL, ISPS, etc."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of audit start date for trend analysis over time."
    - name: "start_date_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year of audit start date for annual compliance programme reporting."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted. Baseline volume metric for audit programme throughput."
    - name: "psc_detention_rate_numerator"
      expr: COUNT(CASE WHEN detention_issued_flag = TRUE THEN 1 END)
      comment: "Count of audits resulting in vessel detention. Used with total_psc_inspections to compute PSC detention rate — a primary regulatory risk KPI."
    - name: "total_psc_inspections"
      expr: COUNT(CASE WHEN psc_inspection_flag = TRUE THEN 1 END)
      comment: "Total number of Port State Control inspections. Denominator for PSC detention rate calculation."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up action. Indicates unresolved compliance gaps requiring management intervention."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average audit duration in days. Measures audit efficiency and resource utilisation across audit types."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for compliance audits. Drives audit budget management and cost-per-outcome analysis."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per compliance audit. Benchmarks audit programme efficiency and identifies cost outliers."
    - name: "unsatisfactory_outcome_count"
      expr: COUNT(CASE WHEN overall_audit_outcome = 'unsatisfactory' THEN 1 END)
      comment: "Number of audits with unsatisfactory outcomes. A leading indicator of regulatory risk and potential enforcement action."
    - name: "management_response_received_count"
      expr: COUNT(CASE WHEN management_response_received_flag = TRUE THEN 1 END)
      comment: "Number of audits where management has formally responded. Measures governance accountability and corrective action engagement."
    - name: "avg_team_size"
      expr: AVG(CAST(team_size AS DOUBLE))
      comment: "Average audit team size. Supports workforce planning for the compliance audit function."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for customs declaration processing covering clearance efficiency, duty revenue, declaration quality, and sanctions screening outcomes. Used by Customs Operations, Trade Compliance, and Finance leadership to manage trade facilitation and revenue assurance."
  source: "`vibe_shipping_ports_v1`.`compliance`.`customs_declaration`"
  dimensions:
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration (e.g., import, export, transit, T/S) for trade flow segmentation."
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current processing status of the declaration (e.g., submitted, assessed, cleared, rejected) for pipeline monitoring."
    - name: "customs_regime"
      expr: customs_regime
      comment: "Customs regime applied (e.g., home use, re-export, FTZ, bonded) for regime-level compliance analysis."
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country for trade lane analysis and sanctions risk segmentation."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms code (e.g., FOB, CIF, DDP) for trade terms analysis affecting duty liability."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Outcome of sanctions screening on the declaration for risk-based filtering."
    - name: "psc_inspection_required"
      expr: psc_inspection_required
      comment: "Flag indicating PSC inspection was required for this declaration, enabling inspection-triggered delay analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of declaration submission for trend and seasonality analysis."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_timestamp)
      comment: "Year of declaration submission for annual trade volume reporting."
    - name: "edi_message_type"
      expr: edi_message_type
      comment: "EDI message type used for the declaration (e.g., CUSCAR, CUSRES) for PCS channel analysis."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of customs declarations submitted. Baseline trade volume metric."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared cargo value across all declarations. Drives duty revenue forecasting and trade value reporting."
    - name: "total_duty_collected"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty assessed across declarations. Primary revenue assurance KPI for customs authority reporting."
    - name: "total_vat_collected"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT assessed on customs declarations. Supports tax authority reporting and revenue reconciliation."
    - name: "total_other_charges"
      expr: SUM(CAST(other_charges_amount AS DOUBLE))
      comment: "Total other charges levied on declarations (e.g., processing fees). Supports full cost-of-clearance analysis."
    - name: "total_charges"
      expr: SUM(CAST(total_charges_amount AS DOUBLE))
      comment: "Total charges across all declarations. Comprehensive revenue metric for customs operations."
    - name: "avg_declared_value_per_declaration"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value per declaration. Benchmarks shipment value profile and detects anomalous under-declaration."
    - name: "avg_duty_per_declaration"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty amount per declaration. Used to monitor effective duty rate trends."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of declared cargo in kilograms. Supports port throughput and capacity planning."
    - name: "sanctions_flagged_declarations"
      expr: COUNT(CASE WHEN sanctions_screening_status NOT IN ('cleared', 'pass', 'no_match') THEN 1 END)
      comment: "Number of declarations with non-cleared sanctions screening status. Critical risk KPI for trade compliance and regulatory reporting."
    - name: "rejected_declarations"
      expr: COUNT(CASE WHEN declaration_status = 'rejected' THEN 1 END)
      comment: "Number of rejected declarations. Measures declaration quality and broker performance."
    - name: "fal_compliant_declarations"
      expr: COUNT(CASE WHEN fal_form_3_compliant = TRUE THEN 1 END)
      comment: "Number of declarations compliant with IMO FAL Form 3 requirements. Measures port facilitation compliance."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_customs_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for customs hold management covering hold duration, demurrage exposure, seizure rates, and release efficiency. Used by Port Operations, Customs, and Finance to minimise cargo dwell time and manage financial exposure from holds."
  source: "`vibe_shipping_ports_v1`.`compliance`.`customs_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of customs hold (e.g., examination, sanctions, documentation) for root-cause analysis."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g., active, released, escalated) for operational pipeline management."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Coded reason for the hold placement for systematic hold cause analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the hold for SLA management and escalation tracking."
    - name: "demurrage_applicable_flag"
      expr: demurrage_applicable_flag
      comment: "Indicates whether demurrage charges apply to this hold, enabling financial exposure segmentation."
    - name: "detention_applicable_flag"
      expr: detention_applicable_flag
      comment: "Indicates whether detention charges apply, for container cost exposure analysis."
    - name: "seizure_flag"
      expr: seizure_flag
      comment: "Indicates whether cargo was seized, a critical enforcement outcome metric."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level at time of hold for security-driven hold analysis."
    - name: "hold_placement_month"
      expr: DATE_TRUNC('MONTH', hold_placement_timestamp)
      comment: "Month of hold placement for trend analysis of hold volumes over time."
    - name: "sanctions_screening_result"
      expr: sanctions_screening_result
      comment: "Result of sanctions screening associated with the hold for risk-based segmentation."
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of customs holds placed. Baseline metric for hold volume and customs intervention frequency."
    - name: "active_holds"
      expr: COUNT(CASE WHEN hold_status = 'active' THEN 1 END)
      comment: "Number of currently active holds. Real-time operational KPI for cargo release backlog management."
    - name: "seizure_count"
      expr: COUNT(CASE WHEN seizure_flag = TRUE THEN 1 END)
      comment: "Number of holds resulting in cargo seizure. Critical enforcement outcome KPI for customs authority reporting."
    - name: "avg_actual_delay_hours"
      expr: AVG(CAST(actual_delay_duration_hours AS DOUBLE))
      comment: "Average actual delay caused by customs holds in hours. Primary efficiency KPI for trade facilitation — directly impacts port competitiveness."
    - name: "total_actual_delay_hours"
      expr: SUM(CAST(actual_delay_duration_hours AS DOUBLE))
      comment: "Total delay hours caused by customs holds. Aggregated impact metric for port dwell time and demurrage exposure."
    - name: "avg_estimated_delay_hours"
      expr: AVG(CAST(estimated_delay_duration_hours AS DOUBLE))
      comment: "Average estimated delay at hold placement. Compared against actual delay to measure hold duration forecast accuracy."
    - name: "demurrage_exposure_holds"
      expr: COUNT(CASE WHEN demurrage_applicable_flag = TRUE THEN 1 END)
      comment: "Number of holds with demurrage exposure. Drives financial liability quantification for cargo owners and port."
    - name: "holds_with_notification_sent"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END)
      comment: "Number of holds where stakeholder notification was sent. Measures process compliance for hold communication SLAs."
    - name: "delay_forecast_variance"
      expr: AVG(CAST(actual_delay_duration_hours AS DOUBLE) - CAST(estimated_delay_duration_hours AS DOUBLE))
      comment: "Average variance between actual and estimated hold delay hours. Measures accuracy of hold duration forecasting for operational planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for sanctions screening operations covering match rates, risk levels, escalation frequency, and screening coverage. Used by the Chief Compliance Officer, Trade Finance, and Risk Management to manage sanctions exposure and regulatory obligations."
  source: "`vibe_shipping_ports_v1`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Overall status of the screening record (e.g., pending, cleared, escalated, blocked) for pipeline management."
    - name: "match_status"
      expr: match_status
      comment: "Outcome of the sanctions list match (e.g., no_match, potential_match, confirmed_match) for risk segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the screened entity (e.g., low, medium, high, critical) for risk-tiered reporting."
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (e.g., vessel, company, individual, cargo) for entity-level risk analysis."
    - name: "analyst_review_status"
      expr: analyst_review_status
      comment: "Status of analyst review for potential matches — tracks human-in-the-loop compliance workflow."
    - name: "is_high_risk_cargo"
      expr: is_high_risk_cargo
      comment: "Flag for high-risk cargo designation, enabling cargo-specific sanctions risk analysis."
    - name: "screening_trigger_event"
      expr: screening_trigger_event
      comment: "Business event that triggered the screening (e.g., vessel arrival, booking, payment) for process coverage analysis."
    - name: "vessel_flag_state"
      expr: vessel_flag_state
      comment: "Flag state of the vessel being screened for flag-state risk profiling."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month of screening for trend analysis of sanctions screening volumes."
    - name: "screening_system_name"
      expr: screening_system_name
      comment: "Name of the sanctions screening system used (e.g., World-Check, Dow Jones) for system performance benchmarking."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings performed. Baseline metric for screening programme coverage and throughput."
    - name: "confirmed_match_count"
      expr: COUNT(CASE WHEN match_status = 'confirmed_match' THEN 1 END)
      comment: "Number of confirmed sanctions matches. Critical regulatory KPI — each confirmed match requires immediate escalation and reporting."
    - name: "potential_match_count"
      expr: COUNT(CASE WHEN match_status = 'potential_match' THEN 1 END)
      comment: "Number of potential sanctions matches requiring analyst review. Drives analyst workload planning and false-positive rate analysis."
    - name: "escalated_to_authority_count"
      expr: COUNT(CASE WHEN escalated_to_authority IS NOT NULL AND escalated_to_authority != '' THEN 1 END)
      comment: "Number of screenings escalated to regulatory authorities. Measures regulatory reporting obligation fulfilment."
    - name: "high_risk_cargo_screenings"
      expr: COUNT(CASE WHEN is_high_risk_cargo = TRUE THEN 1 END)
      comment: "Number of screenings involving high-risk cargo. Supports risk-based inspection prioritisation."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average sanctions match score across all screenings. Monitors screening system calibration and false-positive threshold management."
    - name: "max_match_score"
      expr: MAX(CAST(match_score AS DOUBLE))
      comment: "Maximum match score recorded. Identifies highest-risk screening events for priority review."
    - name: "distinct_vessels_screened"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Number of distinct vessels screened. Measures vessel sanctions screening coverage across port calls."
    - name: "distinct_vendors_screened"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors screened. Measures supply chain sanctions screening coverage."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory violations covering penalty revenue, severity distribution, recurrence rates, and corrective action closure. Used by the Compliance Director, Legal, and Port Authority to manage regulatory risk, enforcement outcomes, and corrective action effectiveness."
  source: "`vibe_shipping_ports_v1`.`compliance`.`violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of regulatory violation (e.g., MARPOL, ISPS, customs, IMDG) for regulatory framework analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation (e.g., minor, major, critical) for risk-tiered reporting."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the violation case (e.g., open, under investigation, closed) for case pipeline management."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the violation was raised (e.g., SOLAS, MARPOL, ISPS, IMDG) for framework-level compliance analysis."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action for the violation (e.g., pending, in-progress, completed) for remediation tracking."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Indicates whether this is a repeat violation — a critical signal for systemic compliance failure."
    - name: "penalty_payment_status"
      expr: penalty_payment_status
      comment: "Status of penalty payment (e.g., outstanding, paid, waived) for revenue collection tracking."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation reached for the violation for governance oversight analysis."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the violation was detected (e.g., audit, inspection, self-report, system alert) for detection effectiveness analysis."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month of violation detection for trend analysis of violation frequency over time."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class associated with the violation for DG-specific compliance analysis."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of regulatory violations recorded. Baseline compliance health metric."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount levied across all violations. Primary financial impact KPI for regulatory enforcement — directly affects port operating costs."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation. Benchmarks enforcement severity and monitors penalty escalation trends."
    - name: "recurrence_violation_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of repeat violations. Critical KPI indicating systemic compliance failures requiring structural intervention."
    - name: "open_violations"
      expr: COUNT(CASE WHEN case_status = 'open' THEN 1 END)
      comment: "Number of currently open violation cases. Operational backlog metric for compliance case management."
    - name: "corrective_action_overdue_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('completed', 'closed') AND corrective_action_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of violations where corrective action deadline has passed without completion. Drives escalation and governance accountability."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across violations. Monitors overall compliance risk profile and trend direction."
    - name: "max_risk_score"
      expr: MAX(CAST(risk_score AS DOUBLE))
      comment: "Maximum risk score recorded. Identifies highest-risk violations for priority management attention."
    - name: "penalty_outstanding_amount"
      expr: SUM(CASE WHEN penalty_payment_status = 'outstanding' THEN CAST(penalty_amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding penalty amounts not yet collected. Drives accounts receivable and enforcement follow-up."
    - name: "distinct_vessels_with_violations"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Number of distinct vessels with recorded violations. Identifies repeat-offender vessels for targeted inspection programmes."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_marpol_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance KPIs for MARPOL operations covering emissions volumes, waste disposal, ballast water management, and CII/EEXI performance. Used by the Environmental Compliance Officer, Port Authority, and sustainability leadership to manage IMO environmental obligations."
  source: "`vibe_shipping_ports_v1`.`compliance`.`marpol_record`"
  dimensions:
    - name: "marpol_annex"
      expr: marpol_annex
      comment: "MARPOL annex applicable to the record (e.g., Annex I oil, Annex IV sewage, Annex V garbage, Annex VI air) for annex-level compliance analysis."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of MARPOL operation (e.g., discharge, reception, disposal, ballast exchange) for operational breakdown."
    - name: "compliance_status"
      expr: compliance_status
      comment: "MARPOL compliance status of the record (e.g., compliant, non-compliant, under review) for regulatory standing."
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste or substance involved (e.g., oily water, garbage, sewage, exhaust gas) for waste stream analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (e.g., port reception facility, incineration, discharge) for environmental impact analysis."
    - name: "cii_rating"
      expr: cii_rating
      comment: "IMO Carbon Intensity Indicator rating (A-E) for the vessel/operation. Key decarbonisation KPI dimension."
    - name: "port_authority_endorsement_flag"
      expr: port_authority_endorsement_flag
      comment: "Indicates port authority endorsement of the MARPOL record for regulatory validation tracking."
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', operation_timestamp)
      comment: "Month of MARPOL operation for emissions and waste trend analysis."
    - name: "operation_year"
      expr: DATE_TRUNC('YEAR', operation_timestamp)
      comment: "Year of MARPOL operation for annual environmental reporting (IMO DCS, EU MRV)."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether corrective action was required for the MARPOL record, for non-compliance remediation tracking."
  measures:
    - name: "total_marpol_records"
      expr: COUNT(1)
      comment: "Total MARPOL operational records. Baseline metric for environmental compliance activity volume."
    - name: "total_sox_emissions_mt"
      expr: SUM(CAST(sox_emissions_mt AS DOUBLE))
      comment: "Total sulphur oxide emissions in metric tonnes. Primary MARPOL Annex VI KPI for IMO 2020 sulphur cap compliance and port air quality management."
    - name: "total_nox_emissions_mt"
      expr: SUM(CAST(nox_emissions_mt AS DOUBLE))
      comment: "Total nitrogen oxide emissions in metric tonnes. MARPOL Annex VI Tier III compliance KPI for NOx emission control areas (ECAs)."
    - name: "total_particulate_matter_mt"
      expr: SUM(CAST(particulate_matter_emissions_mt AS DOUBLE))
      comment: "Total particulate matter emissions in metric tonnes. Environmental health KPI for port air quality and community impact reporting."
    - name: "total_waste_quantity_mt"
      expr: SUM(CAST(quantity_mass_mt AS DOUBLE))
      comment: "Total waste quantity handled in metric tonnes. Drives port reception facility capacity planning and MARPOL Annex V reporting."
    - name: "total_waste_volume_m3"
      expr: SUM(CAST(quantity_volume_m3 AS DOUBLE))
      comment: "Total waste volume handled in cubic metres. Supports reception facility utilisation and waste management contract sizing."
    - name: "avg_eexi_value"
      expr: AVG(CAST(eexi_value AS DOUBLE))
      comment: "Average Energy Efficiency Existing Ship Index value across records. Monitors fleet energy efficiency compliance with IMO EEXI requirements."
    - name: "avg_eedi_value"
      expr: AVG(CAST(eedi_value AS DOUBLE))
      comment: "Average Energy Efficiency Design Index value. Benchmarks new vessel energy efficiency against IMO EEDI reference lines."
    - name: "non_compliant_records"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Number of non-compliant MARPOL records. Critical environmental enforcement KPI — each non-compliance risks port state detention and reputational damage."
    - name: "port_authority_endorsed_records"
      expr: COUNT(CASE WHEN port_authority_endorsement_flag = TRUE THEN 1 END)
      comment: "Number of MARPOL records endorsed by port authority. Measures regulatory validation coverage and documentation completeness."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_hs_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HS code registry management covering duty rate profiles, restricted/prohibited commodity coverage, dangerous goods classification, and trade control flags. Used by Trade Compliance and Customs teams to manage tariff classification quality and trade control obligations."
  source: "`vibe_shipping_ports_v1`.`compliance`.`hs_code`"
  dimensions:
    - name: "chapter"
      expr: chapter
      comment: "HS code chapter (2-digit) for high-level commodity category analysis."
    - name: "heading"
      expr: heading
      comment: "HS code heading (4-digit) for mid-level commodity classification analysis."
    - name: "hs_code_status"
      expr: hs_code_status
      comment: "Status of the HS code (e.g., active, superseded, withdrawn) for code registry quality management."
    - name: "hs_version"
      expr: hs_version
      comment: "HS nomenclature version (e.g., HS2022, HS2017) for version-specific classification analysis."
    - name: "imdg_dangerous_goods_flag"
      expr: imdg_dangerous_goods_flag
      comment: "Indicates whether the HS code covers IMDG dangerous goods for DG classification coverage analysis."
    - name: "prohibited_flag"
      expr: prohibited_flag
      comment: "Indicates prohibited commodities for trade restriction compliance monitoring."
    - name: "restricted_flag"
      expr: restricted_flag
      comment: "Indicates restricted commodities requiring special authorisation for trade control analysis."
    - name: "dual_use_flag"
      expr: dual_use_flag
      comment: "Indicates dual-use goods subject to export control regulations for strategic trade compliance."
    - name: "preferential_tariff_flag"
      expr: preferential_tariff_flag
      comment: "Indicates eligibility for preferential tariff treatment under trade agreements for duty optimisation analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country-specific HS code variant for jurisdiction-level classification analysis."
  measures:
    - name: "total_hs_codes"
      expr: COUNT(1)
      comment: "Total number of HS codes in the registry. Baseline metric for classification coverage completeness."
    - name: "active_hs_codes"
      expr: COUNT(CASE WHEN hs_code_status = 'active' THEN 1 END)
      comment: "Number of currently active HS codes. Measures classification registry currency and maintenance quality."
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_percentage AS DOUBLE))
      comment: "Average duty rate percentage across HS codes. Benchmarks tariff burden profile for trade competitiveness analysis."
    - name: "max_duty_rate_pct"
      expr: MAX(CAST(duty_rate_percentage AS DOUBLE))
      comment: "Maximum duty rate in the tariff schedule. Identifies peak tariff exposure for high-value commodity planning."
    - name: "avg_vat_rate_pct"
      expr: AVG(CAST(vat_rate_percentage AS DOUBLE))
      comment: "Average VAT rate across HS codes. Supports tax burden analysis and trade cost modelling."
    - name: "dangerous_goods_codes_count"
      expr: COUNT(CASE WHEN imdg_dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of HS codes classified as IMDG dangerous goods. Measures DG classification coverage for port safety compliance."
    - name: "prohibited_codes_count"
      expr: COUNT(CASE WHEN prohibited_flag = TRUE THEN 1 END)
      comment: "Number of prohibited commodity HS codes. Drives customs enforcement targeting and gate control configuration."
    - name: "dual_use_codes_count"
      expr: COUNT(CASE WHEN dual_use_flag = TRUE THEN 1 END)
      comment: "Number of dual-use goods HS codes. Measures strategic export control classification coverage."
    - name: "preferential_tariff_codes_count"
      expr: COUNT(CASE WHEN preferential_tariff_flag = TRUE THEN 1 END)
      comment: "Number of HS codes eligible for preferential tariff treatment. Supports trade agreement utilisation analysis and duty savings identification."
    - name: "avg_excise_duty_rate_pct"
      expr: AVG(CAST(excise_duty_rate_percentage AS DOUBLE))
      comment: "Average excise duty rate across applicable HS codes. Supports excise revenue forecasting and compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_import_export_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for import/export permit lifecycle management covering permit validity, inspection outcomes, sanctions screening, and controlled goods coverage. Used by Trade Compliance and Customs Operations to manage permit programme effectiveness and regulatory obligations."
  source: "`vibe_shipping_ports_v1`.`compliance`.`import_export_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., import, export, re-export, transit) for trade flow segmentation."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., active, expired, revoked, suspended) for permit portfolio management."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country that issued the permit for jurisdiction-level analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade lane and sanctions risk analysis."
    - name: "controlled_goods_flag"
      expr: controlled_goods_flag
      comment: "Indicates whether the permit covers controlled goods for strategic trade compliance segmentation."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates whether physical inspection was required for the permit for inspection workload analysis."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Sanctions screening outcome for the permit for risk-based permit management."
    - name: "issue_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year of permit issuance for annual permit volume and trend analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of permit issuance for seasonal permit demand analysis."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of import/export permits. Baseline metric for trade permit programme volume."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status = 'active' THEN 1 END)
      comment: "Number of currently active permits. Operational metric for permit portfolio management."
    - name: "revoked_permits"
      expr: COUNT(CASE WHEN permit_status = 'revoked' THEN 1 END)
      comment: "Number of revoked permits. Compliance risk KPI — revocations indicate enforcement actions or compliance failures."
    - name: "total_authorized_value"
      expr: SUM(CAST(value_authorized AS DOUBLE))
      comment: "Total value of goods authorised under permits. Measures trade value under regulatory control for economic reporting."
    - name: "total_authorized_quantity"
      expr: SUM(CAST(quantity_authorized AS DOUBLE))
      comment: "Total quantity of goods authorised under permits. Supports quota utilisation and trade volume analysis."
    - name: "avg_authorized_value"
      expr: AVG(CAST(value_authorized AS DOUBLE))
      comment: "Average authorised value per permit. Benchmarks permit size profile for risk-based inspection targeting."
    - name: "controlled_goods_permits"
      expr: COUNT(CASE WHEN controlled_goods_flag = TRUE THEN 1 END)
      comment: "Number of permits covering controlled goods. Measures strategic trade control programme scope."
    - name: "inspection_required_permits"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of permits requiring physical inspection. Drives inspection resource planning for customs operations."
    - name: "sanctions_flagged_permits"
      expr: COUNT(CASE WHEN sanctions_screening_status NOT IN ('cleared', 'pass', 'no_match') THEN 1 END)
      comment: "Number of permits with non-cleared sanctions screening. Critical risk KPI for trade compliance enforcement."
    - name: "distinct_commodities_permitted"
      expr: COUNT(DISTINCT compliance_hs_code_id)
      comment: "Number of distinct HS codes covered by permits. Measures breadth of commodity coverage under trade control."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_trade_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for trade restriction registry management covering active restrictions, enforcement levels, and commodity/country coverage. Used by Trade Compliance, Legal, and Risk Management to manage sanctions, embargoes, and trade control obligations."
  source: "`vibe_shipping_ports_v1`.`compliance`.`trade_restriction`"
  dimensions:
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of trade restriction (e.g., embargo, sanctions, export control, quota) for restriction category analysis."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction (e.g., active, expired, suspended) for active restriction portfolio management."
    - name: "enforcement_level"
      expr: enforcement_level
      comment: "Level of enforcement required (e.g., mandatory, advisory, voluntary) for compliance obligation prioritisation."
    - name: "restriction_scope"
      expr: restriction_scope
      comment: "Scope of the restriction (e.g., bilateral, multilateral, unilateral) for geopolitical risk analysis."
    - name: "issuing_authority_country_code"
      expr: issuing_authority_country_code
      comment: "Country of the issuing authority for jurisdiction-level restriction analysis."
    - name: "screening_required_flag"
      expr: screening_required_flag
      comment: "Indicates whether screening is required for this restriction for compliance workflow configuration."
    - name: "declaration_required_flag"
      expr: declaration_required_flag
      comment: "Indicates whether a declaration is required for this restriction for documentation compliance analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the restriction became effective for temporal restriction landscape analysis."
  measures:
    - name: "total_restrictions"
      expr: COUNT(1)
      comment: "Total number of trade restrictions in the registry. Baseline metric for trade control landscape complexity."
    - name: "active_restrictions"
      expr: COUNT(CASE WHEN restriction_status = 'active' THEN 1 END)
      comment: "Number of currently active trade restrictions. Operational KPI for compliance team workload and risk exposure management."
    - name: "mandatory_enforcement_restrictions"
      expr: COUNT(CASE WHEN enforcement_level = 'mandatory' THEN 1 END)
      comment: "Number of restrictions with mandatory enforcement. Identifies highest-priority compliance obligations requiring immediate action."
    - name: "screening_required_restrictions"
      expr: COUNT(CASE WHEN screening_required_flag = TRUE THEN 1 END)
      comment: "Number of restrictions requiring sanctions screening. Drives screening programme scope and system configuration."
    - name: "derogation_available_restrictions"
      expr: COUNT(CASE WHEN derogation_available_flag = TRUE THEN 1 END)
      comment: "Number of restrictions where derogation is available. Identifies opportunities for trade facilitation through exemption management."
    - name: "distinct_affected_countries"
      expr: COUNT(DISTINCT affected_country_id)
      comment: "Number of distinct countries affected by trade restrictions. Measures geographic scope of trade control obligations."
    - name: "distinct_restricted_commodities"
      expr: COUNT(DISTINCT commodity_code_id)
      comment: "Number of distinct commodity codes under trade restriction. Measures commodity-level trade control coverage."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_declaration_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for customs declaration screening operations covering anomaly detection rates, screening method effectiveness, and follow-up action rates. Used by Customs Risk Management to optimise risk-based screening programmes and resource allocation."
  source: "`vibe_shipping_ports_v1`.`compliance`.`declaration_screening`"
  dimensions:
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (e.g., X-ray, document review, physical examination, automated) for method effectiveness analysis."
    - name: "screening_outcome"
      expr: screening_outcome
      comment: "Outcome of the screening (e.g., cleared, anomaly detected, referred for examination) for outcome distribution analysis."
    - name: "anomaly_detected_flag"
      expr: anomaly_detected_flag
      comment: "Indicates whether an anomaly was detected during screening — primary screening effectiveness KPI dimension."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether follow-up action is required after screening for workload planning."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month of screening for trend analysis of screening volumes and anomaly rates."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of declaration screenings performed. Baseline metric for screening programme throughput."
    - name: "anomaly_detected_count"
      expr: COUNT(CASE WHEN anomaly_detected_flag = TRUE THEN 1 END)
      comment: "Number of screenings where anomalies were detected. Primary effectiveness KPI for risk-based screening programmes."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of screenings requiring follow-up action. Drives post-screening workload planning and resource allocation."
    - name: "avg_screening_duration_seconds"
      expr: AVG(CAST(screening_duration_seconds AS DOUBLE))
      comment: "Average screening duration in seconds. Measures screening efficiency and identifies bottlenecks in the customs clearance process."
    - name: "distinct_declarations_screened"
      expr: COUNT(DISTINCT customs_declaration_id)
      comment: "Number of distinct customs declarations screened. Measures screening coverage across the declaration population."
$$;