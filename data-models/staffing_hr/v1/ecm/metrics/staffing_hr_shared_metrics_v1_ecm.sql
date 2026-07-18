-- Metric views for domain: shared | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`shared_holiday_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic holiday planning and workforce cost metrics for staffing operations, enabling premium pay forecasting, mandatory closure impact analysis, and multi-jurisdictional holiday compliance tracking."
  source: "`staffing_hr_ecm`.`shared`.`holiday_calendar`"
  dimensions:
    - name: "holiday_year"
      expr: year
      comment: "Calendar year of the holiday for annual planning and year-over-year comparison"
    - name: "holiday_country"
      expr: country_code
      comment: "Country code for multi-national holiday compliance and regional workforce planning"
    - name: "holiday_state_province"
      expr: state_province_code
      comment: "State or province code for sub-national holiday observance and regional staffing impact"
    - name: "business_unit"
      expr: business_unit_code
      comment: "Business unit code for segmented holiday policy and cost allocation"
    - name: "holiday_type_category"
      expr: holiday_type
      comment: "Type of holiday (e.g., national, religious, regional) for policy segmentation"
    - name: "is_mandatory_closure"
      expr: is_mandatory_closure
      comment: "Flag indicating whether operations must close, critical for capacity planning"
    - name: "is_paid_holiday"
      expr: is_paid
      comment: "Flag indicating whether holiday is paid, directly impacts labor cost forecasting"
    - name: "is_client_specific"
      expr: client_specific_flag
      comment: "Flag indicating client-specific holiday, used for custom contract compliance"
    - name: "staffing_impact_level_category"
      expr: staffing_impact_level
      comment: "Severity of staffing impact (e.g., high, medium, low) for resource allocation prioritization"
    - name: "holiday_month"
      expr: MONTH(holiday_date)
      comment: "Month of holiday occurrence for seasonal workforce planning and cash flow forecasting"
    - name: "holiday_quarter"
      expr: QUARTER(holiday_date)
      comment: "Quarter of holiday occurrence for quarterly budget and capacity planning"
    - name: "day_of_week_category"
      expr: day_of_week
      comment: "Day of week the holiday falls on, impacts weekend adjacency and bridge day planning"
    - name: "is_recurring"
      expr: recurring_flag
      comment: "Flag indicating whether holiday recurs annually, used for multi-year forecasting"
    - name: "holiday_status"
      expr: holiday_calendar_status
      comment: "Current status of holiday record (e.g., active, cancelled, pending) for operational validity"
  measures:
    - name: "total_holidays"
      expr: COUNT(DISTINCT holiday_calendar_id)
      comment: "Distinct count of holidays for capacity planning and compliance tracking across jurisdictions"
    - name: "total_mandatory_closures"
      expr: COUNT(DISTINCT CASE WHEN is_mandatory_closure = TRUE THEN holiday_calendar_id END)
      comment: "Count of mandatory closure days, critical for annual capacity and revenue forecasting"
    - name: "total_paid_holidays"
      expr: COUNT(DISTINCT CASE WHEN is_paid = TRUE THEN holiday_calendar_id END)
      comment: "Count of paid holidays, directly drives labor cost budgeting and margin planning"
    - name: "avg_premium_pay_multiplier"
      expr: AVG(CAST(premium_pay_multiplier AS DOUBLE))
      comment: "Average premium pay multiplier across holidays, used for blended labor cost rate forecasting"
    - name: "total_premium_pay_exposure"
      expr: SUM(CAST(premium_pay_multiplier AS DOUBLE))
      comment: "Sum of all premium pay multipliers, proxy for total premium cost exposure across all holidays"
    - name: "max_premium_pay_multiplier"
      expr: MAX(CAST(premium_pay_multiplier AS DOUBLE))
      comment: "Highest premium pay multiplier, identifies peak cost holidays for targeted cost mitigation"
    - name: "avg_advance_notice_days_numeric"
      expr: AVG(CAST(advance_notice_days AS DOUBLE))
      comment: "Average advance notice period in days, measures planning lead time for workforce scheduling"
    - name: "total_client_specific_holidays"
      expr: COUNT(DISTINCT CASE WHEN client_specific_flag = TRUE THEN holiday_calendar_id END)
      comment: "Count of client-specific holidays, indicates custom contract complexity and compliance burden"
    - name: "mandatory_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_mandatory_closure = TRUE THEN holiday_calendar_id END) / NULLIF(COUNT(DISTINCT holiday_calendar_id), 0), 2)
      comment: "Percentage of holidays requiring mandatory closure, key driver of annual capacity loss and revenue risk"
    - name: "paid_holiday_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_paid = TRUE THEN holiday_calendar_id END) / NULLIF(COUNT(DISTINCT holiday_calendar_id), 0), 2)
      comment: "Percentage of holidays that are paid, directly impacts labor cost as percentage of total holidays"
$$;
