-- Metric views for domain: donor | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising revenue metrics derived from individual gift transactions. Tracks donation volume, value, net revenue, matching gifts, and refund rates — essential for fundraising performance management and donor stewardship decisions."
  source: "`vibe_ngo_v1`.`donor`.`gift`"
  dimensions:
    - name: "gift_type"
      expr: gift_type
      comment: "Type of gift (e.g. one-time, recurring, in-kind) — used to segment revenue by giving modality."
    - name: "gift_status"
      expr: gift_status
      comment: "Processing status of the gift (e.g. posted, pending, reversed) — used to filter to confirmed revenue."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Whether the gift is restricted or unrestricted — critical for fund allocation and program planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the gift was made — used for multi-currency revenue analysis."
    - name: "acknowledgement_type"
      expr: acknowledgement_type
      comment: "Method used to acknowledge the gift — used to evaluate stewardship channel effectiveness."
    - name: "matching_gift_flag"
      expr: matching_gift_flag
      comment: "Indicates whether the gift is a corporate matching gift — used to track matched revenue uplift."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Indicates whether the donor chose to remain anonymous — used for recognition and reporting segmentation."
    - name: "tribute_flag"
      expr: tribute_flag
      comment: "Indicates whether the gift was made as a tribute (in honor/memory) — used for tribute program analysis."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Indicates whether the gift was refunded — used to identify and investigate refund patterns."
    - name: "gift_date_month"
      expr: DATE_TRUNC('MONTH', gift_date)
      comment: "Month of the gift date — used for monthly revenue trend analysis."
    - name: "gift_date_year"
      expr: DATE_TRUNC('YEAR', gift_date)
      comment: "Year of the gift date — used for annual fundraising performance comparisons."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month the gift was posted to the general ledger — used for financial period reporting."
  measures:
    - name: "total_gift_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross donation amount received across all gifts. Primary fundraising revenue KPI used in board reporting and campaign performance reviews."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net donation amount after fees and deductions. Reflects actual revenue available to the organization for programming."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred across all gifts. Used to evaluate cost of fundraising and payment channel efficiency."
    - name: "avg_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gift size. A key donor engagement metric — declining averages signal donor fatigue or acquisition of lower-value donors."
    - name: "total_gifts"
      expr: COUNT(1)
      comment: "Total number of gift transactions. Used as the denominator for average gift calculations and to track fundraising volume."
    - name: "unique_donors"
      expr: COUNT(DISTINCT primary_gift_constituent_id)
      comment: "Number of unique donors who made at least one gift. Core donor base size metric used in retention and acquisition analysis."
    - name: "matching_gift_amount"
      expr: SUM(CASE WHEN matching_gift_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from corporate matching gifts. Tracks the uplift from employer match programs — a high-leverage fundraising channel."
    - name: "refund_amount"
      expr: SUM(CASE WHEN refund_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of refunded gifts. Elevated refund amounts signal donor dissatisfaction or processing errors requiring investigation."
    - name: "net_to_gross_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross gift revenue retained after fees. Measures payment channel efficiency — lower ratios indicate high processing costs eroding fundraising yield."
    - name: "avg_match_ratio"
      expr: AVG(CASE WHEN matching_gift_flag = TRUE THEN CAST(match_ratio AS DOUBLE) ELSE NULL END)
      comment: "Average employer match ratio on matched gifts. Used to evaluate the leverage factor of corporate matching gift programs."
    - name: "irs_compliant_gift_count"
      expr: COUNT(CASE WHEN irs_compliant_flag = TRUE THEN 1 ELSE NULL END)
      comment: "Number of gifts confirmed as IRS-compliant. Used for regulatory compliance monitoring and audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge commitment and fulfillment metrics. Tracks total pledge value, outstanding balances, fulfillment rates, and write-offs — essential for cash flow forecasting and donor commitment management."
  source: "`vibe_ngo_v1`.`donor`.`pledge`"
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of the pledge (e.g. active, fulfilled, cancelled, lapsed) — primary filter for pipeline vs. completed pledge analysis."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge (e.g. standard, bequest, challenge) — used to segment commitment pipeline by giving vehicle."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g. monthly, quarterly, annual) — used for cash flow forecasting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the pledge is a recurring commitment — used to distinguish predictable recurring revenue from one-time pledges."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pledge — used for multi-currency pipeline reporting."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates whether the pledge qualifies for employer matching — used to identify uplift opportunities."
    - name: "pledge_date_year"
      expr: DATE_TRUNC('YEAR', pledge_date)
      comment: "Year the pledge was made — used for annual pledge volume and value trend analysis."
    - name: "pledge_date_month"
      expr: DATE_TRUNC('MONTH', pledge_date)
      comment: "Month the pledge was made — used for monthly pipeline and commitment trend analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for pledge cancellation — used to identify systemic issues driving pledge attrition."
  measures:
    - name: "total_pledge_value"
      expr: SUM(CAST(total_pledge_amount AS DOUBLE))
      comment: "Total committed pledge value across all pledges. Represents the full fundraising pipeline and is a primary input to revenue forecasting."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount already collected against pledges. Measures pledge fulfillment progress and actual cash received."
    - name: "total_balance_outstanding"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total outstanding pledge balance yet to be collected. Critical for cash flow forecasting and collections prioritization."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total value written off from uncollectable pledges. Elevated write-offs signal donor attrition or economic stress in the donor base."
    - name: "pledge_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_pledge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total pledged amount that has been collected. Core pledge health KPI — low fulfillment rates trigger donor outreach and collections action."
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_pledge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of pledged value written off as uncollectable. Used to assess pledge portfolio risk and donor reliability."
    - name: "avg_pledge_amount"
      expr: AVG(CAST(total_pledge_amount AS DOUBLE))
      comment: "Average total pledge commitment per pledge record. Used to track changes in donor commitment levels over time."
    - name: "avg_next_installment_amount"
      expr: AVG(CAST(next_installment_amount AS DOUBLE))
      comment: "Average upcoming installment amount across active pledges. Used for near-term cash flow projection."
    - name: "total_pledges"
      expr: COUNT(1)
      comment: "Total number of pledge records. Used as the denominator for pledge-level rate calculations and pipeline volume tracking."
    - name: "unique_pledging_constituents"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents with active or historical pledges. Measures depth of committed donor relationships."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level fundraising performance metrics. Tracks goal attainment, cost of fundraising, ROI, and donor engagement across campaigns — used by fundraising leadership to allocate resources and evaluate campaign effectiveness."
  source: "`vibe_ngo_v1`.`donor`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of fundraising campaign (e.g. annual fund, capital, emergency) — used to benchmark performance within campaign categories."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g. active, closed, planned) — used to filter to in-flight vs. completed campaigns."
    - name: "appeal_channel"
      expr: appeal_channel
      comment: "Primary solicitation channel for the campaign (e.g. direct mail, digital, events) — used for channel effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the campaign financial targets and actuals — used for multi-currency reporting."
    - name: "is_active"
      expr: is_active
      comment: "Whether the campaign is currently active — used to filter dashboards to live campaigns."
    - name: "tax_deductible"
      expr: tax_deductible
      comment: "Whether donations to this campaign are tax-deductible — used for donor communication and compliance reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment of the campaign — used for impact reporting and donor segmentation by cause area."
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Intended donor audience segment for the campaign — used to evaluate segment-specific fundraising performance."
    - name: "campaign_start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the campaign started — used for year-over-year campaign performance comparisons."
    - name: "matching_gift_eligible"
      expr: matching_gift_eligible
      comment: "Whether the campaign is eligible for employer matching gifts — used to identify campaigns with matching uplift potential."
  measures:
    - name: "total_raised_amount"
      expr: SUM(CAST(total_raised_amount AS DOUBLE))
      comment: "Total funds raised across all campaigns. Primary fundraising output metric used in board and executive reporting."
    - name: "total_goal_amount"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Total fundraising goal across all campaigns. Used as the denominator for goal attainment rate calculations."
    - name: "goal_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_raised_amount AS DOUBLE)) / NULLIF(SUM(CAST(goal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising goal achieved. Core campaign effectiveness KPI — below-target campaigns trigger strategy review and resource reallocation."
    - name: "total_cost_of_fundraising"
      expr: SUM(CAST(cost_of_fundraising AS DOUBLE))
      comment: "Total cost incurred to run fundraising campaigns. Used in cost-efficiency analysis and charity watchdog reporting."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment across campaigns. Measures fundraising efficiency — campaigns with low ROI are candidates for restructuring or discontinuation."
    - name: "cost_to_revenue_ratio"
      expr: ROUND(100.0 * SUM(CAST(cost_of_fundraising AS DOUBLE)) / NULLIF(SUM(CAST(total_raised_amount AS DOUBLE)), 0), 2)
      comment: "Cost of fundraising as a percentage of total revenue raised. Industry-standard efficiency metric used by charity evaluators (e.g. Charity Navigator) — high ratios signal inefficient campaigns."
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns. Used for portfolio-level analysis and as a denominator for per-campaign averages."
    - name: "active_campaigns"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 ELSE NULL END)
      comment: "Number of currently active campaigns. Used to monitor fundraising pipeline breadth and resource allocation across live initiatives."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal-level solicitation performance metrics. Tracks response rates, revenue per appeal, ROI, and cost efficiency — used by fundraising teams to optimize solicitation strategies and channel mix."
  source: "`vibe_ngo_v1`.`donor`.`appeal`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g. acquisition, renewal, upgrade) — used to benchmark performance within appeal categories."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g. active, closed, draft) — used to filter to completed appeals for performance analysis."
    - name: "channel"
      expr: channel
      comment: "Solicitation channel used for the appeal (e.g. direct mail, email, telemarketing) — primary dimension for channel effectiveness analysis."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of appeal costs — used for multi-currency cost analysis."
    - name: "control_group_flag"
      expr: control_group_flag
      comment: "Indicates whether the appeal was a control group — used to compare test vs. control performance in A/B testing."
    - name: "test_segment_flag"
      expr: test_segment_flag
      comment: "Indicates whether the appeal was a test segment — used to evaluate experimental solicitation strategies."
    - name: "mailing_date_month"
      expr: DATE_TRUNC('MONTH', mailing_date)
      comment: "Month the appeal was mailed — used for seasonal response rate and revenue trend analysis."
    - name: "mailing_date_year"
      expr: DATE_TRUNC('YEAR', mailing_date)
      comment: "Year the appeal was mailed — used for year-over-year appeal performance comparisons."
    - name: "premium_offered"
      expr: premium_offered
      comment: "Premium or incentive offered with the appeal — used to evaluate the lift from premium-based solicitations."
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated by appeals. Primary output metric for appeal portfolio performance."
    - name: "total_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of running appeals. Used in cost-efficiency and ROI analysis."
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate across appeals. A key solicitation effectiveness metric — declining response rates signal donor fatigue or poor targeting."
    - name: "avg_roi_ratio"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average return on investment ratio across appeals. Used to rank and prioritize appeal channels and formats."
    - name: "revenue_per_cost_ratio"
      expr: ROUND(SUM(CAST(total_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(cost_amount AS DOUBLE)), 0), 2)
      comment: "Revenue generated per dollar spent on appeals. Measures fundraising efficiency — ratios below 1.0 indicate loss-making appeals requiring review."
    - name: "avg_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount across appeals. Used to calibrate solicitation amounts against actual giving capacity and response rates."
    - name: "avg_average_gift_amount"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average of the per-appeal average gift amounts. Used to track gift size trends across the appeal portfolio."
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of appeals. Used for portfolio volume tracking and as a denominator for per-appeal averages."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_major_gift_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift pipeline and conversion metrics. Tracks pipeline value, weighted expected revenue, probability, and stage progression — essential for major gifts officers and leadership to manage high-value donor relationships and forecast transformational gifts."
  source: "`vibe_ngo_v1`.`donor`.`major_gift_opportunity`"
  dimensions:
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current stage in the major gift solicitation cycle (e.g. identification, cultivation, solicitation, stewardship) — primary pipeline stage dimension."
    - name: "gift_type"
      expr: gift_type
      comment: "Type of major gift being pursued (e.g. outright, bequest, planned) — used to segment pipeline by giving vehicle."
    - name: "gift_purpose"
      expr: gift_purpose
      comment: "Intended purpose or program area for the major gift — used to align pipeline with organizational priorities."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Whether the anticipated gift is restricted or unrestricted — used for fund allocation planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the opportunity — used for multi-currency pipeline reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year in which the gift is expected to close — used for annual major gifts revenue forecasting."
    - name: "is_active"
      expr: is_active
      comment: "Whether the opportunity is currently active — used to filter to live pipeline vs. closed/lost opportunities."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the major gift opportunity was identified — used to evaluate prospect identification effectiveness."
    - name: "expected_close_date_year"
      expr: DATE_TRUNC('YEAR', expected_close_date)
      comment: "Year the gift is expected to close — used for annual pipeline forecasting and capacity planning."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason the opportunity was lost — used to identify systemic barriers in the major gifts solicitation process."
  measures:
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total amount being solicited across all major gift opportunities. Represents the gross major gifts pipeline value."
    - name: "total_expected_gift_amount"
      expr: SUM(CAST(expected_gift_amount AS DOUBLE))
      comment: "Total expected gift value across all opportunities. Used as the unweighted major gifts revenue forecast."
    - name: "total_weighted_value"
      expr: SUM(CAST(weighted_value AS DOUBLE))
      comment: "Total probability-weighted pipeline value. The primary major gifts revenue forecast metric — accounts for likelihood of close at each stage."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average close probability across active opportunities. Used to assess overall pipeline health and conversion confidence."
    - name: "avg_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount per major gift opportunity. Used to track whether the organization is targeting appropriately sized gifts."
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of major gift opportunities in the pipeline. Used to assess pipeline breadth and major gifts officer workload."
    - name: "active_opportunities"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 ELSE NULL END)
      comment: "Number of currently active major gift opportunities. Core pipeline volume metric for major gifts management."
    - name: "weighted_to_ask_ratio"
      expr: ROUND(100.0 * SUM(CAST(weighted_value AS DOUBLE)) / NULLIF(SUM(CAST(ask_amount AS DOUBLE)), 0), 2)
      comment: "Weighted pipeline value as a percentage of total ask amount. Measures overall pipeline confidence — low ratios indicate high-risk pipeline with low conversion probability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor constituent portfolio metrics. Tracks donor base composition, giving capacity, lifetime value, and engagement health — used by development leadership to manage donor relationships, prioritize cultivation, and assess portfolio quality."
  source: "`vibe_ngo_v1`.`donor`.`constituent`"
  dimensions:
    - name: "constituent_type"
      expr: constituent_type
      comment: "Type of constituent (e.g. individual, foundation, corporation, government) — primary segmentation dimension for donor portfolio analysis."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier assigned to the constituent (e.g. major donor, mid-level, annual fund) — used for tiered stewardship and resource allocation."
    - name: "funder_classification"
      expr: funder_classification
      comment: "Classification of the funder type (e.g. bilateral, multilateral, private foundation) — used for institutional donor portfolio analysis."
    - name: "record_status"
      expr: record_status
      comment: "Status of the constituent record (e.g. active, inactive, deceased) — used to filter to active donor base."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether the constituent has provided GDPR consent — used for compliance monitoring and contactable audience sizing."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Whether the constituent has opted in to email communications — used to size the email-reachable donor audience."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Whether the constituent is deceased — used to exclude from active solicitation and flag for bequest follow-up."
    - name: "preferred_grant_modality"
      expr: preferred_grant_modality
      comment: "Preferred grant modality of the constituent — used to align funding proposals with donor preferences."
    - name: "prospect_research_rating"
      expr: prospect_research_rating
      comment: "Prospect research rating assigned to the constituent — used to prioritize major gift cultivation efforts."
    - name: "first_gift_year"
      expr: DATE_TRUNC('YEAR', first_gift_date)
      comment: "Year of the constituent's first gift — used for donor cohort analysis and retention tracking."
    - name: "oda_eligibility_flag"
      expr: oda_eligibility_flag
      comment: "Whether the constituent is eligible for Official Development Assistance reporting — used for DAC/ODA compliance segmentation."
    - name: "dac_member_flag"
      expr: dac_member_flag
      comment: "Whether the constituent is a DAC member country donor — used for OECD DAC reporting and institutional donor analysis."
  measures:
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Total lifetime giving across all constituents. Measures the cumulative fundraising value of the donor portfolio — a primary indicator of donor base health."
    - name: "avg_lifetime_giving"
      expr: AVG(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Average lifetime giving per constituent. Used to benchmark donor value and identify segments with high long-term giving potential."
    - name: "total_estimated_giving_capacity"
      expr: SUM(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across the constituent portfolio. Measures the theoretical fundraising ceiling — used to identify the gap between capacity and actual giving."
    - name: "avg_largest_gift_amount"
      expr: AVG(CAST(largest_gift_amount AS DOUBLE))
      comment: "Average largest single gift per constituent. Used to assess peak giving behavior and identify major gift upgrade candidates."
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_giving_total AS DOUBLE)) / NULLIF(SUM(CAST(estimated_giving_capacity AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated giving capacity that has been realized through lifetime giving. Low utilization rates identify constituents with significant untapped giving potential."
    - name: "total_constituents"
      expr: COUNT(1)
      comment: "Total number of constituent records. Used as the base for donor portfolio sizing and per-constituent metric calculations."
    - name: "active_constituents"
      expr: COUNT(CASE WHEN record_status = 'active' THEN 1 ELSE NULL END)
      comment: "Number of active constituent records. Measures the size of the actionable donor base for solicitation and stewardship."
    - name: "gdpr_consented_constituents"
      expr: COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN 1 ELSE NULL END)
      comment: "Number of constituents with valid GDPR consent. Used for compliance monitoring and to size the legally contactable European donor audience."
    - name: "email_opted_in_constituents"
      expr: COUNT(CASE WHEN email_opt_in_flag = TRUE THEN 1 ELSE NULL END)
      comment: "Number of constituents opted in to email communications. Measures the reachable digital audience for email fundraising campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fundraising_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising event performance metrics. Tracks revenue, net proceeds, goal attainment, and cost efficiency across events — used by events and development teams to evaluate event ROI and optimize the events fundraising portfolio."
  source: "`vibe_ngo_v1`.`donor`.`fundraising_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of fundraising event (e.g. gala, auction, walkathon, webinar) — used to benchmark performance within event categories."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event (e.g. planned, completed, cancelled) — used to filter to completed events for performance analysis."
    - name: "is_virtual_event"
      expr: is_virtual_event
      comment: "Whether the event was held virtually — used to compare virtual vs. in-person event performance."
    - name: "is_tax_deductible"
      expr: is_tax_deductible
      comment: "Whether event ticket purchases are tax-deductible — used for donor communication and compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of event financials — used for multi-currency event portfolio reporting."
    - name: "venue_country_code"
      expr: venue_country_code
      comment: "Country where the event was held — used for geographic analysis of event fundraising performance."
    - name: "event_date_year"
      expr: DATE_TRUNC('YEAR', event_date)
      comment: "Year the event was held — used for annual event portfolio performance comparisons."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the event was held — used for seasonal event performance analysis."
  measures:
    - name: "total_revenue_raised"
      expr: SUM(CAST(total_revenue_raised AS DOUBLE))
      comment: "Total revenue raised across all fundraising events. Primary event fundraising output metric."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after event costs. Measures the actual financial contribution of events to the organization's mission."
    - name: "total_event_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total cost of running fundraising events. Used in cost-efficiency analysis and event portfolio optimization."
    - name: "total_fundraising_goal"
      expr: SUM(CAST(fundraising_goal_amount AS DOUBLE))
      comment: "Total fundraising goal across all events. Used as the denominator for event goal attainment calculations."
    - name: "event_goal_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_revenue_raised AS DOUBLE)) / NULLIF(SUM(CAST(fundraising_goal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising goal achieved across events. Core event effectiveness KPI — below-target events trigger post-event review and strategy adjustment."
    - name: "net_revenue_margin"
      expr: ROUND(100.0 * SUM(CAST(net_revenue AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue_raised AS DOUBLE)), 0), 2)
      comment: "Net revenue as a percentage of gross revenue raised. Measures event cost efficiency — low margins indicate events where costs are consuming most of the fundraising yield."
    - name: "avg_ticket_price"
      expr: AVG(CAST(ticket_price_tiers AS DOUBLE))
      comment: "Average ticket price across events. Used to evaluate pricing strategy and its relationship to attendance and revenue outcomes."
    - name: "avg_tax_deductible_percentage"
      expr: AVG(CAST(tax_deductible_percentage AS DOUBLE))
      comment: "Average tax-deductible portion of event revenue. Used for donor tax receipt calculations and compliance reporting."
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of fundraising events. Used for portfolio volume tracking and per-event average calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect pipeline and qualification metrics. Tracks prospect pool size, estimated capacity, conversion rates, and pipeline value — used by major gifts and development teams to manage the donor acquisition funnel and prioritize cultivation resources."
  source: "`vibe_ngo_v1`.`donor`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect (e.g. identified, qualified, cultivating, converted, disqualified) — primary pipeline stage dimension."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g. individual, foundation, corporate) — used to segment the prospect pipeline by donor category."
    - name: "stage"
      expr: stage
      comment: "Current cultivation stage of the prospect — used to track pipeline progression and identify bottlenecks."
    - name: "research_stage"
      expr: research_stage
      comment: "Stage of prospect research completed — used to prioritize research resources and identify prospects ready for cultivation."
    - name: "program_interest_area"
      expr: program_interest_area
      comment: "Program area the prospect is interested in funding — used to align cultivation strategies with donor interests."
    - name: "geographic_interest"
      expr: geographic_interest
      comment: "Geographic focus area of the prospect — used to match prospects with relevant programs and campaigns."
    - name: "source_of_wealth"
      expr: source_of_wealth
      comment: "Primary source of the prospect's wealth — used for prospect segmentation and cultivation strategy development."
    - name: "identification_year"
      expr: DATE_TRUNC('YEAR', identification_date)
      comment: "Year the prospect was identified — used for prospect cohort analysis and pipeline aging."
    - name: "expected_close_year"
      expr: DATE_TRUNC('YEAR', expected_close_date)
      comment: "Year the prospect is expected to convert — used for annual major gifts pipeline forecasting."
  measures:
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across all prospects. Measures the theoretical value of the prospect pipeline — used to prioritize cultivation investment."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total amount being solicited across all prospects. Represents the active ask pipeline value."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average conversion probability across prospects. Used to assess overall prospect pipeline quality and forecast conversion yield."
    - name: "avg_estimated_gift_range_max"
      expr: AVG(CAST(estimated_gift_range_max AS DOUBLE))
      comment: "Average upper bound of estimated gift range across prospects. Used to calibrate ask amounts and assess pipeline ceiling value."
    - name: "avg_wealth_screening_score"
      expr: AVG(CAST(wealth_screening_score AS DOUBLE))
      comment: "Average wealth screening score across prospects. Used to assess the overall quality and capacity of the prospect pool."
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Total number of prospects in the pipeline. Used for pipeline volume tracking and conversion rate calculations."
    - name: "converted_prospects"
      expr: COUNT(CASE WHEN conversion_date IS NOT NULL THEN 1 ELSE NULL END)
      comment: "Number of prospects who have converted to donors. Used to calculate prospect-to-donor conversion rates."
    - name: "prospect_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_date IS NOT NULL THEN 1 ELSE NULL END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects who have converted to donors. Core acquisition funnel metric — low conversion rates trigger review of cultivation strategies and prospect qualification criteria."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_stewardship_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship engagement metrics. Tracks stewardship activity volume, cost, engagement quality, and follow-up compliance — used by relationship managers to ensure donors receive appropriate recognition and communication, reducing lapse risk."
  source: "`vibe_ngo_v1`.`donor`.`stewardship_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of stewardship activity (e.g. thank-you call, impact report, site visit) — used to analyze which activity types drive the best donor engagement outcomes."
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the stewardship activity (e.g. planned, completed, cancelled) — used to track completion rates and identify overdue activities."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the stewardship activity (e.g. email, phone, in-person) — used to evaluate channel effectiveness for donor engagement."
    - name: "donor_sentiment"
      expr: donor_sentiment
      comment: "Recorded donor sentiment following the activity (e.g. positive, neutral, negative) — used to monitor relationship health across the donor portfolio."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the stewardship activity — used to ensure high-priority donor touchpoints are completed on time."
    - name: "stewardship_plan_stage"
      expr: stewardship_plan_stage
      comment: "Stage within the stewardship plan — used to track progression through structured donor stewardship journeys."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether a follow-up action is required — used to manage outstanding stewardship obligations."
    - name: "solicitation_made_flag"
      expr: solicitation_made_flag
      comment: "Whether a solicitation was made during the activity — used to track conversion of stewardship touchpoints into asks."
    - name: "activity_date_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month the stewardship activity occurred — used for monthly engagement volume and trend analysis."
    - name: "activity_date_year"
      expr: DATE_TRUNC('YEAR', activity_date)
      comment: "Year the stewardship activity occurred — used for annual stewardship program performance reviews."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of stewardship activities completed. Measures the volume of donor touchpoints — a leading indicator of donor retention and relationship health."
    - name: "unique_constituents_stewarded"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents who received stewardship activities. Used to assess breadth of stewardship coverage across the donor portfolio."
    - name: "total_stewardship_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities. Used to evaluate stewardship program investment and cost per touchpoint."
    - name: "avg_stewardship_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship activity. Used to benchmark stewardship efficiency and identify high-cost activity types."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total solicitation amount raised through stewardship activities. Measures the revenue generation potential of the stewardship program."
    - name: "solicitation_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN solicitation_made_flag = TRUE THEN 1 ELSE NULL END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stewardship activities that included a solicitation. Used to evaluate how effectively stewardship touchpoints are being leveraged for fundraising asks."
    - name: "acknowledgement_sent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgement_sent_flag = TRUE THEN 1 ELSE NULL END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stewardship activities where an acknowledgement was sent. Measures compliance with donor recognition standards — low rates risk donor dissatisfaction and lapse."
    - name: "impact_story_share_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN impact_story_shared_flag = TRUE THEN 1 ELSE NULL END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stewardship activities where an impact story was shared. Measures the quality of donor engagement — impact storytelling is a proven driver of donor retention and upgrade."
    - name: "follow_up_pending_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE AND completed_date IS NULL THEN 1 ELSE NULL END)
      comment: "Number of stewardship activities with outstanding follow-up actions. Used to manage relationship manager workload and ensure no donor commitments fall through the cracks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund portfolio health and compliance metrics. Tracks fund balances, restriction compliance, cost share obligations, and indirect cost rates — used by finance and development leadership to manage fund utilization, compliance, and reporting obligations."
  source: "`vibe_ngo_v1`.`donor`.`fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of fund (e.g. restricted, unrestricted, endowment, emergency) — primary segmentation dimension for fund portfolio analysis."
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (e.g. active, closed, suspended) — used to filter to active funds for operational reporting."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction on the fund (e.g. purpose-restricted, time-restricted, unrestricted) — used for compliance monitoring and fund allocation planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fund — used for multi-currency fund portfolio reporting."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for the fund — used for ODA reporting and donor compliance."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN SDG alignment of the fund — used for impact reporting and donor stewardship."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the fund (e.g. global, regional, country-specific) — used for geographic portfolio analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for the fund — used to manage donor reporting obligations and compliance calendars."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Whether the fund requires cost sharing — used to identify funds with co-financing obligations."
    - name: "audit_required"
      expr: audit_required
      comment: "Whether the fund requires an external audit — used for audit planning and compliance monitoring."
    - name: "inception_year"
      expr: DATE_TRUNC('YEAR', inception_date)
      comment: "Year the fund was established — used for fund portfolio aging and vintage analysis."
  measures:
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance across all funds. Primary fund portfolio liquidity metric — used for cash management and program funding decisions."
    - name: "avg_fund_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average balance per fund. Used to identify underfunded or overfunded funds requiring reallocation."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across funds. Used to monitor overhead recovery and negotiate indirect cost rates with donors."
    - name: "avg_cost_share_percentage"
      expr: AVG(CASE WHEN cost_share_required = TRUE THEN CAST(cost_share_percentage AS DOUBLE) ELSE NULL END)
      comment: "Average cost share percentage across funds that require cost sharing. Used to assess the organization's co-financing burden and compliance with donor cost share requirements."
    - name: "total_funds"
      expr: COUNT(1)
      comment: "Total number of funds in the portfolio. Used for portfolio sizing and as a denominator for per-fund averages."
    - name: "active_funds"
      expr: COUNT(CASE WHEN fund_status = 'active' THEN 1 ELSE NULL END)
      comment: "Number of currently active funds. Used to track the operational fund portfolio size."
    - name: "audit_required_funds"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 ELSE NULL END)
      comment: "Number of funds requiring external audit. Used for audit planning, resource allocation, and compliance risk management."
    - name: "restricted_fund_balance"
      expr: SUM(CASE WHEN restriction_type != 'unrestricted' THEN CAST(balance AS DOUBLE) ELSE 0 END)
      comment: "Total balance held in restricted funds. Used to monitor the proportion of funds with donor-imposed restrictions — high restricted balances limit organizational flexibility."
$$;