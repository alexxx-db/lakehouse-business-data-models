-- Metric views for domain: research | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_budget_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research budget allocation and utilization metrics tracking funding deployment, spend rates, and compliance obligations for financial control and strategic investment decisions."
  source: "`vibe_semiconductors_v1`.`research`.`budget_allocation`"
  dimensions:
    - name: "allocation_code"
      expr: allocation_code
      comment: "Unique identifier for the budget allocation"
    - name: "allocation_name"
      expr: allocation_name
      comment: "Business name of the budget allocation"
    - name: "allocation_status"
      expr: budget_allocation_status
      comment: "Current status of the allocation"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget allocation"
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source (internal, grant, etc.)"
    - name: "grant_type"
      expr: grant_type
      comment: "Type of government grant (if applicable)"
    - name: "granting_agency_name"
      expr: granting_agency_name
      comment: "Name of granting agency"
    - name: "grant_program_name"
      expr: grant_program_name
      comment: "Name of grant program"
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Indicator whether allocation is subject to CHIPS Act compliance"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicator whether allocation is subject to ITAR controls"
    - name: "strategic_priority_level"
      expr: strategic_priority_level
      comment: "Strategic priority ranking of the allocation"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation"
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Calendar year of allocation"
    - name: "allocation_quarter"
      expr: CONCAT('Q', QUARTER(allocation_date), '-', YEAR(allocation_date))
      comment: "Fiscal quarter of allocation"
  measures:
    - name: "allocation_count"
      expr: COUNT(DISTINCT budget_allocation_id)
      comment: "Total number of distinct budget allocations"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all allocations for investment tracking"
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total budget spent for burn rate analysis and financial control"
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total grant award amounts for external funding tracking"
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average allocation amount for benchmarking"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget consumed for financial control and forecasting"
    - name: "remaining_budget"
      expr: SUM((CAST(allocated_amount AS DOUBLE)) - (CAST(spent_amount AS DOUBLE)))
      comment: "Total remaining budget available for resource planning and reallocation decisions"
    - name: "chips_act_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN chips_act_compliance_flag = TRUE THEN budget_allocation_id END)
      comment: "Count of CHIPS Act allocations for compliance tracking"
    - name: "chips_act_total_allocated"
      expr: SUM(CASE WHEN chips_act_compliance_flag = TRUE THEN CAST(allocated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total CHIPS Act funding allocated for compliance reporting"
    - name: "itar_controlled_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled_flag = TRUE THEN budget_allocation_id END)
      comment: "Count of ITAR-controlled allocations for export control oversight"
    - name: "high_priority_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_priority_level = 'High' THEN budget_allocation_id END)
      comment: "Count of high-priority allocations requiring executive attention"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_characterization_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device characterization and yield learning metrics tracking parametric performance, defect density, and yield detractors for process optimization and technology qualification decisions."
  source: "`vibe_semiconductors_v1`.`research`.`characterization_result`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of characterization measurement performed"
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the measured parameter"
    - name: "measurement_status"
      expr: characterization_result_status
      comment: "Status of the characterization result"
    - name: "device_architecture"
      expr: device_architecture
      comment: "Device architecture type being characterized"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect observed"
    - name: "dominant_yield_detractor"
      expr: dominant_yield_detractor
      comment: "Primary yield-limiting mechanism identified"
    - name: "reliability_stress_type"
      expr: reliability_stress_type
      comment: "Type of reliability stress test applied"
    - name: "measurement_equipment_code"
      expr: measurement_equipment_code
      comment: "Equipment used for measurement"
    - name: "analysis_software"
      expr: analysis_software
      comment: "Software tool used for data analysis"
    - name: "learning_cycle_number"
      expr: learning_cycle_number
      comment: "Learning cycle iteration number for tracking improvement velocity"
    - name: "pdk_calibration_flag"
      expr: pdk_calibration_flag
      comment: "Indicator whether result is used for PDK calibration"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Fiscal year of measurement"
    - name: "measurement_quarter"
      expr: CONCAT('Q', QUARTER(measurement_date), '-', YEAR(measurement_date))
      comment: "Fiscal quarter of measurement"
  measures:
    - name: "result_count"
      expr: COUNT(DISTINCT characterization_result_id)
      comment: "Total number of distinct characterization results"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value for parametric trend analysis"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density for process quality assessment"
    - name: "avg_die_yield_percent"
      expr: AVG(CAST(die_yield_percent AS DOUBLE))
      comment: "Average die yield percentage for process capability evaluation"
    - name: "avg_functional_yield_percent"
      expr: AVG(CAST(functional_yield_percent AS DOUBLE))
      comment: "Average functional yield percentage for product quality assessment"
    - name: "avg_parametric_yield_percent"
      expr: AVG(CAST(parametric_yield_percent AS DOUBLE))
      comment: "Average parametric yield percentage for process window evaluation"
    - name: "avg_yield_improvement_delta"
      expr: AVG(CAST(yield_improvement_delta AS DOUBLE))
      comment: "Average yield improvement delta for learning velocity and process maturation tracking"
    - name: "total_yield_improvement_delta"
      expr: SUM(CAST(yield_improvement_delta AS DOUBLE))
      comment: "Total yield improvement across all results for cumulative learning assessment"
    - name: "in_spec_result_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(measured_value AS DOUBLE) BETWEEN CAST(specification_lower_limit AS DOUBLE) AND CAST(specification_upper_limit AS DOUBLE) THEN characterization_result_id END)
      comment: "Count of results within specification limits for process capability assessment"
    - name: "out_of_spec_result_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(measured_value AS DOUBLE) NOT BETWEEN CAST(specification_lower_limit AS DOUBLE) AND CAST(specification_upper_limit AS DOUBLE) THEN characterization_result_id END)
      comment: "Count of out-of-spec results requiring corrective action and process adjustment"
    - name: "pdk_calibration_result_count"
      expr: COUNT(DISTINCT CASE WHEN pdk_calibration_flag = TRUE THEN characterization_result_id END)
      comment: "Count of results used for PDK calibration for design kit accuracy tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_collaboration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research collaboration KPIs — tracks partnership portfolio, funding contributions, and IP terms used by business development and R&D leadership to manage external research relationships."
  source: "`vibe_semiconductors_v1`.`research`.`collaboration`"
  dimensions:
    - name: "collaboration_status"
      expr: collaboration_status
      comment: "Current status of the collaboration (Active, Completed, Terminated, Negotiating)."
    - name: "collaboration_type"
      expr: collaboration_type
      comment: "Type of collaboration (Joint Development, Sponsored Research, Consortium, Government Program, etc.)."
    - name: "technology_focus_area"
      expr: technology_focus_area
      comment: "Technology focus area of the collaboration."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification — critical for compliance gating of international collaborations."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Indicates whether the collaboration has a renewal option — used for partnership continuity planning."
    - name: "start_date_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year bucket of collaboration start date for partnership trend analysis."
  measures:
    - name: "total_collaborations"
      expr: COUNT(1)
      comment: "Total number of research collaborations — baseline measure of external partnership portfolio size."
    - name: "active_collaboration_count"
      expr: COUNT(CASE WHEN collaboration_status = 'Active' THEN 1 END)
      comment: "Number of currently active collaborations — measures active external R&D partnership engagement."
    - name: "total_funding_contribution_usd"
      expr: SUM(CAST(funding_contribution_amount AS DOUBLE))
      comment: "Total funding contributions from collaboration partners — measures external R&D co-investment received."
    - name: "avg_cost_sharing_pct"
      expr: AVG(CAST(cost_sharing_percentage AS DOUBLE))
      comment: "Average cost sharing percentage across collaborations — measures partner co-investment ratio; drives partnership value assessment."
    - name: "renewal_eligible_count"
      expr: COUNT(CASE WHEN renewal_option_flag = TRUE THEN 1 END)
      comment: "Number of collaborations with renewal options — measures partnership continuity pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_program_partner_collaboration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program-level partner collaboration KPIs — tracks funding contributions, IP sharing terms, and collaboration portfolio health used by business development and program management teams."
  source: "`vibe_semiconductors_v1`.`research`.`collaboration`"
  dimensions:
    - name: "collaboration_status"
      expr: collaboration_status
      comment: "Current status of the program partner collaboration (Active, Completed, Terminated, Negotiating)."
    - name: "start_date_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year bucket of collaboration start date for partnership trend analysis."
  measures:
    - name: "total_program_partner_collaborations"
      expr: COUNT(1)
      comment: "Total number of program partner collaborations — baseline measure of external partnership portfolio."
    - name: "active_collaboration_count"
      expr: COUNT(CASE WHEN collaboration_status = 'Active' THEN 1 END)
      comment: "Number of currently active program partner collaborations — measures active external engagement."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_competitive_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive benchmarking KPIs — tracks PPA gap analysis and transistor density positioning used by technology strategy and product planning teams to assess competitive standing."
  source: "`vibe_semiconductors_v1`.`research`.`competitive_benchmark`"
  dimensions:
    - name: "benchmark_status"
      expr: benchmark_status
      comment: "Current status of the benchmark record (Active, Archived, Under Review)."
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of the competitor being benchmarked against."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers for the benchmark comparison."
    - name: "benchmark_metric"
      expr: benchmark_metric
      comment: "Metric being benchmarked (Performance, Power, Area, Transistor Density, etc.)."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type being compared (FinFET, GAA, Planar, etc.)."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the benchmark data (High, Medium, Low)."
    - name: "benchmark_date_year"
      expr: DATE_TRUNC('year', benchmark_date)
      comment: "Year bucket of benchmark date for competitive trend analysis."
  measures:
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of competitive benchmark records — baseline measure of competitive intelligence coverage."
    - name: "avg_our_value"
      expr: AVG(CAST(our_value AS DOUBLE))
      comment: "Average of our measured metric value across benchmarks — baseline for competitive gap analysis."
    - name: "avg_competitor_value"
      expr: AVG(CAST(competitor_value AS DOUBLE))
      comment: "Average competitor metric value — used to quantify competitive gap."
    - name: "avg_ppa_performance_score"
      expr: AVG(CAST(ppa_performance_score AS DOUBLE))
      comment: "Average PPA performance score — composite metric for technology performance competitiveness."
    - name: "avg_ppa_power_score"
      expr: AVG(CAST(ppa_power_score AS DOUBLE))
      comment: "Average PPA power score — composite metric for power efficiency competitiveness."
    - name: "avg_ppa_area_score"
      expr: AVG(CAST(ppa_area_score AS DOUBLE))
      comment: "Average PPA area score — composite metric for die area competitiveness."
    - name: "avg_transistor_density_mtransistors_per_mm2"
      expr: AVG(CAST(transistor_density_mtransistors_per_mm2 AS DOUBLE))
      comment: "Average transistor density (MTr/mm²) — primary technology scaling benchmark metric used to assess node competitiveness."
    - name: "avg_operating_frequency_ghz"
      expr: AVG(CAST(operating_frequency_ghz AS DOUBLE))
      comment: "Average operating frequency (GHz) — key performance benchmark metric for logic technology competitiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research compliance assessment KPIs — tracks regulatory compliance status, remediation progress, and risk exposure used by compliance officers and R&D leadership to manage regulatory obligations."
  source: "`vibe_semiconductors_v1`.`research`.`compliance_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (Export Control, ITAR, CHIPS Act, Environmental, IP, etc.)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (Compliant, Non-Compliant, Pending, Under Review)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the compliance assessment (Low, Medium, High, Critical)."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework being assessed (EAR, ITAR, REACH, RoHS, CHIPS Act, etc.)."
    - name: "remediation_required"
      expr: remediation_required
      comment: "Indicates whether remediation is required — triggers corrective action planning."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month bucket of assessment date for compliance trend analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments — baseline measure of compliance review activity."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of non-compliant assessments — critical risk indicator; triggers immediate remediation and executive escalation."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Compliance rate (%) — ratio of compliant to total assessments; primary regulatory health metric for R&D operations."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring remediation — measures open compliance risk exposure."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical risk compliance assessments — triggers executive risk review and escalation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_device_architecture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device architecture KPIs — tracks architectural maturity, PPA targets, and IP status used by technology development and product planning teams to manage next-generation device architecture portfolio."
  source: "`vibe_semiconductors_v1`.`research`.`device_architecture`"
  dimensions:
    - name: "architecture_status"
      expr: architecture_status
      comment: "Current status of the device architecture (Concept, Development, Validation, Production, Deprecated)."
    - name: "architecture_type"
      expr: architecture_type
      comment: "Type of device architecture (FinFET, GAA, CFET, Planar, 2D Material, etc.)."
    - name: "device_type"
      expr: device_type
      comment: "Type of device (NMOS, PMOS, CMOS, BiCMOS, etc.)."
    - name: "architecture_maturity_level"
      expr: architecture_maturity_level
      comment: "Maturity level of the architecture (Exploratory, Feasibility, Development, Qualification, Production)."
    - name: "materials_innovation_flag"
      expr: materials_innovation_flag
      comment: "Indicates whether the architecture involves materials innovation — flags high-risk, high-reward architectures."
    - name: "transistor_type"
      expr: transistor_type
      comment: "Transistor type of the architecture (n-type, p-type, complementary, etc.)."
    - name: "concept_date_year"
      expr: DATE_TRUNC('year', concept_date)
      comment: "Year bucket of concept date for architecture pipeline trend analysis."
  measures:
    - name: "total_device_architectures"
      expr: COUNT(1)
      comment: "Total number of device architectures in the research portfolio — baseline measure of architecture pipeline breadth."
    - name: "avg_gate_length_nm"
      expr: AVG(CAST(gate_length_nm AS DOUBLE))
      comment: "Average gate length (nm) across device architectures — primary transistor scaling metric; drives technology node competitiveness assessment."
    - name: "avg_gate_pitch_nm"
      expr: AVG(CAST(gate_pitch_nm AS DOUBLE))
      comment: "Average gate pitch (nm) — key density metric for transistor scaling; drives area improvement targets."
    - name: "avg_fin_width_nm"
      expr: AVG(CAST(fin_width_nm AS DOUBLE))
      comment: "Average fin width (nm) — critical FinFET/GAA geometry parameter affecting drive current and leakage."
    - name: "avg_thermal_performance_target_w_cm2"
      expr: AVG(CAST(thermal_performance_target_w_cm2 AS DOUBLE))
      comment: "Average thermal performance target (W/cm²) — measures thermal management ambition for advanced device architectures."
    - name: "materials_innovation_architecture_count"
      expr: COUNT(CASE WHEN materials_innovation_flag = TRUE THEN 1 END)
      comment: "Number of architectures involving materials innovation — measures high-risk, high-reward R&D pipeline depth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_experimental_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experimental lot execution metrics tracking yield performance, cost efficiency, cycle time, and learning velocity for R&D process optimization and technology maturation decisions."
  source: "`vibe_semiconductors_v1`.`research`.`experimental_lot`"
  dimensions:
    - name: "lot_number"
      expr: lot_number
      comment: "Unique identifier for the experimental lot"
    - name: "lot_status"
      expr: experimental_lot_status
      comment: "Current processing status of the lot"
    - name: "lot_type"
      expr: lot_type
      comment: "Classification of lot type (e.g., DOE, characterization, qualification)"
    - name: "lot_purpose"
      expr: lot_purpose
      comment: "Business purpose or objective of the lot"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority ranking for resource allocation"
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Target process technology node in nanometers"
    - name: "substrate_type"
      expr: substrate_type
      comment: "Wafer substrate material type"
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter in millimeters"
    - name: "target_device_structure"
      expr: target_device_structure
      comment: "Target device architecture or structure"
    - name: "collaboration_partner"
      expr: collaboration_partner
      comment: "External collaboration partner (if any)"
    - name: "fab_line_assignment"
      expr: fab_line_assignment
      comment: "Assigned fabrication line for processing"
    - name: "is_archived"
      expr: is_archived
      comment: "Indicator whether lot is archived"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Fiscal year of actual lot start"
    - name: "actual_start_quarter"
      expr: CONCAT('Q', QUARTER(actual_start_date), '-', YEAR(actual_start_date))
      comment: "Fiscal quarter of actual lot start"
    - name: "completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Fiscal year of lot completion"
  measures:
    - name: "lot_count"
      expr: COUNT(DISTINCT experimental_lot_id)
      comment: "Total number of distinct experimental lots"
    - name: "total_wafer_count"
      expr: SUM(CAST(wafer_count AS DOUBLE))
      comment: "Total wafers processed across all experimental lots for capacity planning"
    - name: "avg_wafer_count_per_lot"
      expr: AVG(CAST(wafer_count AS DOUBLE))
      comment: "Average wafers per lot for resource planning and cost estimation"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost incurred across all lots for budget tracking"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost for budget planning and forecasting"
    - name: "avg_actual_cost_per_lot"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per lot for cost benchmarking"
    - name: "cost_variance_total"
      expr: SUM((CAST(actual_cost_usd AS DOUBLE)) - (CAST(estimated_cost_usd AS DOUBLE)))
      comment: "Total cost variance (actual minus estimated) for financial control and forecasting accuracy"
    - name: "avg_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage for process maturity assessment"
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage for goal setting"
    - name: "yield_achievement_rate"
      expr: ROUND(100.0 * AVG(CAST(actual_yield_percent AS DOUBLE)) / NULLIF(AVG(CAST(target_yield_percent AS DOUBLE)), 0), 2)
      comment: "Percentage of target yield achieved for process capability assessment and learning velocity"
    - name: "total_split_count"
      expr: SUM(CAST(split_count AS DOUBLE))
      comment: "Total number of process splits across lots indicating DOE complexity"
    - name: "avg_split_count_per_lot"
      expr: AVG(CAST(split_count AS DOUBLE))
      comment: "Average splits per lot for experimental design complexity benchmarking"
    - name: "high_priority_lot_count"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'High' THEN experimental_lot_id END)
      comment: "Count of high-priority lots requiring expedited processing and resource allocation"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_government_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Government grant portfolio KPIs — tracks award amounts, matching fund obligations, and CHIPS Act compliance used by finance and R&D leadership for grant management and regulatory reporting."
  source: "`vibe_semiconductors_v1`.`research`.`government_grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status
      comment: "Current status of the government grant (Active, Completed, Pending, Terminated)."
    - name: "grant_type"
      expr: grant_type
      comment: "Type of government grant (Research, Development, Commercialization, CHIPS Act, etc.)."
    - name: "granting_agency_name"
      expr: granting_agency_name
      comment: "Name of the granting agency (DOE, DARPA, NSF, CHIPS Program Office, etc.)."
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Indicates whether the grant is subject to CHIPS Act compliance requirements."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification of the grant — critical for compliance gating."
    - name: "award_date_year"
      expr: DATE_TRUNC('year', award_date)
      comment: "Year bucket of award date for grant portfolio trend analysis."
  measures:
    - name: "total_grants"
      expr: COUNT(1)
      comment: "Total number of government grants — baseline measure of external funding relationships."
    - name: "total_award_amount_usd"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total government grant award amounts — primary external funding inflow metric; drives R&D investment capacity planning."
    - name: "total_matching_fund_amount_usd"
      expr: SUM(CAST(matching_fund_amount AS DOUBLE))
      comment: "Total matching fund obligations — measures company co-investment commitments tied to government grants."
    - name: "total_tax_credit_amount_usd"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credit amounts associated with grants — measures tax benefit realization from R&D investment."
    - name: "chips_act_grant_count"
      expr: COUNT(CASE WHEN chips_act_compliance_flag = TRUE THEN 1 END)
      comment: "Number of CHIPS Act grants — critical for regulatory compliance tracking and reporting."
    - name: "chips_act_total_award_usd"
      expr: SUM(CASE WHEN chips_act_compliance_flag = TRUE THEN CAST(award_amount AS DOUBLE) ELSE 0 END)
      comment: "Total CHIPS Act award amounts — measures government funding received under the CHIPS Act; key metric for CHIPS Act compliance reporting."
    - name: "avg_award_amount_usd"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average grant award amount — used to benchmark grant size and identify outliers."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_invention_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invention disclosure pipeline KPIs — tracks innovation intake, IP counsel decisions, and filing recommendations used by IP management and R&D leadership."
  source: "`vibe_semiconductors_v1`.`research`.`invention_disclosure`"
  dimensions:
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Current status of the invention disclosure (Submitted, Under Review, Approved, Rejected, Filed, etc.)."
    - name: "technology_domain"
      expr: technology_domain
      comment: "Technology domain of the invention (Transistor, Interconnect, Memory, Packaging, etc.)."
    - name: "review_committee_decision"
      expr: review_committee_decision
      comment: "Decision of the IP review committee (File, Publish, Abandon, Trade Secret, etc.)."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification of the invention — critical for compliance gating."
    - name: "prior_art_search_status"
      expr: prior_art_search_status
      comment: "Status of the prior art search (Pending, Completed, Not Required)."
    - name: "submission_date_year"
      expr: DATE_TRUNC('year', submission_date)
      comment: "Year bucket of submission date for innovation pipeline trend analysis."
  measures:
    - name: "total_disclosures"
      expr: COUNT(1)
      comment: "Total number of invention disclosures — baseline measure of innovation intake volume."
    - name: "patent_filing_recommended_count"
      expr: COUNT(CASE WHEN patent_filing_recommendation = TRUE THEN 1 END)
      comment: "Number of disclosures recommended for patent filing — measures IP pipeline conversion rate."
    - name: "filing_recommendation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patent_filing_recommendation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Patent filing recommendation rate (%) — measures the fraction of disclosures advancing to patent prosecution; indicates innovation quality."
    - name: "prior_art_search_completed_count"
      expr: COUNT(CASE WHEN prior_art_search_status = 'Completed' THEN 1 END)
      comment: "Number of disclosures with completed prior art searches — measures IP due diligence throughput."
    - name: "export_controlled_disclosure_count"
      expr: COUNT(CASE WHEN export_control_classification IS NOT NULL AND export_control_classification != '' THEN 1 END)
      comment: "Number of disclosures with export control classifications — critical for compliance risk management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_ip_core_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core development KPIs — tracks NRE cost, verification coverage, and design maturity used by IP portfolio management and R&D leadership to steer IP investment."
  source: "`vibe_semiconductors_v1`.`research`.`ip_core_development`"
  dimensions:
    - name: "development_status"
      expr: development_status
      comment: "Current development status of the IP core (In Development, Tape-Out, Silicon Validation, Released, etc.)."
    - name: "development_stage"
      expr: development_stage
      comment: "Development stage of the IP core (Concept, RTL, Netlist, Layout, Silicon, etc.)."
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (Hard IP, Soft IP, Firm IP)."
    - name: "ip_category"
      expr: ip_category
      comment: "Category of IP core (Interface, Memory, Processor, Analog, Mixed-Signal, etc.)."
    - name: "target_node"
      expr: target_node
      comment: "Target process node for the IP core."
    - name: "licensing_model"
      expr: licensing_model
      comment: "Licensing model for the IP core (Royalty, Flat Fee, Subscription, etc.)."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL rating of the IP core development."
  measures:
    - name: "total_ip_core_developments"
      expr: COUNT(1)
      comment: "Total number of IP core development projects — baseline measure of IP portfolio pipeline."
    - name: "total_actual_nre_cost_usd"
      expr: SUM(CAST(actual_nre_cost_usd AS DOUBLE))
      comment: "Total actual NRE cost across IP core developments — primary IP investment spend metric."
    - name: "total_estimated_nre_cost_usd"
      expr: SUM(CAST(estimated_nre_cost_usd AS DOUBLE))
      comment: "Total estimated NRE cost — measures planned IP investment."
    - name: "nre_cost_variance_usd"
      expr: SUM(CAST(actual_nre_cost_usd AS DOUBLE) - CAST(estimated_nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost variance (actual minus estimated) — positive variance triggers cost overrun review."
    - name: "avg_verification_coverage_pct"
      expr: AVG(CAST(verification_coverage_percentage AS DOUBLE))
      comment: "Average verification coverage percentage — measures design quality and readiness for silicon; low coverage increases tape-out risk."
    - name: "avg_rtl_completion_pct"
      expr: AVG(CAST(rtl_completion_percentage AS DOUBLE))
      comment: "Average RTL completion percentage — measures design progress across the IP portfolio."
    - name: "avg_reuse_pct"
      expr: AVG(CAST(reuse_percentage AS DOUBLE))
      comment: "Average IP reuse percentage — measures design efficiency; high reuse reduces NRE cost and time-to-market."
    - name: "avg_target_ppa_performance_mhz"
      expr: AVG(CAST(target_ppa_performance_mhz AS DOUBLE))
      comment: "Average target PPA performance (MHz) — measures performance ambition of the IP portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_materials_research`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Materials research KPIs — tracks material property performance, compliance status, and research maturity used by materials scientists and process engineers to guide next-generation material adoption."
  source: "`vibe_semiconductors_v1`.`research`.`materials_research`"
  dimensions:
    - name: "research_status"
      expr: research_status
      comment: "Current status of the materials research (Active, Completed, On-Hold, Abandoned)."
    - name: "material_category"
      expr: material_category
      comment: "Category of material being researched (Dielectric, Metal, Semiconductor, 2D Material, etc.)."
    - name: "material_class"
      expr: material_class
      comment: "Class of material (Conductor, Insulator, Semiconductor, Ferroelectric, etc.)."
    - name: "research_maturity_stage"
      expr: research_maturity_stage
      comment: "Maturity stage of the materials research (Exploratory, Feasibility, Development, Qualification)."
    - name: "reach_compliance_status"
      expr: reach_compliance_status
      comment: "REACH compliance status of the material — critical for regulatory and supply chain risk management."
    - name: "rohs_compliance_status"
      expr: rohs_compliance_status
      comment: "RoHS compliance status of the material — critical for product compliance and market access."
    - name: "technology_node_target"
      expr: technology_node_target
      comment: "Target technology node for the material application."
  measures:
    - name: "total_materials_research_records"
      expr: COUNT(1)
      comment: "Total number of materials research records — baseline measure of materials R&D portfolio breadth."
    - name: "avg_electron_mobility_cm2_vs"
      expr: AVG(CAST(electron_mobility_cm2_vs AS DOUBLE))
      comment: "Average electron mobility (cm²/V·s) — primary performance metric for semiconductor channel materials; higher mobility enables faster transistors."
    - name: "avg_dielectric_constant"
      expr: AVG(CAST(dielectric_constant AS DOUBLE))
      comment: "Average dielectric constant — key parameter for gate dielectric and interconnect materials selection."
    - name: "avg_thermal_conductivity_w_mk"
      expr: AVG(CAST(thermal_conductivity_w_mk AS DOUBLE))
      comment: "Average thermal conductivity (W/m·K) — critical for thermal management material selection in advanced packaging."
    - name: "avg_material_cost_per_gram_usd"
      expr: AVG(CAST(material_cost_per_gram_usd AS DOUBLE))
      comment: "Average material cost per gram (USD) — used to assess cost-of-ownership implications of new materials."
    - name: "reach_compliant_material_count"
      expr: COUNT(CASE WHEN reach_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of materials with REACH compliance — measures regulatory-safe material portfolio breadth."
    - name: "avg_film_thickness_nm"
      expr: AVG(CAST(film_thickness_nm AS DOUBLE))
      comment: "Average film thickness (nm) — key process control parameter for thin film materials in advanced nodes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_packaging_research`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced packaging research KPIs — tracks NRE investment, interconnect density targets, and thermal performance goals used by packaging R&D and advanced packaging strategy teams."
  source: "`vibe_semiconductors_v1`.`research`.`packaging_research`"
  dimensions:
    - name: "research_status"
      expr: research_status
      comment: "Current status of the packaging research (Active, Completed, On-Hold, Abandoned)."
    - name: "packaging_technology_type"
      expr: packaging_technology_type
      comment: "Type of packaging technology being researched (2.5D, 3D-IC, Fan-Out, Chiplet, etc.)."
    - name: "development_maturity_stage"
      expr: development_maturity_stage
      comment: "Maturity stage of the packaging research (Exploratory, Feasibility, Development, Qualification)."
    - name: "reliability_qualification_status"
      expr: reliability_qualification_status
      comment: "Reliability qualification status of the packaging technology."
    - name: "chips_act_program_flag"
      expr: chips_act_program_flag
      comment: "Indicates whether the packaging research is funded under the CHIPS Act."
    - name: "strategic_priority_level"
      expr: strategic_priority_level
      comment: "Strategic priority level of the packaging research."
  measures:
    - name: "total_packaging_research_records"
      expr: COUNT(1)
      comment: "Total number of packaging research records — baseline measure of advanced packaging R&D portfolio."
    - name: "total_nre_budget_allocated_usd"
      expr: SUM(CAST(nre_budget_allocated AS DOUBLE))
      comment: "Total NRE budget allocated for packaging research — primary advanced packaging investment metric."
    - name: "total_nre_budget_spent_usd"
      expr: SUM(CAST(nre_budget_spent AS DOUBLE))
      comment: "Total NRE budget spent on packaging research — measures actual advanced packaging expenditure."
    - name: "nre_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(nre_budget_spent AS DOUBLE)) / NULLIF(SUM(CAST(nre_budget_allocated AS DOUBLE)), 0), 2)
      comment: "NRE budget utilization rate (%) for packaging research — drives budget reallocation decisions."
    - name: "avg_interconnect_density_target"
      expr: AVG(CAST(interconnect_density_target AS DOUBLE))
      comment: "Average interconnect density target — measures ambition level of advanced packaging interconnect scaling."
    - name: "avg_yield_target_pct"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average yield target percentage for packaging research — measures yield ambition for advanced packaging processes."
    - name: "avg_thermal_performance_target_w_per_cm2"
      expr: AVG(CAST(thermal_performance_target_w_per_cm2 AS DOUBLE))
      comment: "Average thermal performance target (W/cm²) — measures thermal management ambition for advanced packaging; critical for high-power AI/HPC applications."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_patent_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intellectual property portfolio metrics tracking patent filing velocity, prosecution progress, grant rates, and strategic value for innovation output assessment and IP portfolio management decisions."
  source: "`vibe_semiconductors_v1`.`research`.`patent_filing`"
  dimensions:
    - name: "patent_number"
      expr: patent_number
      comment: "Granted patent number"
    - name: "application_number"
      expr: application_number
      comment: "Patent application number"
    - name: "patent_status"
      expr: patent_filing_status
      comment: "Current status of the patent filing"
    - name: "patent_type"
      expr: patent_type
      comment: "Type of patent (utility, design, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Filing jurisdiction or country"
    - name: "prosecution_stage"
      expr: prosecution_stage
      comment: "Current stage in patent prosecution process"
    - name: "technology_domain"
      expr: technology_domain
      comment: "Technology domain or technical area"
    - name: "ipc_classification"
      expr: ipc_classification
      comment: "International Patent Classification code"
    - name: "cpc_classification"
      expr: cpc_classification
      comment: "Cooperative Patent Classification code"
    - name: "novelty_assessment"
      expr: novelty_assessment
      comment: "Assessment of invention novelty"
    - name: "protection_strategy"
      expr: protection_strategy
      comment: "IP protection strategy classification"
    - name: "chips_act_reportable"
      expr: chips_act_reportable
      comment: "Indicator whether filing is reportable under CHIPS Act"
    - name: "prior_art_search_completed"
      expr: prior_art_search_completed
      comment: "Indicator whether prior art search is completed"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Fiscal year of patent filing"
    - name: "filing_quarter"
      expr: CONCAT('Q', QUARTER(filing_date), '-', YEAR(filing_date))
      comment: "Fiscal quarter of patent filing"
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Fiscal year of patent grant"
  measures:
    - name: "filing_count"
      expr: COUNT(DISTINCT patent_filing_id)
      comment: "Total number of distinct patent filings for innovation output tracking"
    - name: "granted_patent_count"
      expr: COUNT(DISTINCT CASE WHEN grant_date IS NOT NULL THEN patent_filing_id END)
      comment: "Count of granted patents for IP portfolio strength assessment"
    - name: "pending_patent_count"
      expr: COUNT(DISTINCT CASE WHEN grant_date IS NULL AND abandonment_date IS NULL THEN patent_filing_id END)
      comment: "Count of pending patents for prosecution workload and portfolio pipeline tracking"
    - name: "abandoned_patent_count"
      expr: COUNT(DISTINCT CASE WHEN abandonment_date IS NOT NULL THEN patent_filing_id END)
      comment: "Count of abandoned patents for portfolio efficiency analysis"
    - name: "patent_grant_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN grant_date IS NOT NULL THEN patent_filing_id END) / NULLIF(COUNT(DISTINCT patent_filing_id), 0), 2)
      comment: "Percentage of filings that resulted in granted patents for prosecution effectiveness assessment"
    - name: "total_estimated_filing_cost"
      expr: SUM(CAST(estimated_filing_cost AS DOUBLE))
      comment: "Total estimated filing costs for budget planning"
    - name: "total_actual_filing_cost"
      expr: SUM(CAST(actual_filing_cost AS DOUBLE))
      comment: "Total actual filing costs for budget tracking and cost control"
    - name: "avg_actual_filing_cost"
      expr: AVG(CAST(actual_filing_cost AS DOUBLE))
      comment: "Average actual cost per filing for cost benchmarking"
    - name: "avg_business_value_score"
      expr: AVG(CAST(business_value_score AS DOUBLE))
      comment: "Average business value score for portfolio quality assessment"
    - name: "avg_strategic_value"
      expr: AVG(CAST(strategic_value AS DOUBLE))
      comment: "Average strategic value for portfolio prioritization and resource allocation"
    - name: "avg_office_action_count"
      expr: AVG(CAST(office_action_count AS DOUBLE))
      comment: "Average office actions per filing for prosecution complexity assessment"
    - name: "avg_inventor_count"
      expr: AVG(CAST(inventor_count AS DOUBLE))
      comment: "Average inventors per filing for collaboration intensity tracking"
    - name: "chips_act_reportable_count"
      expr: COUNT(DISTINCT CASE WHEN chips_act_reportable = TRUE THEN patent_filing_id END)
      comment: "Count of CHIPS Act reportable filings for compliance tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_pdk_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PDK development KPIs — tracks validation progress, feature completeness, and release readiness used by EDA and process technology teams to manage PDK delivery to design teams."
  source: "`vibe_semiconductors_v1`.`research`.`pdk_development`"
  dimensions:
    - name: "development_status"
      expr: development_status
      comment: "Current development status of the PDK (In Development, Validation, Released, Deprecated)."
    - name: "development_stage"
      expr: development_stage
      comment: "Development stage of the PDK (Alpha, Beta, Production, etc.)."
    - name: "process_type"
      expr: process_type
      comment: "Process type the PDK supports (Logic, Analog, RF, Mixed-Signal, etc.)."
    - name: "release_type"
      expr: release_type
      comment: "Type of PDK release (Major, Minor, Patch, Hotfix)."
    - name: "is_customer_accessible"
      expr: is_customer_accessible
      comment: "Indicates whether the PDK is accessible to external design customers."
    - name: "supports_euv_lithography"
      expr: supports_euv_lithography
      comment: "Indicates whether the PDK supports EUV lithography — critical for advanced node design enablement."
    - name: "release_date_year"
      expr: DATE_TRUNC('year', release_date)
      comment: "Year bucket of PDK release date for release cadence analysis."
  measures:
    - name: "total_pdk_versions"
      expr: COUNT(1)
      comment: "Total number of PDK versions — baseline measure of PDK portfolio breadth."
    - name: "avg_validation_completion_pct"
      expr: AVG(CAST(validation_completion_percentage AS DOUBLE))
      comment: "Average PDK validation completion percentage — measures readiness for design team release; low values indicate delivery risk."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size (nm) across PDK versions — tracks technology node advancement in the PDK portfolio."
    - name: "customer_accessible_pdk_count"
      expr: COUNT(CASE WHEN is_customer_accessible = TRUE THEN 1 END)
      comment: "Number of PDK versions accessible to design customers — measures design enablement breadth."
    - name: "euv_capable_pdk_count"
      expr: COUNT(CASE WHEN supports_euv_lithography = TRUE THEN 1 END)
      comment: "Number of PDK versions supporting EUV lithography — measures advanced node design enablement capability."
    - name: "released_pdk_count"
      expr: COUNT(CASE WHEN development_status = 'Released' THEN 1 END)
      comment: "Number of released PDK versions — measures production-ready PDK availability for design teams."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_process_flow_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow experiment KPIs — tracks yield performance, cycle time efficiency, and DOE execution used by process engineers to optimize fabrication flows for new technology nodes."
  source: "`vibe_semiconductors_v1`.`research`.`process_flow_experiment`"
  dimensions:
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the process flow experiment (Active, Completed, Failed, On-Hold)."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow (Baseline, Split, DOE, Variant, etc.)."
    - name: "doe_design_type"
      expr: doe_design_type
      comment: "Design of experiment type (Full Factorial, Fractional, RSM, Taguchi, etc.)."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node targeted by the process flow experiment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the process flow experiment."
    - name: "doe_split_flag"
      expr: doe_split_flag
      comment: "Indicates whether the experiment uses a DOE split design."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the process flow experiment."
  measures:
    - name: "total_process_flow_experiments"
      expr: COUNT(1)
      comment: "Total number of process flow experiments — baseline measure of process development activity."
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across process flow experiments — primary indicator of process flow effectiveness."
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage — baseline for yield gap analysis."
    - name: "yield_attainment_pct"
      expr: ROUND(100.0 * AVG(CAST(actual_yield_percent AS DOUBLE)) / NULLIF(AVG(CAST(expected_yield_percent AS DOUBLE)), 0), 2)
      comment: "Yield attainment rate (%) — ratio of actual to expected yield; measures how well process flow experiments meet yield objectives."
    - name: "avg_actual_cycle_time_minutes"
      expr: AVG(CAST(actual_cycle_time_minutes AS DOUBLE))
      comment: "Average actual cycle time (minutes) — measures process flow execution efficiency."
    - name: "avg_target_cycle_time_minutes"
      expr: AVG(CAST(target_cycle_time_minutes AS DOUBLE))
      comment: "Average target cycle time (minutes) — baseline for cycle time gap analysis."
    - name: "cycle_time_efficiency_pct"
      expr: ROUND(100.0 * AVG(CAST(target_cycle_time_minutes AS DOUBLE)) / NULLIF(AVG(CAST(actual_cycle_time_minutes AS DOUBLE)), 0), 2)
      comment: "Cycle time efficiency (%) — ratio of target to actual cycle time; values below 100% indicate cycle time overruns requiring process optimization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_process_integration_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process integration run KPIs — tracks electrical performance, yield, and TCAD correlation for R&D process development runs used by process integration engineers and technology development leadership."
  source: "`vibe_semiconductors_v1`.`research`.`process_integration_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the process integration run (Active, Completed, Failed, On-Hold)."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type targeted by the run (FinFET, GAA, Planar, etc.)."
    - name: "doe_design_type"
      expr: doe_design_type
      comment: "Design of experiment type used in the run (Full Factorial, Fractional, RSM, etc.)."
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Overall pass/fail determination for the integration run."
    - name: "learning_cycle_number"
      expr: learning_cycle_number
      comment: "Learning cycle number — tracks iterative improvement cycles in process development."
    - name: "run_date_month"
      expr: DATE_TRUNC('month', run_date)
      comment: "Month bucket of run date for throughput and trend analysis."
  measures:
    - name: "total_integration_runs"
      expr: COUNT(1)
      comment: "Total number of process integration runs — baseline measure of process development activity."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across integration runs — primary indicator of process integration effectiveness."
    - name: "avg_threshold_voltage_mv"
      expr: AVG(CAST(threshold_voltage_mv AS DOUBLE))
      comment: "Average threshold voltage (mV) across runs — key electrical parameter for transistor performance benchmarking."
    - name: "avg_drive_current_ua"
      expr: AVG(CAST(drive_current_ua AS DOUBLE))
      comment: "Average drive current (µA) across runs — critical transistor performance metric used to assess process competitiveness."
    - name: "avg_leakage_current_na"
      expr: AVG(CAST(leakage_current_na AS DOUBLE))
      comment: "Average leakage current (nA) across runs — low leakage is essential for power-efficient device performance."
    - name: "avg_tcad_correlation_accuracy_pct"
      expr: AVG(CAST(tcad_correlation_accuracy_percentage AS DOUBLE))
      comment: "Average TCAD simulation correlation accuracy (%) — measures how well simulation models predict actual silicon behavior; drives PDK calibration decisions."
    - name: "pass_run_count"
      expr: COUNT(CASE WHEN pass_fail_determination = 'Pass' THEN 1 END)
      comment: "Number of integration runs that passed — measures process integration success rate."
    - name: "pdk_contribution_run_count"
      expr: COUNT(CASE WHEN pdk_contribution_flag = TRUE THEN 1 END)
      comment: "Number of runs contributing data to PDK development — measures R&D-to-PDK pipeline throughput."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_process_split`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process split KPIs — tracks split experiment yield, cost, and cycle time used by process engineers to evaluate process parameter optimization and DOE effectiveness."
  source: "`vibe_semiconductors_v1`.`research`.`process_split`"
  dimensions:
    - name: "split_status"
      expr: split_status
      comment: "Current status of the process split (Active, Completed, Deprecated, On-Hold)."
    - name: "split_method"
      expr: split_method
      comment: "Method used for the process split (Wafer-Level, Lot-Level, Step-Level, etc.)."
    - name: "split_parameter"
      expr: split_parameter
      comment: "Process parameter being split (Temperature, Pressure, Gas Flow, Dose, etc.)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the process split."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the process split is on the critical path — critical splits directly impact program schedule."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the process split."
  measures:
    - name: "total_process_splits"
      expr: COUNT(1)
      comment: "Total number of process splits — baseline measure of DOE and process optimization activity."
    - name: "avg_average_yield_pct"
      expr: AVG(CAST(average_yield_percent AS DOUBLE))
      comment: "Average yield percentage across process splits — primary indicator of process split effectiveness."
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost estimate per process split — used to benchmark DOE investment and prioritize high-value splits."
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total cost estimate across all process splits — measures total DOE investment commitment."
    - name: "avg_total_cycle_time_minutes"
      expr: AVG(CAST(total_cycle_time_minutes AS DOUBLE))
      comment: "Average total cycle time (minutes) per process split — measures process split execution efficiency."
    - name: "critical_split_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical process splits — measures schedule risk exposure from critical-path process experiments."
    - name: "avg_split_ratio"
      expr: AVG(CAST(split_ratio AS DOUBLE))
      comment: "Average split ratio across process splits — measures the balance of experimental conditions in DOE designs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research project execution metrics tracking budget burn, schedule adherence, IP generation, and technology readiness for portfolio management and resource allocation decisions."
  source: "`vibe_semiconductors_v1`.`research`.`project`"
  dimensions:
    - name: "project_code"
      expr: project_code
      comment: "Unique identifier for the research project"
    - name: "project_name"
      expr: project_name
      comment: "Business name of the research project"
    - name: "project_status"
      expr: project_status
      comment: "Current execution status of the project"
    - name: "project_type"
      expr: project_type
      comment: "Classification of project type"
    - name: "phase"
      expr: phase
      comment: "Current development phase of the project"
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL maturity indicator for commercialization readiness"
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk assessment for the project"
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic importance ranking of the project"
    - name: "research_domain"
      expr: research_domain
      comment: "Research domain or technical area"
    - name: "device_architecture_focus"
      expr: device_architecture_focus
      comment: "Target device architecture or technology"
    - name: "technology_node_target"
      expr: technology_node_target
      comment: "Target process technology node"
    - name: "collaboration_type"
      expr: collaboration_type
      comment: "Type of external collaboration (if any)"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicator whether project is subject to ITAR export controls"
    - name: "ip_filing_planned"
      expr: ip_filing_planned
      comment: "Indicator whether IP filing is planned for this project"
    - name: "mpw_shuttle_participation"
      expr: mpw_shuttle_participation
      comment: "Indicator whether project participates in multi-project wafer shuttle"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Fiscal year of planned project start"
    - name: "planned_start_quarter"
      expr: CONCAT('Q', QUARTER(planned_start_date), '-', YEAR(planned_start_date))
      comment: "Fiscal quarter of planned project start"
  measures:
    - name: "project_count"
      expr: COUNT(DISTINCT project_id)
      comment: "Total number of distinct research projects"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all projects for investment tracking"
    - name: "total_nre_budget_allocated"
      expr: SUM(CAST(nre_budget_allocated AS DOUBLE))
      comment: "Total non-recurring engineering budget allocated for cost planning"
    - name: "total_nre_budget_spent"
      expr: SUM(CAST(nre_budget_spent AS DOUBLE))
      comment: "Total NRE budget spent for burn rate analysis and financial control"
    - name: "avg_budget_per_project"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per project for benchmarking and resource planning"
    - name: "nre_budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(nre_budget_spent AS DOUBLE)) / NULLIF(SUM(CAST(nre_budget_allocated AS DOUBLE)), 0), 2)
      comment: "Percentage of NRE budget consumed for financial control and forecasting"
    - name: "total_experimental_lots"
      expr: SUM(CAST(experimental_wafer_lot_count AS DOUBLE))
      comment: "Total experimental wafer lots across projects indicating R&D activity volume"
    - name: "total_ip_filings"
      expr: SUM(CAST(ip_filing_count AS DOUBLE))
      comment: "Total intellectual property filings generated by projects measuring innovation output"
    - name: "avg_ip_filings_per_project"
      expr: AVG(CAST(ip_filing_count AS DOUBLE))
      comment: "Average IP filings per project for innovation productivity benchmarking"
    - name: "high_priority_project_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_priority = 'High' THEN project_id END)
      comment: "Count of high-priority projects requiring executive focus and resource prioritization"
    - name: "itar_controlled_project_count"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled = TRUE THEN project_id END)
      comment: "Count of ITAR-controlled projects for export control compliance"
    - name: "mpw_shuttle_project_count"
      expr: COUNT(DISTINCT CASE WHEN mpw_shuttle_participation = TRUE THEN project_id END)
      comment: "Count of projects using MPW shuttle for cost-effective prototyping"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research publication KPIs — tracks scientific output, open access adoption, and export control compliance used by R&D leadership to measure research impact and manage publication governance."
  source: "`vibe_semiconductors_v1`.`research`.`publication`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Current status of the publication (Draft, Submitted, Under Review, Accepted, Published, Rejected)."
    - name: "publication_type"
      expr: publication_type
      comment: "Type of publication (Journal Article, Conference Paper, Patent, Technical Report, etc.)."
    - name: "venue_type"
      expr: venue_type
      comment: "Type of publication venue (Peer-Reviewed Journal, Conference, Workshop, etc.)."
    - name: "technology_domain"
      expr: technology_domain
      comment: "Technology domain of the publication (Transistor, Interconnect, Memory, Packaging, etc.)."
    - name: "peer_review_status"
      expr: peer_review_status
      comment: "Peer review status of the publication."
    - name: "open_access_flag"
      expr: open_access_flag
      comment: "Indicates whether the publication is open access — measures research dissemination reach."
    - name: "publication_date_year"
      expr: DATE_TRUNC('year', publication_date)
      comment: "Year bucket of publication date for research output trend analysis."
  measures:
    - name: "total_publications"
      expr: COUNT(1)
      comment: "Total number of publications — baseline measure of scientific output volume."
    - name: "published_count"
      expr: COUNT(CASE WHEN publication_status = 'Published' THEN 1 END)
      comment: "Number of published works — measures realized scientific output and research visibility."
    - name: "open_access_count"
      expr: COUNT(CASE WHEN open_access_flag = TRUE THEN 1 END)
      comment: "Number of open access publications — measures research dissemination reach and compliance with open access mandates."
    - name: "export_controlled_publication_count"
      expr: COUNT(CASE WHEN export_control_review_status IS NOT NULL AND export_control_review_status != '' THEN 1 END)
      comment: "Number of publications with export control review — measures compliance governance of research dissemination."
    - name: "itar_controlled_publication_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled publications — critical for export compliance risk management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research milestone execution KPIs — tracks schedule adherence, gate review outcomes, and critical path performance used by program managers and R&D leadership for portfolio governance."
  source: "`vibe_semiconductors_v1`.`research`.`research_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the research milestone (On-Track, At-Risk, Delayed, Completed, Cancelled)."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (Gate Review, Tapeout, Silicon Return, Qualification, Publication, etc.)."
    - name: "gate_review_outcome"
      expr: gate_review_outcome
      comment: "Outcome of the gate review (Approved, Conditional, Rejected, Deferred)."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL level at the milestone — tracks technology maturity progression."
    - name: "chips_act_reportable"
      expr: chips_act_reportable
      comment: "Indicates whether the milestone is reportable under CHIPS Act obligations."
    - name: "critical_path_indicator"
      expr: critical_path_indicator
      comment: "Indicates whether the milestone is on the critical path — critical path delays directly impact program delivery."
    - name: "planned_date_month"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Month bucket of planned milestone date for schedule trend analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of research milestones — baseline measure of program execution granularity."
    - name: "completed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Number of completed milestones — measures program execution progress."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Milestone completion rate (%) — measures overall program execution effectiveness; low rate triggers schedule recovery planning."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN critical_path_indicator = TRUE THEN 1 END)
      comment: "Number of critical path milestones — measures schedule risk exposure."
    - name: "delayed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Delayed' THEN 1 END)
      comment: "Number of delayed milestones — triggers schedule recovery and resource reallocation decisions."
    - name: "ip_filing_triggered_count"
      expr: COUNT(CASE WHEN ip_filing_triggered = TRUE THEN 1 END)
      comment: "Number of milestones that triggered IP filings — measures innovation output linked to program execution."
    - name: "total_budget_impact_usd"
      expr: SUM(CAST(budget_impact_amount AS DOUBLE))
      comment: "Total budget impact of milestone changes — measures financial exposure from schedule and scope changes."
    - name: "chips_act_reportable_milestone_count"
      expr: COUNT(CASE WHEN chips_act_reportable = TRUE THEN 1 END)
      comment: "Number of CHIPS Act reportable milestones — critical for regulatory compliance reporting cadence."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic research program performance metrics tracking budget utilization, project portfolio health, and technology readiness progression for executive steering and resource allocation decisions."
  source: "`vibe_semiconductors_v1`.`research`.`research_program`"
  dimensions:
    - name: "program_code"
      expr: program_code
      comment: "Unique identifier for the research program"
    - name: "program_name"
      expr: program_name
      comment: "Business name of the research program"
    - name: "program_status"
      expr: research_program_status
      comment: "Current lifecycle status of the program"
    - name: "program_type"
      expr: program_type
      comment: "Classification of program type (e.g., process development, device architecture, packaging)"
    - name: "current_phase"
      expr: current_phase
      comment: "Current development phase of the program"
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL maturity indicator for technology commercialization readiness"
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk assessment for the program"
    - name: "chips_act_program_flag"
      expr: chips_act_program_flag
      comment: "Indicator whether program is funded under CHIPS Act"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicator whether program is subject to ITAR export controls"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Fiscal year of planned program start"
    - name: "planned_start_quarter"
      expr: CONCAT('Q', QUARTER(planned_start_date), '-', YEAR(planned_start_date))
      comment: "Fiscal quarter of planned program start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Fiscal year of actual program start"
    - name: "target_application_domain"
      expr: target_application_domain
      comment: "Target market or application segment for the program"
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform or architecture family"
  measures:
    - name: "program_count"
      expr: COUNT(DISTINCT research_program_id)
      comment: "Total number of distinct research programs"
    - name: "total_budget_envelope"
      expr: SUM(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Total allocated budget across all programs for investment planning"
    - name: "avg_budget_per_program"
      expr: AVG(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Average budget allocation per program for benchmarking and resource planning"
    - name: "total_experimental_lots"
      expr: SUM(CAST(experimental_wafer_lot_count AS DOUBLE))
      comment: "Total experimental wafer lots across programs indicating R&D activity volume"
    - name: "total_ip_filings"
      expr: SUM(CAST(ip_filing_count AS DOUBLE))
      comment: "Total intellectual property filings generated by programs measuring innovation output"
    - name: "total_tapeout_milestones"
      expr: SUM(CAST(tapeout_milestone_count AS DOUBLE))
      comment: "Total tapeout milestones achieved across programs tracking silicon validation progress"
    - name: "avg_experimental_lots_per_program"
      expr: AVG(CAST(experimental_wafer_lot_count AS DOUBLE))
      comment: "Average experimental lot count per program for resource intensity benchmarking"
    - name: "chips_act_program_count"
      expr: COUNT(DISTINCT CASE WHEN chips_act_program_flag = TRUE THEN research_program_id END)
      comment: "Count of programs funded under CHIPS Act for compliance reporting"
    - name: "itar_controlled_program_count"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled_flag = TRUE THEN research_program_id END)
      comment: "Count of ITAR-controlled programs for export control oversight"
    - name: "high_risk_program_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'High' THEN research_program_id END)
      comment: "Count of high-risk programs requiring executive attention and mitigation planning"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_technology_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research technology node KPIs — tracks node maturity, transistor density targets, and cost metrics used by technology development leadership to manage the node roadmap portfolio."
  source: "`vibe_semiconductors_v1`.`research`.`research_technology_node`"
  dimensions:
    - name: "node_maturity_status"
      expr: node_maturity_status
      comment: "Maturity status of the research technology node (Exploratory, Development, Qualification, Production)."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture of the node (FinFET, GAA, CFET, Planar, etc.)."
    - name: "lithography_generation"
      expr: lithography_generation
      comment: "Lithography generation used for the node (DUV, EUV, High-NA EUV, etc.)."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL rating of the research technology node."
    - name: "reliability_qualification_status"
      expr: reliability_qualification_status
      comment: "Reliability qualification status of the node."
    - name: "environmental_compliance_status"
      expr: environmental_compliance_status
      comment: "Environmental compliance status of the node."
  measures:
    - name: "total_technology_nodes"
      expr: COUNT(1)
      comment: "Total number of research technology nodes — baseline measure of node portfolio breadth."
    - name: "avg_transistor_density_mtransistors_per_mm2"
      expr: AVG(CAST(transistor_density_mtransistors_per_mm2 AS DOUBLE))
      comment: "Average transistor density (MTr/mm²) — primary technology scaling metric; drives competitive positioning and roadmap investment decisions."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size (nm) — measures technology node advancement across the portfolio."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage — measures yield ambition for research nodes; drives process development investment."
    - name: "avg_cost_per_wafer_usd"
      expr: AVG(CAST(cost_per_wafer_usd AS DOUBLE))
      comment: "Average cost per wafer (USD) — critical for technology node cost-of-ownership analysis and pricing strategy."
    - name: "avg_nre_cost_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per technology node — measures technology development investment per node."
    - name: "avg_target_performance_metric_ghz"
      expr: AVG(CAST(target_performance_metric_ghz AS DOUBLE))
      comment: "Average target performance metric (GHz) — measures performance ambition of the node portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_tapeout_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tapeout experiment execution metrics tracking NRE costs, design quality, wafer allocation, and return velocity for silicon validation efficiency and technology maturation decisions."
  source: "`vibe_semiconductors_v1`.`research`.`tapeout_experiment`"
  dimensions:
    - name: "experiment_code"
      expr: experiment_code
      comment: "Unique identifier for the tapeout experiment"
    - name: "tapeout_name"
      expr: tapeout_name
      comment: "Business name of the tapeout"
    - name: "experiment_status"
      expr: tapeout_experiment_status
      comment: "Current status of the tapeout experiment"
    - name: "tapeout_purpose"
      expr: tapeout_purpose
      comment: "Business purpose or objective of the tapeout"
    - name: "chip_name"
      expr: chip_name
      comment: "Name of the chip design"
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type being validated"
    - name: "shuttle_name"
      expr: shuttle_name
      comment: "Multi-project wafer shuttle name"
    - name: "foundry_fab_target"
      expr: foundry_fab_target
      comment: "Target foundry fabrication facility"
    - name: "wafer_allocation_type"
      expr: wafer_allocation_type
      comment: "Type of wafer allocation (dedicated, MPW, etc.)"
    - name: "pdk_version"
      expr: pdk_version
      comment: "Process design kit version used"
    - name: "eda_tool_suite"
      expr: eda_tool_suite
      comment: "EDA tool suite used for design"
    - name: "drc_status"
      expr: drc_status
      comment: "Design rule check status"
    - name: "lvs_status"
      expr: lvs_status
      comment: "Layout versus schematic check status"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the tapeout"
    - name: "collaboration_partner"
      expr: collaboration_partner
      comment: "External collaboration partner (if any)"
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Fiscal year of tapeout"
    - name: "tapeout_quarter"
      expr: CONCAT('Q', QUARTER(tapeout_date), '-', YEAR(tapeout_date))
      comment: "Fiscal quarter of tapeout"
  measures:
    - name: "tapeout_count"
      expr: COUNT(DISTINCT tapeout_experiment_id)
      comment: "Total number of distinct tapeout experiments for silicon validation velocity tracking"
    - name: "total_nre_cost"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total non-recurring engineering cost for tapeouts for investment tracking"
    - name: "avg_nre_cost_per_tapeout"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per tapeout for cost benchmarking and planning"
    - name: "total_wafer_quantity"
      expr: SUM(CAST(wafer_quantity AS DOUBLE))
      comment: "Total wafers allocated across all tapeouts for capacity planning"
    - name: "avg_wafer_quantity_per_tapeout"
      expr: AVG(CAST(wafer_quantity AS DOUBLE))
      comment: "Average wafers per tapeout for resource planning"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size for design complexity and cost assessment"
    - name: "total_dies_per_wafer"
      expr: SUM(CAST(number_of_dies_per_wafer AS DOUBLE))
      comment: "Total dies across all wafers for yield potential assessment"
    - name: "avg_dies_per_wafer"
      expr: AVG(CAST(number_of_dies_per_wafer AS DOUBLE))
      comment: "Average dies per wafer for design efficiency benchmarking"
    - name: "drc_clean_tapeout_count"
      expr: COUNT(DISTINCT CASE WHEN drc_status = 'Clean' THEN tapeout_experiment_id END)
      comment: "Count of DRC-clean tapeouts for design quality assessment"
    - name: "lvs_clean_tapeout_count"
      expr: COUNT(DISTINCT CASE WHEN lvs_status = 'Clean' THEN tapeout_experiment_id END)
      comment: "Count of LVS-clean tapeouts for design quality assessment"
    - name: "mpw_shuttle_tapeout_count"
      expr: COUNT(DISTINCT CASE WHEN wafer_allocation_type = 'MPW' THEN tapeout_experiment_id END)
      comment: "Count of MPW shuttle tapeouts for cost-effective prototyping tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_technology_roadmap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology roadmap KPIs — tracks PPA improvement targets, competitive positioning, and investment priorities used by CTO and technology strategy leadership."
  source: "`vibe_semiconductors_v1`.`research`.`technology_roadmap`"
  dimensions:
    - name: "roadmap_status"
      expr: roadmap_status
      comment: "Current status of the technology roadmap (Draft, Approved, Active, Archived)."
    - name: "technology_focus_area"
      expr: technology_focus_area
      comment: "Technology focus area of the roadmap (Logic, Memory, Packaging, RF, etc.)."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type targeted by the roadmap (FinFET, GAA, CFET, etc.)."
    - name: "target_process_node"
      expr: target_process_node
      comment: "Target process node for the roadmap milestone."
    - name: "investment_priority_level"
      expr: investment_priority_level
      comment: "Investment priority level of the roadmap (Critical, High, Medium, Low)."
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Indicates whether the roadmap is aligned with CHIPS Act obligations."
    - name: "horizon_start_year"
      expr: horizon_start_year
      comment: "Start year of the roadmap planning horizon — used for multi-year trend analysis."
  measures:
    - name: "total_roadmaps"
      expr: COUNT(1)
      comment: "Total number of technology roadmaps — baseline measure of technology planning coverage."
    - name: "avg_performance_improvement_target_pct"
      expr: AVG(CAST(performance_improvement_target_percent AS DOUBLE))
      comment: "Average performance improvement target (%) across roadmaps — measures ambition level of technology performance goals."
    - name: "avg_power_improvement_target_pct"
      expr: AVG(CAST(power_improvement_target_percent AS DOUBLE))
      comment: "Average power improvement target (%) — measures power reduction ambition; critical for mobile and data center market competitiveness."
    - name: "avg_area_improvement_target_pct"
      expr: AVG(CAST(area_improvement_target_percent AS DOUBLE))
      comment: "Average area improvement target (%) — measures die area scaling ambition; drives cost-per-transistor reduction."
    - name: "avg_estimated_nre_cost_usd"
      expr: AVG(CAST(estimated_nre_cost AS DOUBLE))
      comment: "Average estimated NRE cost per roadmap — used to benchmark technology development investment requirements."
    - name: "total_estimated_nre_cost_usd"
      expr: SUM(CAST(estimated_nre_cost AS DOUBLE))
      comment: "Total estimated NRE cost across all roadmaps — measures total technology development investment pipeline."
    - name: "avg_transistor_density_target"
      expr: AVG(CAST(transistor_density_target AS DOUBLE))
      comment: "Average transistor density target (MTr/mm²) — primary technology scaling metric used to benchmark against IRDS roadmap and competitors."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_test_suite`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research test suite KPIs — tracks test coverage, automation adoption, and pass rates used by verification and test engineering teams to manage test quality for R&D silicon."
  source: "`vibe_semiconductors_v1`.`research`.`test_suite`"
  dimensions:
    - name: "suite_status"
      expr: suite_status
      comment: "Current status of the test suite (Active, Deprecated, Under Development, Archived)."
    - name: "suite_type"
      expr: suite_type
      comment: "Type of test suite (Functional, Parametric, Reliability, Characterization, etc.)."
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates whether the test suite is automated — measures test efficiency and scalability."
    - name: "domain"
      expr: domain
      comment: "Domain of the test suite (Logic, Memory, Analog, RF, etc.)."
    - name: "associated_process_node"
      expr: associated_process_node
      comment: "Process node associated with the test suite."
  measures:
    - name: "total_test_suites"
      expr: COUNT(1)
      comment: "Total number of research test suites — baseline measure of test portfolio breadth."
    - name: "avg_estimated_coverage_pct"
      expr: AVG(CAST(estimated_coverage_percent AS DOUBLE))
      comment: "Average estimated test coverage percentage — measures test completeness; low coverage increases silicon validation risk."
    - name: "avg_pass_rate_pct"
      expr: AVG(CAST(pass_rate_percentage AS DOUBLE))
      comment: "Average test suite pass rate (%) — primary indicator of silicon quality and test effectiveness."
    - name: "automated_suite_count"
      expr: COUNT(CASE WHEN is_automated = TRUE THEN 1 END)
      comment: "Number of automated test suites — measures test automation adoption; higher automation reduces test cycle time and cost."
    - name: "automation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Test automation rate (%) — measures the fraction of test suites that are automated; drives test efficiency improvement decisions."
    - name: "avg_average_test_duration_seconds"
      expr: AVG(CAST(average_test_duration_seconds AS DOUBLE))
      comment: "Average test duration (seconds) per suite — measures test execution efficiency; high duration impacts silicon characterization throughput."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_yield_learning_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield learning and improvement metrics tracking defect density, yield detractors, corrective actions, and learning velocity for process maturation and production readiness decisions."
  source: "`vibe_semiconductors_v1`.`research`.`yield_learning_record`"
  dimensions:
    - name: "record_status"
      expr: yield_learning_record_status
      comment: "Status of the yield learning record"
    - name: "learning_cycle_phase"
      expr: learning_cycle_phase
      comment: "Phase of the learning cycle"
    - name: "learning_cycle_number"
      expr: learning_cycle_number
      comment: "Learning cycle iteration number"
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type"
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers"
    - name: "dominant_yield_detractor"
      expr: dominant_yield_detractor
      comment: "Primary yield-limiting mechanism"
    - name: "defect_type_primary"
      expr: defect_type_primary
      comment: "Primary defect type observed"
    - name: "defect_type_secondary"
      expr: defect_type_secondary
      comment: "Secondary defect type observed"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "production_applicability_flag"
      expr: production_applicability_flag
      comment: "Indicator whether learning is applicable to production"
    - name: "pareto_analysis_performed_flag"
      expr: pareto_analysis_performed_flag
      comment: "Indicator whether Pareto analysis was performed"
    - name: "statistical_confidence_level"
      expr: statistical_confidence_level
      comment: "Statistical confidence level of the analysis"
    - name: "analysis_year"
      expr: YEAR(analysis_date)
      comment: "Fiscal year of analysis"
    - name: "analysis_quarter"
      expr: CONCAT('Q', QUARTER(analysis_date), '-', YEAR(analysis_date))
      comment: "Fiscal quarter of analysis"
  measures:
    - name: "learning_record_count"
      expr: COUNT(DISTINCT yield_learning_record_id)
      comment: "Total number of distinct yield learning records for learning velocity tracking"
    - name: "avg_baseline_yield_percent"
      expr: AVG(CAST(baseline_yield_percent AS DOUBLE))
      comment: "Average baseline yield percentage for starting point assessment"
    - name: "avg_current_yield_percent"
      expr: AVG(CAST(current_yield_percent AS DOUBLE))
      comment: "Average current yield percentage for progress tracking"
    - name: "avg_die_yield_percentage"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage for process capability assessment"
    - name: "avg_functional_yield_percentage"
      expr: AVG(CAST(functional_yield_percentage AS DOUBLE))
      comment: "Average functional yield percentage for product quality assessment"
    - name: "avg_yield_improvement_delta"
      expr: AVG(CAST(yield_improvement_delta_percentage AS DOUBLE))
      comment: "Average yield improvement delta for learning effectiveness assessment"
    - name: "total_yield_improvement_delta"
      expr: SUM(CAST(yield_improvement_delta_percentage AS DOUBLE))
      comment: "Total yield improvement across all records for cumulative learning impact and maturation velocity"
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density for process quality assessment"
    - name: "avg_critical_defect_count"
      expr: AVG(CAST(critical_defect_count AS DOUBLE))
      comment: "Average critical defects for quality control focus"
    - name: "total_wafer_count"
      expr: SUM(CAST(wafer_count AS DOUBLE))
      comment: "Total wafers analyzed for sample size assessment"
    - name: "production_applicable_record_count"
      expr: COUNT(DISTINCT CASE WHEN production_applicability_flag = TRUE THEN yield_learning_record_id END)
      comment: "Count of records applicable to production for technology transfer readiness"
    - name: "pareto_analysis_record_count"
      expr: COUNT(DISTINCT CASE WHEN pareto_analysis_performed_flag = TRUE THEN yield_learning_record_id END)
      comment: "Count of records with Pareto analysis for systematic problem-solving tracking"
$$;
