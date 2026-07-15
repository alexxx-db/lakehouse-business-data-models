-- Metric views for domain: donor | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising revenue metrics derived from individual gift transactions. Tracks gift volume, revenue, net amounts, and giving patterns to inform fundraising strategy and donor stewardship decisions. Note: FK columns for mel_indicator_id, mel_indicator_result_id, mel_evaluation_id, and safeguarding_safeguarding_incident_id are excluded per VREQ-017/018/019/020 as those relationships are being removed from this table."
  source: "`vibe_ngo_v1`.`donor`.`gift`"
  dimensions:
    - name: "gift_type"
      expr: gift_type
      comment: "Type of gift (e.g., cash, in-kind, matching) for segmenting revenue by giving vehicle."
    - name: "gift_status"
      expr: gift_status
      comment: "Current processing status of the gift (e.g., posted, pending, refunded) for pipeline and reconciliation analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., credit card, check, wire) to analyze channel preferences and processing costs."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the gift was received (e.g., online, direct mail, event) for channel ROI analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Whether the gift is restricted, unrestricted, or temporarily restricted — critical for fund allocation and compliance."
    - name: "gift_date_month"
      expr: DATE_TRUNC('MONTH', gift_date)
      comment: "Month of gift date for trend analysis and seasonal fundraising performance."
    - name: "gift_date_year"
      expr: YEAR(gift_date)
      comment: "Fiscal/calendar year of gift for year-over-year revenue comparison."
    - name: "matching_gift_flag"
      expr: matching_gift_flag
      comment: "Indicates whether the gift is a corporate match, enabling matching gift revenue tracking."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Flags refunded gifts to allow net revenue calculations and refund rate monitoring."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Indicates anonymous gifts for stewardship and recognition planning."
    - name: "tribute_flag"
      expr: tribute_flag
      comment: "Indicates tribute/memorial gifts for targeted stewardship and notification workflows."
    - name: "irs_compliant_flag"
      expr: irs_compliant_flag
      comment: "Flags gifts that meet IRS compliance requirements for regulatory reporting."
  measures:
    - name: "total_gift_count"
      expr: COUNT(1)
      comment: "Total number of gift transactions. Baseline volume metric for fundraising throughput and donor engagement."
    - name: "total_gross_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross gift amount received. Primary revenue KPI for fundraising performance and goal tracking."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net gift amount after fees. Reflects actual revenue retained by the organization for program funding."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total processing fees across all gifts. Informs payment channel cost analysis and fee negotiation decisions."
    - name: "avg_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gift size. Key indicator of donor generosity trends and effectiveness of ask strategies."
    - name: "unique_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors who made gifts. Measures donor base breadth and acquisition/retention effectiveness."
    - name: "matching_gift_revenue"
      expr: SUM(CASE WHEN matching_gift_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from corporate matching gifts. Quantifies the impact of matching gift programs on fundraising."
    - name: "refund_amount"
      expr: SUM(CASE WHEN refund_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of refunded gifts. Monitors refund exposure and donor satisfaction issues."
    - name: "goods_services_value_total"
      expr: SUM(CAST(goods_services_value AS DOUBLE))
      comment: "Total value of goods and services provided in exchange for gifts. Required for IRS quid pro quo disclosure compliance."
    - name: "avg_net_gift_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net gift amount after fees. Benchmarks true per-gift revenue yield across payment channels."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge pipeline and fulfillment metrics tracking committed future revenue, outstanding balances, and installment performance. Essential for cash flow forecasting and donor retention management."
  source: "`vibe_ngo_v1`.`donor`.`pledge`"
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of the pledge (e.g., active, fulfilled, lapsed, cancelled) for pipeline health monitoring."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge (e.g., standard, recurring, challenge) for segmenting commitment structures."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for pledge installments, informing collection strategy and default risk."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of pledge installments (e.g., monthly, quarterly, annual) for cash flow planning."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flags recurring pledges — the most predictable and high-value revenue stream for the organization."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates whether the pledge qualifies for corporate matching, informing matching gift solicitation strategy."
    - name: "pledge_date_year"
      expr: YEAR(pledge_date)
      comment: "Year the pledge was made for cohort and vintage analysis of pledge fulfillment rates."
    - name: "pledge_date_month"
      expr: DATE_TRUNC('MONTH', pledge_date)
      comment: "Month the pledge was made for seasonal pipeline trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pledge for multi-currency portfolio management."
  measures:
    - name: "total_pledge_count"
      expr: COUNT(1)
      comment: "Total number of pledges. Baseline volume metric for commitment pipeline size."
    - name: "total_pledged_amount"
      expr: SUM(CAST(total_pledge_amount AS DOUBLE))
      comment: "Total committed pledge value. Represents the full revenue pipeline from donor commitments."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected against pledges. Measures actual cash received from pledge commitments."
    - name: "total_balance_outstanding"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total outstanding pledge balance. Critical for cash flow forecasting and collection prioritization."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total value written off from uncollectable pledges. Measures pledge default risk and collection effectiveness."
    - name: "avg_pledge_amount"
      expr: AVG(CAST(total_pledge_amount AS DOUBLE))
      comment: "Average pledge commitment size. Benchmarks ask strategy effectiveness and donor capacity alignment."
    - name: "avg_next_installment_amount"
      expr: AVG(CAST(next_installment_amount AS DOUBLE))
      comment: "Average upcoming installment amount. Informs near-term cash flow projections from pledge collections."
    - name: "unique_pledging_donors"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors with active pledges. Measures depth of committed donor relationships."
    - name: "recurring_pledge_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of recurring pledges. Recurring giving is the most stable revenue stream — critical for sustainability planning."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Sum of most recent installment payments received. Provides a near-term revenue pulse for pledge collections."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance and ROI metrics for evaluating fundraising campaign effectiveness, cost efficiency, and goal attainment. Drives strategic decisions on campaign investment and channel allocation."
  source: "`vibe_ngo_v1`.`donor`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of fundraising campaign (e.g., annual fund, capital, emergency) for portfolio-level performance comparison."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current campaign status (e.g., active, closed, planning) for pipeline and lifecycle management."
    - name: "appeal_channel"
      expr: appeal_channel
      comment: "Primary solicitation channel for the campaign (e.g., digital, direct mail, events) for channel ROI analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flags currently active campaigns for operational monitoring vs. historical analysis."
    - name: "is_public"
      expr: is_public
      comment: "Indicates publicly visible campaigns for brand and communications strategy decisions."
    - name: "matching_gift_eligible"
      expr: matching_gift_eligible
      comment: "Flags campaigns eligible for corporate matching to prioritize matching gift solicitation."
    - name: "tax_deductible"
      expr: tax_deductible
      comment: "Indicates tax-deductible campaigns for donor communications and compliance reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment for impact reporting and donor targeting by cause area."
    - name: "campaign_start_year"
      expr: YEAR(start_date)
      comment: "Year the campaign launched for year-over-year performance benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Campaign currency for multi-currency portfolio management and reporting."
  measures:
    - name: "total_campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline for portfolio size and organizational fundraising capacity."
    - name: "total_raised_amount"
      expr: SUM(CAST(total_raised_amount AS DOUBLE))
      comment: "Total revenue raised across campaigns. Primary KPI for fundraising performance against organizational goals."
    - name: "total_goal_amount"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Total fundraising goal across campaigns. Denominator for goal attainment rate calculations."
    - name: "total_cost_of_fundraising"
      expr: SUM(CAST(cost_of_fundraising AS DOUBLE))
      comment: "Total cost invested in fundraising campaigns. Essential for cost-efficiency and ROI analysis."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment across campaigns. Key efficiency metric for campaign portfolio optimization."
    - name: "avg_goal_amount"
      expr: AVG(CAST(goal_amount AS DOUBLE))
      comment: "Average campaign goal size. Benchmarks ambition level and capacity planning for future campaigns."
    - name: "avg_raised_amount"
      expr: AVG(CAST(total_raised_amount AS DOUBLE))
      comment: "Average revenue raised per campaign. Informs campaign sizing and resource allocation decisions."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns. Monitors organizational fundraising capacity and workload."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal-level fundraising performance metrics measuring solicitation effectiveness, response rates, and cost efficiency. Informs direct marketing strategy and channel investment decisions."
  source: "`vibe_ngo_v1`.`donor`.`appeal`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g., acquisition, renewal, upgrade) for segmenting solicitation strategy performance."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal for pipeline monitoring and post-campaign analysis."
    - name: "channel"
      expr: channel
      comment: "Solicitation channel (e.g., email, direct mail, telemarketing) for channel ROI and cost comparison."
    - name: "control_group_flag"
      expr: control_group_flag
      comment: "Flags control group appeals for A/B test analysis and creative performance benchmarking."
    - name: "test_segment_flag"
      expr: test_segment_flag
      comment: "Flags test segment appeals to isolate experimental results from production performance."
    - name: "mailing_date_month"
      expr: DATE_TRUNC('MONTH', mailing_date)
      comment: "Month of appeal mailing for seasonal response rate and revenue trend analysis."
    - name: "mailing_date_year"
      expr: YEAR(mailing_date)
      comment: "Year of appeal mailing for year-over-year direct marketing performance comparison."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of appeal costs for multi-currency cost analysis."
  measures:
    - name: "total_appeal_count"
      expr: COUNT(1)
      comment: "Total number of appeals executed. Baseline for solicitation volume and direct marketing throughput."
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated by appeals. Primary KPI for direct marketing fundraising performance."
    - name: "total_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of executing appeals. Essential for cost-of-fundraising and ROI calculations."
    - name: "avg_roi_ratio"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average return on investment ratio across appeals. Key efficiency metric for direct marketing portfolio decisions."
    - name: "avg_response_rate_percent"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average donor response rate across appeals. Measures solicitation effectiveness and message resonance."
    - name: "avg_gift_amount"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average gift amount generated per appeal. Benchmarks ask strategy and donor segment quality."
    - name: "avg_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount across appeals. Informs ask calibration strategy relative to actual gift outcomes."
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total solicitation ask value across all appeals. Represents the full revenue ambition of the direct marketing portfolio."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_major_gift_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift pipeline metrics tracking prospect cultivation, ask strategy, and revenue forecasting for high-value donor relationships. Critical for major gifts officer performance management and revenue projection."
  source: "`vibe_ngo_v1`.`donor`.`major_gift_opportunity`"
  dimensions:
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current cultivation stage (e.g., identification, cultivation, solicitation, stewardship) for pipeline stage analysis."
    - name: "gift_type"
      expr: gift_type
      comment: "Type of major gift being cultivated (e.g., outright, planned, challenge) for portfolio composition analysis."
    - name: "gift_purpose"
      expr: gift_purpose
      comment: "Intended purpose or program area for the gift, aligning major gift pipeline with programmatic priorities."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type of the anticipated gift for fund allocation planning."
    - name: "is_active"
      expr: is_active
      comment: "Flags active opportunities for current pipeline vs. closed/historical analysis."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Indicates anonymous major gift opportunities for recognition and stewardship planning."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Flags opportunities eligible for corporate matching to maximize gift value."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year target for the major gift, enabling annual revenue goal tracking and forecasting."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the prospect was identified for acquisition source analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the major gift opportunity for multi-currency pipeline management."
  measures:
    - name: "total_opportunity_count"
      expr: COUNT(1)
      comment: "Total number of major gift opportunities in the pipeline. Baseline for pipeline volume and officer workload management."
    - name: "total_expected_gift_amount"
      expr: SUM(CAST(expected_gift_amount AS DOUBLE))
      comment: "Total expected value of major gift pipeline. Primary revenue forecasting metric for major gifts program."
    - name: "total_weighted_value"
      expr: SUM(CAST(weighted_value AS DOUBLE))
      comment: "Probability-weighted pipeline value. Most accurate revenue forecast metric accounting for close likelihood."
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total solicitation ask value across all major gift opportunities. Represents full revenue ambition of the major gifts program."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average close probability across the pipeline. Indicates overall pipeline health and officer confidence in prospects."
    - name: "avg_expected_gift_amount"
      expr: AVG(CAST(expected_gift_amount AS DOUBLE))
      comment: "Average expected gift size. Benchmarks major gift program ambition and prospect capacity alignment."
    - name: "avg_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount per opportunity. Informs ask calibration strategy relative to prospect capacity ratings."
    - name: "active_opportunity_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active major gift opportunities. Monitors pipeline health and officer portfolio size."
    - name: "unique_prospect_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents with major gift opportunities. Measures breadth of major donor cultivation portfolio."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fundraising_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising event performance metrics measuring revenue generation, cost efficiency, and attendance outcomes. Informs event strategy, venue selection, and resource allocation for the events program."
  source: "`vibe_ngo_v1`.`donor`.`fundraising_event`"
  dimensions:
    - name: "fundraising_event_type"
      expr: fundraising_event_type
      comment: "Type of fundraising event (e.g., gala, auction, run/walk) for event portfolio performance comparison."
    - name: "fundraising_event_status"
      expr: fundraising_event_status
      comment: "Current event status (e.g., planned, active, completed, cancelled) for pipeline and post-event analysis."
    - name: "is_virtual_event"
      expr: is_virtual_event
      comment: "Distinguishes virtual from in-person events for format ROI comparison and strategic planning."
    - name: "is_tax_deductible"
      expr: is_tax_deductible
      comment: "Indicates tax-deductible events for donor communications and compliance reporting."
    - name: "venue_country_code"
      expr: venue_country_code
      comment: "Country where the event is held for geographic event portfolio analysis."
    - name: "event_date_year"
      expr: YEAR(fundraising_event_date)
      comment: "Year of the event for year-over-year event revenue and attendance trend analysis."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', fundraising_event_date)
      comment: "Month of the event for seasonal event performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of event financials for multi-currency event portfolio management."
  measures:
    - name: "total_event_count"
      expr: COUNT(1)
      comment: "Total number of fundraising events. Baseline for events program volume and organizational capacity."
    - name: "total_revenue_raised"
      expr: SUM(CAST(total_revenue_raised AS DOUBLE))
      comment: "Total revenue raised across all fundraising events. Primary KPI for events program financial performance."
    - name: "total_event_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total cost of running fundraising events. Essential for cost-of-fundraising and event ROI analysis."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after event costs. Measures actual financial contribution of events to the organization."
    - name: "total_fundraising_goal"
      expr: SUM(CAST(fundraising_goal_amount AS DOUBLE))
      comment: "Total fundraising goal across events. Denominator for event goal attainment rate calculations."
    - name: "avg_net_revenue_per_event"
      expr: AVG(CAST(net_revenue AS DOUBLE))
      comment: "Average net revenue per event. Benchmarks event format efficiency and informs future event investment decisions."
    - name: "avg_tax_deductible_percentage"
      expr: AVG(CAST(tax_deductible_percentage AS DOUBLE))
      comment: "Average tax-deductible portion of event revenue. Informs donor tax benefit communications and compliance."
    - name: "avg_fundraising_goal"
      expr: AVG(CAST(fundraising_goal_amount AS DOUBLE))
      comment: "Average fundraising goal per event. Benchmarks event ambition and capacity planning."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect research and pipeline metrics for evaluating donor identification, qualification, and cultivation effectiveness. Drives major gifts and planned giving pipeline development strategy."
  source: "`vibe_ngo_v1`.`donor`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current prospect status (e.g., identified, qualified, cultivating, disqualified) for pipeline stage analysis."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g., individual, foundation, corporate) for portfolio segmentation and strategy."
    - name: "research_stage"
      expr: research_stage
      comment: "Stage of prospect research completion for research team workload and pipeline readiness monitoring."
    - name: "stage"
      expr: stage
      comment: "Cultivation stage of the prospect for pipeline progression and conversion rate analysis."
    - name: "last_contact_type"
      expr: last_contact_type
      comment: "Type of most recent contact with the prospect for engagement quality analysis."
    - name: "geographic_interest"
      expr: geographic_interest
      comment: "Geographic focus area of the prospect for alignment with organizational program footprint."
    - name: "program_interest_area"
      expr: program_interest_area
      comment: "Program area of interest for aligning prospect cultivation with organizational priorities."
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year the prospect was identified for cohort analysis of prospect pipeline development."
  measures:
    - name: "total_prospect_count"
      expr: COUNT(1)
      comment: "Total number of prospects in the pipeline. Baseline for prospect pool size and research team capacity planning."
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across all prospects. Represents the maximum addressable major gift revenue opportunity."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total planned solicitation amount across prospects. Measures the revenue ambition of the prospect cultivation pipeline."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average conversion probability across prospects. Indicates overall pipeline quality and cultivation effectiveness."
    - name: "avg_estimated_capacity"
      expr: AVG(CAST(estimated_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per prospect. Benchmarks prospect pool quality and research targeting effectiveness."
    - name: "avg_wealth_screening_score"
      expr: AVG(CAST(wealth_screening_score AS DOUBLE))
      comment: "Average wealth screening score across prospects. Measures overall financial capacity of the prospect pool."
    - name: "avg_gift_range_max"
      expr: AVG(CAST(estimated_gift_range_max AS DOUBLE))
      comment: "Average upper bound of estimated gift range. Informs ask strategy calibration for the prospect portfolio."
    - name: "unique_prospect_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituent prospects. Measures breadth of the prospect identification program."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_stewardship_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship activity metrics measuring engagement quality, follow-up compliance, and relationship management effectiveness. Drives retention strategy and major donor relationship health monitoring. Note: FK columns for safeguarding_incident and supply_distribution_plan are excluded per VREQ-021/022 as those relationships are being removed from this table."
  source: "`vibe_ngo_v1`.`donor`.`stewardship_activity`"
  dimensions:
    - name: "stewardship_activity_type"
      expr: stewardship_activity_type
      comment: "Type of stewardship activity (e.g., site visit, impact report, personal call) for engagement mix analysis."
    - name: "stewardship_activity_status"
      expr: stewardship_activity_status
      comment: "Current status of the activity (e.g., planned, completed, overdue) for follow-up compliance monitoring."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for stewardship (e.g., email, phone, in-person) for channel effectiveness analysis."
    - name: "donor_sentiment"
      expr: donor_sentiment
      comment: "Recorded donor sentiment after the activity for relationship health monitoring and risk identification."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the stewardship activity for workload management and high-value donor prioritization."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Flags activities requiring follow-up to monitor stewardship compliance and relationship continuity."
    - name: "solicitation_made_flag"
      expr: solicitation_made_flag
      comment: "Indicates whether a solicitation was made during the activity for conversion rate analysis."
    - name: "impact_story_shared_flag"
      expr: impact_story_shared_flag
      comment: "Flags activities where impact stories were shared — key stewardship best practice for donor retention."
    - name: "stewardship_plan_stage"
      expr: stewardship_plan_stage
      comment: "Stage within the stewardship plan for pipeline progression and plan adherence monitoring."
    - name: "activity_date_month"
      expr: DATE_TRUNC('MONTH', stewardship_activity_date)
      comment: "Month of stewardship activity for trend analysis of engagement cadence."
    - name: "activity_date_year"
      expr: YEAR(stewardship_activity_date)
      comment: "Year of stewardship activity for year-over-year engagement volume comparison."
  measures:
    - name: "total_activity_count"
      expr: COUNT(1)
      comment: "Total number of stewardship activities. Baseline for engagement volume and officer productivity monitoring."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities. Informs stewardship program budget management and cost-per-touch analysis."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total solicitation amount made during stewardship activities. Measures revenue generation from stewardship touchpoints."
    - name: "avg_cost_per_activity"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship activity. Benchmarks stewardship efficiency and informs budget allocation."
    - name: "unique_donors_stewarded"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors receiving stewardship. Measures breadth of active donor relationship management."
    - name: "completed_activity_count"
      expr: COUNT(CASE WHEN stewardship_activity_status = 'completed' THEN 1 END)
      comment: "Number of completed stewardship activities. Measures stewardship plan execution rate and officer follow-through."
    - name: "solicitation_activity_count"
      expr: COUNT(CASE WHEN solicitation_made_flag = TRUE THEN 1 END)
      comment: "Number of activities where a solicitation was made. Tracks ask frequency within stewardship touchpoints."
    - name: "impact_story_shared_count"
      expr: COUNT(CASE WHEN impact_story_shared_flag = TRUE THEN 1 END)
      comment: "Number of activities where impact stories were shared. Measures stewardship quality and best practice adherence."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_portfolio_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gifts officer portfolio management metrics tracking donor assignment, capacity, and relationship health. Enables portfolio load balancing, officer performance evaluation, and cultivation pipeline management."
  source: "`vibe_ngo_v1`.`donor`.`portfolio_assignment`"
  dimensions:
    - name: "portfolio_status"
      expr: portfolio_status
      comment: "Current status of the portfolio assignment (e.g., active, transferred, closed) for portfolio health monitoring."
    - name: "portfolio_tier"
      expr: portfolio_tier
      comment: "Tier classification of the portfolio assignment (e.g., major, mid-level, planned giving) for capacity analysis."
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current cultivation stage of the assigned donor for pipeline stage distribution analysis."
    - name: "geographic_territory"
      expr: geographic_territory
      comment: "Geographic territory of the portfolio assignment for regional portfolio management and officer alignment."
    - name: "affinity_focus_area"
      expr: affinity_focus_area
      comment: "Donor affinity area for aligning portfolio assignments with programmatic priorities."
    - name: "proposal_submitted_flag"
      expr: proposal_submitted_flag
      comment: "Flags assignments where a proposal has been submitted for pipeline conversion rate analysis."
    - name: "assignment_year"
      expr: YEAR(portfolio_assignment_date)
      comment: "Year of portfolio assignment for cohort analysis of assignment outcomes."
    - name: "capacity_currency_code"
      expr: capacity_currency_code
      comment: "Currency of capacity estimates for multi-currency portfolio management."
  measures:
    - name: "total_assignment_count"
      expr: COUNT(1)
      comment: "Total number of portfolio assignments. Baseline for portfolio size and officer workload management."
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity_amount AS DOUBLE))
      comment: "Total estimated giving capacity across all portfolio assignments. Represents the maximum addressable revenue from managed relationships."
    - name: "total_expected_ask_amount"
      expr: SUM(CAST(expected_ask_amount AS DOUBLE))
      comment: "Total planned ask amount across portfolio assignments. Measures revenue ambition of the managed portfolio."
    - name: "total_lifetime_giving"
      expr: SUM(CAST(total_lifetime_giving_amount AS DOUBLE))
      comment: "Total lifetime giving across all portfolio-assigned donors. Measures the cumulative value of managed donor relationships."
    - name: "avg_portfolio_load_weight"
      expr: AVG(CAST(portfolio_load_weight AS DOUBLE))
      comment: "Average portfolio load weight per assignment. Informs officer workload balancing and portfolio size optimization."
    - name: "avg_estimated_capacity"
      expr: AVG(CAST(estimated_capacity_amount AS DOUBLE))
      comment: "Average estimated giving capacity per assigned donor. Benchmarks portfolio quality and prospect targeting effectiveness."
    - name: "unique_donors_in_portfolio"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors in managed portfolios. Measures breadth of active major donor relationship management."
    - name: "proposal_submitted_count"
      expr: COUNT(CASE WHEN proposal_submitted_flag = TRUE THEN 1 END)
      comment: "Number of portfolio assignments with submitted proposals. Tracks solicitation activity and pipeline conversion progress."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_wealth_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wealth screening and prospect capacity metrics for evaluating the quality and coverage of donor research. Informs prospect prioritization, ask calibration, and major gifts pipeline development."
  source: "`vibe_ngo_v1`.`donor`.`wealth_screening`"
  dimensions:
    - name: "wealth_screening_type"
      expr: wealth_screening_type
      comment: "Type of wealth screening conducted (e.g., initial, refresh, deep dive) for research methodology analysis."
    - name: "wealth_screening_status"
      expr: wealth_screening_status
      comment: "Current status of the screening (e.g., pending, completed, reviewed) for research pipeline management."
    - name: "capacity_rating_tier"
      expr: capacity_rating_tier
      comment: "Capacity tier assigned by screening (e.g., $1M+, $100K-$1M) for prospect pool segmentation and prioritization."
    - name: "provider"
      expr: provider
      comment: "Wealth screening data provider for vendor performance comparison and data quality assessment."
    - name: "data_privacy_consent_flag"
      expr: data_privacy_consent_flag
      comment: "Flags screenings with donor privacy consent for compliance monitoring and GDPR adherence."
    - name: "screening_year"
      expr: YEAR(wealth_screening_date)
      comment: "Year of screening for data freshness analysis and refresh cycle planning."
    - name: "net_worth_range"
      expr: net_worth_range
      comment: "Net worth range band for prospect pool capacity distribution analysis."
  measures:
    - name: "total_screening_count"
      expr: COUNT(1)
      comment: "Total number of wealth screenings conducted. Baseline for research program coverage and throughput."
    - name: "total_estimated_net_worth"
      expr: SUM(CAST(estimated_net_worth AS DOUBLE))
      comment: "Total estimated net worth across screened prospects. Represents the maximum addressable wealth in the prospect pool."
    - name: "total_philanthropic_capacity"
      expr: SUM(CAST(philanthropic_capacity_estimate AS DOUBLE))
      comment: "Total estimated philanthropic giving capacity. Primary metric for quantifying the major gift revenue opportunity."
    - name: "total_screening_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of wealth screening services. Informs research budget management and vendor ROI analysis."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average data confidence score from screening provider. Measures research data quality and reliability."
    - name: "avg_philanthropic_capacity"
      expr: AVG(CAST(philanthropic_capacity_estimate AS DOUBLE))
      comment: "Average philanthropic capacity per screened prospect. Benchmarks prospect pool quality and ask calibration."
    - name: "unique_screened_constituents"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents screened. Measures research program coverage of the donor and prospect base."
    - name: "avg_real_estate_value"
      expr: AVG(CAST(real_estate_value AS DOUBLE))
      comment: "Average real estate holdings value across screened prospects. Key wealth indicator for capacity rating calibration."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_planned_giving`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned giving pipeline metrics tracking legacy commitments, estimated values, and realization progress. Critical for long-term revenue forecasting and legacy society management."
  source: "`vibe_ngo_v1`.`donor`.`planned_giving`"
  dimensions:
    - name: "planned_gift_type"
      expr: planned_gift_type
      comment: "Type of planned gift vehicle (e.g., bequest, charitable remainder trust, annuity) for portfolio composition analysis."
    - name: "gift_status"
      expr: gift_status
      comment: "Current status of the planned gift (e.g., expectancy, realized, revoked) for pipeline and realization tracking."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type of the planned gift for fund allocation and endowment planning."
    - name: "legal_documentation_status"
      expr: legal_documentation_status
      comment: "Status of legal documentation for the planned gift for compliance and risk management."
    - name: "legacy_society_member"
      expr: legacy_society_member
      comment: "Flags legacy society members for stewardship program management and recognition."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used to value the planned gift for financial reporting consistency and accuracy."
    - name: "gift_vehicle_subtype"
      expr: gift_vehicle_subtype
      comment: "Specific subtype of gift vehicle for detailed portfolio composition and tax planning analysis."
    - name: "commitment_year"
      expr: YEAR(commitment_date)
      comment: "Year of planned gift commitment for cohort analysis of legacy pipeline development."
    - name: "estimated_value_currency"
      expr: estimated_value_currency
      comment: "Currency of estimated planned gift value for multi-currency legacy portfolio management."
  measures:
    - name: "total_planned_gift_count"
      expr: COUNT(1)
      comment: "Total number of planned gift commitments. Baseline for legacy pipeline size and program growth tracking."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of planned gift pipeline. Primary long-term revenue forecasting metric for the organization."
    - name: "total_present_value"
      expr: SUM(CAST(present_value AS DOUBLE))
      comment: "Total present value of planned gifts. Provides a discounted revenue forecast for financial planning purposes."
    - name: "total_realized_value"
      expr: SUM(CAST(realized_value AS DOUBLE))
      comment: "Total value of realized planned gifts. Measures actual legacy revenue received and program maturity."
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average realization probability across planned gifts. Indicates overall pipeline quality and expected realization rate."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated planned gift value. Benchmarks legacy gift size and informs stewardship investment decisions."
    - name: "legacy_society_member_count"
      expr: COUNT(CASE WHEN legacy_society_member = TRUE THEN 1 END)
      comment: "Number of legacy society members. Measures legacy program engagement and stewardship community size."
    - name: "unique_planned_donors"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors with planned gift commitments. Measures breadth of legacy donor relationships."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_soft_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Soft credit attribution metrics for tracking solicitor and relationship manager contributions to fundraising revenue. Enables officer performance evaluation and relationship credit allocation management."
  source: "`vibe_ngo_v1`.`donor`.`soft_credit`"
  dimensions:
    - name: "soft_credit_type"
      expr: soft_credit_type
      comment: "Type of soft credit (e.g., solicitor, relationship manager, board member) for attribution analysis."
    - name: "soft_credit_status"
      expr: soft_credit_status
      comment: "Current status of the soft credit record for data quality and reconciliation monitoring."
    - name: "solicitor_relationship"
      expr: solicitor_relationship
      comment: "Relationship type between the credited individual and the donor for attribution model analysis."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Flags anonymous soft credits for recognition and reporting compliance."
    - name: "recognition_eligible_flag"
      expr: recognition_eligible_flag
      comment: "Indicates whether the soft credit qualifies for recognition reporting and officer performance metrics."
    - name: "lifetime_value_eligible_flag"
      expr: lifetime_value_eligible_flag
      comment: "Flags soft credits that count toward lifetime value calculations for relationship scoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the soft credit for annual officer performance and attribution reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the soft credit amount for multi-currency attribution management."
    - name: "soft_credit_date_month"
      expr: DATE_TRUNC('MONTH', soft_credit_date)
      comment: "Month of soft credit for trend analysis of solicitor activity and attribution patterns."
  measures:
    - name: "total_soft_credit_count"
      expr: COUNT(1)
      comment: "Total number of soft credit records. Baseline for attribution volume and solicitor activity monitoring."
    - name: "total_soft_credit_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total soft credit amount attributed. Primary metric for officer performance evaluation and relationship credit reporting."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage per soft credit. Measures how credit is distributed across solicitors for a single gift."
    - name: "avg_soft_credit_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average soft credit amount per record. Benchmarks typical attribution value per solicitor touchpoint."
    - name: "unique_credited_constituents"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique individuals receiving soft credit. Measures breadth of solicitor and relationship manager contributions."
    - name: "recognition_eligible_amount"
      expr: SUM(CASE WHEN recognition_eligible_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total soft credit amount eligible for recognition reporting. Informs officer recognition and incentive program management."
$$;


CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor constituent base metrics for understanding the composition, capacity, and engagement profile of the donor population. Drives segmentation strategy, prospect identification, and relationship management decisions."
  source: "`vibe_ngo_v1`.`donor`.`constituent`"
  dimensions:
    - name: "constituent_type"
      expr: constituent_type
      comment: "Type of constituent (e.g., individual, foundation, corporation, government) for portfolio segmentation."
    - name: "record_status"
      expr: record_status
      comment: "Current record status (e.g., active, inactive, deceased) for data quality and active donor base monitoring."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier classification (e.g., major, mid-level, annual) for tiered stewardship strategy."
    - name: "funder_classification"
      expr: funder_classification
      comment: "Classification of the funder type for portfolio composition and strategy alignment."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "GDPR consent status for compliance monitoring and communication eligibility management."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Email opt-in status for digital communication reach and channel strategy planning."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Flags deceased constituents for data hygiene, planned giving realization, and stewardship adjustments."
    - name: "oda_eligibility_flag"
      expr: oda_eligibility_flag
      comment: "Official Development Assistance eligibility flag for DAC-compliant donor reporting."
    - name: "dac_member_flag"
      expr: dac_member_flag
      comment: "Flags DAC member donors for OECD/DAC compliance reporting and institutional relationship management."
    - name: "preferred_grant_modality"
      expr: preferred_grant_modality
      comment: "Preferred grant modality for aligning funding proposals with donor preferences."
    - name: "first_gift_year"
      expr: YEAR(first_gift_date)
      comment: "Year of first gift for donor cohort analysis and retention rate calculations."
  measures:
    - name: "total_constituent_count"
      expr: COUNT(1)
      comment: "Total number of constituents in the database. Baseline for donor base size and growth tracking."
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Total lifetime giving across all constituents. Measures the cumulative financial value of the entire donor base."
    - name: "total_estimated_giving_capacity"
      expr: SUM(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across all constituents. Quantifies the maximum addressable fundraising opportunity."
    - name: "avg_lifetime_giving"
      expr: AVG(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Average lifetime giving per constituent. Benchmarks donor value and informs segmentation thresholds."
    - name: "avg_largest_gift_amount"
      expr: AVG(CAST(largest_gift_amount AS DOUBLE))
      comment: "Average largest single gift per constituent. Indicates donor capacity utilization and ask strategy effectiveness."
    - name: "avg_estimated_giving_capacity"
      expr: AVG(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per constituent. Benchmarks prospect pool quality and capacity rating accuracy."
    - name: "active_constituent_count"
      expr: COUNT(CASE WHEN record_status = 'active' THEN 1 END)
      comment: "Number of active constituents. Measures the reachable donor base for fundraising and stewardship activities."
    - name: "gdpr_consented_count"
      expr: COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN 1 END)
      comment: "Number of constituents with GDPR consent. Measures compliant communication reach for European donor engagement."
$$;
