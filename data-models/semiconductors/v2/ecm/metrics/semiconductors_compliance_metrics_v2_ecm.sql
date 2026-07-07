-- Metric views for domain: compliance | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit performance and finding metrics for certification and regulatory adherence"
  source: "`vibe_semiconductors_v1`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (internal, external, surveillance, etc.)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_standard"
      expr: audit_standard
      comment: "Standard or regulation audited against (ISO 9001, IATF 16949, etc.)"
    - name: "audit_conclusion"
      expr: audit_conclusion
      comment: "Overall conclusion of the audit"
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year the audit was conducted"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(actual_start_date), '-', YEAR(actual_start_date))
      comment: "Quarter the audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month the audit was conducted"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted"
    - name: "total_findings"
      expr: SUM(CAST(finding_count AS BIGINT))
      comment: "Total number of audit findings across all audits"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(finding_count AS DOUBLE))
      comment: "Average number of findings per audit"
    - name: "total_major_nonconformities"
      expr: SUM(CAST(major_nonconformity_count AS BIGINT))
      comment: "Total number of major nonconformities identified"
    - name: "total_minor_nonconformities"
      expr: SUM(CAST(minor_nonconformity_count AS BIGINT))
      comment: "Total number of minor nonconformities identified"
    - name: "total_observations"
      expr: SUM(CAST(observation_count AS BIGINT))
      comment: "Total number of observations noted"
    - name: "major_nonconformity_rate"
      expr: ROUND(100.0 * SUM(CAST(major_nonconformity_count AS BIGINT)) / NULLIF(SUM(CAST(finding_count AS BIGINT)), 0), 2)
      comment: "Percentage of findings that are major nonconformities"
    - name: "audits_with_major_nc"
      expr: SUM(CASE WHEN CAST(major_nonconformity_count AS BIGINT) > 0 THEN 1 ELSE 0 END)
      comment: "Number of audits with at least one major nonconformity"
    - name: "unique_sites_audited"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of unique sites audited"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification lifecycle and audit readiness metrics for quality and regulatory compliance"
  source: "`vibe_semiconductors_v1`.`compliance`.`certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification"
    - name: "standard"
      expr: standard
      comment: "Certification standard (ISO 9001, IATF 16949, etc.)"
    - name: "certifying_body"
      expr: body
      comment: "Certification body that issued the certificate"
    - name: "certification_year"
      expr: YEAR(effective_date)
      comment: "Year the certification became effective"
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certifications"
    - name: "active_certifications"
      expr: SUM(CASE WHEN certification_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of certifications currently active"
    - name: "expired_certifications"
      expr: SUM(CASE WHEN certification_status = 'Expired' THEN 1 ELSE 0 END)
      comment: "Number of certifications that have expired"
    - name: "total_nonconformities"
      expr: SUM(CAST(nonconformity_count AS BIGINT))
      comment: "Total number of nonconformities across all certifications"
    - name: "avg_nonconformities_per_cert"
      expr: AVG(CAST(nonconformity_count AS DOUBLE))
      comment: "Average number of nonconformities per certification"
    - name: "unique_sites_certified"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of unique sites with certifications"
    - name: "unique_products_certified"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products covered by certifications"
    - name: "unique_standards"
      expr: COUNT(DISTINCT standard)
      comment: "Number of unique certification standards held"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_chips_act_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CHIPS Act funding compliance and reporting obligation metrics"
  source: "`vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of CHIPS Act obligation"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation"
    - name: "guardrail_provision"
      expr: guardrail_provision
      comment: "Specific guardrail provision applicable"
    - name: "clawback_risk"
      expr: clawback_risk_flag
      comment: "Whether there is clawback risk for this obligation"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for the obligation"
    - name: "obligation_year"
      expr: YEAR(compliance_deadline)
      comment: "Year of compliance deadline"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of CHIPS Act obligations"
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount_usd AS DOUBLE))
      comment: "Total CHIPS Act funding amount in USD"
    - name: "avg_funding_amount"
      expr: AVG(CAST(funding_amount_usd AS DOUBLE))
      comment: "Average funding amount per obligation"
    - name: "clawback_risk_count"
      expr: SUM(CASE WHEN clawback_risk_flag = true THEN 1 ELSE 0 END)
      comment: "Number of obligations with clawback risk"
    - name: "clawback_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN clawback_risk_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations with clawback risk"
    - name: "funding_at_risk"
      expr: SUM(CASE WHEN clawback_risk_flag = true THEN CAST(funding_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total funding amount at risk of clawback"
    - name: "compliant_obligations"
      expr: SUM(CASE WHEN obligation_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Number of obligations in compliant status"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN obligation_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations in compliant status"
    - name: "unique_sites_obligated"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of unique sites with CHIPS Act obligations"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding resolution and corrective action effectiveness metrics"
  source: "`vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (major nonconformity, minor nonconformity, observation, etc.)"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, closed, overdue, etc.)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the finding"
    - name: "effectiveness_verified"
      expr: effectiveness_verified_flag
      comment: "Whether corrective action effectiveness has been verified"
    - name: "finding_year"
      expr: YEAR(due_date)
      comment: "Year the finding is due for closure"
    - name: "finding_quarter"
      expr: CONCAT('Q', QUARTER(due_date), '-', YEAR(due_date))
      comment: "Quarter the finding is due for closure"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "open_findings"
      expr: SUM(CASE WHEN finding_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Number of findings currently open"
    - name: "closed_findings"
      expr: SUM(CASE WHEN finding_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Number of findings that have been closed"
    - name: "closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN finding_status = 'Closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that have been closed"
    - name: "overdue_findings"
      expr: SUM(CASE WHEN finding_status = 'Overdue' THEN 1 ELSE 0 END)
      comment: "Number of findings past their due date"
    - name: "effectiveness_verified_count"
      expr: SUM(CASE WHEN effectiveness_verified_flag = true THEN 1 ELSE 0 END)
      comment: "Number of findings with verified corrective action effectiveness"
    - name: "effectiveness_verification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN effectiveness_verified_flag = true THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN finding_status = 'Closed' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of closed findings with verified effectiveness"
    - name: "high_risk_findings"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Number of high-risk findings"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_conflict_minerals_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict minerals due diligence and supply chain transparency metrics"
  source: "`vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: declaration_status
      comment: "Status of the conflict minerals declaration"
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Status of supplier due diligence process"
    - name: "drc_conflict_free"
      expr: drc_conflict_free_flag
      comment: "Whether materials are DRC conflict-free"
    - name: "cmrt_version"
      expr: cmrt_version
      comment: "Version of Conflict Minerals Reporting Template used"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for conflict minerals"
    - name: "smelter_list_provided"
      expr: smelter_list_provided_flag
      comment: "Whether supplier provided smelter list"
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of conflict minerals declarations"
    - name: "drc_conflict_free_count"
      expr: SUM(CASE WHEN drc_conflict_free_flag = true THEN 1 ELSE 0 END)
      comment: "Number of declarations certified as DRC conflict-free"
    - name: "drc_conflict_free_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drc_conflict_free_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations that are DRC conflict-free"
    - name: "smelter_list_provided_count"
      expr: SUM(CASE WHEN smelter_list_provided_flag = true THEN 1 ELSE 0 END)
      comment: "Number of declarations with smelter list provided"
    - name: "smelter_list_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN smelter_list_provided_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations with smelter list provided"
    - name: "gold_present_count"
      expr: SUM(CASE WHEN gold_present_flag = true THEN 1 ELSE 0 END)
      comment: "Number of declarations with gold present"
    - name: "tantalum_present_count"
      expr: SUM(CASE WHEN tantalum_present_flag = true THEN 1 ELSE 0 END)
      comment: "Number of declarations with tantalum present"
    - name: "tin_present_count"
      expr: SUM(CASE WHEN tin_present_flag = true THEN 1 ELSE 0 END)
      comment: "Number of declarations with tin present"
    - name: "tungsten_present_count"
      expr: SUM(CASE WHEN tungsten_present_flag = true THEN 1 ELSE 0 END)
      comment: "Number of declarations with tungsten present"
    - name: "unique_suppliers_declaring"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers providing conflict minerals declarations"
    - name: "unique_products_declared"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products with conflict minerals declarations"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_eccn_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export control classification KPIs — tracks ECCN classification coverage, license exception availability, and classification currency to ensure all products are properly classified before export."
  source: "`vibe_semiconductors_v1`.`compliance`.`eccn_classification`"
  dimensions:
    - name: "eccn_code"
      expr: eccn_code
      comment: "The ECCN code assigned to the item (e.g., 3E001, EAR99), used to segment the portfolio by control level."
    - name: "classification_status"
      expr: classification_status
      comment: "Current status of the classification (Active, Expired, Under Review) for portfolio health monitoring."
    - name: "control_reason"
      expr: control_reason
      comment: "Reason for export control (NS, AT, MT, etc.) used to understand the regulatory basis for controls."
    - name: "license_exception_available"
      expr: license_exception_available
      comment: "Whether a license exception is available for this classification, reducing licensing burden."
    - name: "license_exception_type"
      expr: license_exception_type
      comment: "Type of license exception available (e.g., ENC, STA, TMP) for exception utilization analysis."
    - name: "technology_level"
      expr: technology_level
      comment: "Technology level of the classified item, used to assess strategic sensitivity of the portfolio."
    - name: "classification_year"
      expr: YEAR(classification_date)
      comment: "Year the classification was performed, used for classification vintage and refresh cycle analysis."
    - name: "commodity_jurisdiction"
      expr: commodity_jurisdiction
      comment: "Jurisdiction governing the commodity (EAR or ITAR), the most fundamental export control segmentation."
  measures:
    - name: "total_classifications"
      expr: COUNT(1)
      comment: "Total number of ECCN classification records. Baseline measure of classification program scope."
    - name: "active_classification_count"
      expr: COUNT(CASE WHEN classification_status = 'Active' THEN 1 END)
      comment: "Number of currently active ECCN classifications. Measures the size of the actively controlled product portfolio."
    - name: "expired_classification_count"
      expr: COUNT(CASE WHEN classification_status = 'Expired' THEN 1 END)
      comment: "Number of expired ECCN classifications. Expired classifications create export control gaps — products may be shipped without valid authorization."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN classification_status = 'Active' AND expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Active classifications expiring within 90 days. Drives proactive reclassification to prevent export authorization gaps."
    - name: "license_exception_eligible_count"
      expr: COUNT(CASE WHEN license_exception_available = TRUE THEN 1 END)
      comment: "Number of classifications where a license exception is available. Higher counts reduce licensing overhead and accelerate time-to-ship."
    - name: "license_exception_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN license_exception_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of classifications eligible for a license exception. A key efficiency metric — higher rates mean fewer individual licenses needed."
    - name: "itar_controlled_count"
      expr: COUNT(CASE WHEN commodity_jurisdiction = 'ITAR' THEN 1 END)
      comment: "Number of items under ITAR jurisdiction. ITAR items carry the highest compliance burden and penalty risk, requiring dedicated executive oversight."
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN review_date < CURRENT_DATE() AND classification_status = 'Active' THEN 1 END)
      comment: "Active classifications whose scheduled review date has passed. Overdue reviews indicate stale classifications that may no longer reflect current technology controls."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_export_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for export license portfolio management — tracks license value ceilings, expiry risk, and renewal pipeline to ensure uninterrupted shipment authorizations."
  source: "`vibe_semiconductors_v1`.`compliance`.`export_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of export license (e.g., EAR99, ITAR, BIS) used to segment the portfolio by regulatory regime."
    - name: "export_license_status"
      expr: export_license_status
      comment: "Current lifecycle status of the license (Active, Expired, Pending, Revoked) for pipeline and risk analysis."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory body that issued the license (e.g., BIS, DDTC) for authority-level reporting."
    - name: "authorized_countries"
      expr: authorized_countries
      comment: "Countries authorized under the license, enabling geographic compliance coverage analysis."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Boolean flag indicating whether the license requires renewal, used to prioritize renewal workload."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the license became effective, used for cohort and vintage analysis."
    - name: "effective_until_year"
      expr: YEAR(effective_until)
      comment: "Year the license expires, used to identify near-term expiry risk cohorts."
    - name: "usml_category"
      expr: usml_category
      comment: "USML category of the licensed commodity, critical for ITAR compliance segmentation."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the end-use verification process, indicating due-diligence completeness."
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of export licenses in the portfolio. Baseline KPI for license portfolio size and workload."
    - name: "active_license_count"
      expr: COUNT(CASE WHEN export_license_status = 'Active' THEN 1 END)
      comment: "Number of currently active export licenses. Directly measures the organization's authorized export capacity."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN export_license_status = 'Active' AND effective_until <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Active licenses expiring within 90 days. Critical risk KPI — licenses not renewed in time halt shipments and create revenue risk."
    - name: "total_authorized_value_usd"
      expr: SUM(CAST(value_ceiling AS DOUBLE))
      comment: "Sum of all authorized value ceilings across the license portfolio in USD. Measures the total export authorization capacity available to the business."
    - name: "avg_authorized_value_usd"
      expr: AVG(CAST(value_ceiling AS DOUBLE))
      comment: "Average authorized value ceiling per export license. Benchmarks license sizing and identifies under- or over-authorized licenses."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE THEN 1 END)
      comment: "Number of licenses flagged as requiring renewal. Drives renewal workload planning and compliance calendar management."
    - name: "unverified_license_count"
      expr: COUNT(CASE WHEN verification_status != 'Verified' OR verification_status IS NULL THEN 1 END)
      comment: "Licenses without a completed end-use verification. Unverified licenses represent regulatory exposure and potential enforcement risk."
    - name: "license_active_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN export_license_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses that are currently active. Measures the health and utilization of the export license portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_export_license_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export license utilization and compliance tracking metrics for trade control and regulatory adherence"
  source: "`vibe_semiconductors_v1`.`compliance`.`export_license_usage`"
  dimensions:
    - name: "destination_country"
      expr: destination_country_code
      comment: "Destination country for export shipment"
    - name: "export_control_regulation"
      expr: export_control_regulation
      comment: "Applicable export control regulation (EAR, ITAR, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the export license usage"
    - name: "export_license_type"
      expr: export_license_type
      comment: "Type of export license used"
    - name: "export_license_usage_status"
      expr: export_license_usage_status
      comment: "Status of the license usage record"
    - name: "commodity_usml_category"
      expr: commodity_usml_category
      comment: "USML category for controlled commodities"
    - name: "export_year"
      expr: YEAR(export_date)
      comment: "Year of export transaction"
    - name: "export_quarter"
      expr: CONCAT('Q', QUARTER(export_date), '-', YEAR(export_date))
      comment: "Quarter of export transaction"
    - name: "export_month"
      expr: DATE_TRUNC('MONTH', export_date)
      comment: "Month of export transaction"
  measures:
    - name: "total_export_transactions"
      expr: COUNT(1)
      comment: "Total number of export license usage transactions"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared value of all export transactions"
    - name: "avg_declared_value"
      expr: AVG(CAST(declared_value AS DOUBLE))
      comment: "Average declared value per export transaction"
    - name: "avg_license_utilization_pct"
      expr: AVG(CAST(cumulative_license_utilization_percent AS DOUBLE))
      comment: "Average cumulative license utilization percentage across transactions"
    - name: "unique_destination_countries"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of unique destination countries for exports"
    - name: "unique_end_users"
      expr: COUNT(DISTINCT end_user_name)
      comment: "Number of unique end users receiving exports"
    - name: "sensitive_export_count"
      expr: SUM(CASE WHEN is_sensitive = true THEN 1 ELSE 0 END)
      comment: "Count of exports flagged as sensitive"
    - name: "sensitive_export_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_sensitive = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of export transactions flagged as sensitive"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_obligation_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation KPIs — tracks obligation coverage, review currency, and risk ratings to ensure the organization maintains awareness of and compliance with all applicable regulatory requirements."
  source: "`vibe_semiconductors_v1`.`compliance`.`obligation_register`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (Active, Compliant, Non-Compliant, Under Review) for compliance posture monitoring."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (Environmental, Export Control, Labor, Safety) for domain-level compliance analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation (US, EU, China, etc.) for geographic compliance coverage analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation (High, Medium, Low) for prioritization of compliance resources."
    - name: "obligation_source"
      expr: obligation_source
      comment: "Source of the obligation (Regulation, Contract, Permit, Standard) for obligation origin analysis."
    - name: "review_frequency"
      expr: review_frequency
      comment: "Required review frequency (Annual, Quarterly, etc.) for compliance calendar management."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations tracked. Baseline measure of the regulatory compliance program scope."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN obligation_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of obligations currently in non-compliant status. Each non-compliant obligation represents active regulatory exposure with potential penalty consequences."
    - name: "high_risk_obligation_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk regulatory obligations. High-risk obligations require dedicated executive oversight and resource allocation."
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND obligation_status = 'Active' THEN 1 END)
      comment: "Active obligations whose scheduled review date has passed. Overdue reviews indicate stale obligation assessments that may miss regulatory changes."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN obligation_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN obligation_status IN ('Compliant', 'Non-Compliant') THEN 1 END), 0), 2)
      comment: "Percentage of assessed obligations that are compliant. The primary regulatory compliance health metric — declining rates signal systemic compliance failures."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with tracked obligations. Measures the geographic breadth of the regulatory compliance program."
    - name: "overdue_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND obligation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN obligation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active obligations with overdue reviews. A rising rate indicates the compliance team is falling behind on regulatory monitoring obligations."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_reach_svhc_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "REACH SVHC substance declaration and compliance metrics for regulatory adherence"
  source: "`vibe_semiconductors_v1`.`compliance`.`reach_svhc_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: declaration_status
      comment: "Status of the REACH SVHC declaration"
    - name: "svhc_above_threshold"
      expr: svhc_above_threshold_flag
      comment: "Whether SVHC concentration exceeds reporting threshold"
    - name: "svhc_substance_name"
      expr: svhc_substance_name
      comment: "Name of the SVHC substance declared"
    - name: "candidate_list_version"
      expr: candidate_list_version
      comment: "Version of the REACH candidate list used"
    - name: "declaration_year"
      expr: YEAR(declaration_date)
      comment: "Year of declaration"
    - name: "declaration_quarter"
      expr: CONCAT('Q', QUARTER(declaration_date), '-', YEAR(declaration_date))
      comment: "Quarter of declaration"
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of REACH SVHC declarations"
    - name: "above_threshold_count"
      expr: SUM(CASE WHEN svhc_above_threshold_flag = true THEN 1 ELSE 0 END)
      comment: "Number of declarations with SVHC above reporting threshold"
    - name: "above_threshold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN svhc_above_threshold_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations with SVHC above threshold"
    - name: "avg_concentration_pct"
      expr: AVG(CAST(concentration_percent AS DOUBLE))
      comment: "Average SVHC concentration percentage across declarations"
    - name: "total_article_weight"
      expr: SUM(CAST(article_weight_grams AS DOUBLE))
      comment: "Total weight of articles declared in grams"
    - name: "unique_svhc_substances"
      expr: COUNT(DISTINCT svhc_substance_name)
      comment: "Number of unique SVHC substances declared"
    - name: "unique_products_declared"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products with SVHC declarations"
    - name: "unique_suppliers_declaring"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers providing SVHC declarations"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing KPIs — tracks filing submission timeliness, approval rates, and renewal pipeline to ensure continuous regulatory authorization for business operations."
  source: "`vibe_semiconductors_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (Submitted, Approved, Rejected, Pending Renewal) for pipeline monitoring."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (Environmental Permit, Operating License, Safety Certification, etc.) for filing category analysis."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing (EPA, FDA, OSHA, etc.) for authority-level compliance tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the filing for geographic compliance coverage analysis."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of filing submission for annual regulatory activity analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the filing/permit expires, used to identify near-term renewal requirements."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings. Baseline measure of regulatory compliance program scope."
    - name: "approved_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Approved' THEN 1 END)
      comment: "Number of approved regulatory filings. Approved filings represent active regulatory authorizations required for business operations."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected regulatory filings. Rejections may halt operations or require costly remediation and resubmission."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN filing_status = 'Approved' AND expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Approved filings expiring within 90 days. Lapsed regulatory filings can halt manufacturing operations — a critical operational risk KPI."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN filing_status IN ('Approved', 'Rejected') THEN 1 END), 0), 2)
      comment: "Percentage of decided filings that were approved. Measures the quality of regulatory submissions and the organization's regulatory relationship health."
    - name: "overdue_renewal_count"
      expr: COUNT(CASE WHEN renewal_due_date < CURRENT_DATE() AND filing_status = 'Approved' THEN 1 END)
      comment: "Approved filings with overdue renewal submissions. Overdue renewals risk permit lapse and operational shutdown."
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of distinct regulatory bodies with active filings. Measures the breadth of regulatory relationships requiring active management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_restricted_party_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restricted party screening effectiveness and risk detection metrics for trade compliance"
  source: "`vibe_semiconductors_v1`.`compliance`.`restricted_party_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the restricted party screening (match, no match, etc.)"
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening record"
    - name: "entity_type"
      expr: entity_type
      comment: "Type of entity screened (customer, supplier, end user, etc.)"
    - name: "entity_country"
      expr: entity_country
      comment: "Country of the screened entity"
    - name: "list_matched"
      expr: list_matched
      comment: "Restricted party list that triggered a match"
    - name: "screening_provider"
      expr: screening_provider
      comment: "Third-party screening service provider"
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Whether the match was determined to be a false positive"
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year of screening"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of restricted party screenings performed"
    - name: "match_count"
      expr: SUM(CASE WHEN screening_result = 'Match' THEN 1 ELSE 0 END)
      comment: "Number of screenings that resulted in a match"
    - name: "match_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN screening_result = 'Match' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that resulted in a match"
    - name: "false_positive_count"
      expr: SUM(CASE WHEN false_positive_flag = true THEN 1 ELSE 0 END)
      comment: "Number of matches determined to be false positives"
    - name: "false_positive_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN false_positive_flag = true THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN screening_result = 'Match' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of matches that were false positives"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match confidence score across all screenings"
    - name: "unique_entities_screened"
      expr: COUNT(DISTINCT entity_name)
      comment: "Number of unique entities screened"
    - name: "unresolved_match_count"
      expr: SUM(CASE WHEN screening_result = 'Match' AND resolution_date IS NULL THEN 1 ELSE 0 END)
      comment: "Number of matches that remain unresolved"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_substance_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical substance inventory KPIs — tracks SVHC, RoHS, and REACH registration status across the substance portfolio to manage chemical compliance risk and phase-out planning."
  source: "`vibe_semiconductors_v1`.`compliance`.`substance_inventory`"
  dimensions:
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory status of the substance (Authorized, Restricted, Candidate List, Banned) for compliance risk segmentation."
    - name: "substance_category"
      expr: substance_category
      comment: "Category of the substance (Solvent, Metal, Polymer, etc.) for portfolio composition analysis."
    - name: "svhc_flag"
      expr: svhc_flag
      comment: "Whether the substance is on the SVHC Candidate List — the primary REACH compliance risk indicator."
    - name: "rohs_restricted_flag"
      expr: rohs_restricted_flag
      comment: "Whether the substance is restricted under RoHS — critical for electronics market access in EU and other jurisdictions."
    - name: "reach_registered_flag"
      expr: reach_registered_flag
      comment: "Whether the substance is registered under REACH — unregistered substances cannot be legally used above threshold quantities in the EU."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "GHS/CLP hazard classification of the substance for safety and regulatory reporting."
    - name: "phase_out_year"
      expr: YEAR(phase_out_date)
      comment: "Year the substance is scheduled for phase-out, used for substitution planning and supply chain transition management."
  measures:
    - name: "total_substances"
      expr: COUNT(1)
      comment: "Total number of substances in the inventory. Baseline measure of chemical compliance program scope."
    - name: "svhc_substance_count"
      expr: COUNT(CASE WHEN svhc_flag = TRUE THEN 1 END)
      comment: "Number of SVHC substances in the inventory. SVHC substances require mandatory disclosure and drive REACH compliance obligations across the product portfolio."
    - name: "rohs_restricted_substance_count"
      expr: COUNT(CASE WHEN rohs_restricted_flag = TRUE THEN 1 END)
      comment: "Number of RoHS-restricted substances in use. RoHS-restricted substances in products block EU market access and require urgent substitution."
    - name: "unregistered_reach_substance_count"
      expr: COUNT(CASE WHEN reach_registered_flag = FALSE OR reach_registered_flag IS NULL THEN 1 END)
      comment: "Number of substances not registered under REACH. Unregistered substances above threshold quantities cannot be legally used in EU manufacturing."
    - name: "total_annual_usage_kg"
      expr: SUM(CAST(annual_usage_kg AS DOUBLE))
      comment: "Total annual usage of all substances in kilograms. Measures the scale of chemical consumption and drives REACH registration tonnage band requirements."
    - name: "svhc_annual_usage_kg"
      expr: SUM(CASE WHEN svhc_flag = TRUE THEN CAST(annual_usage_kg AS DOUBLE) ELSE 0 END)
      comment: "Total annual usage of SVHC substances in kilograms. Quantifies the volume of highest-risk substances in use — drives substitution priority decisions."
    - name: "phasing_out_within_1_year"
      expr: COUNT(CASE WHEN phase_out_date <= DATE_ADD(CURRENT_DATE(), 365) AND phase_out_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of substances scheduled for phase-out within the next 12 months. Drives urgent supply chain substitution and qualification activities."
    - name: "svhc_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN svhc_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory substances that are SVHC. A rising SVHC rate indicates increasing chemical compliance risk in the manufacturing process."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_technology_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology control plan KPIs — tracks plan coverage, review currency, and approval status to ensure controlled technologies are protected from unauthorized access and export."
  source: "`vibe_semiconductors_v1`.`compliance`.`technology_control_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the technology control plan (Active, Under Review, Expired, Draft) for portfolio health monitoring."
    - name: "approved_by"
      expr: approved_by
      comment: "Individual or role that approved the plan, used for accountability and approval authority analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the plan became effective, used for plan vintage and refresh cycle analysis."
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the plan is scheduled for review, used for review workload planning."
  measures:
    - name: "total_control_plans"
      expr: COUNT(1)
      comment: "Total number of technology control plans. Baseline measure of technology protection program scope."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active technology control plans. Active plans are the primary mechanism for protecting controlled technologies from unauthorized access."
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN review_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 END)
      comment: "Active technology control plans whose scheduled review date has passed. Overdue reviews indicate stale access controls that may no longer reflect current technology or personnel."
    - name: "unapproved_plan_count"
      expr: COUNT(CASE WHEN (approved_by IS NULL OR approved_by = '') AND plan_status = 'Active' THEN 1 END)
      comment: "Active plans without a recorded approval. Unapproved active plans represent a governance gap in the technology protection program."
    - name: "plan_active_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technology control plans that are currently active. Measures the operational coverage of the technology protection program."
    - name: "overdue_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN plan_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active technology control plans with overdue reviews. A rising rate signals deteriorating technology protection governance."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_trade_compliance_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade compliance hold and release cycle time metrics for export control"
  source: "`vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the trade compliance hold"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of compliance hold applied"
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason for placing the compliance hold"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the hold has been escalated"
    - name: "hold_year"
      expr: YEAR(placed_date)
      comment: "Year the hold was placed"
    - name: "hold_quarter"
      expr: CONCAT('Q', QUARTER(placed_date), '-', YEAR(placed_date))
      comment: "Quarter the hold was placed"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', placed_date)
      comment: "Month the hold was placed"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of trade compliance holds placed"
    - name: "active_holds"
      expr: SUM(CASE WHEN hold_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of holds currently active"
    - name: "released_holds"
      expr: SUM(CASE WHEN hold_status = 'Released' THEN 1 ELSE 0 END)
      comment: "Number of holds that have been released"
    - name: "escalated_holds"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Number of holds that have been escalated"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that required escalation"
    - name: "unique_accounts_held"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with compliance holds"
    - name: "unique_orders_held"
      expr: COUNT(DISTINCT order_reference)
      comment: "Number of unique orders placed on compliance hold"
    - name: "unique_shipments_held"
      expr: COUNT(DISTINCT shipment_reference)
      comment: "Number of unique shipments placed on compliance hold"
$$;
