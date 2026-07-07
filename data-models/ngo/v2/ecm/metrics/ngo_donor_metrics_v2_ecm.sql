-- Metric views for domain: donor | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising revenue metrics derived from individual gift transactions. Primary KPI surface for CFO, CDO, and fundraising leadership. Source-of-record: Raiser's Edge NXT, Salesforce NPSP, or equivalent CRM gift ledger. Excludes FK columns removed per VREQ-047/048/049 (mel_indicator_result_id, mel_evaluation_id, safeguarding_safeguarding_incident_id)."
  source: "`vibe_ngo_v1`.`donor`.`gift`"
  dimensions:
    - name: "gift_type"
      expr: gift_type
      comment: "Type of gift (cash, in-kind, stock, matching, etc.) — primary segmentation for revenue mix analysis."
    - name: "gift_status"
      expr: gift_status
      comment: "Processing status of the gift (posted, pending, reversed) — used to filter to booked revenue."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Whether the gift is unrestricted, temporarily restricted, or permanently restricted — critical for fund accounting and liquidity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the gift — enables multi-currency revenue reporting."
    - name: "gift_date_month"
      expr: DATE_TRUNC('MONTH', gift_date)
      comment: "Month of gift date — supports trend analysis and seasonal fundraising patterns."
    - name: "gift_date_year"
      expr: YEAR(gift_date)
      comment: "Fiscal/calendar year of gift — used for year-over-year revenue comparison."
    - name: "matching_gift_flag"
      expr: matching_gift_flag
      comment: "Indicates whether the gift has a corporate match — used to track match leverage ratio."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Indicates whether the gift was refunded — used to compute net revenue after reversals."
    - name: "tribute_flag"
      expr: tribute_flag
      comment: "Indicates whether the gift is a tribute/memorial gift — supports tribute program reporting."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Indicates whether the donor requested anonymity — used for recognition and reporting exclusions."
    - name: "irs_compliant_flag"
      expr: irs_compliant_flag
      comment: "Indicates IRS compliance status of the gift — critical for audit and regulatory reporting."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month of GL posting date — aligns fundraising revenue to accounting periods."
  measures:
    - name: "total_gift_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross gift revenue across all gifts. Primary top-line fundraising KPI used in board decks and donor reports. Drives resource allocation and campaign investment decisions."
    - name: "total_net_gift_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net gift revenue after fees and adjustments. Used by finance leadership to assess true fundraising yield and cost-of-fundraising ratios."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing and platform fees deducted from gifts. Informs payment channel cost analysis and vendor negotiations."
    - name: "gift_count"
      expr: COUNT(1)
      comment: "Total number of gift transactions. Used alongside revenue to compute average gift size and donor productivity metrics."
    - name: "avg_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gross gift amount per transaction. Key indicator of donor generosity trends and ask-string effectiveness; triggers strategy review when it declines."
    - name: "avg_net_gift_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net gift amount after fees. Used to benchmark channel efficiency — lower averages on digital channels may indicate fee drag."
    - name: "matching_gift_revenue"
      expr: SUM(CASE WHEN matching_gift_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total revenue from matched gifts. Measures corporate match leverage — a key multiplier metric for major gift and corporate fundraising strategy."
    - name: "match_leverage_ratio"
      expr: SUM(CASE WHEN matching_gift_flag = TRUE THEN amount ELSE 0 END) / NULLIF(SUM(CASE WHEN matching_gift_flag = FALSE THEN amount ELSE 0 END), 0)
      comment: "Ratio of matched gift revenue to unmatched gift revenue. Quantifies the multiplier effect of corporate matching programs; used to prioritize match-eligible donor cultivation."
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gifts that were refunded. Elevated refund rates signal donor dissatisfaction, processing errors, or fraud — triggers operational investigation."
    - name: "total_goods_services_value"
      expr: SUM(CAST(goods_services_value AS DOUBLE))
      comment: "Total value of goods or services provided in exchange for gifts. Required for IRS quid-pro-quo disclosure and deductibility calculations."
    - name: "irs_compliant_gift_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN irs_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gifts flagged as IRS compliant. Compliance rate below 100% is a regulatory risk indicator requiring audit and remediation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge commitment and fulfillment metrics. Tracks multi-year giving commitments, installment performance, and write-off risk. Critical for cash-flow forecasting and major gift pipeline management. Source-of-record: Raiser's Edge NXT, Salesforce NPSP."
  source: "`vibe_ngo_v1`.`donor`.`pledge`"
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of the pledge (active, fulfilled, cancelled, written-off) — primary filter for pipeline vs. closed analysis."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge (standard, recurring, challenge, etc.) — used to segment commitment pipeline by giving vehicle."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (monthly, quarterly, annually) — informs cash-flow timing projections."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the pledge — enables multi-currency pipeline reporting."
    - name: "pledge_date_year"
      expr: YEAR(pledge_date)
      comment: "Year the pledge was made — used for vintage cohort analysis of pledge fulfillment rates."
    - name: "pledge_date_month"
      expr: DATE_TRUNC('MONTH', pledge_date)
      comment: "Month the pledge was made — supports trend analysis of new commitment volume."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the pledge is a recurring giving commitment — recurring pledges are the most predictable revenue stream."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates whether the pledge qualifies for corporate matching — used to prioritize match solicitation outreach."
    - name: "acknowledgment_sent"
      expr: acknowledgment_sent
      comment: "Indicates whether the acknowledgment was sent — used to track stewardship compliance."
  measures:
    - name: "total_pledge_amount"
      expr: SUM(CAST(total_pledge_amount AS DOUBLE))
      comment: "Total face value of all pledges. Primary pipeline metric for major gift and planned giving programs — used in board-level revenue forecasting."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected against pledges. Measures actual pledge fulfillment and cash conversion — critical for liquidity planning."
    - name: "total_balance_outstanding"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total uncollected pledge balance. Represents future committed revenue — used in multi-year budget projections and cash-flow models."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total pledge amounts written off as uncollectable. Elevated write-offs signal donor attrition or economic stress — triggers portfolio review and stewardship intervention."
    - name: "pledge_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_pledge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total pledged amount that has been collected. Core pledge health KPI — below-target rates trigger installment reminder campaigns and personal outreach."
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_pledge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of pledged amount written off. Key risk metric for pledge portfolio quality — high rates indicate over-reliance on aspirational commitments without proper qualification."
    - name: "avg_pledge_amount"
      expr: AVG(CAST(total_pledge_amount AS DOUBLE))
      comment: "Average pledge face value. Benchmarks ask-string effectiveness and major gift program productivity."
    - name: "avg_next_installment_amount"
      expr: AVG(CAST(next_installment_amount AS DOUBLE))
      comment: "Average upcoming installment amount. Used for short-term cash-flow forecasting and installment reminder prioritization."
    - name: "active_pledge_count"
      expr: COUNT(CASE WHEN pledge_status = 'Active' THEN 1 END)
      comment: "Number of currently active pledges. Tracks the size of the committed giving pipeline — declining count is an early warning of revenue shortfall."
    - name: "recurring_pledge_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of recurring pledges. Recurring giving is the most predictable revenue stream — growth in this metric is a strategic priority for financial sustainability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_major_gift_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift pipeline and conversion metrics. Tracks prospect cultivation stages, weighted pipeline value, and close rates. Primary KPI surface for Chief Development Officer and major gift officers. Source-of-record: Salesforce NPSP, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`major_gift_opportunity`"
  dimensions:
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current cultivation stage of the opportunity (identification, qualification, cultivation, solicitation, stewardship) — primary pipeline stage dimension."
    - name: "gift_type"
      expr: gift_type
      comment: "Type of major gift being cultivated (outright, pledge, planned, etc.) — used to segment pipeline by giving vehicle."
    - name: "gift_purpose"
      expr: gift_purpose
      comment: "Programmatic purpose of the gift — used to align pipeline to organizational priorities and campaign goals."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type of the anticipated gift — informs fund accounting and program planning."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of expected close — used for annual fundraising goal tracking and budget planning."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code — enables multi-currency pipeline reporting for international organizations."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the opportunity is currently being actively cultivated — used to filter to live pipeline."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates whether the opportunity qualifies for corporate matching — used to identify match leverage potential in pipeline."
    - name: "expected_close_date_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Month of expected close — used for near-term revenue forecasting and officer workload planning."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the prospect was identified — used to evaluate ROI of prospect identification strategies."
  measures:
    - name: "total_pipeline_value"
      expr: SUM(CAST(expected_gift_amount AS DOUBLE))
      comment: "Total face value of all major gift opportunities in pipeline. Primary pipeline health metric for CDO and board fundraising committee — drives annual goal-setting and officer capacity planning."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_value AS DOUBLE))
      comment: "Probability-weighted pipeline value. More accurate revenue forecast than face value — used in budget projections and cash-flow modeling."
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total amount being solicited across active opportunities. Measures the ambition of the ask strategy relative to pipeline capacity."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average close probability across pipeline opportunities. Declining average signals pipeline quality deterioration or stalled cultivation — triggers officer coaching intervention."
    - name: "avg_expected_gift_amount"
      expr: AVG(CAST(expected_gift_amount AS DOUBLE))
      comment: "Average expected gift size in pipeline. Benchmarks major gift program ambition and tracks whether ask amounts are growing over time."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of major gift opportunities. Tracks pipeline volume — used alongside weighted value to assess pipeline depth and officer productivity."
    - name: "active_opportunity_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active opportunities. Core pipeline health metric — used to assess officer portfolio load and identify capacity gaps."
    - name: "distinct_prospect_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique prospects with major gift opportunities. Measures breadth of major gift cultivation universe — used to assess pipeline sustainability."
    - name: "avg_weighted_value"
      expr: AVG(CAST(weighted_value AS DOUBLE))
      comment: "Average probability-weighted value per opportunity. Used to benchmark opportunity quality and prioritize officer time allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising campaign performance and ROI metrics. Tracks campaign revenue, cost efficiency, and goal attainment. Primary KPI surface for fundraising directors and marketing leadership. Source-of-record: Salesforce NPSP, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (annual fund, capital, emergency, endowment, etc.) — primary segmentation for portfolio analysis."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (planning, active, closed) — used to filter to live vs. historical campaigns."
    - name: "appeal_channel"
      expr: appeal_channel
      comment: "Primary solicitation channel (direct mail, digital, events, major gifts) — used to evaluate channel ROI."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code — enables multi-currency campaign reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment — used to report fundraising by programmatic priority area."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the campaign is currently active — used to filter dashboards to live campaigns."
    - name: "matching_gift_eligible"
      expr: matching_gift_eligible
      comment: "Indicates whether the campaign is eligible for corporate matching — used to track match leverage by campaign."
    - name: "start_date_year"
      expr: YEAR(start_date)
      comment: "Year the campaign started — used for year-over-year campaign performance comparison."
    - name: "tax_deductible"
      expr: tax_deductible
      comment: "Indicates whether gifts to this campaign are tax deductible — used for donor communications and compliance reporting."
  measures:
    - name: "total_raised_amount"
      expr: SUM(CAST(total_raised_amount AS DOUBLE))
      comment: "Total revenue raised across campaigns. Top-line fundraising performance metric used in board reports and donor impact communications."
    - name: "total_goal_amount"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Total fundraising goal across campaigns. Used as denominator for goal attainment rate — critical for campaign planning and accountability."
    - name: "total_cost_of_fundraising"
      expr: SUM(CAST(cost_of_fundraising AS DOUBLE))
      comment: "Total cost invested in fundraising campaigns. Used to compute cost-of-fundraising ratio — a key efficiency metric for charity watchdogs and board oversight."
    - name: "campaign_goal_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_raised_amount AS DOUBLE)) / NULLIF(SUM(CAST(goal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising goal achieved across campaigns. Primary campaign success metric — below 80% triggers strategy review and resource reallocation."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment across campaigns. Measures fundraising efficiency — campaigns with negative ROI are candidates for discontinuation or redesign."
    - name: "cost_of_fundraising_ratio"
      expr: ROUND(100.0 * SUM(CAST(cost_of_fundraising AS DOUBLE)) / NULLIF(SUM(CAST(total_raised_amount AS DOUBLE)), 0), 2)
      comment: "Cost of fundraising as a percentage of revenue raised. Industry benchmark is under 20% — exceeding this triggers efficiency review and is scrutinized by charity evaluators."
    - name: "net_campaign_revenue"
      expr: SUM((CAST(total_raised_amount AS DOUBLE)) - (CAST(cost_of_fundraising AS DOUBLE)))
      comment: "Net revenue after deducting fundraising costs. True bottom-line campaign profitability metric used in portfolio optimization decisions."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Used to assess portfolio breadth and resource distribution across fundraising initiatives."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns. Tracks concurrent fundraising activity — used for resource allocation and donor fatigue risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal-level solicitation performance and cost-efficiency metrics. Tracks response rates, ROI, and revenue per appeal. Used by direct response and annual fund teams to optimize solicitation strategy. Source-of-record: Raiser's Edge NXT, Salesforce NPSP."
  source: "`vibe_ngo_v1`.`donor`.`appeal`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (acquisition, renewal, upgrade, lapsed reactivation) — primary segmentation for solicitation strategy analysis."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (planned, active, closed) — used to filter to completed appeals for performance analysis."
    - name: "channel"
      expr: channel
      comment: "Solicitation channel (direct mail, email, phone, digital) — used to compare channel ROI and optimize channel mix."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of appeal costs — enables multi-currency cost reporting."
    - name: "control_group_flag"
      expr: control_group_flag
      comment: "Indicates whether this appeal is a control group — used to measure lift from test variants."
    - name: "test_segment_flag"
      expr: test_segment_flag
      comment: "Indicates whether this appeal is a test segment — used to isolate A/B test performance."
    - name: "mailing_date_month"
      expr: DATE_TRUNC('MONTH', mailing_date)
      comment: "Month of mailing — used to analyze seasonal response patterns and optimize mailing calendar."
    - name: "mailing_date_year"
      expr: YEAR(mailing_date)
      comment: "Year of mailing — used for year-over-year appeal performance comparison."
  measures:
    - name: "total_appeal_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated by appeals. Primary appeal performance metric — used to rank appeals and allocate future investment."
    - name: "total_appeal_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of executing appeals. Used as denominator for ROI calculation — critical for cost-efficiency benchmarking."
    - name: "avg_roi_ratio"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average return on investment ratio across appeals. Core efficiency metric — appeals with ROI below 1.0 are losing money and require immediate review."
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate across appeals. Measures solicitation effectiveness — declining response rates signal donor fatigue or messaging misalignment."
    - name: "avg_gift_amount"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average gift amount per appeal. Used to benchmark ask-string effectiveness and track upgrade program performance."
    - name: "appeal_net_revenue"
      expr: SUM((CAST(total_revenue_amount AS DOUBLE)) - (CAST(cost_amount AS DOUBLE)))
      comment: "Net revenue after deducting appeal costs. True profitability of each appeal — used to prioritize high-performing appeals for scale-up."
    - name: "appeal_count"
      expr: COUNT(1)
      comment: "Total number of appeals executed. Used to assess solicitation volume and donor contact frequency."
    - name: "avg_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount across appeals. Tracks whether ask strings are calibrated to donor capacity — misalignment reduces response rates."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor base health, capacity, and lifecycle metrics. Tracks constituent portfolio size, giving capacity, and engagement status. Primary KPI surface for CDO, prospect research, and donor relations teams. Source-of-record: Raiser's Edge NXT, Salesforce NPSP. PII sensitivity: constituent records contain pii_donor classified attributes."
  source: "`vibe_ngo_v1`.`donor`.`constituent`"
  dimensions:
    - name: "constituent_type"
      expr: constituent_type
      comment: "Type of constituent (individual, foundation, corporation, government) — primary segmentation for portfolio strategy."
    - name: "funder_classification"
      expr: funder_classification
      comment: "Classification of funder (bilateral, multilateral, private, corporate, individual) — used for portfolio diversification analysis."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier (major donor, mid-level, annual fund, lapsed) — used to segment stewardship investment and officer assignment."
    - name: "record_status"
      expr: record_status
      comment: "Active/inactive status of the constituent record — used to filter to active donor base."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Indicates GDPR consent status — critical for compliance with EU data protection regulations; non-consented records must be excluded from solicitations."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Indicates email marketing opt-in — used to size addressable email audience."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Indicates whether the constituent is deceased — used to suppress from active solicitation and route to planned giving."
    - name: "dac_member_flag"
      expr: dac_member_flag
      comment: "Indicates whether the constituent is an OECD DAC member — relevant for ODA-eligible funding classification."
    - name: "oda_eligibility_flag"
      expr: oda_eligibility_flag
      comment: "Indicates ODA eligibility — used for international development funding compliance reporting."
    - name: "preferred_grant_modality"
      expr: preferred_grant_modality
      comment: "Preferred grant modality (project, pooled, budget support) — used to align proposal strategy to donor preferences."
    - name: "first_gift_date_year"
      expr: YEAR(first_gift_date)
      comment: "Year of first gift — used for donor vintage cohort analysis and retention modeling."
    - name: "mailing_country_code"
      expr: mailing_country_code
      comment: "Country of constituent mailing address — used for geographic portfolio analysis and international fundraising strategy."
  measures:
    - name: "total_constituent_count"
      expr: COUNT(1)
      comment: "Total number of constituent records. Measures the size of the donor universe — growth indicates successful acquisition; decline signals attrition risk."
    - name: "active_constituent_count"
      expr: COUNT(CASE WHEN record_status = 'Active' THEN 1 END)
      comment: "Number of active constituent records. Core donor base health metric — used to track net active donor growth after acquisition and attrition."
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Total lifetime giving across all constituents. Measures the cumulative value of the donor portfolio — used in endowment planning and major gift strategy."
    - name: "avg_lifetime_giving"
      expr: AVG(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Average lifetime giving per constituent. Benchmarks donor value and tracks whether portfolio quality is improving over time."
    - name: "total_estimated_giving_capacity"
      expr: SUM(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across constituents. Measures the theoretical ceiling of the donor portfolio — used to identify the gap between current giving and capacity."
    - name: "avg_estimated_giving_capacity"
      expr: AVG(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per constituent. Used to benchmark portfolio quality and prioritize capacity-building investments."
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_giving_total AS DOUBLE)) / NULLIF(SUM(CAST(estimated_giving_capacity AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated giving capacity that has been realized as lifetime giving. Low rates indicate untapped potential — used to prioritize major gift cultivation and upgrade strategies."
    - name: "avg_largest_gift_amount"
      expr: AVG(CAST(largest_gift_amount AS DOUBLE))
      comment: "Average largest single gift per constituent. Tracks the ceiling of donor generosity — used to calibrate major gift ask amounts and identify upgrade candidates."
    - name: "gdpr_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gdpr_consent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constituents with valid GDPR consent. Compliance metric — below 100% for EU constituents is a regulatory risk requiring immediate remediation."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_opt_in_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constituents opted in to email communications. Measures addressable digital audience — declining rate reduces email fundraising reach and requires re-permission campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_stewardship_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship engagement and relationship management metrics. Tracks activity volume, cost, and follow-up compliance. Used by major gift officers and stewardship teams to manage donor relationships. Note: FK columns safeguarding_safeguarding_incident_id and supply_distribution_plan_id removed per VREQ-050/051. Source-of-record: Salesforce NPSP, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`stewardship_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of stewardship activity (call, meeting, site visit, impact report, event) — used to analyze engagement channel mix."
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the activity (planned, completed, cancelled) — used to track stewardship plan execution."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the activity (phone, email, in-person, virtual) — used to optimize stewardship channel strategy."
    - name: "donor_sentiment"
      expr: donor_sentiment
      comment: "Recorded donor sentiment (positive, neutral, negative) — used to identify at-risk relationships requiring escalation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the stewardship activity — used to ensure high-priority donors receive timely engagement."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether a follow-up action is required — used to track outstanding stewardship obligations."
    - name: "solicitation_made_flag"
      expr: solicitation_made_flag
      comment: "Indicates whether a solicitation was made during the activity — used to track ask frequency and conversion."
    - name: "impact_story_shared_flag"
      expr: impact_story_shared_flag
      comment: "Indicates whether an impact story was shared — used to measure impact communication frequency as a stewardship quality indicator."
    - name: "activity_date_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of activity — used to track stewardship cadence and identify gaps in engagement."
    - name: "stewardship_plan_stage"
      expr: stewardship_plan_stage
      comment: "Stage in the stewardship plan — used to track plan progression and identify stalled relationships."
  measures:
    - name: "total_activity_count"
      expr: COUNT(1)
      comment: "Total number of stewardship activities. Measures engagement volume — used to assess officer productivity and stewardship plan execution rate."
    - name: "completed_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'Completed' THEN 1 END)
      comment: "Number of completed stewardship activities. Tracks actual vs. planned engagement — completion rate below target triggers officer performance review."
    - name: "activity_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN activity_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of planned stewardship activities completed. Core stewardship execution KPI — low rates indicate capacity gaps or planning misalignment."
    - name: "total_stewardship_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities. Used to compute cost-per-touch and stewardship ROI — informs budget allocation across donor tiers."
    - name: "avg_stewardship_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship activity. Benchmarks stewardship efficiency — used to compare cost across channels and donor tiers."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total amount solicited through stewardship activities. Measures the ask pipeline generated through relationship management — used to link stewardship investment to revenue outcomes."
    - name: "distinct_donor_touched_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors who received stewardship activities. Measures breadth of stewardship coverage — used to identify donors not receiving adequate engagement."
    - name: "follow_up_pending_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE AND activity_status != 'Completed' THEN 1 END)
      comment: "Number of activities with outstanding follow-up obligations. Operational risk metric — high counts indicate stewardship commitments at risk of being missed."
    - name: "negative_sentiment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_sentiment = 'Negative' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stewardship activities with negative donor sentiment. Early warning indicator for at-risk major donor relationships — triggers escalation to senior leadership."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect pipeline qualification and conversion metrics. Tracks prospect research quality, cultivation progress, and pipeline conversion rates. Used by prospect research and major gift teams. Source-of-record: Raiser's Edge NXT, iWave, DonorSearch."
  source: "`vibe_ngo_v1`.`donor`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect (identified, qualified, cultivating, solicited, converted, disqualified) — primary pipeline stage dimension."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (individual, foundation, corporate) — used to segment pipeline by donor category."
    - name: "research_stage"
      expr: research_stage
      comment: "Stage of prospect research (initial, in-progress, complete) — used to track research pipeline throughput."
    - name: "stage"
      expr: stage
      comment: "Cultivation stage of the prospect — used to track pipeline progression and identify bottlenecks."
    - name: "geographic_interest"
      expr: geographic_interest
      comment: "Geographic focus area of the prospect — used to align prospects to relevant programs and campaigns."
    - name: "program_interest_area"
      expr: program_interest_area
      comment: "Programmatic interest area of the prospect — used to match prospects to relevant funding opportunities."
    - name: "identification_date_year"
      expr: YEAR(identification_date)
      comment: "Year the prospect was identified — used for pipeline vintage analysis and research team productivity tracking."
    - name: "expected_close_date_year"
      expr: YEAR(expected_close_date)
      comment: "Year of expected conversion — used for annual pipeline forecasting."
  measures:
    - name: "total_prospect_count"
      expr: COUNT(1)
      comment: "Total number of prospects in the pipeline. Measures pipeline volume — used to assess research team productivity and pipeline sustainability."
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across all prospects. Measures the theoretical value of the prospect pipeline — used in long-term fundraising strategy and goal-setting."
    - name: "avg_estimated_capacity"
      expr: AVG(CAST(estimated_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per prospect. Benchmarks prospect quality — used to assess whether research is identifying high-capacity individuals."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total amount being solicited across prospects. Measures the ask pipeline — used to forecast near-term major gift revenue."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average conversion probability across prospects. Tracks pipeline quality — declining probability signals cultivation challenges requiring strategy adjustment."
    - name: "avg_wealth_screening_score"
      expr: AVG(CAST(wealth_screening_score AS DOUBLE))
      comment: "Average wealth screening score across prospects. Measures the financial capacity of the prospect pool — used to prioritize research and cultivation investment."
    - name: "avg_gift_range_max"
      expr: AVG(CAST(estimated_gift_range_max AS DOUBLE))
      comment: "Average upper bound of estimated gift range. Used to calibrate ask amounts and assess the ceiling of the prospect pipeline."
    - name: "avg_gift_range_min"
      expr: AVG(CAST(estimated_gift_range_min AS DOUBLE))
      comment: "Average lower bound of estimated gift range. Used alongside max to understand the range of expected gift sizes in the pipeline."
    - name: "conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prospect_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects that converted to donors. Core pipeline efficiency metric — low conversion rates trigger review of qualification criteria and cultivation strategy."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fundraising_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising event revenue, cost, and attendance metrics. Tracks event ROI, goal attainment, and net revenue. Used by events and development teams to optimize event portfolio. Note: capacity_total corrected to DECIMAL per VREQ-054. Source-of-record: Salesforce NPSP, Raiser's Edge NXT, Eventbrite."
  source: "`vibe_ngo_v1`.`donor`.`fundraising_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of fundraising event (gala, auction, run/walk, virtual, cultivation) — used to compare ROI across event formats."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event (planned, active, completed, cancelled) — used to filter to completed events for performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code — enables multi-currency event reporting."
    - name: "is_virtual_event"
      expr: is_virtual_event
      comment: "Indicates whether the event is virtual — used to compare in-person vs. virtual event performance."
    - name: "is_tax_deductible"
      expr: is_tax_deductible
      comment: "Indicates whether event tickets are tax deductible — used for donor communications and compliance."
    - name: "event_date_year"
      expr: YEAR(event_date)
      comment: "Year of the event — used for year-over-year event portfolio comparison."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event — used to analyze seasonal event performance patterns."
    - name: "venue_country_code"
      expr: venue_country_code
      comment: "Country of the event venue — used for geographic event portfolio analysis."
  measures:
    - name: "total_revenue_raised"
      expr: SUM(CAST(total_revenue_raised AS DOUBLE))
      comment: "Total revenue raised across fundraising events. Primary event portfolio performance metric — used to assess the contribution of events to overall fundraising goals."
    - name: "total_event_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total cost of executing fundraising events. Used as denominator for event ROI — critical for cost-efficiency benchmarking."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after event costs. True event profitability metric — used to rank events and allocate future investment."
    - name: "total_fundraising_goal"
      expr: SUM(CAST(fundraising_goal_amount AS DOUBLE))
      comment: "Total fundraising goal across events. Used as denominator for goal attainment rate."
    - name: "event_goal_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_revenue_raised AS DOUBLE)) / NULLIF(SUM(CAST(fundraising_goal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising goal achieved across events. Primary event success metric — below-target rates trigger post-event review and strategy adjustment."
    - name: "event_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_event_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue_raised AS DOUBLE)), 0), 2)
      comment: "Event cost as a percentage of revenue raised. Measures event efficiency — high ratios indicate events consuming disproportionate resources relative to revenue generated."
    - name: "avg_ticket_price_paid"
      expr: AVG(CAST(ticket_price_tiers AS DOUBLE))
      comment: "Average ticket price tier across events. Used to benchmark pricing strategy and assess revenue per attendee."
    - name: "total_capacity"
      expr: SUM(CAST(capacity_total AS DOUBLE))
      comment: "Total event capacity across all events. Used as denominator for capacity utilization rate — informs venue selection and event sizing decisions."
    - name: "event_count"
      expr: COUNT(1)
      comment: "Total number of fundraising events. Used to assess event portfolio volume and resource distribution."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_planned_giving`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned giving pipeline value, realization, and stewardship metrics. Tracks legacy commitments, present value, and realization rates. Used by planned giving officers and finance leadership for long-term revenue forecasting. Source-of-record: Raiser's Edge NXT, PG Calc."
  source: "`vibe_ngo_v1`.`donor`.`planned_giving`"
  dimensions:
    - name: "planned_gift_type"
      expr: planned_gift_type
      comment: "Type of planned gift (bequest, charitable remainder trust, annuity, life insurance) — used to segment pipeline by giving vehicle."
    - name: "gift_status"
      expr: gift_status
      comment: "Current status of the planned gift (expectancy, irrevocable, realized, lapsed) — primary pipeline stage dimension."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type of the planned gift — informs fund accounting and program planning for future receipts."
    - name: "stewardship_tier"
      expr: stewardship_tier
      comment: "Stewardship tier of the planned giving donor — used to prioritize legacy society engagement."
    - name: "legacy_society_member"
      expr: legacy_society_member
      comment: "Indicates whether the donor is a legacy society member — used to track legacy society size and engagement."
    - name: "confidentiality_flag"
      expr: confidentiality_flag
      comment: "Indicates whether the planned gift is confidential — used to ensure appropriate data access controls."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used to value the planned gift — used to assess valuation consistency and accuracy."
    - name: "commitment_date_year"
      expr: YEAR(commitment_date)
      comment: "Year of commitment — used for vintage cohort analysis of planned giving pipeline."
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated face value of planned giving pipeline. Primary planned giving portfolio metric — used in long-term endowment projections and strategic planning."
    - name: "total_present_value"
      expr: SUM(CAST(present_value AS DOUBLE))
      comment: "Total present value of planned giving commitments. More accurate than face value for financial planning — used in actuarial modeling and endowment projections."
    - name: "total_realized_value"
      expr: SUM(CAST(realized_value AS DOUBLE))
      comment: "Total value of planned gifts that have been realized. Measures actual cash conversion from the planned giving pipeline — used to validate pipeline projections."
    - name: "realization_rate"
      expr: ROUND(100.0 * SUM(CAST(realized_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_value AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated planned giving value that has been realized. Measures pipeline accuracy and conversion — used to calibrate future projections and identify at-risk commitments."
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average probability score across planned giving commitments. Used to weight pipeline value and prioritize stewardship investment."
    - name: "legacy_society_member_count"
      expr: COUNT(CASE WHEN legacy_society_member = TRUE THEN 1 END)
      comment: "Number of legacy society members. Tracks the size of the committed planned giving community — growth is a key indicator of long-term organizational sustainability."
    - name: "planned_giving_count"
      expr: COUNT(1)
      comment: "Total number of planned giving commitments. Measures pipeline volume — used alongside value to assess pipeline depth."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used in planned gift valuations. Used to assess consistency of valuation methodology across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_wealth_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect wealth screening quality and capacity estimation metrics. Tracks screening coverage, confidence, and capacity estimates. Used by prospect research teams to prioritize cultivation investment. Source-of-record: iWave, DonorSearch, WealthEngine."
  source: "`vibe_ngo_v1`.`donor`.`wealth_screening`"
  dimensions:
    - name: "screening_provider"
      expr: screening_provider
      comment: "Wealth screening vendor (iWave, DonorSearch, WealthEngine) — used to compare data quality and ROI across providers."
    - name: "screening_type"
      expr: screening_type
      comment: "Type of screening (initial, refresh, deep-dive) — used to track screening lifecycle and refresh cadence."
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening (pending, complete, reviewed) — used to track research pipeline throughput."
    - name: "capacity_rating_tier"
      expr: capacity_rating_tier
      comment: "Capacity rating tier assigned by screening (major, mid-level, annual) — primary segmentation for portfolio strategy."
    - name: "data_privacy_consent_flag"
      expr: data_privacy_consent_flag
      comment: "Indicates whether data privacy consent was obtained for screening — critical compliance dimension."
    - name: "screening_date_year"
      expr: YEAR(screening_date)
      comment: "Year of screening — used to track screening volume and identify constituents due for refresh."
    - name: "net_worth_range"
      expr: net_worth_range
      comment: "Net worth range band — used to segment constituents by wealth tier for portfolio strategy."
  measures:
    - name: "total_screened_count"
      expr: COUNT(1)
      comment: "Total number of wealth screenings conducted. Measures research coverage — used to track progress toward full portfolio screening."
    - name: "total_philanthropic_capacity"
      expr: SUM(CAST(philanthropic_capacity_estimate AS DOUBLE))
      comment: "Total estimated philanthropic giving capacity across screened constituents. Measures the theoretical ceiling of the donor portfolio — used in major gift strategy and goal-setting."
    - name: "avg_philanthropic_capacity"
      expr: AVG(CAST(philanthropic_capacity_estimate AS DOUBLE))
      comment: "Average estimated philanthropic capacity per screened constituent. Benchmarks portfolio quality — used to assess whether screening is identifying high-capacity individuals."
    - name: "avg_screening_confidence_score"
      expr: AVG(CAST(screening_confidence_score AS DOUBLE))
      comment: "Average confidence score of wealth screenings. Measures data quality — low confidence scores indicate need for manual research validation before cultivation investment."
    - name: "total_estimated_net_worth"
      expr: SUM(CAST(estimated_net_worth AS DOUBLE))
      comment: "Total estimated net worth across screened constituents. Provides a macro view of portfolio wealth — used in long-term fundraising strategy and endowment planning."
    - name: "avg_real_estate_value"
      expr: AVG(CAST(real_estate_value AS DOUBLE))
      comment: "Average real estate holdings value per screened constituent. Real estate is a primary indicator of giving capacity — used to identify planned giving and major gift prospects."
    - name: "total_screening_cost"
      expr: SUM(CAST(screening_cost AS DOUBLE))
      comment: "Total cost of wealth screening activities. Used to compute cost-per-screened-constituent and assess ROI of research investment."
    - name: "avg_screening_cost"
      expr: AVG(CAST(screening_cost AS DOUBLE))
      comment: "Average cost per wealth screening. Used to benchmark vendor pricing and optimize research budget allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor fund balance, restriction, and compliance metrics. Tracks fund health, restriction compliance, and cost-share obligations. Used by finance and development leadership for fund stewardship and compliance reporting. Source-of-record: Financial Edge NXT, SAP S/4HANA, Blackbaud CRM."
  source: "`vibe_ngo_v1`.`donor`.`donor_fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of fund (endowment, restricted, unrestricted, quasi-endowment) — primary segmentation for fund portfolio analysis."
    - name: "fund_category"
      expr: fund_category
      comment: "Category of fund (program, operations, capital, emergency) — used to align fund portfolio to organizational priorities."
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (active, closed, suspended) — used to filter to active funds."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type (unrestricted, temporarily restricted, permanently restricted) — critical for fund accounting and FASB ASC 958 compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code — enables multi-currency fund portfolio reporting."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for ODA reporting and international development fund classification."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN SDG alignment — used to report fund portfolio by programmatic priority."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates whether the fund requires cost-share matching — used to track cost-share obligations and compliance."
    - name: "audit_required"
      expr: audit_required
      comment: "Indicates whether the fund requires an audit — used to track audit obligations and compliance."
    - name: "inception_date_year"
      expr: YEAR(inception_date)
      comment: "Year the fund was established — used for fund vintage analysis."
  measures:
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance across all donor funds. Primary fund portfolio health metric — used in liquidity analysis and program planning."
    - name: "avg_fund_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average balance per donor fund. Benchmarks fund size — used to identify underfunded programs and prioritize fundraising efforts."
    - name: "total_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across funds requiring cost-share. Used to assess the aggregate cost-share obligation and ensure compliance with donor requirements."
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of donor funds. Measures portfolio breadth — used to assess fund management complexity and administrative burden."
    - name: "active_fund_count"
      expr: COUNT(CASE WHEN fund_status = 'Active' THEN 1 END)
      comment: "Number of active donor funds. Tracks the live fund portfolio — used for resource planning and compliance monitoring."
    - name: "cost_share_required_fund_count"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of funds with cost-share requirements. Measures the scope of cost-share obligations — used to ensure adequate unrestricted revenue to meet matching requirements."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across donor funds. Used to assess the blended overhead recovery rate and identify funds with below-NICRA indirect cost allowances."
    - name: "total_minimum_gift_threshold"
      expr: SUM(CAST(minimum_gift_amount AS DOUBLE))
      comment: "Total minimum gift thresholds across funds. Used to assess the aggregate minimum commitment required to activate all funds — informs fundraising floor targets."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_soft_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Soft credit attribution and solicitor performance metrics. Tracks credited revenue by solicitor, allocation accuracy, and recognition eligibility. Used by major gift and development operations teams. Source-of-record: Raiser's Edge NXT, Salesforce NPSP."
  source: "`vibe_ngo_v1`.`donor`.`soft_credit`"
  dimensions:
    - name: "soft_credit_type"
      expr: soft_credit_type
      comment: "Type of soft credit (solicitor, influencer, board member, volunteer) — used to segment attribution by relationship role."
    - name: "soft_credit_status"
      expr: soft_credit_status
      comment: "Status of the soft credit (pending, approved, reversed) — used to filter to confirmed attributions."
    - name: "solicitor_relationship"
      expr: solicitor_relationship
      comment: "Relationship of the credited individual to the donor — used to analyze which relationship types drive the most revenue."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code — enables multi-currency soft credit reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the soft credit — used for annual solicitor performance reporting."
    - name: "recognition_eligible_flag"
      expr: recognition_eligible_flag
      comment: "Indicates whether the soft credit counts toward recognition thresholds — used for solicitor recognition program management."
    - name: "lifetime_value_eligible_flag"
      expr: lifetime_value_eligible_flag
      comment: "Indicates whether the soft credit counts toward lifetime value calculations — used for portfolio valuation."
    - name: "soft_credit_date_month"
      expr: DATE_TRUNC('MONTH', soft_credit_date)
      comment: "Month of soft credit — used to track solicitor productivity trends over time."
  measures:
    - name: "total_soft_credit_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total soft credit amount attributed to solicitors and influencers. Measures the revenue impact of relationship-based fundraising — used in solicitor performance reviews and compensation planning."
    - name: "avg_soft_credit_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average soft credit amount per attribution. Benchmarks solicitor productivity — used to identify high-performing officers and set performance targets."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage per soft credit. Used to assess whether credit is being distributed appropriately across team members — imbalanced allocations may indicate attribution disputes."
    - name: "distinct_solicitor_count"
      expr: COUNT(DISTINCT staff_member_id)
      comment: "Number of unique staff members receiving soft credit. Measures the breadth of the fundraising team contributing to revenue — used in team capacity and performance analysis."
    - name: "soft_credit_count"
      expr: COUNT(1)
      comment: "Total number of soft credit attributions. Used alongside amount to compute average credit per attribution and assess attribution completeness."
    - name: "recognition_eligible_amount"
      expr: SUM(CASE WHEN recognition_eligible_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total soft credit amount eligible for recognition programs. Used to determine solicitor recognition tier qualifications and incentive compensation calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor segmentation portfolio and giving capacity metrics. Tracks segment size, giving level distribution, and portfolio coverage. Used by direct response and annual fund teams to optimize segmentation strategy. Source-of-record: Raiser's Edge NXT, Salesforce NPSP."
  source: "`vibe_ngo_v1`.`donor`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (acquisition, retention, upgrade, lapsed, major gift) — primary segmentation for portfolio strategy analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, inactive, archived) — used to filter to live segments."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Donor lifecycle stage represented by the segment — used to track portfolio distribution across acquisition, retention, and lapsed stages."
    - name: "stewardship_tier"
      expr: stewardship_tier
      comment: "Stewardship tier of the segment — used to align stewardship investment to segment value."
    - name: "is_dynamic"
      expr: is_dynamic
      comment: "Indicates whether the segment is dynamically refreshed — used to assess data currency and segmentation quality."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment — used for regional fundraising strategy analysis."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which segment members were acquired — used to evaluate acquisition channel ROI."
    - name: "wealth_screening_tier"
      expr: wealth_screening_tier
      comment: "Wealth screening tier of the segment — used to align ask amounts to capacity."
  measures:
    - name: "total_segment_count"
      expr: COUNT(1)
      comment: "Total number of donor segments. Measures segmentation complexity — used to assess whether the portfolio is over-segmented or under-segmented."
    - name: "avg_giving_level_max"
      expr: AVG(CAST(giving_level_max AS DOUBLE))
      comment: "Average upper giving level threshold across segments. Used to assess whether segments are calibrated to appropriate giving ranges."
    - name: "avg_giving_level_min"
      expr: AVG(CAST(giving_level_min AS DOUBLE))
      comment: "Average lower giving level threshold across segments. Used alongside max to assess giving range distribution across the portfolio."
    - name: "total_giving_capacity_range"
      expr: SUM((CAST(giving_level_max AS DOUBLE)) - (CAST(giving_level_min AS DOUBLE)))
      comment: "Total giving capacity range covered by all segments. Measures the breadth of the segmentation strategy — gaps indicate donor populations not being targeted."
    - name: "dynamic_segment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_dynamic = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segments that are dynamically refreshed. Higher rates indicate more current and accurate segmentation — static segments risk targeting stale donor data."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_indicator_funding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor-designated indicator funding commitments and fulfillment metrics. Tracks funding amounts, donor targets, and commitment status by programmatic indicator. Used by MEL and development teams to align donor funding to program outcomes. Source-of-record: Salesforce NPSP, eTools."
  source: "`vibe_ngo_v1`.`donor`.`indicator_funding`"
  dimensions:
    - name: "indicator_funding_status"
      expr: indicator_funding_status
      comment: "Current status of the indicator funding commitment (active, fulfilled, lapsed) — used to filter to live commitments."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type of the funding — used to align funding to appropriate program accounts."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting required by the donor — used to plan MEL reporting workload."
    - name: "funding_start_date_year"
      expr: YEAR(funding_start_date)
      comment: "Year funding begins — used for annual funding pipeline analysis."
    - name: "funding_end_date_year"
      expr: YEAR(funding_end_date)
      comment: "Year funding ends — used to identify expiring commitments requiring renewal."
  measures:
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total donor funding committed to specific program indicators. Measures the financial backing for outcome-linked giving — used to align program budgets to donor commitments."
    - name: "avg_funding_amount"
      expr: AVG(CAST(funding_amount AS DOUBLE))
      comment: "Average funding amount per indicator commitment. Benchmarks the scale of outcome-linked giving — used to assess whether commitments are sufficient to achieve indicator targets."
    - name: "total_donor_target_value"
      expr: SUM(CAST(donor_target_value AS DOUBLE))
      comment: "Total donor-specified target values across indicator funding commitments. Used to align MEL targets to donor expectations and assess target feasibility."
    - name: "distinct_indicator_count"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of unique program indicators with donor funding. Measures the breadth of outcome-linked giving — used to assess alignment between donor priorities and program portfolio."
    - name: "distinct_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors with indicator funding commitments. Measures the depth of outcome-linked donor engagement — used to track growth of impact-first giving."
    - name: "funding_commitment_count"
      expr: COUNT(1)
      comment: "Total number of indicator funding commitments. Used alongside amount to assess portfolio volume and administrative complexity."
$$;