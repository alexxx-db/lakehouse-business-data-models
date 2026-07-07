-- Metric views for domain: product | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of materials metrics tracking BOM complexity, material cost, compliance status, and change activity for supply chain planning and cost management."
  source: "`vibe_semiconductors_v1`.`product`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "BOM approval and release status for engineering change control"
    - name: "bom_type"
      expr: bom_type
      comment: "BOM type (engineering, manufacturing, service) for lifecycle management"
    - name: "explosion_type"
      expr: explosion_type
      comment: "BOM explosion method for MRP and costing logic"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance status for environmental regulatory reporting"
    - name: "conflict_minerals_compliant_flag"
      expr: conflict_minerals_compliant_flag
      comment: "Conflict minerals compliance for supply chain due diligence"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag for trade compliance"
    - name: "critical_material_flag"
      expr: critical_material_flag
      comment: "Critical material indicator for supply risk management"
    - name: "production_version"
      expr: production_version
      comment: "Production version for manufacturing configuration control"
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total BOM count for configuration management workload"
    - name: "total_material_cost_usd"
      expr: SUM(CAST(total_material_cost AS DOUBLE))
      comment: "Aggregate material cost across BOMs for cost of goods sold analysis"
    - name: "avg_material_cost_usd"
      expr: AVG(CAST(total_material_cost AS DOUBLE))
      comment: "Average BOM material cost for product cost benchmarking"
    - name: "avg_component_count"
      expr: AVG(CAST(total_component_count AS DOUBLE))
      comment: "Average component count per BOM for complexity and supply chain risk assessment"
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap rate for yield and cost modeling"
    - name: "rohs_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rohs_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs meeting RoHS compliance for regulatory readiness"
    - name: "conflict_minerals_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conflict_minerals_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs with conflict minerals compliance for supply chain transparency"
    - name: "critical_material_exposure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_material_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs containing critical materials for supply risk mitigation"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOM line-level metrics covering component cost, compliance, and supply risk — used by supply chain, procurement, and product engineering to manage component-level cost and risk exposure."
  source: "`vibe_semiconductors_v1`.`product`.`bom_line`"
  dimensions:
    - name: "bom_line_status"
      expr: bom_line_status
      comment: "Current status of the BOM line (Active, Obsolete, Pending) for component portfolio health."
    - name: "component_type"
      expr: component_type
      comment: "Type of component (Active, Passive, Mechanical) for spend category analysis."
    - name: "make_or_buy_indicator"
      expr: make_or_buy_indicator
      comment: "Make-or-buy decision indicator — strategic sourcing classification for cost and risk analysis."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance flag for chemical regulatory segmentation."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Boolean indicating a critical component — supply chain risk flag for procurement prioritization."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Boolean indicating single-source supply — supply concentration risk flag for procurement."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR control flag for export compliance risk segmentation."
    - name: "phantom_bom_flag"
      expr: phantom_bom_flag
      comment: "Boolean indicating a phantom BOM line — used to filter planning vs. physical components."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Component manufacturer name for supplier concentration and risk analysis."
    - name: "bom_level"
      expr: bom_level
      comment: "BOM hierarchy level for multi-level BOM complexity analysis."
  measures:
    - name: "total_bom_lines"
      expr: COUNT(1)
      comment: "Total count of BOM lines — measures BOM complexity and component portfolio size."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all BOM lines in USD — primary component cost KPI for product cost management."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per BOM line — benchmarks component cost structure."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average quantity per assembly across BOM lines — used for material requirements planning."
    - name: "avg_scrap_factor_percent"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor percentage across BOM lines — material waste and cost efficiency KPI."
    - name: "total_single_source_components"
      expr: COUNT(CASE WHEN single_source_flag = TRUE THEN 1 END)
      comment: "Count of single-source BOM lines — supply concentration risk KPI for procurement and supply chain risk management."
    - name: "total_critical_components"
      expr: COUNT(CASE WHEN critical_component_flag = TRUE THEN 1 END)
      comment: "Count of critical component BOM lines — supply chain risk exposure metric for procurement prioritization."
    - name: "total_itar_controlled_lines"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled BOM lines — export compliance risk exposure for legal and trade teams."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_compliance_cert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product compliance certification metrics covering certification coverage, expiry risk, and regulatory scope — used by compliance, legal, and product management executives to manage regulatory market access."
  source: "`vibe_semiconductors_v1`.`product`.`compliance_cert`"
  dimensions:
    - name: "compliance_cert_status"
      expr: compliance_cert_status
      comment: "Current status of the compliance certificate (Active, Expired, Revoked) for compliance portfolio health."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status for compliance tracking."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (RoHS, REACH, AEC-Q, ISO, etc.) for compliance category analysis."
    - name: "environmental_standard"
      expr: environmental_standard
      comment: "Environmental standard covered by the certification for regulatory segmentation."
    - name: "quality_management_standard"
      expr: quality_management_standard
      comment: "Quality management standard (ISO 9001, IATF 16949) for quality compliance segmentation."
    - name: "automotive_grade_certified"
      expr: automotive_grade_certified
      comment: "Boolean indicating automotive grade certification — critical for automotive market access."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for chemical regulatory segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance risk segmentation."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Boolean indicating recertification is required — tracks upcoming compliance renewal workload."
    - name: "applicable_regions"
      expr: applicable_regions
      comment: "Geographic regions covered by the certification for market access analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires — used for recertification planning and compliance risk management."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued — used for certification age and renewal cycle analysis."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Count of active compliance certifications — primary compliance portfolio coverage KPI."
    - name: "total_expired_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Count of expired certifications — compliance risk exposure metric triggering immediate renewal action."
    - name: "total_automotive_certified_products"
      expr: COUNT(CASE WHEN automotive_grade_certified = TRUE THEN 1 END)
      comment: "Count of automotive-grade certified products — directly tied to automotive market access and revenue."
    - name: "total_recertification_required"
      expr: COUNT(CASE WHEN recertification_required = TRUE THEN 1 END)
      comment: "Count of certifications requiring recertification — upcoming compliance workload and risk management KPI."
    - name: "total_itar_controlled_certs"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled certifications — export compliance risk exposure for legal review."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_configuration_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product configuration rule metrics covering rule portfolio health, compliance, and coverage — used by product management and engineering to govern valid product configurations and manage rule lifecycle."
  source: "`vibe_semiconductors_v1`.`product`.`configuration_rule`"
  dimensions:
    - name: "configuration_rule_status"
      expr: configuration_rule_status
      comment: "Current status of the configuration rule (Active, Deprecated, Draft) for rule portfolio health."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of configuration rule (Compatibility, Exclusion, Dependency) for rule classification."
    - name: "applicable_market"
      expr: applicable_market
      comment: "Market segment the rule applies to for market-specific configuration analysis."
    - name: "applicable_process_node"
      expr: applicable_process_node
      comment: "Process node the rule applies to for technology-specific configuration management."
    - name: "automotive_qualified"
      expr: automotive_qualified
      comment: "Boolean indicating automotive qualification applicability — automotive configuration compliance flag."
    - name: "is_default_rule"
      expr: is_default_rule
      comment: "Boolean indicating this is a default configuration rule — used to distinguish baseline vs. exception rules."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance risk segmentation."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "package_type"
      expr: package_type
      comment: "Package type the rule applies to for packaging configuration analysis."
    - name: "temperature_range"
      expr: temperature_range
      comment: "Temperature range the rule applies to for operating condition segmentation."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the rule became effective — used for rule lifecycle and version management analysis."
  measures:
    - name: "total_active_rules"
      expr: COUNT(CASE WHEN configuration_rule_status = 'Active' THEN 1 END)
      comment: "Count of active configuration rules — measures configuration governance coverage."
    - name: "total_automotive_qualified_rules"
      expr: COUNT(CASE WHEN automotive_qualified = TRUE THEN 1 END)
      comment: "Count of automotive-qualified configuration rules — measures automotive configuration compliance coverage."
    - name: "total_itar_controlled_rules"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled configuration rules — export compliance risk exposure for legal review."
    - name: "total_default_rules"
      expr: COUNT(CASE WHEN is_default_rule = TRUE THEN 1 END)
      comment: "Count of default configuration rules — measures baseline configuration coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_errata`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product errata metrics tracking defect severity, customer impact, resolution rates, and workaround availability for quality management and customer support effectiveness."
  source: "`vibe_semiconductors_v1`.`product`.`errata`"
  dimensions:
    - name: "errata_status"
      expr: errata_status
      comment: "Errata lifecycle status for defect tracking and resolution management"
    - name: "severity"
      expr: severity
      comment: "Defect severity level for prioritization and escalation"
    - name: "customer_disclosure_status"
      expr: customer_disclosure_status
      comment: "Customer notification status for transparency and communication tracking"
    - name: "workaround_available"
      expr: workaround_available
      comment: "Workaround availability for customer impact mitigation"
    - name: "verification_status"
      expr: verification_status
      comment: "Fix verification status for closure readiness"
    - name: "functional_block"
      expr: functional_block
      comment: "Affected functional block for root cause analysis and design improvement"
    - name: "regulatory_impact"
      expr: regulatory_impact
      comment: "Regulatory impact level for compliance risk assessment"
  measures:
    - name: "total_errata"
      expr: COUNT(1)
      comment: "Total errata count for product quality tracking"
    - name: "avg_impacted_customer_count"
      expr: AVG(CAST(impacted_customer_count AS DOUBLE))
      comment: "Average number of customers impacted per errata for exposure assessment"
    - name: "workaround_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN workaround_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of errata with workarounds available for customer impact mitigation"
    - name: "distinct_affected_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers impacted by errata for customer satisfaction risk"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product family metrics tracking portfolio breadth, technology node distribution, lifecycle status, and compliance for strategic product line management and roadmap planning."
  source: "`vibe_semiconductors_v1`.`product`.`family`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Family lifecycle stage for portfolio health and investment prioritization"
    - name: "family_type"
      expr: family_type
      comment: "Product family type for market segmentation and strategy alignment"
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment for revenue and demand planning"
    - name: "process_technology"
      expr: process_technology
      comment: "Fabrication process technology for capacity and cost modeling"
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Technology node for roadmap and migration planning"
    - name: "package_type"
      expr: package_type
      comment: "Package type for assembly and test planning"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance status for regulatory reporting"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag for trade compliance"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit ownership for P&L and resource allocation"
  measures:
    - name: "total_families"
      expr: COUNT(1)
      comment: "Total product family count for portfolio breadth tracking"
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield across families for manufacturing performance benchmarking"
    - name: "avg_target_power_mw"
      expr: AVG(CAST(target_power_mw AS DOUBLE))
      comment: "Average target power consumption for power efficiency roadmap tracking"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(typical_die_size_mm2 AS DOUBLE))
      comment: "Average die size for cost and capacity modeling"
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturing score for manufacturability assessment"
    - name: "avg_dft_coverage_percent"
      expr: AVG(CAST(dft_coverage_percent AS DOUBLE))
      comment: "Average design-for-test coverage for quality and yield improvement"
    - name: "rohs_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rohs_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of families meeting RoHS compliance for regulatory readiness"
    - name: "distinct_business_units"
      expr: COUNT(DISTINCT business_unit)
      comment: "Number of business units with product families for organizational coverage"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ic_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core product catalog metrics tracking active products, lifecycle distribution, technology node mix, and compliance status for semiconductor IC portfolio management and strategic planning."
  source: "`vibe_semiconductors_v1`.`product`.`ic_catalog`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle stage (NPI, production, EOL) for portfolio health analysis"
    - name: "product_type"
      expr: product_type
      comment: "IC product category for market segment analysis"
    - name: "target_market"
      expr: target_market
      comment: "Target market segment for revenue and demand planning"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Operating temperature classification for application suitability"
    - name: "process_technology"
      expr: process_technology
      comment: "Fabrication process technology for capacity and cost modeling"
    - name: "automotive_qualified_flag"
      expr: automotive_qualified
      comment: "AEC-Q100 qualification status for automotive market eligibility"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant
      comment: "RoHS compliance status for regulatory reporting"
    - name: "itar_controlled_flag"
      expr: itar_controlled
      comment: "ITAR export control flag for trade compliance"
    - name: "npi_phase"
      expr: npi_phase
      comment: "New product introduction phase for development pipeline tracking"
    - name: "design_type"
      expr: design_type
      comment: "Design architecture type (ASIC, ASSP, etc.) for portfolio mix analysis"
  measures:
    - name: "total_active_products"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active products in catalog for portfolio size tracking"
    - name: "total_products"
      expr: COUNT(1)
      comment: "Total product count including inactive for historical portfolio analysis"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size for cost and yield modeling"
    - name: "avg_power_typical_mw"
      expr: AVG(CAST(power_typical_mw AS DOUBLE))
      comment: "Average typical power consumption for thermal and power budget planning"
    - name: "avg_operating_frequency_max_mhz"
      expr: AVG(CAST(operating_frequency_max_mhz AS DOUBLE))
      comment: "Average maximum operating frequency for performance benchmarking"
    - name: "total_transistor_count"
      expr: SUM(CAST(transistor_count AS DOUBLE))
      comment: "Aggregate transistor count across portfolio for complexity tracking"
    - name: "distinct_product_families"
      expr: COUNT(DISTINCT family_id)
      comment: "Number of unique product families for portfolio breadth analysis"
    - name: "rohs_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of products meeting RoHS compliance for regulatory readiness"
    - name: "automotive_qualification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN automotive_qualified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of automotive-qualified products for market penetration tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP licensing metrics tracking agreement value, royalty rates, territory coverage, and compliance for IP monetization and revenue recognition."
  source: "`vibe_semiconductors_v1`.`product`.`license_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Agreement lifecycle status for contract management and revenue forecasting"
    - name: "license_type"
      expr: license_type
      comment: "License model (perpetual, subscription, royalty-bearing) for revenue recognition"
    - name: "licensing_model"
      expr: licensing_model
      comment: "Licensing business model for pricing strategy analysis"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Exclusivity status for competitive positioning and pricing power"
    - name: "territory_restriction"
      expr: territory_restriction
      comment: "Geographic territory for market coverage and expansion planning"
    - name: "field_of_use"
      expr: field_of_use
      comment: "Permitted application field for IP usage compliance"
    - name: "sublicense_allowed_flag"
      expr: sublicense_allowed_flag
      comment: "Sublicensing permission for ecosystem expansion potential"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Auto-renewal status for recurring revenue predictability"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag for trade compliance"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total license agreement count for IP portfolio monetization tracking"
    - name: "total_contract_value_usd"
      expr: SUM(CAST(total_contract_value_usd AS DOUBLE))
      comment: "Aggregate contract value for IP revenue pipeline"
    - name: "avg_contract_value_usd"
      expr: AVG(CAST(total_contract_value_usd AS DOUBLE))
      comment: "Average contract value for deal size benchmarking"
    - name: "total_upfront_fee_usd"
      expr: SUM(CAST(upfront_fee_usd AS DOUBLE))
      comment: "Aggregate upfront fees for immediate revenue recognition"
    - name: "total_minimum_royalty_usd"
      expr: SUM(CAST(minimum_royalty_usd AS DOUBLE))
      comment: "Aggregate minimum royalty commitments for baseline revenue forecasting"
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate for pricing strategy benchmarking"
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Aggregate non-recurring engineering costs for IP customization investment"
    - name: "exclusivity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exclusive agreements for competitive positioning analysis"
    - name: "sublicense_allowed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sublicense_allowed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements allowing sublicensing for ecosystem expansion potential"
    - name: "distinct_licensees"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique licensee customers for IP market penetration"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_license_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License allocation utilization metrics covering consumption rates, remaining capacity, and compliance risk — used by legal, compliance, and product executives to manage export license utilization and IP allocation efficiency."
  source: "`vibe_semiconductors_v1`.`product`.`license_allocation`"
  dimensions:
    - name: "license_allocation_status"
      expr: license_allocation_status
      comment: "Current status of the allocation (Active, Exhausted, Expired) for utilization management."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Operational status of the allocation record."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (Export License, IP License, Volume) for classification."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the allocation for compliance workflow tracking."
    - name: "license_type"
      expr: license_type
      comment: "License type associated with the allocation for portfolio segmentation."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR control flag for export compliance risk segmentation."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for export compliance geographic analysis."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Boolean indicating renewal is needed — upcoming compliance workload flag."
    - name: "allocation_period"
      expr: allocation_period
      comment: "Allocation period label for time-series utilization analysis."
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year of allocation — used for utilization trend analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the allocation expires — used for renewal pipeline planning."
  measures:
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total allocated units across all license allocations — measures IP and export license capacity deployed."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total consumed units across all license allocations — measures actual utilization of licensed capacity."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining units across all license allocations — measures unused licensed capacity and potential revenue."
    - name: "total_allocated_value_usd"
      expr: SUM(CAST(allocated_value_usd AS DOUBLE))
      comment: "Total allocated value in USD — measures financial exposure of license allocations."
    - name: "total_consumed_value_usd"
      expr: SUM(CAST(consumed_value_usd AS DOUBLE))
      comment: "Total consumed value in USD — measures realized value from license utilization."
    - name: "avg_utilization_percent"
      expr: AVG(CAST(utilization_percent AS DOUBLE))
      comment: "Average license utilization percentage — primary efficiency KPI for license portfolio management."
    - name: "avg_diversion_risk_score"
      expr: AVG(CAST(diversion_risk_score AS DOUBLE))
      comment: "Average diversion risk score across allocations — export compliance risk KPI for legal and compliance review."
    - name: "total_itar_controlled_allocations"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled allocations — export compliance risk exposure metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_pcn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product change notification metrics tracking change volume, customer impact, approval rates, and implementation timelines for change management and customer communication effectiveness."
  source: "`vibe_semiconductors_v1`.`product`.`pcn`"
  dimensions:
    - name: "pcn_status"
      expr: pcn_status
      comment: "PCN workflow status for change management tracking"
    - name: "pcn_type"
      expr: pcn_type
      comment: "Type of product change for impact analysis and prioritization"
    - name: "change_category"
      expr: change_category
      comment: "Change category for classification and reporting"
    - name: "form_fit_function_impact"
      expr: form_fit_function_impact
      comment: "Form-fit-function impact level for customer qualification requirements"
    - name: "customer_approval_required_flag"
      expr: customer_approval_required_flag
      comment: "Customer approval requirement for notification workflow routing"
    - name: "automotive_qualification_required_flag"
      expr: automotive_qualification_required_flag
      comment: "Automotive re-qualification requirement for AEC-Q100 compliance"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification completion status for change implementation readiness"
    - name: "samples_available_flag"
      expr: samples_available_flag
      comment: "Sample availability for customer evaluation support"
  measures:
    - name: "total_pcns"
      expr: COUNT(1)
      comment: "Total PCN count for change management workload tracking"
    - name: "avg_affected_customer_count"
      expr: AVG(CAST(affected_customer_count AS DOUBLE))
      comment: "Average number of customers impacted per PCN for communication scope planning"
    - name: "avg_customer_approval_count"
      expr: AVG(CAST(customer_approval_count AS DOUBLE))
      comment: "Average customer approvals received per PCN for acceptance rate tracking"
    - name: "avg_customer_objection_count"
      expr: AVG(CAST(customer_objection_count AS DOUBLE))
      comment: "Average customer objections per PCN for risk and escalation management"
    - name: "customer_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(customer_approval_count AS DOUBLE)) / NULLIF(SUM(CAST(affected_customer_count AS DOUBLE)), 0), 2)
      comment: "Percentage of affected customers approving changes for change acceptance tracking"
    - name: "automotive_qualification_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN automotive_qualification_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PCNs requiring automotive re-qualification for resource planning"
    - name: "samples_available_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN samples_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PCNs with samples available for customer evaluation readiness"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_process_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process node technology metrics covering yield baselines, cost, cycle time, and lifecycle — used by technology strategy and manufacturing executives to evaluate node investments and roadmap transitions."
  source: "`vibe_semiconductors_v1`.`product`.`process_node`"
  dimensions:
    - name: "process_node_status"
      expr: process_node_status
      comment: "Current status of the process node (Active, EOL, Development) for technology portfolio health."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the node (R&D, Qualification, Production, EOL) for roadmap planning."
    - name: "node_generation"
      expr: node_generation
      comment: "Technology generation label (e.g. 7nm, 5nm, 3nm) for technology roadmap segmentation."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography type (EUV, DUV, ArF) — tracks technology transition investment."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (FinFET, GAA, Planar) for technology differentiation analysis."
    - name: "foundry_source"
      expr: foundry_source
      comment: "Foundry partner providing the process node — supply concentration risk analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the node (Qualified, In-Progress, Pending) for readiness tracking."
    - name: "opc_required_flag"
      expr: opc_required_flag
      comment: "Boolean indicating OPC requirement — proxy for mask complexity and cost."
    - name: "pdk_release_year"
      expr: YEAR(pdk_release_date)
      comment: "Year PDK was released — tracks design enablement readiness timeline."
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year the node was qualified — used for technology ramp cohort analysis."
  measures:
    - name: "total_active_nodes"
      expr: COUNT(CASE WHEN process_node_status = 'Active' THEN 1 END)
      comment: "Count of active process nodes — measures technology portfolio breadth and manufacturing flexibility."
    - name: "avg_baseline_yield_percent"
      expr: AVG(CAST(baseline_yield_percent AS DOUBLE))
      comment: "Average baseline yield percentage across process nodes — key manufacturing efficiency and cost KPI."
    - name: "avg_cost_per_wafer_usd"
      expr: AVG(CAST(cost_per_wafer_usd AS DOUBLE))
      comment: "Average cost per wafer in USD — primary cost structure KPI for technology node investment decisions."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average cycle time in days — manufacturing throughput KPI affecting delivery lead times and WIP."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size in nm — tracks technology advancement trajectory across the node portfolio."
    - name: "total_qualified_nodes"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Count of fully qualified process nodes — measures manufacturing readiness and production capacity options."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product IP core portfolio metrics covering licensing economics, performance, and lifecycle — used by IP strategy, legal, and product executives to manage IP monetization and portfolio investment decisions."
  source: "`vibe_semiconductors_v1`.`product`.`product_ip_core`"
  dimensions:
    - name: "product_ip_core_status"
      expr: product_ip_core_status
      comment: "Current status of the IP core (Active, EOL, Development) for portfolio health."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the IP core for roadmap planning."
    - name: "ip_category"
      expr: ip_category
      comment: "Category of IP core (CPU, Memory, Interface, Analog) for portfolio composition analysis."
    - name: "ip_type"
      expr: ip_type
      comment: "IP type (Hard, Soft, Firm) for licensing model and integration analysis."
    - name: "licensing_model"
      expr: licensing_model
      comment: "Licensing model (Royalty, Flat Fee, Subscription) for revenue structure analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the IP core (Verified, In-Progress, Pending) for readiness tracking."
    - name: "design_for_testability"
      expr: design_for_testability
      comment: "Boolean indicating DFT inclusion — quality and test coverage flag."
    - name: "rtl_language"
      expr: rtl_language
      comment: "RTL language (Verilog, VHDL, SystemVerilog) for EDA tool compatibility analysis."
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the IP core was released — used for portfolio vintage and revenue ramp analysis."
  measures:
    - name: "total_active_ip_cores"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN 1 END)
      comment: "Count of active IP cores — primary IP portfolio breadth KPI for product strategy."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost across IP cores in USD — measures IP development investment for ROI analysis."
    - name: "avg_nre_cost_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per IP core in USD — benchmarks IP development investment per asset."
    - name: "avg_per_unit_royalty_usd"
      expr: AVG(CAST(per_unit_royalty_usd AS DOUBLE))
      comment: "Average per-unit royalty in USD — IP monetization pricing benchmark."
    - name: "avg_operating_frequency_mhz"
      expr: AVG(CAST(operating_frequency_mhz AS DOUBLE))
      comment: "Average operating frequency in MHz across IP cores — performance portfolio benchmark."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in mW — power efficiency benchmark for IP portfolio."
    - name: "avg_area_mm2"
      expr: AVG(CAST(area_mm2 AS DOUBLE))
      comment: "Average IP core area in mm² — silicon efficiency benchmark for integration cost analysis."
    - name: "total_dft_enabled_cores"
      expr: COUNT(CASE WHEN design_for_testability = TRUE THEN 1 END)
      comment: "Count of IP cores with DFT — measures test quality coverage across the IP portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ltb_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-Time-Buy notification metrics covering LTB revenue, unit volumes, and customer acknowledgment — used by product management and sales executives to manage EOL revenue capture and customer transition."
  source: "`vibe_semiconductors_v1`.`product`.`product_ltb_notification`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the LTB notification (Draft, Issued, Closed) for pipeline management."
    - name: "product_ltb_notification_status"
      expr: product_ltb_notification_status
      comment: "Operational status of the LTB notification record."
    - name: "notification_type"
      expr: notification_type
      comment: "Type of LTB notification for classification and routing."
    - name: "discontinuance_reason_code"
      expr: discontinuance_reason_code
      comment: "Reason code for product discontinuance — used to analyze EOL drivers (technology, demand, cost)."
    - name: "customer_acknowledgment_required"
      expr: customer_acknowledgment_required
      comment: "Boolean indicating customer acknowledgment is required — flags high-touch EOL transitions."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Boolean indicating regulatory approval is required before EOL — compliance risk flag."
    - name: "replacement_product_qualification_required"
      expr: replacement_product_qualification_required
      comment: "Boolean indicating replacement product qualification is required — tracks transition complexity."
    - name: "notification_issue_year"
      expr: YEAR(notification_issue_date)
      comment: "Year LTB notification was issued — used for EOL volume trend analysis."
    - name: "final_order_year"
      expr: YEAR(final_order_date)
      comment: "Year of final order deadline — used for LTB revenue timing and supply planning."
  measures:
    - name: "total_ltb_notifications"
      expr: COUNT(1)
      comment: "Total count of LTB notifications — measures EOL portfolio activity and revenue capture workload."
    - name: "total_estimated_ltb_revenue"
      expr: SUM(CAST(estimated_ltb_revenue AS DOUBLE))
      comment: "Total estimated LTB revenue in USD — primary EOL revenue capture KPI for financial planning."
    - name: "total_actual_ltb_revenue"
      expr: SUM(CAST(actual_ltb_revenue AS DOUBLE))
      comment: "Total actual LTB revenue realized in USD — measures EOL revenue capture effectiveness vs. estimates."
    - name: "avg_estimated_ltb_revenue"
      expr: AVG(CAST(estimated_ltb_revenue AS DOUBLE))
      comment: "Average estimated LTB revenue per notification — benchmarks EOL revenue opportunity sizing."
    - name: "total_notifications_requiring_customer_ack"
      expr: COUNT(CASE WHEN customer_acknowledgment_required = TRUE THEN 1 END)
      comment: "Count of LTB notifications requiring customer acknowledgment — measures customer engagement workload."
    - name: "total_notifications_requiring_regulatory_approval"
      expr: COUNT(CASE WHEN regulatory_approval_required = TRUE THEN 1 END)
      comment: "Count of LTB notifications requiring regulatory approval — compliance risk exposure metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_qualification_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product qualification metrics tracking program completion, test coverage, reliability performance, and deviation rates for quality assurance and time-to-market management."
  source: "`vibe_semiconductors_v1`.`product`.`product_qualification_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Qualification program status for project tracking and resource allocation"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Qualification type (AEC-Q100, JEDEC, custom) for standard compliance"
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Applicable qualification standard for test plan definition"
    - name: "deviation_granted"
      expr: deviation_granted
      comment: "Deviation approval status for risk and compliance tracking"
    - name: "waiver_granted"
      expr: waiver_granted
      comment: "Waiver approval status for exception management"
    - name: "htol_enabled"
      expr: htol_enabled
      comment: "High-temperature operating life test inclusion for reliability assessment"
    - name: "tc_enabled"
      expr: tc_enabled
      comment: "Temperature cycling test inclusion for thermal stress qualification"
    - name: "hast_enabled"
      expr: hast_enabled
      comment: "Highly accelerated stress test inclusion for moisture reliability"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total qualification program count for workload and resource planning"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products under qualification for portfolio readiness tracking"
    - name: "deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_granted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs with approved deviations for quality risk assessment"
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs with approved waivers for exception tracking"
    - name: "htol_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN htol_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs including HTOL testing for reliability coverage"
    - name: "tc_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tc_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs including temperature cycling for thermal stress coverage"
    - name: "hast_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hast_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs including HAST for moisture reliability coverage"
    - name: "avg_lot_count"
      expr: AVG(CAST(lot_count AS DOUBLE))
      comment: "Average lot count per program for sample size and statistical confidence"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers under qualification for supply chain diversification"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product sample request metrics covering request volume, conversion rates, and evaluation outcomes — used by sales and product management executives to track design-win pipeline and sample program effectiveness."
  source: "`vibe_semiconductors_v1`.`product`.`product_sample_request`"
  dimensions:
    - name: "product_sample_request_status"
      expr: product_sample_request_status
      comment: "Current status of the sample request (Pending, Approved, Shipped, Evaluated) for pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the sample request for workflow management."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample (Engineering, Production, Qualification) for request classification."
    - name: "request_source"
      expr: request_source
      comment: "Source channel of the sample request (Direct, Distributor, Online) for channel analysis."
    - name: "design_win_status"
      expr: design_win_status
      comment: "Design win status resulting from the sample evaluation — primary sales pipeline conversion KPI dimension."
    - name: "design_win_conversion_flag"
      expr: design_win_conversion_flag
      comment: "Boolean indicating the sample led to a design win — conversion rate KPI dimension."
    - name: "expedited_flag"
      expr: expedited_flag
      comment: "Boolean indicating expedited sample request — measures urgency and customer priority."
    - name: "priority"
      expr: priority
      comment: "Priority level of the sample request for workload management."
    - name: "target_application"
      expr: target_application
      comment: "Target application for the sample — used for market segment and use-case analysis."
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year the sample was requested — used for demand trend analysis."
    - name: "ship_year"
      expr: YEAR(ship_date)
      comment: "Year the sample was shipped — used for fulfillment cycle time analysis."
  measures:
    - name: "total_sample_requests"
      expr: COUNT(1)
      comment: "Total count of product sample requests — measures design-win pipeline activity and customer engagement volume."
    - name: "total_design_win_conversions"
      expr: COUNT(CASE WHEN design_win_conversion_flag = TRUE THEN 1 END)
      comment: "Count of sample requests that converted to design wins — primary sample program ROI KPI."
    - name: "total_sample_cost"
      expr: SUM(CAST(sample_cost_amount AS DOUBLE))
      comment: "Total sample cost in USD — measures investment in the sample program for ROI analysis."
    - name: "avg_sample_cost"
      expr: AVG(CAST(sample_cost_amount AS DOUBLE))
      comment: "Average sample cost per request in USD — benchmarks sample program cost efficiency."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score from customer feedback — measures product quality perception and design-win readiness."
    - name: "total_expedited_requests"
      expr: COUNT(CASE WHEN expedited_flag = TRUE THEN 1 END)
      comment: "Count of expedited sample requests — measures urgent customer demand and supply chain responsiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product specification metrics covering performance achievement vs. targets and compliance status — used by product engineering and technology executives to track design goal attainment and specification quality."
  source: "`vibe_semiconductors_v1`.`product`.`product_spec`"
  dimensions:
    - name: "spec_status"
      expr: spec_status
      comment: "Current status of the product spec (Draft, Approved, Obsolete) for spec portfolio health."
    - name: "product_spec_status"
      expr: product_spec_status
      comment: "Operational status of the product spec record."
    - name: "automotive_grade"
      expr: automotive_grade
      comment: "Automotive grade classification for market segment analysis."
    - name: "functional_safety_rating"
      expr: functional_safety_rating
      comment: "Functional safety rating (ASIL-A through ASIL-D) for safety-critical application segmentation."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture for technology generation analysis."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for chemical regulatory segmentation."
    - name: "operating_condition_corner"
      expr: operating_condition_corner
      comment: "Operating condition corner (TT, SS, FF, etc.) for characterization analysis."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the spec was approved — used for spec vintage and revision cycle analysis."
  measures:
    - name: "avg_max_frequency_achieved_mhz"
      expr: AVG(CAST(max_frequency_achieved_mhz AS DOUBLE))
      comment: "Average achieved maximum frequency in MHz — measures performance delivery vs. design targets."
    - name: "avg_max_frequency_target_mhz"
      expr: AVG(CAST(max_frequency_target_mhz AS DOUBLE))
      comment: "Average target maximum frequency in MHz — baseline for performance achievement gap analysis."
    - name: "avg_dynamic_power_achieved_mw"
      expr: AVG(CAST(dynamic_power_achieved_mw AS DOUBLE))
      comment: "Average achieved dynamic power in mW — measures power efficiency delivery vs. design targets."
    - name: "avg_dynamic_power_target_mw"
      expr: AVG(CAST(dynamic_power_target_mw AS DOUBLE))
      comment: "Average target dynamic power in mW — baseline for power efficiency achievement gap analysis."
    - name: "avg_die_area_achieved_mm2"
      expr: AVG(CAST(die_area_achieved_mm2 AS DOUBLE))
      comment: "Average achieved die area in mm² — measures silicon efficiency delivery vs. design targets."
    - name: "avg_die_area_target_mm2"
      expr: AVG(CAST(die_area_target_mm2 AS DOUBLE))
      comment: "Average target die area in mm² — baseline for silicon efficiency achievement gap analysis."
    - name: "avg_esd_protection_level_kv"
      expr: AVG(CAST(esd_protection_level_kv AS DOUBLE))
      comment: "Average ESD protection level in kV — quality and reliability specification benchmark."
    - name: "avg_leakage_power_achieved_mw"
      expr: AVG(CAST(leakage_power_achieved_mw AS DOUBLE))
      comment: "Average achieved leakage power in mW — low-power design quality KPI for IoT and mobile segments."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level metrics tracking orderable configurations, lifecycle status, pricing, lead times, and compliance for sales operations and supply chain planning."
  source: "`vibe_semiconductors_v1`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "SKU lifecycle stage for availability and ordering policy"
    - name: "sku_status"
      expr: sku_status
      comment: "SKU operational status for order fulfillment eligibility"
    - name: "orderable_flag"
      expr: orderable_flag
      comment: "Orderable status for sales and distribution planning"
    - name: "shippable_flag"
      expr: shippable_flag
      comment: "Shippable status for logistics and fulfillment readiness"
    - name: "temperature_range"
      expr: temperature_range
      comment: "Operating temperature range for application suitability"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Performance speed grade for product differentiation"
    - name: "voltage_variant"
      expr: voltage_variant
      comment: "Voltage variant for power supply compatibility"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for regulatory reporting"
    - name: "halogen_free"
      expr: halogen_free
      comment: "Halogen-free status for environmental compliance"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag for trade compliance"
  measures:
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total SKU count for catalog breadth and complexity tracking"
    - name: "orderable_sku_count"
      expr: COUNT(CASE WHEN orderable_flag = TRUE THEN 1 END)
      comment: "Count of orderable SKUs for sales availability tracking"
    - name: "shippable_sku_count"
      expr: COUNT(CASE WHEN shippable_flag = TRUE THEN 1 END)
      comment: "Count of shippable SKUs for fulfillment capacity planning"
    - name: "avg_list_price_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE))
      comment: "Average list price for pricing strategy benchmarking"
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost for margin analysis and cost management"
    - name: "avg_unit_weight_grams"
      expr: AVG(CAST(unit_weight_grams AS DOUBLE))
      comment: "Average unit weight for logistics and shipping cost modeling"
    - name: "rohs_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKUs meeting RoHS compliance for regulatory readiness"
    - name: "halogen_free_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN halogen_free = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of halogen-free SKUs for environmental compliance tracking"
$$;
