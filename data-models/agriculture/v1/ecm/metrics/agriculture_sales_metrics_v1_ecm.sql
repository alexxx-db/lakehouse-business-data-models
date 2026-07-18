-- Metric views for domain: sales | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order level KPIs for revenue and profitability analysis"
  source: "`agriculture_ecm`.`sales`.`order`"
  dimensions:
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the order date"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales distribution channel used for the order"
    - name: "sales_organization_id"
      expr: sales_organization_id
      comment: "Identifier of the sales organization responsible for the order"
    - name: "broker_id"
      expr: broker_id
      comment: "Broker associated with the order"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of sales orders"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross amount for all orders"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amount for all orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amount for all orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discount amount applied to orders"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per order"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line‑level financial and volume metrics for detailed sales analysis"
  source: "`agriculture_ecm`.`sales`.`order_line`"
  dimensions:
    - name: "commodity_code"
      expr: commodity_code
      comment: "Code of the commodity sold"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line"
    - name: "delivery_location_code"
      expr: delivery_location_code
      comment: "Code of the delivery location for the line"
  measures:
    - name: "order_line_count"
      expr: COUNT(1)
      comment: "Total number of order line items"
    - name: "total_line_net_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Sum of net amount for all order lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across order lines"
    - name: "distinct_orders"
      expr: COUNT(DISTINCT order_id)
      comment: "Number of distinct orders represented in the line items"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract‑level KPIs for volume commitment and pricing"
  source: "`agriculture_ecm`.`sales`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type/category of the contract"
    - name: "broker_id"
      expr: broker_id
      comment: "Broker responsible for the contract"
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts"
    - name: "total_contracted_volume_mt"
      expr: SUM(CAST(contracted_volume AS DOUBLE))
      comment: "Sum of contracted volume (metric tons) across contracts"
    - name: "total_fulfilled_volume_mt"
      expr: SUM(CAST(fulfilled_volume AS DOUBLE))
      comment: "Sum of fulfilled volume (metric tons) across contracts"
    - name: "average_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average contract price per unit"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opportunity pipeline metrics for forecasting and pipeline health"
  source: "`agriculture_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current stage of the opportunity in the sales pipeline"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the opportunity is pursued"
    - name: "gmo_flag"
      expr: gmo_flag
      comment: "Indicates if the product involves GMO"
    - name: "organic_certified"
      expr: organic_certified
      comment: "Indicates if the product is organically certified"
    - name: "expected_close_month"
      expr: DATE_TRUNC('month', expected_close_date)
      comment: "Month of the expected close date"
  measures:
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of sales opportunities"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Sum of estimated revenue for all opportunities"
    - name: "total_estimated_volume"
      expr: SUM(CAST(estimated_volume AS DOUBLE))
      comment: "Sum of estimated volume for all opportunities"
    - name: "average_close_probability_pct"
      expr: AVG(CAST(close_probability_pct AS DOUBLE))
      comment: "Average probability of closing across opportunities"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting KPIs to support supply planning and inventory decisions"
  source: "`agriculture_ecm`.`sales`.`demand_forecast`"
  dimensions:
    - name: "forecast_period_type"
      expr: forecast_period_type
      comment: "Granularity of the forecast period (e.g., monthly, quarterly)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast"
    - name: "forecast_start_month"
      expr: DATE_TRUNC('month', forecast_period_start_date)
      comment: "Month when the forecast period starts"
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity being forecasted"
    - name: "territory_id"
      expr: territory_id
      comment: "Territory for which the forecast is made"
  measures:
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of demand forecast records"
    - name: "total_forecasted_volume"
      expr: SUM(CAST(forecasted_volume AS DOUBLE))
      comment: "Sum of forecasted volume across all forecasts"
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Sum of forecasted revenue across all forecasts"
    - name: "average_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_pct AS DOUBLE))
      comment: "Average forecast accuracy percentage"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_market_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market price snapshot metrics for pricing strategy and market monitoring"
  source: "`agriculture_ecm`.`sales`.`market_price`"
  dimensions:
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity identifier"
    - name: "country_code"
      expr: country_code
      comment: "Country for which the price is reported"
    - name: "price_date"
      expr: price_date
      comment: "Date of the price observation"
  measures:
    - name: "price_record_count"
      expr: COUNT(1)
      comment: "Number of market price records"
    - name: "average_ask_price"
      expr: AVG(CAST(ask_price AS DOUBLE))
      comment: "Average ask price across records"
    - name: "average_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average bid price across records"
    - name: "average_close_price"
      expr: AVG(CAST(close_price AS DOUBLE))
      comment: "Average closing price across records"
$$;


CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker performance and capacity metrics for channel management"
  source: "`agriculture_ecm`.`sales`.`broker`"
  dimensions:
    - name: "broker_category"
      expr: broker_category
      comment: "Category classification of the broker"
    - name: "broker_type"
      expr: broker_type
      comment: "Type of broker (e.g., internal, external)"
    - name: "business_country_code"
      expr: business_country_code
      comment: "Country where the broker operates"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates if the broker has exclusive rights"
    - name: "globalg_ap_certified"
      expr: globalg_ap_certified
      comment: "Indicates if the broker is GFSI certified"
  measures:
    - name: "broker_count"
      expr: COUNT(1)
      comment: "Total number of brokers"
    - name: "total_annual_volume_target_mt"
      expr: SUM(CAST(annual_volume_target_mt AS DOUBLE))
      comment: "Sum of annual volume targets (metric tons) across brokers"
    - name: "average_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across brokers"
$$;
