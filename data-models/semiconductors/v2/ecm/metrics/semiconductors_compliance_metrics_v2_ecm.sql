-- Metric views for domain: compliance | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for compliance audit events — tracks audit volume, closure rates, risk distribution, and corrective action timeliness to steer the compliance program."
  source: "`vibe_semiconductors_v1`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_category"
      expr: audit_category
      comment: "Category of the audit (e.g. supplier, internal, regulatory) for segmenting audit performance."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g. first-party, second-party, third-party) to compare audit program composition."
    - name: "audit_standard"
      expr: audit_standard
      comment: "Governing standard under which the audit was conducted (e.g. ISO 9001, IATF 16949)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit outcome — used to prioritize follow-up actions."
    - name: "closure_status"
      expr: closure_status
      comment: "Current closure status of the audit — drives open-audit aging analysis."
    - name: "overall_result"
      expr: overall_result
      comment: "Pass/fail/conditional result of the audit for trend and pass-rate analysis."
    - name: "audit_region"
      expr: audit_region
      comment: "Geographic region where the audit was conducted — enables regional compliance benchmarking."
    - name: "auditing_body"
      expr: auditing_body
      comment: "Organization or body that conducted the audit (internal team, third-party registrar, etc.)."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the audit record (open, in-review, closed, archived)."
    - name: "audit_start_month"
      expr: DATE_TRUNC('MONTH', audit_start_date)
      comment: "Month the audit started — used for trend analysis of audit activity over time."
    - name: "audit_year"
      expr: YEAR(audit_start_date)
      comment: "Year the audit started — supports annual compliance program reporting."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit events — baseline volume metric for compliance program coverage."
    - name: "open_audits"
      expr: COUNT(CASE WHEN closure_status != 'Closed' THEN 1 END)
      comment: "Number of audits not yet closed — high open count signals compliance program backlog risk."
    - name: "high_risk_audits"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of audits rated high risk — executives use this to prioritize remediation resources."
    - name: "audit_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closure_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that have been closed — key KPI for compliance program effectiveness and velocity."
    - name: "audits_with_corrective_action_overdue"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE AND closure_status != 'Closed' THEN 1 END)
      comment: "Audits where the corrective action due date has passed but the audit is still open — a critical risk indicator for regulatory exposure."
    - name: "distinct_auditing_bodies"
      expr: COUNT(DISTINCT auditing_body)
      comment: "Number of distinct auditing bodies engaged — reflects breadth of third-party oversight and certification coverage."
    - name: "distinct_audit_standards_covered"
      expr: COUNT(DISTINCT audit_standard)
      comment: "Number of distinct standards audited against — measures compliance program scope and regulatory coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance audit findings — tracks finding severity, resolution velocity, and corrective action effectiveness to drive quality and regulatory risk reduction."
  source: "`vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (major non-conformance, minor non-conformance, observation) — drives prioritization."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the finding — used to triage and escalate high-risk compliance gaps."
    - name: "compliance_audit_finding_status"
      expr: compliance_audit_finding_status
      comment: "Current status of the finding (open, in-progress, closed, verified) — tracks resolution pipeline."
    - name: "clause_violated"
      expr: clause_violated
      comment: "Specific regulatory or standard clause violated — identifies systemic compliance weaknesses."
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Root cause analysis method used (5-Why, Fishbone, etc.) — assesses rigor of corrective action."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the finding is targeted for closure — used for workload forecasting and deadline tracking."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the finding was created — supports trend analysis of finding discovery rates."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline measure for compliance finding volume."
    - name: "open_findings"
      expr: COUNT(CASE WHEN compliance_audit_finding_status NOT IN ('Closed', 'Verified') THEN 1 END)
      comment: "Number of findings not yet closed or verified — open finding backlog is a direct regulatory risk indicator."
    - name: "overdue_findings"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND compliance_audit_finding_status NOT IN ('Closed', 'Verified') THEN 1 END)
      comment: "Findings past their target completion date without closure — signals corrective action program failure and regulatory exposure."
    - name: "finding_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_audit_finding_status IN ('Closed', 'Verified') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that have been closed or verified — primary KPI for corrective action program effectiveness."
    - name: "high_risk_findings"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Count of high-risk findings — executives use this to assess severity of compliance gaps and prioritize remediation investment."
    - name: "findings_with_preventive_action"
      expr: COUNT(CASE WHEN preventive_action_plan IS NOT NULL AND preventive_action_plan != '' THEN 1 END)
      comment: "Findings that have a documented preventive action plan — measures maturity of the compliance corrective action program."
    - name: "findings_effectiveness_verified"
      expr: COUNT(CASE WHEN effectiveness_verification_date IS NOT NULL THEN 1 END)
      comment: "Findings where effectiveness of the corrective action has been verified — a quality systems maturity indicator required by ISO standards."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for compliance certifications — tracks certification health, expiry risk, and audit readiness across the semiconductor enterprise."
  source: "`vibe_semiconductors_v1`.`compliance`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (ISO 9001, ISO 14001, IATF 16949, etc.) — used to track coverage by standard."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, suspended, expired, pending) — primary health indicator."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category (quality, environmental, safety, export) — enables cross-category portfolio analysis."
    - name: "compliance_risk_level"
      expr: compliance_risk_level
      comment: "Risk level associated with the certification — used to prioritize renewal and audit resources."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification — tracks registrar relationships and audit body diversity."
    - name: "process_area"
      expr: process_area
      comment: "Process area covered by the certification — maps certifications to operational scope."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires — used for renewal planning and budget forecasting."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued — supports certification age and renewal cycle analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certifications held — baseline measure for compliance certification portfolio size."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active certifications — directly reflects the company's compliance standing with customers and regulators."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Certifications expiring within 90 days — critical early-warning KPI for renewal risk management."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE AND certification_status != 'Expired' THEN 1 END)
      comment: "Certifications that have passed their expiry date but are not yet marked expired — identifies compliance data quality and governance gaps."
    - name: "recertification_required_count"
      expr: COUNT(CASE WHEN recertification_required = TRUE THEN 1 END)
      comment: "Number of certifications requiring recertification — drives renewal workload planning and resource allocation."
    - name: "internal_audit_required_count"
      expr: COUNT(CASE WHEN internal_audit_required = TRUE THEN 1 END)
      comment: "Certifications requiring internal audits — used to plan internal audit program capacity."
    - name: "certification_active_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications currently active — executive-level health score for the compliance certification portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_export_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export control KPIs — tracks license portfolio health, utilization ceiling, and expiry risk to ensure EAR/ITAR compliance and prevent shipment holds."
  source: "`vibe_semiconductors_v1`.`compliance`.`export_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of export license (STA, individual, license exception) — used to analyze license portfolio composition."
    - name: "export_license_status"
      expr: export_license_status
      comment: "Current status of the license (active, expired, revoked, pending) — primary health indicator for export compliance."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Government authority that issued the license (BIS, DDTC, etc.) — tracks regulatory body relationships."
    - name: "registration_category"
      expr: registration_category
      comment: "USML or EAR registration category — used to segment licenses by controlled technology type."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the license became effective — supports license vintage and renewal cycle analysis."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the license requires renewal — used to plan renewal workload and avoid lapses."
  measures:
    - name: "total_export_licenses"
      expr: COUNT(1)
      comment: "Total number of export licenses in the portfolio — baseline measure for export control program scope."
    - name: "active_export_licenses"
      expr: COUNT(CASE WHEN export_license_status = 'Active' THEN 1 END)
      comment: "Number of currently active export licenses — directly determines which shipments can legally proceed."
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(CASE WHEN effective_until BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Export licenses expiring within 90 days — critical risk indicator; expired licenses halt shipments and create revenue risk."
    - name: "total_authorized_value_ceiling_usd"
      expr: SUM(CAST(value_ceiling AS DOUBLE))
      comment: "Total authorized value ceiling across all export licenses in USD — measures the aggregate export authorization capacity of the business."
    - name: "avg_authorized_value_ceiling_usd"
      expr: AVG(CAST(value_ceiling AS DOUBLE))
      comment: "Average authorized value ceiling per export license — used to benchmark license sizing and identify under-authorized licenses."
    - name: "licenses_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required = TRUE THEN 1 END)
      comment: "Number of licenses flagged for renewal — drives export compliance team workload planning."
    - name: "distinct_issuing_authorities"
      expr: COUNT(DISTINCT issuing_authority)
      comment: "Number of distinct government authorities that have issued licenses — reflects regulatory jurisdiction breadth of the export program."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_export_license_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export license utilization KPIs — tracks declared value, license balance consumption, and usage patterns to prevent over-utilization and ensure EAR/ITAR compliance."
  source: "`vibe_semiconductors_v1`.`compliance`.`export_license_usage`"
  dimensions:
    - name: "export_license_usage_status"
      expr: export_license_usage_status
      comment: "Status of the usage record (pending, approved, shipped, rejected) — tracks usage pipeline."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the usage transaction — identifies non-compliant shipments requiring intervention."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the export — used for geographic risk analysis and restricted country monitoring."
    - name: "export_license_type"
      expr: export_license_type
      comment: "Type of export license used for the transaction — supports license type utilization analysis."
    - name: "export_control_regulation"
      expr: export_control_regulation
      comment: "Applicable export control regulation (EAR, ITAR, etc.) — segments usage by regulatory framework."
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Whether the export transaction involves sensitive technology — used to flag high-risk transactions for enhanced review."
    - name: "export_month"
      expr: DATE_TRUNC('MONTH', export_date)
      comment: "Month of the export transaction — supports monthly export volume and value trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the declared value — used for multi-currency export value analysis."
  measures:
    - name: "total_export_transactions"
      expr: COUNT(1)
      comment: "Total number of export license usage transactions — baseline volume metric for export activity."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared value of all export transactions — key financial metric for export program scale and license ceiling utilization."
    - name: "avg_declared_value_per_transaction"
      expr: AVG(CAST(declared_value AS DOUBLE))
      comment: "Average declared value per export transaction — used to benchmark transaction sizing and detect anomalies."
    - name: "total_quantity_exported"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items exported across all transactions — measures physical export volume for license utilization tracking."
    - name: "avg_license_utilization_pct"
      expr: AVG(CAST(cumulative_license_utilization_percent AS DOUBLE))
      comment: "Average cumulative license utilization percentage across transactions — licenses approaching 100% require immediate renewal to prevent shipment holds."
    - name: "total_license_balance_remaining"
      expr: SUM(CAST(license_balance_remaining AS DOUBLE))
      comment: "Total remaining license balance across all active usage records — measures aggregate export authorization headroom."
    - name: "sensitive_transaction_count"
      expr: COUNT(CASE WHEN is_sensitive = TRUE THEN 1 END)
      comment: "Number of sensitive export transactions — high-risk transactions requiring enhanced compliance review and executive awareness."
    - name: "distinct_destination_countries"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of distinct destination countries — measures geographic reach of exports and breadth of restricted-country screening requirements."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_obligation_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation management KPIs — tracks compliance status, remediation progress, and risk exposure across all regulatory obligations to steer the enterprise compliance program."
  source: "`vibe_semiconductors_v1`.`compliance`.`obligation_register`"
  dimensions:
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of the regulatory obligation (environmental, export, labor, financial) — enables cross-category compliance portfolio analysis."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation (reporting, operational, financial, training) — used to segment obligations by nature."
    - name: "current_compliance_status"
      expr: current_compliance_status
      comment: "Current compliance status of the obligation (compliant, non-compliant, at-risk, under-review) — primary risk indicator."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation — used to prioritize remediation resources and executive attention."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the obligation record — tracks active vs. retired obligations."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation (US, EU, China, etc.) — enables geographic compliance risk analysis."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body enforcing the obligation (SEC, EPA, BIS, etc.) — tracks regulator relationships."
    - name: "responsible_function"
      expr: responsible_function
      comment: "Business function responsible for the obligation — used to allocate compliance workload and accountability."
    - name: "next_review_month"
      expr: DATE_TRUNC('MONTH', next_review_date)
      comment: "Month of the next scheduled review — used for compliance calendar planning."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations tracked — baseline measure for compliance program scope."
    - name: "non_compliant_obligations"
      expr: COUNT(CASE WHEN current_compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of obligations currently in non-compliant status — the most critical compliance risk KPI; each non-compliant obligation represents potential regulatory penalty exposure."
    - name: "at_risk_obligations"
      expr: COUNT(CASE WHEN current_compliance_status = 'At-Risk' THEN 1 END)
      comment: "Number of obligations flagged as at-risk — leading indicator of future non-compliance requiring proactive intervention."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN current_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations in compliant status — headline KPI for the enterprise compliance program reported to the board and audit committee."
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk obligations — executives use this to prioritize compliance investment and remediation resources."
    - name: "obligations_with_active_remediation"
      expr: COUNT(CASE WHEN remediation_plan IS NOT NULL AND remediation_plan != '' THEN 1 END)
      comment: "Obligations that have an active remediation plan — measures the organization's responsiveness to identified compliance gaps."
    - name: "overdue_remediation_obligations"
      expr: COUNT(CASE WHEN remediation_target_date < CURRENT_DATE AND current_compliance_status != 'Compliant' THEN 1 END)
      comment: "Obligations where the remediation target date has passed without achieving compliance — signals systemic remediation failure and escalating regulatory risk."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with tracked obligations — measures geographic regulatory footprint of the enterprise."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_chips_act_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CHIPS Act compliance KPIs — tracks funding utilization, compliance metric achievement, and obligation status to ensure adherence to CHIPS Act award conditions and avoid clawback risk."
  source: "`vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`"
  dimensions:
    - name: "chips_act_obligation_status"
      expr: chips_act_obligation_status
      comment: "Current status of the CHIPS Act obligation (active, fulfilled, at-risk, breached) — primary compliance health indicator."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status against the specific obligation metric — tracks whether targets are being met."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of CHIPS Act obligation (domestic production, workforce training, childcare, guardrail) — segments obligations by requirement category."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How frequently the obligation is measured (quarterly, annual) — used for reporting calendar planning."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for the obligation — enables period-over-period compliance trend analysis."
    - name: "funding_currency"
      expr: funding_currency
      comment: "Currency of the CHIPS Act funding award — used for multi-currency financial analysis."
    - name: "clawback_condition"
      expr: clawback_condition
      comment: "Whether a clawback condition applies — obligations with clawback conditions require heightened monitoring."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the obligation became effective — supports multi-year CHIPS Act program tracking."
  measures:
    - name: "total_chips_obligations"
      expr: COUNT(1)
      comment: "Total number of CHIPS Act obligations tracked — baseline measure for CHIPS Act compliance program scope."
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total CHIPS Act funding amount across all obligations — measures aggregate federal investment and corresponding compliance commitment."
    - name: "avg_compliance_actual"
      expr: AVG(CAST(compliance_actual AS DOUBLE))
      comment: "Average actual compliance metric value across obligations — measures overall achievement against CHIPS Act targets."
    - name: "total_compliance_actual"
      expr: SUM(CAST(compliance_actual AS DOUBLE))
      comment: "Total actual compliance metric value — used to aggregate performance across all CHIPS Act obligation metrics."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value across all CHIPS Act obligations — denominator for aggregate compliance achievement rate."
    - name: "obligations_with_clawback_risk"
      expr: COUNT(CASE WHEN clawback_condition = TRUE AND chips_act_obligation_status != 'Fulfilled' THEN 1 END)
      comment: "Obligations with clawback conditions that are not yet fulfilled — represents direct financial risk of funding recovery by the government."
    - name: "workforce_training_obligations"
      expr: COUNT(CASE WHEN workforce_training_requirement = TRUE THEN 1 END)
      comment: "Number of obligations with workforce training requirements — drives HR and training program planning for CHIPS Act compliance."
    - name: "domestic_production_obligations"
      expr: COUNT(CASE WHEN domestic_production_commitment = TRUE THEN 1 END)
      comment: "Number of obligations with domestic production commitments — tracks the core manufacturing mandate of CHIPS Act awards."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_restricted_party_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade compliance screening KPIs — tracks screening volume, match rates, escalation rates, and risk scores to manage restricted party exposure and prevent export violations."
  source: "`vibe_semiconductors_v1`.`compliance`.`restricted_party_screening`"
  dimensions:
    - name: "restricted_party_screening_status"
      expr: restricted_party_screening_status
      comment: "Current status of the screening (pending, cleared, escalated, blocked) — primary operational status for screening queue management."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the screening (cleared, denied, escalated, pending review) — used to analyze screening outcomes."
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (customer, supplier, end-user, individual) — segments screening activity by entity category."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the screened entity — used to prioritize review resources."
    - name: "match_result"
      expr: match_result
      comment: "Result of the screening match (no match, potential match, confirmed match) — key indicator of restricted party exposure."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the screening required escalation to compliance management — tracks escalation burden."
    - name: "is_manual"
      expr: is_manual
      comment: "Whether the screening was performed manually vs. automated — used to assess automation coverage and manual review workload."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month the screening was performed — supports trend analysis of screening volume and match rates."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of restricted party screenings performed — baseline volume metric for trade compliance program activity."
    - name: "confirmed_match_count"
      expr: COUNT(CASE WHEN match_result = 'Confirmed Match' THEN 1 END)
      comment: "Number of screenings resulting in a confirmed restricted party match — the most critical trade compliance risk KPI; each confirmed match requires immediate action."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring escalation — high escalation rates signal either increased risk exposure or screening threshold calibration issues."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screenings — used to calibrate screening sensitivity and assess overall restricted party risk level."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of screened entities — measures aggregate risk level of the customer and partner portfolio."
    - name: "manual_screening_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings performed manually — high manual rates indicate automation gaps that increase compliance cost and cycle time."
    - name: "distinct_entities_screened"
      expr: COUNT(DISTINCT screened_entity_name)
      comment: "Number of distinct entities screened — measures breadth of restricted party screening coverage across the business partner ecosystem."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_trade_compliance_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade compliance hold KPIs — tracks hold volume, financial exposure, and resolution velocity to minimize revenue impact from export control holds."
  source: "`vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the trade compliance hold (active, released, escalated, cancelled) — primary operational status."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (export control, restricted party, license required, ITAR) — used to analyze hold root causes."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Specific reason code for the hold — enables root cause analysis and systemic issue identification."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the held transaction — identifies high-risk geographic corridors."
    - name: "export_control_regulation"
      expr: export_control_regulation
      comment: "Export control regulation triggering the hold (EAR, ITAR, etc.) — segments holds by regulatory framework."
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Whether the held transaction involves sensitive technology — used to prioritize review of high-risk holds."
    - name: "hold_placed_month"
      expr: DATE_TRUNC('MONTH', hold_placed_timestamp)
      comment: "Month the hold was placed — supports trend analysis of hold frequency and financial impact over time."
    - name: "triggering_transaction_type"
      expr: triggering_transaction_type
      comment: "Type of transaction that triggered the hold (order, shipment, invoice) — used to identify which transaction types generate the most compliance holds."
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of trade compliance holds — baseline volume metric for export control hold activity."
    - name: "active_holds"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN 1 END)
      comment: "Number of currently active holds — directly represents blocked revenue and shipment pipeline."
    - name: "total_estimated_value_held_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of transactions currently on hold in USD — measures the financial revenue risk from active trade compliance holds."
    - name: "avg_estimated_value_per_hold_usd"
      expr: AVG(CAST(estimated_value_usd AS DOUBLE))
      comment: "Average estimated value per hold — used to assess the typical financial impact of a compliance hold event."
    - name: "total_gross_amount_held_usd"
      expr: SUM(CAST(gross_amount_usd AS DOUBLE))
      comment: "Total gross amount of held transactions in USD — provides a comprehensive view of financial exposure from trade compliance holds."
    - name: "sensitive_holds_count"
      expr: COUNT(CASE WHEN is_sensitive = TRUE THEN 1 END)
      comment: "Number of holds involving sensitive technology — these require priority resolution due to heightened regulatory scrutiny."
    - name: "distinct_destination_countries_held"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of distinct destination countries with active holds — measures geographic breadth of export control risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_substance_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical substance compliance KPIs — tracks hazardous substance inventory, regulatory restriction status, and risk scores to manage RoHS, REACH, PFAS, and ITAR chemical compliance."
  source: "`vibe_semiconductors_v1`.`compliance`.`substance_inventory`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the substance (compliant, non-compliant, under-review) — primary regulatory health indicator."
    - name: "substance_type"
      expr: substance_type
      comment: "Type of substance (chemical, gas, solvent, dopant) — used to segment inventory by substance category."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the substance (GHS category) — used for safety and regulatory risk analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the substance record (active, phased-out, restricted) — tracks substance portfolio health."
    - name: "controlled_substance_category"
      expr: controlled_substance_category
      comment: "Category of controlled substance classification — used to segment by regulatory control type."
    - name: "is_reach_svhc"
      expr: is_reach_svhc
      comment: "Whether the substance is on the REACH SVHC candidate list — REACH SVHC substances require mandatory customer disclosure."
    - name: "is_rohs_restricted"
      expr: is_rohs_restricted
      comment: "Whether the substance is restricted under RoHS — RoHS restrictions directly affect product market access in the EU."
    - name: "is_pfas"
      expr: is_pfas
      comment: "Whether the substance is a PFAS compound — PFAS substances face increasing global regulatory restrictions."
    - name: "is_itar_controlled"
      expr: is_itar_controlled
      comment: "Whether the substance is ITAR-controlled — ITAR substances require export licenses and strict access controls."
  measures:
    - name: "total_substances"
      expr: COUNT(1)
      comment: "Total number of substances in the compliance inventory — baseline measure for chemical compliance program scope."
    - name: "restricted_substances_count"
      expr: COUNT(CASE WHEN is_rohs_restricted = TRUE OR is_reach_svhc = TRUE OR is_pfas = TRUE THEN 1 END)
      comment: "Number of substances subject to major regulatory restrictions (RoHS, REACH SVHC, PFAS) — measures the regulatory risk footprint of the chemical inventory."
    - name: "total_annual_usage_volume_kg"
      expr: SUM(CAST(annual_usage_volume_kg AS DOUBLE))
      comment: "Total annual usage volume of all substances in kilograms — used for regulatory reporting thresholds and environmental impact assessment."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all substances in inventory — measures aggregate chemical compliance risk level of the manufacturing process."
    - name: "itar_controlled_substances"
      expr: COUNT(CASE WHEN is_itar_controlled = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled substances — each requires strict access controls and export licensing; critical for defense-related semiconductor programs."
    - name: "non_compliant_substances"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of substances in non-compliant status — non-compliant substances can block product shipments and trigger regulatory penalties."
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_percent AS DOUBLE))
      comment: "Average purity percentage across substances — used for process quality and regulatory specification compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing KPIs — tracks filing volume, status, timeliness, and impact severity to ensure on-time regulatory submissions and manage compliance obligations."
  source: "`vibe_semiconductors_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Current status of the regulatory filing (submitted, acknowledged, pending, rejected) — primary operational status."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (annual report, incident report, change notification) — used to segment filing activity by type."
    - name: "regulatory_filing_category"
      expr: regulatory_filing_category
      comment: "Category of the regulatory filing — enables cross-category filing portfolio analysis."
    - name: "agency"
      expr: agency
      comment: "Regulatory agency receiving the filing (SEC, EPA, BIS, CHIPS Program Office) — tracks filing activity by regulator."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the filing — enables geographic regulatory compliance analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of the regulatory change or filing impact — used to prioritize response and resource allocation."
    - name: "action_status"
      expr: action_status
      comment: "Status of required actions associated with the filing — tracks action completion pipeline."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of filing submission — supports annual regulatory filing volume and compliance trend analysis."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the filing is confidential — used to manage access controls and disclosure obligations."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings — baseline measure for regulatory filing program volume."
    - name: "pending_filings"
      expr: COUNT(CASE WHEN regulatory_filing_status = 'Pending' THEN 1 END)
      comment: "Number of filings in pending status — pending filings represent unresolved regulatory obligations that may have deadlines."
    - name: "overdue_action_filings"
      expr: COUNT(CASE WHEN action_deadline < CURRENT_DATE AND action_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Filings with overdue required actions — missed regulatory deadlines can result in penalties, fines, or loss of operating licenses."
    - name: "high_impact_filings"
      expr: COUNT(CASE WHEN impact_severity = 'High' THEN 1 END)
      comment: "Number of high-impact regulatory filings — executives use this to prioritize compliance response resources and assess regulatory risk."
    - name: "filing_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= action_deadline THEN 1 END) / NULLIF(COUNT(CASE WHEN action_deadline IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of filings submitted on or before the action deadline — headline KPI for regulatory filing timeliness and compliance program discipline."
    - name: "distinct_agencies_filed_with"
      expr: COUNT(DISTINCT agency)
      comment: "Number of distinct regulatory agencies filed with — measures breadth of regulatory engagement and compliance program scope."
    - name: "distinct_jurisdictions_filed"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with regulatory filings — measures geographic regulatory footprint."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_technology_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology control plan KPIs — tracks export control coverage, plan health, and review compliance for controlled semiconductor technology to manage ITAR/EAR deemed export risk."
  source: "`vibe_semiconductors_v1`.`compliance`.`technology_control_plan`"
  dimensions:
    - name: "technology_control_plan_status"
      expr: technology_control_plan_status
      comment: "Current status of the technology control plan (active, expired, under-review, superseded) — primary health indicator."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of technology control plan (ITAR, EAR, dual-use) — segments plans by regulatory framework."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the plan (compliant, non-compliant, at-risk) — used to identify plans requiring immediate attention."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the plan (ITAR, EAR, TSCA) — enables framework-level compliance analysis."
    - name: "review_status"
      expr: review_status
      comment: "Status of the most recent plan review — tracks review cycle compliance."
    - name: "is_deemed_export"
      expr: is_deemed_export
      comment: "Whether the plan covers deemed export scenarios (foreign nationals accessing controlled technology) — deemed export plans require heightened controls."
    - name: "export_license_required"
      expr: export_license_required
      comment: "Whether an export license is required under this plan — plans requiring licenses need active license management."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the plan became effective — supports plan vintage and review cycle analysis."
  measures:
    - name: "total_control_plans"
      expr: COUNT(1)
      comment: "Total number of technology control plans — baseline measure for export control program coverage."
    - name: "active_control_plans"
      expr: COUNT(CASE WHEN technology_control_plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active technology control plans — active plans represent the live export control framework protecting controlled technology."
    - name: "plans_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Technology control plans expiring within 90 days — expired plans create uncontrolled access to restricted technology, a critical ITAR/EAR violation risk."
    - name: "deemed_export_plans"
      expr: COUNT(CASE WHEN is_deemed_export = TRUE THEN 1 END)
      comment: "Number of plans covering deemed export scenarios — deemed export violations carry severe penalties; this count drives HR and access control program requirements."
    - name: "plans_requiring_license"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN 1 END)
      comment: "Number of technology control plans that require an export license — drives export license procurement and maintenance workload."
    - name: "plans_overdue_for_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE AND technology_control_plan_status = 'Active' THEN 1 END)
      comment: "Active plans that are past their scheduled review date — overdue reviews represent compliance gaps that regulators can cite during audits."
    - name: "training_required_plans"
      expr: COUNT(CASE WHEN training_required = TRUE THEN 1 END)
      comment: "Number of plans with mandatory training requirements — drives compliance training program planning and workforce certification tracking."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_conflict_minerals_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict minerals compliance KPIs — tracks declaration status, conflict-free rates, and audit outcomes to meet SEC Form SD and OECD due diligence requirements."
  source: "`vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of the conflict minerals declaration (filed, pending, under-review, expired) — primary compliance status."
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of declaration (SEC Form SD, customer declaration, internal) — segments declarations by reporting requirement."
    - name: "drc_conflict_free_status"
      expr: drc_conflict_free_status
      comment: "DRC conflict-free status (conflict-free, not conflict-free, undeterminable) — the core compliance outcome for conflict minerals reporting."
    - name: "audit_outcome"
      expr: audit_outcome
      comment: "Outcome of the conflict minerals audit — used to assess supply chain due diligence effectiveness."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the minerals — used to identify high-risk sourcing geographies."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year of the declaration — supports year-over-year conflict minerals compliance trend analysis."
    - name: "third_party_verification"
      expr: third_party_verification
      comment: "Whether the declaration was independently verified by a third party — third-party verification is required for SEC Form SD compliance."
    - name: "is_conflict_free"
      expr: is_conflict_free
      comment: "Whether the declaration certifies conflict-free status — the primary binary compliance outcome."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of conflict minerals declarations — baseline measure for conflict minerals compliance program scope."
    - name: "conflict_free_declarations"
      expr: COUNT(CASE WHEN is_conflict_free = TRUE THEN 1 END)
      comment: "Number of declarations certified as conflict-free — the primary compliance achievement metric for conflict minerals reporting."
    - name: "conflict_free_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_conflict_free = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations certified as conflict-free — headline KPI for conflict minerals compliance program; reported to SEC and major customers."
    - name: "third_party_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN third_party_verification = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations with independent third-party verification — measures rigor of the conflict minerals due diligence program."
    - name: "avg_conflict_minerals_percentage"
      expr: AVG(CAST(conflict_minerals_percentage AS DOUBLE))
      comment: "Average conflict minerals percentage across declarations — measures the aggregate concentration of conflict minerals in the supply chain."
    - name: "avg_compliance_risk_score"
      expr: AVG(CAST(compliance_risk_score AS DOUBLE))
      comment: "Average compliance risk score across conflict minerals declarations — measures aggregate supply chain conflict minerals risk level."
    - name: "total_material_weight_kg"
      expr: SUM(CAST(total_material_weight_kg AS DOUBLE))
      comment: "Total material weight covered by conflict minerals declarations in kilograms — measures the physical scale of the conflict minerals compliance program."
$$;