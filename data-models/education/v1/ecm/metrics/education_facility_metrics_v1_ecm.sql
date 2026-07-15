-- Metric views for domain: facility | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_building`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic building performance metrics including space efficiency, financial performance, and facility condition for capital planning and operational optimization decisions"
  source: "`education_ecm`.`facility`.`building`"
  dimensions:
    - name: "building_code"
      expr: building_code
      comment: "Unique building identifier code"
    - name: "building_name"
      expr: building_name
      comment: "Building name for reporting"
    - name: "building_type"
      expr: building_type
      comment: "Building classification (academic, administrative, residential, research, etc.)"
    - name: "campus_id"
      expr: campus_id
      comment: "Campus location identifier"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, inactive, under renovation, etc.)"
    - name: "ownership_status"
      expr: ownership_status
      comment: "Ownership classification (owned, leased, etc.)"
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "LEED sustainability certification level"
    - name: "ada_compliant"
      expr: ada_compliant
      comment: "ADA compliance status flag"
    - name: "construction_decade"
      expr: CONCAT(SUBSTRING(construction_year, 1, 3), '0s')
      comment: "Decade of original construction for age cohort analysis"
    - name: "energy_star_tier"
      expr: CASE WHEN CAST(energy_star_score AS INT) >= 75 THEN 'High Performer' WHEN CAST(energy_star_score AS INT) >= 50 THEN 'Average' WHEN energy_star_score IS NOT NULL THEN 'Below Average' ELSE 'Not Rated' END
      comment: "Energy Star performance tier for sustainability reporting"
  measures:
    - name: "total_buildings"
      expr: COUNT(DISTINCT building_id)
      comment: "Total count of distinct buildings for portfolio size tracking"
    - name: "total_gross_square_feet"
      expr: SUM(CAST(gross_square_feet AS DOUBLE))
      comment: "Total gross square footage across buildings for space inventory"
    - name: "total_assignable_square_feet"
      expr: SUM(CAST(assignable_square_feet AS DOUBLE))
      comment: "Total assignable square footage for utilization planning"
    - name: "avg_space_utilization_rate"
      expr: AVG(CAST(space_utilization_rate AS DOUBLE))
      comment: "Average space utilization rate for efficiency assessment"
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of building portfolio for insurance and capital planning"
    - name: "total_annual_operating_cost"
      expr: SUM(CAST(annual_operating_cost AS DOUBLE))
      comment: "Total annual operating costs for budget planning and cost management"
    - name: "total_deferred_maintenance_backlog"
      expr: SUM(CAST(deferred_maintenance_backlog AS DOUBLE))
      comment: "Total deferred maintenance backlog for capital prioritization and risk assessment"
    - name: "avg_facility_condition_index"
      expr: AVG(CAST(facility_condition_index AS DOUBLE))
      comment: "Average facility condition index (FCI) for portfolio health assessment; lower is better"
    - name: "operating_cost_per_gsf"
      expr: ROUND(SUM(CAST(annual_operating_cost AS DOUBLE)) / NULLIF(SUM(CAST(gross_square_feet AS DOUBLE)), 0), 2)
      comment: "Operating cost per gross square foot for cost efficiency benchmarking"
    - name: "assignable_to_gross_ratio"
      expr: ROUND(SUM(CAST(assignable_square_feet AS DOUBLE)) / NULLIF(SUM(CAST(gross_square_feet AS DOUBLE)), 0), 3)
      comment: "Assignable to gross square footage ratio for space efficiency analysis"
    - name: "deferred_maintenance_per_gsf"
      expr: ROUND(SUM(CAST(deferred_maintenance_backlog AS DOUBLE)) / NULLIF(SUM(CAST(gross_square_feet AS DOUBLE)), 0), 2)
      comment: "Deferred maintenance per gross square foot for capital needs assessment"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project portfolio performance metrics for investment oversight, schedule adherence, and budget control decisions"
  source: "`education_ecm`.`facility`.`capital_project`"
  dimensions:
    - name: "project_number"
      expr: project_number
      comment: "Unique project identifier"
    - name: "project_name"
      expr: project_name
      comment: "Project name for reporting"
    - name: "project_type"
      expr: project_type
      comment: "Project classification (new construction, renovation, infrastructure, etc.)"
    - name: "project_status"
      expr: project_status
      comment: "Current project status (planning, design, construction, closeout, etc.)"
    - name: "project_phase"
      expr: project_phase
      comment: "Current project phase"
    - name: "project_priority"
      expr: project_priority
      comment: "Project priority level for resource allocation"
    - name: "risk_level"
      expr: risk_level
      comment: "Project risk classification"
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level for sustainability goals"
    - name: "fiscal_year_planned_start"
      expr: YEAR(planned_start_date)
      comment: "Fiscal year of planned project start"
    - name: "fiscal_year_planned_completion"
      expr: YEAR(planned_completion_date)
      comment: "Fiscal year of planned project completion"
  measures:
    - name: "total_projects"
      expr: COUNT(DISTINCT capital_project_id)
      comment: "Total count of capital projects for portfolio tracking"
    - name: "total_authorized_budget"
      expr: SUM(CAST(total_authorized_budget AS DOUBLE))
      comment: "Total authorized budget across projects for capital planning"
    - name: "total_actual_expenditures"
      expr: SUM(CAST(actual_expenditures_to_date AS DOUBLE))
      comment: "Total actual expenditures to date for spend tracking"
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance AS DOUBLE))
      comment: "Total budget variance (positive = under budget, negative = over budget) for financial control"
    - name: "total_encumbrance"
      expr: SUM(CAST(current_encumbrance AS DOUBLE))
      comment: "Total current encumbrance for cash flow planning"
    - name: "avg_budget_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(budget_variance AS DOUBLE)) / NULLIF(SUM(CAST(total_authorized_budget AS DOUBLE)), 0), 2)
      comment: "Average budget variance as percentage of authorized budget for cost control assessment"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditures_to_date AS DOUBLE)) / NULLIF(SUM(CAST(total_authorized_budget AS DOUBLE)), 0), 2)
      comment: "Budget utilization rate (expenditures as % of authorized budget) for spend velocity tracking"
    - name: "avg_schedule_variance_days"
      expr: AVG(CAST(schedule_variance_days AS DOUBLE))
      comment: "Average schedule variance in days for on-time delivery assessment"
    - name: "total_gross_square_footage_delivered"
      expr: SUM(CAST(gross_square_footage AS DOUBLE))
      comment: "Total gross square footage delivered by projects for space capacity planning"
    - name: "cost_per_gross_square_foot"
      expr: ROUND(SUM(CAST(actual_expenditures_to_date AS DOUBLE)) / NULLIF(SUM(CAST(gross_square_footage AS DOUBLE)), 0), 2)
      comment: "Cost per gross square foot for construction cost benchmarking"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order operational performance metrics for maintenance efficiency, cost control, and service quality decisions"
  source: "`education_ecm`.`facility`.`work_order`"
  dimensions:
    - name: "work_order_number"
      expr: work_order_number
      comment: "Unique work order identifier"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Work order classification (corrective, preventive, emergency, project, etc.)"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current work order status (open, in progress, completed, closed, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Work order priority level for resource allocation"
    - name: "trade_category"
      expr: trade_category
      comment: "Trade skill category (electrical, plumbing, HVAC, etc.)"
    - name: "building_id"
      expr: building_id
      comment: "Building location identifier"
    - name: "crew_id"
      expr: crew_id
      comment: "Assigned crew identifier"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of work order request for trend analysis"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month of work order completion for productivity tracking"
    - name: "ada_compliance_flag"
      expr: ada_compliance_flag
      comment: "ADA compliance related work order flag"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Safety incident related work order flag"
  measures:
    - name: "total_work_orders"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Total count of work orders for workload tracking"
    - name: "total_work_order_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total work order cost for maintenance budget tracking"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for workforce cost analysis"
    - name: "total_materials_cost"
      expr: SUM(CAST(materials_cost AS DOUBLE))
      comment: "Total materials cost for supply chain management"
    - name: "total_contractor_cost"
      expr: SUM(CAST(contractor_cost AS DOUBLE))
      comment: "Total contractor cost for outsourcing analysis"
    - name: "total_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours for workforce capacity planning"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours for service disruption impact assessment"
    - name: "avg_labor_hours_per_wo"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average labor hours per work order for productivity benchmarking"
    - name: "avg_cost_per_work_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per work order for cost efficiency tracking"
    - name: "labor_cost_percentage"
      expr: ROUND(100.0 * SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Labor cost as percentage of total work order cost for cost structure analysis"
    - name: "contractor_cost_percentage"
      expr: ROUND(100.0 * SUM(CAST(contractor_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Contractor cost as percentage of total work order cost for insourcing vs outsourcing decisions"
    - name: "avg_labor_rate"
      expr: ROUND(SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_labor_hours AS DOUBLE)), 0), 2)
      comment: "Average labor rate per hour for workforce cost benchmarking"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_space_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space assignment and utilization metrics for academic space planning, cost allocation, and compliance reporting decisions"
  source: "`education_ecm`.`facility`.`space_assignment`"
  dimensions:
    - name: "assignment_type"
      expr: assignment_type
      comment: "Space assignment classification (research, instruction, office, etc.)"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status (active, pending, expired, etc.)"
    - name: "purpose_code"
      expr: purpose_code
      comment: "Space purpose code for functional classification"
    - name: "ficm_room_use_code"
      expr: ficm_room_use_code
      comment: "FICM (Facilities Inventory and Classification Manual) room use code for federal reporting"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier for departmental analysis"
    - name: "room_id"
      expr: room_id
      comment: "Room identifier"
    - name: "academic_program_id"
      expr: academic_program_id
      comment: "Academic program identifier for program-level space analysis"
    - name: "assignment_fiscal_year"
      expr: YEAR(assignment_start_date)
      comment: "Fiscal year of assignment start for trend analysis"
    - name: "ipeds_reportable_flag"
      expr: ipeds_reportable_flag
      comment: "IPEDS reportable space flag for federal compliance"
    - name: "accreditation_reportable_flag"
      expr: accreditation_reportable_flag
      comment: "Accreditation reportable space flag for accreditation compliance"
  measures:
    - name: "total_space_assignments"
      expr: COUNT(DISTINCT space_assignment_id)
      comment: "Total count of space assignments for allocation tracking"
    - name: "total_assigned_square_footage"
      expr: SUM(CAST(assigned_square_footage AS DOUBLE))
      comment: "Total assigned square footage for space utilization analysis"
    - name: "total_annual_chargeback_amount"
      expr: SUM(CAST(annual_chargeback_amount AS DOUBLE))
      comment: "Total annual chargeback amount for cost recovery tracking"
    - name: "avg_chargeback_rate"
      expr: AVG(CAST(chargeback_rate AS DOUBLE))
      comment: "Average chargeback rate per square foot for rate benchmarking"
    - name: "avg_occupancy_percentage"
      expr: AVG(CAST(occupancy_percentage AS DOUBLE))
      comment: "Average occupancy percentage for space efficiency assessment"
    - name: "avg_assigned_square_footage"
      expr: AVG(CAST(assigned_square_footage AS DOUBLE))
      comment: "Average assigned square footage per assignment for space allocation patterns"
    - name: "chargeback_per_square_foot"
      expr: ROUND(SUM(CAST(annual_chargeback_amount AS DOUBLE)) / NULLIF(SUM(CAST(assigned_square_footage AS DOUBLE)), 0), 2)
      comment: "Chargeback amount per square foot for cost allocation analysis"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room inventory and utilization metrics for space planning, scheduling optimization, and accessibility compliance decisions"
  source: "`education_ecm`.`facility`.`room`"
  dimensions:
    - name: "room_number"
      expr: room_number
      comment: "Room number identifier"
    - name: "room_name"
      expr: room_name
      comment: "Room name for reporting"
    - name: "room_type"
      expr: room_type
      comment: "Room classification (classroom, lab, office, etc.)"
    - name: "subtype"
      expr: subtype
      comment: "Room subtype for detailed classification"
    - name: "use_code"
      expr: use_code
      comment: "Room use code for functional classification"
    - name: "building_id"
      expr: building_id
      comment: "Building location identifier"
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level location"
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Current occupancy status (occupied, vacant, etc.)"
    - name: "condition"
      expr: condition
      comment: "Room condition rating"
    - name: "ada_accessible_flag"
      expr: ada_accessible_flag
      comment: "ADA accessibility compliance flag"
    - name: "scheduling_eligible_flag"
      expr: scheduling_eligible_flag
      comment: "Scheduling system eligibility flag"
    - name: "smart_classroom_flag"
      expr: smart_classroom_flag
      comment: "Smart classroom technology flag"
    - name: "hazardous_materials_flag"
      expr: hazardous_materials_flag
      comment: "Hazardous materials present flag"
  measures:
    - name: "total_rooms"
      expr: COUNT(DISTINCT room_id)
      comment: "Total count of rooms for inventory tracking"
    - name: "total_gross_square_feet"
      expr: SUM(CAST(gross_square_feet AS DOUBLE))
      comment: "Total gross square footage for space inventory"
    - name: "total_net_assignable_square_feet"
      expr: SUM(CAST(net_assignable_square_feet AS DOUBLE))
      comment: "Total net assignable square footage for utilization planning"
    - name: "total_design_capacity"
      expr: SUM(CAST(design_capacity AS DOUBLE))
      comment: "Total design capacity (seats/stations) for capacity planning"
    - name: "avg_gross_square_feet"
      expr: AVG(CAST(gross_square_feet AS DOUBLE))
      comment: "Average gross square footage per room for space standards analysis"
    - name: "avg_net_assignable_square_feet"
      expr: AVG(CAST(net_assignable_square_feet AS DOUBLE))
      comment: "Average net assignable square footage per room for space efficiency"
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height for space quality assessment"
    - name: "net_to_gross_ratio"
      expr: ROUND(SUM(CAST(net_assignable_square_feet AS DOUBLE)) / NULLIF(SUM(CAST(gross_square_feet AS DOUBLE)), 0), 3)
      comment: "Net to gross square footage ratio for space efficiency benchmarking"
    - name: "avg_design_capacity_per_room"
      expr: AVG(CAST(design_capacity AS DOUBLE))
      comment: "Average design capacity per room for capacity standards"
    - name: "square_feet_per_station"
      expr: ROUND(SUM(CAST(net_assignable_square_feet AS DOUBLE)) / NULLIF(SUM(CAST(design_capacity AS DOUBLE)), 0), 2)
      comment: "Net assignable square feet per station for space utilization standards"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_space_utilization_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space utilization survey metrics for federal F&A cost rate determination, indirect cost recovery, and research space compliance decisions"
  source: "`education_ecm`.`facility`.`space_utilization_survey`"
  dimensions:
    - name: "survey_number"
      expr: survey_number
      comment: "Unique survey identifier"
    - name: "survey_status"
      expr: survey_status
      comment: "Survey status (draft, submitted, approved, etc.)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of survey for compliance period tracking"
    - name: "academic_term"
      expr: academic_term
      comment: "Academic term of survey"
    - name: "survey_methodology"
      expr: survey_methodology
      comment: "Survey methodology (observation, interview, etc.)"
    - name: "room_use_classification"
      expr: room_use_classification
      comment: "Room use classification for federal reporting"
    - name: "building_id"
      expr: building_id
      comment: "Building identifier"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier"
    - name: "survey_period_id"
      expr: survey_period_id
      comment: "Survey period identifier"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Exception flag for non-standard surveys"
  measures:
    - name: "total_surveys"
      expr: COUNT(DISTINCT space_utilization_survey_id)
      comment: "Total count of space utilization surveys for compliance tracking"
    - name: "total_square_footage_surveyed"
      expr: SUM(CAST(square_footage_surveyed AS DOUBLE))
      comment: "Total square footage surveyed for coverage assessment"
    - name: "avg_instruction_percentage"
      expr: AVG(CAST(instruction_percentage AS DOUBLE))
      comment: "Average instruction percentage for academic space allocation"
    - name: "avg_organized_research_percentage"
      expr: AVG(CAST(organized_research_percentage AS DOUBLE))
      comment: "Average organized research percentage for F&A cost rate calculation"
    - name: "avg_other_sponsored_activities_percentage"
      expr: AVG(CAST(other_sponsored_activities_percentage AS DOUBLE))
      comment: "Average other sponsored activities percentage for cost allocation"
    - name: "avg_other_institutional_activities_percentage"
      expr: AVG(CAST(other_institutional_activities_percentage AS DOUBLE))
      comment: "Average other institutional activities percentage for cost allocation"
    - name: "avg_vacant_percentage"
      expr: AVG(CAST(vacant_percentage AS DOUBLE))
      comment: "Average vacant percentage for space efficiency assessment"
    - name: "avg_unallowable_activities_percentage"
      expr: AVG(CAST(unallowable_activities_percentage AS DOUBLE))
      comment: "Average unallowable activities percentage for compliance monitoring"
    - name: "research_space_square_footage"
      expr: SUM(CAST(square_footage_surveyed AS DOUBLE) * CAST(organized_research_percentage AS DOUBLE) / 100.0)
      comment: "Total research space square footage for F&A cost base calculation"
    - name: "instruction_space_square_footage"
      expr: SUM(CAST(square_footage_surveyed AS DOUBLE) * CAST(instruction_percentage AS DOUBLE) / 100.0)
      comment: "Total instruction space square footage for academic space planning"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_lease_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease portfolio financial metrics for lease liability management, cash flow planning, and real estate strategy decisions"
  source: "`education_ecm`.`facility`.`lease_agreement`"
  dimensions:
    - name: "lease_number"
      expr: lease_number
      comment: "Unique lease agreement identifier"
    - name: "lease_type"
      expr: lease_type
      comment: "Lease classification (operating, finance, etc.)"
    - name: "lease_status"
      expr: lease_status
      comment: "Current lease status (active, expired, terminated, etc.)"
    - name: "lessor_lessee_indicator"
      expr: lessor_lessee_indicator
      comment: "Lessor or lessee indicator (institution as lessor vs lessee)"
    - name: "counterparty_name"
      expr: counterparty_name
      comment: "Counterparty name for vendor/tenant analysis"
    - name: "space_use_category"
      expr: space_use_category
      comment: "Space use category for functional analysis"
    - name: "property_city"
      expr: property_city
      comment: "Property city location"
    - name: "property_state_province"
      expr: property_state_province
      comment: "Property state/province location"
    - name: "escalation_type"
      expr: escalation_type
      comment: "Rent escalation type (fixed, CPI, etc.)"
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Lease commencement year for cohort analysis"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Lease expiration year for renewal planning"
  measures:
    - name: "total_leases"
      expr: COUNT(DISTINCT lease_agreement_id)
      comment: "Total count of lease agreements for portfolio tracking"
    - name: "total_annual_base_rent"
      expr: SUM(CAST(annual_base_rent AS DOUBLE))
      comment: "Total annual base rent for cash flow planning"
    - name: "total_lease_liability_value"
      expr: SUM(CAST(lease_liability_value AS DOUBLE))
      comment: "Total lease liability value for balance sheet reporting (GASB 87 / ASC 842)"
    - name: "total_right_of_use_asset_value"
      expr: SUM(CAST(right_of_use_asset_value AS DOUBLE))
      comment: "Total right-of-use asset value for balance sheet reporting"
    - name: "total_leased_square_footage"
      expr: SUM(CAST(leased_square_footage AS DOUBLE))
      comment: "Total leased square footage for space portfolio analysis"
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposit amount for cash management"
    - name: "avg_annual_rent_per_lease"
      expr: AVG(CAST(annual_base_rent AS DOUBLE))
      comment: "Average annual rent per lease for cost benchmarking"
    - name: "avg_lease_term_months"
      expr: AVG(CAST(lease_term_months AS DOUBLE))
      comment: "Average lease term in months for portfolio term structure analysis"
    - name: "avg_escalation_rate"
      expr: AVG(CAST(escalation_rate_percent AS DOUBLE))
      comment: "Average escalation rate percentage for future cost projection"
    - name: "rent_per_square_foot"
      expr: ROUND(SUM(CAST(annual_base_rent AS DOUBLE)) / NULLIF(SUM(CAST(leased_square_footage AS DOUBLE)), 0), 2)
      comment: "Annual rent per square foot for market rate benchmarking"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset portfolio financial and lifecycle metrics for capital asset management, depreciation planning, and replacement budgeting decisions"
  source: "`education_ecm`.`facility`.`asset`"
  dimensions:
    - name: "asset_name"
      expr: asset_name
      comment: "Asset name for identification"
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category classification (equipment, furniture, systems, etc.)"
    - name: "subcategory"
      expr: subcategory
      comment: "Asset subcategory for detailed classification"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Asset lifecycle status (active, retired, disposed, etc.)"
    - name: "condition_rating"
      expr: condition_rating
      comment: "Asset condition rating for maintenance prioritization"
    - name: "criticality_level"
      expr: criticality_level
      comment: "Asset criticality level for risk assessment"
    - name: "building_id"
      expr: building_id
      comment: "Building location identifier"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Asset manufacturer for vendor analysis"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Acquisition year for age cohort analysis"
    - name: "energy_star_certified"
      expr: energy_star_certified
      comment: "Energy Star certification flag for sustainability tracking"
    - name: "ada_compliant"
      expr: ada_compliant
      comment: "ADA compliance flag"
  measures:
    - name: "total_assets"
      expr: COUNT(DISTINCT asset_id)
      comment: "Total count of assets for inventory tracking"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost for capital investment tracking"
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total replacement cost for capital planning and insurance valuation"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset for cost benchmarking"
    - name: "avg_replacement_cost"
      expr: AVG(CAST(replacement_cost AS DOUBLE))
      comment: "Average replacement cost per asset for budgeting"
    - name: "replacement_to_acquisition_ratio"
      expr: ROUND(SUM(CAST(replacement_cost AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Replacement to acquisition cost ratio for inflation and technology change assessment"
$$;
