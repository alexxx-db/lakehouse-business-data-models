-- Metric views for domain: service | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`service_case_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks service case volume, throughput, and workload distribution across channels, priorities, and case types. Supports operational staffing decisions and SLA governance."
  source: "`vibe_retail_v1`.`service`.`service_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Category of service case (e.g. complaint, inquiry, return, technical support) used to route and prioritise workload."
    - name: "case_status"
      expr: case_status
      comment: "Current lifecycle state of the case (e.g. open, in-progress, resolved, closed) for pipeline visibility."
    - name: "channel"
      expr: channel
      comment: "Contact channel through which the case was raised (e.g. email, phone, chat, in-store) for channel-mix analysis."
    - name: "priority"
      expr: priority
      comment: "Assigned urgency level of the case (e.g. low, medium, high, critical) for workload triage."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team or queue currently responsible for the case, used for capacity and backlog reporting."
    - name: "case_owner_type"
      expr: case_owner_type
      comment: "Indicates whether the case is owned by an agent, a team, or an automated process."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating whether the case has been escalated, used to measure escalation rate."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Boolean flag indicating whether the case breached its SLA target, used to measure SLA compliance."
    - name: "is_closed"
      expr: is_closed
      comment: "Boolean flag indicating whether the case is fully closed, used to separate open backlog from resolved cases."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Calendar date the case was created, used for daily volume trending."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Calendar month the case was created, used for monthly volume trending and capacity planning."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Standardised outcome code applied at case closure (e.g. refund_issued, replaced, no_action) for root-cause analysis."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of service cases in the selected period. Baseline volume KPI used in all service capacity and SLA dashboards."
    - name: "open_cases"
      expr: COUNT(CASE WHEN is_closed = FALSE THEN 1 END)
      comment: "Number of cases currently open (not yet closed). Tracks live backlog size for staffing and escalation decisions."
    - name: "closed_cases"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Number of cases that have been fully closed. Used to measure throughput and resolution capacity."
    - name: "escalated_cases"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of cases that were escalated. High escalation counts signal systemic quality or staffing issues."
    - name: "sla_breached_cases"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of cases that breached their SLA target. Core compliance KPI for service-level governance."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that were escalated. Compound ratio KPI; rising escalation rate triggers investigation into agent capability or product quality."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that breached SLA. Primary SLA compliance KPI reported to operations leadership and vendor scorecards."
    - name: "case_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that are closed out of all cases in scope. Measures resolution throughput efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`service_case_resolution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures service case resolution speed, SLA adherence, and refund impact. Supports executive-level customer service quality reviews and cost-of-service analysis."
  source: "`vibe_retail_v1`.`service`.`service_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Category of service case used to compare resolution performance across case types."
    - name: "channel"
      expr: channel
      comment: "Contact channel through which the case was raised, used to compare resolution speed by channel."
    - name: "priority"
      expr: priority
      comment: "Urgency level of the case, used to validate that high-priority cases resolve faster."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for the case, used for team-level performance benchmarking."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Outcome code at closure, used to analyse which resolution types are most common and costly."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the case was escalated, used to compare resolution time for escalated vs non-escalated cases."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the case breached SLA, used to segment resolution metrics by compliance status."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which refund amounts are denominated, required for multi-currency refund analysis."
    - name: "closed_month"
      expr: DATE_TRUNC('month', closed_timestamp)
      comment: "Month the case was closed, used for monthly resolution trend analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the case was created, used to align resolution metrics to intake cohorts."
  measures:
    - name: "total_resolved_cases"
      expr: COUNT(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of cases with a recorded resolution timestamp. Baseline for all resolution-speed KPIs."
    - name: "avg_resolution_hours"
      expr: AVG(CASE WHEN resolution_timestamp IS NOT NULL AND created_timestamp IS NOT NULL THEN (UNIX_TIMESTAMP(resolution_timestamp) - UNIX_TIMESTAMP(created_timestamp)) / 3600.0 END)
      comment: "Average hours from case creation to resolution. Primary resolution-speed KPI; directly tied to customer satisfaction and SLA compliance."
    - name: "avg_first_response_hours"
      expr: AVG(CASE WHEN first_response_timestamp IS NOT NULL AND created_timestamp IS NOT NULL THEN (UNIX_TIMESTAMP(first_response_timestamp) - UNIX_TIMESTAMP(created_timestamp)) / 3600.0 END)
      comment: "Average hours from case creation to first agent response. Measures responsiveness; a leading indicator of customer satisfaction and SLA risk."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target (in hours) across cases in scope. Used to contextualise breach rates against the contracted service level."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total monetary value of refunds issued through service cases. Direct cost-of-service KPI used in P&L impact analysis and fraud monitoring."
    - name: "avg_refund_amount"
      expr: AVG(CASE WHEN refund_amount > 0 THEN CAST(refund_amount AS DOUBLE) END)
      comment: "Average refund amount per case where a refund was issued. Tracks refund generosity trends and potential policy abuse."
    - name: "refund_case_count"
      expr: COUNT(CASE WHEN refund_amount > 0 THEN 1 END)
      comment: "Number of cases where a refund was issued. Used to calculate refund incidence rate alongside total case volume."
    - name: "refund_incidence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that resulted in a refund. Compound KPI linking service quality to financial cost; rising rate triggers policy review."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`service_case_satisfaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks customer satisfaction signals from service cases including NPS scores and satisfaction ratings. Supports CX leadership decisions on service quality investment and agent performance."
  source: "`vibe_retail_v1`.`service`.`service_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Category of service case, used to identify which case types drive the lowest satisfaction scores."
    - name: "channel"
      expr: channel
      comment: "Contact channel, used to compare satisfaction outcomes across service channels."
    - name: "priority"
      expr: priority
      comment: "Case priority level, used to validate that high-priority resolution correlates with better satisfaction."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for the case, used for team-level satisfaction benchmarking."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution outcome, used to correlate resolution type with satisfaction scores."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the case was escalated, used to measure satisfaction impact of escalation."
    - name: "customer_satisfaction_rating"
      expr: customer_satisfaction_rating
      comment: "Categorical satisfaction rating provided by the customer (e.g. satisfied, neutral, dissatisfied) for distribution analysis."
    - name: "nps_score_band"
      expr: CASE WHEN CAST(nps_score AS INT) >= 9 THEN 'promoter' WHEN CAST(nps_score AS INT) >= 7 THEN 'passive' WHEN nps_score IS NOT NULL THEN 'detractor' ELSE 'no_response' END
      comment: "NPS band derived from the numeric score: promoter (9-10), passive (7-8), detractor (0-6). Used for NPS distribution reporting."
    - name: "closed_month"
      expr: DATE_TRUNC('month', closed_timestamp)
      comment: "Month the case was closed, used for monthly satisfaction trend analysis."
  measures:
    - name: "cases_with_nps_response"
      expr: COUNT(CASE WHEN nps_score IS NOT NULL THEN 1 END)
      comment: "Number of cases where an NPS score was captured. Used as the denominator for NPS response rate and score calculations."
    - name: "nps_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nps_score IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where the customer provided an NPS score. Low response rate undermines NPS reliability and signals survey process issues."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN CAST(nps_score AS INT) >= 9 THEN 1 END)
      comment: "Number of cases where the customer gave a promoter score (9 or 10). Component of NPS calculation."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN nps_score IS NOT NULL AND CAST(nps_score AS INT) < 7 THEN 1 END)
      comment: "Number of cases where the customer gave a detractor score (0-6). Component of NPS calculation and key driver of churn risk."
    - name: "net_promoter_score"
      expr: ROUND(100.0 * (COUNT(CASE WHEN CAST(nps_score AS INT) >= 9 THEN 1 END) - COUNT(CASE WHEN nps_score IS NOT NULL AND CAST(nps_score AS INT) < 7 THEN 1 END)) / NULLIF(COUNT(CASE WHEN nps_score IS NOT NULL THEN 1 END), 0), 1)
      comment: "Net Promoter Score computed as (promoters - detractors) / respondents × 100. Primary CX KPI used in board-level customer satisfaction reporting and benchmarking."
    - name: "dissatisfied_case_count"
      expr: COUNT(CASE WHEN customer_satisfaction_rating = 'dissatisfied' THEN 1 END)
      comment: "Number of cases rated as dissatisfied by the customer. Operational alert metric; spikes trigger immediate CX investigation."
    - name: "dissatisfaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_satisfaction_rating = 'dissatisfied' THEN 1 END) / NULLIF(COUNT(CASE WHEN customer_satisfaction_rating IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of rated cases where the customer expressed dissatisfaction. Compound satisfaction quality KPI used in service performance reviews."
$$;