-- Metric views for domain: sales | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core revenue and order performance metrics derived from the booking fact table. Covers gross/net booked revenue, discount analysis, and booking volume by key business dimensions. Used in QBRs, revenue forecasting, and sales performance reviews."
  source: "`vibe_semiconductors_v1`.`sales`.`booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the booking (e.g. Open, Confirmed, Cancelled). Used to filter active vs. cancelled revenue."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, Blanket, NRE). Drives revenue recognition treatment and reporting segmentation."
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region associated with the booking. Enables regional revenue performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the booking. Required for multi-currency revenue reporting and FX analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family associated with the booking. Enables product-line revenue mix analysis."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Fulfillment mode (e.g. Direct, Hub, Consignment). Impacts logistics cost and revenue recognition timing."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the booking (e.g. List, Negotiated, Volume). Used to assess pricing strategy effectiveness."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_timestamp)
      comment: "Calendar month of booking creation. Enables month-over-month revenue trend analysis."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of customer-requested delivery. Used for demand shaping and capacity planning."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether the booking is in backlog. Used to separate recognized revenue from open backlog."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Export compliance status of the booking. Critical for regulatory reporting and revenue at risk assessment."
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for the shipment. Enables geographic demand and compliance analysis."
  measures:
    - name: "total_booked_revenue_gross"
      expr: SUM(CAST(booked_revenue_gross AS DOUBLE))
      comment: "Total gross booked revenue across all bookings. Primary top-line revenue KPI used in QBRs and board reporting."
    - name: "total_booked_revenue_net"
      expr: SUM(CAST(booked_revenue_net AS DOUBLE))
      comment: "Total net booked revenue after discounts and adjustments. Reflects true revenue commitment for financial planning."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars granted across all bookings. Tracks pricing discipline and margin erosion risk."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on bookings. Required for tax liability reporting and compliance."
    - name: "total_booked_quantity"
      expr: SUM(CAST(booked_quantity AS DOUBLE))
      comment: "Total unit volume booked. Used for demand planning, capacity allocation, and supply chain signaling."
    - name: "booking_count"
      expr: COUNT(1)
      comment: "Total number of bookings. Baseline volume metric for booking velocity and sales productivity analysis."
    - name: "avg_booked_revenue_gross_per_booking"
      expr: AVG(CAST(booked_revenue_gross AS DOUBLE))
      comment: "Average gross revenue per booking. Indicates deal size trends and is used to assess upsell effectiveness."
    - name: "avg_discount_amount_per_booking"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per booking. Monitors pricing discipline and identifies accounts receiving outsized concessions."
    - name: "distinct_accounts_booked"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with bookings. Measures customer breadth and concentration risk."
    - name: "backlog_revenue_gross"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN booked_revenue_gross ELSE 0 END)
      comment: "Gross revenue in open backlog. Critical leading indicator of near-term revenue recognition and supply commit."
    - name: "forecast_flagged_revenue"
      expr: SUM(CASE WHEN forecast_flag = TRUE THEN booked_revenue_gross ELSE 0 END)
      comment: "Gross revenue on bookings flagged for forecast inclusion. Used to reconcile bookings to sales forecast."
    - name: "critical_booking_revenue"
      expr: SUM(CASE WHEN is_critical = TRUE THEN booked_revenue_gross ELSE 0 END)
      comment: "Revenue from bookings flagged as critical priority. Used for escalation management and executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline health and conversion metrics derived from the opportunity table. Covers pipeline value, stage distribution, win/loss analysis, and NRE deal tracking. Used in pipeline reviews, forecast calls, and strategic planning."
  source: "`vibe_semiconductors_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current pipeline stage of the opportunity (e.g. Qualify, Propose, Negotiate, Close). Drives pipeline funnel analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Go-to-market channel (e.g. Direct, Distribution, Online). Used to assess channel mix and effectiveness."
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity. Enables regional pipeline and win-rate benchmarking."
    - name: "end_market"
      expr: end_market
      comment: "Target end market (e.g. Automotive, Industrial, Consumer). Used for market segment pipeline analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the opportunity. Required for multi-currency pipeline valuation."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract associated with the opportunity (e.g. NRE, Volume, Blanket). Drives revenue recognition and deal structure analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the associated contract. Used to track deal progression from opportunity to contracted revenue."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the opportunity. Used to assess pricing strategy and margin expectations."
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Month the opportunity is expected to close. Core dimension for pipeline timing and forecast period assignment."
    - name: "win_loss_month"
      expr: DATE_TRUNC('MONTH', win_loss_date)
      comment: "Month the opportunity was won or lost. Used for win/loss trend analysis and competitive intelligence."
    - name: "win_loss_reason"
      expr: win_loss_reason
      comment: "Reason for winning or losing the opportunity. Drives competitive strategy and sales coaching decisions."
    - name: "target_application"
      expr: target_application
      comment: "Target customer application (e.g. ADAS, 5G, Server). Used for application-level pipeline and design win tracking."
  measures:
    - name: "total_pipeline_gross_amount"
      expr: SUM(CAST(expected_gross_amount AS DOUBLE))
      comment: "Total gross pipeline value across all open opportunities. Primary pipeline health KPI for sales leadership and board reporting."
    - name: "total_pipeline_net_amount"
      expr: SUM(CAST(expected_net_amount AS DOUBLE))
      comment: "Total net pipeline value after expected discounts. Used for realistic revenue forecasting and quota attainment tracking."
    - name: "total_nre_pipeline_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total NRE (Non-Recurring Engineering) value in pipeline. Tracks engineering services revenue and design-in investment."
    - name: "total_expected_discount_amount"
      expr: SUM(CAST(expected_discount_amount AS DOUBLE))
      comment: "Total expected discount across pipeline. Used to assess pricing risk and gross-to-net revenue gap."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities. Baseline pipeline volume metric for sales productivity and funnel analysis."
    - name: "distinct_accounts_in_pipeline"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with active opportunities. Measures customer reach and concentration in the pipeline."
    - name: "avg_deal_size_gross"
      expr: AVG(CAST(expected_gross_amount AS DOUBLE))
      comment: "Average gross deal size per opportunity. Tracks deal size trends and is used to assess upsell and product mix strategy."
    - name: "avg_nre_amount_per_opportunity"
      expr: AVG(CAST(nre_amount AS DOUBLE))
      comment: "Average NRE amount per opportunity. Indicates the engineering investment intensity of the pipeline."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average unit price across opportunities. Used to monitor ASP (Average Selling Price) trends in the pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast accuracy and volume metrics. Covers forecast quantity, revenue, bias, and MAPE to drive forecast quality improvement and supply chain alignment. Used in S&OP, demand review meetings, and executive forecast calls."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. Bottom-Up, Top-Down, Statistical). Used to compare forecast methodologies and accuracy."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Business category of the forecast (e.g. Commit, Best Case, Upside). Drives scenario planning and risk assessment."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Lifecycle status of the forecast (e.g. Draft, Submitted, Approved). Used to filter active vs. historical forecasts."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period the forecast covers. Core time dimension for period-over-period forecast comparison."
    - name: "geography"
      expr: geography
      comment: "Geographic scope of the forecast. Enables regional demand planning and supply allocation."
    - name: "end_market"
      expr: end_market
      comment: "Target end market for the forecast. Used for market segment demand analysis and capacity planning."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Named forecast scenario (e.g. Base, Bull, Bear). Used for scenario-based planning and risk quantification."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start)
      comment: "Start month of the forecast horizon. Used to align forecast periods with supply planning cycles."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Stated confidence level of the forecast. Used to weight forecasts in consensus demand planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast revenue. Required for multi-currency demand and revenue planning."
  measures:
    - name: "total_forecast_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Total forecasted revenue across all forecast records. Primary demand signal for financial planning and S&OP."
    - name: "total_forecast_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total forecasted unit volume. Core supply planning input for wafer starts, capacity, and inventory positioning."
    - name: "total_variance_to_actual"
      expr: SUM(CAST(variance_to_actual AS DOUBLE))
      comment: "Total forecast variance vs. actuals. Measures aggregate forecast error and drives process improvement."
    - name: "avg_forecast_bias"
      expr: AVG(CAST(bias AS DOUBLE))
      comment: "Average forecast bias (systematic over/under-forecasting). Used to detect and correct directional forecast errors."
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across forecasts. Primary forecast accuracy KPI used in S&OP scorecards."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Total number of forecast records. Used to assess forecast coverage and submission compliance."
    - name: "locked_forecast_revenue"
      expr: SUM(CASE WHEN is_locked = TRUE THEN revenue ELSE 0 END)
      comment: "Revenue in locked (committed) forecasts. Represents the firm demand signal used for supply commit and financial guidance."
    - name: "distinct_accounts_forecasted"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with active forecasts. Measures forecast coverage breadth across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win pipeline and revenue ramp metrics. Design wins are the leading indicator of future semiconductor revenue — tracking win volume, estimated revenue, and ramp rates is critical for long-range planning. Used in design win reviews, investor reporting, and product strategy."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_design_win`"
  dimensions:
    - name: "sales_design_win_status"
      expr: sales_design_win_status
      comment: "Current status of the design win (e.g. Active, At Risk, Lost, Ramping). Used to track design win health and revenue at risk."
    - name: "market_segment"
      expr: market_segment
      comment: "End market segment of the design win (e.g. Automotive, Data Center, Mobile). Drives product roadmap and investment prioritization."
    - name: "region"
      expr: region
      comment: "Geographic region of the design win. Used for regional design win performance and market penetration analysis."
    - name: "target_application"
      expr: target_application
      comment: "Target customer application for the design win. Used to track application-level design win momentum."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the design win. Used to assess revenue quality and pricing strategy by win cohort."
    - name: "win_source"
      expr: win_source
      comment: "Source of the design win (e.g. Direct, Channel, FAE). Used to assess sales motion effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the design win revenue estimates. Required for multi-currency revenue ramp planning."
    - name: "revenue_ramp_start_month"
      expr: DATE_TRUNC('MONTH', revenue_ramp_start_date)
      comment: "Month revenue ramp begins for the design win. Used to build revenue ramp schedules and supply plans."
    - name: "win_month"
      expr: DATE_TRUNC('MONTH', win_timestamp)
      comment: "Month the design win was recorded. Used for cohort analysis and win rate trending."
    - name: "is_key_account"
      expr: is_key_account
      comment: "Indicates whether the design win is at a key/strategic account. Used to prioritize support and track strategic account penetration."
    - name: "export_controlled"
      expr: export_controlled
      comment: "Indicates whether the design win involves export-controlled technology. Used for compliance risk assessment."
  measures:
    - name: "total_estimated_annual_revenue_gross"
      expr: SUM(CAST(estimated_annual_revenue_gross AS DOUBLE))
      comment: "Total estimated annual gross revenue from design wins. Primary long-range revenue indicator used in investor and board reporting."
    - name: "total_estimated_annual_revenue_net"
      expr: SUM(CAST(estimated_annual_revenue_net AS DOUBLE))
      comment: "Total estimated annual net revenue from design wins. Used for net revenue planning and margin forecasting."
    - name: "total_estimated_annual_unit_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Total estimated annual unit volume from design wins. Core input for long-range capacity planning and wafer demand."
    - name: "design_win_count"
      expr: COUNT(1)
      comment: "Total number of design wins. Baseline KPI for design win velocity and sales funnel conversion."
    - name: "distinct_accounts_with_design_wins"
      expr: COUNT(DISTINCT primary_sales_account_id)
      comment: "Number of unique accounts with design wins. Measures customer penetration and design win breadth."
    - name: "avg_estimated_annual_revenue_gross"
      expr: AVG(CAST(estimated_annual_revenue_gross AS DOUBLE))
      comment: "Average estimated annual gross revenue per design win. Tracks deal size trends and product mix quality."
    - name: "avg_forecasted_ramp_rate_per_month"
      expr: AVG(CAST(forecasted_ramp_rate_per_month AS DOUBLE))
      comment: "Average monthly revenue ramp rate across design wins. Used to model revenue ramp curves and supply ramp planning."
    - name: "avg_forecast_accuracy"
      expr: AVG(CAST(forecast_accuracy AS DOUBLE))
      comment: "Average forecast accuracy score across design wins. Measures how reliably design win revenue estimates convert to actuals."
    - name: "total_revenue_adjustment"
      expr: SUM(CAST(revenue_adjustment AS DOUBLE))
      comment: "Total revenue adjustments applied to design wins. Tracks downward revisions and at-risk revenue for pipeline hygiene."
    - name: "avg_competitor_displacement_score"
      expr: AVG(CAST(competitor_displacement_score AS DOUBLE))
      comment: "Average competitor displacement score across design wins. Measures competitive win quality and market share capture effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quoting activity, conversion, and pricing metrics. Tracks quote volume, win/loss rates, discount levels, and average deal values. Used in sales operations reviews, pricing governance, and pipeline conversion analysis."
  source: "`vibe_semiconductors_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (e.g. Draft, Submitted, Won, Lost, Expired). Core dimension for funnel conversion analysis."
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Win or loss outcome of the quote. Used to calculate win rates and analyze competitive performance."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region associated with the quote. Enables regional quoting activity and win rate benchmarking."
    - name: "currency"
      expr: currency
      comment: "Transaction currency of the quote. Required for multi-currency pricing analysis."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms (e.g. FOB, CIF, DDP). Used to assess logistics cost impact on deal economics."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for the quote. Used for trade compliance and logistics cost analysis."
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the quote was issued. Used for quoting velocity trending and seasonal demand analysis."
    - name: "is_converted"
      expr: is_converted
      comment: "Indicates whether the quote was converted to a booking. Primary conversion flag for quote-to-order rate calculation."
    - name: "reason_lost"
      expr: reason_lost
      comment: "Reason the quote was lost. Used for competitive intelligence and pricing strategy refinement."
  measures:
    - name: "total_quote_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net quoted amount across all quotes. Measures the value of the quoting pipeline and pricing activity."
    - name: "total_quote_total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross quoted amount including tax. Used for total deal value tracking and revenue pipeline sizing."
    - name: "total_quote_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars across all quotes. Tracks pricing discipline and margin erosion at the quoting stage."
    - name: "total_quote_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all quotes. Used for tax liability estimation and compliance reporting."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes issued. Baseline quoting activity metric for sales productivity and process efficiency."
    - name: "converted_quote_count"
      expr: SUM(CASE WHEN is_converted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quotes converted to bookings. Numerator for quote-to-order conversion rate calculation."
    - name: "avg_quote_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net quoted amount per quote. Tracks average deal size at the quoting stage and ASP trends."
    - name: "avg_discount_amount_per_quote"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per quote. Used to monitor pricing discipline and identify accounts with excessive discounting."
    - name: "distinct_accounts_quoted"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts receiving quotes. Measures quoting reach and customer engagement breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_nre_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) agreement tracking and revenue recognition metrics. NRE agreements are critical for semiconductor design-in revenue and CHIPS Act compliance. Used in engineering services P&L reviews, milestone tracking, and contract management."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_nre_agreement`"
  dimensions:
    - name: "sales_nre_agreement_status"
      expr: sales_nre_agreement_status
      comment: "Current status of the NRE agreement (e.g. Active, Completed, Terminated). Used to filter active vs. closed NRE revenue."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of NRE agreement (e.g. Design, Mask, Characterization). Used to categorize engineering services revenue."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the NRE agreement. Used to track agreements pending approval and revenue at risk."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable committed in the NRE agreement. Used to track engineering output and milestone completion."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the NRE agreement. Enables regional NRE revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the NRE agreement. Required for multi-currency NRE revenue reporting."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the NRE agreement becomes effective. Used for cohort analysis and revenue recognition scheduling."
    - name: "change_order_flag"
      expr: change_order_flag
      comment: "Indicates whether a change order has been issued. Used to track scope changes and associated revenue adjustments."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the NRE agreement includes exclusivity. Used to assess strategic customer commitments."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the NRE agreement. Used for data governance and access control."
  measures:
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_total_amount AS DOUBLE))
      comment: "Total contracted NRE value across all agreements. Primary NRE revenue KPI for engineering services P&L and investor reporting."
    - name: "total_actual_revenue_recognized"
      expr: SUM(CAST(actual_revenue_recognized AS DOUBLE))
      comment: "Total NRE revenue actually recognized. Used to track ASC 606 milestone-based revenue recognition progress."
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted NRE revenue. Used for financial planning and NRE revenue pipeline sizing."
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total value of milestones across NRE agreements. Used to track milestone billing and cash flow from NRE contracts."
    - name: "nre_agreement_count"
      expr: COUNT(1)
      comment: "Total number of NRE agreements. Baseline metric for NRE deal volume and engineering services pipeline."
    - name: "distinct_accounts_with_nre"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with NRE agreements. Measures design-in customer breadth and strategic engagement depth."
    - name: "avg_nre_total_amount"
      expr: AVG(CAST(nre_total_amount AS DOUBLE))
      comment: "Average NRE contract value. Tracks deal size trends in engineering services and informs pricing strategy."
    - name: "nre_revenue_recognition_gap"
      expr: SUM((CAST(nre_total_amount AS DOUBLE)) - (CAST(actual_revenue_recognized AS DOUBLE)))
      comment: "Difference between contracted NRE value and recognized revenue. Measures deferred NRE revenue and milestone completion risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_customer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contract portfolio metrics covering contract value, credit exposure, and renewal risk. Used in contract management reviews, credit risk assessments, and revenue assurance processes."
  source: "`vibe_semiconductors_v1`.`sales`.`customer_contract`"
  dimensions:
    - name: "customer_contract_status"
      expr: customer_contract_status
      comment: "Current status of the customer contract (e.g. Active, Expired, Terminated). Used to filter active contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of customer contract (e.g. Master Supply, NRE, Blanket). Used to segment contract portfolio by structure."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the contract. Enables regional contract portfolio analysis."
    - name: "currency"
      expr: currency
      comment: "Contract currency. Required for multi-currency contract value reporting."
    - name: "invoicing_frequency"
      expr: invoicing_frequency
      comment: "Frequency of invoicing under the contract (e.g. Monthly, Milestone, Quarterly). Used for cash flow planning."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Customer credit rating associated with the contract. Used for credit risk management and AR exposure analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether the contract auto-renews. Used to forecast contract renewal revenue and manage renewal risk."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the contract became effective. Used for contract cohort analysis and revenue recognition scheduling."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node covered by the contract. Used to analyze contract portfolio by process technology generation."
    - name: "product_family"
      expr: product_family
      comment: "Product family covered by the contract. Used for product-line contract coverage analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total contracted value across all customer contracts. Primary contract portfolio KPI for revenue assurance and financial planning."
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Total annualized contract value (ACV). Used for recurring revenue tracking and ARR/ACV reporting."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all contracts. Used for credit risk exposure management and AR policy compliance."
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS DOUBLE))
      comment: "Total unit volume committed across contracts. Used for supply planning and take-or-pay obligation tracking."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of customer contracts. Baseline metric for contract portfolio size and coverage."
    - name: "distinct_accounts_under_contract"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with active contracts. Measures contracted customer base breadth and revenue assurance coverage."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_total AS DOUBLE))
      comment: "Average contract value per agreement. Tracks deal size trends and informs contract negotiation strategy."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across contracts. Used to monitor pricing discipline and margin impact of contracted discounts."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation, qualification, and conversion metrics. Tracks lead volume, estimated revenue pipeline, and conversion outcomes. Used in marketing effectiveness reviews, demand generation planning, and sales funnel management."
  source: "`vibe_semiconductors_v1`.`sales`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (e.g. New, Qualified, Converted, Disqualified). Core dimension for funnel stage analysis."
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead (e.g. Inbound, Outbound, Referral, Event). Used to assess lead source effectiveness and marketing ROI."
    - name: "source"
      expr: source
      comment: "Lead source channel (e.g. Web, Trade Show, Partner). Used to attribute leads to marketing programs and optimize spend."
    - name: "market_segment"
      expr: market_segment
      comment: "Target market segment of the lead. Used for segment-level demand generation analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the lead. Enables regional lead generation and conversion benchmarking."
    - name: "country"
      expr: country
      comment: "Country of the lead. Used for geographic demand analysis and export compliance screening."
    - name: "conversion_outcome"
      expr: conversion_outcome
      comment: "Outcome of lead conversion (e.g. Won, Lost, Nurture). Used to assess lead quality and conversion effectiveness."
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_timestamp)
      comment: "Month the lead was created. Used for lead generation velocity trending and cohort analysis."
    - name: "is_nre"
      expr: is_nre
      comment: "Indicates whether the lead involves NRE services. Used to segment NRE vs. product revenue pipeline."
    - name: "target_application"
      expr: target_application
      comment: "Target application for the lead. Used to track application-level demand generation and design-in pipeline."
  measures:
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue from all leads. Measures the top-of-funnel revenue pipeline and marketing-generated opportunity value."
    - name: "total_estimated_quantity"
      expr: SUM(CAST(estimated_quantity AS DOUBLE))
      comment: "Total estimated unit volume from leads. Used for early-stage demand planning and capacity signaling."
    - name: "lead_count"
      expr: COUNT(1)
      comment: "Total number of leads. Baseline metric for lead generation volume and marketing program effectiveness."
    - name: "avg_estimated_revenue_per_lead"
      expr: AVG(CAST(estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per lead. Used to assess lead quality and prioritize high-value lead follow-up."
    - name: "distinct_companies_in_pipeline"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique companies (accounts) with active leads. Measures market reach and new logo pipeline breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_rebate_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate program financial exposure and payout metrics. Tracks rebate accruals, maximum payout exposure, and program coverage. Used in channel finance reviews, partner management, and margin management."
  source: "`vibe_semiconductors_v1`.`sales`.`rebate_program`"
  dimensions:
    - name: "rebate_program_status"
      expr: rebate_program_status
      comment: "Current status of the rebate program (e.g. Active, Expired, Pending). Used to filter active rebate exposure."
    - name: "program_type"
      expr: program_type
      comment: "Type of rebate program (e.g. Volume, Growth, Loyalty). Used to categorize rebate spend by program structure."
    - name: "partner_type"
      expr: partner_type
      comment: "Type of channel partner receiving the rebate (e.g. Distributor, VAR, Rep). Used for channel-level rebate analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the rebate program. Enables regional rebate spend and channel performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rebate program. Required for multi-currency rebate liability reporting."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the rebate (e.g. Pending, Settled, Disputed). Used to track rebate payment obligations."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue the rebate (e.g. Periodic, Milestone). Used for financial accrual accuracy and audit compliance."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the rebate program becomes effective. Used for program cohort analysis and accrual period tracking."
  measures:
    - name: "total_max_payout_exposure"
      expr: SUM(CAST(max_payout_amount AS DOUBLE))
      comment: "Total maximum rebate payout exposure across all programs. Primary financial liability KPI for channel finance and margin management."
    - name: "rebate_program_count"
      expr: COUNT(1)
      comment: "Total number of active rebate programs. Used to assess channel incentive complexity and administrative burden."
    - name: "distinct_accounts_with_rebates"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts enrolled in rebate programs. Measures rebate program reach and channel coverage."
    - name: "avg_max_payout_per_program"
      expr: AVG(CAST(max_payout_amount AS DOUBLE))
      comment: "Average maximum payout per rebate program. Used to benchmark program generosity and assess margin impact per partner."
    - name: "total_tier1_threshold_amount"
      expr: SUM(CAST(tier1_threshold_amount AS DOUBLE))
      comment: "Total Tier 1 revenue threshold across all rebate programs. Used to assess how much channel revenue must be generated to trigger rebates."
    - name: "total_tier2_threshold_amount"
      expr: SUM(CAST(tier2_threshold_amount AS DOUBLE))
      comment: "Total Tier 2 revenue threshold across all rebate programs. Used to assess stretch targets and incremental rebate exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign spend, ROI, and performance metrics. Tracks budget utilization, estimated ROI, and campaign coverage by product family and region. Used in marketing effectiveness reviews and budget allocation decisions."
  source: "`vibe_semiconductors_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g. Planning, Active, Completed). Used to filter active vs. historical campaigns."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of marketing campaign (e.g. Digital, Event, Partner). Used to assess channel mix and marketing spend allocation."
    - name: "channel"
      expr: channel
      comment: "Marketing channel used for the campaign. Used to evaluate channel effectiveness and optimize media mix."
    - name: "region"
      expr: region
      comment: "Geographic region targeted by the campaign. Enables regional marketing spend and effectiveness analysis."
    - name: "target_market"
      expr: target_market
      comment: "Target market segment for the campaign. Used to align marketing investment with strategic market priorities."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the campaign. Used to assess execution risk and prioritize campaign management attention."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign starts. Used for marketing calendar planning and spend timing analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the campaign has compliance requirements. Used for regulatory and export compliance screening."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total marketing budget allocated across all campaigns. Primary marketing spend KPI for budget management and ROI analysis."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend across all campaigns. Used to track budget utilization and identify over/under-spend."
    - name: "total_roi_estimate"
      expr: SUM(CAST(roi_estimate AS DOUBLE))
      comment: "Total estimated ROI across all campaigns. Used to assess aggregate marketing investment return and justify budget."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline metric for marketing activity volume and program coverage."
    - name: "avg_roi_estimate_per_campaign"
      expr: AVG(CAST(roi_estimate AS DOUBLE))
      comment: "Average estimated ROI per campaign. Used to benchmark campaign effectiveness and prioritize high-ROI programs."
    - name: "budget_utilization_amount"
      expr: SUM((CAST(actual_spend AS DOUBLE)) - (CAST(budget_amount AS DOUBLE)))
      comment: "Difference between actual spend and budget (positive = over budget, negative = under budget). Used for budget variance management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory coverage and revenue target metrics. Tracks territory revenue targets, coverage structure, and geographic distribution. Used in sales planning, quota setting, and territory design reviews."
  source: "`vibe_semiconductors_v1`.`sales`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g. Active, Inactive, Restructuring). Used to filter active territory portfolio."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (e.g. Named Account, Geographic, Vertical). Used to analyze territory structure and coverage model."
    - name: "region_code"
      expr: region_code
      comment: "Regional code of the territory. Used for geographic aggregation and regional performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the territory. Used for country-level revenue target and coverage analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the territory targets apply to. Used for annual quota planning and year-over-year comparison."
    - name: "is_overlay"
      expr: is_overlay
      comment: "Indicates whether the territory is an overlay (specialist) territory. Used to assess overlay coverage and cost."
    - name: "multi_rep_coverage"
      expr: multi_rep_coverage
      comment: "Indicates whether the territory has multiple rep coverage. Used to assess coverage model complexity and cost."
    - name: "channel_tier"
      expr: channel_tier
      comment: "Channel tier classification of the territory. Used to align territory management with channel strategy."
  measures:
    - name: "total_revenue_target_amount"
      expr: SUM(CAST(revenue_target_amount AS DOUBLE))
      comment: "Total revenue target across all territories. Primary quota and target-setting KPI for sales planning and performance management."
    - name: "territory_count"
      expr: COUNT(1)
      comment: "Total number of territories. Used to assess sales coverage model scale and territory design efficiency."
    - name: "avg_revenue_target_per_territory"
      expr: AVG(CAST(revenue_target_amount AS DOUBLE))
      comment: "Average revenue target per territory. Used to assess quota equity and identify over/under-loaded territories."
$$;