-- Metric views for domain: shared | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`shared_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic geographic and demographic KPIs for the shared region master. Enables executives to assess market size, economic potential, urbanization trends, and regional hierarchy depth across the enterprise geographic footprint."
  source: "`vibe_consumer_goods_v1`.`shared`.`region`"
  dimensions:
    - name: "region_type"
      expr: region_type
      comment: "Classification of the region (e.g., country, state, metro, territory) — primary grouping for geographic roll-ups."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Depth level within the regional hierarchy, enabling drill-down from global to local."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate classification of the region, used for demand planning and product assortment decisions."
    - name: "iso_country_code"
      expr: iso_country_code
      comment: "ISO country code for the region, enabling country-level aggregation and regulatory alignment."
    - name: "region_status"
      expr: region_status
      comment: "Operational status of the region (e.g., active, inactive, planned), used to filter live vs. historical geographies."
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Flag indicating whether the region spans multiple national borders, relevant for trade compliance and logistics planning."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language spoken in the region, used for localization and marketing targeting decisions."
    - name: "time_zone"
      expr: time_zone
      comment: "Time zone of the region, used for operational scheduling and reporting alignment."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the region definition became effective, enabling trend analysis of geographic restructuring."
    - name: "effective_until_year"
      expr: YEAR(effective_until)
      comment: "Year the region definition expires or expired, used to identify regions undergoing redefinition."
  measures:
    - name: "total_regions"
      expr: COUNT(DISTINCT region_id)
      comment: "Total count of distinct active and historical regions in the master. Executives use this to understand the breadth of the geographic footprint and track expansion or consolidation."
    - name: "total_population"
      expr: SUM(CAST(population AS DOUBLE))
      comment: "Aggregate population across all regions in scope. A primary indicator of total addressable market size for consumer goods planning and investment prioritization."
    - name: "avg_population_per_region"
      expr: AVG(CAST(population AS DOUBLE))
      comment: "Average population per region. Used to identify under-served or over-indexed geographies relative to the portfolio footprint."
    - name: "total_gdp_usd"
      expr: SUM(CAST(gdp_usd AS DOUBLE))
      comment: "Total GDP (USD) summed across all regions in scope. Directly measures the economic value of the markets the business operates in, informing investment and resource allocation decisions."
    - name: "avg_gdp_usd_per_region"
      expr: AVG(CAST(gdp_usd AS DOUBLE))
      comment: "Average GDP per region. Enables comparison of economic weight across geographic segments to prioritize high-value markets."
    - name: "total_area_sq_km"
      expr: SUM(CAST(area_sq_km AS DOUBLE))
      comment: "Total geographic area in square kilometers covered by all regions in scope. Used in logistics network design and distribution density analysis."
    - name: "avg_area_sq_km_per_region"
      expr: AVG(CAST(area_sq_km AS DOUBLE))
      comment: "Average geographic area per region. Helps identify regions that may require denser distribution infrastructure relative to their size."
    - name: "avg_median_income_usd"
      expr: AVG(CAST(median_income_usd AS DOUBLE))
      comment: "Average median household income (USD) across regions. A key consumer purchasing power indicator used in pricing strategy, product tiering, and market entry decisions."
    - name: "total_median_income_usd"
      expr: SUM(CAST(median_income_usd AS DOUBLE))
      comment: "Sum of median income across regions (proxy for aggregate consumer spending capacity). Used in portfolio prioritization and revenue potential modeling."
    - name: "avg_urbanization_rate"
      expr: AVG(CAST(urbanization_rate AS DOUBLE))
      comment: "Average urbanization rate across regions. Urbanization drives channel mix (modern trade vs. traditional trade) and is a critical input to go-to-market strategy."
    - name: "max_urbanization_rate"
      expr: MAX(urbanization_rate)
      comment: "Highest urbanization rate among regions in scope. Identifies the most urban markets, which typically have the highest modern-trade penetration and premium product opportunity."
    - name: "min_urbanization_rate"
      expr: MIN(urbanization_rate)
      comment: "Lowest urbanization rate among regions in scope. Identifies the most rural markets, which may require different distribution and product strategies."
    - name: "cross_border_region_count"
      expr: COUNT(DISTINCT CASE WHEN is_cross_border = TRUE THEN region_id END)
      comment: "Number of regions that span multiple national borders. Executives use this to quantify trade compliance complexity and cross-border logistics exposure."
    - name: "cross_border_region_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_cross_border = TRUE THEN region_id END) / NULLIF(COUNT(DISTINCT region_id), 0), 2)
      comment: "Percentage of regions that are cross-border. A rising share signals increasing regulatory and logistics complexity in the geographic footprint."
    - name: "gdp_per_capita_proxy"
      expr: ROUND(SUM(CAST(gdp_usd AS DOUBLE)) / NULLIF(SUM(CAST(population AS DOUBLE)), 0), 2)
      comment: "Aggregate GDP divided by aggregate population — a proxy for GDP per capita across the regional portfolio. Used to rank markets by economic productivity and consumer spending potential."
    - name: "population_density_proxy"
      expr: ROUND(SUM(CAST(population AS DOUBLE)) / NULLIF(SUM(CAST(area_sq_km AS DOUBLE)), 0), 4)
      comment: "Aggregate population divided by aggregate area — a proxy for population density across regions. Informs distribution network design, last-mile logistics investment, and retail coverage strategy."
    - name: "active_region_count"
      expr: COUNT(DISTINCT CASE WHEN region_status = 'active' THEN region_id END)
      comment: "Count of regions currently in active status. Tracks the live operational geographic footprint versus historical or planned regions."
    - name: "top_level_region_count"
      expr: COUNT(DISTINCT CASE WHEN parent_region_id IS NULL THEN region_id END)
      comment: "Count of root-level regions (those with no parent). Indicates the number of top-level geographic groupings, used to assess hierarchy breadth and reporting structure."
$$;
