-- Metric views for domain: compliance | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 10:21:34

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic customs clearance performance and trade compliance KPIs tracking declaration processing efficiency, duty collection, and clearance cycle times that directly impact port throughput and revenue collection."
  source: "`vibe_shipping_ports_v1`.`compliance`.`customs_declaration`"
  dimensions:
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration (import, export, transit) for segmenting trade flows"
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of declaration (submitted, assessed, cleared, rejected) for tracking processing stages"
    - name: "customs_regime"
      expr: customs_regime
      comment: "Customs regime applied (normal, bonded, temporary admission) for regulatory analysis"
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country for trade flow and bilateral trade analysis"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of declaration submission for time-series trend analysis"
    - name: "clearance_month"
      expr: DATE_TRUNC('MONTH', clearance_timestamp)
      comment: "Month of customs clearance for throughput performance tracking"
    - name: "fal_form_3_compliant"
      expr: fal_form_3_compliant
      comment: "IMO FAL Form 3 compliance flag for international maritime standards adherence"
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Sanctions screening outcome for risk and compliance monitoring"
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of customs declarations processed - baseline volume metric for port trade activity"
    - name: "total_duty_collected"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty collected in local currency - critical revenue metric for port authority and government"
    - name: "total_vat_collected"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT collected on imports - key tax revenue metric for fiscal authorities"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of goods - measures trade volume and economic activity through the port"
    - name: "total_charges"
      expr: SUM(CAST(total_charges_amount AS DOUBLE))
      comment: "Total charges (duty + VAT + fees) collected - comprehensive revenue metric for port financial performance"
    - name: "avg_declared_value"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value per declaration - indicates shipment size and trade patterns"
    - name: "avg_duty_amount"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty per declaration - measures effective duty rate and revenue per transaction"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of cargo declared - measures physical throughput capacity utilization"
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight of goods - measures actual cargo volume for logistics planning"
    - name: "avg_clearance_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(clearance_timestamp) - UNIX_TIMESTAMP(submission_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average clearance cycle time in hours from submission to clearance - critical efficiency KPI for port competitiveness and trade facilitation"
    - name: "distinct_declarants"
      expr: COUNT(DISTINCT declarant_identifier)
      comment: "Number of unique declarants - measures customer base diversity and market concentration"
    - name: "distinct_consignees"
      expr: COUNT(DISTINCT consignee_identifier)
      comment: "Number of unique consignees - tracks import customer diversity for business development"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_customs_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical customs hold and inspection performance metrics tracking cargo detention, examination efficiency, and release cycle times that directly impact port dwell time, demurrage costs, and supply chain velocity."
  source: "`vibe_shipping_ports_v1`.`compliance`.`customs_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of customs hold (documentary, physical inspection, security) for root cause analysis"
    - name: "hold_status"
      expr: hold_status
      comment: "Current hold status (active, released, escalated) for operational monitoring"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardized reason code for hold placement for compliance pattern analysis"
    - name: "placed_by_authority"
      expr: placed_by_authority
      comment: "Authority that placed the hold (customs, border security, health) for inter-agency coordination"
    - name: "priority_level"
      expr: priority_level
      comment: "Hold priority level for resource allocation and escalation management"
    - name: "seizure_flag"
      expr: seizure_flag
      comment: "Whether cargo was seized - critical risk and enforcement outcome indicator"
    - name: "demurrage_applicable_flag"
      expr: demurrage_applicable_flag
      comment: "Whether demurrage charges apply - financial impact flag for cost analysis"
    - name: "hold_placement_month"
      expr: DATE_TRUNC('MONTH', hold_placement_timestamp)
      comment: "Month hold was placed for trend analysis of inspection volumes"
    - name: "psc_inspection_flag"
      expr: psc_inspection_flag
      comment: "Port State Control inspection flag for maritime safety compliance tracking"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of customs holds placed - baseline metric for inspection volume and compliance enforcement intensity"
    - name: "avg_hold_duration_hours"
      expr: AVG(CAST(actual_delay_duration_hours AS DOUBLE))
      comment: "Average hold duration in hours - critical efficiency KPI measuring inspection speed and cargo dwell time impact on supply chain velocity"
    - name: "total_hold_duration_hours"
      expr: SUM(CAST(actual_delay_duration_hours AS DOUBLE))
      comment: "Total hold duration across all holds - measures aggregate detention time and port efficiency drag"
    - name: "avg_estimated_delay_hours"
      expr: AVG(CAST(estimated_delay_duration_hours AS DOUBLE))
      comment: "Average estimated delay duration - measures planning accuracy and customer communication quality"
    - name: "total_estimated_delay_hours"
      expr: SUM(CAST(estimated_delay_duration_hours AS DOUBLE))
      comment: "Total estimated delay hours - aggregate forecast for capacity planning"
    - name: "distinct_containers_held"
      expr: COUNT(DISTINCT container_number)
      comment: "Number of unique containers under hold - measures inspection scope and cargo flow disruption"
    - name: "avg_inspection_cycle_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(inspection_completed_timestamp) - UNIX_TIMESTAMP(inspection_scheduled_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time from inspection scheduled to completed in hours - operational efficiency metric for inspection resource utilization"
    - name: "avg_release_cycle_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(hold_release_timestamp) - UNIX_TIMESTAMP(hold_placement_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time from hold placement to release in hours - end-to-end hold resolution efficiency KPI critical for port competitiveness"
    - name: "seizure_count"
      expr: SUM(CAST(CASE WHEN seizure_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of holds resulting in cargo seizure - enforcement effectiveness and risk materialization metric"
    - name: "demurrage_applicable_count"
      expr: SUM(CAST(CASE WHEN demurrage_applicable_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of holds triggering demurrage charges - financial impact metric for customer cost and port reputation"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sanctions compliance and risk screening KPIs tracking match rates, resolution efficiency, and escalation patterns that directly impact regulatory compliance, enforcement risk, and trade security."
  source: "`vibe_shipping_ports_v1`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Screening outcome status (clear, match, pending review) for compliance monitoring"
    - name: "match_status"
      expr: match_status
      comment: "Match determination (no match, potential match, confirmed match) for risk segmentation"
    - name: "risk_level"
      expr: risk_level
      comment: "Assigned risk level (low, medium, high, critical) for prioritization and resource allocation"
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (vessel, company, individual, cargo) for screening coverage analysis"
    - name: "matched_list_name"
      expr: matched_list_name
      comment: "Sanctions list where match was found (OFAC, UN, EU) for regulatory jurisdiction tracking"
    - name: "analyst_review_status"
      expr: analyst_review_status
      comment: "Human review status (pending, reviewed, escalated) for workflow management"
    - name: "escalated_to_authority"
      expr: escalated_to_authority
      comment: "Authority to which case was escalated for enforcement coordination tracking"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month of screening for trend analysis of screening volumes and match rates"
    - name: "is_high_risk_cargo"
      expr: is_high_risk_cargo
      comment: "High-risk cargo flag for targeted compliance and inspection planning"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Origin country for geographic risk profiling and trade pattern analysis"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings performed - baseline compliance activity volume metric"
    - name: "match_count"
      expr: SUM(CASE WHEN match_status IN ('potential_match', 'confirmed_match') THEN 1 ELSE 0 END)
      comment: "Number of screenings with potential or confirmed matches - critical risk detection metric for enforcement and interdiction"
    - name: "high_risk_count"
      expr: SUM(CASE WHEN risk_level IN ('high', 'critical') THEN 1 ELSE 0 END)
      comment: "Number of high or critical risk screenings - measures threat exposure and enforcement workload"
    - name: "escalation_count"
      expr: SUM(CAST(CASE WHEN escalated_to_authority IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of cases escalated to authorities - measures serious compliance incidents requiring government intervention"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match confidence score - measures screening system accuracy and false positive rate indicator"
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(resolution_timestamp) - UNIX_TIMESTAMP(screening_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time from screening to resolution in hours - critical efficiency KPI for compliance processing speed and cargo release velocity"
    - name: "distinct_vessels_screened"
      expr: COUNT(DISTINCT imo_number)
      comment: "Number of unique vessels screened - measures maritime traffic compliance coverage"
    - name: "distinct_entities_screened"
      expr: COUNT(DISTINCT COALESCE(imo_number, company_registration_number, individual_passport_number))
      comment: "Number of unique entities screened across all types - measures comprehensive screening reach"
    - name: "high_risk_cargo_count"
      expr: SUM(CAST(CASE WHEN is_high_risk_cargo = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of high-risk cargo screenings - targeted risk metric for enhanced inspection planning"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_import_export_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic trade licensing and permit management KPIs tracking permit issuance, utilization, inspection outcomes, and controlled goods compliance that directly impact trade facilitation and regulatory enforcement."
  source: "`vibe_shipping_ports_v1`.`compliance`.`import_export_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (import, export, dual-use, strategic goods) for regulatory category analysis"
    - name: "permit_status"
      expr: permit_status
      comment: "Current permit status (active, expired, revoked, pending) for compliance monitoring"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Government authority that issued permit for inter-agency coordination tracking"
    - name: "controlled_goods_flag"
      expr: controlled_goods_flag
      comment: "Whether permit covers controlled or strategic goods - critical for export control compliance"
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether physical inspection is required - operational planning and resource allocation flag"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of inspection (passed, failed, conditional) for compliance quality tracking"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for export control and trade flow analysis"
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country that issued the permit for jurisdiction and reciprocity tracking"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month permit was issued for trend analysis of licensing activity"
    - name: "quantity_unit"
      expr: quantity_unit
      comment: "Unit of measure for authorized quantity for commodity-specific analysis"
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of import/export permits - baseline metric for trade licensing volume and regulatory activity"
    - name: "controlled_goods_permits"
      expr: SUM(CAST(CASE WHEN controlled_goods_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of permits for controlled or strategic goods - critical export control compliance metric for national security"
    - name: "total_authorized_value"
      expr: SUM(CAST(value_authorized AS DOUBLE))
      comment: "Total value of goods authorized for trade - measures economic impact and trade volume under license"
    - name: "avg_authorized_value"
      expr: AVG(CAST(value_authorized AS DOUBLE))
      comment: "Average value per permit - indicates transaction size and licensing efficiency"
    - name: "total_authorized_quantity"
      expr: SUM(CAST(quantity_authorized AS DOUBLE))
      comment: "Total quantity authorized across all permits - measures physical volume of licensed trade"
    - name: "avg_authorized_quantity"
      expr: AVG(CAST(quantity_authorized AS DOUBLE))
      comment: "Average quantity per permit - indicates typical shipment size for capacity planning"
    - name: "inspection_required_count"
      expr: SUM(CAST(CASE WHEN inspection_required_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of permits requiring inspection - measures inspection workload and resource demand"
    - name: "inspection_failure_count"
      expr: SUM(CAST(CASE WHEN inspection_result = 'failed' THEN 1 ELSE 0 END AS INT))
      comment: "Number of failed inspections - compliance quality metric indicating non-conformance rate"
    - name: "revoked_permits"
      expr: SUM(CAST(CASE WHEN permit_status = 'revoked' THEN 1 ELSE 0 END AS INT))
      comment: "Number of revoked permits - enforcement action metric indicating serious compliance violations"
    - name: "avg_permit_validity_days"
      expr: AVG(CAST(DATEDIFF(validity_end_date, validity_start_date) AS DOUBLE))
      comment: "Average permit validity period in days - measures licensing flexibility and administrative burden"
    - name: "avg_processing_time_days"
      expr: AVG(CAST(DATEDIFF(issue_date, application_date) AS DOUBLE))
      comment: "Average time from application to issuance in days - critical trade facilitation efficiency KPI measuring regulatory processing speed"
    - name: "distinct_permit_holders"
      expr: COUNT(DISTINCT permit_holder_identifier)
      comment: "Number of unique permit holders - measures licensed trader base and market participation"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_marpol_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic maritime environmental compliance KPIs tracking MARPOL waste disposal, emissions, ballast water management, and port reception facility utilization that directly impact environmental regulatory compliance and port sustainability performance."
  source: "`vibe_shipping_ports_v1`.`compliance`.`marpol_record`"
  dimensions:
    - name: "marpol_annex"
      expr: marpol_annex
      comment: "MARPOL annex category (I-VI) for regulatory classification of environmental compliance"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation (discharge, reception, treatment, disposal) for activity segmentation"
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste handled (oily waste, sewage, garbage, ballast water) for environmental impact analysis"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance outcome (compliant, non-compliant, conditional) for enforcement and quality tracking"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for waste disposal for environmental best practice analysis"
    - name: "ballast_water_management_method"
      expr: ballast_water_management_method
      comment: "Ballast water treatment method (exchange, treatment system) for invasive species prevention tracking"
    - name: "cii_rating"
      expr: cii_rating
      comment: "Carbon Intensity Indicator rating (A-E) for IMO decarbonization compliance and vessel efficiency benchmarking"
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', operation_timestamp)
      comment: "Month of operation for environmental performance trend analysis"
    - name: "port_authority_endorsement_flag"
      expr: port_authority_endorsement_flag
      comment: "Whether port authority endorsed the operation for regulatory oversight tracking"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required for non-compliance incident management"
  measures:
    - name: "total_operations"
      expr: COUNT(1)
      comment: "Total number of MARPOL operations recorded - baseline environmental compliance activity volume"
    - name: "total_waste_mass_mt"
      expr: SUM(CAST(quantity_mass_mt AS DOUBLE))
      comment: "Total waste mass in metric tons - measures aggregate waste handling volume and port reception facility capacity utilization"
    - name: "total_waste_volume_m3"
      expr: SUM(CAST(quantity_volume_m3 AS DOUBLE))
      comment: "Total waste volume in cubic meters - measures volumetric waste handling for facility planning"
    - name: "avg_waste_mass_mt"
      expr: AVG(CAST(quantity_mass_mt AS DOUBLE))
      comment: "Average waste mass per operation - indicates typical discharge size for operational planning"
    - name: "total_nox_emissions_mt"
      expr: SUM(CAST(nox_emissions_mt AS DOUBLE))
      comment: "Total NOx emissions in metric tons - critical air quality metric for MARPOL Annex VI compliance and port environmental impact"
    - name: "total_sox_emissions_mt"
      expr: SUM(CAST(sox_emissions_mt AS DOUBLE))
      comment: "Total SOx emissions in metric tons - sulfur emissions metric for IMO 2020 low-sulfur fuel compliance tracking"
    - name: "total_particulate_emissions_mt"
      expr: SUM(CAST(particulate_matter_emissions_mt AS DOUBLE))
      comment: "Total particulate matter emissions in metric tons - air quality metric for port environmental health impact"
    - name: "avg_eedi_value"
      expr: AVG(CAST(eedi_value AS DOUBLE))
      comment: "Average Energy Efficiency Design Index - vessel design efficiency metric for fleet environmental performance benchmarking"
    - name: "avg_eexi_value"
      expr: AVG(CAST(eexi_value AS DOUBLE))
      comment: "Average Energy Efficiency Existing Ship Index - existing fleet efficiency metric for IMO decarbonization compliance"
    - name: "non_compliance_count"
      expr: SUM(CAST(CASE WHEN compliance_status = 'non_compliant' THEN 1 ELSE 0 END AS INT))
      comment: "Number of non-compliant operations - enforcement metric measuring environmental violation rate and regulatory risk"
    - name: "corrective_action_count"
      expr: SUM(CAST(CASE WHEN corrective_action_required IS NOT NULL AND corrective_action_required != '' THEN 1 ELSE 0 END AS INT))
      comment: "Number of operations requiring corrective action - quality metric for environmental incident management"
    - name: "distinct_vessels"
      expr: COUNT(DISTINCT vessel_imo_number)
      comment: "Number of unique vessels with MARPOL records - measures environmental compliance coverage across fleet"
    - name: "port_endorsed_operations"
      expr: SUM(CAST(CASE WHEN port_authority_endorsement_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Number of port authority endorsed operations - regulatory oversight quality metric"
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`compliance_isps_facility_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic maritime security compliance KPIs tracking ISPS Code implementation, security level management, Declaration of Security execution, and security incident response that directly impact port security posture and international ship-port interface compliance."
  source: "`vibe_shipping_ports_v1`.`compliance`.`isps_facility_record`"
  dimensions:
    - name: "current_security_level"
      expr: current_security_level
      comment: "Current ISPS security level (1, 2, 3) for threat posture and resource allocation"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of port facility (terminal, warehouse, anchorage) for security coverage analysis"
    - name: "compliance_status"
      expr: compliance_status
      comment: "ISPS compliance status (compliant, conditional, non-compliant) for regulatory enforcement tracking"
    - name: "dos_type"
      expr: dos_type
      comment: "Type of Declaration of Security (ship-port, ship-ship) for interface security coordination"
    - name: "alert_type"
      expr: alert_type
      comment: "Type of security alert (intrusion, suspicious activity, threat) for incident classification"
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of security alert (low, medium, high, critical) for prioritization and escalation"
    - name: "last_psc_inspection_result"
      expr: last_psc_inspection_result
      comment: "Result of last Port State Control inspection for external audit quality tracking"
    - name: "security_level_month"
      expr: DATE_TRUNC('MONTH', security_level_effective_date)
      comment: "Month of security level change for threat trend analysis"
    - name: "alert_issued_month"
      expr: DATE_TRUNC('MONTH', alert_issued_timestamp)
      comment: "Month security alert was issued for incident trend tracking"
    - name: "facility_name"
      expr: facility_name
      comment: "Name of port facility for location-specific security performance analysis"
  measures:
    - name: "total_facility_records"
      expr: COUNT(1)
      comment: "Total number of ISPS facility records - baseline security compliance activity volume"
    - name: "security_alert_count"
      expr: SUM(CAST(CASE WHEN alert_type IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of security alerts issued - critical security incident metric measuring threat activity and response workload"
    - name: "high_severity_alert_count"
      expr: SUM(CASE WHEN alert_severity IN ('high', 'critical') THEN 1 ELSE 0 END)
      comment: "Number of high or critical severity alerts - measures serious security threats requiring immediate response"
    - name: "avg_alert_resolution_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(alert_resolution_timestamp) - UNIX_TIMESTAMP(alert_issued_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time from alert issuance to resolution in hours - critical security response efficiency KPI measuring incident management effectiveness"
    - name: "dos_executed_count"
      expr: SUM(CAST(CASE WHEN dos_reference_number IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Number of Declarations of Security executed - measures ship-port security interface coordination volume"
    - name: "avg_dos_validity_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(dos_valid_until) - UNIX_TIMESTAMP(dos_valid_from)) / 3600.0 AS DOUBLE))
      comment: "Average Declaration of Security validity period in hours - measures security agreement duration and operational flexibility"
    - name: "psc_deficiency_total"
      expr: SUM(CAST(psc_deficiency_count AS DOUBLE))
      comment: "Total Port State Control deficiencies identified - external audit quality metric indicating compliance gaps and enforcement risk"
    - name: "avg_psc_deficiency_count"
      expr: AVG(CAST(psc_deficiency_count AS DOUBLE))
      comment: "Average PSC deficiencies per facility - benchmarking metric for facility security quality"
    - name: "non_compliant_facilities"
      expr: SUM(CAST(CASE WHEN compliance_status = 'non_compliant' THEN 1 ELSE 0 END AS INT))
      comment: "Number of non-compliant facilities - enforcement metric measuring serious security compliance failures"
    - name: "distinct_facilities"
      expr: COUNT(DISTINCT facility_name)
      comment: "Number of unique facilities with ISPS records - measures security compliance coverage across port infrastructure"
    - name: "distinct_vessels_interfaced"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Number of unique vessels with security interface records - measures ship-port security coordination reach"
    - name: "escalated_alert_count"
      expr: SUM(CAST(CASE WHEN alert_escalation_chain IS NOT NULL AND alert_escalation_chain != '' THEN 1 ELSE 0 END AS INT))
      comment: "Number of alerts escalated through chain of command - measures serious incident rate requiring senior management intervention"
$$;