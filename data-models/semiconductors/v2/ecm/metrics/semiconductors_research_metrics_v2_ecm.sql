-- Metric views for domain: research | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for R&D program portfolio management — budget envelope, IP output, tapeout cadence, and program health by phase and priority. Used by CTO and VP R&D to steer investment allocation across technology generations."
  source: "`vibe_semiconductors_v1`.`research`.`research_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the research program (Active, On Hold, Completed, Cancelled) for portfolio health segmentation."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the program (Process R&D, Device Architecture, Packaging, PDK, etc.) for investment mix analysis."
    - name: "current_phase"
      expr: current_phase
      comment: "Current gate-review phase of the program for pipeline stage analysis."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform (FinFET, GAA, FDSOI, etc.) targeted by the program for node-level investment tracking."
    - name: "technology_generation_target"
      expr: technology_generation_target
      comment: "Target technology generation (e.g., 3nm, 2nm) for roadmap alignment analysis."
    - name: "chips_act_program_flag"
      expr: chips_act_program_flag
      comment: "Indicates whether the program is funded under the CHIPS Act for compliance and reporting segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Program risk classification (Low, Medium, High, Critical) for risk-weighted portfolio views."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL stage of the program for maturity-based portfolio analysis."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicates ITAR-controlled programs for export compliance segmentation."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year the program was planned to start, for cohort and vintage analysis."
    - name: "planned_completion_year"
      expr: DATE_TRUNC('YEAR', planned_completion_date)
      comment: "Year the program is planned to complete, for pipeline timing analysis."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of research programs in the portfolio. Baseline KPI for portfolio size and capacity planning."
    - name: "total_budget_envelope_usd"
      expr: SUM(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Total committed R&D budget across all programs. Primary financial KPI for CTO/CFO investment oversight."
    - name: "avg_budget_per_program_usd"
      expr: AVG(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Average budget envelope per research program. Used to benchmark program sizing and detect outliers."
    - name: "total_ip_filings"
      expr: SUM(CAST(ip_filing_count AS BIGINT))
      comment: "Total IP filings generated across all programs. Key innovation output KPI for board-level IP strategy reporting."
    - name: "total_tapeout_milestones"
      expr: SUM(CAST(tapeout_milestone_count AS BIGINT))
      comment: "Total tapeout milestones achieved across programs. Measures silicon execution velocity and R&D throughput."
    - name: "total_experimental_wafer_lots"
      expr: SUM(CAST(experimental_wafer_lot_count AS BIGINT))
      comment: "Total experimental wafer lots consumed across programs. Proxy for fab resource utilization by R&D."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Number of currently active research programs. Used to assess R&D execution capacity and pipeline health."
    - name: "chips_act_program_count"
      expr: COUNT(CASE WHEN chips_act_program_flag = TRUE THEN 1 END)
      comment: "Number of programs funded under the CHIPS Act. Critical for government compliance reporting and funding utilization."
    - name: "high_risk_program_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of programs classified as high or critical risk. Triggers executive risk review and mitigation planning."
    - name: "itar_controlled_program_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled programs. Required for export compliance audits and government reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project-level R&D execution KPIs covering budget performance, IP output, and delivery health. Used by R&D program managers and VPs to track project execution against plan."
  source: "`vibe_semiconductors_v1`.`research`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project (Active, Completed, On Hold, Cancelled) for pipeline health segmentation."
    - name: "project_type"
      expr: project_type
      comment: "Type of research project (Process Development, Device Architecture, PDK, etc.) for investment mix analysis."
    - name: "phase"
      expr: phase
      comment: "Current execution phase of the project for stage-gate pipeline analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Project risk classification for risk-weighted portfolio views."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL stage of the project for maturity-based portfolio analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (Internal, CHIPS Act, Government Grant, JDA) for funding mix analysis."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates ITAR-controlled projects for export compliance segmentation."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the project started, for cohort and vintage analysis."
    - name: "planned_end_year"
      expr: DATE_TRUNC('YEAR', planned_end_date)
      comment: "Year the project is planned to end, for delivery pipeline analysis."
    - name: "mpw_shuttle_participation"
      expr: mpw_shuttle_participation
      comment: "Whether the project participates in an MPW shuttle, for silicon access cost analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of R&D projects. Baseline KPI for portfolio size and resource capacity planning."
    - name: "total_nre_budget_allocated_usd"
      expr: SUM(CAST(nre_budget_allocated AS DOUBLE))
      comment: "Total NRE budget allocated across all projects. Primary financial KPI for R&D investment oversight."
    - name: "total_nre_budget_spent_usd"
      expr: SUM(CAST(nre_budget_spent AS DOUBLE))
      comment: "Total NRE budget spent across all projects. Tracks actual R&D expenditure against allocation."
    - name: "avg_nre_budget_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(nre_budget_spent AS DOUBLE) / NULLIF(CAST(nre_budget_allocated AS DOUBLE), 0)), 2)
      comment: "Average NRE budget utilization rate per project. Measures R&D spending efficiency; low utilization may indicate execution delays."
    - name: "total_ip_filings"
      expr: SUM(CAST(ip_filing_count AS BIGINT))
      comment: "Total IP filings generated across all projects. Key innovation output KPI for IP strategy and competitive positioning."
    - name: "total_experimental_wafer_lots"
      expr: SUM(CAST(experimental_wafer_lot_count AS BIGINT))
      comment: "Total experimental wafer lots consumed across projects. Proxy for fab resource utilization by R&D."
    - name: "active_project_count"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN 1 END)
      comment: "Number of currently active R&D projects. Used to assess execution capacity and pipeline health."
    - name: "nre_budget_variance_usd"
      expr: SUM(CAST(nre_budget_spent AS DOUBLE) - CAST(nre_budget_allocated AS DOUBLE))
      comment: "Total NRE budget variance (spent minus allocated) across all projects. Negative = under-spend; positive = over-run. Triggers CFO review."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical risk projects. Triggers executive risk review and mitigation planning."
    - name: "ip_filing_planned_project_count"
      expr: COUNT(CASE WHEN ip_filing_planned = TRUE THEN 1 END)
      comment: "Number of projects with planned IP filings. Measures forward-looking IP pipeline for competitive strategy."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_experimental_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experimental wafer lot execution KPIs covering yield performance, cost efficiency, and lot throughput. Used by process integration engineers and R&D directors to optimize silicon learning cycles."
  source: "`vibe_semiconductors_v1`.`research`.`experimental_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the experimental lot (Active, Completed, Scrapped, On Hold) for lot pipeline analysis."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of experimental lot (DOE, Baseline, Split, Qualification) for experiment classification."
    - name: "experimental_outcome_status"
      expr: experimental_outcome_status
      comment: "Outcome of the experiment (Pass, Fail, Inconclusive) for learning cycle effectiveness analysis."
    - name: "substrate_type"
      expr: substrate_type
      comment: "Wafer substrate type (Bulk Si, SOI, SiGe, etc.) for material-level yield analysis."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers for node-level yield and cost benchmarking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the lot for resource allocation analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the lot was planned to start, for capacity planning and cycle time trending."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month the lot actually started, for schedule adherence analysis."
    - name: "is_archived"
      expr: is_archived
      comment: "Whether the lot has been archived, for active vs. historical portfolio segmentation."
  measures:
    - name: "total_experimental_lots"
      expr: COUNT(1)
      comment: "Total number of experimental lots. Baseline KPI for R&D silicon execution volume."
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across experimental lots. Primary R&D yield KPI; drives process improvement investment decisions."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across experimental lots. Benchmark for yield gap analysis."
    - name: "yield_gap_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE) - CAST(actual_yield_percent AS DOUBLE))
      comment: "Average gap between target and actual yield (target minus actual). Positive values indicate yield shortfall requiring process intervention."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of all experimental lots. Key R&D cost KPI for budget management and cost-per-learning-cycle analysis."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of all experimental lots. Used for budget forecasting and cost variance analysis."
    - name: "avg_cost_per_lot_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per experimental lot. Benchmarks R&D cost efficiency across technology nodes and lot types."
    - name: "cost_overrun_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE) - CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total cost overrun (actual minus estimated) across all lots. Positive = over budget; triggers R&D cost control review."
    - name: "scrapped_lot_count"
      expr: COUNT(CASE WHEN lot_status = 'Scrapped' THEN 1 END)
      comment: "Number of scrapped experimental lots. High scrap rates indicate process instability or resource waste."
    - name: "high_yield_lot_count"
      expr: COUNT(CASE WHEN actual_yield_percent >= 80 THEN 1 END)
      comment: "Number of lots achieving 80%+ actual yield. Measures R&D process maturity and learning cycle success rate."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_characterization_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device and process characterization KPIs covering yield metrics, measurement quality, and defect analysis. Used by process engineers and R&D directors to evaluate technology node readiness and identify yield limiters."
  source: "`vibe_semiconductors_v1`.`research`.`characterization_result`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of characterization measurement (Electrical, Physical, Optical, etc.) for analysis segmentation."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (Pass, Fail, Pending Review) for data quality filtering."
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect observed for Pareto analysis of yield limiters."
    - name: "dominant_yield_detractor"
      expr: dominant_yield_detractor
      comment: "Primary yield detractor identified for root cause prioritization."
    - name: "yield_limiting_mechanism"
      expr: yield_limiting_mechanism
      comment: "Physical mechanism limiting yield for process improvement targeting."
    - name: "device_architecture"
      expr: device_architecture
      comment: "Device architecture under characterization for architecture-level yield comparison."
    - name: "pdk_calibration_flag"
      expr: pdk_calibration_flag
      comment: "Whether the result is used for PDK calibration, for PDK development tracking."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for trend analysis of yield improvement over time."
    - name: "reliability_stress_type"
      expr: reliability_stress_type
      comment: "Type of reliability stress applied (HTOL, NBTI, HCI, etc.) for reliability qualification tracking."
  measures:
    - name: "total_characterization_results"
      expr: COUNT(1)
      comment: "Total number of characterization results. Baseline KPI for R&D measurement throughput."
    - name: "avg_die_yield_pct"
      expr: AVG(CAST(die_yield_percent AS DOUBLE))
      comment: "Average die yield percentage across all characterization results. Primary silicon yield KPI for technology node readiness assessment."
    - name: "avg_functional_yield_pct"
      expr: AVG(CAST(functional_yield_percent AS DOUBLE))
      comment: "Average functional yield percentage. Measures device functionality rate; critical for production readiness decisions."
    - name: "avg_parametric_yield_pct"
      expr: AVG(CAST(parametric_yield_percent AS DOUBLE))
      comment: "Average parametric yield percentage. Measures electrical parameter compliance rate for process window analysis."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across characterization results. Key process cleanliness KPI; drives fab process improvement investment."
    - name: "avg_yield_improvement_delta"
      expr: AVG(CAST(yield_improvement_delta AS DOUBLE))
      comment: "Average yield improvement delta achieved per characterization cycle. Measures R&D learning cycle effectiveness."
    - name: "total_yield_improvement_delta"
      expr: SUM(CAST(yield_improvement_delta AS DOUBLE))
      comment: "Cumulative yield improvement delta across all results. Tracks total yield gain from R&D investment."
    - name: "pdk_calibration_result_count"
      expr: COUNT(CASE WHEN pdk_calibration_flag = TRUE THEN 1 END)
      comment: "Number of results used for PDK calibration. Measures PDK development data coverage and model accuracy investment."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value across all results. Used for process centering and specification compliance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_patent_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP portfolio KPIs covering patent filing volume, cost, prosecution health, and strategic value. Used by Chief IP Counsel and CTO to manage the patent portfolio and R&D IP output."
  source: "`vibe_semiconductors_v1`.`research`.`patent_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the patent filing (Filed, Pending, Granted, Abandoned, Expired) for portfolio health analysis."
    - name: "patent_type"
      expr: patent_type
      comment: "Type of patent (Utility, Design, Provisional, PCT) for portfolio composition analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Patent jurisdiction (US, EP, CN, JP, KR, etc.) for geographic IP coverage analysis."
    - name: "technology_domain"
      expr: technology_domain
      comment: "Technology domain of the invention for IP portfolio alignment with R&D strategy."
    - name: "prosecution_stage"
      expr: prosecution_stage
      comment: "Current prosecution stage for pipeline management and attorney workload analysis."
    - name: "chips_act_reportable"
      expr: chips_act_reportable
      comment: "Whether the patent is reportable under CHIPS Act obligations for compliance tracking."
    - name: "prior_art_search_completed"
      expr: prior_art_search_completed
      comment: "Whether prior art search is completed for prosecution readiness analysis."
    - name: "filing_year"
      expr: DATE_TRUNC('YEAR', filing_date)
      comment: "Year of patent filing for IP output trend analysis."
    - name: "grant_year"
      expr: DATE_TRUNC('YEAR', grant_date)
      comment: "Year of patent grant for IP portfolio maturity analysis."
  measures:
    - name: "total_patent_filings"
      expr: COUNT(1)
      comment: "Total number of patent filings. Primary IP output KPI for R&D innovation measurement and competitive positioning."
    - name: "total_actual_filing_cost_usd"
      expr: SUM(CAST(actual_filing_cost AS DOUBLE))
      comment: "Total actual cost of all patent filings. Key IP investment KPI for budget management and cost-per-patent analysis."
    - name: "total_estimated_filing_cost_usd"
      expr: SUM(CAST(estimated_filing_cost AS DOUBLE))
      comment: "Total estimated filing cost across all patents. Used for IP budget forecasting."
    - name: "avg_filing_cost_usd"
      expr: AVG(CAST(actual_filing_cost AS DOUBLE))
      comment: "Average actual cost per patent filing. Benchmarks IP prosecution efficiency across jurisdictions and law firms."
    - name: "avg_strategic_value_score"
      expr: AVG(CAST(strategic_value AS DOUBLE))
      comment: "Average strategic value score of the patent portfolio. Used by Chief IP Counsel to prioritize maintenance and licensing decisions."
    - name: "total_strategic_value_score"
      expr: SUM(CAST(strategic_value AS DOUBLE))
      comment: "Total strategic value score across all patents. Measures overall IP portfolio strength for licensing and M&A valuation."
    - name: "avg_business_value_score"
      expr: AVG(CAST(business_value_score AS DOUBLE))
      comment: "Average business value score of patent filings. Measures commercial relevance of the IP portfolio."
    - name: "granted_patent_count"
      expr: COUNT(CASE WHEN filing_status = 'Granted' THEN 1 END)
      comment: "Number of granted patents. Measures IP portfolio strength and prosecution success rate."
    - name: "chips_act_reportable_count"
      expr: COUNT(CASE WHEN chips_act_reportable = TRUE THEN 1 END)
      comment: "Number of patents reportable under CHIPS Act. Required for government compliance reporting."
    - name: "filing_cost_variance_usd"
      expr: SUM(CAST(actual_filing_cost AS DOUBLE) - CAST(estimated_filing_cost AS DOUBLE))
      comment: "Total filing cost variance (actual minus estimated). Positive = over budget; triggers IP budget review."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_government_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Government grant portfolio KPIs covering award amounts, CHIPS Act compliance, and funding utilization. Used by VP R&D and CFO to manage government funding relationships and compliance obligations."
  source: "`vibe_semiconductors_v1`.`research`.`government_grant`"
  dimensions:
    - name: "government_grant_status"
      expr: government_grant_status
      comment: "Current status of the grant (Active, Completed, Pending, Terminated) for portfolio health analysis."
    - name: "grant_type"
      expr: grant_type
      comment: "Type of government grant (CHIPS Act, SBIR, DARPA, DOE, etc.) for funding source mix analysis."
    - name: "grant_category"
      expr: grant_category
      comment: "Category of the grant for investment area analysis."
    - name: "awarding_agency"
      expr: awarding_agency
      comment: "Government agency awarding the grant for agency relationship management."
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Whether the grant is CHIPS Act compliant for regulatory reporting segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the grant involves ITAR-controlled research for export compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the grant award for multi-currency portfolio analysis."
    - name: "award_year"
      expr: DATE_TRUNC('YEAR', award_date)
      comment: "Year of grant award for funding trend analysis."
    - name: "performance_start_year"
      expr: DATE_TRUNC('YEAR', performance_start_date)
      comment: "Year the grant performance period starts for timeline analysis."
  measures:
    - name: "total_grants"
      expr: COUNT(1)
      comment: "Total number of government grants. Baseline KPI for government funding relationship breadth."
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total government grant award amount. Primary funding KPI for R&D budget planning and government relations reporting."
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average grant award amount. Benchmarks grant size for funding strategy and agency relationship analysis."
    - name: "total_matching_fund_amount"
      expr: SUM(CAST(matching_fund_amount AS DOUBLE))
      comment: "Total matching funds committed by the company. Measures co-investment obligations under government grant terms."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credits associated with government grants. Key financial benefit KPI for CFO reporting on CHIPS Act incentives."
    - name: "chips_act_grant_count"
      expr: COUNT(CASE WHEN chips_act_compliance_flag = TRUE THEN 1 END)
      comment: "Number of CHIPS Act compliant grants. Required for government compliance reporting and funding utilization tracking."
    - name: "active_grant_count"
      expr: COUNT(CASE WHEN government_grant_status = 'Active' THEN 1 END)
      comment: "Number of currently active government grants. Measures active government funding relationships."
    - name: "avg_tax_credit_per_grant"
      expr: AVG(CAST(tax_credit_amount AS DOUBLE))
      comment: "Average tax credit per government grant. Used to evaluate the financial return on government funding relationships."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_yield_learning_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield learning cycle KPIs covering yield improvement, defect analysis, and production readiness. Used by process integration directors and fab operations to track R&D-to-production yield transfer effectiveness."
  source: "`vibe_semiconductors_v1`.`research`.`yield_learning_record`"
  dimensions:
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of yield loss (Lithography, Etch, Deposition, CMP, etc.) for Pareto-driven process improvement."
    - name: "defect_type_primary"
      expr: defect_type_primary
      comment: "Primary defect type for yield loss attribution analysis."
    - name: "dominant_yield_detractor"
      expr: dominant_yield_detractor
      comment: "Dominant yield detractor for prioritizing process improvement investments."
    - name: "learning_cycle_phase"
      expr: learning_cycle_phase
      comment: "Phase of the learning cycle (Early, Mid, Late, Production Transfer) for maturity tracking."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers for node-level yield learning comparison."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type for architecture-level yield analysis."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action (Open, In Progress, Closed) for yield improvement execution tracking."
    - name: "production_applicability_flag"
      expr: production_applicability_flag
      comment: "Whether the learning is applicable to production for R&D-to-production transfer analysis."
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month of yield analysis for trend analysis of yield improvement velocity."
    - name: "pareto_analysis_performed_flag"
      expr: pareto_analysis_performed_flag
      comment: "Whether Pareto analysis was performed for analysis quality segmentation."
  measures:
    - name: "total_yield_learning_records"
      expr: COUNT(1)
      comment: "Total number of yield learning records. Baseline KPI for R&D learning cycle throughput."
    - name: "avg_die_yield_pct"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage across all learning records. Primary yield KPI for technology node maturity assessment."
    - name: "avg_functional_yield_pct"
      expr: AVG(CAST(functional_yield_percentage AS DOUBLE))
      comment: "Average functional yield percentage. Measures device functionality rate for production readiness decisions."
    - name: "avg_baseline_yield_pct"
      expr: AVG(CAST(baseline_yield_percentage AS DOUBLE))
      comment: "Average baseline yield percentage. Benchmark for measuring yield improvement from R&D interventions."
    - name: "avg_yield_improvement_delta_pct"
      expr: AVG(CAST(yield_improvement_delta_percentage AS DOUBLE))
      comment: "Average yield improvement delta achieved per learning cycle. Measures R&D learning cycle effectiveness and process improvement ROI."
    - name: "total_yield_improvement_delta_pct"
      expr: SUM(CAST(yield_improvement_delta_percentage AS DOUBLE))
      comment: "Cumulative yield improvement delta across all learning records. Tracks total yield gain from R&D investment."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm². Key process cleanliness KPI; drives fab process improvement investment."
    - name: "production_applicable_record_count"
      expr: COUNT(CASE WHEN production_applicability_flag = TRUE THEN 1 END)
      comment: "Number of yield learning records applicable to production. Measures R&D-to-production knowledge transfer effectiveness."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_status = 'Open' THEN 1 END)
      comment: "Number of yield learning records with open corrective actions. Measures yield improvement execution backlog requiring management attention."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_pdk_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PDK development KPIs covering validation progress, feature completeness, and release health. Used by PDK program managers and design enablement directors to track PDK readiness for customer and internal design teams."
  source: "`vibe_semiconductors_v1`.`research`.`pdk_development`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the PDK (In Development, Released, Deprecated, End of Support) for portfolio health analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the PDK for release readiness tracking."
    - name: "release_type"
      expr: release_type
      comment: "Type of PDK release (Alpha, Beta, Production, Patch) for release pipeline analysis."
    - name: "process_type"
      expr: process_type
      comment: "Process type the PDK targets (Logic, Analog, RF, Memory) for design enablement coverage analysis."
    - name: "is_customer_accessible"
      expr: is_customer_accessible
      comment: "Whether the PDK is accessible to external customers for design-win enablement tracking."
    - name: "supports_euv_lithography"
      expr: supports_euv_lithography
      comment: "Whether the PDK supports EUV lithography for advanced node capability tracking."
    - name: "cadence_virtuoso_compatible"
      expr: cadence_virtuoso_compatible
      comment: "Whether the PDK is compatible with Cadence Virtuoso for EDA tool coverage analysis."
    - name: "synopsys_compatible"
      expr: synopsys_compatible
      comment: "Whether the PDK is compatible with Synopsys tools for EDA tool coverage analysis."
    - name: "release_year"
      expr: DATE_TRUNC('YEAR', release_date)
      comment: "Year of PDK release for release cadence trend analysis."
  measures:
    - name: "total_pdk_versions"
      expr: COUNT(1)
      comment: "Total number of PDK versions. Baseline KPI for design enablement portfolio breadth."
    - name: "avg_validation_completion_pct"
      expr: AVG(CAST(validation_completion_percentage AS DOUBLE))
      comment: "Average PDK validation completion percentage. Primary PDK readiness KPI; drives release gate decisions."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size across PDK versions. Measures technology node coverage of the PDK portfolio."
    - name: "customer_accessible_pdk_count"
      expr: COUNT(CASE WHEN is_customer_accessible = TRUE THEN 1 END)
      comment: "Number of PDKs accessible to external customers. Measures design-win enablement capacity and customer design support readiness."
    - name: "euv_capable_pdk_count"
      expr: COUNT(CASE WHEN supports_euv_lithography = TRUE THEN 1 END)
      comment: "Number of PDKs supporting EUV lithography. Measures advanced node design enablement capability."
    - name: "released_pdk_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Released' THEN 1 END)
      comment: "Number of currently released PDKs. Measures active design enablement portfolio size."
    - name: "avg_known_issues_count"
      expr: AVG(CAST(known_issues_count AS BIGINT))
      comment: "Average number of known issues per PDK version. Quality KPI for PDK health; high values trigger PDK patch releases."
    - name: "total_critical_issues"
      expr: SUM(CAST(critical_issues_count AS BIGINT))
      comment: "Total critical issues across all PDK versions. Triggers immediate PDK patch prioritization and customer notification."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_competitive_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive intelligence KPIs covering PPA gap analysis, transistor density benchmarking, and technology positioning. Used by CTO and VP Strategy to assess competitive standing and guide R&D investment priorities."
  source: "`vibe_semiconductors_v1`.`research`.`competitive_benchmark`"
  dimensions:
    - name: "benchmark_status"
      expr: benchmark_status
      comment: "Status of the benchmark (Active, Archived, Under Review) for data currency filtering."
    - name: "benchmark_source_type"
      expr: benchmark_source_type
      comment: "Source type of benchmark data (Published, Reverse Engineering, Conference, Analyst) for data quality segmentation."
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of the competitor being benchmarked for competitive gap analysis by rival."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers for node-level competitive comparison."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type (FinFET, GAA, FDSOI) for architecture-level competitive analysis."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the benchmark data for data quality-weighted analysis."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL of the benchmarked technology for maturity-adjusted competitive analysis."
    - name: "benchmark_year"
      expr: DATE_TRUNC('YEAR', benchmark_date)
      comment: "Year of the benchmark for competitive trend analysis over time."
  measures:
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of competitive benchmarks. Baseline KPI for competitive intelligence coverage."
    - name: "avg_ppa_performance_score"
      expr: AVG(CAST(ppa_performance_score AS DOUBLE))
      comment: "Average PPA performance score across benchmarks. Primary competitive positioning KPI for CTO technology strategy decisions."
    - name: "avg_ppa_power_score"
      expr: AVG(CAST(ppa_power_score AS DOUBLE))
      comment: "Average PPA power score across benchmarks. Measures power efficiency competitive position."
    - name: "avg_ppa_area_score"
      expr: AVG(CAST(ppa_area_score AS DOUBLE))
      comment: "Average PPA area score across benchmarks. Measures area scaling competitive position."
    - name: "avg_transistor_density"
      expr: AVG(CAST(transistor_density_mtransistors_per_mm2 AS DOUBLE))
      comment: "Average competitor transistor density in MTr/mm². Key technology scaling KPI for node competitiveness assessment."
    - name: "avg_operating_frequency_ghz"
      expr: AVG(CAST(operating_frequency_ghz AS DOUBLE))
      comment: "Average competitor operating frequency in GHz. Measures performance competitive gap for product positioning."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average competitor power consumption in mW. Measures power efficiency competitive gap."
    - name: "distinct_competitors_tracked"
      expr: COUNT(DISTINCT competitor_name)
      comment: "Number of distinct competitors tracked. Measures competitive intelligence coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_budget_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R&D budget allocation KPIs covering award amounts, CHIPS Act funding, and budget period management. Used by CFO and VP R&D to manage government and internal R&D funding allocations."
  source: "`vibe_semiconductors_v1`.`research`.`budget_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the budget allocation (Active, Approved, Pending, Closed) for portfolio health analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget allocation (Personnel, Equipment, Materials, Overhead) for cost structure analysis."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source (Government, Internal, JDA, VC) for funding mix analysis."
    - name: "grant_type"
      expr: grant_type
      comment: "Type of grant funding the allocation for government program tracking."
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Whether the allocation is CHIPS Act compliant for regulatory reporting."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Whether the allocation involves ITAR-controlled research for export compliance tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the budget allocation for risk-weighted portfolio analysis."
    - name: "strategic_priority_level"
      expr: strategic_priority_level
      comment: "Strategic priority level of the allocation for investment prioritization analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget allocation for annual budget planning and variance analysis."
    - name: "allocation_year"
      expr: DATE_TRUNC('YEAR', allocation_date)
      comment: "Year of the budget allocation for trend analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of budget allocations. Baseline KPI for R&D funding portfolio breadth."
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total award amount across all budget allocations. Primary R&D funding KPI for CFO and VP R&D investment oversight."
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average award amount per budget allocation. Benchmarks allocation sizing for funding strategy analysis."
    - name: "chips_act_allocation_count"
      expr: COUNT(CASE WHEN chips_act_compliance_flag = TRUE THEN 1 END)
      comment: "Number of CHIPS Act compliant budget allocations. Required for government compliance reporting and funding utilization tracking."
    - name: "chips_act_total_award_amount"
      expr: SUM(CASE WHEN chips_act_compliance_flag = TRUE THEN CAST(award_amount AS DOUBLE) ELSE 0 END)
      comment: "Total award amount from CHIPS Act compliant allocations. Measures total CHIPS Act funding received for government reporting."
    - name: "high_priority_allocation_count"
      expr: COUNT(CASE WHEN strategic_priority_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical strategic priority allocations. Measures concentration of funding in strategic initiatives."
    - name: "itar_controlled_allocation_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled budget allocations. Required for export compliance audits and government reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_process_integration_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process integration run KPIs covering electrical performance, yield, and TCAD correlation. Used by process integration engineers and R&D directors to evaluate technology node process maturity and learning cycle velocity."
  source: "`vibe_semiconductors_v1`.`research`.`process_integration_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the process integration run (In Progress, Completed, Failed, On Hold) for pipeline analysis."
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Pass/fail outcome of the run for learning cycle success rate analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the run results for data governance tracking."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type under integration for architecture-level performance comparison."
    - name: "doe_design_type"
      expr: doe_design_type
      comment: "Design of experiment type for experimental methodology analysis."
    - name: "pdk_contribution_flag"
      expr: pdk_contribution_flag
      comment: "Whether the run contributes to PDK development for PDK data coverage tracking."
    - name: "tcad_simulation_correlation_flag"
      expr: tcad_simulation_correlation_flag
      comment: "Whether TCAD simulation correlation was performed for simulation accuracy tracking."
    - name: "run_start_month"
      expr: DATE_TRUNC('MONTH', run_start_timestamp)
      comment: "Month the run started for throughput trend analysis."
  measures:
    - name: "total_integration_runs"
      expr: COUNT(1)
      comment: "Total number of process integration runs. Baseline KPI for R&D silicon execution throughput."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across all integration runs. Primary process maturity KPI for technology node readiness assessment."
    - name: "avg_threshold_voltage_mv"
      expr: AVG(CAST(threshold_voltage_mv AS DOUBLE))
      comment: "Average threshold voltage in mV. Key device electrical parameter for process centering and specification compliance."
    - name: "avg_drive_current_ua"
      expr: AVG(CAST(drive_current_ua AS DOUBLE))
      comment: "Average drive current in µA. Primary transistor performance KPI for technology node competitiveness assessment."
    - name: "avg_leakage_current_na"
      expr: AVG(CAST(leakage_current_na AS DOUBLE))
      comment: "Average leakage current in nA. Key power efficiency KPI; high leakage triggers process optimization investment."
    - name: "avg_tcad_correlation_accuracy_pct"
      expr: AVG(CAST(tcad_correlation_accuracy_percentage AS DOUBLE))
      comment: "Average TCAD simulation correlation accuracy percentage. Measures simulation model quality for PDK development and process prediction."
    - name: "pdk_contributing_run_count"
      expr: COUNT(CASE WHEN pdk_contribution_flag = TRUE THEN 1 END)
      comment: "Number of runs contributing to PDK development. Measures PDK data coverage and model calibration investment."
    - name: "pass_run_count"
      expr: COUNT(CASE WHEN pass_fail_determination = 'Pass' THEN 1 END)
      comment: "Number of passing process integration runs. Measures R&D execution success rate and process stability."
    - name: "avg_gate_oxide_thickness_nm"
      expr: AVG(CAST(gate_oxide_thickness_nm AS DOUBLE))
      comment: "Average gate oxide thickness in nm. Critical process control parameter for device reliability and performance."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_ip_core_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core development KPIs covering NRE cost, design completeness, and verification coverage. Used by VP Engineering and Chief IP Officer to manage the IP core portfolio and track development ROI."
  source: "`vibe_semiconductors_v1`.`research`.`ip_core_development`"
  dimensions:
    - name: "development_status"
      expr: development_status
      comment: "Current development status of the IP core (In Development, Silicon Validated, Released, Deprecated) for portfolio health analysis."
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (Hard IP, Soft IP, Firm IP) for portfolio composition analysis."
    - name: "ip_category"
      expr: ip_category
      comment: "Category of IP core (Interface, Memory, Processor, Analog, etc.) for technology coverage analysis."
    - name: "licensing_model"
      expr: licensing_model
      comment: "Licensing model for the IP core (Royalty, Paid-Up, Internal Only) for revenue model analysis."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL of the IP core for maturity-based portfolio analysis."
    - name: "silicon_validation_status"
      expr: silicon_validation_status
      comment: "Silicon validation status for production readiness tracking."
    - name: "ip_portfolio_classification"
      expr: ip_portfolio_classification
      comment: "Portfolio classification (Strategic, Standard, Legacy) for investment prioritization."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the IP core development for risk-weighted portfolio analysis."
    - name: "project_start_year"
      expr: DATE_TRUNC('YEAR', project_start_date)
      comment: "Year the IP core development project started for cohort analysis."
  measures:
    - name: "total_ip_core_developments"
      expr: COUNT(1)
      comment: "Total number of IP core development efforts. Baseline KPI for IP portfolio breadth."
    - name: "total_actual_nre_cost_usd"
      expr: SUM(CAST(actual_nre_cost_usd AS DOUBLE))
      comment: "Total actual NRE cost across all IP core developments. Primary IP investment KPI for CFO and VP Engineering budget management."
    - name: "total_estimated_nre_cost_usd"
      expr: SUM(CAST(estimated_nre_cost_usd AS DOUBLE))
      comment: "Total estimated NRE cost across all IP core developments. Used for IP budget forecasting."
    - name: "nre_cost_variance_usd"
      expr: SUM(CAST(actual_nre_cost_usd AS DOUBLE) - CAST(estimated_nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost variance (actual minus estimated). Positive = over budget; triggers IP development cost review."
    - name: "avg_verification_coverage_pct"
      expr: AVG(CAST(verification_coverage_percentage AS DOUBLE))
      comment: "Average verification coverage percentage across IP cores. Measures design quality and tape-out readiness."
    - name: "avg_rtl_completion_pct"
      expr: AVG(CAST(rtl_completion_percentage AS DOUBLE))
      comment: "Average RTL completion percentage. Measures IP core development pipeline progress."
    - name: "avg_reuse_pct"
      expr: AVG(CAST(reuse_percentage AS DOUBLE))
      comment: "Average IP reuse percentage. Measures design efficiency and IP portfolio leverage; high reuse reduces NRE cost."
    - name: "silicon_validated_count"
      expr: COUNT(CASE WHEN silicon_validation_status = 'Validated' THEN 1 END)
      comment: "Number of silicon-validated IP cores. Measures production-ready IP portfolio size for customer design-win enablement."
    - name: "avg_documentation_completeness_pct"
      expr: AVG(CAST(documentation_completeness_percentage AS DOUBLE))
      comment: "Average documentation completeness percentage. Measures IP core release readiness and customer support quality."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_tapeout_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tapeout experiment KPIs covering NRE cost, design completion status, and silicon return tracking. Used by R&D directors and program managers to manage MPW shuttle participation and tapeout execution."
  source: "`vibe_semiconductors_v1`.`research`.`tapeout_experiment`"
  dimensions:
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the tapeout experiment (In Design, Submitted, In Fab, Returned, Completed) for pipeline analysis."
    - name: "drc_status"
      expr: drc_status
      comment: "DRC completion status for design sign-off tracking."
    - name: "lvs_status"
      expr: lvs_status
      comment: "LVS completion status for design sign-off tracking."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type under tapeout for architecture-level cost and cycle time analysis."
    - name: "tapeout_purpose"
      expr: tapeout_purpose
      comment: "Purpose of the tapeout (Process Characterization, IP Validation, Product Prototype) for investment classification."
    - name: "wafer_allocation_type"
      expr: wafer_allocation_type
      comment: "Type of wafer allocation (MPW, Dedicated, Split) for cost model analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the tapeout experiment for cost attribution analysis."
    - name: "gds_submission_year"
      expr: DATE_TRUNC('YEAR', gds_submission_date)
      comment: "Year of GDS submission for tapeout cadence trend analysis."
  measures:
    - name: "total_tapeout_experiments"
      expr: COUNT(1)
      comment: "Total number of tapeout experiments. Baseline KPI for R&D silicon execution volume and MPW shuttle utilization."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost across all tapeout experiments. Primary tapeout investment KPI for R&D budget management."
    - name: "avg_nre_cost_per_tapeout_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per tapeout experiment. Benchmarks tapeout cost efficiency across technology nodes and allocation types."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in mm². Measures area scaling progress and cost-per-die implications for technology node evaluation."
    - name: "drc_clean_count"
      expr: COUNT(CASE WHEN drc_status = 'Clean' THEN 1 END)
      comment: "Number of tapeouts with clean DRC. Measures design quality and tape-out readiness rate."
    - name: "completed_tapeout_count"
      expr: COUNT(CASE WHEN experiment_status = 'Completed' THEN 1 END)
      comment: "Number of completed tapeout experiments. Measures R&D silicon execution throughput and learning cycle completion rate."
    - name: "distinct_technology_nodes"
      expr: COUNT(DISTINCT fabrication_technology_node_id)
      comment: "Number of distinct technology nodes covered by tapeout experiments. Measures technology node portfolio breadth in R&D."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_technology_roadmap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology roadmap KPIs covering PPA improvement targets, competitive benchmarking, and investment planning. Used by CTO and VP Strategy to align R&D investment with technology generation targets."
  source: "`vibe_semiconductors_v1`.`research`.`technology_roadmap`"
  dimensions:
    - name: "roadmap_status"
      expr: roadmap_status
      comment: "Current status of the technology roadmap (Active, Draft, Archived) for portfolio currency analysis."
    - name: "technology_focus_area"
      expr: technology_focus_area
      comment: "Technology focus area of the roadmap (Logic, Memory, Packaging, etc.) for investment mix analysis."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type targeted by the roadmap for architecture strategy analysis."
    - name: "investment_priority_level"
      expr: investment_priority_level
      comment: "Investment priority level for resource allocation analysis."
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Whether the roadmap is CHIPS Act compliant for government reporting."
    - name: "target_process_node"
      expr: target_process_node
      comment: "Target process node for the roadmap for node-level investment planning."
    - name: "target_introduction_year"
      expr: DATE_TRUNC('YEAR', target_introduction_date)
      comment: "Year the technology is targeted for introduction for pipeline timing analysis."
    - name: "last_review_year"
      expr: DATE_TRUNC('YEAR', last_review_date)
      comment: "Year of last roadmap review for currency and governance tracking."
  measures:
    - name: "total_roadmaps"
      expr: COUNT(1)
      comment: "Total number of technology roadmaps. Baseline KPI for technology planning coverage."
    - name: "avg_performance_improvement_target_pct"
      expr: AVG(CAST(performance_improvement_target_percent AS DOUBLE))
      comment: "Average performance improvement target percentage across roadmaps. Measures ambition level of R&D technology targets."
    - name: "avg_power_improvement_target_pct"
      expr: AVG(CAST(power_improvement_target_percent AS DOUBLE))
      comment: "Average power improvement target percentage. Measures power efficiency ambition for competitive positioning."
    - name: "avg_area_improvement_target_pct"
      expr: AVG(CAST(area_improvement_target_percent AS DOUBLE))
      comment: "Average area improvement target percentage. Measures scaling ambition for cost reduction planning."
    - name: "avg_transistor_density_target"
      expr: AVG(CAST(transistor_density_target AS DOUBLE))
      comment: "Average transistor density target across roadmaps. Key technology scaling KPI for node competitiveness planning."
    - name: "total_estimated_nre_cost"
      expr: SUM(CAST(estimated_nre_cost AS DOUBLE))
      comment: "Total estimated NRE cost across all technology roadmaps. Primary investment planning KPI for CTO and CFO."
    - name: "avg_estimated_nre_cost"
      expr: AVG(CAST(estimated_nre_cost AS DOUBLE))
      comment: "Average estimated NRE cost per roadmap. Benchmarks technology generation investment requirements."
    - name: "chips_act_roadmap_count"
      expr: COUNT(CASE WHEN chips_act_compliance_flag = TRUE THEN 1 END)
      comment: "Number of CHIPS Act compliant technology roadmaps. Required for government compliance reporting."
$$;