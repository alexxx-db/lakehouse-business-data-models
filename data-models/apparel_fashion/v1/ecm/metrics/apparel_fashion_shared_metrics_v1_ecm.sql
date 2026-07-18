-- Metric views for domain: shared | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`shared_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic organization performance and health metrics for executive decision-making, including revenue concentration, entity lifecycle, and operational scale indicators."
  source: "`apparel_fashion_ecm`.`shared`.`organization`"
  dimensions:
    - name: "organization_type"
      expr: organization_type
      comment: "Legal or operational classification of the organization (e.g., subsidiary, parent, joint venture) for segmentation analysis."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code for geographic revenue and entity distribution analysis."
    - name: "industry_classification_code"
      expr: industry_classification_code
      comment: "Standard industry classification code (e.g., NAICS, SIC) for vertical market analysis."
    - name: "is_publicly_traded"
      expr: is_publicly_traded
      comment: "Public vs private entity flag for governance and reporting segmentation."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating tier for financial risk and partner quality assessment."
    - name: "status"
      expr: organization_status
      comment: "Current operational status (active, inactive, dissolved) for entity health monitoring."
    - name: "fiscal_year_end_month"
      expr: fiscal_year_end_month
      comment: "Fiscal calendar alignment for period-based financial consolidation."
    - name: "incorporation_year"
      expr: YEAR(incorporation_date)
      comment: "Year of incorporation for entity age cohort analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the organization record became effective for temporal analysis."
  measures:
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Total annual revenue across all organizations - primary top-line performance indicator for portfolio valuation and market share analysis."
    - name: "average_annual_revenue"
      expr: AVG(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Average annual revenue per organization - key metric for entity scale benchmarking and segment profiling."
    - name: "organization_count"
      expr: COUNT(DISTINCT organization_id)
      comment: "Distinct count of organizations - critical for portfolio size tracking, M&A pipeline, and entity consolidation decisions."
    - name: "active_organization_count"
      expr: COUNT(DISTINCT CASE WHEN organization_status = 'active' THEN organization_id END)
      comment: "Count of active organizations - operational health indicator for resource allocation and market presence decisions."
    - name: "publicly_traded_count"
      expr: COUNT(DISTINCT CASE WHEN is_publicly_traded = true THEN organization_id END)
      comment: "Count of publicly traded entities - governance complexity and regulatory exposure metric for compliance planning."
    - name: "total_employee_headcount"
      expr: SUM(CAST(employee_count AS DOUBLE))
      comment: "Total employee headcount across all organizations - workforce scale metric for labor cost modeling and operational capacity planning."
    - name: "average_employee_headcount"
      expr: AVG(CAST(employee_count AS DOUBLE))
      comment: "Average employee count per organization - efficiency and scale benchmark for organizational design decisions."
    - name: "revenue_per_employee"
      expr: SUM(CAST(annual_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(employee_count AS DOUBLE)), 0)
      comment: "Revenue per employee ratio - critical productivity and efficiency KPI for operational excellence and investment prioritization."
    - name: "parent_organization_count"
      expr: COUNT(DISTINCT CASE WHEN parent_organization_id IS NOT NULL THEN organization_id END)
      comment: "Count of subsidiary organizations - structural complexity metric for consolidation strategy and governance design."
    - name: "tax_exempt_organization_count"
      expr: COUNT(DISTINCT CASE WHEN is_tax_exempt = true THEN organization_id END)
      comment: "Count of tax-exempt entities - tax planning and compliance scope metric for financial strategy decisions."
$$;
