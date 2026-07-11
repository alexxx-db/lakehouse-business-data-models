-- Metric views for domain: service | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:39:56

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_field_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core field service execution metrics tracking labor, parts, travel costs, service delivery performance, and operational efficiency for field service orders."
  source: "`vibe_manufacturing_v1`.`service`.`field_service_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of field service order (e.g., preventive maintenance, corrective repair, installation)"
    - name: "service_category"
      expr: service_category
      comment: "Category of service work performed"
    - name: "priority"
      expr: priority
      comment: "Priority level of the service order"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the field service order"
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the service order"
    - name: "outcome_code"
      expr: outcome_code
      comment: "Outcome code indicating result of service work"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the service issue"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the service order is covered under warranty"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month when the service order was scheduled to start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when the service order actually started"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month when the service order was requested"
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total number of field service orders"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all field service orders"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost across all field service orders"
    - name: "total_travel_cost"
      expr: SUM(CAST(travel_cost AS DOUBLE))
      comment: "Total travel cost across all field service orders"
    - name: "total_net_revenue"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net revenue from field service orders"
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross revenue from field service orders"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed across all field service orders"
    - name: "total_travel_hours"
      expr: SUM(CAST(travel_hours AS DOUBLE))
      comment: "Total travel hours consumed across all field service orders"
    - name: "total_travel_distance_km"
      expr: SUM(CAST(travel_distance_km AS DOUBLE))
      comment: "Total travel distance in kilometers across all field service orders"
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per field service order"
    - name: "avg_labor_cost_per_order"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per field service order"
    - name: "avg_parts_cost_per_order"
      expr: AVG(CAST(parts_cost AS DOUBLE))
      comment: "Average parts cost per field service order"
    - name: "avg_travel_cost_per_order"
      expr: AVG(CAST(travel_cost AS DOUBLE))
      comment: "Average travel cost per field service order"
    - name: "avg_net_revenue_per_order"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net revenue per field service order"
    - name: "warranty_order_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Count of field service orders covered under warranty"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service request performance metrics tracking request volume, resolution efficiency, SLA compliance, cost, and customer service quality."
  source: "`vibe_manufacturing_v1`.`service`.`request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of service request"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request"
    - name: "priority"
      expr: priority
      comment: "Priority level of the service request"
    - name: "service_category"
      expr: service_category
      comment: "Category of service requested"
    - name: "channel"
      expr: channel
      comment: "Channel through which the service request was submitted"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the service request"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause identified for the service request"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the service request is covered under warranty"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier applicable to the service request"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the service request was created"
    - name: "closed_month"
      expr: DATE_TRUNC('MONTH', closed_timestamp)
      comment: "Month when the service request was closed"
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for service requests"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for service requests"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost for service requests"
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per service request"
    - name: "avg_estimated_cost_per_request"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per service request"
    - name: "total_travel_distance_km"
      expr: SUM(CAST(travel_distance_km AS DOUBLE))
      comment: "Total travel distance in kilometers for service requests"
    - name: "avg_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance in kilometers per service request"
    - name: "warranty_request_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Count of service requests covered under warranty"
    - name: "closed_request_count"
      expr: COUNT(CASE WHEN closed_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of service requests that have been closed"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract financial and performance metrics tracking contract value, renewal rates, coverage scope, and SLA commitments."
  source: "`vibe_manufacturing_v1`.`service`.`service_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of service contract"
    - name: "contract_category"
      expr: contract_category
      comment: "Category of service contract"
    - name: "service_contract_status"
      expr: service_contract_status
      comment: "Current status of the service contract"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier level of the contract"
    - name: "coverage_scope"
      expr: coverage_scope
      comment: "Scope of coverage provided by the contract"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the service contract"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract has auto-renewal enabled"
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the contract is a renewal"
    - name: "warranty_included_flag"
      expr: warranty_included_flag
      comment: "Indicates whether warranty is included in the contract"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the contract"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the contract became effective"
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month when the contract is set to end"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of service contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total gross contract value across all service contracts"
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after discounts across all service contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average gross contract value per service contract"
    - name: "avg_net_contract_value"
      expr: AVG(CAST(net_contract_value AS DOUBLE))
      comment: "Average net contract value per service contract"
    - name: "avg_discount_rate_percent"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Average discount rate percentage across service contracts"
    - name: "avg_uptime_guarantee_percent"
      expr: AVG(CAST(uptime_guarantee_percent AS DOUBLE))
      comment: "Average uptime guarantee percentage across service contracts"
    - name: "avg_response_time_target_hours"
      expr: AVG(CAST(response_time_target_hours AS DOUBLE))
      comment: "Average response time target in hours across service contracts"
    - name: "avg_resolution_time_target_hours"
      expr: AVG(CAST(resolution_time_target_hours AS DOUBLE))
      comment: "Average resolution time target in hours across service contracts"
    - name: "renewal_contract_count"
      expr: COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END)
      comment: "Count of service contracts that are renewals"
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Count of service contracts with auto-renewal enabled"
    - name: "warranty_included_contract_count"
      expr: COUNT(CASE WHEN warranty_included_flag = TRUE THEN 1 END)
      comment: "Count of service contracts that include warranty coverage"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_installed_base`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Installed base asset performance and reliability metrics tracking equipment health, maintenance cycles, uptime, and operational effectiveness."
  source: "`vibe_manufacturing_v1`.`service`.`installed_base`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the installed asset"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance applied to the asset"
    - name: "installation_method"
      expr: installation_method
      comment: "Method used for asset installation"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the asset is installed"
    - name: "state"
      expr: state
      comment: "State or province where the asset is installed"
    - name: "city"
      expr: city
      comment: "City where the asset is installed"
    - name: "installation_month"
      expr: DATE_TRUNC('MONTH', installation_date)
      comment: "Month when the asset was installed"
    - name: "last_service_month"
      expr: DATE_TRUNC('MONTH', last_service_date)
      comment: "Month when the asset was last serviced"
    - name: "next_maintenance_month"
      expr: DATE_TRUNC('MONTH', next_maintenance_date)
      comment: "Month when the asset is scheduled for next maintenance"
  measures:
    - name: "total_installed_assets"
      expr: COUNT(1)
      comment: "Total number of installed base assets"
    - name: "total_capacity_kw"
      expr: SUM(CAST(capacity_kw AS DOUBLE))
      comment: "Total capacity in kilowatts across all installed assets"
    - name: "avg_capacity_kw"
      expr: AVG(CAST(capacity_kw AS DOUBLE))
      comment: "Average capacity in kilowatts per installed asset"
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total power rating in kilowatts across all installed assets"
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating in kilowatts per installed asset"
    - name: "avg_oee_percent"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average overall equipment effectiveness (OEE) percentage across installed assets"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average mean time between failures (MTBF) in hours across installed assets"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average mean time to repair (MTTR) in hours across installed assets"
    - name: "avg_voltage"
      expr: AVG(CAST(voltage AS DOUBLE))
      comment: "Average voltage across installed assets"
    - name: "avg_current"
      expr: AVG(CAST(current AS DOUBLE))
      comment: "Average current across installed assets"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_part_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts consumption and fulfillment metrics tracking spare parts usage, costs, delivery performance, and warranty coverage for service operations."
  source: "`vibe_manufacturing_v1`.`service`.`part_consumption`"
  dimensions:
    - name: "source_type"
      expr: source_type
      comment: "Source type of the part consumption (e.g., stock, emergency procurement)"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the part consumption"
    - name: "order_urgency"
      expr: order_urgency
      comment: "Urgency level of the part order"
    - name: "contract_coverage_flag"
      expr: contract_coverage_flag
      comment: "Indicates whether the part consumption is covered under a service contract"
    - name: "warranty_coverage_flag"
      expr: warranty_coverage_flag
      comment: "Indicates whether the part consumption is covered under warranty"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the consumed part"
    - name: "consumption_month"
      expr: DATE_TRUNC('MONTH', consumption_timestamp)
      comment: "Month when the part was consumed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month when the part order was placed"
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month when the part was actually delivered"
  measures:
    - name: "total_part_consumption_records"
      expr: COUNT(1)
      comment: "Total number of part consumption records"
    - name: "total_part_cost"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total cost of parts consumed across all service operations"
    - name: "avg_part_cost_per_consumption"
      expr: AVG(CAST(line_total_amount AS DOUBLE))
      comment: "Average cost per part consumption record"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of consumed parts"
    - name: "contract_covered_consumption_count"
      expr: COUNT(CASE WHEN contract_coverage_flag = TRUE THEN 1 END)
      comment: "Count of part consumptions covered under service contracts"
    - name: "warranty_covered_consumption_count"
      expr: COUNT(CASE WHEN warranty_coverage_flag = TRUE THEN 1 END)
      comment: "Count of part consumptions covered under warranty"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_engineer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service engineer workforce metrics tracking utilization, skills, certifications, labor rates, and resource availability for field service operations."
  source: "`vibe_manufacturing_v1`.`service`.`engineer`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the service engineer"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type of the service engineer"
    - name: "labor_classification"
      expr: labor_classification
      comment: "Labor classification of the service engineer"
    - name: "service_region"
      expr: service_region
      comment: "Service region assigned to the engineer"
    - name: "dispatch_zone"
      expr: dispatch_zone
      comment: "Dispatch zone assigned to the engineer"
    - name: "shift_preference"
      expr: shift_preference
      comment: "Shift preference of the service engineer"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the service engineer"
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level of the service engineer"
    - name: "product_family_competency"
      expr: product_family_competency
      comment: "Product family competency of the service engineer"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the engineer is eligible for overtime"
    - name: "travel_eligibility"
      expr: travel_eligibility
      comment: "Indicates whether the engineer is eligible for travel assignments"
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates whether the engineer is a union member"
    - name: "skill_plc_certified"
      expr: skill_plc_certified
      comment: "Indicates whether the engineer is PLC certified"
    - name: "skill_robotics_certified"
      expr: skill_robotics_certified
      comment: "Indicates whether the engineer is robotics certified"
    - name: "skill_scada_certified"
      expr: skill_scada_certified
      comment: "Indicates whether the engineer is SCADA certified"
    - name: "skill_hmi_certified"
      expr: skill_hmi_certified
      comment: "Indicates whether the engineer is HMI certified"
    - name: "skill_drive_systems_certified"
      expr: skill_drive_systems_certified
      comment: "Indicates whether the engineer is drive systems certified"
    - name: "skill_electrification_certified"
      expr: skill_electrification_certified
      comment: "Indicates whether the engineer is electrification certified"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month when the engineer was hired"
  measures:
    - name: "total_engineers"
      expr: COUNT(1)
      comment: "Total number of service engineers"
    - name: "avg_labor_rate_hourly"
      expr: AVG(CAST(labor_rate_hourly AS DOUBLE))
      comment: "Average hourly labor rate across service engineers"
    - name: "plc_certified_engineer_count"
      expr: COUNT(CASE WHEN skill_plc_certified = TRUE THEN 1 END)
      comment: "Count of engineers certified in PLC systems"
    - name: "robotics_certified_engineer_count"
      expr: COUNT(CASE WHEN skill_robotics_certified = TRUE THEN 1 END)
      comment: "Count of engineers certified in robotics"
    - name: "scada_certified_engineer_count"
      expr: COUNT(CASE WHEN skill_scada_certified = TRUE THEN 1 END)
      comment: "Count of engineers certified in SCADA systems"
    - name: "hmi_certified_engineer_count"
      expr: COUNT(CASE WHEN skill_hmi_certified = TRUE THEN 1 END)
      comment: "Count of engineers certified in HMI systems"
    - name: "drive_systems_certified_engineer_count"
      expr: COUNT(CASE WHEN skill_drive_systems_certified = TRUE THEN 1 END)
      comment: "Count of engineers certified in drive systems"
    - name: "electrification_certified_engineer_count"
      expr: COUNT(CASE WHEN skill_electrification_certified = TRUE THEN 1 END)
      comment: "Count of engineers certified in electrification"
    - name: "overtime_eligible_engineer_count"
      expr: COUNT(CASE WHEN overtime_eligible = TRUE THEN 1 END)
      comment: "Count of engineers eligible for overtime"
    - name: "travel_eligible_engineer_count"
      expr: COUNT(CASE WHEN travel_eligibility = TRUE THEN 1 END)
      comment: "Count of engineers eligible for travel assignments"
    - name: "union_member_engineer_count"
      expr: COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END)
      comment: "Count of engineers who are union members"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty coverage and claims metrics tracking warranty status, coverage scope, claims activity, and transferability for products and equipment."
  source: "`vibe_manufacturing_v1`.`service`.`warranty`"
  dimensions:
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the warranty"
    - name: "registration_status"
      expr: registration_status
      comment: "Registration status of the warranty"
    - name: "service_level"
      expr: service_level
      comment: "Service level provided under the warranty"
    - name: "coverage_scope"
      expr: coverage_scope
      comment: "Scope of coverage provided by the warranty"
    - name: "claims_allowed_flag"
      expr: claims_allowed_flag
      comment: "Indicates whether claims are allowed under the warranty"
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the warranty is renewable"
    - name: "transferability_flag"
      expr: transferability_flag
      comment: "Indicates whether the warranty is transferable to another owner"
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when the warranty became effective"
    - name: "effective_until_month"
      expr: DATE_TRUNC('MONTH', effective_until)
      comment: "Month when the warranty expires"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month when the warranty was registered"
  measures:
    - name: "total_warranties"
      expr: COUNT(1)
      comment: "Total number of warranties"
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total coverage amount across all warranties"
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average coverage amount per warranty"
    - name: "claims_allowed_warranty_count"
      expr: COUNT(CASE WHEN claims_allowed_flag = TRUE THEN 1 END)
      comment: "Count of warranties that allow claims"
    - name: "renewable_warranty_count"
      expr: COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END)
      comment: "Count of warranties that are renewable"
    - name: "transferable_warranty_count"
      expr: COUNT(CASE WHEN transferability_flag = TRUE THEN 1 END)
      comment: "Count of warranties that are transferable"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service entitlement and SLA performance metrics tracking response times, resolution times, breach rates, and service level compliance."
  source: "`vibe_manufacturing_v1`.`service`.`entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of service entitlement"
    - name: "service_entitlement_status"
      expr: service_entitlement_status
      comment: "Current status of the service entitlement"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Level of coverage provided by the entitlement"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level associated with the entitlement"
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel through which the entitlement is delivered"
    - name: "business_hours_coverage"
      expr: business_hours_coverage
      comment: "Indicates whether the entitlement covers business hours only"
    - name: "acknowledgment_breach_flag"
      expr: acknowledgment_breach_flag
      comment: "Indicates whether the acknowledgment SLA was breached"
    - name: "first_response_breach_flag"
      expr: first_response_breach_flag
      comment: "Indicates whether the first response SLA was breached"
    - name: "resolution_breach_flag"
      expr: resolution_breach_flag
      comment: "Indicates whether the resolution SLA was breached"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the entitlement became effective"
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month when the entitlement expires"
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total number of service entitlements"
    - name: "acknowledgment_breach_count"
      expr: COUNT(CASE WHEN acknowledgment_breach_flag = TRUE THEN 1 END)
      comment: "Count of entitlements with acknowledgment SLA breaches"
    - name: "first_response_breach_count"
      expr: COUNT(CASE WHEN first_response_breach_flag = TRUE THEN 1 END)
      comment: "Count of entitlements with first response SLA breaches"
    - name: "resolution_breach_count"
      expr: COUNT(CASE WHEN resolution_breach_flag = TRUE THEN 1 END)
      comment: "Count of entitlements with resolution SLA breaches"
$$;