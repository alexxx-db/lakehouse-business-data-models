-- Metric views for domain: donor | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising gift metrics tracking donation volume, value, net revenue, and gift quality indicators. Primary KPI layer for fundraising performance and donor giving behavior."
  source: "`vibe_ngo_v1`.`donor`.`gift`"
  dimensions:
    - name: "gift_type"
      expr: gift_type
      comment: "Type of gift (e.g. cash, in-kind, stock, matching) used to segment giving patterns and channel mix."
    - name: "gift_status"
      expr: gift_status
      comment: "Current processing status of the gift (e.g. posted, pending, reversed) for pipeline and reconciliation analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. credit card, check, wire) to analyze channel preferences and processing costs."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the gift was received (e.g. online, direct mail, event) for multi-channel fundraising analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Whether the gift is restricted or unrestricted, critical for fund allocation and program planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the gift for multi-currency fundraising operations and reporting."
    - name: "gift_date_month"
      expr: DATE_TRUNC('MONTH', gift_date)
      comment: "Month of gift date for trend analysis and seasonal fundraising performance tracking."
    - name: "gift_date_year"
      expr: YEAR(gift_date)
      comment: "Fiscal/calendar year of gift for year-over-year fundraising comparison."
    - name: "matching_gift_flag"
      expr: matching_gift_flag
      comment: "Indicates whether the gift is a corporate matching gift, used to track match leverage and employer engagement."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Indicates anonymous gifts for stewardship and recognition planning."
    - name: "tribute_flag"
      expr: tribute_flag
      comment: "Indicates tribute or memorial gifts for targeted stewardship and acknowledgement workflows."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Flags refunded gifts to isolate reversals from net revenue calculations."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month of GL posting date for financial period reconciliation."
  measures:
    - name: "total_gift_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross gift amount received. Primary fundraising revenue KPI used in board reporting and campaign performance dashboards."
    - name: "total_net_gift_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net gift amount after fees and deductions. Reflects actual revenue available to the organization for program delivery."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred. Drives cost-of-fundraising analysis and payment channel optimization decisions."
    - name: "gift_count"
      expr: COUNT(1)
      comment: "Total number of gifts received. Baseline volume metric for fundraising throughput and donor engagement tracking."
    - name: "unique_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors who made a gift. Core donor base metric used to track donor acquisition, retention, and breadth of support."
    - name: "avg_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gift size. Key indicator of donor generosity trends and effectiveness of ask strategies."
    - name: "total_matching_gift_amount"
      expr: SUM(CASE WHEN matching_gift_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of corporate matching gifts. Measures leverage of employer match programs and their contribution to total fundraising."
    - name: "total_goods_services_value"
      expr: SUM(CAST(goods_services_value AS DOUBLE))
      comment: "Total value of goods and services provided in exchange for gifts. Required for IRS-compliant acknowledgement and net charitable contribution calculation."
    - name: "refund_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN 1 END)
      comment: "Number of refunded gifts. Monitors gift reversal rate as a quality and donor satisfaction indicator."
    - name: "total_refund_amount"
      expr: SUM(CASE WHEN refund_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of refunded gifts. Quantifies revenue at risk from reversals and informs donor relations interventions."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge pipeline and fulfillment metrics tracking committed giving, outstanding balances, installment health, and write-off risk. Essential for cash flow forecasting and major gift portfolio management."
  source: "`vibe_ngo_v1`.`donor`.`pledge`"
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of the pledge (e.g. active, fulfilled, cancelled, written-off) for pipeline segmentation."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge (e.g. major gift, recurring, event) for portfolio mix analysis."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g. monthly, quarterly, annual) for cash flow planning."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for pledge installments, used to assess collection risk and processing preferences."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pledge for multi-currency portfolio management."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates recurring pledges, which represent predictable revenue streams critical for operational planning."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Flags pledges eligible for employer matching, used to prioritize match solicitation outreach."
    - name: "pledge_date_year"
      expr: YEAR(pledge_date)
      comment: "Year the pledge was made for cohort and year-over-year pipeline analysis."
    - name: "pledge_date_month"
      expr: DATE_TRUNC('MONTH', pledge_date)
      comment: "Month the pledge was made for seasonal pipeline trend analysis."
    - name: "next_installment_due_date_month"
      expr: DATE_TRUNC('MONTH', next_installment_due_date)
      comment: "Month the next installment is due, used for short-term cash flow forecasting."
  measures:
    - name: "total_pledge_amount"
      expr: SUM(CAST(total_pledge_amount AS DOUBLE))
      comment: "Total committed pledge value across all active pledges. Primary pipeline metric for major gift and planned giving portfolios."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected against pledges. Measures pledge fulfillment progress and actual cash received."
    - name: "total_balance_outstanding"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total outstanding pledge balance yet to be collected. Critical for accounts receivable and cash flow forecasting."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total value of pledges written off as uncollectable. Measures portfolio credit risk and informs pledge acceptance policies."
    - name: "pledge_count"
      expr: COUNT(1)
      comment: "Total number of pledges. Baseline volume metric for pipeline depth and major gift officer workload."
    - name: "unique_pledging_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors with active pledges. Measures depth of committed donor relationships."
    - name: "avg_pledge_amount"
      expr: AVG(CAST(total_pledge_amount AS DOUBLE))
      comment: "Average pledge size. Benchmarks major gift ask levels and tracks portfolio quality over time."
    - name: "avg_next_installment_amount"
      expr: AVG(CAST(next_installment_amount AS DOUBLE))
      comment: "Average upcoming installment amount. Used for short-term cash flow projection and collections prioritization."
    - name: "cancelled_pledge_count"
      expr: COUNT(CASE WHEN pledge_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled pledges. Monitors pledge attrition rate as a donor retention and stewardship quality signal."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Sum of most recent installment payments received. Provides a near-term cash receipts indicator for treasury management."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance and fundraising efficiency metrics. Enables leadership to evaluate ROI, goal attainment, and cost-effectiveness of fundraising campaigns."
  source: "`vibe_ngo_v1`.`donor`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g. annual fund, capital, emergency) for portfolio mix and strategy analysis."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g. active, closed, planned) for pipeline and performance tracking."
    - name: "appeal_channel"
      expr: appeal_channel
      comment: "Primary solicitation channel for the campaign (e.g. digital, direct mail, events) for channel effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of campaign financials for multi-currency reporting."
    - name: "is_active"
      expr: is_active
      comment: "Indicates currently active campaigns for operational dashboard filtering."
    - name: "is_public"
      expr: is_public
      comment: "Indicates publicly visible campaigns for external communications and transparency reporting."
    - name: "matching_gift_eligible"
      expr: matching_gift_eligible
      comment: "Flags campaigns eligible for employer matching to prioritize match leverage strategies."
    - name: "tax_deductible"
      expr: tax_deductible
      comment: "Indicates tax-deductible campaigns for donor communications and compliance reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment for impact reporting and donor segmentation by cause area."
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Target donor segment for the campaign, used to evaluate segment-specific fundraising effectiveness."
    - name: "start_date_year"
      expr: YEAR(start_date)
      comment: "Year the campaign started for year-over-year performance comparison."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started for seasonal fundraising trend analysis."
  measures:
    - name: "total_raised_amount"
      expr: SUM(CAST(total_raised_amount AS DOUBLE))
      comment: "Total funds raised across campaigns. Primary fundraising revenue KPI for board and executive reporting."
    - name: "total_goal_amount"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Total fundraising goal across campaigns. Used as the denominator for goal attainment rate calculations."
    - name: "total_cost_of_fundraising"
      expr: SUM(CAST(cost_of_fundraising AS DOUBLE))
      comment: "Total cost incurred to run campaigns. Core input for cost-of-fundraising ratio and ROI analysis."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment percentage across campaigns. Directly measures fundraising efficiency and informs resource allocation decisions."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline volume metric for portfolio breadth and fundraising program scale."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns. Measures operational fundraising pipeline depth."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor and constituent portfolio metrics covering giving capacity, lifetime value, retention signals, and relationship quality. Drives major gift strategy, prospect prioritization, and donor retention programs."
  source: "`vibe_ngo_v1`.`donor`.`constituent`"
  dimensions:
    - name: "constituent_type"
      expr: constituent_type
      comment: "Type of constituent (e.g. individual, foundation, corporation, government) for portfolio segmentation."
    - name: "funder_classification"
      expr: funder_classification
      comment: "Classification of the funder (e.g. major donor, mid-level, grassroots) for tiered stewardship strategy."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier assigned to the constituent for prioritized engagement and stewardship resource allocation."
    - name: "record_status"
      expr: record_status
      comment: "Active/inactive status of the constituent record for portfolio hygiene and active donor base sizing."
    - name: "communication_preference"
      expr: communication_preference
      comment: "Preferred communication channel for donor outreach optimization and engagement strategy."
    - name: "preferred_grant_modality"
      expr: preferred_grant_modality
      comment: "Preferred grant modality for institutional funders, used to tailor proposals and stewardship."
    - name: "mailing_country_code"
      expr: mailing_country_code
      comment: "Country of the constituent for geographic fundraising analysis and international donor strategy."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "GDPR consent status for compliance-driven segmentation and communication eligibility."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Email opt-in status for digital fundraising reach and deliverable audience sizing."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Flags deceased constituents for exclusion from active solicitation and planned giving portfolio management."
    - name: "dac_member_flag"
      expr: dac_member_flag
      comment: "Indicates DAC member status for ODA-eligible funding source tracking and institutional donor reporting."
    - name: "first_gift_date_year"
      expr: YEAR(first_gift_date)
      comment: "Year of first gift for donor cohort analysis and acquisition vintage tracking."
    - name: "prospect_research_rating"
      expr: prospect_research_rating
      comment: "Prospect research wealth rating for major gift capacity segmentation and ask calibration."
  measures:
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Total lifetime giving across all constituents. Measures cumulative fundraising value of the donor portfolio and long-term relationship ROI."
    - name: "avg_lifetime_giving"
      expr: AVG(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Average lifetime giving per constituent. Benchmarks donor value and informs major gift threshold setting."
    - name: "total_estimated_giving_capacity"
      expr: SUM(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across the portfolio. Quantifies the addressable fundraising opportunity for major gift and planned giving programs."
    - name: "avg_estimated_giving_capacity"
      expr: AVG(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per constituent. Used to calibrate ask amounts and prioritize major gift officer portfolios."
    - name: "total_largest_gift_amount"
      expr: SUM(CAST(largest_gift_amount AS DOUBLE))
      comment: "Sum of each constituent's largest single gift. Indicates peak generosity potential across the portfolio."
    - name: "constituent_count"
      expr: COUNT(1)
      comment: "Total number of constituents in the database. Baseline metric for donor base size and CRM portfolio scope."
    - name: "active_constituent_count"
      expr: COUNT(CASE WHEN record_status = 'Active' AND deceased_flag = FALSE THEN 1 END)
      comment: "Number of active, living constituents. Defines the actionable donor universe for solicitation and stewardship programs."
    - name: "email_opted_in_count"
      expr: COUNT(CASE WHEN email_opt_in_flag = TRUE THEN 1 END)
      comment: "Number of constituents opted in to email communications. Measures digital fundraising reach and deliverable audience size."
    - name: "gdpr_consented_count"
      expr: COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN 1 END)
      comment: "Number of constituents with valid GDPR consent. Critical compliance metric for EU donor engagement and regulatory risk management."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect pipeline and major gift cultivation metrics. Enables major gift officers and development leadership to manage the fundraising pipeline, track conversion rates, and prioritize high-capacity prospects."
  source: "`vibe_ngo_v1`.`donor`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect in the pipeline (e.g. identified, qualified, cultivating, solicited, closed) for stage-gate analysis."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g. individual, foundation, corporate) for portfolio mix and strategy segmentation."
    - name: "stage"
      expr: stage
      comment: "Cultivation stage of the prospect for pipeline velocity and conversion funnel analysis."
    - name: "research_stage"
      expr: research_stage
      comment: "Stage of prospect research completion for workload management and qualification prioritization."
    - name: "rating"
      expr: rating
      comment: "Overall prospect rating combining capacity and affinity for portfolio prioritization."
    - name: "program_interest_area"
      expr: program_interest_area
      comment: "Program area of interest for the prospect, used to match prospects to relevant campaigns and impact stories."
    - name: "geographic_interest"
      expr: geographic_interest
      comment: "Geographic focus of the prospect for country office and regional fundraising alignment."
    - name: "cultivation_strategy"
      expr: cultivation_strategy
      comment: "Assigned cultivation strategy for the prospect, used to track strategy effectiveness and resource allocation."
    - name: "identification_date_year"
      expr: YEAR(identification_date)
      comment: "Year the prospect was identified for pipeline vintage and cohort analysis."
    - name: "expected_close_date_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Expected close month for near-term pipeline forecasting and gift officer workload planning."
  measures:
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total ask amount across all prospects. Measures the total value of the major gift pipeline being actively solicited."
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across all prospects. Quantifies the maximum addressable opportunity in the prospect portfolio."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average probability of gift conversion across prospects. Measures pipeline quality and informs revenue forecasting confidence."
    - name: "avg_estimated_gift_range_max"
      expr: AVG(CAST(estimated_gift_range_max AS DOUBLE))
      comment: "Average upper bound of estimated gift range. Used to calibrate ask strategies and benchmark portfolio quality."
    - name: "prospect_count"
      expr: COUNT(1)
      comment: "Total number of prospects in the pipeline. Baseline metric for pipeline depth and major gift officer portfolio sizing."
    - name: "converted_prospect_count"
      expr: COUNT(CASE WHEN conversion_date IS NOT NULL THEN 1 END)
      comment: "Number of prospects who converted to donors. Measures pipeline conversion effectiveness and cultivation strategy ROI."
    - name: "avg_wealth_screening_score"
      expr: AVG(CAST(wealth_screening_score AS DOUBLE))
      comment: "Average wealth screening score across prospects. Benchmarks portfolio capacity quality and guides prospect research prioritization."
    - name: "total_estimated_gift_range_max"
      expr: SUM(CAST(estimated_gift_range_max AS DOUBLE))
      comment: "Total upper-bound gift potential across all prospects. Provides a ceiling estimate for the major gift pipeline value."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal-level fundraising performance metrics covering revenue, cost efficiency, response rates, and ROI. Enables direct marketing and fundraising teams to optimize solicitation strategies."
  source: "`vibe_ngo_v1`.`donor`.`appeal`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g. acquisition, renewal, upgrade, lapsed reactivation) for strategy-level performance comparison."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g. active, closed, planned) for pipeline and performance tracking."
    - name: "channel"
      expr: channel
      comment: "Solicitation channel (e.g. direct mail, email, telemarketing, digital) for channel effectiveness and cost analysis."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of appeal costs for multi-currency cost reporting."
    - name: "revenue_currency_code"
      expr: revenue_currency_code
      comment: "Currency of appeal revenue for multi-currency revenue reporting."
    - name: "control_group_flag"
      expr: control_group_flag
      comment: "Indicates control group appeals for A/B test analysis and experimental design evaluation."
    - name: "test_segment_flag"
      expr: test_segment_flag
      comment: "Indicates test segment appeals for experimental vs. control performance comparison."
    - name: "mailing_date_month"
      expr: DATE_TRUNC('MONTH', mailing_date)
      comment: "Month of mailing for seasonal response rate and revenue trend analysis."
    - name: "mailing_date_year"
      expr: YEAR(mailing_date)
      comment: "Year of mailing for year-over-year appeal performance benchmarking."
  measures:
    - name: "total_revenue_amount"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated by appeals. Primary appeal performance KPI for direct marketing ROI analysis."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of running appeals. Core input for cost-of-fundraising and net revenue calculations."
    - name: "avg_response_rate_percent"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate across appeals. Measures solicitation effectiveness and audience engagement quality."
    - name: "avg_roi_ratio"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average return on investment ratio across appeals. Directly measures fundraising efficiency and guides channel investment decisions."
    - name: "avg_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount across appeals. Benchmarks ask strategy calibration and its relationship to response rates."
    - name: "avg_average_gift_amount"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average of the per-appeal average gift amounts. Tracks gift size trends across solicitation strategies."
    - name: "appeal_count"
      expr: COUNT(1)
      comment: "Total number of appeals executed. Baseline metric for solicitation program scale and channel activity volume."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fundraising_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising event performance metrics covering revenue, cost efficiency, net revenue, and goal attainment. Enables event managers and development leadership to evaluate event ROI and optimize the events portfolio."
  source: "`vibe_ngo_v1`.`donor`.`fundraising_event`"
  dimensions:
    - name: "fundraising_event_type"
      expr: fundraising_event_type
      comment: "Type of fundraising event (e.g. gala, auction, walkathon, webinar) for event portfolio mix and strategy analysis."
    - name: "fundraising_event_status"
      expr: fundraising_event_status
      comment: "Current status of the event (e.g. planned, active, completed, cancelled) for pipeline and performance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of event financials for multi-currency reporting."
    - name: "is_virtual_event"
      expr: is_virtual_event
      comment: "Indicates virtual vs. in-person events for format effectiveness and cost comparison analysis."
    - name: "is_tax_deductible"
      expr: is_tax_deductible
      comment: "Indicates tax-deductible events for donor communications and compliance reporting."
    - name: "venue_country_code"
      expr: venue_country_code
      comment: "Country where the event is held for geographic fundraising analysis."
    - name: "venue_city"
      expr: venue_city
      comment: "City where the event is held for regional event performance analysis."
    - name: "fundraising_event_date_year"
      expr: YEAR(fundraising_event_date)
      comment: "Year of the event for year-over-year event portfolio performance comparison."
    - name: "fundraising_event_date_month"
      expr: DATE_TRUNC('MONTH', fundraising_event_date)
      comment: "Month of the event for seasonal event performance and planning analysis."
  measures:
    - name: "total_revenue_raised"
      expr: SUM(CAST(total_revenue_raised AS DOUBLE))
      comment: "Total revenue raised across fundraising events. Primary event performance KPI for development leadership and board reporting."
    - name: "total_event_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total cost of running fundraising events. Core input for event net revenue and cost-efficiency analysis."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue from events after costs. Measures actual financial contribution of the events program to the organization."
    - name: "total_fundraising_goal_amount"
      expr: SUM(CAST(fundraising_goal_amount AS DOUBLE))
      comment: "Total fundraising goal across events. Used as denominator for event goal attainment rate calculations."
    - name: "avg_tax_deductible_percentage"
      expr: AVG(CAST(tax_deductible_percentage AS DOUBLE))
      comment: "Average tax-deductible percentage across events. Informs donor acknowledgement accuracy and IRS compliance."
    - name: "event_count"
      expr: COUNT(1)
      comment: "Total number of fundraising events. Baseline metric for events program scale and portfolio breadth."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_stewardship_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship and engagement activity metrics tracking outreach volume, solicitation pipeline, cost of stewardship, and follow-up compliance. Enables relationship managers to optimize stewardship plans and measure engagement quality."
  source: "`vibe_ngo_v1`.`donor`.`stewardship_activity`"
  dimensions:
    - name: "stewardship_activity_type"
      expr: stewardship_activity_type
      comment: "Type of stewardship activity (e.g. site visit, impact report, phone call, event invitation) for activity mix and effectiveness analysis."
    - name: "stewardship_activity_status"
      expr: stewardship_activity_status
      comment: "Current status of the activity (e.g. planned, completed, cancelled) for workload and completion rate tracking."
    - name: "stewardship_plan_stage"
      expr: stewardship_plan_stage
      comment: "Stage within the stewardship plan for pipeline progression and relationship depth analysis."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the stewardship activity (e.g. email, phone, in-person) for channel effectiveness analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the activity for workload management and high-value donor prioritization."
    - name: "donor_sentiment"
      expr: donor_sentiment
      comment: "Recorded donor sentiment from the interaction for relationship health monitoring and early warning detection."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the stewardship activity for effectiveness measurement and strategy refinement."
    - name: "solicitation_made_flag"
      expr: solicitation_made_flag
      comment: "Indicates whether a solicitation was made during the activity for pipeline conversion tracking."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Flags activities requiring follow-up for compliance and relationship management accountability."
    - name: "impact_story_shared_flag"
      expr: impact_story_shared_flag
      comment: "Indicates whether an impact story was shared, used to measure impact communication frequency and its effect on donor retention."
    - name: "acknowledgement_sent_flag"
      expr: acknowledgement_sent_flag
      comment: "Indicates whether an acknowledgement was sent for compliance and stewardship quality monitoring."
    - name: "stewardship_activity_date_month"
      expr: DATE_TRUNC('MONTH', stewardship_activity_date)
      comment: "Month of the stewardship activity for trend analysis and activity cadence monitoring."
    - name: "stewardship_activity_date_year"
      expr: YEAR(stewardship_activity_date)
      comment: "Year of the stewardship activity for year-over-year engagement volume comparison."
  measures:
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total solicitation amount across stewardship activities. Measures the value of the ask pipeline generated through stewardship interactions."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities. Measures investment in donor relationships and informs cost-per-touch analysis."
    - name: "activity_count"
      expr: COUNT(1)
      comment: "Total number of stewardship activities. Baseline metric for relationship management activity volume and team productivity."
    - name: "unique_constituent_touched_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents receiving stewardship. Measures breadth of active relationship management and stewardship plan coverage."
    - name: "solicitation_activity_count"
      expr: COUNT(CASE WHEN solicitation_made_flag = TRUE THEN 1 END)
      comment: "Number of activities where a solicitation was made. Tracks ask frequency and pipeline generation activity."
    - name: "follow_up_pending_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE AND completed_date IS NULL THEN 1 END)
      comment: "Number of activities with outstanding follow-up actions. Measures stewardship compliance risk and relationship management backlog."
    - name: "avg_cost_per_activity"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship activity. Benchmarks stewardship efficiency and informs budget allocation across activity types."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor fund portfolio metrics tracking fund balances, restriction compliance, cost share obligations, and indirect cost rates. Enables finance and development leadership to manage fund health, compliance, and strategic allocation."
  source: "`vibe_ngo_v1`.`donor`.`fund`"
  dimensions:
    - name: "donor_fund_type"
      expr: donor_fund_type
      comment: "Type of donor fund (e.g. endowment, restricted, unrestricted, emergency) for portfolio mix and compliance analysis."
    - name: "donor_fund_status"
      expr: donor_fund_status
      comment: "Current status of the fund (e.g. active, closed, suspended) for active portfolio management."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type of the fund (e.g. restricted, unrestricted, temporarily restricted) for compliance and allocation planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fund for multi-currency portfolio management."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for ODA-aligned fund classification and donor reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN SDG alignment of the fund for impact reporting and strategic portfolio analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the fund for regional portfolio analysis and country office allocation."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates funds with cost share obligations for compliance monitoring and co-funding tracking."
    - name: "audit_required"
      expr: audit_required
      comment: "Flags funds requiring external audit for compliance risk management and audit planning."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for the fund for donor reporting workload planning."
    - name: "inception_date_year"
      expr: YEAR(inception_date)
      comment: "Year the fund was established for portfolio vintage and longevity analysis."
  measures:
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance across all donor funds. Primary fund portfolio health metric for treasury and finance leadership."
    - name: "avg_fund_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average fund balance. Benchmarks fund size distribution and identifies outliers requiring attention."
    - name: "total_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across funds. Measures overhead recovery efficiency and compliance with donor-negotiated rates."
    - name: "total_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost share percentage across funds with cost share requirements. Monitors co-funding obligation levels and compliance risk."
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of donor funds. Baseline metric for fund portfolio breadth and administrative complexity."
    - name: "active_fund_count"
      expr: COUNT(CASE WHEN donor_fund_status = 'Active' THEN 1 END)
      comment: "Number of currently active donor funds. Measures the operational fund portfolio size for resource planning."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of funds requiring external audit. Drives audit planning, compliance resource allocation, and risk management."
    - name: "total_minimum_gift_amount"
      expr: SUM(CAST(minimum_gift_amount AS DOUBLE))
      comment: "Sum of minimum gift thresholds across funds. Informs gift acceptance policy review and fund accessibility analysis."
$$;
