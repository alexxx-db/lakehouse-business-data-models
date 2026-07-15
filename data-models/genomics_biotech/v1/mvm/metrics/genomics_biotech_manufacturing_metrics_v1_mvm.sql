-- Metric views for domain: manufacturing | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_production_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core manufacturing batch performance metrics tracking yield, quality, and throughput for production batches in genomics manufacturing operations"
  source: "`genomics_biotech_ecm`.`manufacturing`.`production_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the production batch (e.g., in-progress, completed, released, quarantined)"
    - name: "batch_disposition"
      expr: batch_disposition
      comment: "Final disposition decision for the batch (e.g., approved, rejected, rework)"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "Good Manufacturing Practice classification level for regulatory compliance"
    - name: "product_category"
      expr: product_category
      comment: "Category of genomics product being manufactured (e.g., sequencing reagent, array kit, gene-editing tool)"
    - name: "manufacturing_month"
      expr: DATE_TRUNC('MONTH', manufacturing_start_date)
      comment: "Month when manufacturing started, for time-series analysis"
    - name: "manufacturing_quarter"
      expr: DATE_TRUNC('QUARTER', manufacturing_start_date)
      comment: "Quarter when manufacturing started, for executive reporting"
    - name: "ebr_status"
      expr: ebr_status
      comment: "Electronic batch record status for compliance tracking"
    - name: "process_validation_status"
      expr: process_validation_status
      comment: "Process validation status indicating manufacturing process control"
    - name: "equipment_qualification_status"
      expr: equipment_qualification_status
      comment: "Equipment qualification status for GMP compliance"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of production batches manufactured"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across batches, key efficiency indicator for manufacturing operations"
    - name: "total_planned_batch_size"
      expr: SUM(CAST(batch_size_planned AS DOUBLE))
      comment: "Total planned production volume across all batches"
    - name: "total_actual_batch_size"
      expr: SUM(CAST(batch_size_actual AS DOUBLE))
      comment: "Total actual production volume achieved across all batches"
    - name: "total_deviation_count"
      expr: SUM(CAST(deviation_count AS DOUBLE))
      comment: "Total number of manufacturing deviations, critical quality indicator"
    - name: "total_exception_count"
      expr: SUM(CAST(exception_count AS DOUBLE))
      comment: "Total number of exceptions raised during manufacturing"
    - name: "qc_pass_count"
      expr: SUM(CAST(qc_pass_count AS DOUBLE))
      comment: "Total number of QC checkpoints passed across all batches"
    - name: "qc_fail_count"
      expr: SUM(CAST(qc_fail_count AS DOUBLE))
      comment: "Total number of QC checkpoints failed, key quality risk indicator"
    - name: "distinct_products_manufactured"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs manufactured, indicating product portfolio breadth"
    - name: "distinct_sites"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of distinct manufacturing sites producing batches"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution and efficiency metrics for genomics manufacturing operations, tracking schedule adherence and production performance"
  source: "`genomics_biotech_ecm`.`manufacturing`.`work_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the work order (e.g., planned, released, in-progress, completed)"
    - name: "order_type"
      expr: order_type
      comment: "Type of work order (e.g., production, rework, validation)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order for scheduling and resource allocation"
    - name: "product_classification"
      expr: product_classification
      comment: "Classification of product being manufactured (e.g., IVD, research use only)"
    - name: "gmp_flag"
      expr: gmp_flag
      comment: "Indicates whether work order is under GMP requirements"
    - name: "qc_hold_flag"
      expr: qc_hold_flag
      comment: "Indicates whether work order is on QC hold"
    - name: "process_validation_status"
      expr: process_validation_status
      comment: "Process validation status for the work order"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month when work order is scheduled to start"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders in the manufacturing system"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all work orders"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual production quantity achieved across all work orders"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity, key waste and efficiency indicator"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across work orders, critical manufacturing efficiency KPI"
    - name: "total_deviation_count"
      expr: SUM(CAST(deviation_count AS DOUBLE))
      comment: "Total number of deviations across all work orders, quality risk indicator"
    - name: "distinct_products"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct products being manufactured"
    - name: "distinct_sites"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of distinct manufacturing sites executing work orders"
    - name: "work_orders_on_qc_hold"
      expr: SUM(CASE WHEN qc_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of work orders currently on QC hold, operational bottleneck indicator"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_production_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed operation-level performance metrics tracking labor efficiency, machine utilization, and cycle time for genomics manufacturing processes"
  source: "`genomics_biotech_ecm`.`manufacturing`.`production_operation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Current status of the production operation (e.g., scheduled, in-progress, completed, confirmed)"
    - name: "control_key"
      expr: control_key
      comment: "Control key defining operation characteristics and scheduling behavior"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Indicates whether a deviation occurred during this operation"
    - name: "in_process_qc_checkpoint_flag"
      expr: in_process_qc_checkpoint_flag
      comment: "Indicates whether this operation includes an in-process QC checkpoint"
    - name: "process_validation_run_flag"
      expr: process_validation_run_flag
      comment: "Indicates whether this operation is part of a process validation run"
    - name: "qc_result_status"
      expr: qc_result_status
      comment: "QC result status for operations with quality checkpoints"
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when operation actually started"
  measures:
    - name: "total_operations"
      expr: COUNT(1)
      comment: "Total number of production operations executed"
    - name: "total_labor_time_minutes"
      expr: SUM(CAST(actual_labor_time_minutes AS DOUBLE))
      comment: "Total actual labor time consumed across all operations"
    - name: "total_machine_time_minutes"
      expr: SUM(CAST(actual_machine_time_minutes AS DOUBLE))
      comment: "Total actual machine time consumed across all operations"
    - name: "total_setup_time_minutes"
      expr: SUM(CAST(actual_setup_time_minutes AS DOUBLE))
      comment: "Total setup time, key indicator for changeover efficiency"
    - name: "avg_labor_time_minutes"
      expr: AVG(CAST(actual_labor_time_minutes AS DOUBLE))
      comment: "Average labor time per operation, productivity benchmark"
    - name: "avg_machine_time_minutes"
      expr: AVG(CAST(actual_machine_time_minutes AS DOUBLE))
      comment: "Average machine time per operation, equipment efficiency indicator"
    - name: "total_yield_quantity"
      expr: SUM(CAST(yield_quantity AS DOUBLE))
      comment: "Total yield quantity produced across all operations"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity, waste and quality indicator"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity, first-pass yield indicator"
    - name: "operations_with_deviations"
      expr: SUM(CASE WHEN deviation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of operations with deviations, process control indicator"
    - name: "distinct_work_centers"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of distinct work centers executing operations"
    - name: "distinct_equipment"
      expr: COUNT(DISTINCT equipment_id)
      comment: "Number of distinct equipment assets utilized"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset performance and utilization metrics for genomics manufacturing, tracking uptime, maintenance, and qualification status"
  source: "`genomics_biotech_ecm`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_status"
      expr: equipment_status
      comment: "Current operational status of the equipment (e.g., operational, down, maintenance)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of manufacturing equipment (e.g., sequencer, liquid handler, incubator)"
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the equipment"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Current calibration status, critical for GMP compliance"
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the equipment for regulatory compliance"
    - name: "qualification_status"
      expr: qualification_date IS NOT NULL
      comment: "Indicates whether equipment has been qualified"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "Cleanroom classification where equipment is located"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification of the equipment for quality management"
    - name: "asset_lifecycle_stage"
      expr: asset_lifecycle_stage
      comment: "Current lifecycle stage of the asset (e.g., active, aging, end-of-life)"
    - name: "decommissioned_flag"
      expr: decommissioned_flag
      comment: "Indicates whether equipment has been decommissioned"
  measures:
    - name: "total_equipment_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets in the manufacturing network"
    - name: "total_equipment_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total capital investment in manufacturing equipment"
    - name: "avg_equipment_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per equipment asset"
    - name: "total_usage_hours"
      expr: SUM(CAST(usage_hours_total AS DOUBLE))
      comment: "Total cumulative usage hours across all equipment"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures, key reliability indicator"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair, maintenance efficiency indicator"
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total power consumption capacity, operational cost driver"
    - name: "equipment_requiring_calibration"
      expr: SUM(CASE WHEN next_calibration_due < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Number of equipment assets with overdue calibration, compliance risk indicator"
    - name: "equipment_requiring_maintenance"
      expr: SUM(CASE WHEN next_maintenance_due < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Number of equipment assets with overdue maintenance, operational risk indicator"
    - name: "distinct_equipment_types"
      expr: COUNT(DISTINCT equipment_type)
      comment: "Number of distinct equipment types in the manufacturing network"
    - name: "distinct_work_centers"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of distinct work centers containing equipment"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch record compliance and quality metrics for genomics manufacturing, tracking regulatory documentation and release status"
  source: "`genomics_biotech_ecm`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "batch_record_status"
      expr: batch_record_status
      comment: "Current status of the batch record (e.g., draft, under review, approved, rejected)"
    - name: "batch_disposition"
      expr: batch_record_status
      comment: "Disposition status for the batch record"
    - name: "coa_issued_flag"
      expr: coa_issued_flag
      comment: "Indicates whether Certificate of Analysis has been issued"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates whether batch is under quarantine"
    - name: "environmental_class"
      expr: environmental_class
      comment: "Environmental classification for manufacturing area"
    - name: "sterilization_method"
      expr: sterilization_method
      comment: "Sterilization method applied to the batch"
    - name: "gmp_classification"
      expr: environmental_class
      comment: "GMP classification inferred from environmental class"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month when batch record was approved"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completed_timestamp)
      comment: "Month when batch record was completed"
  measures:
    - name: "total_batch_records"
      expr: COUNT(1)
      comment: "Total number of batch records in the system"
    - name: "total_deviation_count"
      expr: SUM(CAST(deviation_count AS DOUBLE))
      comment: "Total number of deviations across all batch records, quality indicator"
    - name: "total_exception_count"
      expr: SUM(CAST(exception_count AS DOUBLE))
      comment: "Total number of exceptions across all batch records"
    - name: "avg_deviation_count"
      expr: AVG(CAST(deviation_count AS DOUBLE))
      comment: "Average number of deviations per batch record, process control indicator"
    - name: "batches_with_coa_issued"
      expr: SUM(CASE WHEN coa_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of batches with Certificate of Analysis issued, release readiness indicator"
    - name: "batches_under_quarantine"
      expr: SUM(CASE WHEN quarantine_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of batches currently under quarantine, quality hold indicator"
    - name: "distinct_products"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct products with batch records"
    - name: "distinct_sites"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of distinct manufacturing sites generating batch records"
    - name: "distinct_production_batches"
      expr: COUNT(DISTINCT production_batch_id)
      comment: "Number of distinct production batches documented"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_finished_goods_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished goods release and quality disposition metrics for genomics products, tracking regulatory compliance and release decisions"
  source: "`genomics_biotech_ecm`.`manufacturing`.`finished_goods_release`"
  dimensions:
    - name: "release_status"
      expr: release_status
      comment: "Current release status of finished goods (e.g., pending, approved, rejected, on hold)"
    - name: "release_type"
      expr: release_type
      comment: "Type of release (e.g., full release, conditional release, emergency release)"
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates whether batch meets GMP compliance requirements"
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Indicates whether batch is on regulatory hold"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether corrective action is required before release"
    - name: "intended_use_classification"
      expr: intended_use_classification
      comment: "Intended use classification (e.g., IVD, research use only)"
    - name: "release_criteria_checklist_status"
      expr: release_criteria_checklist_status
      comment: "Status of release criteria checklist completion"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_decision_date)
      comment: "Month when release decision was made"
  measures:
    - name: "total_release_records"
      expr: COUNT(1)
      comment: "Total number of finished goods release records"
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity of finished goods released to market"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity of finished goods rejected, quality cost indicator"
    - name: "avg_released_quantity"
      expr: AVG(CAST(released_quantity AS DOUBLE))
      comment: "Average quantity released per batch"
    - name: "total_outstanding_deviation_count"
      expr: SUM(CAST(outstanding_deviation_count AS DOUBLE))
      comment: "Total number of outstanding deviations across all releases, quality risk indicator"
    - name: "releases_on_regulatory_hold"
      expr: SUM(CASE WHEN regulatory_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of releases currently on regulatory hold, compliance risk indicator"
    - name: "releases_requiring_capa"
      expr: SUM(CASE WHEN capa_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of releases requiring corrective action, quality system indicator"
    - name: "gmp_compliant_releases"
      expr: SUM(CASE WHEN gmp_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of releases meeting GMP compliance, regulatory performance indicator"
    - name: "distinct_products_released"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct products released to market"
    - name: "distinct_sites"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of distinct manufacturing sites releasing finished goods"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_inprocess_qc_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-process quality control metrics for genomics manufacturing, tracking real-time quality performance and process control"
  source: "`genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result`"
  dimensions:
    - name: "inspection_result_status"
      expr: inspection_result_status
      comment: "Result status of the QC inspection (e.g., pass, fail, conditional)"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition code for the inspected material"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Indicates whether a deviation was identified during inspection"
    - name: "retest_required_flag"
      expr: retest_required_flag
      comment: "Indicates whether retest is required"
    - name: "inspection_method_code"
      expr: inspection_method_code
      comment: "Method code used for the inspection"
    - name: "control_chart_rule_violation"
      expr: control_chart_rule_violation
      comment: "Control chart rule violation detected, statistical process control indicator"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month when inspection was performed"
  measures:
    - name: "total_qc_inspections"
      expr: COUNT(1)
      comment: "Total number of in-process QC inspections performed"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total number of defects identified, quality performance indicator"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all inspections"
    - name: "avg_environmental_temperature"
      expr: AVG(CAST(environmental_condition_temperature AS DOUBLE))
      comment: "Average environmental temperature during inspections, process control indicator"
    - name: "avg_environmental_humidity"
      expr: AVG(CAST(environmental_condition_humidity AS DOUBLE))
      comment: "Average environmental humidity during inspections, process control indicator"
    - name: "inspections_with_deviations"
      expr: SUM(CASE WHEN deviation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inspections with deviations, first-pass quality indicator"
    - name: "inspections_requiring_retest"
      expr: SUM(CASE WHEN retest_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inspections requiring retest, quality efficiency indicator"
    - name: "distinct_work_orders"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Number of distinct work orders with QC inspections"
    - name: "distinct_production_batches"
      expr: COUNT(DISTINCT production_batch_id)
      comment: "Number of distinct production batches inspected"
    - name: "distinct_work_centers"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of distinct work centers performing QC inspections"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing site capacity and compliance metrics for genomics operations, tracking facility performance and regulatory status"
  source: "`genomics_biotech_ecm`.`manufacturing`.`site`"
  dimensions:
    - name: "manufacturing_site_status"
      expr: manufacturing_site_status
      comment: "Current operational status of the manufacturing site"
    - name: "site_type"
      expr: site_type
      comment: "Type of manufacturing site (e.g., production, R&D, contract manufacturing)"
    - name: "gmp_certified"
      expr: gmp_certified
      comment: "Indicates whether site is GMP certified"
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates whether site meets environmental compliance requirements"
    - name: "country_code"
      expr: country_code
      comment: "Country where manufacturing site is located"
    - name: "region"
      expr: region
      comment: "Geographic region of the manufacturing site"
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification level for the site"
  measures:
    - name: "total_manufacturing_sites"
      expr: COUNT(1)
      comment: "Total number of manufacturing sites in the network"
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(floor_area_sqm AS DOUBLE))
      comment: "Total manufacturing floor area across all sites"
    - name: "total_production_capacity_per_day"
      expr: SUM(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Total daily production capacity across all sites, strategic capacity planning metric"
    - name: "total_production_capacity_per_month"
      expr: SUM(CAST(production_capacity_units_per_month AS DOUBLE))
      comment: "Total monthly production capacity across all sites, strategic capacity planning metric"
    - name: "avg_production_capacity_per_day"
      expr: AVG(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Average daily production capacity per site"
    - name: "total_equipment_count"
      expr: SUM(CAST(equipment_count AS DOUBLE))
      comment: "Total number of equipment assets across all sites"
    - name: "avg_shift_hours_per_day"
      expr: AVG(CAST(shift_hours_per_day AS DOUBLE))
      comment: "Average shift hours per day across sites, labor utilization indicator"
    - name: "gmp_certified_sites"
      expr: SUM(CASE WHEN gmp_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of GMP certified sites, regulatory capability indicator"
    - name: "environmentally_compliant_sites"
      expr: SUM(CASE WHEN environmental_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of environmentally compliant sites, sustainability indicator"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with manufacturing presence, geographic diversification indicator"
    - name: "distinct_regions"
      expr: COUNT(DISTINCT region)
      comment: "Number of distinct regions with manufacturing presence"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`manufacturing_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity and utilization metrics for genomics manufacturing, tracking bottlenecks and operational efficiency"
  source: "`genomics_biotech_ecm`.`manufacturing`.`work_center`"
  dimensions:
    - name: "work_center_status"
      expr: work_center_status
      comment: "Current operational status of the work center"
    - name: "work_center_category"
      expr: work_center_category
      comment: "Category of work center (e.g., sequencing, library prep, QC)"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification of the work center"
    - name: "is_bottleneck"
      expr: is_bottleneck
      comment: "Indicates whether work center is identified as a production bottleneck"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the work center for GMP operations"
    - name: "environmental_monitoring_zone"
      expr: environmental_monitoring_zone
      comment: "Environmental monitoring zone classification"
    - name: "requires_batch_record"
      expr: requires_batch_record
      comment: "Indicates whether work center requires batch record documentation"
    - name: "allows_overlapping_operations"
      expr: allows_overlapping_operations
      comment: "Indicates whether work center allows overlapping operations"
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers in the manufacturing network"
    - name: "total_available_capacity_hours_per_day"
      expr: SUM(CAST(available_capacity_hours_per_day AS DOUBLE))
      comment: "Total available capacity hours per day across all work centers, capacity planning metric"
    - name: "avg_utilization_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate across work centers, operational efficiency KPI"
    - name: "avg_efficiency_factor_percent"
      expr: AVG(CAST(efficiency_factor_percent AS DOUBLE))
      comment: "Average efficiency factor across work centers, productivity indicator"
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time per work center, changeover efficiency indicator"
    - name: "avg_processing_time_per_unit_minutes"
      expr: AVG(CAST(processing_time_per_unit_minutes AS DOUBLE))
      comment: "Average processing time per unit, throughput indicator"
    - name: "avg_queue_time_minutes"
      expr: AVG(CAST(queue_time_minutes AS DOUBLE))
      comment: "Average queue time, flow efficiency indicator"
    - name: "bottleneck_work_centers"
      expr: SUM(CASE WHEN is_bottleneck = TRUE THEN 1 ELSE 0 END)
      comment: "Number of work centers identified as bottlenecks, capacity constraint indicator"
    - name: "work_centers_requiring_batch_record"
      expr: SUM(CASE WHEN requires_batch_record = TRUE THEN 1 ELSE 0 END)
      comment: "Number of work centers requiring batch record documentation, GMP scope indicator"
    - name: "distinct_sites"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of distinct sites containing work centers"
    - name: "distinct_work_center_categories"
      expr: COUNT(DISTINCT work_center_category)
      comment: "Number of distinct work center categories, process diversity indicator"
$$;
