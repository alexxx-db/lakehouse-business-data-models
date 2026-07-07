-- Metric views for domain: member | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_assignment_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assignment Rule business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`assignment_rule`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Effective Until"
      expr: effective_until
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version Code"
      expr: fhir_version_code
    - name: "Is Active"
      expr: is_active
    - name: "Master Entity Identifier"
      expr: master_entity_identifier
    - name: "Record Created At"
      expr: record_created_at
    - name: "Record Source System"
      expr: record_source_system
    - name: "Record Status"
      expr: record_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assignment Rule"
      expr: COUNT(DISTINCT assignment_rule_id)
    - name: "Total Updated By"
      expr: SUM(updated_by)
    - name: "Average Updated By"
      expr: AVG(updated_by)
    - name: "Total Created By"
      expr: SUM(created_by)
    - name: "Average Created By"
      expr: AVG(created_by)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_authorization_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization Document business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`authorization_document`"
  dimensions:
    - name: "Authorization Number"
      expr: authorization_number
    - name: "Authorization Type"
      expr: authorization_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version Code"
      expr: fhir_version_code
    - name: "Is Active"
      expr: is_active
    - name: "Master Entity Identifier"
      expr: master_entity_identifier
    - name: "Member Address"
      expr: member_address
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Authorization Document"
      expr: COUNT(DISTINCT authorization_document_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_authorized_representative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorized Representative business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`authorized_representative`"
  dimensions:
    - name: "Audit Reason"
      expr: audit_reason
    - name: "Authorization End Date"
      expr: authorization_end_date
    - name: "Authorization Scope"
      expr: authorization_scope
    - name: "Authorization Start Date"
      expr: authorization_start_date
    - name: "Authorization Status"
      expr: authorization_status
    - name: "Authorized Representative Status"
      expr: authorized_representative_status
    - name: "Bar Number"
      expr: bar_number
    - name: "Contact Address Line1"
      expr: contact_address_line1
    - name: "Contact City"
      expr: contact_city
    - name: "Contact Country Code"
      expr: contact_country_code
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Contact Postal Code"
      expr: contact_postal_code
    - name: "Contact State Code"
      expr: contact_state_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Authorized Representative"
      expr: COUNT(DISTINCT authorized_representative_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits KPIs tracking COB coverage rates, MSP compliance, verification status, and subrogation flags. Directly impacts claims cost recovery, CMS MSP compliance, and financial performance."
  source: "`vibe_health_insurance_v1`.`member`.`cob_record`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current COB record status (active, inactive, pending verification) for operational COB management."
    - name: "cob_order"
      expr: cob_order
      comment: "COB order (primary, secondary, tertiary) for claims adjudication sequencing and cost recovery analysis."
    - name: "coordination_of_benefits_rule"
      expr: coordination_of_benefits_rule
      comment: "COB rule applied (birthday rule, non-duplication, maintenance of benefits) for adjudication accuracy analysis."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of other-carrier policy for COB population segmentation and recovery strategy."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify COB (member attestation, carrier inquiry, CMS data) for data quality and compliance analysis."
    - name: "is_msp_compliant"
      expr: is_msp_compliant
      comment: "Whether COB record is Medicare Secondary Payer compliant — non-compliance triggers CMS penalties and recovery demands."
    - name: "cob_verification_month"
      expr: DATE_TRUNC('month', cob_verification_date)
      comment: "Month COB was verified for verification currency analysis and re-verification scheduling."
  measures:
    - name: "total_cob_records"
      expr: COUNT(cob_record_id)
      comment: "Total COB records — baseline metric for dual-coverage population size and COB program scope."
    - name: "active_cob_records"
      expr: COUNT(CASE WHEN cob_status = 'active' AND is_active = TRUE THEN cob_record_id END)
      comment: "Count of active COB records — live dual-coverage population for claims adjudication and cost recovery program sizing."
    - name: "msp_non_compliant_records"
      expr: COUNT(CASE WHEN is_msp_compliant = FALSE THEN cob_record_id END)
      comment: "Count of MSP non-compliant COB records — CMS compliance risk metric; non-compliance triggers federal recovery demands and penalties."
    - name: "msp_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_msp_compliant = TRUE THEN cob_record_id END) / NULLIF(COUNT(cob_record_id), 0), 2)
      comment: "Percentage of COB records that are MSP compliant — regulatory compliance KPI; below threshold triggers CMS audit and recovery risk."
    - name: "subrogation_flagged_records"
      expr: COUNT(CASE WHEN is_subrogation_flag = TRUE THEN cob_record_id END)
      comment: "Count of COB records flagged for subrogation — measures subrogation recovery opportunity pipeline for financial recovery program."
    - name: "distinct_members_with_cob"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members with COB records — unduplicated dual-coverage population for COB program investment sizing."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cob_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cob Record business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`cob_record`"
  dimensions:
    - name: "Birthday Rule Applicable"
      expr: birthday_rule_applicable
    - name: "Cob Order"
      expr: cob_order
    - name: "Cob Record Number"
      expr: cob_record_number
    - name: "Cob Status"
      expr: cob_status
    - name: "Cob Verification Date"
      expr: cob_verification_date
    - name: "Coordination Of Benefits Rule"
      expr: coordination_of_benefits_rule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version Code"
      expr: fhir_version_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cob Record"
      expr: COUNT(DISTINCT cob_record_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cobra`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA continuation coverage KPIs tracking election rates, premium collection, exhaustion patterns, and compliance. Drives COBRA program financial management and regulatory notice compliance."
  source: "`vibe_health_insurance_v1`.`member`.`cobra_continuant`"
  dimensions:
    - name: "cobra_continuant_status"
      expr: cobra_continuant_status
      comment: "Current COBRA continuant status (elected, active, exhausted, terminated) for program lifecycle management."
    - name: "qualifying_event_type"
      expr: qualifying_event_type
      comment: "Type of qualifying event triggering COBRA (termination, reduction in hours, divorce, death) for event-level compliance analysis."
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "COBRA premium payment status (current, delinquent, lapsed) for collections and termination risk management."
    - name: "payment_method"
      expr: payment_method
      comment: "COBRA premium payment method for billing operations analysis."
    - name: "cobra_eligibility_indicator"
      expr: cobra_eligibility_indicator
      comment: "Whether individual is COBRA eligible — distinguishes eligible from ineligible continuants."
    - name: "is_exhausted"
      expr: is_exhausted
      comment: "Whether COBRA coverage has been exhausted — exhausted continuants may qualify for marketplace enrollment."
    - name: "election_month"
      expr: DATE_TRUNC('month', election_date)
      comment: "Month COBRA was elected for election trend and seasonal analysis."
  measures:
    - name: "total_cobra_continuants"
      expr: COUNT(cobra_continuant_id)
      comment: "Total COBRA continuant records — baseline COBRA program size for financial liability and administrative cost planning."
    - name: "active_cobra_continuants"
      expr: COUNT(CASE WHEN cobra_continuant_status = 'active' AND is_active = TRUE THEN cobra_continuant_id END)
      comment: "Count of currently active COBRA continuants — live COBRA membership for premium billing and claims cost monitoring."
    - name: "total_cobra_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total COBRA premium billed — revenue metric for COBRA program financial performance and cost recovery analysis."
    - name: "avg_cobra_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average COBRA premium per continuant — benchmarks COBRA affordability and election rate drivers."
    - name: "exhausted_cobra_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exhausted = TRUE THEN cobra_continuant_id END) / NULLIF(COUNT(cobra_continuant_id), 0), 2)
      comment: "Percentage of COBRA continuants who exhausted coverage — measures COBRA program duration utilization and marketplace transition volume."
    - name: "delinquent_payment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN premium_payment_status = 'delinquent' THEN cobra_continuant_id END) / NULLIF(COUNT(cobra_continuant_id), 0), 2)
      comment: "Percentage of COBRA continuants with delinquent premium payments — collections risk metric triggering termination processing and revenue recovery action."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cobra_continuant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cobra Continuant business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`cobra_continuant`"
  dimensions:
    - name: "Cobra Continuant Status"
      expr: cobra_continuant_status
    - name: "Cobra Eligibility Indicator"
      expr: cobra_eligibility_indicator
    - name: "Cobra Eligibility Reason"
      expr: cobra_eligibility_reason
    - name: "Cobra Notice Sent Date"
      expr: cobra_notice_sent_date
    - name: "Cobra Notice Type"
      expr: cobra_notice_type
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Election Date"
      expr: election_date
    - name: "Election Deadline"
      expr: election_deadline
    - name: "Exhaustion Date"
      expr: exhaustion_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cobra Continuant"
      expr: COUNT(DISTINCT cobra_continuant_id)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`consent`"
  dimensions:
    - name: "Authorized Recipient"
      expr: authorized_recipient
    - name: "Collection Method"
      expr: collection_method
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Type"
      expr: consent_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Disclosure Scope"
      expr: disclosure_scope
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consent"
      expr: COUNT(DISTINCT consent_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_dependent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dependent business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`dependent`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Age Out Eligibility Flag"
      expr: age_out_eligibility_flag
    - name: "Chip Eligibility Flag"
      expr: chip_eligibility_flag
    - name: "City"
      expr: city
    - name: "Country"
      expr: country
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Disability Status"
      expr: disability_status
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dependent"
      expr: COUNT(DISTINCT dependent_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_disenrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disenrollment KPIs tracking churn volume, financial refund exposure, termination reasons, and processing efficiency. Directly informs retention strategy, premium reconciliation, and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`member`.`disenrollment`"
  dimensions:
    - name: "disenrollment_status"
      expr: disenrollment_status
      comment: "Current status of the disenrollment record (pending, processed, reversed) for operational workflow management."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for disenrollment (voluntary, non-payment, death, relocation) for churn root cause analysis."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, administrative) for regulatory classification and member rights notification."
    - name: "source"
      expr: source
      comment: "Source system or channel initiating the disenrollment for data lineage and process improvement analysis."
    - name: "eligibility_loss_indicator"
      expr: eligibility_loss_indicator
      comment: "Whether disenrollment resulted in eligibility loss — critical for COBRA notice obligations and continuity of care planning."
    - name: "appeal_rights_notified"
      expr: appeal_rights_notified
      comment: "Whether member was notified of appeal rights — compliance metric for CMS and state DOI regulatory requirements."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month disenrollment became effective for churn trend analysis and seasonal pattern detection."
  measures:
    - name: "total_disenrollments"
      expr: COUNT(disenrollment_id)
      comment: "Total disenrollment volume — primary churn metric for membership retention strategy and premium revenue forecasting."
    - name: "total_refund_gross_amount"
      expr: SUM(CAST(refund_gross_amount AS DOUBLE))
      comment: "Total gross refund amount from disenrollments — financial liability metric for premium reconciliation and cash flow planning."
    - name: "total_refund_net_amount"
      expr: SUM(CAST(refund_net_amount AS DOUBLE))
      comment: "Total net refund amount after adjustments — actual cash outflow from disenrollment processing for financial reporting."
    - name: "avg_refund_net_amount"
      expr: AVG(CAST(refund_net_amount AS DOUBLE))
      comment: "Average net refund per disenrollment — benchmarks typical refund exposure per termination for reserve adequacy assessment."
    - name: "appeal_rights_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_rights_notified = TRUE THEN disenrollment_id END) / NULLIF(COUNT(disenrollment_id), 0), 2)
      comment: "Percentage of disenrollments where member was notified of appeal rights — regulatory compliance rate; below 100% triggers CMS audit risk."
    - name: "eligibility_loss_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_loss_indicator = TRUE THEN disenrollment_id END) / NULLIF(COUNT(disenrollment_id), 0), 2)
      comment: "Percentage of disenrollments resulting in eligibility loss — measures COBRA and continuity of care obligation volume."
    - name: "distinct_disenrolled_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members disenrolled — unduplicated churn headcount for retention program ROI measurement."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level KPIs tracking income distribution, subsidy eligibility, FPL stratification, and multi-plan coverage. Drives ACA subsidy management, exchange market strategy, and household-level risk assessment."
  source: "`vibe_health_insurance_v1`.`member`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current household status for active population filtering and lifecycle analysis."
    - name: "household_type"
      expr: household_type
      comment: "Type of household (individual, family, multi-generational) for benefit design and premium analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status of the household for coverage continuity analysis."
    - name: "aca_subsidy_eligible"
      expr: aca_subsidy_eligible
      comment: "Whether household is ACA subsidy eligible — primary segmentation for exchange market strategy and APTC program management."
    - name: "income_source"
      expr: income_source
      comment: "Source of household income (employment, self-employment, benefits) for income verification and subsidy accuracy analysis."
    - name: "state"
      expr: state
      comment: "State of household residence for geographic market analysis and state-specific regulatory compliance."
    - name: "medicaid_eligible"
      expr: medicaid_eligible
      comment: "Whether household is Medicaid eligible — identifies population at risk of Medicaid churn and exchange enrollment transitions."
    - name: "is_multi_plan"
      expr: is_multi_plan
      comment: "Whether household has multiple plan enrollments — multi-plan households require COB coordination and premium reconciliation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month household record became effective for household formation trend analysis."
  measures:
    - name: "total_households"
      expr: COUNT(household_id)
      comment: "Total household count — baseline metric for exchange market size and ACA subsidy program scope."
    - name: "subsidy_eligible_households"
      expr: COUNT(CASE WHEN aca_subsidy_eligible = TRUE THEN household_id END)
      comment: "Count of ACA subsidy-eligible households — drives APTC program financial exposure and exchange market strategy."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy dollars across households — financial exposure metric for ACA subsidy reconciliation and CMS APTC reporting."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total premium tax credit amount across households — measures ACA tax credit program utilization and financial liability."
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage across households — measures income profile of enrolled population for subsidy adequacy and benefit design."
    - name: "avg_total_income"
      expr: AVG(CAST(total_income AS DOUBLE))
      comment: "Average household total income — income stratification metric for subsidy eligibility modeling and market segmentation."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average household risk score — actuarial metric for premium adequacy assessment and risk pool health monitoring."
    - name: "subsidy_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN aca_subsidy_eligible = TRUE THEN household_id END) / NULLIF(COUNT(household_id), 0), 2)
      comment: "Percentage of households eligible for ACA subsidies — measures income-qualified population share for exchange market positioning."
    - name: "income_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN income_verification_flag = TRUE THEN household_id END) / NULLIF(COUNT(household_id), 0), 2)
      comment: "Percentage of households with verified income — data quality and compliance metric for ACA subsidy accuracy and CMS audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_id_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Id Card business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`id_card`"
  dimensions:
    - name: "Barcode"
      expr: barcode
    - name: "Card Format"
      expr: card_format
    - name: "Card Number"
      expr: card_number
    - name: "Card Type"
      expr: card_type
    - name: "Card Version"
      expr: card_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Service Phone"
      expr: customer_service_phone
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Delivery Confirmation Date"
      expr: delivery_confirmation_date
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "External System Code"
      expr: external_system_code
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Id Card"
      expr: COUNT(DISTINCT id_card_id)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_identity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`identity`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Citizenship Status"
      expr: citizenship_status
    - name: "City"
      expr: city
    - name: "Country"
      expr: country
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Email"
      expr: email
    - name: "Enrollment Effective Date"
      expr: enrollment_effective_date
    - name: "Ethnicity"
      expr: ethnicity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Identity"
      expr: COUNT(DISTINCT identity_id)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_lob_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line of business assignment KPIs tracking LOB distribution, dual eligibility, risk tier stratification, and SNP population. Drives CMS contract management, risk adjustment strategy, and care management program targeting."
  source: "`vibe_health_insurance_v1`.`member`.`lob_assignment`"
  dimensions:
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (commercial, Medicare Advantage, Medicaid, exchange) for LOB-level financial and operational analysis."
    - name: "lob_assignment_status"
      expr: lob_assignment_status
      comment: "Current LOB assignment status for active population filtering."
    - name: "snp_type"
      expr: snp_type
      comment: "Special Needs Plan type (D-SNP, C-SNP, I-SNP) for SNP-specific regulatory and financial reporting."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of member for care management program targeting and actuarial stratification."
    - name: "hcc_risk_score_tier"
      expr: hcc_risk_score_tier
      comment: "HCC risk score tier for risk adjustment revenue stratification and care management prioritization."
    - name: "dual_eligible_flag"
      expr: dual_eligible_flag
      comment: "Whether member is dual-eligible (Medicare and Medicaid) — dual-eligible population drives D-SNP enrollment and coordination requirements."
    - name: "cms_region"
      expr: cms_region
      comment: "CMS region for geographic risk adjustment and contract performance analysis."
    - name: "state_code"
      expr: state_code
      comment: "State of LOB assignment for state-level regulatory and Medicaid contract reporting."
    - name: "rising_risk_indicator"
      expr: rising_risk_indicator
      comment: "Whether member is flagged as rising risk — identifies population for proactive care management intervention."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month LOB assignment became effective for membership trend analysis by LOB."
  measures:
    - name: "total_lob_assignments"
      expr: COUNT(lob_assignment_id)
      comment: "Total LOB assignment records — baseline membership count by line of business for CMS contract and financial reporting."
    - name: "distinct_members_by_lob"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of distinct members per LOB — unduplicated membership headcount for CMS enrollment reporting and premium revenue attribution."
    - name: "dual_eligible_members"
      expr: COUNT(CASE WHEN dual_eligible_flag = TRUE THEN lob_assignment_id END)
      comment: "Count of dual-eligible members — drives D-SNP enrollment targets, coordination of benefits strategy, and CMS low-income subsidy reporting."
    - name: "dual_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dual_eligible_flag = TRUE THEN lob_assignment_id END) / NULLIF(COUNT(lob_assignment_id), 0), 2)
      comment: "Percentage of members who are dual-eligible — measures complexity of the enrolled population and associated care coordination cost."
    - name: "rising_risk_member_count"
      expr: COUNT(CASE WHEN rising_risk_indicator = TRUE THEN lob_assignment_id END)
      comment: "Count of rising-risk members — primary care management program targeting metric; rising count triggers proactive outreach investment."
    - name: "rising_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rising_risk_indicator = TRUE THEN lob_assignment_id END) / NULLIF(COUNT(lob_assignment_id), 0), 2)
      comment: "Percentage of members flagged as rising risk — measures population health trajectory and care management program demand."
    - name: "snp_enrolled_members"
      expr: COUNT(CASE WHEN snp_type IS NOT NULL AND snp_type <> '' THEN lob_assignment_id END)
      comment: "Count of members enrolled in a Special Needs Plan — measures SNP program scale for CMS bid and contract management."
    - name: "care_management_eligible_members"
      expr: COUNT(CASE WHEN care_management_eligibility_flag = TRUE THEN lob_assignment_id END)
      comment: "Count of members eligible for care management programs — drives care management staffing, outreach budget, and program ROI measurement."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Address business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_address`"
  dimensions:
    - name: "Address Type"
      expr: address_type
    - name: "Census Tract"
      expr: census_tract
    - name: "Change Reason"
      expr: change_reason
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "County Fips"
      expr: county_fips
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Code"
      expr: external_code
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Address"
      expr: COUNT(DISTINCT member_address_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Communication business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_communication`"
  dimensions:
    - name: "Acknowledgment Status"
      expr: acknowledgment_status
    - name: "Body"
      expr: body
    - name: "Card Format"
      expr: card_format
    - name: "Card Status"
      expr: card_status
    - name: "Card Type"
      expr: card_type
    - name: "Channel"
      expr: channel
    - name: "Communication Number"
      expr: communication_number
    - name: "Communication Type"
      expr: communication_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Service Phone"
      expr: customer_service_phone
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Delivery Confirmation"
      expr: delivery_confirmation
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Communication"
      expr: COUNT(DISTINCT member_communication_id)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Contact business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_contact`"
  dimensions:
    - name: "Address Cass Certified"
      expr: address_cass_certified
    - name: "Address Effective Date"
      expr: address_effective_date
    - name: "Address Geocode Accuracy"
      expr: address_geocode_accuracy
    - name: "Address Geocode Source"
      expr: address_geocode_source
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Address Priority Rank"
      expr: address_priority_rank
    - name: "Address Source System"
      expr: address_source_system
    - name: "Address Termination Date"
      expr: address_termination_date
    - name: "Address Type"
      expr: address_type
    - name: "Address Verification Status"
      expr: address_verification_status
    - name: "Census Tract"
      expr: census_tract
    - name: "City"
      expr: city
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Type"
      expr: contact_type
    - name: "Country Code"
      expr: country_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Contact"
      expr: COUNT(DISTINCT member_contact_id)
    - name: "Total Id Value"
      expr: SUM(id_value)
    - name: "Average Id Value"
      expr: AVG(id_value)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility span KPIs tracking coverage continuity, active eligibility rates, and span duration. Critical for claims adjudication accuracy, CMS reporting, and enrollment reconciliation."
  source: "`vibe_health_insurance_v1`.`member`.`member_eligibility_span`"
  dimensions:
    - name: "is_active"
      expr: is_active
      comment: "Whether the eligibility span is currently active — primary filter for real-time eligibility verification."
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status for data quality and operational filtering."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the eligibility span began — used for cohort-based eligibility trend analysis."
    - name: "effective_end_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the eligibility span ended — used for attrition and gap-in-coverage analysis."
    - name: "record_source_system"
      expr: record_source_system
      comment: "Source system originating the eligibility record — used for data quality and reconciliation by source."
  measures:
    - name: "total_eligibility_spans"
      expr: COUNT(member_eligibility_span_id)
      comment: "Total number of eligibility spans — baseline volume metric for enrollment operations and CMS submission reconciliation."
    - name: "active_eligibility_spans"
      expr: COUNT(CASE WHEN is_active = TRUE THEN member_eligibility_span_id END)
      comment: "Count of currently active eligibility spans — real-time membership count for claims adjudication and premium billing."
    - name: "distinct_covered_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of distinct subscribers with at least one eligibility span — unduplicated membership headcount for actuarial and regulatory reporting."
    - name: "active_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN member_eligibility_span_id END) / NULLIF(COUNT(member_eligibility_span_id), 0), 2)
      comment: "Percentage of eligibility spans that are currently active — measures coverage continuity health and data completeness for adjudication."
    - name: "avg_span_duration_days"
      expr: AVG(CAST(DATEDIFF(effective_end_date, effective_start_date) AS DOUBLE))
      comment: "Average length of eligibility spans in days — longer spans indicate member retention; short spans signal churn or data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Eligibility Span business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_eligibility_span`"
  dimensions:
    - name: "Cobro End Date"
      expr: cobro_end_date
    - name: "Cobro Start Date"
      expr: cobro_start_date
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Source"
      expr: eligibility_source
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version Code"
      expr: fhir_version_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Eligibility Span"
      expr: COUNT(DISTINCT member_eligibility_span_id)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Enrollment business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_enrollment`"
  dimensions:
    - name: "Application Received Date"
      expr: application_received_date
    - name: "Auto Assignment Flag"
      expr: auto_assignment_flag
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Coverage Level"
      expr: coverage_level
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Disenrollment Date"
      expr: disenrollment_date
    - name: "Disenrollment Reason Code"
      expr: disenrollment_reason_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Enrollment Channel"
      expr: enrollment_channel
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Number"
      expr: enrollment_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Enrollment"
      expr: COUNT(DISTINCT member_enrollment_id)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health plan enrollment KPIs tracking active membership, premium economics, subsidy utilization, and coverage tier distribution. Core operational dashboard for enrollment management and financial planning."
  source: "`vibe_health_insurance_v1`.`member`.`member_enrollment2`"
  dimensions:
    - name: "coverage_status_code"
      expr: coverage_status_code
      comment: "Current coverage status (active, terminated, suspended) for enrollment cohort segmentation."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (individual, family, employee+spouse, etc.) for premium and benefit analysis."
    - name: "election_source_code"
      expr: election_source_code
      comment: "Source of enrollment election (employer, exchange, direct, SEP) to track acquisition channels."
    - name: "sep_reason_code"
      expr: sep_reason_code
      comment: "Special enrollment period reason code to monitor qualifying life events driving mid-year enrollment."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (new, renewal, COBRA, SEP) for lifecycle stage analysis."
    - name: "tier_level_code"
      expr: tier_level_code
      comment: "Plan tier level (bronze, silver, gold, platinum) for benefit richness and premium stratification."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('month', coverage_start_date)
      comment: "Month of coverage start for enrollment trend analysis over time."
    - name: "coverage_end_month"
      expr: DATE_TRUNC('month', coverage_end_date)
      comment: "Month of coverage end for attrition and churn trend analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether enrollment was auto-renewed, indicating passive vs. active re-enrollment behavior."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status for operational filtering and cohort segmentation."
  measures:
    - name: "total_enrolled_members"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of distinct subscribers enrolled — primary membership headcount KPI for capacity planning and revenue forecasting."
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN coverage_status_code = 'active' OR enrollment_status = 'active' THEN member_enrollment2_id END)
      comment: "Count of currently active enrollment records — operational measure of live membership for premium billing and risk pool sizing."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium billed across all enrollment records — top-line revenue driver for financial planning and actuarial rate adequacy assessment."
    - name: "avg_premium_per_member"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per enrollment record — benchmark for rate competitiveness and cross-tier pricing analysis."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total APTC/subsidy dollars applied across enrollments — financial exposure metric for ACA subsidy reconciliation and CMS reporting."
    - name: "avg_subsidy_per_member"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy per enrollment — indicates subsidy dependency of the enrolled population, informing exchange market strategy."
    - name: "total_dependents_covered"
      expr: SUM(CAST(dependents_covered_count AS DOUBLE))
      comment: "Total dependents covered across all enrollments — drives benefit utilization projections and family unit risk assessment."
    - name: "subsidy_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subsidy_amount > 0 THEN member_enrollment2_id END) / NULLIF(COUNT(member_enrollment2_id), 0), 2)
      comment: "Percentage of enrollments receiving a subsidy — measures ACA exchange market penetration and income-qualified population share."
    - name: "sep_enrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sep_reason_code IS NOT NULL AND sep_reason_code <> '' THEN member_enrollment2_id END) / NULLIF(COUNT(member_enrollment2_id), 0), 2)
      comment: "Percentage of enrollments originating from a Special Enrollment Period — monitors mid-year enrollment volatility and adverse selection risk."
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN member_enrollment2_id END) / NULLIF(COUNT(member_enrollment2_id), 0), 2)
      comment: "Percentage of enrollments that auto-renewed — high auto-renewal indicates member stickiness and reduces re-enrollment operational cost."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Grievance business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_grievance`"
  dimensions:
    - name: "Cms Reportable Indicator"
      expr: cms_reportable_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version Code"
      expr: fhir_version_code
    - name: "Grievance Number"
      expr: grievance_number
    - name: "Grievance Source"
      expr: grievance_source
    - name: "Investigation End Timestamp"
      expr: investigation_end_timestamp
    - name: "Investigation Start Timestamp"
      expr: investigation_start_timestamp
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Grievance"
      expr: COUNT(DISTINCT member_grievance_id)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member grievance KPIs tracking complaint volume, resolution rates, financial exposure, and regulatory reporting compliance. Critical for CMS Star Ratings, NCQA accreditation, and member experience management."
  source: "`vibe_health_insurance_v1`.`member`.`member_grievance2`"
  dimensions:
    - name: "member_grievance_status"
      expr: member_grievance_status
      comment: "Current grievance status (open, resolved, escalated, withdrawn) for pipeline and backlog management."
    - name: "issue_category_code"
      expr: issue_category_code
      comment: "Category of grievance issue (access, quality, billing, service) for root cause analysis and corrective action targeting."
    - name: "resolution_type_code"
      expr: resolution_type_code
      comment: "How the grievance was resolved (upheld, overturned, withdrawn, dismissed) for quality and fairness benchmarking."
    - name: "type_code"
      expr: type_code
      comment: "Grievance type code for regulatory classification and CMS reporting segmentation."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business associated with the grievance for LOB-level quality performance analysis."
    - name: "state_code"
      expr: state_code
      comment: "State where grievance originated for state-level regulatory compliance and DOI reporting."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether grievance must be reported to a regulator — flags compliance-critical cases for timely submission."
    - name: "cms_reportable_indicator"
      expr: cms_reportable_indicator
      comment: "Whether grievance is reportable to CMS — critical for Medicare Star Ratings and HEDIS complaint measure compliance."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month grievance was received for trend analysis and seasonal pattern detection."
    - name: "resolution_month"
      expr: DATE_TRUNC('month', resolution_date)
      comment: "Month grievance was resolved for resolution cycle time trending."
  measures:
    - name: "total_grievances"
      expr: COUNT(member_grievance2_id)
      comment: "Total grievance volume — primary quality metric for CMS Star Ratings complaint measure and NCQA accreditation standards."
    - name: "open_grievances"
      expr: COUNT(CASE WHEN member_grievance_status = 'open' THEN member_grievance2_id END)
      comment: "Count of unresolved open grievances — operational backlog metric; high open count signals resolution capacity issues and regulatory risk."
    - name: "cms_reportable_grievances"
      expr: COUNT(CASE WHEN cms_reportable_indicator = TRUE THEN member_grievance2_id END)
      comment: "Count of CMS-reportable grievances — directly impacts Medicare Star Ratings; executives monitor this to protect plan star rating."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount disputed across grievances — measures financial exposure from member billing complaints and claim disputes."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per grievance — benchmarks typical financial exposure per complaint for reserve and settlement planning."
    - name: "avg_member_satisfaction_score"
      expr: AVG(CAST(member_satisfaction_score AS DOUBLE))
      comment: "Average member satisfaction score at grievance resolution — direct measure of member experience quality and service recovery effectiveness."
    - name: "regulatory_reporting_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN member_grievance2_id END) / NULLIF(COUNT(member_grievance2_id), 0), 2)
      comment: "Percentage of grievances requiring regulatory reporting — measures compliance burden and regulatory risk exposure."
    - name: "distinct_grieving_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members who filed grievances — measures breadth of dissatisfaction; high count relative to membership signals systemic quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_lifecycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member lifecycle event KPIs tracking enrollment changes, qualifying life events, disenrollment patterns, and CMS-reportable transitions. Essential for operational compliance, CMS reporting, and member retention strategy."
  source: "`vibe_health_insurance_v1`.`member`.`member_lifecycle_event`"
  dimensions:
    - name: "event_type_code"
      expr: event_type_code
      comment: "Type of lifecycle event (enrollment, disenrollment, plan change, QLE, relocation) for event-level operational analysis."
    - name: "event_reason_code"
      expr: event_reason_code
      comment: "Reason code for the lifecycle event — identifies root causes of membership changes for retention and compliance action."
    - name: "disenrollment_reason_code"
      expr: disenrollment_reason_code
      comment: "Specific disenrollment reason for churn analysis and targeted retention intervention."
    - name: "member_lifecycle_event_status"
      expr: member_lifecycle_event_status
      comment: "Processing status of the lifecycle event for operational workflow management."
    - name: "cms_reporting_indicator"
      expr: cms_reporting_indicator
      comment: "Whether event must be reported to CMS — flags compliance-critical events for timely regulatory submission."
    - name: "special_enrollment_period_flag"
      expr: special_enrollment_period_flag
      comment: "Whether event triggered a Special Enrollment Period — monitors SEP utilization and adverse selection risk."
    - name: "cobra_qualifying_event_flag"
      expr: cobra_qualifying_event_flag
      comment: "Whether event is a COBRA qualifying event — drives COBRA notice obligations and continuation coverage tracking."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of lifecycle event for trend analysis and seasonal enrollment pattern detection."
    - name: "relocation_state_code"
      expr: relocation_state_code
      comment: "State to which member relocated — used for geographic membership flow analysis and network adequacy planning."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the lifecycle event — unverified events represent compliance and data quality risk."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(member_lifecycle_event_id)
      comment: "Total lifecycle event volume — baseline operational throughput metric for enrollment processing capacity planning."
    - name: "disenrollment_events"
      expr: COUNT(CASE WHEN event_type_code = 'disenrollment' OR disenrollment_reason_code IS NOT NULL THEN member_lifecycle_event_id END)
      comment: "Count of disenrollment events — primary churn metric; rising disenrollment triggers retention program investment decisions."
    - name: "cms_reportable_events"
      expr: COUNT(CASE WHEN cms_reporting_indicator = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of CMS-reportable lifecycle events — compliance volume metric for CMS submission planning and regulatory risk management."
    - name: "sep_triggered_events"
      expr: COUNT(CASE WHEN special_enrollment_period_flag = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of events triggering Special Enrollment Periods — measures mid-year enrollment volatility and adverse selection exposure."
    - name: "cobra_qualifying_events"
      expr: COUNT(CASE WHEN cobra_qualifying_event_flag = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of COBRA qualifying events — drives COBRA notice obligations and continuation coverage liability estimation."
    - name: "unverified_event_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status IS NULL OR verification_status = 'unverified' THEN member_lifecycle_event_id END) / NULLIF(COUNT(member_lifecycle_event_id), 0), 2)
      comment: "Percentage of lifecycle events lacking verification — high rate signals enrollment data quality risk and potential CMS audit exposure."
    - name: "distinct_members_with_events"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members experiencing lifecycle events — measures breadth of membership churn and change activity in a period."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member lifecycle event metrics tracking qualifying life events, special enrollment periods, and regulatory triggers critical for enrollment operations and compliance."
  source: "`vibe_health_insurance_v1`.`member`.`member_lifecycle_event`"
  dimensions:
    - name: "member_lifecycle_event_status"
      expr: member_lifecycle_event_status
      comment: "Current status of the lifecycle event"
    - name: "event_type_code"
      expr: event_type_code
      comment: "Type of lifecycle event (enrollment, disenrollment, transfer, QLE)"
    - name: "event_reason_code"
      expr: event_reason_code
      comment: "Reason code for the lifecycle event"
    - name: "disenrollment_source"
      expr: disenrollment_source
      comment: "Source of disenrollment for attrition channel analysis"
    - name: "disenrollment_reason_code"
      expr: disenrollment_reason_code
      comment: "Specific reason for disenrollment"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the lifecycle event"
    - name: "qualified_life_event_flag"
      expr: qualified_life_event_flag
      comment: "Whether this is a qualified life event triggering special enrollment"
    - name: "special_enrollment_period_flag"
      expr: special_enrollment_period_flag
      comment: "Whether a special enrollment period was triggered"
    - name: "cobra_qualifying_event_flag"
      expr: cobra_qualifying_event_flag
      comment: "Whether this event qualifies for COBRA continuation"
    - name: "medicare_entitlement_flag"
      expr: medicare_entitlement_flag
      comment: "Whether the event involves Medicare entitlement"
    - name: "source_system"
      expr: source_system
      comment: "Source system of the lifecycle event"
    - name: "event_year"
      expr: YEAR(effective_date)
      comment: "Year the lifecycle event became effective"
    - name: "event_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the lifecycle event became effective"
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total count of member lifecycle events for operational volume tracking"
    - name: "qualified_life_events"
      expr: COUNT(CASE WHEN qualified_life_event_flag = true THEN 1 END)
      comment: "Count of qualified life events triggering special enrollment periods"
    - name: "special_enrollment_events"
      expr: COUNT(CASE WHEN special_enrollment_period_flag = true THEN 1 END)
      comment: "Count of special enrollment period events for SEP volume management"
    - name: "cobra_qualifying_events"
      expr: COUNT(CASE WHEN cobra_qualifying_event_flag = true THEN 1 END)
      comment: "Count of COBRA qualifying events for continuation coverage obligation tracking"
    - name: "medicare_entitlement_events"
      expr: COUNT(CASE WHEN medicare_entitlement_flag = true THEN 1 END)
      comment: "Count of Medicare entitlement events for aging-in population management"
    - name: "medicaid_eligibility_gain_events"
      expr: COUNT(CASE WHEN medicaid_eligibility_gain_flag = true THEN 1 END)
      comment: "Count of Medicaid eligibility gain events for government program coordination"
    - name: "medicaid_eligibility_loss_events"
      expr: COUNT(CASE WHEN medicaid_eligibility_loss_flag = true THEN 1 END)
      comment: "Count of Medicaid eligibility loss events for coverage transition management"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_member_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Lifecycle Event business metrics"
  source: "`vibe_health_insurance_v1`.`member`.`member_lifecycle_event`"
  dimensions:
    - name: "Appeal Rights Notification Flag"
      expr: appeal_rights_notification_flag
    - name: "Chip Aging Out Flag"
      expr: chip_aging_out_flag
    - name: "Cms Reporting Indicator"
      expr: cms_reporting_indicator
    - name: "Cobra Qualifying Event Flag"
      expr: cobra_qualifying_event_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Disability Determination Flag"
      expr: disability_determination_flag
    - name: "Disenrollment Reason Code"
      expr: disenrollment_reason_code
    - name: "Disenrollment Request Date"
      expr: disenrollment_request_date
    - name: "Disenrollment Source"
      expr: disenrollment_source
    - name: "Documentation Received Flag"
      expr: documentation_received_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Event Description"
      expr: event_description
    - name: "Event Reason Code"
      expr: event_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Lifecycle Event"
      expr: COUNT(DISTINCT member_lifecycle_event_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_pcp_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PCP assignment KPIs tracking assignment rates, panel status, network tier distribution, and assignment stability. Critical for network adequacy, care continuity, and value-based care program performance."
  source: "`vibe_health_insurance_v1`.`member`.`pcp_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current PCP assignment status (active, pending, terminated) for operational assignment management."
    - name: "assignment_type"
      expr: assignment_type
      comment: "How assignment was made (auto-assigned, member-selected, plan-assigned) for assignment quality and member satisfaction analysis."
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Reason for PCP assignment or change — identifies drivers of PCP churn and assignment instability."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of assigned PCP (tier 1, tier 2, out-of-network) for cost and quality tier utilization analysis."
    - name: "panel_status"
      expr: panel_status
      comment: "PCP panel status (open, closed, restricted) — closed panels signal network capacity constraints requiring intervention."
    - name: "pcp_specialty_code"
      expr: pcp_specialty_code
      comment: "Specialty of assigned PCP for care model and specialty distribution analysis."
    - name: "is_primary"
      expr: is_primary
      comment: "Whether this is the member's primary PCP assignment — distinguishes primary from secondary assignments."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month PCP assignment became effective for assignment trend and stability analysis."
  measures:
    - name: "total_pcp_assignments"
      expr: COUNT(pcp_assignment_id)
      comment: "Total PCP assignment records — baseline metric for network adequacy and care coordination program coverage."
    - name: "active_pcp_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'active' AND is_active = TRUE THEN pcp_assignment_id END)
      comment: "Count of currently active PCP assignments — measures live PCP attribution for value-based care program enrollment and capitation payment."
    - name: "distinct_assigned_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members with a PCP assignment — PCP attribution rate denominator for value-based care and HEDIS measure compliance."
    - name: "distinct_assigned_pcps"
      expr: COUNT(DISTINCT pcp_provider_id)
      comment: "Count of distinct PCPs with at least one member assignment — measures PCP network utilization and panel distribution breadth."
    - name: "closed_panel_assignment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN panel_status = 'closed' THEN pcp_assignment_id END) / NULLIF(COUNT(pcp_assignment_id), 0), 2)
      comment: "Percentage of assignments to PCPs with closed panels — high rate signals network capacity risk and member access barriers."
    - name: "member_selected_assignment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assignment_type = 'member-selected' THEN pcp_assignment_id END) / NULLIF(COUNT(pcp_assignment_id), 0), 2)
      comment: "Percentage of PCP assignments made by member choice vs. auto-assignment — higher member-selected rate correlates with better care engagement and retention."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member policy KPIs tracking premium economics, deductible and out-of-pocket exposure, coverage status, and renewal performance. Core financial and actuarial metrics for product management and underwriting."
  source: "`vibe_health_insurance_v1`.`member`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current policy status (active, lapsed, terminated, renewed) for portfolio health analysis."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of policy (individual, group, family) for product line segmentation and pricing analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (medical, dental, vision, pharmacy) for benefit line performance analysis."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status for active policy filtering and lapse rate analysis."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status (renewed, lapsed, pending) for retention and renewal rate analysis."
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Premium payment frequency (monthly, quarterly, annual) for cash flow and billing cycle analysis."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('month', coverage_start_date)
      comment: "Month coverage began for policy cohort and vintage analysis."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for policy termination for churn root cause analysis and retention strategy."
  measures:
    - name: "total_policies"
      expr: COUNT(policy_id)
      comment: "Total policy count — baseline portfolio size metric for product management and actuarial analysis."
    - name: "active_policies"
      expr: COUNT(CASE WHEN policy_status = 'active' AND is_active = TRUE THEN policy_id END)
      comment: "Count of currently active policies — live portfolio size for premium revenue forecasting and risk pool management."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium across all policies — top-line revenue metric for financial planning and actuarial rate adequacy."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per policy — benchmark for pricing competitiveness and cross-product premium analysis."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible per policy — measures cost-sharing burden on members and benefit richness of the portfolio."
    - name: "avg_out_of_pocket_max"
      expr: AVG(CAST(out_of_pocket_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum per policy — measures member financial exposure and ACA OOP cap compliance."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit across policies — measures aggregate benefit liability for actuarial reserve adequacy."
    - name: "renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_status = 'renewed' THEN policy_id END) / NULLIF(COUNT(CASE WHEN renewal_status IS NOT NULL AND renewal_status <> '' THEN policy_id END), 0), 2)
      comment: "Percentage of policies that renewed — primary retention KPI; declining renewal rate triggers product and pricing intervention."
    - name: "avg_renewal_premium_amount"
      expr: AVG(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Average renewal premium — measures premium trend at renewal for rate adequacy and member affordability analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member segmentation KPIs tracking risk stratification, chronic condition prevalence, dual eligibility, and SDOH risk distribution. Drives care management program targeting, actuarial modeling, and population health investment decisions."
  source: "`vibe_health_insurance_v1`.`member`.`segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the member segment for population cohort analysis and care management program alignment."
    - name: "segment_category"
      expr: segment_category
      comment: "Category of segment (risk, chronic condition, demographic, behavioral) for strategic population analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of the segment (low, medium, high, rising) for care management resource allocation."
    - name: "hcc_risk_score_tier"
      expr: hcc_risk_score_tier
      comment: "HCC risk score tier for risk adjustment revenue stratification and care management prioritization."
    - name: "chronic_condition_code"
      expr: chronic_condition_code
      comment: "Chronic condition code associated with the segment for disease management program targeting."
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Whether segment members have a chronic condition — primary care management eligibility flag."
    - name: "dual_eligible"
      expr: dual_eligible
      comment: "Whether segment members are dual-eligible — drives D-SNP enrollment and coordination of care requirements."
    - name: "snp_eligibility"
      expr: snp_eligibility
      comment: "Whether segment members are SNP eligible — identifies population for specialized plan enrollment."
    - name: "star_rating_cohort"
      expr: star_rating_cohort
      comment: "CMS Star Rating cohort assignment — links segment to specific HEDIS/CAHPS measures for quality performance management."
    - name: "segmentation_source"
      expr: segmentation_source
      comment: "Source of segmentation model (predictive model, claims-based, clinical) for model performance benchmarking."
  measures:
    - name: "total_segment_assignments"
      expr: COUNT(segment_id)
      comment: "Total segment assignment records — baseline metric for segmentation model coverage and population stratification completeness."
    - name: "distinct_segmented_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of distinct members assigned to segments — measures segmentation model population coverage for care management program targeting."
    - name: "chronic_condition_members"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE THEN segment_id END)
      comment: "Count of segment assignments with chronic conditions — measures disease burden of the population for care management program sizing and cost projection."
    - name: "dual_eligible_segment_members"
      expr: COUNT(CASE WHEN dual_eligible = TRUE THEN segment_id END)
      comment: "Count of dual-eligible members in segments — drives D-SNP enrollment strategy and coordination of care investment."
    - name: "avg_sdoh_risk_score"
      expr: AVG(CAST(sdoh_risk_score AS DOUBLE))
      comment: "Average SDOH risk score across segments — measures social determinants burden of the population for community health investment and health equity programs."
    - name: "chronic_condition_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN chronic_condition_flag = TRUE THEN segment_id END) / NULLIF(COUNT(segment_id), 0), 2)
      comment: "Percentage of segment assignments with chronic conditions — population health metric for disease management program ROI and actuarial cost projection."
    - name: "high_risk_segment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_tier = 'high' THEN segment_id END) / NULLIF(COUNT(segment_id), 0), 2)
      comment: "Percentage of members in high-risk segments — primary care management prioritization metric; rising rate triggers care management capacity investment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber-level KPIs covering population demographics, risk profile, income distribution, and retention. Foundation for actuarial, underwriting, and member experience analytics."
  source: "`vibe_health_insurance_v1`.`member`.`subscriber`"
  dimensions:
    - name: "subscriber_status"
      expr: subscriber_status
      comment: "Current subscriber status (active, terminated, suspended) for population segmentation."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare, Medicaid, exchange) for LOB-level performance analysis."
    - name: "gender"
      expr: gender
      comment: "Subscriber gender for demographic and actuarial risk stratification."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for member communication effectiveness and health equity analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (individual, group, family) for benefit design and premium analysis."
    - name: "tobacco_use_status"
      expr: tobacco_use_status
      comment: "Tobacco use status for risk adjustment, wellness program targeting, and premium surcharge analysis."
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for SNP eligibility, care management targeting, and ADA compliance reporting."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel through which subscriber enrolled (employer, exchange, direct) for acquisition cost analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether subscriber is currently active — primary operational filter for live population analytics."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of benefits indicator — identifies members with dual coverage for COB cost recovery analysis."
  measures:
    - name: "total_subscribers"
      expr: COUNT(subscriber_id)
      comment: "Total subscriber count — primary membership headcount for capacity planning, premium revenue forecasting, and regulatory reporting."
    - name: "active_subscribers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN subscriber_id END)
      comment: "Count of currently active subscribers — live membership base for operational planning and risk pool management."
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income of subscribers — key input for subsidy eligibility modeling, ACA affordability analysis, and market segmentation."
    - name: "avg_hcc_risk_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC risk score across subscribers — primary actuarial metric for risk adjustment revenue, premium adequacy, and care management prioritization."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor (RAF) — directly drives CMS risk adjustment payments; low RAF vs. competitor benchmark signals revenue leakage."
    - name: "total_annual_income"
      expr: SUM(CAST(annual_income AS DOUBLE))
      comment: "Total annual income across subscriber population — used for FPL-based subsidy pool sizing and income-stratified benefit design."
    - name: "cob_subscriber_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cob_indicator IS NOT NULL AND cob_indicator <> '' AND cob_indicator <> 'N' THEN subscriber_id END) / NULLIF(COUNT(subscriber_id), 0), 2)
      comment: "Percentage of subscribers with COB indicator — measures dual-coverage population share for COB recovery program sizing."
    - name: "deceased_subscriber_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_deceased = TRUE THEN subscriber_id END) / NULLIF(COUNT(subscriber_id), 0), 2)
      comment: "Percentage of subscribers flagged as deceased — operational data quality metric; high rate signals enrollment termination processing failures."
$$;
