-- Metric views for domain: product | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ic_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the IC product catalog — lifecycle health, compliance posture, and portfolio composition used by product management and executive leadership to steer the product roadmap."
  source: "`vibe_semiconductors_v1`.`product`.`ic_catalog`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle stage (NPI, Production, EOL, Discontinued) — primary dimension for portfolio health analysis."
    - name: "product_type"
      expr: product_type
      comment: "Product type classification (ASIC, FPGA, Memory, Analog, etc.) enabling portfolio mix analysis."
    - name: "target_market"
      expr: target_market
      comment: "Target end market (Automotive, Industrial, Consumer, Data Center) for market-segment revenue attribution."
    - name: "process_technology"
      expr: process_technology
      comment: "Process technology node label (e.g. 7nm, 5nm) for technology-generation portfolio analysis."
    - name: "automotive_qualified"
      expr: automotive_qualified
      comment: "Flag indicating AEC-Q100/Q101 automotive qualification — critical for automotive market penetration tracking."
    - name: "npi_phase"
      expr: npi_phase
      comment: "New Product Introduction phase (Concept, Design, Tape-out, Qualification, Launch) for pipeline stage-gate reporting."
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Operating temperature grade (Commercial, Industrial, Military) for market segment qualification."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH environmental compliance flag — regulatory risk dimension for compliance reporting."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS environmental compliance flag — regulatory risk dimension for compliance reporting."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag — critical for export compliance and market access decisions."
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tape-out for cohort analysis of design-to-production pipeline velocity."
    - name: "production_release_year"
      expr: YEAR(production_release_date)
      comment: "Year of production release for time-to-market analysis."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN is_active = TRUE THEN ic_catalog_id END)
      comment: "Count of active IC catalog entries — baseline portfolio size KPI used by product management to track active product breadth."
    - name: "automotive_qualified_product_count"
      expr: COUNT(CASE WHEN automotive_qualified = TRUE THEN ic_catalog_id END)
      comment: "Number of AEC-qualified products — directly drives automotive market revenue opportunity and customer qualification pipeline."
    - name: "automotive_qualification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN automotive_qualified = TRUE THEN ic_catalog_id END) / NULLIF(COUNT(ic_catalog_id), 0), 2)
      comment: "Percentage of catalog products that are automotive-qualified — strategic KPI for automotive market penetration strategy."
    - name: "reach_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reach_compliant = TRUE THEN ic_catalog_id END) / NULLIF(COUNT(ic_catalog_id), 0), 2)
      comment: "Percentage of catalog products that are REACH-compliant — regulatory risk KPI; non-compliance blocks EU market access."
    - name: "rohs_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rohs_compliant = TRUE THEN ic_catalog_id END) / NULLIF(COUNT(ic_catalog_id), 0), 2)
      comment: "Percentage of catalog products that are RoHS-compliant — regulatory risk KPI for EU and global market access."
    - name: "itar_controlled_product_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN ic_catalog_id END)
      comment: "Count of ITAR-controlled products — export compliance risk exposure metric reviewed by legal and compliance leadership."
    - name: "avg_transistor_count"
      expr: AVG(CAST(transistor_count AS DOUBLE))
      comment: "Average transistor count across catalog products — technology complexity indicator used to benchmark design sophistication and process node utilization."
    - name: "avg_max_operating_frequency_mhz"
      expr: AVG(CAST(operating_frequency_max_mhz AS DOUBLE))
      comment: "Average maximum operating frequency (MHz) across catalog products — performance benchmark for competitive positioning analysis."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size (mm²) — cost and yield proxy; larger die sizes drive higher wafer cost and lower yield, directly impacting gross margin."
    - name: "avg_max_power_mw"
      expr: AVG(CAST(power_max_mw AS DOUBLE))
      comment: "Average maximum power consumption (mW) across catalog products — power efficiency benchmark for data center and mobile market competitiveness."
    - name: "eol_announced_product_count"
      expr: COUNT(CASE WHEN eol_announcement_date IS NOT NULL THEN ic_catalog_id END)
      comment: "Count of products with an EOL announcement — portfolio sunset risk metric; high counts signal revenue cliff risk requiring replacement product pipeline."
    - name: "products_in_npi"
      expr: COUNT(CASE WHEN lifecycle_status = 'NPI' THEN ic_catalog_id END)
      comment: "Count of products currently in New Product Introduction phase — innovation pipeline health KPI for executive roadmap reviews."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs for product families — used by product line managers and executives to assess family health, compliance posture, technology mix, and lifecycle stage distribution."
  source: "`vibe_semiconductors_v1`.`product`.`family`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Family lifecycle status (Active, EOL, Discontinued) — primary dimension for portfolio health segmentation."
    - name: "family_type"
      expr: family_type
      comment: "Product family type classification for portfolio mix analysis."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment (Automotive, Industrial, Consumer, HPC) for revenue and pipeline attribution."
    - name: "process_technology"
      expr: process_technology
      comment: "Process technology associated with the family for technology-generation portfolio analysis."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography type (EUV, DUV, etc.) — technology investment dimension for R&D and capex planning."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag at family level — compliance risk dimension."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance flag at family level — environmental regulatory risk dimension."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level within the product family tree — used to filter top-level vs. sub-family analysis."
    - name: "volume_production_year"
      expr: YEAR(volume_production_date)
      comment: "Year volume production began — cohort dimension for time-to-volume analysis."
    - name: "eol_announcement_year"
      expr: YEAR(eol_announcement_date)
      comment: "Year EOL was announced — used to track portfolio sunset cadence."
  measures:
    - name: "total_product_families"
      expr: COUNT(family_id)
      comment: "Total number of product families — baseline portfolio breadth KPI for executive portfolio reviews."
    - name: "active_family_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN family_id END)
      comment: "Count of active product families — core portfolio health metric; decline signals portfolio consolidation or sunset risk."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across product families — manufacturing efficiency benchmark; low yield targets signal cost risk and process maturity gaps."
    - name: "avg_typical_die_size_mm2"
      expr: AVG(CAST(typical_die_size_mm2 AS DOUBLE))
      comment: "Average typical die size (mm²) across families — cost proxy; larger die sizes increase wafer cost per unit and reduce gross margin."
    - name: "avg_target_power_mw"
      expr: AVG(CAST(target_power_mw AS DOUBLE))
      comment: "Average target power consumption (mW) across families — power efficiency benchmark for competitive positioning in power-sensitive markets."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_percent AS DOUBLE))
      comment: "Average Design-for-Test coverage percentage — quality and test cost driver; low DFT coverage increases test escape risk and field failure costs."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design-for-Manufacturability score — yield and cost risk indicator; low DFM scores predict yield loss and ramp delays."
    - name: "eol_family_count"
      expr: COUNT(CASE WHEN eol_announcement_date IS NOT NULL THEN family_id END)
      comment: "Count of families with EOL announcements — portfolio sunset risk KPI; high counts require replacement pipeline acceleration."
    - name: "itar_controlled_family_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN family_id END)
      comment: "Count of ITAR-controlled product families — export compliance risk exposure for legal and compliance leadership."
    - name: "reach_compliant_family_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reach_compliant_flag = TRUE THEN family_id END) / NULLIF(COUNT(family_id), 0), 2)
      comment: "Percentage of product families that are REACH-compliant — environmental compliance rate; below 100% signals EU market access risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials KPIs for cost management, compliance risk, and supply chain resilience — used by engineering, supply chain, and finance leadership to manage material costs and regulatory exposure."
  source: "`vibe_semiconductors_v1`.`product`.`bom`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "BOM type (Engineering, Manufacturing, Sales) — primary dimension for BOM category analysis."
    - name: "bom_status"
      expr: bom_status
      comment: "BOM approval and release status — used to filter active vs. draft BOMs in cost analysis."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency code for material cost amounts — required for multi-currency cost normalization."
    - name: "conflict_minerals_compliant_flag"
      expr: conflict_minerals_compliant_flag
      comment: "Conflict minerals compliance flag (Dodd-Frank Section 1502) — regulatory risk dimension."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance flag at BOM level — environmental regulatory risk dimension."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag at BOM level — environmental regulatory risk dimension."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag at BOM level — export compliance risk dimension."
    - name: "critical_material_flag"
      expr: critical_material_flag
      comment: "Flag indicating the BOM contains critical materials — supply chain resilience risk dimension."
    - name: "explosion_type"
      expr: explosion_type
      comment: "BOM explosion type (Single-level, Multi-level, Summarized) — structural dimension for BOM analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the BOM became effective — time dimension for BOM vintage and cost trend analysis."
  measures:
    - name: "total_bom_count"
      expr: COUNT(bom_id)
      comment: "Total number of BOMs — baseline portfolio complexity metric; high BOM counts signal engineering complexity and maintenance overhead."
    - name: "total_material_cost"
      expr: SUM(CAST(total_material_cost AS DOUBLE))
      comment: "Total material cost across all BOMs — primary cost KPI for COGS management and gross margin analysis."
    - name: "avg_material_cost_per_bom"
      expr: AVG(CAST(total_material_cost AS DOUBLE))
      comment: "Average material cost per BOM — cost benchmarking KPI; outliers indicate design cost overruns requiring engineering review."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOMs — manufacturing waste KPI; high scrap rates directly reduce gross margin and signal process quality issues."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average production lot size across BOMs — manufacturing efficiency indicator; small lot sizes increase per-unit overhead costs."
    - name: "critical_material_bom_count"
      expr: COUNT(CASE WHEN critical_material_flag = TRUE THEN bom_id END)
      comment: "Count of BOMs containing critical materials — supply chain resilience risk KPI; high counts signal single-source or geopolitical supply risk."
    - name: "conflict_minerals_non_compliant_count"
      expr: COUNT(CASE WHEN conflict_minerals_compliant_flag = FALSE THEN bom_id END)
      comment: "Count of BOMs not compliant with conflict minerals regulations — Dodd-Frank compliance risk KPI; non-zero values require immediate remediation."
    - name: "itar_controlled_bom_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN bom_id END)
      comment: "Count of ITAR-controlled BOMs — export compliance risk exposure metric for legal and compliance leadership."
    - name: "reach_compliant_bom_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reach_compliant_flag = TRUE THEN bom_id END) / NULLIF(COUNT(bom_id), 0), 2)
      comment: "Percentage of BOMs that are REACH-compliant — environmental compliance rate; below 100% blocks EU market shipments."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component-level BOM KPIs for supply chain risk, cost management, and compliance — used by supply chain, engineering, and compliance teams to manage component sourcing risk and regulatory exposure."
  source: "`vibe_semiconductors_v1`.`product`.`bom_line`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Component type classification (Active, Passive, Mechanical, etc.) — primary dimension for component category analysis."
    - name: "make_or_buy_indicator"
      expr: make_or_buy_indicator
      comment: "Make vs. Buy indicator — strategic sourcing dimension; buy components drive supplier dependency and supply chain risk."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Flag indicating single-source components — critical supply chain resilience risk dimension."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Flag indicating critical components — supply chain risk dimension for prioritized sourcing management."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance flag at component level — environmental regulatory risk dimension."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag at component level — environmental regulatory risk dimension."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag at component level — export compliance risk dimension."
    - name: "conflict_minerals_status"
      expr: conflict_minerals_status
      comment: "Conflict minerals compliance status at component level — Dodd-Frank regulatory risk dimension."
    - name: "phantom_bom_flag"
      expr: phantom_bom_flag
      comment: "Phantom BOM flag — structural dimension to exclude phantom assemblies from cost rollups."
    - name: "bom_level"
      expr: bom_level
      comment: "BOM indentation level — structural dimension for multi-level BOM analysis."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Component manufacturer name — supplier concentration risk dimension."
  measures:
    - name: "total_component_lines"
      expr: COUNT(bom_line_id)
      comment: "Total BOM line count — BOM complexity baseline; high component counts increase supply chain management overhead and risk."
    - name: "single_source_component_count"
      expr: COUNT(CASE WHEN single_source_flag = TRUE THEN bom_line_id END)
      comment: "Count of single-source component lines — supply chain resilience risk KPI; high counts signal critical supply disruption exposure."
    - name: "single_source_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN single_source_flag = TRUE THEN bom_line_id END) / NULLIF(COUNT(bom_line_id), 0), 2)
      comment: "Percentage of BOM lines that are single-sourced — supply chain concentration risk rate; drives dual-sourcing investment decisions."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN critical_component_flag = TRUE THEN bom_line_id END)
      comment: "Count of critical component lines — supply chain risk exposure metric for prioritized inventory buffering and supplier management."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all BOM lines — component cost baseline for COGS analysis and cost reduction targeting."
    - name: "avg_standard_cost_per_line"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per BOM line — cost benchmarking KPI for identifying high-cost components driving margin compression."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average component quantity per assembly — material intensity metric used in cost modeling and demand planning."
    - name: "avg_scrap_factor_pct"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor percentage across BOM lines — manufacturing waste KPI; high scrap factors inflate material costs and reduce gross margin."
    - name: "itar_controlled_component_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN bom_line_id END)
      comment: "Count of ITAR-controlled component lines — export compliance risk exposure for legal and compliance leadership."
    - name: "reach_non_compliant_component_count"
      expr: COUNT(CASE WHEN reach_compliant_flag = FALSE THEN bom_line_id END)
      comment: "Count of REACH non-compliant component lines — environmental compliance risk KPI; non-zero values block EU market shipments."
    - name: "distinct_manufacturer_count"
      expr: COUNT(DISTINCT manufacturer_name)
      comment: "Count of distinct component manufacturers — supplier diversification metric; low counts signal concentration risk in the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_qualification_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product qualification program KPIs for quality, reliability, and time-to-market — used by quality engineering and product management to track qualification progress, test coverage, and program health."
  source: "`vibe_semiconductors_v1`.`product`.`product_qualification_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Qualification program status (In Progress, Passed, Failed, On Hold) — primary dimension for program health analysis."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Qualification type (AEC-Q100, JEDEC, Customer-Specific, etc.) — dimension for qualification standard analysis."
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Qualification standard applied — regulatory and customer requirement dimension."
    - name: "deviation_granted"
      expr: deviation_granted
      comment: "Flag indicating a qualification deviation was granted — quality risk dimension; deviations signal potential reliability gaps."
    - name: "waiver_granted"
      expr: waiver_granted
      comment: "Flag indicating a qualification waiver was granted — quality risk dimension; waivers may indicate test coverage gaps."
    - name: "htol_enabled"
      expr: htol_enabled
      comment: "High Temperature Operating Life test enabled flag — reliability test coverage dimension."
    - name: "hast_enabled"
      expr: hast_enabled
      comment: "Highly Accelerated Stress Test enabled flag — reliability test coverage dimension."
    - name: "tc_enabled"
      expr: tc_enabled
      comment: "Temperature Cycling test enabled flag — reliability test coverage dimension."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year qualification program was planned to start — cohort dimension for pipeline timing analysis."
    - name: "actual_completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Year qualification program actually completed — time-to-qualification cohort dimension."
  measures:
    - name: "total_qualification_programs"
      expr: COUNT(product_qualification_program_id)
      comment: "Total qualification programs — baseline pipeline size KPI for quality and product management leadership."
    - name: "active_qualification_program_count"
      expr: COUNT(CASE WHEN program_status = 'In Progress' THEN product_qualification_program_id END)
      comment: "Count of qualification programs currently in progress — active pipeline health KPI for resource planning."
    - name: "qualification_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN program_status = 'Passed' THEN product_qualification_program_id END) / NULLIF(COUNT(product_qualification_program_id), 0), 2)
      comment: "Percentage of qualification programs that passed — quality effectiveness KPI; low pass rates signal design or process reliability issues."
    - name: "deviation_granted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_granted = TRUE THEN product_qualification_program_id END) / NULLIF(COUNT(product_qualification_program_id), 0), 2)
      comment: "Percentage of programs with deviations granted — quality risk rate; high deviation rates signal systemic qualification gaps requiring engineering intervention."
    - name: "waiver_granted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted = TRUE THEN product_qualification_program_id END) / NULLIF(COUNT(product_qualification_program_id), 0), 2)
      comment: "Percentage of programs with waivers granted — quality risk rate; waivers may expose the company to field reliability failures and customer claims."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, actual_start_date) AS DOUBLE))
      comment: "Average qualification cycle time in days — time-to-market KPI; long cycle times delay product launches and revenue recognition."
    - name: "schedule_overrun_program_count"
      expr: COUNT(CASE WHEN actual_completion_date > planned_completion_date THEN product_qualification_program_id END)
      comment: "Count of qualification programs that completed after planned date — schedule adherence KPI; overruns delay product launches and customer commitments."
    - name: "esd_hbm_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN esd_hbm_enabled = TRUE THEN product_qualification_program_id END) / NULLIF(COUNT(product_qualification_program_id), 0), 2)
      comment: "Percentage of qualification programs with ESD HBM testing enabled — ESD test coverage rate; low coverage increases field ESD failure risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_pcn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Change Notification KPIs for change management, customer impact, and regulatory compliance — used by product management and customer success to track PCN pipeline, customer response rates, and qualification requirements."
  source: "`vibe_semiconductors_v1`.`product`.`pcn`"
  dimensions:
    - name: "pcn_status"
      expr: pcn_status
      comment: "PCN status (Draft, Issued, Closed, Superseded) — primary dimension for PCN pipeline management."
    - name: "pcn_type"
      expr: pcn_type
      comment: "PCN type (Process Change, Material Change, Design Change, etc.) — dimension for change category analysis."
    - name: "change_category"
      expr: change_category
      comment: "Change category classification — dimension for impact severity analysis."
    - name: "customer_approval_required_flag"
      expr: customer_approval_required_flag
      comment: "Flag indicating customer approval is required — critical dimension for customer-gated PCN tracking."
    - name: "automotive_qualification_required_flag"
      expr: automotive_qualification_required_flag
      comment: "Flag indicating automotive re-qualification is required — high-impact dimension for automotive customer management."
    - name: "samples_available_flag"
      expr: samples_available_flag
      comment: "Flag indicating samples are available for customer evaluation — customer readiness dimension."
    - name: "notification_year"
      expr: YEAR(notification_date)
      comment: "Year PCN was issued — time dimension for PCN volume trend analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year PCN becomes effective — time dimension for change implementation planning."
  measures:
    - name: "total_pcn_count"
      expr: COUNT(pcn_id)
      comment: "Total PCN count — baseline change activity volume KPI; high volumes signal product instability or active process improvement programs."
    - name: "open_pcn_count"
      expr: COUNT(CASE WHEN pcn_status NOT IN ('Closed', 'Superseded') THEN pcn_id END)
      comment: "Count of open/active PCNs — change management workload KPI; high open counts signal customer communication and qualification backlog."
    - name: "customer_approval_required_count"
      expr: COUNT(CASE WHEN customer_approval_required_flag = TRUE THEN pcn_id END)
      comment: "Count of PCNs requiring customer approval — customer engagement workload KPI; drives customer success team resource planning."
    - name: "automotive_requalification_required_count"
      expr: COUNT(CASE WHEN automotive_qualification_required_flag = TRUE THEN pcn_id END)
      comment: "Count of PCNs requiring automotive re-qualification — high-impact KPI for automotive customer risk management; each triggers costly and time-consuming AEC re-qualification."
    - name: "avg_customer_approval_count"
      expr: AVG(CAST(customer_approval_count AS DOUBLE))
      comment: "Average number of customer approvals received per PCN — customer engagement effectiveness metric."
    - name: "avg_customer_objection_count"
      expr: AVG(CAST(customer_objection_count AS DOUBLE))
      comment: "Average number of customer objections per PCN — customer satisfaction risk KPI; high objection rates signal change management process failures."
    - name: "avg_affected_customer_count"
      expr: AVG(CAST(affected_customer_count AS DOUBLE))
      comment: "Average number of customers affected per PCN — customer impact breadth metric for prioritizing PCN communication resources."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_errata`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product errata KPIs for quality, customer risk, and engineering accountability — used by quality, product management, and customer success to track errata severity, resolution velocity, and customer disclosure compliance."
  source: "`vibe_semiconductors_v1`.`product`.`errata`"
  dimensions:
    - name: "errata_status"
      expr: errata_status
      comment: "Errata status (Open, In Progress, Resolved, Closed) — primary dimension for errata pipeline management."
    - name: "severity"
      expr: severity
      comment: "Errata severity level (Critical, Major, Minor) — risk prioritization dimension; critical errata require immediate executive attention."
    - name: "functional_block"
      expr: functional_block
      comment: "Affected functional block within the IC — engineering root cause dimension for identifying systemic design weaknesses."
    - name: "customer_disclosure_status"
      expr: customer_disclosure_status
      comment: "Customer disclosure status — compliance dimension; undisclosed critical errata create legal and customer trust risk."
    - name: "workaround_available"
      expr: workaround_available
      comment: "Flag indicating a workaround is available — customer impact mitigation dimension."
    - name: "verification_status"
      expr: verification_status
      comment: "Fix verification status — quality gate dimension for errata closure process."
    - name: "discovered_year"
      expr: YEAR(discovered_date)
      comment: "Year errata was discovered — cohort dimension for errata vintage and aging analysis."
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year errata was resolved — time-to-resolution cohort dimension."
  measures:
    - name: "total_errata_count"
      expr: COUNT(errata_id)
      comment: "Total errata count — baseline product quality KPI; high counts signal design quality issues impacting customer satisfaction and field reliability."
    - name: "open_errata_count"
      expr: COUNT(CASE WHEN errata_status NOT IN ('Resolved', 'Closed') THEN errata_id END)
      comment: "Count of open errata — active quality risk exposure KPI; high open counts signal unresolved customer-impacting defects."
    - name: "critical_errata_count"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN errata_id END)
      comment: "Count of critical severity errata — highest-priority quality risk KPI; critical errata can cause product recalls, customer escalations, and revenue loss."
    - name: "undisclosed_errata_count"
      expr: COUNT(CASE WHEN customer_disclosure_status NOT IN ('Disclosed', 'Closed') THEN errata_id END)
      comment: "Count of errata not yet disclosed to customers — compliance and customer trust risk KPI; undisclosed critical errata create legal liability."
    - name: "workaround_available_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN workaround_available = TRUE THEN errata_id END) / NULLIF(COUNT(errata_id), 0), 2)
      comment: "Percentage of errata with available workarounds — customer impact mitigation rate; higher rates reduce customer escalation risk while permanent fixes are developed."
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolution_date, discovered_date) AS DOUBLE))
      comment: "Average days from errata discovery to resolution — engineering responsiveness KPI; long resolution times increase customer exposure and satisfaction risk."
    - name: "avg_impacted_customer_count"
      expr: AVG(CAST(impacted_customer_count AS DOUBLE))
      comment: "Average number of customers impacted per errata — customer risk breadth metric for prioritizing engineering and customer success resources."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level commercial KPIs for pricing, lifecycle management, and compliance — used by product management, sales, and finance to track orderable portfolio health, pricing, and regulatory posture."
  source: "`vibe_semiconductors_v1`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "SKU lifecycle status (Active, EOL, Discontinued, LTB) — primary dimension for orderable portfolio health analysis."
    - name: "orderable_flag"
      expr: orderable_flag
      comment: "Flag indicating the SKU is currently orderable — commercial availability dimension."
    - name: "shippable_flag"
      expr: shippable_flag
      comment: "Flag indicating the SKU is currently shippable — fulfillment readiness dimension."
    - name: "temperature_range"
      expr: temperature_range
      comment: "Operating temperature range (Commercial, Industrial, Military) — market segment dimension."
    - name: "speed_grade"
      expr: speed_grade
      comment: "Speed grade classification — performance tier dimension for pricing and market positioning analysis."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag at SKU level — environmental regulatory risk dimension."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag at SKU level — environmental regulatory risk dimension."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag at SKU level — export compliance risk dimension."
    - name: "halogen_free"
      expr: halogen_free
      comment: "Halogen-free flag — environmental compliance dimension for green product portfolio tracking."
    - name: "pcn_required_flag"
      expr: pcn_required_flag
      comment: "Flag indicating a PCN is required for this SKU — change management risk dimension."
    - name: "introduction_year"
      expr: YEAR(introduction_date)
      comment: "Year SKU was introduced — cohort dimension for portfolio vintage and lifecycle analysis."
    - name: "eol_announcement_year"
      expr: YEAR(eol_announcement_date)
      comment: "Year EOL was announced — portfolio sunset cohort dimension."
  measures:
    - name: "total_sku_count"
      expr: COUNT(sku_id)
      comment: "Total SKU count — baseline orderable portfolio size KPI for product management and sales operations."
    - name: "orderable_sku_count"
      expr: COUNT(CASE WHEN orderable_flag = TRUE THEN sku_id END)
      comment: "Count of currently orderable SKUs — active commercial portfolio size KPI; decline signals portfolio contraction or supply issues."
    - name: "orderable_sku_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN orderable_flag = TRUE THEN sku_id END) / NULLIF(COUNT(sku_id), 0), 2)
      comment: "Percentage of SKUs that are currently orderable — portfolio availability rate; low rates signal lifecycle management or supply chain issues."
    - name: "avg_list_price_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE))
      comment: "Average list price (USD) across SKUs — pricing benchmark KPI for competitive positioning and pricing strategy reviews."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost (USD) across SKUs — cost baseline KPI for gross margin analysis and cost reduction targeting."
    - name: "avg_gross_margin_proxy_pct"
      expr: ROUND(100.0 * AVG(CAST(list_price_usd - standard_cost_usd AS DOUBLE)) / NULLIF(AVG(CAST(list_price_usd AS DOUBLE)), 0), 2)
      comment: "Estimated average gross margin percentage (list price minus standard cost over list price) — profitability proxy KPI for pricing and cost management decisions."
    - name: "avg_unit_weight_grams"
      expr: AVG(CAST(unit_weight_grams AS DOUBLE))
      comment: "Average unit weight (grams) — logistics cost driver metric; heavier SKUs increase shipping costs and affect packaging design."
    - name: "eol_sku_count"
      expr: COUNT(CASE WHEN eol_announcement_date IS NOT NULL THEN sku_id END)
      comment: "Count of SKUs with EOL announcements — portfolio sunset risk KPI; high counts require replacement SKU pipeline acceleration."
    - name: "itar_controlled_sku_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN sku_id END)
      comment: "Count of ITAR-controlled SKUs — export compliance risk exposure for legal and compliance leadership."
    - name: "reach_compliant_sku_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reach_compliant = TRUE THEN sku_id END) / NULLIF(COUNT(sku_id), 0), 2)
      comment: "Percentage of SKUs that are REACH-compliant — environmental compliance rate; below 100% blocks EU market shipments."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ltb_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-Time-Buy notification KPIs for end-of-life revenue management and customer communication — used by product management and sales to maximize LTB revenue capture and ensure customer acknowledgment compliance."
  source: "`vibe_semiconductors_v1`.`product`.`product_ltb_notification`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "LTB notification status (Draft, Issued, Closed, Cancelled) — primary dimension for LTB pipeline management."
    - name: "notification_type"
      expr: notification_type
      comment: "LTB notification type — dimension for categorizing EOL communication types."
    - name: "discontinuance_reason_code"
      expr: discontinuance_reason_code
      comment: "Reason code for product discontinuance — dimension for EOL root cause analysis."
    - name: "customer_acknowledgment_required"
      expr: customer_acknowledgment_required
      comment: "Flag indicating customer acknowledgment is required — compliance dimension for LTB process adherence."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Flag indicating regulatory approval is required before discontinuance — compliance risk dimension."
    - name: "replacement_product_qualification_required"
      expr: replacement_product_qualification_required
      comment: "Flag indicating replacement product qualification is required — customer transition risk dimension."
    - name: "notification_issue_year"
      expr: YEAR(notification_issue_date)
      comment: "Year LTB notification was issued — time dimension for LTB volume trend analysis."
    - name: "final_order_year"
      expr: YEAR(final_order_date)
      comment: "Year final orders are due — time dimension for LTB revenue capture planning."
  measures:
    - name: "total_ltb_notifications"
      expr: COUNT(product_ltb_notification_id)
      comment: "Total LTB notifications issued — baseline EOL activity volume KPI; high volumes signal accelerating portfolio sunset requiring replacement pipeline investment."
    - name: "total_actual_ltb_revenue"
      expr: SUM(CAST(actual_ltb_revenue AS DOUBLE))
      comment: "Total actual LTB revenue captured — primary EOL revenue KPI; directly measures success of LTB commercial execution."
    - name: "total_estimated_ltb_revenue"
      expr: SUM(CAST(estimated_ltb_revenue AS DOUBLE))
      comment: "Total estimated LTB revenue — revenue forecast KPI for EOL financial planning and budget commitments."
    - name: "ltb_revenue_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_ltb_revenue AS DOUBLE)) / NULLIF(SUM(CAST(estimated_ltb_revenue AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated LTB revenue actually captured — commercial execution effectiveness KPI; low rates signal customer communication or qualification failures."
    - name: "avg_customers_acknowledged_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(total_customers_acknowledged AS DOUBLE)) / NULLIF(AVG(CAST(total_customers_notified AS DOUBLE)), 0), 2)
      comment: "Average customer acknowledgment rate per LTB notification — customer engagement KPI; low rates signal communication gaps and unmanaged customer transition risk."
    - name: "open_ltb_notification_count"
      expr: COUNT(CASE WHEN notification_status NOT IN ('Closed', 'Cancelled') THEN product_ltb_notification_id END)
      comment: "Count of open LTB notifications — active EOL management workload KPI for product management resource planning."
    - name: "regulatory_approval_pending_count"
      expr: COUNT(CASE WHEN regulatory_approval_required = TRUE AND regulatory_approval_status NOT IN ('Approved', 'Closed') THEN product_ltb_notification_id END)
      comment: "Count of LTB notifications pending regulatory approval — compliance risk KPI; pending approvals block product discontinuance and create legal exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product specification KPIs for performance achievement, design quality, and specification compliance — used by engineering and product management to track spec attainment versus targets and identify performance gaps."
  source: "`vibe_semiconductors_v1`.`product`.`product_spec`"
  dimensions:
    - name: "spec_status"
      expr: spec_status
      comment: "Specification status (Draft, Approved, Superseded) — primary dimension for spec lifecycle management."
    - name: "automotive_grade"
      expr: automotive_grade
      comment: "Automotive grade classification — market qualification dimension for automotive product tracking."
    - name: "functional_safety_rating"
      expr: functional_safety_rating
      comment: "Functional safety rating (ASIL-A through ASIL-D, SIL) — safety compliance dimension for automotive and industrial markets."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag at spec level — environmental regulatory risk dimension."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag at spec level — environmental regulatory risk dimension."
    - name: "operating_condition_corner"
      expr: operating_condition_corner
      comment: "Operating condition corner (TT, SS, FF, SF, FS) — process corner dimension for performance analysis."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (FinFET, Planar, GAA) — technology dimension for performance benchmarking."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year specification was approved — cohort dimension for spec vintage analysis."
  measures:
    - name: "total_product_specs"
      expr: COUNT(product_spec_id)
      comment: "Total product specifications — baseline spec portfolio size KPI."
    - name: "avg_frequency_achievement_pct"
      expr: ROUND(100.0 * AVG(CAST(max_frequency_achieved_mhz AS DOUBLE)) / NULLIF(AVG(CAST(max_frequency_target_mhz AS DOUBLE)), 0), 2)
      comment: "Average frequency achievement rate (achieved vs. target MHz) — performance attainment KPI; below 100% signals design or process gaps requiring engineering intervention."
    - name: "avg_dynamic_power_achievement_pct"
      expr: ROUND(100.0 * AVG(CAST(dynamic_power_achieved_mw AS DOUBLE)) / NULLIF(AVG(CAST(dynamic_power_target_mw AS DOUBLE)), 0), 2)
      comment: "Average dynamic power achievement rate (achieved vs. target mW) — power efficiency attainment KPI; above 100% means power exceeds target, impacting battery life and thermal design."
    - name: "avg_die_area_achievement_pct"
      expr: ROUND(100.0 * AVG(CAST(die_area_achieved_mm2 AS DOUBLE)) / NULLIF(AVG(CAST(die_area_target_mm2 AS DOUBLE)), 0), 2)
      comment: "Average die area achievement rate (achieved vs. target mm²) — cost efficiency KPI; above 100% means die is larger than planned, increasing wafer cost and reducing gross margin."
    - name: "avg_max_frequency_achieved_mhz"
      expr: AVG(CAST(max_frequency_achieved_mhz AS DOUBLE))
      comment: "Average maximum frequency achieved (MHz) — absolute performance benchmark for competitive positioning analysis."
    - name: "avg_leakage_power_achieved_mw"
      expr: AVG(CAST(leakage_power_achieved_mw AS DOUBLE))
      comment: "Average leakage power achieved (mW) — power efficiency metric; high leakage increases standby power consumption and impacts battery-powered applications."
    - name: "avg_transistor_count"
      expr: AVG(CAST(transistor_count AS DOUBLE))
      comment: "Average transistor count across product specs — design complexity benchmark for technology node utilization analysis."
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count across product specs — logic complexity metric for design effort and verification scope estimation."
    - name: "avg_esd_protection_level_kv"
      expr: AVG(CAST(esd_protection_level_kv AS DOUBLE))
      comment: "Average ESD protection level (kV) — reliability benchmark; low ESD protection increases field failure risk in handling-sensitive applications."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_compliance_cert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product compliance certification KPIs for regulatory risk management and market access — used by compliance, legal, and product management to track certification coverage, expiry risk, and recertification pipeline."
  source: "`vibe_semiconductors_v1`.`product`.`compliance_cert`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status (Active, Expired, Pending, Revoked) — primary dimension for compliance portfolio health."
    - name: "certification_type"
      expr: certification_type
      comment: "Certification type (CE, UL, FCC, AEC-Q100, ISO 26262, etc.) — dimension for certification category analysis."
    - name: "environmental_standard"
      expr: environmental_standard
      comment: "Environmental standard (RoHS, REACH, WEEE, etc.) — regulatory framework dimension."
    - name: "automotive_grade_certified"
      expr: automotive_grade_certified
      comment: "Automotive grade certification flag — market access dimension for automotive revenue tracking."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag — environmental regulatory risk dimension."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag — environmental regulatory risk dimension."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "EAR export control flag — export compliance risk dimension."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag — export compliance risk dimension."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Flag indicating recertification is required — compliance maintenance workload dimension."
    - name: "applicable_regions"
      expr: applicable_regions
      comment: "Geographic regions where certification applies — market access dimension."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year certification became effective — cohort dimension for certification vintage analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year certification expires — time dimension for expiry risk planning."
  measures:
    - name: "total_compliance_certs"
      expr: COUNT(compliance_cert_id)
      comment: "Total compliance certifications — baseline regulatory coverage portfolio size KPI."
    - name: "active_cert_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN compliance_cert_id END)
      comment: "Count of active compliance certifications — current regulatory coverage KPI; decline signals market access risk."
    - name: "expired_cert_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN compliance_cert_id END)
      comment: "Count of expired certifications — compliance gap KPI; expired certs block product shipments to regulated markets."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN compliance_cert_id END)
      comment: "Count of certifications expiring within 90 days — forward-looking compliance risk KPI; drives recertification prioritization to prevent market access disruption."
    - name: "automotive_cert_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN automotive_grade_certified = TRUE THEN compliance_cert_id END) / NULLIF(COUNT(compliance_cert_id), 0), 2)
      comment: "Percentage of certifications that are automotive-grade — automotive market qualification coverage rate."
    - name: "recertification_required_count"
      expr: COUNT(CASE WHEN recertification_required = TRUE THEN compliance_cert_id END)
      comment: "Count of certifications requiring recertification — compliance maintenance workload KPI for resource planning."
    - name: "itar_controlled_cert_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN compliance_cert_id END)
      comment: "Count of ITAR-controlled product certifications — export compliance risk exposure metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_process_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process node KPIs for technology portfolio management, cost competitiveness, and lifecycle planning — used by technology strategy and product management to assess node health, cost position, and qualification status."
  source: "`vibe_semiconductors_v1`.`product`.`process_node`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Process node lifecycle stage (R&D, Qualification, Production, EOL) — primary dimension for technology portfolio health."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Node qualification status — readiness dimension for production ramp decisions."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography type (EUV, DUV, ArF, etc.) — technology investment dimension for capex planning."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (FinFET, Planar, GAA) — technology generation dimension."
    - name: "node_generation"
      expr: node_generation
      comment: "Node generation label — technology roadmap dimension for generational analysis."
    - name: "environmental_compliance_status"
      expr: environmental_compliance_status
      comment: "Environmental compliance status — regulatory risk dimension."
    - name: "opc_required_flag"
      expr: opc_required_flag
      comment: "Optical Proximity Correction required flag — process complexity dimension affecting mask cost and cycle time."
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year node was qualified — cohort dimension for technology ramp velocity analysis."
  measures:
    - name: "total_process_nodes"
      expr: COUNT(process_node_id)
      comment: "Total process nodes in portfolio — technology breadth KPI for technology strategy reviews."
    - name: "production_node_count"
      expr: COUNT(CASE WHEN lifecycle_stage = 'Production' THEN process_node_id END)
      comment: "Count of nodes in production — active technology portfolio size KPI; drives capacity planning and customer design-in decisions."
    - name: "avg_baseline_yield_pct"
      expr: AVG(CAST(baseline_yield_percent AS DOUBLE))
      comment: "Average baseline yield percentage across process nodes — manufacturing efficiency KPI; low yields directly reduce gross margin and increase cost per die."
    - name: "avg_cost_per_wafer_usd"
      expr: AVG(CAST(cost_per_wafer_usd AS DOUBLE))
      comment: "Average cost per wafer (USD) across process nodes — primary cost competitiveness KPI for technology node selection and pricing strategy."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average wafer cycle time (days) across process nodes — manufacturing throughput KPI; long cycle times delay customer delivery and increase WIP inventory costs."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size (nm) across nodes — technology advancement metric for competitive positioning and R&D investment justification."
    - name: "eol_node_count"
      expr: COUNT(CASE WHEN eol_announcement_date IS NOT NULL THEN process_node_id END)
      comment: "Count of nodes with EOL announcements — technology sunset risk KPI; high counts require customer migration planning and replacement node investment."
$$;