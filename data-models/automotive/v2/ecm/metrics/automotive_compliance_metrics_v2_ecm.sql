-- Metric views for domain: compliance | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission performance metrics tracking approval rates, cycle times, and fee costs across jurisdictions and submission types for compliance operations steering."
  source: "`vibe_automotive_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., type approval, emissions certification, safety certification)"
    - name: "submission_category"
      expr: submission_category
      comment: "Category classification of the submission for grouping similar regulatory filings"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction where the submission was filed (e.g., US, EU, China)"
    - name: "regulatory_body_name"
      expr: regulatory_body_name
      comment: "Name of the regulatory authority receiving the submission"
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the submission (e.g., submitted, under review, approved, rejected)"
    - name: "emission_standard"
      expr: emission_standard
      comment: "Applicable emissions standard for the submission (e.g., Euro 6, EPA Tier 3)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the vehicle covered by the submission (e.g., gasoline, diesel, electric, hybrid)"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle covered by the submission (e.g., passenger car, light truck, heavy-duty)"
    - name: "vehicle_model_year"
      expr: vehicle_model_year
      comment: "Model year of the vehicle covered by the submission"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the submission is critical for market launch or production"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether the submission requires expedited processing"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when the submission was filed, for time-series analysis"
    - name: "submission_quarter"
      expr: DATE_TRUNC('QUARTER', submission_date)
      comment: "Quarter when the submission was filed, for quarterly performance tracking"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when the submission was filed, for annual trend analysis"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when the submission was approved, for approval cycle analysis"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions filed"
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'approved' THEN 1 END)
      comment: "Number of submissions that have been approved by regulatory authorities"
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'rejected' THEN 1 END)
      comment: "Number of submissions that have been rejected by regulatory authorities"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions approved, key quality indicator for compliance readiness"
    - name: "critical_submissions"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical submissions that block market launch or production"
    - name: "urgent_submissions"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Number of urgent submissions requiring expedited processing"
    - name: "total_fee_gross_amount"
      expr: SUM(CAST(fee_gross_amount AS DOUBLE))
      comment: "Total gross fees paid for regulatory submissions, key cost driver for compliance operations"
    - name: "total_fee_net_amount"
      expr: SUM(CAST(fee_net_amount AS DOUBLE))
      comment: "Total net fees paid for regulatory submissions after adjustments"
    - name: "total_fee_tax_amount"
      expr: SUM(CAST(fee_tax_amount AS DOUBLE))
      comment: "Total tax amount paid on regulatory submission fees"
    - name: "avg_fee_gross_amount"
      expr: AVG(CAST(fee_gross_amount AS DOUBLE))
      comment: "Average gross fee per submission, for cost benchmarking across jurisdictions"
    - name: "avg_cafe_value"
      expr: AVG(CAST(cafe_value AS DOUBLE))
      comment: "Average CAFE (Corporate Average Fuel Economy) value across submissions, for fleet compliance tracking"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_recall_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall campaign metrics tracking volume, scope, and regulatory compliance for safety and quality steering."
  source: "`vibe_automotive_v1`.`compliance`.`recall_campaign`"
  dimensions:
    - name: "recall_campaign_id"
      expr: recall_campaign_id
      comment: "Unique identifier for the recall campaign"
  measures:
    - name: "total_recall_campaigns"
      expr: COUNT(1)
      comment: "Total number of recall campaigns initiated, key safety and quality indicator"
    - name: "distinct_recall_campaigns"
      expr: COUNT(DISTINCT recall_campaign_id)
      comment: "Distinct count of recall campaigns for deduplication across reporting periods"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_recall_defect_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall defect report metrics tracking incident severity, investigation status, and affected vehicle populations for safety risk management."
  source: "`vibe_automotive_v1`.`compliance`.`recall_defect_report`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "Category of the defect (e.g., powertrain, braking, electrical, airbag)"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the defect investigation (e.g., open, under review, closed)"
    - name: "recall_defect_report_status"
      expr: recall_defect_report_status
      comment: "Status of the defect report (e.g., draft, submitted, approved)"
    - name: "report_type"
      expr: report_type
      comment: "Type of defect report (e.g., safety recall, field action, service campaign)"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency receiving the defect report (e.g., NHTSA, Transport Canada)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of affected vehicles"
    - name: "vehicle_model"
      expr: vehicle_model
      comment: "Model name of affected vehicles"
    - name: "report_submission_month"
      expr: DATE_TRUNC('MONTH', report_submission_timestamp)
      comment: "Month when the defect report was submitted, for time-series analysis"
    - name: "report_submission_quarter"
      expr: DATE_TRUNC('QUARTER', report_submission_timestamp)
      comment: "Quarter when the defect report was submitted, for quarterly trend tracking"
  measures:
    - name: "total_defect_reports"
      expr: COUNT(1)
      comment: "Total number of recall defect reports filed, key safety risk indicator"
    - name: "total_incident_count"
      expr: SUM(CAST(incident_count AS BIGINT))
      comment: "Total number of incidents reported across all defect reports, critical safety metric"
    - name: "total_injury_count"
      expr: SUM(CAST(injury_count AS BIGINT))
      comment: "Total number of injuries reported, critical safety and liability metric"
    - name: "total_fatality_count"
      expr: SUM(CAST(fatality_count AS BIGINT))
      comment: "Total number of fatalities reported, highest-severity safety metric"
    - name: "reports_with_injuries"
      expr: COUNT(CASE WHEN CAST(injury_count AS BIGINT) > 0 THEN 1 END)
      comment: "Number of defect reports involving injuries, for severity classification"
    - name: "reports_with_fatalities"
      expr: COUNT(CASE WHEN CAST(fatality_count AS BIGINT) > 0 THEN 1 END)
      comment: "Number of defect reports involving fatalities, highest-priority safety tracking"
    - name: "avg_incident_count_per_report"
      expr: AVG(CAST(incident_count AS BIGINT))
      comment: "Average number of incidents per defect report, for severity benchmarking"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_cafe_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAFE (Corporate Average Fuel Economy) compliance metrics tracking fleet fuel economy performance, credit balances, and fine liabilities for regulatory steering."
  source: "`vibe_automotive_v1`.`compliance`.`cafe_compliance_record`"
  dimensions:
    - name: "fleet_type"
      expr: fleet_type
      comment: "Type of fleet (e.g., passenger car, light truck) for CAFE compliance segmentation"
    - name: "model_year"
      expr: model_year
      comment: "Model year for which CAFE compliance is being tracked"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year in which the CAFE compliance report was filed"
    - name: "reporting_status"
      expr: reporting_status
      comment: "Status of the CAFE compliance report (e.g., draft, submitted, approved)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing CAFE compliance (e.g., NHTSA, EPA)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of CAFE credit (e.g., earned, purchased, transferred)"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the CAFE compliance record is currently active"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when the CAFE compliance report was submitted"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when the CAFE compliance report was approved"
  measures:
    - name: "total_cafe_records"
      expr: COUNT(1)
      comment: "Total number of CAFE compliance records"
    - name: "total_vehicles_reported"
      expr: SUM(CAST(total_vehicles AS BIGINT))
      comment: "Total number of vehicles included in CAFE compliance reporting"
    - name: "avg_actual_cafe_mpg"
      expr: AVG(CAST(actual_cafe_mpg AS DOUBLE))
      comment: "Average actual CAFE fuel economy achieved across fleet, key performance indicator"
    - name: "avg_required_cafe_mpg"
      expr: AVG(CAST(required_cafe_mpg AS DOUBLE))
      comment: "Average required CAFE fuel economy target, for gap analysis"
    - name: "avg_compliance_gap_mpg"
      expr: AVG(CAST(compliance_gap_mpg AS DOUBLE))
      comment: "Average gap between required and actual CAFE MPG, key compliance risk metric"
    - name: "total_credit_balance"
      expr: SUM(CAST(credit_balance AS DOUBLE))
      comment: "Total CAFE credit balance across all records, key asset for future compliance"
    - name: "total_fine_liability_usd"
      expr: SUM(CAST(fine_liability_usd AS DOUBLE))
      comment: "Total fine liability in USD for CAFE non-compliance, critical financial risk metric"
    - name: "avg_fine_liability_usd"
      expr: AVG(CAST(fine_liability_usd AS DOUBLE))
      comment: "Average fine liability per record, for risk benchmarking"
    - name: "records_with_fine_liability"
      expr: COUNT(CASE WHEN CAST(fine_liability_usd AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of records with non-zero fine liability, compliance failure indicator"
    - name: "records_with_positive_credit_balance"
      expr: COUNT(CASE WHEN CAST(credit_balance AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of records with positive credit balance, compliance strength indicator"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_zev_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zero-Emission Vehicle (ZEV) credit metrics tracking credit generation, trading, and retirement for regulatory compliance and revenue optimization."
  source: "`vibe_automotive_v1`.`compliance`.`zev_credit`"
  dimensions:
    - name: "credit_type"
      expr: credit_type
      comment: "Type of ZEV credit (e.g., BEV, PHEV, FCEV)"
    - name: "credit_status"
      expr: credit_status
      comment: "Status of the credit (e.g., active, traded, retired, expired)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of credit transaction (e.g., earned, purchased, sold, retired)"
    - name: "compliance_program"
      expr: compliance_program
      comment: "Regulatory compliance program (e.g., California ZEV, Oregon Clean Fuels)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body administering the ZEV credit program (e.g., CARB, DEQ)"
    - name: "region"
      expr: region
      comment: "Geographic region where the credit is valid"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type generating the credit (e.g., battery electric, plug-in hybrid, fuel cell)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle generating the credit"
    - name: "credit_vintage_year"
      expr: credit_vintage_year
      comment: "Vintage year of the credit, determines expiration and trading rules"
    - name: "counterparty_role"
      expr: counterparty_role
      comment: "Role of the counterparty in the transaction (e.g., buyer, seller, regulator)"
    - name: "retirement_reason"
      expr: retirement_reason
      comment: "Reason for credit retirement (e.g., compliance obligation, expiration)"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month when the credit transaction occurred"
    - name: "transaction_quarter"
      expr: DATE_TRUNC('QUARTER', transaction_date)
      comment: "Quarter when the credit transaction occurred"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the credit became effective"
  measures:
    - name: "total_credit_transactions"
      expr: COUNT(1)
      comment: "Total number of ZEV credit transactions"
    - name: "total_credit_quantity"
      expr: SUM(CAST(credit_quantity AS DOUBLE))
      comment: "Total quantity of ZEV credits across all transactions, key compliance asset metric"
    - name: "total_credit_value_usd"
      expr: SUM(CAST(credit_quantity AS DOUBLE) * CAST(credit_price_usd AS DOUBLE))
      comment: "Total value of ZEV credits in USD, key revenue and asset valuation metric"
    - name: "avg_credit_price_usd"
      expr: AVG(CAST(credit_price_usd AS DOUBLE))
      comment: "Average price per ZEV credit in USD, for market benchmarking and valuation"
    - name: "credits_earned"
      expr: SUM(CASE WHEN transaction_type = 'earned' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total credits earned from vehicle sales, key generation metric"
    - name: "credits_purchased"
      expr: SUM(CASE WHEN transaction_type = 'purchased' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total credits purchased from other parties, compliance strategy metric"
    - name: "credits_sold"
      expr: SUM(CASE WHEN transaction_type = 'sold' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total credits sold to other parties, revenue generation metric"
    - name: "credits_retired"
      expr: SUM(CASE WHEN transaction_type = 'retired' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total credits retired for compliance obligations, utilization metric"
    - name: "net_credit_position"
      expr: SUM(CASE WHEN transaction_type IN ('earned', 'purchased') THEN CAST(credit_quantity AS DOUBLE) WHEN transaction_type IN ('sold', 'retired') THEN -CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Net credit position after all transactions, key compliance asset balance"
    - name: "revenue_from_credit_sales"
      expr: SUM(CASE WHEN transaction_type = 'sold' THEN CAST(credit_quantity AS DOUBLE) * CAST(credit_price_usd AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from ZEV credit sales, key monetization metric"
    - name: "cost_of_credit_purchases"
      expr: SUM(CASE WHEN transaction_type = 'purchased' THEN CAST(credit_quantity AS DOUBLE) * CAST(credit_price_usd AS DOUBLE) ELSE 0 END)
      comment: "Total cost of ZEV credit purchases, key compliance cost metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_homologation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle homologation (type approval) metrics tracking certification status, emissions performance, and market readiness for global launch steering."
  source: "`vibe_automotive_v1`.`compliance`.`homologation_record`"
  dimensions:
    - name: "homologation_record_status"
      expr: homologation_record_status
      comment: "Status of the homologation record (e.g., pending, approved, expired)"
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval (e.g., WVTA, national type approval, individual approval)"
    - name: "market_jurisdiction"
      expr: market_jurisdiction
      comment: "Jurisdiction where the homologation is valid (e.g., EU, US, China)"
    - name: "market_region"
      expr: market_region
      comment: "Geographic region for the homologation (e.g., Europe, North America, Asia-Pacific)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body granting the homologation (e.g., VCA, NHTSA, MIIT)"
    - name: "vehicle_model"
      expr: vehicle_model
      comment: "Model name of the homologated vehicle"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the homologated vehicle"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the homologated vehicle (e.g., gasoline, diesel, electric, hybrid)"
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain configuration (e.g., FWD, RWD, AWD)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (e.g., manual, automatic, CVT)"
    - name: "body_style"
      expr: body_style
      comment: "Body style of the homologated vehicle (e.g., sedan, SUV, hatchback)"
    - name: "test_cycle"
      expr: test_cycle
      comment: "Test cycle used for homologation (e.g., WLTP, NEDC, EPA FTP-75)"
    - name: "test_lab"
      expr: test_lab
      comment: "Laboratory that conducted the homologation testing"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the homologation became effective"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month when the homologation expires"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month when the homologation testing was conducted"
  measures:
    - name: "total_homologation_records"
      expr: COUNT(1)
      comment: "Total number of homologation records, key market readiness indicator"
    - name: "approved_homologations"
      expr: COUNT(CASE WHEN homologation_record_status = 'approved' THEN 1 END)
      comment: "Number of approved homologations, market launch enabler metric"
    - name: "expired_homologations"
      expr: COUNT(CASE WHEN homologation_record_status = 'expired' THEN 1 END)
      comment: "Number of expired homologations, renewal risk indicator"
    - name: "avg_co2_emissions_g_per_km"
      expr: AVG(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions in grams per kilometer, key environmental compliance metric"
    - name: "avg_fuel_consumption_l_per_100km"
      expr: AVG(CAST(fuel_consumption_l_per_100km AS DOUBLE))
      comment: "Average fuel consumption in liters per 100 km, key efficiency metric"
    - name: "total_co2_emissions_g_per_km"
      expr: SUM(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Total CO2 emissions across all homologated vehicles, fleet emissions metric"
    - name: "homologations_by_wltp"
      expr: COUNT(CASE WHEN test_cycle = 'WLTP' THEN 1 END)
      comment: "Number of homologations using WLTP test cycle, modern standard adoption metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_environmental_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental permit metrics tracking permit status, compliance monitoring, and inspection cycles for manufacturing plant environmental risk management."
  source: "`vibe_automotive_v1`.`compliance`.`environmental_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of environmental permit (e.g., air quality, water discharge, waste management)"
    - name: "permit_category"
      expr: permit_category
      comment: "Category of the permit for classification (e.g., major source, minor source)"
    - name: "environmental_permit_status"
      expr: environmental_permit_status
      comment: "Current status of the permit (e.g., active, expired, pending renewal)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the permit (e.g., compliant, non-compliant, under review)"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of permit renewal process (e.g., not required, pending, submitted)"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the environmental permit (e.g., EPA, state DEQ)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the permit compliance"
    - name: "pollutant_code"
      expr: pollutant_code
      comment: "Code identifying the regulated pollutant (e.g., NOx, VOC, PM2.5)"
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used for compliance monitoring (e.g., continuous, periodic, annual)"
    - name: "compliance_monitoring_frequency"
      expr: compliance_monitoring_frequency
      comment: "Frequency of compliance monitoring required by the permit"
    - name: "is_exempt"
      expr: is_exempt
      comment: "Flag indicating whether the facility is exempt from certain permit requirements"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when the permit was issued"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month when the permit expires, for renewal planning"
    - name: "last_inspection_month"
      expr: DATE_TRUNC('MONTH', last_inspection_date)
      comment: "Month of the last inspection"
    - name: "next_inspection_month"
      expr: DATE_TRUNC('MONTH', next_inspection_due)
      comment: "Month when the next inspection is due"
  measures:
    - name: "total_environmental_permits"
      expr: COUNT(1)
      comment: "Total number of environmental permits held, key regulatory footprint metric"
    - name: "active_permits"
      expr: COUNT(CASE WHEN environmental_permit_status = 'active' THEN 1 END)
      comment: "Number of active environmental permits, operational compliance indicator"
    - name: "expired_permits"
      expr: COUNT(CASE WHEN environmental_permit_status = 'expired' THEN 1 END)
      comment: "Number of expired permits, compliance risk indicator requiring immediate action"
    - name: "non_compliant_permits"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Number of permits in non-compliant status, critical environmental risk metric"
    - name: "permits_pending_renewal"
      expr: COUNT(CASE WHEN renewal_status = 'pending' THEN 1 END)
      comment: "Number of permits pending renewal, workload and risk planning metric"
    - name: "avg_pollutant_limit_value"
      expr: AVG(CAST(pollutant_limit_value AS DOUBLE))
      comment: "Average pollutant limit value across permits, for benchmarking regulatory stringency"
    - name: "total_pollutant_limit_value"
      expr: SUM(CAST(pollutant_limit_value AS DOUBLE))
      comment: "Total pollutant limit value across all permits, aggregate environmental capacity metric"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits in compliant status, key environmental performance indicator"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_test_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance test event metrics tracking test execution, pass/fail rates, and retest frequency for certification quality and efficiency steering."
  source: "`vibe_automotive_v1`.`compliance`.`test_event`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of compliance test (e.g., emissions, safety, durability)"
    - name: "test_category"
      expr: test_category
      comment: "Category of the test for classification (e.g., regulatory, validation, pre-certification)"
    - name: "test_event_status"
      expr: test_event_status
      comment: "Status of the test event (e.g., scheduled, in progress, completed, cancelled)"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status resulting from the test (e.g., certified, pending, failed)"
    - name: "result"
      expr: result
      comment: "Result of the test (e.g., pass, fail, inconclusive)"
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Boolean flag indicating pass (true) or fail (false)"
    - name: "is_retest"
      expr: is_retest
      comment: "Flag indicating whether this is a retest after a previous failure"
    - name: "retest_reason"
      expr: retest_reason
      comment: "Reason for retest (e.g., equipment failure, out-of-spec result, procedural error)"
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where the test was conducted"
    - name: "test_location"
      expr: test_location
      comment: "Geographic location of the test"
    - name: "test_program"
      expr: test_program
      comment: "Test program under which the test was conducted (e.g., vehicle program, component validation)"
    - name: "certification_body"
      expr: certification_body
      comment: "Certification body overseeing the test (e.g., EPA, CARB, TÜV)"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction for which the test is conducted"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the tested vehicle (e.g., ICE, BEV, PHEV)"
    - name: "vehicle_model_year"
      expr: vehicle_model_year
      comment: "Model year of the tested vehicle"
    - name: "test_condition"
      expr: test_condition
      comment: "Test condition or scenario (e.g., cold start, hot soak, highway cycle)"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month when the test was conducted"
    - name: "test_quarter"
      expr: DATE_TRUNC('QUARTER', test_timestamp)
      comment: "Quarter when the test was conducted"
  measures:
    - name: "total_test_events"
      expr: COUNT(1)
      comment: "Total number of compliance test events conducted"
    - name: "passed_tests"
      expr: COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END)
      comment: "Number of tests that passed, key quality indicator"
    - name: "failed_tests"
      expr: COUNT(CASE WHEN pass_fail_flag = FALSE THEN 1 END)
      comment: "Number of tests that failed, quality risk indicator"
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests passed on first attempt, key certification efficiency metric"
    - name: "retest_count"
      expr: COUNT(CASE WHEN is_retest = TRUE THEN 1 END)
      comment: "Number of retests conducted, quality and cost efficiency indicator"
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_retest = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that are retests, quality process efficiency metric"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across test events, for performance benchmarking"
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during testing, for environmental condition analysis"
    - name: "avg_ambient_humidity_percent"
      expr: AVG(CAST(ambient_humidity_percent AS DOUBLE))
      comment: "Average ambient humidity during testing, for environmental condition analysis"
    - name: "avg_ambient_pressure_kpa"
      expr: AVG(CAST(ambient_pressure_kpa AS DOUBLE))
      comment: "Average ambient pressure during testing, for environmental condition analysis"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation metrics tracking compliance status, certification timing, and risk levels for proactive compliance management and audit readiness."
  source: "`vibe_automotive_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Status of the regulatory obligation (e.g., open, in progress, completed, overdue)"
    - name: "regulation_type"
      expr: regulation_type
      comment: "Type of regulation (e.g., emissions, safety, data privacy, labor)"
    - name: "regulation_code"
      expr: regulation_code
      comment: "Code identifying the specific regulation"
    - name: "priority"
      expr: priority
      comment: "Priority level of the obligation (e.g., critical, high, medium, low)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with non-compliance (e.g., high, medium, low)"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the obligation is critical for business operations"
    - name: "is_regulatory"
      expr: is_regulatory
      comment: "Flag indicating whether the obligation is regulatory (vs. voluntary)"
    - name: "test_result"
      expr: test_result
      comment: "Result of compliance testing (e.g., pass, fail, pending)"
    - name: "certification_body"
      expr: certification_body
      comment: "Body responsible for certification (e.g., EPA, CARB, TÜV)"
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where compliance testing was conducted"
    - name: "test_method"
      expr: test_method
      comment: "Method used for compliance testing"
    - name: "model_year"
      expr: model_year
      comment: "Model year to which the obligation applies"
    - name: "responsible_engineering_group"
      expr: responsible_engineering_group
      comment: "Engineering group responsible for fulfilling the obligation"
    - name: "non_compliance_reason"
      expr: non_compliance_reason
      comment: "Reason for non-compliance if obligation is not met"
    - name: "waiver_reason"
      expr: waiver_reason
      comment: "Reason for waiver if obligation is waived"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when the obligation becomes effective"
    - name: "target_certification_month"
      expr: DATE_TRUNC('MONTH', target_certification_date)
      comment: "Month when certification is targeted"
    - name: "actual_certification_month"
      expr: DATE_TRUNC('MONTH', actual_certification_date)
      comment: "Month when certification was actually achieved"
    - name: "corrective_action_due_month"
      expr: DATE_TRUNC('MONTH', corrective_action_due_date)
      comment: "Month when corrective action is due"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations tracked"
    - name: "critical_obligations"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical obligations, key risk indicator"
    - name: "overdue_obligations"
      expr: COUNT(CASE WHEN obligation_status = 'overdue' THEN 1 END)
      comment: "Number of overdue obligations, critical compliance risk metric"
    - name: "completed_obligations"
      expr: COUNT(CASE WHEN obligation_status = 'completed' THEN 1 END)
      comment: "Number of completed obligations, compliance achievement metric"
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Number of high-risk obligations, prioritization metric for compliance resources"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across obligations, overall compliance health indicator"
    - name: "avg_emission_value"
      expr: AVG(CAST(emission_value AS DOUBLE))
      comment: "Average emission value across obligations, environmental performance metric"
    - name: "avg_fuel_economy_value"
      expr: AVG(CAST(fuel_economy_value AS DOUBLE))
      comment: "Average fuel economy value across obligations, efficiency performance metric"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN obligation_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations completed, key compliance execution metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_esg_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG (Environmental, Social, Governance) reporting metrics tracking report volume, status, and framework adoption for sustainability disclosure steering."
  source: "`vibe_automotive_v1`.`compliance`.`esg_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of ESG report (e.g., annual sustainability report, CSRD disclosure, CDP submission)"
    - name: "report_status"
      expr: report_status
      comment: "Status of the ESG report (e.g., draft, under review, published)"
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "Reporting framework used (e.g., GRI, SASB, TCFD, CSRD)"
    - name: "assurance_level"
      expr: assurance_level
      comment: "Level of external assurance (e.g., limited, reasonable, none)"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_start)
      comment: "Year of the reporting period start, for annual trend analysis"
    - name: "published_month"
      expr: DATE_TRUNC('MONTH', published_date)
      comment: "Month when the ESG report was published"
    - name: "published_quarter"
      expr: DATE_TRUNC('QUARTER', published_date)
      comment: "Quarter when the ESG report was published"
  measures:
    - name: "total_esg_reports"
      expr: COUNT(1)
      comment: "Total number of ESG reports produced, key sustainability disclosure volume metric"
    - name: "published_esg_reports"
      expr: COUNT(CASE WHEN report_status = 'published' THEN 1 END)
      comment: "Number of published ESG reports, disclosure completion metric"
    - name: "reports_with_assurance"
      expr: COUNT(CASE WHEN assurance_level IN ('limited', 'reasonable') THEN 1 END)
      comment: "Number of ESG reports with external assurance, credibility and quality indicator"
    - name: "distinct_reporting_frameworks"
      expr: COUNT(DISTINCT reporting_framework)
      comment: "Number of distinct reporting frameworks used, framework diversity metric"
$$;