-- Metric views for domain: manufacturing | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core manufacturing batch execution metrics tracking yield performance, quality compliance, and production efficiency for pharmaceutical batch manufacturing operations"
  source: "`pharmaceuticals_ecm`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "batch_number"
      expr: batch_number
      comment: "Unique batch identifier for traceability and regulatory compliance"
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g., In Progress, Released, Rejected)"
    - name: "batch_type"
      expr: batch_type
      comment: "Type of batch (e.g., Commercial, Validation, Clinical)"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification level (e.g., GMP, Non-GMP) for regulatory compliance"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision (e.g., Approved, Rejected, Rework)"
    - name: "manufacture_year"
      expr: YEAR(manufacture_date)
      comment: "Year of manufacture for trend analysis"
    - name: "manufacture_month"
      expr: DATE_TRUNC('MONTH', manufacture_date)
      comment: "Month of manufacture for production planning and trend analysis"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Material reconciliation status for GMP compliance"
    - name: "capa_required"
      expr: capa_required
      comment: "Flag indicating if corrective action is required"
    - name: "environmental_monitoring_compliant"
      expr: environmental_monitoring_compliant
      comment: "Environmental monitoring compliance flag"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of manufacturing batches executed"
    - name: "total_actual_yield_quantity"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Total actual yield quantity produced across all batches"
    - name: "total_theoretical_yield_quantity"
      expr: SUM(CAST(theoretical_yield_quantity AS DOUBLE))
      comment: "Total theoretical yield quantity expected across all batches"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across batches - key manufacturing efficiency indicator"
    - name: "avg_batch_size_quantity"
      expr: AVG(CAST(batch_size_quantity AS DOUBLE))
      comment: "Average batch size for capacity planning"
    - name: "batches_with_capa_required"
      expr: SUM(CASE WHEN capa_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of batches requiring corrective action - quality indicator"
    - name: "batches_environmentally_compliant"
      expr: SUM(CASE WHEN environmental_monitoring_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of batches meeting environmental monitoring standards"
    - name: "distinct_batch_operators"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique operators involved in batch manufacturing"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order execution and performance metrics tracking on-time delivery, yield variance, and manufacturing efficiency for pharmaceutical production planning and operations"
  source: "`pharmaceuticals_ecm`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_number"
      expr: order_number
      comment: "Unique production order identifier"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g., Planned, In Progress, Completed)"
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g., Standard, Rework, Validation)"
    - name: "priority"
      expr: priority
      comment: "Production priority level for scheduling decisions"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Scheduled start month for production planning"
    - name: "scheduled_finish_month"
      expr: DATE_TRUNC('MONTH', scheduled_finish_date)
      comment: "Scheduled finish month for delivery planning"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Material reconciliation status for GMP compliance"
    - name: "validation_batch_flag"
      expr: validation_batch_flag
      comment: "Flag indicating if this is a validation batch"
    - name: "rework_flag"
      expr: rework_flag
      comment: "Flag indicating if this order is for rework"
    - name: "pat_enabled_flag"
      expr: pat_enabled_flag
      comment: "Process Analytical Technology enabled flag"
    - name: "qbd_flag"
      expr: qbd_flag
      comment: "Quality by Design principles applied flag"
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual production quantity delivered"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity - key waste and efficiency indicator"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average production yield percentage - critical manufacturing efficiency KPI"
    - name: "rework_orders"
      expr: SUM(CASE WHEN rework_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rework orders - quality and cost indicator"
    - name: "validation_batches"
      expr: SUM(CASE WHEN validation_batch_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of validation batches for regulatory compliance tracking"
    - name: "pat_enabled_orders"
      expr: SUM(CASE WHEN pat_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders using Process Analytical Technology"
    - name: "qbd_orders"
      expr: SUM(CASE WHEN qbd_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders using Quality by Design principles"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing deviation and quality incident metrics tracking root cause analysis, regulatory reportability, and CAPA effectiveness for pharmaceutical quality management and continuous improvement"
  source: "`pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation`"
  dimensions:
    - name: "deviation_number"
      expr: deviation_number
      comment: "Unique deviation identifier for tracking and audit trail"
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of deviation for classification and trending"
    - name: "deviation_type"
      expr: deviation_type
      comment: "Type of deviation for root cause analysis"
    - name: "severity"
      expr: severity
      comment: "Severity level of the deviation (e.g., Critical, Major, Minor)"
    - name: "manufacturing_deviation_status"
      expr: manufacturing_deviation_status
      comment: "Current status of the deviation investigation"
    - name: "detection_phase"
      expr: detection_phase
      comment: "Manufacturing phase where deviation was detected"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for trending and prevention"
    - name: "product_disposition"
      expr: product_disposition
      comment: "Final disposition of affected product (e.g., Released, Rejected, Rework)"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Flag indicating if deviation must be reported to regulatory authorities"
    - name: "cmo_cdmo_flag"
      expr: cmo_cdmo_flag
      comment: "Flag indicating if deviation occurred at contract manufacturing organization"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month of deviation detection for trending"
    - name: "occurrence_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month of deviation occurrence for root cause analysis"
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of manufacturing deviations - key quality indicator"
    - name: "regulatory_reportable_deviations"
      expr: SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deviations requiring regulatory reporting - critical compliance metric"
    - name: "cmo_cdmo_deviations"
      expr: SUM(CASE WHEN cmo_cdmo_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deviations at contract manufacturing sites - supplier quality indicator"
    - name: "deviations_with_capa"
      expr: COUNT(DISTINCT CASE WHEN capa_number IS NOT NULL THEN deviation_number END)
      comment: "Count of deviations with associated CAPA - quality improvement tracking"
    - name: "distinct_batches_affected"
      expr: COUNT(DISTINCT batch_number)
      comment: "Number of unique batches affected by deviations - impact assessment"
    - name: "distinct_equipment_involved"
      expr: COUNT(DISTINCT equipment_id)
      comment: "Number of unique equipment items involved in deviations - maintenance prioritization"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing equipment performance and qualification metrics tracking uptime, calibration compliance, and asset utilization for pharmaceutical manufacturing operations and maintenance planning"
  source: "`pharmaceuticals_ecm`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_name"
      expr: equipment_name
      comment: "Name of the equipment asset"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment for categorization and analysis"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category for asset management"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (e.g., Active, Idle, Maintenance, Retired)"
    - name: "asset_criticality"
      expr: asset_criticality
      comment: "Criticality classification for maintenance prioritization"
    - name: "gmp_critical_flag"
      expr: gmp_critical_flag
      comment: "Flag indicating if equipment is GMP-critical"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Current calibration status for compliance tracking"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Equipment qualification status (IQ/OQ/PQ)"
    - name: "csv_status"
      expr: csv_status
      comment: "Computer System Validation status for regulated systems"
    - name: "clean_room_classification"
      expr: clean_room_classification
      comment: "Clean room classification if applicable"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year equipment was commissioned for age analysis"
  measures:
    - name: "total_equipment_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets in inventory"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of equipment assets - capital investment tracking"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per equipment asset"
    - name: "total_capacity_value"
      expr: SUM(CAST(capacity_value AS DOUBLE))
      comment: "Total equipment capacity for production planning"
    - name: "gmp_critical_equipment"
      expr: SUM(CASE WHEN gmp_critical_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of GMP-critical equipment requiring enhanced controls"
    - name: "equipment_calibration_current"
      expr: SUM(CASE WHEN calibration_status = 'Current' THEN 1 ELSE 0 END)
      comment: "Count of equipment with current calibration - compliance indicator"
    - name: "equipment_qualified"
      expr: SUM(CASE WHEN qualification_status = 'Qualified' THEN 1 ELSE 0 END)
      comment: "Count of fully qualified equipment - operational readiness indicator"
    - name: "distinct_equipment_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique equipment vendors for supplier diversity analysis"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing site capacity and compliance metrics tracking regulatory status, GMP certification, and production capability for pharmaceutical network planning and regulatory readiness"
  source: "`pharmaceuticals_ecm`.`manufacturing`.`site`"
  dimensions:
    - name: "site_name"
      expr: site_name
      comment: "Name of the manufacturing site"
    - name: "site_code"
      expr: site_code
      comment: "Unique site code for identification"
    - name: "site_type"
      expr: site_type
      comment: "Type of site (e.g., API, Drug Product, Packaging)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the site"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g., Owned, CMO, CDMO)"
    - name: "country_code"
      expr: country_code
      comment: "Country where site is located for geographic analysis"
    - name: "gmp_certification_status"
      expr: gmp_certification_status
      comment: "GMP certification status for regulatory compliance"
    - name: "fda_registration_status"
      expr: fda_registration_status
      comment: "FDA registration status for US market access"
    - name: "ema_authorization_status"
      expr: ema_authorization_status
      comment: "EMA authorization status for EU market access"
    - name: "pics_membership_status"
      expr: pics_membership_status
      comment: "PIC/S membership status for international recognition"
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 certification flag for quality management"
    - name: "pat_capability"
      expr: pat_capability
      comment: "Process Analytical Technology capability flag"
    - name: "qbd_implementation_status"
      expr: qbd_implementation_status
      comment: "Quality by Design implementation status"
    - name: "environmental_monitoring_program"
      expr: environmental_monitoring_program
      comment: "Environmental monitoring program in place flag"
  measures:
    - name: "total_manufacturing_sites"
      expr: COUNT(1)
      comment: "Total number of manufacturing sites in network"
    - name: "total_annual_capacity"
      expr: SUM(CAST(capacity_units_per_year AS DOUBLE))
      comment: "Total annual production capacity across all sites - strategic capacity planning metric"
    - name: "avg_site_capacity"
      expr: AVG(CAST(capacity_units_per_year AS DOUBLE))
      comment: "Average annual capacity per site"
    - name: "gmp_certified_sites"
      expr: SUM(CASE WHEN gmp_certification_status = 'Certified' THEN 1 ELSE 0 END)
      comment: "Count of GMP-certified sites - regulatory compliance indicator"
    - name: "fda_registered_sites"
      expr: SUM(CASE WHEN fda_registration_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of FDA-registered sites for US market capability"
    - name: "ema_authorized_sites"
      expr: SUM(CASE WHEN ema_authorization_status = 'Authorized' THEN 1 ELSE 0 END)
      comment: "Count of EMA-authorized sites for EU market capability"
    - name: "iso_certified_sites"
      expr: SUM(CASE WHEN iso_9001_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ISO 9001 certified sites - quality management maturity"
    - name: "pat_capable_sites"
      expr: SUM(CASE WHEN pat_capability = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sites with PAT capability - advanced manufacturing readiness"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of countries with manufacturing presence - geographic diversification"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing campaign execution metrics tracking batch completion rates, capacity utilization, and campaign efficiency for pharmaceutical production planning and resource optimization"
  source: "`pharmaceuticals_ecm`.`manufacturing`.`campaign`"
  dimensions:
    - name: "campaign_number"
      expr: campaign_number
      comment: "Unique campaign identifier"
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the manufacturing campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., Commercial, Clinical, Validation)"
    - name: "status"
      expr: campaign_status
      comment: "Current campaign status"
    - name: "approval_status"
      expr: approval_status
      comment: "Campaign approval status"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource allocation"
    - name: "manufacturing_mode"
      expr: manufacturing_mode
      comment: "Manufacturing mode (e.g., Continuous, Batch)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for portfolio analysis"
    - name: "regulatory_market"
      expr: regulatory_market
      comment: "Target regulatory market"
    - name: "cgmp_compliance_flag"
      expr: cgmp_compliance_flag
      comment: "cGMP compliance flag"
    - name: "contract_manufacturing_flag"
      expr: contract_manufacturing_flag
      comment: "Contract manufacturing flag"
    - name: "process_analytical_technology_flag"
      expr: process_analytical_technology_flag
      comment: "PAT implementation flag"
    - name: "quality_by_design_flag"
      expr: quality_by_design_flag
      comment: "QbD principles applied flag"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Planned start month for campaign planning"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of manufacturing campaigns"
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total target production quantity across campaigns"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual production quantity delivered"
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size AS DOUBLE))
      comment: "Average batch size across campaigns"
    - name: "total_batches_planned"
      expr: SUM(CAST(number_of_batches_planned AS BIGINT))
      comment: "Total number of batches planned across all campaigns"
    - name: "total_batches_completed"
      expr: SUM(CAST(number_of_batches_completed AS BIGINT))
      comment: "Total number of batches completed - execution performance indicator"
    - name: "cgmp_compliant_campaigns"
      expr: SUM(CASE WHEN cgmp_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cGMP-compliant campaigns"
    - name: "contract_manufacturing_campaigns"
      expr: SUM(CASE WHEN contract_manufacturing_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of campaigns executed at CMO/CDMO"
    - name: "pat_enabled_campaigns"
      expr: SUM(CASE WHEN process_analytical_technology_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of campaigns using Process Analytical Technology"
    - name: "qbd_campaigns"
      expr: SUM(CASE WHEN quality_by_design_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of campaigns using Quality by Design principles"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_process_validation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process validation and qualification metrics tracking validation outcomes, deviation rates, and regulatory compliance for pharmaceutical manufacturing process control and continuous verification"
  source: "`pharmaceuticals_ecm`.`manufacturing`.`process_validation`"
  dimensions:
    - name: "protocol_number"
      expr: protocol_number
      comment: "Unique validation protocol identifier"
    - name: "validation_type"
      expr: validation_type
      comment: "Type of validation (e.g., Prospective, Concurrent, Retrospective)"
    - name: "validation_stage"
      expr: validation_stage
      comment: "Stage of validation (e.g., Stage 1, Stage 2, Stage 3)"
    - name: "validation_status"
      expr: validation_status
      comment: "Current validation status"
    - name: "validation_outcome"
      expr: validation_outcome
      comment: "Final validation outcome (e.g., Successful, Failed, Conditional)"
    - name: "validation_approach"
      expr: validation_approach
      comment: "Validation approach methodology"
    - name: "process_step"
      expr: process_step
      comment: "Process step being validated"
    - name: "design_space_defined"
      expr: design_space_defined
      comment: "Flag indicating if design space is defined (QbD)"
    - name: "pat_implementation"
      expr: pat_implementation
      comment: "PAT implementation flag"
    - name: "execution_start_month"
      expr: DATE_TRUNC('MONTH', execution_start_date)
      comment: "Month validation execution started"
  measures:
    - name: "total_validations"
      expr: COUNT(1)
      comment: "Total number of process validations"
    - name: "successful_validations"
      expr: SUM(CASE WHEN validation_outcome = 'Successful' THEN 1 ELSE 0 END)
      comment: "Count of successful validations - process capability indicator"
    - name: "total_validation_runs"
      expr: SUM(CAST(number_of_runs AS BIGINT))
      comment: "Total number of validation runs executed"
    - name: "avg_runs_per_validation"
      expr: AVG(CAST(number_of_runs AS BIGINT))
      comment: "Average number of runs per validation"
    - name: "total_deviations"
      expr: SUM(CAST(deviation_count AS BIGINT))
      comment: "Total deviation count across validations - quality indicator"
    - name: "total_oos_events"
      expr: SUM(CAST(oos_count AS BIGINT))
      comment: "Total out-of-specification events - process control indicator"
    - name: "avg_batch_size_max"
      expr: AVG(CAST(batch_size_max AS DOUBLE))
      comment: "Average maximum validated batch size"
    - name: "validations_with_design_space"
      expr: SUM(CASE WHEN design_space_defined = TRUE THEN 1 ELSE 0 END)
      comment: "Count of validations with defined design space (QbD approach)"
    - name: "pat_implemented_validations"
      expr: SUM(CASE WHEN pat_implementation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of validations with PAT implementation"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_cmo_oversight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract manufacturing organization oversight metrics tracking supplier quality performance, audit compliance, and delivery reliability for pharmaceutical supply chain risk management and vendor qualification"
  source: "`pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight`"
  dimensions:
    - name: "cmo_type"
      expr: cmo_type
      comment: "Type of contract manufacturing organization"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract agreement"
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status"
    - name: "avl_status"
      expr: avl_status
      comment: "Approved Vendor List status"
    - name: "cgmp_certification_status"
      expr: cgmp_certification_status
      comment: "cGMP certification status"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification for prioritization"
    - name: "quality_scorecard_rating"
      expr: quality_scorecard_rating
      comment: "Quality scorecard rating"
    - name: "technology_platform"
      expr: technology_platform
      comment: "Manufacturing technology platform"
    - name: "active_flag"
      expr: active_flag
      comment: "Active relationship flag"
    - name: "contract_start_year"
      expr: YEAR(contract_start_date)
      comment: "Year contract started"
  measures:
    - name: "total_cmo_relationships"
      expr: COUNT(1)
      comment: "Total number of CMO/CDMO relationships"
    - name: "active_cmo_relationships"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active CMO relationships"
    - name: "avg_batch_success_rate"
      expr: AVG(CAST(batch_success_rate AS DOUBLE))
      comment: "Average batch success rate across CMOs - key supplier quality indicator"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate - supply reliability metric"
    - name: "avg_capa_closure_rate"
      expr: AVG(CAST(capa_closure_rate AS DOUBLE))
      comment: "Average CAPA closure rate - quality system effectiveness indicator"
    - name: "avg_deviation_rate"
      expr: AVG(CAST(deviation_rate AS DOUBLE))
      comment: "Average deviation rate across CMOs - quality performance indicator"
    - name: "cgmp_certified_cmos"
      expr: SUM(CASE WHEN cgmp_certification_status = 'Certified' THEN 1 ELSE 0 END)
      comment: "Count of cGMP-certified CMOs - compliance indicator"
    - name: "distinct_cmo_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique CMO vendors - supplier diversification metric"
$$;
