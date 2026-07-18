-- Metric views for domain: service | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_svc_instance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core service instance metrics tracking active services, revenue-generating capacity, technology mix, and lifecycle performance across subscriber base"
  source: "`telecommunication_ecm`.`service`.`svc_instance`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service (mobile, broadband, fiber, enterprise, IoT)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle state (active, suspended, terminated, pending)"
    - name: "technology_type"
      expr: technology_type
      comment: "Underlying technology (5G, LTE, fiber, DSL, satellite)"
    - name: "service_class"
      expr: service_class
      comment: "Service tier or class (premium, standard, basic)"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_timestamp)
      comment: "Month when service was activated"
    - name: "service_start_month"
      expr: DATE_TRUNC('MONTH', service_start_date)
      comment: "Month when service contract started"
    - name: "roaming_enabled_flag"
      expr: roaming_enabled
      comment: "Whether roaming is enabled for this service"
    - name: "volte_enabled_flag"
      expr: volte_enabled
      comment: "Whether VoLTE is enabled"
    - name: "ims_registered_flag"
      expr: ims_registered
      comment: "Whether service is registered on IMS network"
    - name: "auto_renew_flag"
      expr: auto_renew
      comment: "Whether service is set to auto-renew"
  measures:
    - name: "total_active_services"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN 1 END)
      comment: "Count of services currently in active status - primary capacity metric"
    - name: "total_services"
      expr: COUNT(1)
      comment: "Total count of all service instances regardless of status"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with services - customer base size"
    - name: "total_provisioned_bandwidth_mbps"
      expr: SUM(CAST(bandwidth_mbps AS DOUBLE))
      comment: "Total bandwidth capacity provisioned across all services in Mbps"
    - name: "avg_bandwidth_per_service_mbps"
      expr: AVG(CAST(bandwidth_mbps AS DOUBLE))
      comment: "Average bandwidth allocation per service instance"
    - name: "total_data_allowance_gb"
      expr: SUM(CAST(data_allowance_gb AS DOUBLE))
      comment: "Total data allowance provisioned across all services in GB"
    - name: "avg_data_allowance_per_service_gb"
      expr: AVG(CAST(data_allowance_gb AS DOUBLE))
      comment: "Average data allowance per service instance"
    - name: "volte_adoption_count"
      expr: COUNT(CASE WHEN volte_enabled = TRUE THEN 1 END)
      comment: "Count of services with VoLTE enabled - technology adoption metric"
    - name: "roaming_enabled_count"
      expr: COUNT(CASE WHEN roaming_enabled = TRUE THEN 1 END)
      comment: "Count of services with roaming capability enabled"
    - name: "ims_registered_count"
      expr: COUNT(CASE WHEN ims_registered = TRUE THEN 1 END)
      comment: "Count of services successfully registered on IMS network"
    - name: "auto_renew_count"
      expr: COUNT(CASE WHEN auto_renew = TRUE THEN 1 END)
      comment: "Count of services set to auto-renew - retention indicator"
    - name: "suspended_services"
      expr: COUNT(CASE WHEN lifecycle_status = 'suspended' THEN 1 END)
      comment: "Count of services currently suspended - risk metric"
    - name: "terminated_services"
      expr: COUNT(CASE WHEN lifecycle_status = 'terminated' THEN 1 END)
      comment: "Count of terminated services - churn metric"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_activation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service activation performance metrics tracking provisioning success rates, SLA compliance, technology deployment efficiency, and network quality"
  source: "`telecommunication_ecm`.`service`.`activation_event`"
  dimensions:
    - name: "activation_status"
      expr: activation_status
      comment: "Outcome status of activation attempt (success, failed, pending, retry)"
    - name: "activation_method"
      expr: activation_method
      comment: "Method used for activation (auto, manual, remote, onsite)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being activated"
    - name: "service_category"
      expr: service_category
      comment: "Category of service (consumer, business, enterprise)"
    - name: "network_technology"
      expr: network_technology
      comment: "Network technology used (5G, LTE, fiber, etc.)"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_timestamp)
      comment: "Month when activation occurred"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether activation met SLA target time"
    - name: "fallback_activation_flag"
      expr: fallback_activation_flag
      comment: "Whether fallback activation method was used"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether activation requires regulatory reporting"
    - name: "volte_registration_status"
      expr: volte_registration_status
      comment: "Status of VoLTE registration during activation"
    - name: "esim_profile_download_status"
      expr: esim_profile_download_status
      comment: "Status of eSIM profile download for eSIM activations"
  measures:
    - name: "total_activation_attempts"
      expr: COUNT(1)
      comment: "Total number of activation attempts - volume metric"
    - name: "successful_activations"
      expr: COUNT(CASE WHEN activation_status = 'success' THEN 1 END)
      comment: "Count of successful activations - primary success metric"
    - name: "failed_activations"
      expr: COUNT(CASE WHEN activation_status = 'failed' THEN 1 END)
      comment: "Count of failed activations - quality issue indicator"
    - name: "sla_compliant_activations"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Count of activations meeting SLA target time - service quality metric"
    - name: "fallback_activations"
      expr: COUNT(CASE WHEN fallback_activation_flag = TRUE THEN 1 END)
      comment: "Count of activations requiring fallback method - process efficiency indicator"
    - name: "total_bandwidth_activated_mbps"
      expr: SUM(CAST(bandwidth_allocated_mbps AS DOUBLE))
      comment: "Total bandwidth capacity activated in Mbps - network capacity metric"
    - name: "avg_bandwidth_per_activation_mbps"
      expr: AVG(CAST(bandwidth_allocated_mbps AS DOUBLE))
      comment: "Average bandwidth allocated per activation"
    - name: "unique_subscribers_activated"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with activation events - customer acquisition metric"
    - name: "unique_network_elements_used"
      expr: COUNT(DISTINCT element_id)
      comment: "Distinct count of network elements involved in activations - infrastructure utilization"
    - name: "regulatory_reportable_activations"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of activations requiring regulatory reporting - compliance metric"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_provisioning_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provisioning order execution metrics tracking fulfillment efficiency, SLA compliance, fallout rates, and operational quality across service types"
  source: "`telecommunication_ecm`.`service`.`provisioning_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of provisioning order (completed, in_progress, failed, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of provisioning order (new, change, disconnect, upgrade)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being provisioned"
    - name: "network_domain"
      expr: network_domain
      comment: "Network domain for provisioning (access, core, transport)"
    - name: "orchestration_state"
      expr: orchestration_state
      comment: "Current state in orchestration workflow"
    - name: "priority"
      expr: priority
      comment: "Priority level of provisioning order (urgent, high, normal, low)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Status of service qualification check"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether order met SLA target completion time"
    - name: "fallout_flag"
      expr: fallout_flag
      comment: "Whether order fell out of automated processing"
    - name: "mnp_port_type"
      expr: mnp_port_type
      comment: "Type of mobile number portability (port-in, port-out, internal)"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when provisioning order was created"
    - name: "requested_activation_month"
      expr: DATE_TRUNC('MONTH', requested_activation_date)
      comment: "Month when activation was requested"
  measures:
    - name: "total_provisioning_orders"
      expr: COUNT(1)
      comment: "Total count of provisioning orders - volume metric"
    - name: "completed_orders"
      expr: COUNT(CASE WHEN order_status = 'completed' THEN 1 END)
      comment: "Count of successfully completed orders - primary success metric"
    - name: "failed_orders"
      expr: COUNT(CASE WHEN order_status = 'failed' THEN 1 END)
      comment: "Count of failed orders - quality issue indicator"
    - name: "in_progress_orders"
      expr: COUNT(CASE WHEN order_status = 'in_progress' THEN 1 END)
      comment: "Count of orders currently in progress - work in process metric"
    - name: "sla_compliant_orders"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Count of orders meeting SLA target - service quality metric"
    - name: "fallout_orders"
      expr: COUNT(CASE WHEN fallout_flag = TRUE THEN 1 END)
      comment: "Count of orders requiring manual intervention - automation efficiency metric"
    - name: "unique_subscribers_provisioned"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with provisioning orders"
    - name: "unique_technicians_assigned"
      expr: COUNT(DISTINCT technician_id)
      comment: "Distinct count of technicians assigned to orders - workforce utilization"
    - name: "high_priority_orders"
      expr: COUNT(CASE WHEN priority IN ('urgent', 'high') THEN 1 END)
      comment: "Count of high-priority orders requiring expedited handling"
    - name: "mnp_port_orders"
      expr: COUNT(CASE WHEN mnp_port_type IS NOT NULL THEN 1 END)
      comment: "Count of orders involving mobile number portability"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_svc_suspension`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service suspension and reinstatement metrics tracking churn risk, revenue recovery, regulatory compliance, and customer retention effectiveness"
  source: "`telecommunication_ecm`.`service`.`svc_suspension`"
  dimensions:
    - name: "suspension_status"
      expr: suspension_status
      comment: "Current status of suspension (active, reinstated, permanent)"
    - name: "suspension_type"
      expr: suspension_type
      comment: "Type of suspension (voluntary, involuntary, regulatory, fraud)"
    - name: "suspension_reason_code"
      expr: suspension_reason_code
      comment: "Coded reason for suspension (non-payment, customer request, fraud, etc.)"
    - name: "initiated_channel"
      expr: initiated_channel
      comment: "Channel through which suspension was initiated"
    - name: "reinstatement_condition"
      expr: reinstatement_condition
      comment: "Condition required for reinstatement (payment, verification, etc.)"
    - name: "suspension_start_month"
      expr: DATE_TRUNC('MONTH', suspension_start_date)
      comment: "Month when suspension started"
    - name: "auto_reinstatement_enabled_flag"
      expr: auto_reinstatement_enabled
      comment: "Whether automatic reinstatement is enabled"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether suspension follows regulatory requirements"
    - name: "billing_impact_flag"
      expr: billing_impact_flag
      comment: "Whether suspension impacts billing"
    - name: "network_suspension_applied_flag"
      expr: network_suspension_applied
      comment: "Whether network-level suspension was applied"
    - name: "reinstatement_condition_met_flag"
      expr: reinstatement_condition_met
      comment: "Whether reinstatement condition has been satisfied"
  measures:
    - name: "total_suspensions"
      expr: COUNT(1)
      comment: "Total count of service suspensions - churn risk volume"
    - name: "active_suspensions"
      expr: COUNT(CASE WHEN suspension_status = 'active' THEN 1 END)
      comment: "Count of currently active suspensions - at-risk revenue metric"
    - name: "reinstated_services"
      expr: COUNT(CASE WHEN suspension_status = 'reinstated' THEN 1 END)
      comment: "Count of successfully reinstated services - recovery success metric"
    - name: "permanent_suspensions"
      expr: COUNT(CASE WHEN suspension_status = 'permanent' THEN 1 END)
      comment: "Count of permanent suspensions - churn realization metric"
    - name: "total_suspension_fees"
      expr: SUM(CAST(suspension_fee_amount AS DOUBLE))
      comment: "Total suspension fees charged - revenue impact"
    - name: "total_reinstatement_fees"
      expr: SUM(CAST(reinstatement_fee_amount AS DOUBLE))
      comment: "Total reinstatement fees collected - recovery revenue"
    - name: "total_prorated_charges"
      expr: SUM(CAST(prorated_charge_amount AS DOUBLE))
      comment: "Total prorated charges during suspension period"
    - name: "avg_suspension_fee"
      expr: AVG(CAST(suspension_fee_amount AS DOUBLE))
      comment: "Average suspension fee per suspension event"
    - name: "avg_reinstatement_fee"
      expr: AVG(CAST(reinstatement_fee_amount AS DOUBLE))
      comment: "Average reinstatement fee per reinstatement"
    - name: "unique_suspended_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with suspensions - at-risk customer base"
    - name: "conditions_met_count"
      expr: COUNT(CASE WHEN reinstatement_condition_met = TRUE THEN 1 END)
      comment: "Count of suspensions where reinstatement condition was met - recovery opportunity"
    - name: "regulatory_compliant_suspensions"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of suspensions meeting regulatory requirements - compliance metric"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_svc_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service lifecycle transition metrics tracking status changes, churn patterns, SLA compliance, and operational efficiency across service portfolio"
  source: "`telecommunication_ecm`.`service`.`svc_status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "Status transitioned to"
    - name: "previous_status"
      expr: previous_status
      comment: "Status transitioned from"
    - name: "transition_reason_code"
      expr: transition_reason_code
      comment: "Coded reason for status transition"
    - name: "service_type"
      expr: service_type
      comment: "Type of service undergoing transition"
    - name: "service_technology"
      expr: service_technology
      comment: "Technology of service (5G, fiber, etc.)"
    - name: "churn_category"
      expr: churn_category
      comment: "Category of churn if applicable (voluntary, involuntary, competitive)"
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month when status transition occurred"
    - name: "churn_indicator_flag"
      expr: churn_indicator_flag
      comment: "Whether transition represents a churn event"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether transition breached SLA target"
    - name: "win_back_eligible_flag"
      expr: win_back_eligible_flag
      comment: "Whether customer is eligible for win-back campaign"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether transition followed regulatory requirements"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for transition (approved, pending, rejected)"
  measures:
    - name: "total_status_transitions"
      expr: COUNT(1)
      comment: "Total count of service status transitions - lifecycle activity volume"
    - name: "churn_events"
      expr: COUNT(CASE WHEN churn_indicator_flag = TRUE THEN 1 END)
      comment: "Count of transitions representing churn - primary churn metric"
    - name: "sla_breaches"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of transitions that breached SLA - service quality issue metric"
    - name: "win_back_eligible_customers"
      expr: COUNT(CASE WHEN win_back_eligible_flag = TRUE THEN 1 END)
      comment: "Count of transitions eligible for win-back - retention opportunity metric"
    - name: "regulatory_compliant_transitions"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of transitions meeting regulatory requirements - compliance metric"
    - name: "unique_services_transitioned"
      expr: COUNT(DISTINCT svc_instance_id)
      comment: "Distinct count of service instances with status changes"
    - name: "unique_subscribers_affected"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with service transitions"
    - name: "approved_transitions"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved status transitions"
    - name: "pending_approval_transitions"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Count of transitions pending approval - workflow backlog metric"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_number_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Number resource management metrics tracking MSISDN inventory utilization, portability activity, regulatory compliance, and number lifecycle efficiency"
  source: "`telecommunication_ecm`.`service`.`number_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of number assignment (active, reserved, quarantined, released)"
    - name: "number_type"
      expr: number_type
      comment: "Type of number (mobile, fixed, toll-free, premium)"
    - name: "number_category"
      expr: number_category
      comment: "Category of number (geographic, non-geographic, special)"
    - name: "number_usage_type"
      expr: number_usage_type
      comment: "Usage type (voice, data, IoT, M2M)"
    - name: "porting_status"
      expr: porting_status
      comment: "Status of number portability process"
    - name: "porting_direction"
      expr: porting_direction
      comment: "Direction of port (port-in, port-out, internal)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of number"
    - name: "area_code"
      expr: area_code
      comment: "Area or region code"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month when number was assigned"
    - name: "vanity_number_flag"
      expr: vanity_number_flag
      comment: "Whether number is a vanity/premium number"
    - name: "emergency_services_enabled_flag"
      expr: emergency_services_enabled
      comment: "Whether emergency services are enabled"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether assignment requires regulatory reporting"
    - name: "do_not_call_registry_flag"
      expr: do_not_call_registry_flag
      comment: "Whether number is on do-not-call registry"
  measures:
    - name: "total_number_assignments"
      expr: COUNT(1)
      comment: "Total count of number assignments - inventory utilization metric"
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'active' THEN 1 END)
      comment: "Count of actively assigned numbers - in-use inventory"
    - name: "reserved_numbers"
      expr: COUNT(CASE WHEN assignment_status = 'reserved' THEN 1 END)
      comment: "Count of reserved numbers - pending inventory"
    - name: "quarantined_numbers"
      expr: COUNT(CASE WHEN assignment_status = 'quarantined' THEN 1 END)
      comment: "Count of quarantined numbers - unavailable inventory"
    - name: "released_numbers"
      expr: COUNT(CASE WHEN assignment_status = 'released' THEN 1 END)
      comment: "Count of released numbers - churn indicator"
    - name: "port_in_count"
      expr: COUNT(CASE WHEN porting_direction = 'port-in' THEN 1 END)
      comment: "Count of numbers ported in - customer acquisition metric"
    - name: "port_out_count"
      expr: COUNT(CASE WHEN porting_direction = 'port-out' THEN 1 END)
      comment: "Count of numbers ported out - churn metric"
    - name: "vanity_numbers_assigned"
      expr: COUNT(CASE WHEN vanity_number_flag = TRUE THEN 1 END)
      comment: "Count of vanity/premium numbers assigned - premium service metric"
    - name: "emergency_enabled_numbers"
      expr: COUNT(CASE WHEN emergency_services_enabled = TRUE THEN 1 END)
      comment: "Count of numbers with emergency services enabled - regulatory compliance metric"
    - name: "unique_subscribers_with_numbers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with number assignments"
    - name: "regulatory_reportable_assignments"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of assignments requiring regulatory reporting - compliance metric"
    - name: "do_not_call_registered_numbers"
      expr: COUNT(CASE WHEN do_not_call_registry_flag = TRUE THEN 1 END)
      comment: "Count of numbers on do-not-call registry - marketing constraint metric"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_sla_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA profile and service quality commitment metrics tracking performance targets, credit eligibility, and enterprise service level agreements"
  source: "`telecommunication_ecm`.`service`.`sla_profile`"
  dimensions:
    - name: "profile_tier"
      expr: profile_tier
      comment: "SLA tier level (platinum, gold, silver, bronze)"
    - name: "service_class"
      expr: service_class
      comment: "Class of service covered by SLA"
    - name: "network_technology"
      expr: network_technology
      comment: "Network technology covered (5G, fiber, etc.)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of SLA (national, regional, global)"
    - name: "sla_profile_status"
      expr: sla_profile_status
      comment: "Current status of SLA profile (active, expired, draft)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of SLA profile"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for support and resolution"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when SLA profile became effective"
    - name: "credit_eligible_flag"
      expr: credit_eligible
      comment: "Whether SLA breaches are eligible for service credits"
    - name: "proactive_monitoring_enabled_flag"
      expr: proactive_monitoring_enabled
      comment: "Whether proactive monitoring is enabled"
    - name: "dedicated_support_team_flag"
      expr: dedicated_support_team
      comment: "Whether dedicated support team is assigned"
  measures:
    - name: "total_sla_profiles"
      expr: COUNT(1)
      comment: "Total count of SLA profiles - service commitment portfolio size"
    - name: "active_sla_profiles"
      expr: COUNT(CASE WHEN sla_profile_status = 'active' THEN 1 END)
      comment: "Count of currently active SLA profiles"
    - name: "credit_eligible_profiles"
      expr: COUNT(CASE WHEN credit_eligible = TRUE THEN 1 END)
      comment: "Count of profiles with service credit eligibility - financial risk metric"
    - name: "proactive_monitoring_profiles"
      expr: COUNT(CASE WHEN proactive_monitoring_enabled = TRUE THEN 1 END)
      comment: "Count of profiles with proactive monitoring - premium service metric"
    - name: "dedicated_support_profiles"
      expr: COUNT(CASE WHEN dedicated_support_team = TRUE THEN 1 END)
      comment: "Count of profiles with dedicated support teams - resource allocation metric"
    - name: "avg_uptime_target_pct"
      expr: AVG(CAST(uptime_percentage_target AS DOUBLE))
      comment: "Average uptime percentage target across SLA profiles"
    - name: "avg_packet_loss_limit_pct"
      expr: AVG(CAST(packet_loss_limit_percentage AS DOUBLE))
      comment: "Average packet loss limit percentage across profiles"
$$;
