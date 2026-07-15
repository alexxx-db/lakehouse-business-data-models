-- Metric views for domain: finance | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_actual_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates of actual cost transactions for financial analysis"
  source: "`oil_gas_ecm`.`finance`.`actual_cost`"
  dimensions:
    - name: "posting_year"
      expr: DATE_TRUNC('year', posting_date)
      comment: "Fiscal year derived from posting date"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category classification"
    - name: "business_area"
      expr: business_area
      comment: "Business area associated with the cost"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "asset_facility_id"
      expr: asset_facility_id
      comment: "Identifier of the asset facility"
  measures:
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total incurred amount across all actual cost records"
    - name: "total_net_cost_amount"
      expr: SUM(CAST(net_cost_amount AS DOUBLE))
      comment: "Total net cost amount after adjustments"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity associated with actual cost lines"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of actual cost transactions"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key budget aggregates for planning and control"
  source: "`oil_gas_ecm`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., month/quarter)"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., CAPEX, OPEX)"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the budget"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the budget"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total budgeted amount"
    - name: "total_contingency_amount"
      expr: SUM(amount * contingency_percent / 100)
      comment: "Total contingency amount derived from budget amount and contingency percent"
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of budget records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project financial and schedule KPIs"
  source: "`oil_gas_ecm`.`finance`.`project`"
  dimensions:
    - name: "start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Calendar year when the project started"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project"
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project (e.g., development, acquisition)"
    - name: "region"
      expr: region
      comment: "Geographic region of the project"
    - name: "country"
      expr: country
      comment: "Country where the project is located"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center responsible for the project"
  measures:
    - name: "total_capex_budget"
      expr: SUM(CAST(capital_expenditure_budget AS DOUBLE))
      comment: "Total capital expenditure budget across projects"
    - name: "total_opex_budget"
      expr: SUM(CAST(operating_expenditure_budget AS DOUBLE))
      comment: "Total operating expenditure budget across projects"
    - name: "average_project_duration_days"
      expr: AVG(DATEDIFF(end_date, start_date))
      comment: "Average project duration in days"
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of projects"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_project_economics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Economic evaluation metrics for projects"
  source: "`oil_gas_ecm`.`finance`.`project_economics`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of economic evaluation (e.g., base case, sensitivity)"
    - name: "price_deck_scenario"
      expr: price_deck_scenario
      comment: "Pricing scenario used in the analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the economic figures"
    - name: "project_id"
      expr: project_id
      comment: "Identifier of the associated project"
  measures:
    - name: "total_gross_npv"
      expr: SUM(CAST(gross_npv AS DOUBLE))
      comment: "Aggregate gross net present value across economics records"
    - name: "total_net_npv"
      expr: SUM(CAST(net_npv AS DOUBLE))
      comment: "Aggregate net net present value"
    - name: "average_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average internal rate of return"
    - name: "total_capex"
      expr: SUM(CAST(total_capex AS DOUBLE))
      comment: "Total capital expenditure captured in economics"
    - name: "economics_record_count"
      expr: COUNT(1)
      comment: "Number of project economics records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction financial exposure and tax impact"
  source: "`oil_gas_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction"
    - name: "sending_company_code_id"
      expr: sending_company_code_id
      comment: "Company code sending the transaction"
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code receiving the transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Classification of the transaction"
    - name: "product_category"
      expr: product_category
      comment: "Product category involved"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total amount of intercompany transactions"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount associated with intercompany transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of intercompany transaction records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset valuation and depreciation KPIs"
  source: "`oil_gas_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Classification of the asset (e.g., plant, equipment)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset"
    - name: "geographic_location"
      expr: geographic_location
      comment: "Location of the asset"
    - name: "depreciation_key"
      expr: depreciation_key
      comment: "Depreciation method key"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the asset values"
  measures:
    - name: "total_acquisition_value"
      expr: SUM(CAST(acquisition_value AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Cumulative depreciation across assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Aggregate net book value of assets"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed asset records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_impairment_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impairment assessment financial impact"
  source: "`oil_gas_ecm`.`finance`.`impairment_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of impairment assessment"
    - name: "asset_facility_id"
      expr: asset_facility_id
      comment: "Facility associated with the assessed asset"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the assessment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the assessment"
  measures:
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_recognized AS DOUBLE))
      comment: "Total recognized impairment loss"
    - name: "total_carrying_amount"
      expr: SUM(CAST(carrying_amount AS DOUBLE))
      comment: "Total carrying amount before impairment"
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Number of impairment assessments"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax provision and liability overview"
  source: "`oil_gas_ecm`.`finance`.`tax_provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax provision"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the tax provision"
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code associated with the provision"
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., income, VAT)"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Tax jurisdiction code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the tax amounts"
  measures:
    - name: "total_current_tax_expense"
      expr: SUM(CAST(current_tax_expense AS DOUBLE))
      comment: "Aggregate current tax expense"
    - name: "total_deferred_tax_liability"
      expr: SUM(CAST(deferred_tax_liability AS DOUBLE))
      comment: "Total deferred tax liability"
    - name: "average_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate across provisions"
    - name: "tax_provision_count"
      expr: COUNT(1)
      comment: "Number of tax provision records"
$$;
