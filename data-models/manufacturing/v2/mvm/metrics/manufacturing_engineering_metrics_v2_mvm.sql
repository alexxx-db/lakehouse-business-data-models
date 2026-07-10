-- Metric views for domain: engineering | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:48:32

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`bom`"
  dimensions:
    - name: "Alternative Bom Indicator"
      expr: alternative_bom_indicator
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Bom Number"
      expr: bom_number
    - name: "Bom Status"
      expr: bom_status
    - name: "Bom Type"
      expr: bom_type
    - name: "Category"
      expr: category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Engineering Change Order Number"
      expr: engineering_change_order_number
    - name: "Explosion Type"
      expr: explosion_type
    - name: "Is Configurable"
      expr: is_configurable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom"
      expr: COUNT(DISTINCT bom_id)
    - name: "Total Configuration Profile"
      expr: SUM(configuration_profile)
    - name: "Average Configuration Profile"
      expr: AVG(configuration_profile)
    - name: "Total Cost Estimate Currency"
      expr: SUM(cost_estimate_currency)
    - name: "Average Cost Estimate Currency"
      expr: AVG(cost_estimate_currency)
    - name: "Total Cost Estimate Total"
      expr: SUM(cost_estimate_total)
    - name: "Average Cost Estimate Total"
      expr: AVG(cost_estimate_total)
    - name: "Total Lot Size"
      expr: SUM(lot_size)
    - name: "Average Lot Size"
      expr: AVG(lot_size)
    - name: "Total Plm Item Code"
      expr: SUM(plm_item_code)
    - name: "Average Plm Item Code"
      expr: AVG(plm_item_code)
    - name: "Total Quantity Basis"
      expr: SUM(quantity_basis)
    - name: "Average Quantity Basis"
      expr: AVG(quantity_basis)
    - name: "Total Scrap Percentage"
      expr: SUM(scrap_percentage)
    - name: "Average Scrap Percentage"
      expr: AVG(scrap_percentage)
    - name: "Total Weight Total"
      expr: SUM(weight_total)
    - name: "Average Weight Total"
      expr: AVG(weight_total)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom Line business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`bom_line`"
  dimensions:
    - name: "Assembly Instruction"
      expr: assembly_instruction
    - name: "Bulk Material Flag"
      expr: bulk_material_flag
    - name: "Change Number"
      expr: change_number
    - name: "Co Product Flag"
      expr: co_product_flag
    - name: "Cost Rollup Flag"
      expr: cost_rollup_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Component Flag"
      expr: critical_component_flag
    - name: "Effectivity End Date"
      expr: effectivity_end_date
    - name: "Effectivity Serial Number End"
      expr: effectivity_serial_number_end
    - name: "Effectivity Serial Number Start"
      expr: effectivity_serial_number_start
    - name: "Effectivity Start Date"
      expr: effectivity_start_date
    - name: "Engineering Bom Line Status"
      expr: engineering_bom_line_status
    - name: "Engineering Notes"
      expr: engineering_notes
    - name: "Find Number"
      expr: find_number
    - name: "Fixed Quantity Flag"
      expr: fixed_quantity_flag
    - name: "Installation Point"
      expr: installation_point
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom Line"
      expr: COUNT(DISTINCT bom_line_id)
    - name: "Total Quantity Per Assembly"
      expr: SUM(quantity_per_assembly)
    - name: "Average Quantity Per Assembly"
      expr: AVG(quantity_per_assembly)
    - name: "Total Scrap Factor Percentage"
      expr: SUM(scrap_factor_percentage)
    - name: "Average Scrap Factor Percentage"
      expr: AVG(scrap_factor_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_cad_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cad Model business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`cad_model`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Authoring Tool"
      expr: authoring_tool
    - name: "Authoring Tool Version"
      expr: authoring_tool_version
    - name: "Cam Programming Required"
      expr: cam_programming_required
    - name: "Checksum Hash"
      expr: checksum_hash
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dataset Type"
      expr: dataset_type
    - name: "Design Intent"
      expr: design_intent
    - name: "Dfm Analysis Status"
      expr: dfm_analysis_status
    - name: "Drawing Number"
      expr: drawing_number
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "File Format"
      expr: file_format
    - name: "Intellectual Property Owner"
      expr: intellectual_property_owner
    - name: "Is Confidential"
      expr: is_confidential
    - name: "Material Specification"
      expr: material_specification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cad Model"
      expr: COUNT(DISTINCT cad_model_id)
    - name: "Total Bounding Box Height"
      expr: SUM(bounding_box_height)
    - name: "Average Bounding Box Height"
      expr: AVG(bounding_box_height)
    - name: "Total Bounding Box Length"
      expr: SUM(bounding_box_length)
    - name: "Average Bounding Box Length"
      expr: AVG(bounding_box_length)
    - name: "Total Bounding Box Width"
      expr: SUM(bounding_box_width)
    - name: "Average Bounding Box Width"
      expr: AVG(bounding_box_width)
    - name: "Total Cam Program Reference"
      expr: SUM(cam_program_reference)
    - name: "Average Cam Program Reference"
      expr: AVG(cam_program_reference)
    - name: "Total Center Of Gravity X"
      expr: SUM(center_of_gravity_x)
    - name: "Average Center Of Gravity X"
      expr: AVG(center_of_gravity_x)
    - name: "Total Center Of Gravity Y"
      expr: SUM(center_of_gravity_y)
    - name: "Average Center Of Gravity Y"
      expr: AVG(center_of_gravity_y)
    - name: "Total Center Of Gravity Z"
      expr: SUM(center_of_gravity_z)
    - name: "Average Center Of Gravity Z"
      expr: AVG(center_of_gravity_z)
    - name: "Total Dfm Complexity Score"
      expr: SUM(dfm_complexity_score)
    - name: "Average Dfm Complexity Score"
      expr: AVG(dfm_complexity_score)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
    - name: "Total Model Mass"
      expr: SUM(model_mass)
    - name: "Average Model Mass"
      expr: AVG(model_mass)
    - name: "Total Model Surface Area"
      expr: SUM(model_surface_area)
    - name: "Average Model Surface Area"
      expr: AVG(model_surface_area)
    - name: "Total Model Volume"
      expr: SUM(model_volume)
    - name: "Average Model Volume"
      expr: AVG(model_volume)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`component`"
  dimensions:
    - name: "Abc Classification"
      expr: abc_classification
    - name: "Cad Model Reference"
      expr: cad_model_reference
    - name: "Ce Marking Flag"
      expr: ce_marking_flag
    - name: "Commodity Code"
      expr: commodity_code
    - name: "Component Number"
      expr: component_number
    - name: "Component Type"
      expr: component_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Dfmea Reference"
      expr: dfmea_reference
    - name: "Drawing Number"
      expr: drawing_number
    - name: "Effective Date"
      expr: effective_date
    - name: "Functional Group"
      expr: functional_group
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lifecycle Phase"
      expr: lifecycle_phase
    - name: "Make Or Buy"
      expr: make_or_buy
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Component"
      expr: COUNT(DISTINCT component_id)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Dfm Score"
      expr: SUM(dfm_score)
    - name: "Average Dfm Score"
      expr: AVG(dfm_score)
    - name: "Total Height Mm"
      expr: SUM(height_mm)
    - name: "Average Height Mm"
      expr: AVG(height_mm)
    - name: "Total Length Mm"
      expr: SUM(length_mm)
    - name: "Average Length Mm"
      expr: AVG(length_mm)
    - name: "Total Lot Size"
      expr: SUM(lot_size)
    - name: "Average Lot Size"
      expr: AVG(lot_size)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
    - name: "Total Safety Stock Quantity"
      expr: SUM(safety_stock_quantity)
    - name: "Average Safety Stock Quantity"
      expr: AVG(safety_stock_quantity)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
    - name: "Total Width Mm"
      expr: SUM(width_mm)
    - name: "Average Width Mm"
      expr: AVG(width_mm)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_drawing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drawing business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`drawing`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Assembly Level"
      expr: assembly_level
    - name: "Checked By"
      expr: checked_by
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Drawing Number"
      expr: drawing_number
    - name: "Drawing Status"
      expr: drawing_status
    - name: "Drawing Type"
      expr: drawing_type
    - name: "Drawn By"
      expr: drawn_by
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "File Format"
      expr: file_format
    - name: "File Path"
      expr: file_path
    - name: "Is Master Drawing"
      expr: is_master_drawing
    - name: "Language Code"
      expr: language_code
    - name: "Material Callout"
      expr: material_callout
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drawing"
      expr: COUNT(DISTINCT drawing_id)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_ecn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ecn business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`ecn`"
  dimensions:
    - name: "Acknowledgement Count"
      expr: acknowledgement_count
    - name: "Acknowledgement Required"
      expr: acknowledgement_required
    - name: "Acknowledgement Target Count"
      expr: acknowledgement_target_count
    - name: "Affected Drawing Count"
      expr: affected_drawing_count
    - name: "Affected Part Count"
      expr: affected_part_count
    - name: "Affected Product Lines"
      expr: affected_product_lines
    - name: "Approval Date"
      expr: approval_date
    - name: "Bom Impact Flag"
      expr: bom_impact_flag
    - name: "Change Category"
      expr: change_category
    - name: "Change Description"
      expr: change_description
    - name: "Change Reason"
      expr: change_reason
    - name: "Closure Date"
      expr: closure_date
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Required"
      expr: customer_notification_required
    - name: "Distribution List"
      expr: distribution_list
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ecn"
      expr: COUNT(DISTINCT ecn_id)
    - name: "Total Cost Impact Currency"
      expr: SUM(cost_impact_currency)
    - name: "Average Cost Impact Currency"
      expr: AVG(cost_impact_currency)
    - name: "Total Cost Impact Estimate"
      expr: SUM(cost_impact_estimate)
    - name: "Average Cost Impact Estimate"
      expr: AVG(cost_impact_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_eco`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eco business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`eco`"
  dimensions:
    - name: "Acknowledgement Count"
      expr: acknowledgement_count
    - name: "Acknowledgement Required"
      expr: acknowledgement_required
    - name: "Actual Schedule Impact Days"
      expr: actual_schedule_impact_days
    - name: "Affected Items Count"
      expr: affected_items_count
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By Name"
      expr: approved_by_name
    - name: "Approved By Title"
      expr: approved_by_title
    - name: "Change Priority"
      expr: change_priority
    - name: "Change Type"
      expr: change_type
    - name: "Closure Date"
      expr: closure_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Approval Date"
      expr: customer_approval_date
    - name: "Customer Approval Received"
      expr: customer_approval_received
    - name: "Description"
      expr: description
    - name: "Disposition Action"
      expr: disposition_action
    - name: "Eco Number"
      expr: eco_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eco"
      expr: COUNT(DISTINCT eco_id)
    - name: "Total Actual Cost Impact"
      expr: SUM(actual_cost_impact)
    - name: "Average Actual Cost Impact"
      expr: AVG(actual_cost_impact)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Estimated Cost Impact"
      expr: SUM(estimated_cost_impact)
    - name: "Average Estimated Cost Impact"
      expr: AVG(estimated_cost_impact)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_engineering_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Specification business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_specification`"
  dimensions:
    - name: "Acceptance Criteria"
      expr: acceptance_criteria
    - name: "Applicable Standards"
      expr: applicable_standards
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approver Name"
      expr: approver_name
    - name: "Change Reason"
      expr: change_reason
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Authority"
      expr: design_authority
    - name: "Dfm Analysis Completed"
      expr: dfm_analysis_completed
    - name: "Dfmea Reference"
      expr: dfmea_reference
    - name: "Document Format"
      expr: document_format
    - name: "Document Location"
      expr: document_location
    - name: "Effective Date"
      expr: effective_date
    - name: "Environmental Conditions"
      expr: environmental_conditions
    - name: "Language"
      expr: language
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Engineering Specification"
      expr: COUNT(DISTINCT engineering_specification_id)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`project`"
  dimensions:
    - name: "Actual Launch Date"
      expr: actual_launch_date
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Business Justification"
      expr: business_justification
    - name: "Capex Opex Classification"
      expr: capex_opex_classification
    - name: "Code"
      expr: code
    - name: "Complexity Score"
      expr: complexity_score
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Design Methodology"
      expr: design_methodology
    - name: "Design Review Count"
      expr: design_review_count
    - name: "Dfm Analysis Completed"
      expr: dfm_analysis_completed
    - name: "Dfmea Completed"
      expr: dfmea_completed
    - name: "Eco Count"
      expr: eco_count
    - name: "End Date"
      expr: end_date
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Project"
      expr: COUNT(DISTINCT project_id)
    - name: "Total Budget Allocated Amount"
      expr: SUM(budget_allocated_amount)
    - name: "Average Budget Allocated Amount"
      expr: AVG(budget_allocated_amount)
    - name: "Total Budget Currency Code"
      expr: SUM(budget_currency_code)
    - name: "Average Budget Currency Code"
      expr: AVG(budget_currency_code)
    - name: "Total Budget Spent Amount"
      expr: SUM(budget_spent_amount)
    - name: "Average Budget Spent Amount"
      expr: AVG(budget_spent_amount)
    - name: "Total Collaboration Partners"
      expr: SUM(collaboration_partners)
    - name: "Average Collaboration Partners"
      expr: AVG(collaboration_partners)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project_component_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project Component Assignment business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`project_component_assignment`"
  dimensions:
    - name: "Assigned Engineer"
      expr: assigned_engineer
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Development Status"
      expr: development_status
    - name: "Milestone Date"
      expr: milestone_date
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Priority Level"
      expr: priority_level
    - name: "Role In Project"
      expr: role_in_project
    - name: "Target Revision"
      expr: target_revision
    - name: "Assignment End Date Month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
    - name: "Assignment Start Date Month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Project Component Assignment"
      expr: COUNT(DISTINCT project_component_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revision business metrics"
  source: "`vibe_manufacturing_v1`.`engineering`.`revision`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Cad File Reference"
      expr: cad_file_reference
    - name: "Ce Marking Required"
      expr: ce_marking_required
    - name: "Change Category"
      expr: change_category
    - name: "Change Impact Level"
      expr: change_impact_level
    - name: "Change Justification"
      expr: change_justification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dfm Analysis Completed"
      expr: dfm_analysis_completed
    - name: "Dfmea Completed"
      expr: dfmea_completed
    - name: "Drawing Number"
      expr: drawing_number
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Interchangeability Code"
      expr: interchangeability_code
    - name: "Label"
      expr: label
    - name: "Lifecycle State"
      expr: lifecycle_state
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revision"
      expr: COUNT(DISTINCT revision_id)
    - name: "Total Configuration Baseline"
      expr: SUM(configuration_baseline)
    - name: "Average Configuration Baseline"
      expr: AVG(configuration_baseline)
$$;