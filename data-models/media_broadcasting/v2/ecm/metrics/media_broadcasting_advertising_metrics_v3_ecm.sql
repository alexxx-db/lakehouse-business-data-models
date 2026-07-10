-- Metric views for domain: advertising | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_ad_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core advertising inventory KPIs measuring available supply, estimated audience delivery, pricing yield, and inventory health. Used by yield management, sales leadership, and revenue operations to steer inventory monetization strategy."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`ad_inventory`"
  dimensions:
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of ad inventory unit (e.g. linear, digital, OTT) — primary segmentation axis for yield and pricing analysis."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory unit (e.g. available, held, sold, preempted) — used to filter and segment supply health dashboards."
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier assigned to the inventory unit — used to segment revenue yield and rate card compliance analysis."
    - name: "sales_category"
      expr: sales_category
      comment: "Sales category classification (e.g. upfront, scatter, direct) — key dimension for revenue mix and sales strategy reporting."
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating of the surrounding program — used to segment inventory by advertiser suitability and brand safety tiers."
    - name: "ad_pod_position"
      expr: ad_pod_position
      comment: "Position of the ad within the pod (e.g. first, last, middle) — used to analyze premium pod positioning and pricing premiums."
    - name: "preemptible"
      expr: preemptible
      comment: "Whether the inventory unit is preemptible — used to segment guaranteed vs. preemptible inventory for risk and yield analysis."
    - name: "makegood_eligible"
      expr: makegood_eligible
      comment: "Whether the unit qualifies for makegood replacement — used to track liability exposure in delivery shortfall scenarios."
    - name: "blackout_restriction"
      expr: blackout_restriction
      comment: "Whether a blackout restriction applies — used to identify restricted inventory that cannot be monetized in certain markets."
    - name: "inventory_date"
      expr: DATE_TRUNC('month', inventory_date)
      comment: "Month of the inventory date — used for time-series trending of supply volume and pricing across broadcast months."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the inventory becomes effective — used for forward-looking supply planning and upfront/scatter cycle analysis."
  measures:
    - name: "total_inventory_units"
      expr: COUNT(1)
      comment: "Total number of ad inventory units. Baseline supply volume KPI used by yield management to assess total sellable universe and track inventory growth or contraction over time."
    - name: "total_estimated_impressions"
      expr: SUM(CAST(estimated_impressions AS DOUBLE))
      comment: "Sum of estimated audience impressions across all inventory units. Core audience delivery supply metric used by sales leadership to size total addressable audience and set upfront/scatter pricing floors."
    - name: "avg_estimated_impressions_per_unit"
      expr: AVG(CAST(estimated_impressions AS DOUBLE))
      comment: "Average estimated impressions per inventory unit. Measures audience density per unit — used to identify high-value inventory clusters and inform premium pricing decisions."
    - name: "total_estimated_grp"
      expr: SUM(CAST(estimated_grp AS DOUBLE))
      comment: "Sum of estimated Gross Rating Points across all inventory units. GRP is the primary currency for linear TV advertising — used by sales and planning teams to size audience delivery commitments and negotiate upfront deals."
    - name: "avg_estimated_grp_per_unit"
      expr: AVG(CAST(estimated_grp AS DOUBLE))
      comment: "Average GRP per inventory unit. Measures the audience rating weight of individual units — used to identify high-GRP dayparts and programs that command premium rates."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Sum of estimated unique reach across all inventory units. Reach is a key planning metric for advertisers seeking broad audience coverage — used to validate campaign reach commitments and negotiate scatter pricing."
    - name: "total_estimated_trp"
      expr: SUM(CAST(estimated_trp AS DOUBLE))
      comment: "Sum of estimated Target Rating Points across all inventory units. TRP measures audience delivery against a specific demographic target — used by sales to price and guarantee demographic-targeted campaigns."
    - name: "avg_estimated_trp_per_unit"
      expr: AVG(CAST(estimated_trp AS DOUBLE))
      comment: "Average TRP per inventory unit. Measures demographic targeting efficiency per unit — used to identify inventory with strong target audience concentration for premium demographic pricing."
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average rate card CPM (cost per thousand impressions) across inventory units. Primary pricing benchmark used by revenue management to assess rate card competitiveness and identify pricing gaps by segment."
    - name: "total_rate_card_cpm_value"
      expr: SUM(CAST(rate_card_cpm AS DOUBLE))
      comment: "Sum of rate card CPM values across all inventory units. Used as a proxy for total theoretical revenue potential of the inventory pool at rate card pricing — informs revenue ceiling analysis."
    - name: "avg_rate_card_cprp"
      expr: AVG(CAST(rate_card_cprp AS DOUBLE))
      comment: "Average rate card cost per rating point (CPRP) across inventory units. CPRP is the standard GRP-based pricing metric in linear TV — used by sales leadership to benchmark pricing against market rates and competitor networks."
    - name: "avg_hut_index"
      expr: AVG(CAST(hut_index AS DOUBLE))
      comment: "Average Households Using Television (HUT) index across inventory units. HUT measures the proportion of TV households tuned in — used by programming and sales to assess daypart audience engagement and set pricing floors."
    - name: "avg_put_index"
      expr: AVG(CAST(put_index AS DOUBLE))
      comment: "Average Persons Using Television (PUT) index across inventory units. PUT measures individual viewer engagement — used alongside HUT to assess audience composition and validate demographic targeting assumptions."
    - name: "cpm_to_cprp_ratio"
      expr: ROUND(AVG(CAST(rate_card_cpm AS DOUBLE)) / NULLIF(AVG(CAST(rate_card_cprp AS DOUBLE)), 0), 4)
      comment: "Ratio of average CPM to average CPRP. Measures the implied impressions-per-rating-point relationship — used by yield management to detect pricing inconsistencies between CPM and GRP-based rate structures and flag arbitrage opportunities."
    - name: "grp_per_impression_yield"
      expr: ROUND(SUM(CAST(estimated_grp AS DOUBLE)) / NULLIF(SUM(CAST(estimated_impressions AS DOUBLE)), 0), 6)
      comment: "GRP delivered per estimated impression. Measures the rating-point density of the inventory pool — used to identify high-efficiency inventory where GRP delivery is disproportionately strong relative to raw impression volume, informing premium pricing."
    - name: "trp_to_grp_targeting_efficiency"
      expr: ROUND(SUM(CAST(estimated_trp AS DOUBLE)) / NULLIF(SUM(CAST(estimated_grp AS DOUBLE)), 0), 4)
      comment: "Ratio of total TRP to total GRP. Measures what fraction of total audience delivery hits the target demographic — a targeting efficiency index used by sales to justify demographic premium pricing and validate audience guarantee commitments."
    - name: "makegood_eligible_unit_count"
      expr: COUNT(CASE WHEN makegood_eligible = TRUE THEN 1 END)
      comment: "Count of inventory units eligible for makegood replacement. Measures the pool of units that could generate makegood liability — used by traffic and finance to size potential delivery shortfall exposure and reserve replacement inventory."
    - name: "preemptible_unit_count"
      expr: COUNT(CASE WHEN preemptible = TRUE THEN 1 END)
      comment: "Count of preemptible inventory units. Measures the volume of at-risk inventory that can be displaced by higher-rated orders — used by yield management to balance guaranteed vs. preemptible mix and optimize revenue under demand uncertainty."
    - name: "blackout_restricted_unit_count"
      expr: COUNT(CASE WHEN blackout_restriction = TRUE THEN 1 END)
      comment: "Count of inventory units subject to blackout restrictions. Measures the volume of inventory that cannot be monetized in restricted markets — used by rights and sales operations to quantify revenue impact of blackout obligations."
    - name: "preemptible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preemptible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of total inventory units that are preemptible. A key yield management KPI — high preemptible rates indicate revenue risk from displacement; executives use this to set guaranteed inventory floors and pricing strategy."
    - name: "makegood_liability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN makegood_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory units eligible for makegood. Measures the proportion of the inventory pool carrying delivery liability — used by finance and sales operations to size contingent liability reserves and negotiate makegood policies."
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels represented in the inventory pool. Used by sales leadership to assess breadth of channel coverage and identify under-monetized channels requiring yield improvement focus."
    - name: "distinct_demographic_segments"
      expr: COUNT(DISTINCT demographic_segment_id)
      comment: "Number of distinct demographic segments targeted across inventory units. Measures the demographic breadth of the inventory portfolio — used by sales strategy to assess addressability and cross-demographic packaging opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate card pricing KPIs measuring CPM/CPRP/GRP pricing levels, rate card health, discount structure, and seasonal pricing dynamics. Used by revenue management, sales leadership, and pricing strategy teams to govern rate card competitiveness and pricing discipline."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`rate_card`"
  dimensions:
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of inventory the rate card applies to (e.g. linear, digital, OTT) — primary segmentation for pricing analysis across inventory categories."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type classification (e.g. gross, net, package) — used to segment pricing analysis by rate structure and identify gross-to-net spread patterns."
    - name: "rate_card_status"
      expr: rate_card_status
      comment: "Current status of the rate card (e.g. active, expired, pending approval) — used to filter analysis to live rate cards and track rate card lifecycle management."
    - name: "daypart"
      expr: daypart
      comment: "Daypart associated with the rate card (e.g. primetime, daytime, late night) — key pricing dimension for daypart-level rate benchmarking and yield analysis."
    - name: "program_genre"
      expr: program_genre
      comment: "Genre of the program associated with the rate card — used to analyze pricing premiums by content genre and identify high-value programming categories."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market the rate card applies to — used for market-level pricing analysis and to identify regional pricing disparities."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the rate card — used to segment multi-currency pricing analysis and ensure consistent currency-adjusted comparisons."
    - name: "discount_eligibility"
      expr: discount_eligibility
      comment: "Discount eligibility classification for the rate card — used to analyze discount exposure and enforce pricing floor policies."
    - name: "preemption_priority"
      expr: preemption_priority
      comment: "Preemption priority level of the rate card — used to analyze the relationship between preemption risk and pricing levels."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rate card becomes effective — used for time-series analysis of pricing trends and rate card refresh cycles."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the rate card expires — used to track rate card tenure and identify stale rate cards requiring refresh."
  measures:
    - name: "total_rate_cards"
      expr: COUNT(1)
      comment: "Total number of rate card records. Baseline volume KPI used to track rate card portfolio size and governance — excessive proliferation of rate cards signals pricing complexity and compliance risk."
    - name: "avg_gross_rate"
      expr: AVG(CAST(gross_rate AS DOUBLE))
      comment: "Average gross rate across all rate cards. Primary pricing level KPI used by revenue management to benchmark gross pricing against market rates and track rate card inflation or deflation over time."
    - name: "avg_net_rate"
      expr: AVG(CAST(net_rate AS DOUBLE))
      comment: "Average net rate across all rate cards. Net rate is the actual realized price after agency commissions — used by finance and sales leadership to assess true revenue yield and net revenue forecasting."
    - name: "total_gross_rate_value"
      expr: SUM(CAST(gross_rate AS DOUBLE))
      comment: "Sum of gross rates across all rate cards. Measures total theoretical gross revenue potential of the rate card portfolio — used as a ceiling benchmark for revenue planning and upfront deal sizing."
    - name: "total_net_rate_value"
      expr: SUM(CAST(net_rate AS DOUBLE))
      comment: "Sum of net rates across all rate cards. Measures total net revenue potential of the rate card portfolio — used by finance for revenue recognition planning and order-to-cash reconciliation."
    - name: "avg_cpm_basis"
      expr: AVG(CAST(cpm_basis AS DOUBLE))
      comment: "Average CPM basis (cost per thousand impressions) across rate cards. The CPM basis is the foundational pricing unit for digital and addressable inventory — used by pricing strategy to set competitive CPM floors and ceilings."
    - name: "avg_grp_value"
      expr: AVG(CAST(grp_value AS DOUBLE))
      comment: "Average GRP value (cost per rating point) across rate cards. GRP value is the primary pricing currency for linear TV — used by sales leadership to benchmark CPRP against Nielsen-reported market rates and competitor networks."
    - name: "avg_trp_value"
      expr: AVG(CAST(trp_value AS DOUBLE))
      comment: "Average TRP value (cost per target rating point) across rate cards. TRP value measures the price of demographic-targeted delivery — used by sales to price and justify demographic premium rate cards."
    - name: "avg_seasonality_factor"
      expr: AVG(CAST(seasonality_factor AS DOUBLE))
      comment: "Average seasonality adjustment factor across rate cards. Measures the magnitude of seasonal pricing adjustments — used by revenue management to validate that seasonal premiums (e.g. Q4 uplifts) are correctly applied and competitively calibrated."
    - name: "gross_to_net_rate_spread"
      expr: ROUND(AVG(CAST(gross_rate AS DOUBLE)) - AVG(CAST(net_rate AS DOUBLE)), 2)
      comment: "Difference between average gross rate and average net rate. Measures the average agency commission and discount burden — used by finance and sales leadership to monitor net revenue erosion and enforce pricing floor discipline."
    - name: "net_to_gross_rate_ratio"
      expr: ROUND(AVG(CAST(net_rate AS DOUBLE)) / NULLIF(AVG(CAST(gross_rate AS DOUBLE)), 0), 4)
      comment: "Ratio of average net rate to average gross rate. Measures pricing efficiency — how much of the gross rate is retained after commissions and discounts. A declining ratio signals increasing discount pressure or agency commission creep."
    - name: "cpm_to_grp_value_ratio"
      expr: ROUND(AVG(CAST(cpm_basis AS DOUBLE)) / NULLIF(AVG(CAST(grp_value AS DOUBLE)), 0), 4)
      comment: "Ratio of average CPM basis to average GRP value. Measures the implied impressions-per-rating-point at the rate card level — used by pricing strategy to detect inconsistencies between CPM and GRP pricing structures and ensure cross-currency rate card coherence."
    - name: "trp_to_grp_pricing_premium"
      expr: ROUND(AVG(CAST(trp_value AS DOUBLE)) / NULLIF(AVG(CAST(grp_value AS DOUBLE)), 0), 4)
      comment: "Ratio of average TRP value to average GRP value. Measures the demographic targeting premium embedded in rate cards — a ratio above 1.0 indicates advertisers pay a premium for targeted demographic delivery, validating addressable pricing strategy."
    - name: "seasonality_adjusted_avg_gross_rate"
      expr: ROUND(AVG(CAST(gross_rate AS DOUBLE) * CAST(seasonality_factor AS DOUBLE)), 2)
      comment: "Average gross rate adjusted by the seasonality factor. Measures the effective seasonal pricing level — used by revenue forecasting to project seasonally-adjusted revenue and validate that seasonal rate card uplifts are correctly reflected in deal pricing."
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels covered by rate cards. Used by pricing governance to ensure all monetized channels have active rate cards and identify channels with missing or expired rate card coverage."
    - name: "distinct_demographic_segments"
      expr: COUNT(DISTINCT demographic_segment_id)
      comment: "Number of distinct demographic segments with rate card coverage. Measures the breadth of demographic pricing — used by sales strategy to identify demographic segments lacking dedicated rate cards and prioritize pricing development."
    - name: "active_rate_card_count"
      expr: COUNT(CASE WHEN rate_card_status = 'active' THEN 1 END)
      comment: "Count of currently active rate cards. Used by pricing governance to monitor the live rate card portfolio size — excessive active rate cards signal pricing complexity; too few signal coverage gaps."
    - name: "avg_gross_rate_primetime"
      expr: ROUND(AVG(CASE WHEN daypart = 'primetime' THEN gross_rate END), 2)
      comment: "Average gross rate for primetime daypart rate cards. Primetime commands the highest pricing premiums in linear TV — used by revenue management to benchmark primetime pricing against market rates and track premium erosion."
    - name: "max_gross_rate"
      expr: MAX(gross_rate)
      comment: "Maximum gross rate across all rate cards. Identifies the pricing ceiling in the rate card portfolio — used by sales leadership to understand the top of the rate range and ensure premium inventory is priced at market-leading levels."
    - name: "min_net_rate"
      expr: MIN(net_rate)
      comment: "Minimum net rate across all rate cards. Identifies the pricing floor in the rate card portfolio — used by revenue management to enforce minimum net rate policies and prevent below-floor deal approvals."
$$;