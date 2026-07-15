-- Metric views for domain: hazmat | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste manifest tracking and compliance metrics for shipment oversight and regulatory reporting"
  source: "`waste_management_ecm`.`hazmat`.`manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Current status of the manifest (e.g., in-transit, received, rejected)"
    - name: "manifest_type"
      expr: manifest_type
      comment: "Type of manifest (e.g., standard, import, emergency)"
    - name: "shipment_year"
      expr: YEAR(shipment_date)
      comment: "Year the waste shipment occurred"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month the waste shipment occurred"
    - name: "generator_state"
      expr: generator_state
      comment: "State where the waste generator is located"
    - name: "tsdf_state"
      expr: tsdf_state
      comment: "State where the treatment, storage, disposal facility is located"
    - name: "dot_hazard_class"
      expr: dot_hazard_class
      comment: "DOT hazard classification for the waste"
    - name: "discrepancy_flag"
      expr: CASE WHEN discrepancy_indication = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether a discrepancy was reported on the manifest"
    - name: "rejection_flag"
      expr: CASE WHEN rejection_indication = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the shipment was rejected by the TSDF"
  measures:
    - name: "total_manifests"
      expr: COUNT(1)
      comment: "Total number of hazardous waste manifests"
    - name: "total_waste_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of hazardous waste shipped across all manifests"
    - name: "avg_waste_quantity_per_manifest"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average waste quantity per manifest shipment"
    - name: "manifests_with_discrepancies"
      expr: SUM(CASE WHEN discrepancy_indication = TRUE THEN 1 ELSE 0 END)
      comment: "Count of manifests with reported discrepancies"
    - name: "manifests_rejected"
      expr: SUM(CASE WHEN rejection_indication = TRUE THEN 1 ELSE 0 END)
      comment: "Count of manifests rejected by receiving facility"
    - name: "unique_generators"
      expr: COUNT(DISTINCT generator_epa_id_registration_id)
      comment: "Number of distinct waste generators shipping hazardous waste"
    - name: "unique_tsdfs"
      expr: COUNT(DISTINCT tsdf_epa_epa_id_registration_id)
      comment: "Number of distinct treatment, storage, disposal facilities receiving waste"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_disposal_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste disposal performance and cost metrics for operational efficiency and regulatory compliance"
  source: "`waste_management_ecm`.`hazmat`.`disposal_record`"
  dimensions:
    - name: "disposal_status"
      expr: disposal_status
      comment: "Current status of the disposal record (e.g., pending, completed, rejected)"
    - name: "disposal_method"
      expr: disposal_method_description
      comment: "Method used for waste disposal (e.g., incineration, landfill, treatment)"
    - name: "disposal_year"
      expr: YEAR(disposal_date)
      comment: "Year the disposal occurred"
    - name: "disposal_month"
      expr: DATE_TRUNC('MONTH', disposal_date)
      comment: "Month the disposal occurred"
    - name: "ldr_compliance_status"
      expr: CASE WHEN ldr_compliance_certified = TRUE THEN 'Certified' ELSE 'Not Certified' END
      comment: "Land disposal restriction compliance certification status"
    - name: "discrepancy_flag"
      expr: CASE WHEN discrepancy_indicator = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether a discrepancy was identified during disposal"
    - name: "emergency_response_flag"
      expr: CASE WHEN emergency_response_required = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether emergency response was required during disposal"
  measures:
    - name: "total_disposal_records"
      expr: COUNT(1)
      comment: "Total number of hazardous waste disposal records"
    - name: "total_waste_disposed_lbs"
      expr: SUM(CAST(waste_quantity_lbs AS DOUBLE))
      comment: "Total weight of hazardous waste disposed in pounds"
    - name: "total_waste_disposed_tons"
      expr: SUM(CAST(waste_quantity_tons AS DOUBLE))
      comment: "Total weight of hazardous waste disposed in tons"
    - name: "total_disposal_cost"
      expr: SUM(CAST(disposal_cost_amount AS DOUBLE))
      comment: "Total cost of hazardous waste disposal operations"
    - name: "avg_disposal_cost_per_ton"
      expr: AVG(CAST(disposal_cost_amount AS DOUBLE) / NULLIF(CAST(waste_quantity_tons AS DOUBLE), 0))
      comment: "Average disposal cost per ton of waste"
    - name: "disposal_records_with_discrepancies"
      expr: SUM(CASE WHEN discrepancy_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disposal records with discrepancies"
    - name: "ldr_certified_disposals"
      expr: SUM(CASE WHEN ldr_compliance_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disposals with land disposal restriction compliance certification"
    - name: "unique_tsdf_facilities"
      expr: COUNT(DISTINCT tsdf_facility_id)
      comment: "Number of distinct TSDF facilities used for disposal"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_waste_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste shipment logistics and performance metrics for operational efficiency and safety oversight"
  source: "`waste_management_ecm`.`hazmat`.`waste_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the waste shipment (e.g., scheduled, in-transit, delivered, exception)"
    - name: "shipment_year"
      expr: YEAR(shipment_date)
      comment: "Year the shipment occurred"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month the shipment occurred"
    - name: "temperature_controlled_flag"
      expr: CASE WHEN temperature_controlled = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the shipment required temperature control"
    - name: "placard_required_flag"
      expr: CASE WHEN dot_placard_required = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether DOT placarding was required for the shipment"
    - name: "chain_of_custody_verified_flag"
      expr: CASE WHEN chain_of_custody_verified = TRUE THEN 'Verified' ELSE 'Not Verified' END
      comment: "Whether chain of custody was verified for the shipment"
    - name: "route_deviation_flag"
      expr: CASE WHEN route_deviation_detected = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether a route deviation was detected during transit"
    - name: "gps_tracking_flag"
      expr: CASE WHEN gps_tracking_enabled = TRUE THEN 'Enabled' ELSE 'Disabled' END
      comment: "Whether GPS tracking was enabled for the shipment"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of hazardous waste shipments"
    - name: "total_weight_shipped_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight of hazardous waste shipped in pounds"
    - name: "avg_weight_per_shipment_lbs"
      expr: AVG(CAST(total_weight_lbs AS DOUBLE))
      comment: "Average weight per shipment in pounds"
    - name: "total_actual_transit_hours"
      expr: SUM(CAST(actual_transit_hours AS DOUBLE))
      comment: "Total actual transit time across all shipments in hours"
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time per shipment in hours"
    - name: "shipments_with_route_deviation"
      expr: SUM(CASE WHEN route_deviation_detected = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments with detected route deviations"
    - name: "shipments_chain_of_custody_verified"
      expr: SUM(CASE WHEN chain_of_custody_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments with verified chain of custody"
    - name: "unique_drivers"
      expr: COUNT(DISTINCT driver_id)
      comment: "Number of distinct drivers involved in hazardous waste shipments"
    - name: "unique_vehicles"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles used for hazardous waste shipments"
    - name: "unique_transporters"
      expr: COUNT(DISTINCT transporter_registration_id)
      comment: "Number of distinct registered transporters used"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_emergency_response_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous materials emergency response incident metrics for safety oversight and regulatory compliance"
  source: "`waste_management_ecm`.`hazmat`.`emergency_response_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the emergency response incident (e.g., open, closed, under investigation)"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of emergency incident (e.g., spill, release, fire, explosion)"
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity level of the incident (e.g., minor, moderate, major, catastrophic)"
    - name: "incident_year"
      expr: YEAR(incident_datetime)
      comment: "Year the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_datetime)
      comment: "Month the incident occurred"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where the incident occurred (e.g., facility, transport, public area)"
    - name: "injuries_reported_flag"
      expr: CASE WHEN injuries_reported = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether injuries were reported in the incident"
    - name: "nrc_notified_flag"
      expr: CASE WHEN nrc_report_number IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether the National Response Center was notified"
    - name: "lepc_notified_flag"
      expr: CASE WHEN lepc_notified = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the Local Emergency Planning Committee was notified"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts (e.g., not started, in progress, completed)"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of hazardous materials emergency response incidents"
    - name: "incidents_with_injuries"
      expr: SUM(CASE WHEN injuries_reported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents where injuries were reported"
    - name: "total_release_quantity"
      expr: SUM(CAST(release_quantity AS DOUBLE))
      comment: "Total quantity of hazardous material released across all incidents"
    - name: "avg_release_quantity"
      expr: AVG(CAST(release_quantity AS DOUBLE))
      comment: "Average quantity of hazardous material released per incident"
    - name: "incidents_nrc_notified"
      expr: SUM(CASE WHEN nrc_report_number IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of incidents where National Response Center was notified"
    - name: "incidents_lepc_notified"
      expr: SUM(CASE WHEN lepc_notified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents where Local Emergency Planning Committee was notified"
    - name: "incidents_root_cause_completed"
      expr: SUM(CASE WHEN root_cause_analysis_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents with completed root cause analysis"
    - name: "unique_incident_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities where incidents occurred"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_treatment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste treatment performance and efficiency metrics for operational optimization and compliance"
  source: "`waste_management_ecm`.`hazmat`.`treatment_record`"
  dimensions:
    - name: "treatment_status"
      expr: treatment_status
      comment: "Current status of the treatment record (e.g., scheduled, in-progress, completed, failed)"
    - name: "treatment_technology"
      expr: treatment_technology_code
      comment: "Technology code used for waste treatment"
    - name: "treatment_year"
      expr: YEAR(treatment_date)
      comment: "Year the treatment occurred"
    - name: "treatment_month"
      expr: DATE_TRUNC('MONTH', treatment_date)
      comment: "Month the treatment occurred"
    - name: "ldr_compliance_status"
      expr: ldr_compliance_status
      comment: "Land disposal restriction compliance status for the treatment"
    - name: "emergency_response_flag"
      expr: CASE WHEN emergency_response_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether emergency response was required during treatment"
    - name: "tclp_test_performed_flag"
      expr: CASE WHEN tclp_test_performed = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether TCLP testing was performed on treated waste"
    - name: "qa_review_status"
      expr: quality_assurance_review_status
      comment: "Quality assurance review status for the treatment"
  measures:
    - name: "total_treatment_records"
      expr: COUNT(1)
      comment: "Total number of hazardous waste treatment records"
    - name: "total_input_waste_quantity"
      expr: SUM(CAST(input_waste_quantity AS DOUBLE))
      comment: "Total quantity of waste input to treatment processes"
    - name: "total_output_residual_quantity"
      expr: SUM(CAST(output_residual_quantity AS DOUBLE))
      comment: "Total quantity of residual waste after treatment"
    - name: "avg_treatment_efficiency_pct"
      expr: AVG(CAST(treatment_efficiency_percent AS DOUBLE))
      comment: "Average treatment efficiency percentage across all treatments"
    - name: "total_treatment_cost"
      expr: SUM(CAST(treatment_cost_usd AS DOUBLE))
      comment: "Total cost of hazardous waste treatment operations in USD"
    - name: "avg_treatment_cost_per_unit"
      expr: AVG(CAST(treatment_cost_usd AS DOUBLE) / NULLIF(CAST(input_waste_quantity AS DOUBLE), 0))
      comment: "Average treatment cost per unit of input waste"
    - name: "avg_residence_time_minutes"
      expr: AVG(CAST(residence_time_minutes AS DOUBLE))
      comment: "Average residence time in treatment process in minutes"
    - name: "treatments_with_tclp_test"
      expr: SUM(CASE WHEN tclp_test_performed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of treatments where TCLP testing was performed"
    - name: "unique_treatment_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities performing waste treatment"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_waste_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste profile approval and characterization metrics for compliance and operational planning"
  source: "`waste_management_ecm`.`hazmat`.`waste_profile`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the waste profile (e.g., pending, approved, rejected, expired)"
    - name: "physical_state"
      expr: physical_state
      comment: "Physical state of the waste (e.g., solid, liquid, gas, sludge)"
    - name: "dot_hazard_class"
      expr: dot_hazard_class
      comment: "DOT hazard classification for the waste"
    - name: "packing_group"
      expr: packing_group
      comment: "DOT packing group designation"
    - name: "land_disposal_restricted_flag"
      expr: CASE WHEN land_disposal_restricted = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the waste is subject to land disposal restrictions"
    - name: "ignitable_flag"
      expr: CASE WHEN is_ignitable = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the waste is ignitable"
    - name: "corrosive_flag"
      expr: CASE WHEN is_corrosive = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the waste is corrosive"
    - name: "reactive_flag"
      expr: CASE WHEN is_reactive = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the waste is reactive"
    - name: "toxic_flag"
      expr: CASE WHEN is_toxic = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the waste is toxic"
    - name: "profile_year"
      expr: YEAR(profile_effective_date)
      comment: "Year the waste profile became effective"
  measures:
    - name: "total_waste_profiles"
      expr: COUNT(1)
      comment: "Total number of hazardous waste profiles"
    - name: "approved_waste_profiles"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved waste profiles"
    - name: "total_annual_quantity_estimate_tons"
      expr: SUM(CAST(annual_quantity_estimate_tons AS DOUBLE))
      comment: "Total estimated annual waste quantity across all profiles in tons"
    - name: "avg_annual_quantity_estimate_tons"
      expr: AVG(CAST(annual_quantity_estimate_tons AS DOUBLE))
      comment: "Average estimated annual waste quantity per profile in tons"
    - name: "profiles_land_disposal_restricted"
      expr: SUM(CASE WHEN land_disposal_restricted = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste profiles subject to land disposal restrictions"
    - name: "profiles_ignitable"
      expr: SUM(CASE WHEN is_ignitable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste profiles classified as ignitable"
    - name: "profiles_corrosive"
      expr: SUM(CASE WHEN is_corrosive = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste profiles classified as corrosive"
    - name: "profiles_reactive"
      expr: SUM(CASE WHEN is_reactive = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste profiles classified as reactive"
    - name: "profiles_toxic"
      expr: SUM(CASE WHEN is_toxic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste profiles classified as toxic"
    - name: "unique_generators"
      expr: COUNT(DISTINCT hazardous_waste_generator_id)
      comment: "Number of distinct hazardous waste generators with profiles"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_transporter_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste transporter registration and compliance metrics for vendor management and safety oversight"
  source: "`waste_management_ecm`.`hazmat`.`transporter_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the transporter (e.g., active, expired, suspended)"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating assigned to the transporter"
    - name: "state_code"
      expr: state_code
      comment: "State where the transporter is registered"
    - name: "approved_for_manifest_flag"
      expr: CASE WHEN approved_for_manifest_use = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the transporter is approved for manifest use"
    - name: "hazmat_training_compliance_status"
      expr: hazmat_employee_training_compliance_status
      comment: "Compliance status of hazmat employee training"
    - name: "registration_year"
      expr: YEAR(approval_date)
      comment: "Year the transporter was approved"
  measures:
    - name: "total_transporters"
      expr: COUNT(1)
      comment: "Total number of registered hazardous waste transporters"
    - name: "active_transporters"
      expr: SUM(CASE WHEN registration_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of transporters with active registration status"
    - name: "transporters_approved_for_manifest"
      expr: SUM(CASE WHEN approved_for_manifest_use = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transporters approved for manifest use"
    - name: "avg_vendor_performance_score"
      expr: AVG(CAST(vendor_performance_score AS DOUBLE))
      comment: "Average vendor performance score across all transporters"
    - name: "total_cargo_insurance_coverage"
      expr: SUM(CAST(cargo_insurance_coverage_amount AS DOUBLE))
      comment: "Total cargo insurance coverage amount across all transporters"
    - name: "total_liability_insurance_coverage"
      expr: SUM(CAST(liability_insurance_coverage_amount AS DOUBLE))
      comment: "Total liability insurance coverage amount across all transporters"
    - name: "avg_cargo_insurance_coverage"
      expr: AVG(CAST(cargo_insurance_coverage_amount AS DOUBLE))
      comment: "Average cargo insurance coverage per transporter"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors providing transportation services"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_rcra_biennial_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RCRA biennial reporting metrics for regulatory compliance and waste generation trend analysis"
  source: "`waste_management_ecm`.`hazmat`.`rcra_biennial_report`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year covered by the biennial report"
    - name: "generator_status"
      expr: generator_status
      comment: "Generator status classification (e.g., LQG, SQG, VSQG)"
    - name: "state_agency_code"
      expr: state_agency_code
      comment: "State agency code for the reporting jurisdiction"
    - name: "offsite_shipment_flag"
      expr: CASE WHEN offsite_shipment_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether offsite shipments occurred during the reporting period"
    - name: "onsite_treatment_flag"
      expr: CASE WHEN onsite_treatment_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether onsite treatment occurred during the reporting period"
    - name: "waste_minimization_achieved_flag"
      expr: CASE WHEN waste_minimization_achieved_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether waste minimization was achieved during the reporting period"
    - name: "primary_treatment_method"
      expr: primary_treatment_method
      comment: "Primary treatment method used during the reporting period"
  measures:
    - name: "total_biennial_reports"
      expr: COUNT(1)
      comment: "Total number of RCRA biennial reports submitted"
    - name: "total_waste_generated_lbs"
      expr: SUM(CAST(total_waste_generated_lbs AS DOUBLE))
      comment: "Total hazardous waste generated across all reports in pounds"
    - name: "total_waste_shipped_offsite_lbs"
      expr: SUM(CAST(total_waste_shipped_offsite_lbs AS DOUBLE))
      comment: "Total hazardous waste shipped offsite across all reports in pounds"
    - name: "total_waste_managed_onsite_lbs"
      expr: SUM(CAST(total_waste_managed_onsite_lbs AS DOUBLE))
      comment: "Total hazardous waste managed onsite across all reports in pounds"
    - name: "avg_waste_generated_per_facility_lbs"
      expr: AVG(CAST(total_waste_generated_lbs AS DOUBLE))
      comment: "Average hazardous waste generated per facility in pounds"
    - name: "reports_with_waste_minimization"
      expr: SUM(CASE WHEN waste_minimization_achieved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports where waste minimization was achieved"
    - name: "reports_with_offsite_shipment"
      expr: SUM(CASE WHEN offsite_shipment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports with offsite waste shipments"
    - name: "reports_with_onsite_treatment"
      expr: SUM(CASE WHEN onsite_treatment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports with onsite waste treatment"
    - name: "unique_reporting_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities submitting biennial reports"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_hazwoper_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HAZWOPER training compliance and certification metrics for workforce safety and regulatory adherence"
  source: "`waste_management_ecm`.`hazmat`.`hazwoper_training`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Current status of the HAZWOPER training (e.g., scheduled, completed, expired)"
    - name: "training_type"
      expr: training_type
      comment: "Type of HAZWOPER training (e.g., 40-hour, 24-hour, 8-hour refresher)"
    - name: "training_delivery_method"
      expr: training_delivery_method
      comment: "Method of training delivery (e.g., in-person, online, hybrid)"
    - name: "job_role"
      expr: job_role
      comment: "Job role of the employee receiving training"
    - name: "assessment_passed_flag"
      expr: CASE WHEN assessment_passed = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the employee passed the training assessment"
    - name: "certificate_issued_flag"
      expr: CASE WHEN certificate_issued = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether a training certificate was issued"
    - name: "reimbursement_status"
      expr: reimbursement_status
      comment: "Reimbursement status for training costs"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of HAZWOPER training records"
    - name: "training_records_completed"
      expr: SUM(CASE WHEN training_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed HAZWOPER training records"
    - name: "training_records_passed"
      expr: SUM(CASE WHEN assessment_passed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of training records where assessment was passed"
    - name: "certificates_issued"
      expr: SUM(CASE WHEN certificate_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Count of training certificates issued"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training records"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost AS DOUBLE))
      comment: "Total cost of HAZWOPER training programs"
    - name: "avg_training_cost_per_employee"
      expr: AVG(CAST(training_cost AS DOUBLE))
      comment: "Average training cost per employee"
    - name: "unique_employees_trained"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees who received HAZWOPER training"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_storage_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste storage unit capacity and compliance metrics for operational planning and safety oversight"
  source: "`waste_management_ecm`.`hazmat`.`storage_unit`"
  dimensions:
    - name: "unit_status"
      expr: unit_status
      comment: "Current operational status of the storage unit (e.g., active, inactive, closed)"
    - name: "unit_type"
      expr: unit_type
      comment: "Type of storage unit (e.g., tank, container, building)"
    - name: "secondary_containment_type"
      expr: secondary_containment_type
      comment: "Type of secondary containment system"
    - name: "fire_suppression_system"
      expr: fire_suppression_system
      comment: "Type of fire suppression system installed"
    - name: "ventilation_system_type"
      expr: ventilation_system_type
      comment: "Type of ventilation system"
    - name: "temperature_control_required_flag"
      expr: CASE WHEN temperature_control_required = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether temperature control is required for the storage unit"
    - name: "emergency_response_zone"
      expr: emergency_response_zone
      comment: "Emergency response zone designation for the storage unit"
  measures:
    - name: "total_storage_units"
      expr: COUNT(1)
      comment: "Total number of hazardous waste storage units"
    - name: "active_storage_units"
      expr: SUM(CASE WHEN unit_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active storage units"
    - name: "total_maximum_capacity_gallons"
      expr: SUM(CAST(maximum_capacity_gallons AS DOUBLE))
      comment: "Total maximum storage capacity across all units in gallons"
    - name: "total_current_inventory_quantity"
      expr: SUM(CAST(current_inventory_quantity AS DOUBLE))
      comment: "Total current inventory quantity across all storage units"
    - name: "avg_capacity_utilization_pct"
      expr: AVG(100.0 * CAST(current_inventory_quantity AS DOUBLE) / NULLIF(CAST(maximum_capacity_gallons AS DOUBLE), 0))
      comment: "Average capacity utilization percentage across all storage units"
    - name: "total_secondary_containment_capacity_gallons"
      expr: SUM(CAST(secondary_containment_capacity_gallons AS DOUBLE))
      comment: "Total secondary containment capacity across all units in gallons"
    - name: "avg_maximum_capacity_gallons"
      expr: AVG(CAST(maximum_capacity_gallons AS DOUBLE))
      comment: "Average maximum capacity per storage unit in gallons"
    - name: "units_with_temperature_control"
      expr: SUM(CASE WHEN temperature_control_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of storage units requiring temperature control"
    - name: "unique_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with hazardous waste storage units"
$$;
