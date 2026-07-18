-- Metric views for domain: tailings | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:45:39

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_ard_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ard Assessment business metrics"
  source: "`mining_ecm`.`tailings`.`ard_assessment`"
  dimensions:
    - name: "Ard Risk Classification"
      expr: ard_risk_classification
    - name: "Assessed By"
      expr: assessed_by
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Notes"
      expr: assessment_notes
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lithology"
      expr: lithology
    - name: "Management Strategy"
      expr: management_strategy
    - name: "Material Type"
      expr: material_type
    - name: "Metal Leaching Risk"
      expr: metal_leaching_risk
    - name: "Review Date"
      expr: review_date
    - name: "Reviewed By"
      expr: reviewed_by
    - name: "Sample Collection Date"
      expr: sample_collection_date
    - name: "Sample Location Description"
      expr: sample_location_description
    - name: "Test Method"
      expr: test_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ard Assessment"
      expr: COUNT(DISTINCT ard_assessment_id)
    - name: "Total Anc Kg Caco3 Per Tonne"
      expr: SUM(anc_kg_caco3_per_tonne)
    - name: "Average Anc Kg Caco3 Per Tonne"
      expr: AVG(anc_kg_caco3_per_tonne)
    - name: "Total Arsenic Leachate Mg Per L"
      expr: SUM(arsenic_leachate_mg_per_l)
    - name: "Average Arsenic Leachate Mg Per L"
      expr: AVG(arsenic_leachate_mg_per_l)
    - name: "Total Carbonate Content Percent"
      expr: SUM(carbonate_content_percent)
    - name: "Average Carbonate Content Percent"
      expr: AVG(carbonate_content_percent)
    - name: "Total Copper Leachate Mg Per L"
      expr: SUM(copper_leachate_mg_per_l)
    - name: "Average Copper Leachate Mg Per L"
      expr: AVG(copper_leachate_mg_per_l)
    - name: "Total Lead Leachate Mg Per L"
      expr: SUM(lead_leachate_mg_per_l)
    - name: "Average Lead Leachate Mg Per L"
      expr: AVG(lead_leachate_mg_per_l)
    - name: "Total Maximum Potential Acidity Kg H2so4 Per Tonne"
      expr: SUM(maximum_potential_acidity_kg_h2so4_per_tonne)
    - name: "Average Maximum Potential Acidity Kg H2so4 Per Tonne"
      expr: AVG(maximum_potential_acidity_kg_h2so4_per_tonne)
    - name: "Total Nag Ph"
      expr: SUM(nag_ph)
    - name: "Average Nag Ph"
      expr: AVG(nag_ph)
    - name: "Total Nag Value Kg H2so4 Per Tonne"
      expr: SUM(nag_value_kg_h2so4_per_tonne)
    - name: "Average Nag Value Kg H2so4 Per Tonne"
      expr: AVG(nag_value_kg_h2so4_per_tonne)
    - name: "Total Net Neutralization Potential Ratio"
      expr: SUM(net_neutralization_potential_ratio)
    - name: "Average Net Neutralization Potential Ratio"
      expr: AVG(net_neutralization_potential_ratio)
    - name: "Total Paste Ph"
      expr: SUM(paste_ph)
    - name: "Average Paste Ph"
      expr: AVG(paste_ph)
    - name: "Total Sample Depth M"
      expr: SUM(sample_depth_m)
    - name: "Average Sample Depth M"
      expr: AVG(sample_depth_m)
    - name: "Total Sulfate Sulfur Percent"
      expr: SUM(sulfate_sulfur_percent)
    - name: "Average Sulfate Sulfur Percent"
      expr: AVG(sulfate_sulfur_percent)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_capacity_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity Model business metrics"
  source: "`mining_ecm`.`tailings`.`capacity_model`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Model Assumptions"
      expr: model_assumptions
    - name: "Model Code"
      expr: model_code
    - name: "Model Confidence Level"
      expr: model_confidence_level
    - name: "Model Description"
      expr: model_description
    - name: "Model Name"
      expr: model_name
    - name: "Model Type"
      expr: model_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Raise Method"
      expr: raise_method
    - name: "Raise Stage Number"
      expr: raise_stage_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capacity Model"
      expr: COUNT(DISTINCT capacity_model_id)
    - name: "Total Current Capacity M3"
      expr: SUM(current_capacity_m3)
    - name: "Average Current Capacity M3"
      expr: AVG(current_capacity_m3)
    - name: "Total Current Capacity Tonnes"
      expr: SUM(current_capacity_tonnes)
    - name: "Average Current Capacity Tonnes"
      expr: AVG(current_capacity_tonnes)
    - name: "Total Current Elevation M"
      expr: SUM(current_elevation_m)
    - name: "Average Current Elevation M"
      expr: AVG(current_elevation_m)
    - name: "Total Deposition Rate M3 Per Day"
      expr: SUM(deposition_rate_m3_per_day)
    - name: "Average Deposition Rate M3 Per Day"
      expr: AVG(deposition_rate_m3_per_day)
    - name: "Total Deposition Rate Tonnes Per Day"
      expr: SUM(deposition_rate_tonnes_per_day)
    - name: "Average Deposition Rate Tonnes Per Day"
      expr: AVG(deposition_rate_tonnes_per_day)
    - name: "Total Estimated Life Years"
      expr: SUM(estimated_life_years)
    - name: "Average Estimated Life Years"
      expr: AVG(estimated_life_years)
    - name: "Total Freeboard Requirement M"
      expr: SUM(freeboard_requirement_m)
    - name: "Average Freeboard Requirement M"
      expr: AVG(freeboard_requirement_m)
    - name: "Total Maximum Elevation M"
      expr: SUM(maximum_elevation_m)
    - name: "Average Maximum Elevation M"
      expr: AVG(maximum_elevation_m)
    - name: "Total Settlement Factor"
      expr: SUM(settlement_factor)
    - name: "Average Settlement Factor"
      expr: AVG(settlement_factor)
    - name: "Total Solids Concentration Percentage"
      expr: SUM(solids_concentration_percentage)
    - name: "Average Solids Concentration Percentage"
      expr: AVG(solids_concentration_percentage)
    - name: "Total Solids Density Tonnes Per M3"
      expr: SUM(solids_density_tonnes_per_m3)
    - name: "Average Solids Density Tonnes Per M3"
      expr: AVG(solids_density_tonnes_per_m3)
    - name: "Total Total Design Capacity M3"
      expr: SUM(total_design_capacity_m3)
    - name: "Average Total Design Capacity M3"
      expr: AVG(total_design_capacity_m3)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_closure_liability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Closure Liability business metrics"
  source: "`mining_ecm`.`tailings`.`closure_liability`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Assurance Currency Code"
      expr: assurance_currency_code
    - name: "Consequence Classification"
      expr: consequence_classification
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Estimate Basis"
      expr: estimate_basis
    - name: "Estimate Date"
      expr: estimate_date
    - name: "Estimate Prepared By"
      expr: estimate_prepared_by
    - name: "Expected Closure Completion Date"
      expr: expected_closure_completion_date
    - name: "Expected Closure Start Date"
      expr: expected_closure_start_date
    - name: "Financial Assurance Instrument Type"
      expr: financial_assurance_instrument_type
    - name: "Independent Review Date"
      expr: independent_review_date
    - name: "Independent Review Required"
      expr: independent_review_required
    - name: "Independent Reviewer"
      expr: independent_reviewer
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Liability Notes"
      expr: liability_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Closure Liability"
      expr: COUNT(DISTINCT closure_liability_id)
    - name: "Total Approved Estimate Amount"
      expr: SUM(approved_estimate_amount)
    - name: "Average Approved Estimate Amount"
      expr: AVG(approved_estimate_amount)
    - name: "Total Assurance Amount Lodged"
      expr: SUM(assurance_amount_lodged)
    - name: "Average Assurance Amount Lodged"
      expr: AVG(assurance_amount_lodged)
    - name: "Total Discount Rate"
      expr: SUM(discount_rate)
    - name: "Average Discount Rate"
      expr: AVG(discount_rate)
    - name: "Total Estimated Closure Cost"
      expr: SUM(estimated_closure_cost)
    - name: "Average Estimated Closure Cost"
      expr: AVG(estimated_closure_cost)
    - name: "Total Net Present Value"
      expr: SUM(net_present_value)
    - name: "Average Net Present Value"
      expr: AVG(net_present_value)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
    - name: "Total Variance To Approved Estimate"
      expr: SUM(variance_to_approved_estimate)
    - name: "Average Variance To Approved Estimate"
      expr: AVG(variance_to_approved_estimate)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_closure_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Closure Plan business metrics"
  source: "`mining_ecm`.`tailings`.`closure_plan`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Assurance Expiry Date"
      expr: assurance_expiry_date
    - name: "Assurance Lodgement Date"
      expr: assurance_lodgement_date
    - name: "Closure Cost Currency Code"
      expr: closure_cost_currency_code
    - name: "Closure Strategy"
      expr: closure_strategy
    - name: "Consultation Date"
      expr: consultation_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Final Landform Design"
      expr: final_landform_design
    - name: "Financial Assurance Instrument Type"
      expr: financial_assurance_instrument_type
    - name: "Independent Review Date"
      expr: independent_review_date
    - name: "Independent Reviewer"
      expr: independent_reviewer
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
    - name: "Plan Document Reference"
      expr: plan_document_reference
    - name: "Plan Reference Number"
      expr: plan_reference_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Closure Plan"
      expr: COUNT(DISTINCT closure_plan_id)
    - name: "Total Closure Cost Npv"
      expr: SUM(closure_cost_npv)
    - name: "Average Closure Cost Npv"
      expr: AVG(closure_cost_npv)
    - name: "Total Discount Rate Percent"
      expr: SUM(discount_rate_percent)
    - name: "Average Discount Rate Percent"
      expr: AVG(discount_rate_percent)
    - name: "Total Estimated Closure Cost"
      expr: SUM(estimated_closure_cost)
    - name: "Average Estimated Closure Cost"
      expr: AVG(estimated_closure_cost)
    - name: "Total Financial Assurance Amount"
      expr: SUM(financial_assurance_amount)
    - name: "Average Financial Assurance Amount"
      expr: AVG(financial_assurance_amount)
    - name: "Total Variance To Approved Estimate Percent"
      expr: SUM(variance_to_approved_estimate_percent)
    - name: "Average Variance To Approved Estimate Percent"
      expr: AVG(variance_to_approved_estimate_percent)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_consequence_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consequence Classification business metrics"
  source: "`mining_ecm`.`tailings`.`consequence_classification`"
  dimensions:
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Methodology"
      expr: assessment_methodology
    - name: "Assessment Version"
      expr: assessment_version
    - name: "Classification Category"
      expr: classification_category
    - name: "Classification Notes"
      expr: classification_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cultural Heritage Impact"
      expr: cultural_heritage_impact
    - name: "Dam Safety Review Frequency Months"
      expr: dam_safety_review_frequency_months
    - name: "Design Standard Reference"
      expr: design_standard_reference
    - name: "Downstream Infrastructure Impact"
      expr: downstream_infrastructure_impact
    - name: "Economic Impact Rating"
      expr: economic_impact_rating
    - name: "Environmental Impact Rating"
      expr: environmental_impact_rating
    - name: "Facility Type"
      expr: facility_type
    - name: "Failure Mode Scenario"
      expr: failure_mode_scenario
    - name: "Independent Review Date"
      expr: independent_review_date
    - name: "Independent Review Outcome"
      expr: independent_review_outcome
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consequence Classification"
      expr: COUNT(DISTINCT consequence_classification_id)
    - name: "Total Inundation Area Km2"
      expr: SUM(inundation_area_km2)
    - name: "Average Inundation Area Km2"
      expr: AVG(inundation_area_km2)
    - name: "Total Peak Discharge M3 Per Sec"
      expr: SUM(peak_discharge_m3_per_sec)
    - name: "Average Peak Discharge M3 Per Sec"
      expr: AVG(peak_discharge_m3_per_sec)
    - name: "Total Warning Time Hours"
      expr: SUM(warning_time_hours)
    - name: "Average Warning Time Hours"
      expr: AVG(warning_time_hours)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_dam_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dam Safety Inspection business metrics"
  source: "`mining_ecm`.`tailings`.`dam_safety_inspection`"
  dimensions:
    - name: "Consequence Classification"
      expr: consequence_classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Engineer Of Record Name"
      expr: engineer_of_record_name
    - name: "Eor Signoff Date"
      expr: eor_signoff_date
    - name: "Failure Mode Assessed"
      expr: failure_mode_assessed
    - name: "Fos Compliance Status"
      expr: fos_compliance_status
    - name: "Freeboard Compliance Status"
      expr: freeboard_compliance_status
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Inspection Number"
      expr: inspection_number
    - name: "Inspection Report Reference"
      expr: inspection_report_reference
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Inspection Type"
      expr: inspection_type
    - name: "Instrumentation Compliance"
      expr: instrumentation_compliance
    - name: "Instrumentation Status"
      expr: instrumentation_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Material Strength Parameters"
      expr: material_strength_parameters
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dam Safety Inspection"
      expr: COUNT(DISTINCT dam_safety_inspection_id)
    - name: "Total Factor Of Safety"
      expr: SUM(factor_of_safety)
    - name: "Average Factor Of Safety"
      expr: AVG(factor_of_safety)
    - name: "Total Freeboard Measurement M"
      expr: SUM(freeboard_measurement_m)
    - name: "Average Freeboard Measurement M"
      expr: AVG(freeboard_measurement_m)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_decant_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Decant Operation business metrics"
  source: "`mining_ecm`.`tailings`.`decant_operation`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Decant End Timestamp"
      expr: decant_end_timestamp
    - name: "Decant Event Date"
      expr: decant_event_date
    - name: "Decant Event Reference"
      expr: decant_event_reference
    - name: "Decant Start Timestamp"
      expr: decant_start_timestamp
    - name: "Decant Structure Type"
      expr: decant_structure_type
    - name: "Destination Type"
      expr: destination_type
    - name: "Incident Flag"
      expr: incident_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Licence Condition Reference"
      expr: licence_condition_reference
    - name: "Non Compliance Reason"
      expr: non_compliance_reason
    - name: "Operation Notes"
      expr: operation_notes
    - name: "Operation Status"
      expr: operation_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Decant Operation"
      expr: COUNT(DISTINCT decant_operation_id)
    - name: "Total Flow Rate M3 Per Hour"
      expr: SUM(flow_rate_m3_per_hour)
    - name: "Average Flow Rate M3 Per Hour"
      expr: AVG(flow_rate_m3_per_hour)
    - name: "Total Freeboard After Decant M"
      expr: SUM(freeboard_after_decant_m)
    - name: "Average Freeboard After Decant M"
      expr: AVG(freeboard_after_decant_m)
    - name: "Total Rainfall During Operation Mm"
      expr: SUM(rainfall_during_operation_mm)
    - name: "Average Rainfall During Operation Mm"
      expr: AVG(rainfall_during_operation_mm)
    - name: "Total Volume Decanted M3"
      expr: SUM(volume_decanted_m3)
    - name: "Average Volume Decanted M3"
      expr: AVG(volume_decanted_m3)
    - name: "Total Water Level After M"
      expr: SUM(water_level_after_m)
    - name: "Average Water Level After M"
      expr: AVG(water_level_after_m)
    - name: "Total Water Level Before M"
      expr: SUM(water_level_before_m)
    - name: "Average Water Level Before M"
      expr: AVG(water_level_before_m)
    - name: "Total Water Quality Ph"
      expr: SUM(water_quality_ph)
    - name: "Average Water Quality Ph"
      expr: AVG(water_quality_ph)
    - name: "Total Water Quality Tds Mg Per L"
      expr: SUM(water_quality_tds_mg_per_l)
    - name: "Average Water Quality Tds Mg Per L"
      expr: AVG(water_quality_tds_mg_per_l)
    - name: "Total Water Quality Tss Mg Per L"
      expr: SUM(water_quality_tss_mg_per_l)
    - name: "Average Water Quality Tss Mg Per L"
      expr: AVG(water_quality_tss_mg_per_l)
    - name: "Total Water Quality Turbidity Ntu"
      expr: SUM(water_quality_turbidity_ntu)
    - name: "Average Water Quality Turbidity Ntu"
      expr: AVG(water_quality_turbidity_ntu)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_decant_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Decant Structure business metrics"
  source: "`mining_ecm`.`tailings`.`decant_structure`"
  dimensions:
    - name: "Asset Condition Rating"
      expr: asset_condition_rating
    - name: "Blockage Risk Level"
      expr: blockage_risk_level
    - name: "Construction Contractor"
      expr: construction_contractor
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Design Engineer"
      expr: design_engineer
    - name: "Design Standard"
      expr: design_standard
    - name: "Emergency Response Plan Reference"
      expr: emergency_response_plan_reference
    - name: "Inspection Frequency Days"
      expr: inspection_frequency_days
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Maintenance Notes"
      expr: maintenance_notes
    - name: "Monitoring System Installed"
      expr: monitoring_system_installed
    - name: "Next Inspection Due Date"
      expr: next_inspection_due_date
    - name: "Operational Status"
      expr: operational_status
    - name: "Pipe Material"
      expr: pipe_material
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Decant Structure"
      expr: COUNT(DISTINCT decant_structure_id)
    - name: "Total Design Capacity M3 Per Hour"
      expr: SUM(design_capacity_m3_per_hour)
    - name: "Average Design Capacity M3 Per Hour"
      expr: AVG(design_capacity_m3_per_hour)
    - name: "Total Inlet Elevation M"
      expr: SUM(inlet_elevation_m)
    - name: "Average Inlet Elevation M"
      expr: AVG(inlet_elevation_m)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Outlet Elevation M"
      expr: SUM(outlet_elevation_m)
    - name: "Average Outlet Elevation M"
      expr: AVG(outlet_elevation_m)
    - name: "Total Pipe Diameter Mm"
      expr: SUM(pipe_diameter_mm)
    - name: "Average Pipe Diameter Mm"
      expr: AVG(pipe_diameter_mm)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_deposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposition business metrics"
  source: "`mining_ecm`.`tailings`.`deposition`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Data Source System"
      expr: data_source_system
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Notes"
      expr: notes
    - name: "Raise Trigger Flag"
      expr: raise_trigger_flag
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Spigot Configuration"
      expr: spigot_configuration
    - name: "Survey Accuracy Class"
      expr: survey_accuracy_class
    - name: "Survey Method"
      expr: survey_method
    - name: "Weather Conditions"
      expr: weather_conditions
    - name: "Approval Timestamp Month"
      expr: DATE_TRUNC('MONTH', approval_timestamp)
    - name: "Event Timestamp Month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Deposition"
      expr: COUNT(DISTINCT deposition_id)
    - name: "Total Beach Elevation M"
      expr: SUM(beach_elevation_m)
    - name: "Average Beach Elevation M"
      expr: AVG(beach_elevation_m)
    - name: "Total Beach Length M"
      expr: SUM(beach_length_m)
    - name: "Average Beach Length M"
      expr: AVG(beach_length_m)
    - name: "Total Current Storage Volume M3"
      expr: SUM(current_storage_volume_m3)
    - name: "Average Current Storage Volume M3"
      expr: AVG(current_storage_volume_m3)
    - name: "Total Freeboard M"
      expr: SUM(freeboard_m)
    - name: "Average Freeboard M"
      expr: AVG(freeboard_m)
    - name: "Total Point Latitude"
      expr: SUM(point_latitude)
    - name: "Average Point Latitude"
      expr: AVG(point_latitude)
    - name: "Total Point Longitude"
      expr: SUM(point_longitude)
    - name: "Average Point Longitude"
      expr: AVG(point_longitude)
    - name: "Total Pond Level M"
      expr: SUM(pond_level_m)
    - name: "Average Pond Level M"
      expr: AVG(pond_level_m)
    - name: "Total Pond Surface Area M2"
      expr: SUM(pond_surface_area_m2)
    - name: "Average Pond Surface Area M2"
      expr: AVG(pond_surface_area_m2)
    - name: "Total Remaining Airspace M3"
      expr: SUM(remaining_airspace_m3)
    - name: "Average Remaining Airspace M3"
      expr: AVG(remaining_airspace_m3)
    - name: "Total Remaining Life Years"
      expr: SUM(remaining_life_years)
    - name: "Average Remaining Life Years"
      expr: AVG(remaining_life_years)
    - name: "Total Slurry Density T Per M3"
      expr: SUM(slurry_density_t_per_m3)
    - name: "Average Slurry Density T Per M3"
      expr: AVG(slurry_density_t_per_m3)
    - name: "Total Solids Tonnage T"
      expr: SUM(solids_tonnage_t)
    - name: "Average Solids Tonnage T"
      expr: AVG(solids_tonnage_t)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_deposition_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposition Plan business metrics"
  source: "`mining_ecm`.`tailings`.`deposition_plan`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Reference Number"
      expr: approval_reference_number
    - name: "Closure Rehabilitation Plan Reference"
      expr: closure_rehabilitation_plan_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deposition Method"
      expr: deposition_method
    - name: "Design Engineer License Number"
      expr: design_engineer_license_number
    - name: "Design Engineer Name"
      expr: design_engineer_name
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Emergency Response Plan Reference"
      expr: emergency_response_plan_reference
    - name: "Environmental Impact Statement Reference"
      expr: environmental_impact_statement_reference
    - name: "Geotechnical Stability Rating"
      expr: geotechnical_stability_rating
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Monitoring Plan Reference"
      expr: monitoring_plan_reference
    - name: "Plan Code"
      expr: plan_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Deposition Plan"
      expr: COUNT(DISTINCT deposition_plan_id)
    - name: "Total Deposition Rate M3 Per Day"
      expr: SUM(deposition_rate_m3_per_day)
    - name: "Average Deposition Rate M3 Per Day"
      expr: AVG(deposition_rate_m3_per_day)
    - name: "Total Estimated Closure Liability Amount"
      expr: SUM(estimated_closure_liability_amount)
    - name: "Average Estimated Closure Liability Amount"
      expr: AVG(estimated_closure_liability_amount)
    - name: "Total Planned Capacity M3"
      expr: SUM(planned_capacity_m3)
    - name: "Average Planned Capacity M3"
      expr: AVG(planned_capacity_m3)
    - name: "Total Planned Capacity Tonnes"
      expr: SUM(planned_capacity_tonnes)
    - name: "Average Planned Capacity Tonnes"
      expr: AVG(planned_capacity_tonnes)
    - name: "Total Target Beach Slope Percent"
      expr: SUM(target_beach_slope_percent)
    - name: "Average Target Beach Slope Percent"
      expr: AVG(target_beach_slope_percent)
    - name: "Total Target Freeboard M"
      expr: SUM(target_freeboard_m)
    - name: "Average Target Freeboard M"
      expr: AVG(target_freeboard_m)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_destination_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Destination Facility business metrics"
  source: "`mining_ecm`.`tailings`.`destination_facility`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Consequence Classification"
      expr: consequence_classification
    - name: "Construction Method"
      expr: construction_method
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: destination_facility_description
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Name"
      expr: facility_name
    - name: "Facility Type"
      expr: facility_type
    - name: "Geotechnical Monitoring Frequency"
      expr: geotechnical_monitoring_frequency
    - name: "Last Inspection Date"
      expr: last_inspection_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Destination Facility"
      expr: COUNT(DISTINCT destination_facility_id)
    - name: "Total Crest Elevation M"
      expr: SUM(crest_elevation_m)
    - name: "Average Crest Elevation M"
      expr: AVG(crest_elevation_m)
    - name: "Total Current Capacity M3"
      expr: SUM(current_capacity_m3)
    - name: "Average Current Capacity M3"
      expr: AVG(current_capacity_m3)
    - name: "Total Dam Height M"
      expr: SUM(dam_height_m)
    - name: "Average Dam Height M"
      expr: AVG(dam_height_m)
    - name: "Total Design Capacity M3"
      expr: SUM(design_capacity_m3)
    - name: "Average Design Capacity M3"
      expr: AVG(design_capacity_m3)
    - name: "Total Estimated Closure Liability Usd"
      expr: SUM(estimated_closure_liability_usd)
    - name: "Average Estimated Closure Liability Usd"
      expr: AVG(estimated_closure_liability_usd)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Remaining Capacity M3"
      expr: SUM(remaining_capacity_m3)
    - name: "Average Remaining Capacity M3"
      expr: AVG(remaining_capacity_m3)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_emergency_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency Action Plan business metrics"
  source: "`mining_ecm`.`tailings`.`emergency_action_plan`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Community Engagement Status"
      expr: community_engagement_status
    - name: "Consequence Classification"
      expr: consequence_classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Drill Exercise Frequency"
      expr: drill_exercise_frequency
    - name: "Effective Date"
      expr: effective_date
    - name: "Emergency Notification Procedure"
      expr: emergency_notification_procedure
    - name: "Evacuation Procedure"
      expr: evacuation_procedure
    - name: "Evacuation Trigger Criteria"
      expr: evacuation_trigger_criteria
    - name: "Independent Review Date"
      expr: independent_review_date
    - name: "Independent Reviewer"
      expr: independent_reviewer
    - name: "Inundation Study Date"
      expr: inundation_study_date
    - name: "Inundation Zone Mapping Reference"
      expr: inundation_zone_mapping_reference
    - name: "Last Drill Exercise Date"
      expr: last_drill_exercise_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Emergency Action Plan"
      expr: COUNT(DISTINCT emergency_action_plan_id)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_geotechnical_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geotechnical Instrument business metrics"
  source: "`mining_ecm`.`tailings`.`geotechnical_instrument`"
  dimensions:
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Due Date"
      expr: calibration_due_date
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Acquisition Method"
      expr: data_acquisition_method
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Facility Zone"
      expr: facility_zone
    - name: "Installation Contractor"
      expr: installation_contractor
    - name: "Installation Date"
      expr: installation_date
    - name: "Installation Notes"
      expr: installation_notes
    - name: "Instrument Name"
      expr: instrument_name
    - name: "Instrument Subtype"
      expr: instrument_subtype
    - name: "Instrument Tag"
      expr: instrument_tag
    - name: "Instrument Type"
      expr: instrument_type
    - name: "Is Regulatory Required"
      expr: is_regulatory_required
    - name: "Measurement Unit"
      expr: measurement_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Geotechnical Instrument"
      expr: COUNT(DISTINCT geotechnical_instrument_id)
    - name: "Total Alert Threshold Level 1"
      expr: SUM(alert_threshold_level_1)
    - name: "Average Alert Threshold Level 1"
      expr: AVG(alert_threshold_level_1)
    - name: "Total Alert Threshold Level 2"
      expr: SUM(alert_threshold_level_2)
    - name: "Average Alert Threshold Level 2"
      expr: AVG(alert_threshold_level_2)
    - name: "Total Alert Threshold Level 3"
      expr: SUM(alert_threshold_level_3)
    - name: "Average Alert Threshold Level 3"
      expr: AVG(alert_threshold_level_3)
    - name: "Total Elevation M"
      expr: SUM(elevation_m)
    - name: "Average Elevation M"
      expr: AVG(elevation_m)
    - name: "Total Installation Depth M"
      expr: SUM(installation_depth_m)
    - name: "Average Installation Depth M"
      expr: AVG(installation_depth_m)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Measurement Range Max"
      expr: SUM(measurement_range_max)
    - name: "Average Measurement Range Max"
      expr: AVG(measurement_range_max)
    - name: "Total Measurement Range Min"
      expr: SUM(measurement_range_min)
    - name: "Average Measurement Range Min"
      expr: AVG(measurement_range_min)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_geotechnical_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geotechnical Reading business metrics"
  source: "`mining_ecm`.`tailings`.`geotechnical_reading`"
  dimensions:
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Data Source System"
      expr: data_source_system
    - name: "Incident Flag"
      expr: incident_flag
    - name: "Instrument Type"
      expr: instrument_type
    - name: "Rate Of Change Unit"
      expr: rate_of_change_unit
    - name: "Reading Method"
      expr: reading_method
    - name: "Reading Notes"
      expr: reading_notes
    - name: "Reading Timestamp"
      expr: reading_timestamp
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Threshold Breach Status"
      expr: threshold_breach_status
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Validation Status"
      expr: validation_status
    - name: "Validation Timestamp"
      expr: validation_timestamp
    - name: "Weather Condition"
      expr: weather_condition
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Geotechnical Reading"
      expr: COUNT(DISTINCT geotechnical_reading_id)
    - name: "Total Action Threshold"
      expr: SUM(action_threshold)
    - name: "Average Action Threshold"
      expr: AVG(action_threshold)
    - name: "Total Alert Threshold"
      expr: SUM(alert_threshold)
    - name: "Average Alert Threshold"
      expr: AVG(alert_threshold)
    - name: "Total Baseline Value"
      expr: SUM(baseline_value)
    - name: "Average Baseline Value"
      expr: AVG(baseline_value)
    - name: "Total Deviation From Baseline"
      expr: SUM(deviation_from_baseline)
    - name: "Average Deviation From Baseline"
      expr: AVG(deviation_from_baseline)
    - name: "Total Rate Of Change"
      expr: SUM(rate_of_change)
    - name: "Average Rate Of Change"
      expr: AVG(rate_of_change)
    - name: "Total Reading Value"
      expr: SUM(reading_value)
    - name: "Average Reading Value"
      expr: AVG(reading_value)
    - name: "Total Temperature Celsius"
      expr: SUM(temperature_celsius)
    - name: "Average Temperature Celsius"
      expr: AVG(temperature_celsius)
    - name: "Total Validated By"
      expr: SUM(validated_by)
    - name: "Average Validated By"
      expr: AVG(validated_by)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_material_characterisation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Characterisation business metrics"
  source: "`mining_ecm`.`tailings`.`material_characterisation`"
  dimensions:
    - name: "Ard Classification"
      expr: ard_classification
    - name: "Characterisation Notes"
      expr: characterisation_notes
    - name: "Characterisation Status"
      expr: characterisation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Encapsulation Required Flag"
      expr: encapsulation_required_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Management Strategy"
      expr: management_strategy
    - name: "Material Source"
      expr: material_source
    - name: "Material Type"
      expr: material_type
    - name: "Metal Leaching Risk Rating"
      expr: metal_leaching_risk_rating
    - name: "Sample Collection Date"
      expr: sample_collection_date
    - name: "Sample Location Description"
      expr: sample_location_description
    - name: "Test Date"
      expr: test_date
    - name: "Test Method"
      expr: test_method
    - name: "Test Type"
      expr: test_type
    - name: "Testing Laboratory"
      expr: testing_laboratory
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Characterisation"
      expr: COUNT(DISTINCT material_characterisation_id)
    - name: "Total Acid Neutralisation Capacity Kg H2so4 Per Tonne"
      expr: SUM(acid_neutralisation_capacity_kg_h2so4_per_tonne)
    - name: "Average Acid Neutralisation Capacity Kg H2so4 Per Tonne"
      expr: AVG(acid_neutralisation_capacity_kg_h2so4_per_tonne)
    - name: "Total Arsenic Concentration Mg Per Kg"
      expr: SUM(arsenic_concentration_mg_per_kg)
    - name: "Average Arsenic Concentration Mg Per Kg"
      expr: AVG(arsenic_concentration_mg_per_kg)
    - name: "Total Cadmium Concentration Mg Per Kg"
      expr: SUM(cadmium_concentration_mg_per_kg)
    - name: "Average Cadmium Concentration Mg Per Kg"
      expr: AVG(cadmium_concentration_mg_per_kg)
    - name: "Total Compression Index"
      expr: SUM(compression_index)
    - name: "Average Compression Index"
      expr: AVG(compression_index)
    - name: "Total Consolidation Coefficient M2 Per Year"
      expr: SUM(consolidation_coefficient_m2_per_year)
    - name: "Average Consolidation Coefficient M2 Per Year"
      expr: AVG(consolidation_coefficient_m2_per_year)
    - name: "Total Copper Concentration Mg Per Kg"
      expr: SUM(copper_concentration_mg_per_kg)
    - name: "Average Copper Concentration Mg Per Kg"
      expr: AVG(copper_concentration_mg_per_kg)
    - name: "Total Cyanide Concentration Mg Per Kg"
      expr: SUM(cyanide_concentration_mg_per_kg)
    - name: "Average Cyanide Concentration Mg Per Kg"
      expr: AVG(cyanide_concentration_mg_per_kg)
    - name: "Total Lead Concentration Mg Per Kg"
      expr: SUM(lead_concentration_mg_per_kg)
    - name: "Average Lead Concentration Mg Per Kg"
      expr: AVG(lead_concentration_mg_per_kg)
    - name: "Total Liquid Limit Percent"
      expr: SUM(liquid_limit_percent)
    - name: "Average Liquid Limit Percent"
      expr: AVG(liquid_limit_percent)
    - name: "Total Maximum Potential Acidity Kg H2so4 Per Tonne"
      expr: SUM(maximum_potential_acidity_kg_h2so4_per_tonne)
    - name: "Average Maximum Potential Acidity Kg H2so4 Per Tonne"
      expr: AVG(maximum_potential_acidity_kg_h2so4_per_tonne)
    - name: "Total Mercury Concentration Mg Per Kg"
      expr: SUM(mercury_concentration_mg_per_kg)
    - name: "Average Mercury Concentration Mg Per Kg"
      expr: AVG(mercury_concentration_mg_per_kg)
    - name: "Total Nag Ph"
      expr: SUM(nag_ph)
    - name: "Average Nag Ph"
      expr: AVG(nag_ph)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_monitoring_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitoring Location business metrics"
  source: "`mining_ecm`.`tailings`.`monitoring_location`"
  dimensions:
    - name: "Access Difficulty"
      expr: access_difficulty
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Logger Code"
      expr: data_logger_code
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Installation Date"
      expr: installation_date
    - name: "Instrument Manufacturer"
      expr: instrument_manufacturer
    - name: "Instrument Model"
      expr: instrument_model
    - name: "Instrument Serial Number"
      expr: instrument_serial_number
    - name: "Location Code"
      expr: location_code
    - name: "Location Name"
      expr: location_name
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Monitoring Purpose"
      expr: monitoring_purpose
    - name: "Monitoring Type"
      expr: monitoring_type
    - name: "Next Calibration Due Date"
      expr: next_calibration_due_date
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Monitoring Location"
      expr: COUNT(DISTINCT monitoring_location_id)
    - name: "Total Alert Threshold Lower"
      expr: SUM(alert_threshold_lower)
    - name: "Average Alert Threshold Lower"
      expr: AVG(alert_threshold_lower)
    - name: "Total Alert Threshold Upper"
      expr: SUM(alert_threshold_upper)
    - name: "Average Alert Threshold Upper"
      expr: AVG(alert_threshold_upper)
    - name: "Total Critical Threshold Lower"
      expr: SUM(critical_threshold_lower)
    - name: "Average Critical Threshold Lower"
      expr: AVG(critical_threshold_lower)
    - name: "Total Critical Threshold Upper"
      expr: SUM(critical_threshold_upper)
    - name: "Average Critical Threshold Upper"
      expr: AVG(critical_threshold_upper)
    - name: "Total Elevation M"
      expr: SUM(elevation_m)
    - name: "Average Elevation M"
      expr: AVG(elevation_m)
    - name: "Total Installation Depth M"
      expr: SUM(installation_depth_m)
    - name: "Average Installation Depth M"
      expr: AVG(installation_depth_m)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_rehabilitation_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rehabilitation Activity business metrics"
  source: "`mining_ecm`.`tailings`.`rehabilitation_activity`"
  dimensions:
    - name: "Activity Notes"
      expr: activity_notes
    - name: "Activity Reference Number"
      expr: activity_reference_number
    - name: "Activity Status"
      expr: activity_status
    - name: "Activity Type"
      expr: activity_type
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Notes"
      expr: assessment_notes
    - name: "Assessment Outcome"
      expr: assessment_outcome
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Environmental Monitoring Required"
      expr: environmental_monitoring_required
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Materials Used Description"
      expr: materials_used_description
    - name: "Monitoring Frequency"
      expr: monitoring_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rehabilitation Activity"
      expr: COUNT(DISTINCT rehabilitation_activity_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Area Treated Hectares"
      expr: SUM(area_treated_hectares)
    - name: "Average Area Treated Hectares"
      expr: AVG(area_treated_hectares)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
    - name: "Total Seed Application Rate Kg Per Ha"
      expr: SUM(seed_application_rate_kg_per_ha)
    - name: "Average Seed Application Rate Kg Per Ha"
      expr: AVG(seed_application_rate_kg_per_ha)
    - name: "Total Target Vegetation Cover Percent"
      expr: SUM(target_vegetation_cover_percent)
    - name: "Average Target Vegetation Cover Percent"
      expr: AVG(target_vegetation_cover_percent)
    - name: "Total Topsoil Volume M3"
      expr: SUM(topsoil_volume_m3)
    - name: "Average Topsoil Volume M3"
      expr: AVG(topsoil_volume_m3)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_seepage_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seepage Monitoring business metrics"
  source: "`mining_ecm`.`tailings`.`seepage_monitoring`"
  dimensions:
    - name: "Alert Triggered Flag"
      expr: alert_triggered_flag
    - name: "Comments"
      expr: comments
    - name: "Conductivity Unit"
      expr: conductivity_unit
    - name: "Design Exceedance Flag"
      expr: design_exceedance_flag
    - name: "Flow Rate Unit"
      expr: flow_rate_unit
    - name: "Internal Erosion Risk Indicator"
      expr: internal_erosion_risk_indicator
    - name: "Laboratory Analysis Flag"
      expr: laboratory_analysis_flag
    - name: "Licence Exceedance Flag"
      expr: licence_exceedance_flag
    - name: "Licence Limit Parameter"
      expr: licence_limit_parameter
    - name: "Location Type"
      expr: location_type
    - name: "Measurement Status"
      expr: measurement_status
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Monitoring Point Code"
      expr: monitoring_point_code
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Regulatory Reporting Flag"
      expr: regulatory_reporting_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Seepage Monitoring"
      expr: COUNT(DISTINCT seepage_monitoring_id)
    - name: "Total Arsenic Concentration"
      expr: SUM(arsenic_concentration)
    - name: "Average Arsenic Concentration"
      expr: AVG(arsenic_concentration)
    - name: "Total Copper Concentration"
      expr: SUM(copper_concentration)
    - name: "Average Copper Concentration"
      expr: AVG(copper_concentration)
    - name: "Total Design Seepage Rate"
      expr: SUM(design_seepage_rate)
    - name: "Average Design Seepage Rate"
      expr: AVG(design_seepage_rate)
    - name: "Total Electrical Conductivity"
      expr: SUM(electrical_conductivity)
    - name: "Average Electrical Conductivity"
      expr: AVG(electrical_conductivity)
    - name: "Total Environmental Licence Limit"
      expr: SUM(environmental_licence_limit)
    - name: "Average Environmental Licence Limit"
      expr: AVG(environmental_licence_limit)
    - name: "Total Flow Rate"
      expr: SUM(flow_rate)
    - name: "Average Flow Rate"
      expr: AVG(flow_rate)
    - name: "Total Iron Concentration"
      expr: SUM(iron_concentration)
    - name: "Average Iron Concentration"
      expr: AVG(iron_concentration)
    - name: "Total Lead Concentration"
      expr: SUM(lead_concentration)
    - name: "Average Lead Concentration"
      expr: AVG(lead_concentration)
    - name: "Total Manganese Concentration"
      expr: SUM(manganese_concentration)
    - name: "Average Manganese Concentration"
      expr: AVG(manganese_concentration)
    - name: "Total Ph Level"
      expr: SUM(ph_level)
    - name: "Average Ph Level"
      expr: AVG(ph_level)
    - name: "Total Sulfate Concentration"
      expr: SUM(sulfate_concentration)
    - name: "Average Sulfate Concentration"
      expr: AVG(sulfate_concentration)
    - name: "Total Total Dissolved Solids"
      expr: SUM(total_dissolved_solids)
    - name: "Average Total Dissolved Solids"
      expr: AVG(total_dissolved_solids)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_stability_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability Analysis business metrics"
  source: "`mining_ecm`.`tailings`.`stability_analysis`"
  dimensions:
    - name: "Analysis Date"
      expr: analysis_date
    - name: "Analysis Notes"
      expr: analysis_notes
    - name: "Analysis Reference Number"
      expr: analysis_reference_number
    - name: "Analysis Software"
      expr: analysis_software
    - name: "Analysis Status"
      expr: analysis_status
    - name: "Analysis Type"
      expr: analysis_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Consequence Classification"
      expr: consequence_classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Slip Surface Description"
      expr: critical_slip_surface_description
    - name: "Failure Mode"
      expr: failure_mode
    - name: "Fos Compliance Flag"
      expr: fos_compliance_flag
    - name: "Independent Reviewer"
      expr: independent_reviewer
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loading Condition"
      expr: loading_condition
    - name: "Next Review Due Date"
      expr: next_review_due_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stability Analysis"
      expr: COUNT(DISTINCT stability_analysis_id)
    - name: "Total Cohesion Kpa"
      expr: SUM(cohesion_kpa)
    - name: "Average Cohesion Kpa"
      expr: AVG(cohesion_kpa)
    - name: "Total Factor Of Safety"
      expr: SUM(factor_of_safety)
    - name: "Average Factor Of Safety"
      expr: AVG(factor_of_safety)
    - name: "Total Friction Angle Degrees"
      expr: SUM(friction_angle_degrees)
    - name: "Average Friction Angle Degrees"
      expr: AVG(friction_angle_degrees)
    - name: "Total Minimum Required Fos"
      expr: SUM(minimum_required_fos)
    - name: "Average Minimum Required Fos"
      expr: AVG(minimum_required_fos)
    - name: "Total Peak Ground Acceleration G"
      expr: SUM(peak_ground_acceleration_g)
    - name: "Average Peak Ground Acceleration G"
      expr: AVG(peak_ground_acceleration_g)
    - name: "Total Seismic Coefficient"
      expr: SUM(seismic_coefficient)
    - name: "Average Seismic Coefficient"
      expr: AVG(seismic_coefficient)
    - name: "Total Unit Weight Kn M3"
      expr: SUM(unit_weight_kn_m3)
    - name: "Average Unit Weight Kn M3"
      expr: AVG(unit_weight_kn_m3)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_tarp_trigger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tarp Trigger business metrics"
  source: "`mining_ecm`.`tailings`.`tarp_trigger`"
  dimensions:
    - name: "Activation Timestamp"
      expr: activation_timestamp
    - name: "Closure Approved By"
      expr: closure_approved_by
    - name: "Closure Timestamp"
      expr: closure_timestamp
    - name: "Corrective Actions"
      expr: corrective_actions
    - name: "Data Source System"
      expr: data_source_system
    - name: "Detection Method"
      expr: detection_method
    - name: "Environmental Impact Assessment"
      expr: environmental_impact_assessment
    - name: "Investigation Completion Date"
      expr: investigation_completion_date
    - name: "Investigation Required Flag"
      expr: investigation_required_flag
    - name: "Lessons Learned"
      expr: lessons_learned
    - name: "Notification Timestamp"
      expr: notification_timestamp
    - name: "Notified Personnel"
      expr: notified_personnel
    - name: "Parameter Category"
      expr: parameter_category
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Regulatory Authority"
      expr: regulatory_authority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tarp Trigger"
      expr: COUNT(DISTINCT tarp_trigger_id)
    - name: "Total Exceedance Percentage"
      expr: SUM(exceedance_percentage)
    - name: "Average Exceedance Percentage"
      expr: AVG(exceedance_percentage)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_tsf`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tsf business metrics"
  source: "`mining_ecm`.`tailings`.`tsf`"
  dimensions:
    - name: "Classification Assessment Date"
      expr: classification_assessment_date
    - name: "Classification Assessor"
      expr: classification_assessor
    - name: "Closure Date"
      expr: closure_date
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Consequence Classification"
      expr: consequence_classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Raise Level"
      expr: current_raise_level
    - name: "Dam Safety Review Frequency Months"
      expr: dam_safety_review_frequency_months
    - name: "Dam Type"
      expr: dam_type
    - name: "Downstream Infrastructure Exposure"
      expr: downstream_infrastructure_exposure
    - name: "Eis Reference"
      expr: eis_reference
    - name: "Emergency Preparedness Plan Reference"
      expr: emergency_preparedness_plan_reference
    - name: "Engineer Of Record"
      expr: engineer_of_record
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Name"
      expr: facility_name
    - name: "Failure Mode Scenario"
      expr: failure_mode_scenario
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tsf"
      expr: COUNT(DISTINCT tsf_id)
    - name: "Total Catchment Area Km2"
      expr: SUM(catchment_area_km2)
    - name: "Average Catchment Area Km2"
      expr: AVG(catchment_area_km2)
    - name: "Total Current Capacity M3"
      expr: SUM(current_capacity_m3)
    - name: "Average Current Capacity M3"
      expr: AVG(current_capacity_m3)
    - name: "Total Current Height M"
      expr: SUM(current_height_m)
    - name: "Average Current Height M"
      expr: AVG(current_height_m)
    - name: "Total Design Capacity M3"
      expr: SUM(design_capacity_m3)
    - name: "Average Design Capacity M3"
      expr: AVG(design_capacity_m3)
    - name: "Total Design Height M"
      expr: SUM(design_height_m)
    - name: "Average Design Height M"
      expr: AVG(design_height_m)
    - name: "Total Estimated Closure Liability Usd"
      expr: SUM(estimated_closure_liability_usd)
    - name: "Average Estimated Closure Liability Usd"
      expr: AVG(estimated_closure_liability_usd)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_tsf_capacity_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tsf Capacity Survey business metrics"
  source: "`mining_ecm`.`tailings`.`tsf_capacity_survey`"
  dimensions:
    - name: "Coordinate System"
      expr: coordinate_system
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Freeboard Compliance Flag"
      expr: freeboard_compliance_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Projected Capacity Exhaustion Date"
      expr: projected_capacity_exhaustion_date
    - name: "Regulatory Submission Date"
      expr: regulatory_submission_date
    - name: "Regulatory Submission Flag"
      expr: regulatory_submission_flag
    - name: "Survey Accuracy Classification"
      expr: survey_accuracy_classification
    - name: "Survey Date"
      expr: survey_date
    - name: "Survey Method"
      expr: survey_method
    - name: "Survey Notes"
      expr: survey_notes
    - name: "Survey Reference Number"
      expr: survey_reference_number
    - name: "Survey Report Reference"
      expr: survey_report_reference
    - name: "Survey Status"
      expr: survey_status
    - name: "Surveyor Company"
      expr: surveyor_company
    - name: "Surveyor Name"
      expr: surveyor_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tsf Capacity Survey"
      expr: COUNT(DISTINCT tsf_capacity_survey_id)
    - name: "Total Beach Elevation M"
      expr: SUM(beach_elevation_m)
    - name: "Average Beach Elevation M"
      expr: AVG(beach_elevation_m)
    - name: "Total Capacity Utilization Percent"
      expr: SUM(capacity_utilization_percent)
    - name: "Average Capacity Utilization Percent"
      expr: AVG(capacity_utilization_percent)
    - name: "Total Crest Elevation M"
      expr: SUM(crest_elevation_m)
    - name: "Average Crest Elevation M"
      expr: AVG(crest_elevation_m)
    - name: "Total Current Storage Volume M3"
      expr: SUM(current_storage_volume_m3)
    - name: "Average Current Storage Volume M3"
      expr: AVG(current_storage_volume_m3)
    - name: "Total Design Capacity M3"
      expr: SUM(design_capacity_m3)
    - name: "Average Design Capacity M3"
      expr: AVG(design_capacity_m3)
    - name: "Total Estimated Filling Rate M3 Per Day"
      expr: SUM(estimated_filling_rate_m3_per_day)
    - name: "Average Estimated Filling Rate M3 Per Day"
      expr: AVG(estimated_filling_rate_m3_per_day)
    - name: "Total Freeboard M"
      expr: SUM(freeboard_m)
    - name: "Average Freeboard M"
      expr: AVG(freeboard_m)
    - name: "Total Horizontal Accuracy M"
      expr: SUM(horizontal_accuracy_m)
    - name: "Average Horizontal Accuracy M"
      expr: AVG(horizontal_accuracy_m)
    - name: "Total Minimum Required Freeboard M"
      expr: SUM(minimum_required_freeboard_m)
    - name: "Average Minimum Required Freeboard M"
      expr: AVG(minimum_required_freeboard_m)
    - name: "Total Pond Elevation M"
      expr: SUM(pond_elevation_m)
    - name: "Average Pond Elevation M"
      expr: AVG(pond_elevation_m)
    - name: "Total Pond Surface Area M2"
      expr: SUM(pond_surface_area_m2)
    - name: "Average Pond Surface Area M2"
      expr: AVG(pond_surface_area_m2)
    - name: "Total Remaining Airspace M3"
      expr: SUM(remaining_airspace_m3)
    - name: "Average Remaining Airspace M3"
      expr: AVG(remaining_airspace_m3)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_tsf_raise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tsf Raise business metrics"
  source: "`mining_ecm`.`tailings`.`tsf_raise`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "As Built Drawing Reference"
      expr: as_built_drawing_reference
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Consequence Classification"
      expr: consequence_classification
    - name: "Construction Contractor"
      expr: construction_contractor
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Document Reference"
      expr: design_document_reference
    - name: "Geotechnical Sign Off Date"
      expr: geotechnical_sign_off_date
    - name: "Independent Reviewer"
      expr: independent_reviewer
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Planned Completion Date"
      expr: planned_completion_date
    - name: "Planned Start Date"
      expr: planned_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tsf Raise"
      expr: COUNT(DISTINCT tsf_raise_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Additional Storage Capacity M3"
      expr: SUM(additional_storage_capacity_m3)
    - name: "Average Additional Storage Capacity M3"
      expr: AVG(additional_storage_capacity_m3)
    - name: "Total As Built Crest Elevation M"
      expr: SUM(as_built_crest_elevation_m)
    - name: "Average As Built Crest Elevation M"
      expr: AVG(as_built_crest_elevation_m)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
    - name: "Total Raise Height M"
      expr: SUM(raise_height_m)
    - name: "Average Raise Height M"
      expr: AVG(raise_height_m)
    - name: "Total Raise Volume M3"
      expr: SUM(raise_volume_m3)
    - name: "Average Raise Volume M3"
      expr: AVG(raise_volume_m3)
    - name: "Total Target Crest Elevation M"
      expr: SUM(target_crest_elevation_m)
    - name: "Average Target Crest Elevation M"
      expr: AVG(target_crest_elevation_m)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_waste_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste Placement business metrics"
  source: "`mining_ecm`.`tailings`.`waste_placement`"
  dimensions:
    - name: "Compaction Method"
      expr: compaction_method
    - name: "Compaction Passes"
      expr: compaction_passes
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Compliance Status"
      expr: design_compliance_status
    - name: "Dump Location Code"
      expr: dump_location_code
    - name: "Environmental Clearance Flag"
      expr: environmental_clearance_flag
    - name: "Geochemical Classification"
      expr: geochemical_classification
    - name: "Gps Coordinates"
      expr: gps_coordinates
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lift Number"
      expr: lift_number
    - name: "Material Type"
      expr: material_type
    - name: "Non Conformance Description"
      expr: non_conformance_description
    - name: "Non Conformance Flag"
      expr: non_conformance_flag
    - name: "Placement Date"
      expr: placement_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Waste Placement"
      expr: COUNT(DISTINCT waste_placement_id)
    - name: "Total Density Achieved T M3"
      expr: SUM(density_achieved_t_m3)
    - name: "Average Density Achieved T M3"
      expr: AVG(density_achieved_t_m3)
    - name: "Total Elevation M"
      expr: SUM(elevation_m)
    - name: "Average Elevation M"
      expr: AVG(elevation_m)
    - name: "Total Moisture Content Percent"
      expr: SUM(moisture_content_percent)
    - name: "Average Moisture Content Percent"
      expr: AVG(moisture_content_percent)
    - name: "Total Planned Volume M3"
      expr: SUM(planned_volume_m3)
    - name: "Average Planned Volume M3"
      expr: AVG(planned_volume_m3)
    - name: "Total Tonnage Placed T"
      expr: SUM(tonnage_placed_t)
    - name: "Average Tonnage Placed T"
      expr: AVG(tonnage_placed_t)
    - name: "Total Volume Placed M3"
      expr: SUM(volume_placed_m3)
    - name: "Average Volume Placed M3"
      expr: AVG(volume_placed_m3)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_waste_rock_dump`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste Rock Dump business metrics"
  source: "`mining_ecm`.`tailings`.`waste_rock_dump`"
  dimensions:
    - name: "Approval Reference"
      expr: approval_reference
    - name: "Ard Classification"
      expr: ard_classification
    - name: "Closure Date"
      expr: closure_date
    - name: "Comments"
      expr: comments
    - name: "Compaction Required Flag"
      expr: compaction_required_flag
    - name: "Construction Start Date"
      expr: construction_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Lift Number"
      expr: current_lift_number
    - name: "Dominant Material Type"
      expr: dominant_material_type
    - name: "Drainage System Type"
      expr: drainage_system_type
    - name: "Dump Code"
      expr: dump_code
    - name: "Dump Name"
      expr: dump_name
    - name: "Dump Type"
      expr: dump_type
    - name: "Geochemical Risk Rating"
      expr: geochemical_risk_rating
    - name: "Inspection Outcome"
      expr: inspection_outcome
    - name: "Last Inspection Date"
      expr: last_inspection_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Waste Rock Dump"
      expr: COUNT(DISTINCT waste_rock_dump_id)
    - name: "Total Batter Angle Degrees"
      expr: SUM(batter_angle_degrees)
    - name: "Average Batter Angle Degrees"
      expr: AVG(batter_angle_degrees)
    - name: "Total Current Volume M3"
      expr: SUM(current_volume_m3)
    - name: "Average Current Volume M3"
      expr: AVG(current_volume_m3)
    - name: "Total Design Capacity M3"
      expr: SUM(design_capacity_m3)
    - name: "Average Design Capacity M3"
      expr: AVG(design_capacity_m3)
    - name: "Total Elevation M"
      expr: SUM(elevation_m)
    - name: "Average Elevation M"
      expr: AVG(elevation_m)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Maximum Lift Height M"
      expr: SUM(maximum_lift_height_m)
    - name: "Average Maximum Lift Height M"
      expr: AVG(maximum_lift_height_m)
    - name: "Total Rehabilitation Provision Amount"
      expr: SUM(rehabilitation_provision_amount)
    - name: "Average Rehabilitation Provision Amount"
      expr: AVG(rehabilitation_provision_amount)
    - name: "Total Remaining Capacity M3"
      expr: SUM(remaining_capacity_m3)
    - name: "Average Remaining Capacity M3"
      expr: AVG(remaining_capacity_m3)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_water_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water Balance business metrics"
  source: "`mining_ecm`.`tailings`.`water_balance`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Balance Calculation Timestamp"
      expr: balance_calculation_timestamp
    - name: "Balance Notes"
      expr: balance_notes
    - name: "Balance Period End Date"
      expr: balance_period_end_date
    - name: "Balance Period Start Date"
      expr: balance_period_start_date
    - name: "Balance Status"
      expr: balance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Reviewed By"
      expr: reviewed_by
    - name: "Water Licence Compliance Status"
      expr: water_licence_compliance_status
    - name: "Balance Calculation Timestamp Month"
      expr: DATE_TRUNC('MONTH', balance_calculation_timestamp)
    - name: "Balance Period End Date Month"
      expr: DATE_TRUNC('MONTH', balance_period_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Water Balance"
      expr: COUNT(DISTINCT water_balance_id)
    - name: "Total Balance Reconciliation Variance M3"
      expr: SUM(balance_reconciliation_variance_m3)
    - name: "Average Balance Reconciliation Variance M3"
      expr: AVG(balance_reconciliation_variance_m3)
    - name: "Total Balance Reconciliation Variance Percent"
      expr: SUM(balance_reconciliation_variance_percent)
    - name: "Average Balance Reconciliation Variance Percent"
      expr: AVG(balance_reconciliation_variance_percent)
    - name: "Total Closing Pond Level M"
      expr: SUM(closing_pond_level_m)
    - name: "Average Closing Pond Level M"
      expr: AVG(closing_pond_level_m)
    - name: "Total Closing Storage Volume M3"
      expr: SUM(closing_storage_volume_m3)
    - name: "Average Closing Storage Volume M3"
      expr: AVG(closing_storage_volume_m3)
    - name: "Total Crest Elevation M"
      expr: SUM(crest_elevation_m)
    - name: "Average Crest Elevation M"
      expr: AVG(crest_elevation_m)
    - name: "Total Decant Return Outflow M3"
      expr: SUM(decant_return_outflow_m3)
    - name: "Average Decant Return Outflow M3"
      expr: AVG(decant_return_outflow_m3)
    - name: "Total Design Freeboard M"
      expr: SUM(design_freeboard_m)
    - name: "Average Design Freeboard M"
      expr: AVG(design_freeboard_m)
    - name: "Total Evaporation Outflow M3"
      expr: SUM(evaporation_outflow_m3)
    - name: "Average Evaporation Outflow M3"
      expr: AVG(evaporation_outflow_m3)
    - name: "Total Freeboard M"
      expr: SUM(freeboard_m)
    - name: "Average Freeboard M"
      expr: AVG(freeboard_m)
    - name: "Total Groundwater Inflow M3"
      expr: SUM(groundwater_inflow_m3)
    - name: "Average Groundwater Inflow M3"
      expr: AVG(groundwater_inflow_m3)
    - name: "Total Opening Pond Level M"
      expr: SUM(opening_pond_level_m)
    - name: "Average Opening Pond Level M"
      expr: AVG(opening_pond_level_m)
    - name: "Total Opening Storage Volume M3"
      expr: SUM(opening_storage_volume_m3)
    - name: "Average Opening Storage Volume M3"
      expr: AVG(opening_storage_volume_m3)
$$;