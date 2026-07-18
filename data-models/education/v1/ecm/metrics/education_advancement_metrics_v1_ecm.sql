-- Metric views for domain: advancement | Business: Education | Version: 1 | Generated on: 2026-05-06 12:19:59

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_advanced_degree`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced Degree business metrics"
  source: "`education_ecm`.`advancement`.`advanced_degree`"
  dimensions:
    - name: "Awarding Institution City"
      expr: awarding_institution_city
    - name: "Awarding Institution Country"
      expr: awarding_institution_country
    - name: "Awarding Institution Ipeds Code"
      expr: awarding_institution_ipeds_code
    - name: "Awarding Institution Name"
      expr: awarding_institution_name
    - name: "Awarding Institution State"
      expr: awarding_institution_state
    - name: "Awarding Institution Type"
      expr: awarding_institution_type
    - name: "Career Relevance Flag"
      expr: career_relevance_flag
    - name: "Concentration Specialization"
      expr: concentration_specialization
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Degree Level"
      expr: degree_level
    - name: "Degree Record Number"
      expr: degree_record_number
    - name: "Degree Status"
      expr: degree_status
    - name: "Degree Title"
      expr: degree_title
    - name: "Degree Type"
      expr: degree_type
    - name: "Enrollment Start Year"
      expr: enrollment_start_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Advanced Degree"
      expr: COUNT(DISTINCT advanced_degree_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_advancement_application_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advancement Application Access business metrics"
  source: "`education_ecm`.`advancement`.`advancement_application_access`"
  dimensions:
    - name: "Access Granted Date"
      expr: access_granted_date
    - name: "Access Level"
      expr: access_level
    - name: "Access Revoked Date"
      expr: access_revoked_date
    - name: "Access Status"
      expr: access_status
    - name: "Cost Allocation Code"
      expr: cost_allocation_code
    - name: "Last Login Timestamp"
      expr: last_login_timestamp
    - name: "License Type"
      expr: license_type
    - name: "Usage Frequency"
      expr: usage_frequency
    - name: "Access Granted Date Month"
      expr: DATE_TRUNC('MONTH', access_granted_date)
    - name: "Access Revoked Date Month"
      expr: DATE_TRUNC('MONTH', access_revoked_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Advancement Application Access"
      expr: COUNT(DISTINCT advancement_application_access_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_advancement_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advancement Assignment business metrics"
  source: "`education_ecm`.`advancement`.`advancement_assignment`"
  dimensions:
    - name: "Application Date"
      expr: application_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Created Date"
      expr: created_date
    - name: "End Date"
      expr: end_date
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Notes"
      expr: notes
    - name: "Performance Rating"
      expr: performance_rating
    - name: "Start Date"
      expr: start_date
    - name: "Training Completed Flag"
      expr: training_completed_flag
    - name: "Application Date Month"
      expr: DATE_TRUNC('MONTH', application_date)
    - name: "Approval Date Month"
      expr: DATE_TRUNC('MONTH', approval_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Advancement Assignment"
      expr: COUNT(DISTINCT advancement_assignment_id)
    - name: "Total Engagement Score"
      expr: SUM(engagement_score)
    - name: "Average Engagement Score"
      expr: AVG(engagement_score)
    - name: "Total Hours Served"
      expr: SUM(hours_served)
    - name: "Average Hours Served"
      expr: AVG(hours_served)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_advancement_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advancement Fund business metrics"
  source: "`education_ecm`.`advancement`.`advancement_fund`"
  dimensions:
    - name: "Closure Date"
      expr: closure_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Donor Advised Flag"
      expr: donor_advised_flag
    - name: "Donor Recognition Level"
      expr: donor_recognition_level
    - name: "Establishment Date"
      expr: establishment_date
    - name: "Facilities Support Flag"
      expr: facilities_support_flag
    - name: "Faculty Support Flag"
      expr: faculty_support_flag
    - name: "First Distribution Date"
      expr: first_distribution_date
    - name: "Fund Code"
      expr: fund_code
    - name: "Fund Name"
      expr: fund_name
    - name: "Fund Status"
      expr: fund_status
    - name: "Fund Type"
      expr: fund_type
    - name: "Gift Agreement Document Url"
      expr: gift_agreement_document_url
    - name: "Gift Restriction Terms"
      expr: gift_restriction_terms
    - name: "Investment Pool Assignment"
      expr: investment_pool_assignment
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Advancement Fund"
      expr: COUNT(DISTINCT advancement_fund_id)
    - name: "Total Current Market Value"
      expr: SUM(current_market_value)
    - name: "Average Current Market Value"
      expr: AVG(current_market_value)
    - name: "Total Minimum Endowment Threshold"
      expr: SUM(minimum_endowment_threshold)
    - name: "Average Minimum Endowment Threshold"
      expr: AVG(minimum_endowment_threshold)
    - name: "Total Original Gift Amount"
      expr: SUM(original_gift_amount)
    - name: "Average Original Gift Amount"
      expr: AVG(original_gift_amount)
    - name: "Total Spending Policy Rate"
      expr: SUM(spending_policy_rate)
    - name: "Average Spending Policy Rate"
      expr: AVG(spending_policy_rate)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_advancement_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advancement Registration business metrics"
  source: "`education_ecm`.`advancement`.`advancement_registration`"
  dimensions:
    - name: "Advancement Registration Date"
      expr: advancement_registration_date
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Check In Timestamp"
      expr: check_in_timestamp
    - name: "Confirmation Email Sent Timestamp"
      expr: confirmation_email_sent_timestamp
    - name: "Dietary Requirements"
      expr: dietary_requirements
    - name: "Guest Count"
      expr: guest_count
    - name: "Payment Method"
      expr: payment_method
    - name: "Registration Status"
      expr: registration_status
    - name: "Ticket Type"
      expr: ticket_type
    - name: "Advancement Registration Date Month"
      expr: DATE_TRUNC('MONTH', advancement_registration_date)
    - name: "Cancellation Date Month"
      expr: DATE_TRUNC('MONTH', cancellation_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Advancement Registration"
      expr: COUNT(DISTINCT advancement_registration_id)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_affinity_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Affinity Group business metrics"
  source: "`education_ecm`.`advancement`.`affinity_group`"
  dimensions:
    - name: "Affinity Group Status"
      expr: affinity_group_status
    - name: "Annual Event Count"
      expr: annual_event_count
    - name: "Associated Athletic Team"
      expr: associated_athletic_team
    - name: "Charter Expiration Date"
      expr: charter_expiration_date
    - name: "City"
      expr: city
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dues Required Flag"
      expr: dues_required_flag
    - name: "Engagement Tier"
      expr: engagement_tier
    - name: "Founding Date"
      expr: founding_date
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Group Code"
      expr: group_code
    - name: "Group Name"
      expr: group_name
    - name: "Group Type"
      expr: group_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Affinity Group"
      expr: COUNT(DISTINCT affinity_group_id)
    - name: "Total Annual Dues Amount"
      expr: SUM(annual_dues_amount)
    - name: "Average Annual Dues Amount"
      expr: AVG(annual_dues_amount)
    - name: "Total Total Funds Raised Ytd"
      expr: SUM(total_funds_raised_ytd)
    - name: "Average Total Funds Raised Ytd"
      expr: AVG(total_funds_raised_ytd)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_alumni_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alumni Award business metrics"
  source: "`education_ecm`.`advancement`.`alumni_award`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Award Category"
      expr: award_category
    - name: "Award Name"
      expr: award_name
    - name: "Award Number"
      expr: award_number
    - name: "Award Status"
      expr: award_status
    - name: "Award Subcategory"
      expr: award_subcategory
    - name: "Award Year"
      expr: award_year
    - name: "Citation Text"
      expr: citation_text
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Nomination Date"
      expr: nomination_date
    - name: "Nomination Source"
      expr: nomination_source
    - name: "Nomination Statement"
      expr: nomination_statement
    - name: "Nominator Name"
      expr: nominator_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Alumni Award"
      expr: COUNT(DISTINCT alumni_award_id)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_alumni_communication_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alumni Communication Preference business metrics"
  source: "`education_ecm`.`advancement`.`alumni_communication_preference`"
  dimensions:
    - name: "Bounce Status"
      expr: bounce_status
    - name: "Career News Opt In"
      expr: career_news_opt_in
    - name: "Communication Frequency"
      expr: communication_frequency
    - name: "Consent Ip Address"
      expr: consent_ip_address
    - name: "Consent Source"
      expr: consent_source
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Consent User Agent"
      expr: consent_user_agent
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Do Not Contact"
      expr: do_not_contact
    - name: "Do Not Solicit"
      expr: do_not_solicit
    - name: "Double Opt In Confirmed"
      expr: double_opt_in_confirmed
    - name: "Double Opt In Timestamp"
      expr: double_opt_in_timestamp
    - name: "Email Opt In"
      expr: email_opt_in
    - name: "Event Invitations Opt In"
      expr: event_invitations_opt_in
    - name: "Fundraising Appeals Opt In"
      expr: fundraising_appeals_opt_in
    - name: "Gdpr Consent Version"
      expr: gdpr_consent_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Alumni Communication Preference"
      expr: COUNT(DISTINCT alumni_communication_preference_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_alumni_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alumni Contact business metrics"
  source: "`education_ecm`.`advancement`.`alumni_contact`"
  dimensions:
    - name: "Address Verification Status"
      expr: address_verification_status
    - name: "Contact Frequency Preference"
      expr: contact_frequency_preference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Do Not Call Flag"
      expr: do_not_call_flag
    - name: "Do Not Contact Flag"
      expr: do_not_contact_flag
    - name: "Do Not Email Flag"
      expr: do_not_email_flag
    - name: "Do Not Mail Flag"
      expr: do_not_mail_flag
    - name: "Do Not Sms Flag"
      expr: do_not_sms_flag
    - name: "Email Consent Source"
      expr: email_consent_source
    - name: "Email Consent Timestamp"
      expr: email_consent_timestamp
    - name: "Home Address Line1"
      expr: home_address_line1
    - name: "Home Address Line2"
      expr: home_address_line2
    - name: "Home City"
      expr: home_city
    - name: "Home Country Code"
      expr: home_country_code
    - name: "Home Phone"
      expr: home_phone
    - name: "Home Postal Code"
      expr: home_postal_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Alumni Contact"
      expr: COUNT(DISTINCT alumni_contact_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_alumni_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alumni Event business metrics"
  source: "`education_ecm`.`advancement`.`alumni_event`"
  dimensions:
    - name: "Actual Attendance"
      expr: actual_attendance
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Mode"
      expr: delivery_mode
    - name: "Early Registration Deadline"
      expr: early_registration_deadline
    - name: "Event Code"
      expr: event_code
    - name: "Event Description"
      expr: event_description
    - name: "Event End Date"
      expr: event_end_date
    - name: "Event End Time"
      expr: event_end_time
    - name: "Event Name"
      expr: event_name
    - name: "Event Start Date"
      expr: event_start_date
    - name: "Event Start Time"
      expr: event_start_time
    - name: "Event Status"
      expr: event_status
    - name: "Event Type"
      expr: event_type
    - name: "Is Fundraising Event"
      expr: is_fundraising_event
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Alumni Event"
      expr: COUNT(DISTINCT alumni_event_id)
    - name: "Total Early Registration Fee"
      expr: SUM(early_registration_fee)
    - name: "Average Early Registration Fee"
      expr: AVG(early_registration_fee)
    - name: "Total Fundraising Goal Amount"
      expr: SUM(fundraising_goal_amount)
    - name: "Average Fundraising Goal Amount"
      expr: AVG(fundraising_goal_amount)
    - name: "Total Guest Registration Fee"
      expr: SUM(guest_registration_fee)
    - name: "Average Guest Registration Fee"
      expr: AVG(guest_registration_fee)
    - name: "Total Standard Registration Fee"
      expr: SUM(standard_registration_fee)
    - name: "Average Standard Registration Fee"
      expr: AVG(standard_registration_fee)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_alumni_event_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alumni Event Registration business metrics"
  source: "`education_ecm`.`advancement`.`alumni_event_registration`"
  dimensions:
    - name: "Accessibility Requirements"
      expr: accessibility_requirements
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Check In Method"
      expr: check_in_method
    - name: "Check In Timestamp"
      expr: check_in_timestamp
    - name: "Confirmation Email Sent Flag"
      expr: confirmation_email_sent_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dietary Requirements"
      expr: dietary_requirements
    - name: "Guest Count"
      expr: guest_count
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Name Badge Printed Flag"
      expr: name_badge_printed_flag
    - name: "Notes"
      expr: notes
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Status"
      expr: payment_status
    - name: "Referral Source"
      expr: referral_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Alumni Event Registration"
      expr: COUNT(DISTINCT alumni_event_registration_id)
    - name: "Total Engagement Score"
      expr: SUM(engagement_score)
    - name: "Average Engagement Score"
      expr: AVG(engagement_score)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_alumni_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alumni Survey business metrics"
  source: "`education_ecm`.`advancement`.`alumni_survey`"
  dimensions:
    - name: "Accreditation Association"
      expr: accreditation_association
    - name: "Continuing Education Institution"
      expr: continuing_education_institution
    - name: "Continuing Education Program"
      expr: continuing_education_program
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Degree Level"
      expr: degree_level
    - name: "Delivery Channel"
      expr: delivery_channel
    - name: "Employer Name"
      expr: employer_name
    - name: "Employment Status"
      expr: employment_status
    - name: "Graduation Term"
      expr: graduation_term
    - name: "Graduation Year"
      expr: graduation_year
    - name: "Industry Sector"
      expr: industry_sector
    - name: "Instrument Version"
      expr: instrument_version
    - name: "Invitation Sent Date"
      expr: invitation_sent_date
    - name: "Job Location City"
      expr: job_location_city
    - name: "Job Location Country Code"
      expr: job_location_country_code
    - name: "Job Location State Province"
      expr: job_location_state_province
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Alumni Survey"
      expr: COUNT(DISTINCT alumni_survey_id)
    - name: "Total Completion Percentage"
      expr: SUM(completion_percentage)
    - name: "Average Completion Percentage"
      expr: AVG(completion_percentage)
    - name: "Total Response Rate Target"
      expr: SUM(response_rate_target)
    - name: "Average Response Rate Target"
      expr: AVG(response_rate_target)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_alumnus`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alumnus business metrics"
  source: "`education_ecm`.`advancement`.`alumnus`"
  dimensions:
    - name: "Alternate Email"
      expr: alternate_email
    - name: "Alumni Status"
      expr: alumni_status
    - name: "Current Employer"
      expr: current_employer
    - name: "Current Job Title"
      expr: current_job_title
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Deceased Date"
      expr: deceased_date
    - name: "Deceased Indicator"
      expr: deceased_indicator
    - name: "Department Name"
      expr: department_name
    - name: "Do Not Contact Flag"
      expr: do_not_contact_flag
    - name: "Do Not Solicit Flag"
      expr: do_not_solicit_flag
    - name: "Ethnicity"
      expr: ethnicity
    - name: "Ferpa Consent Flag"
      expr: ferpa_consent_flag
    - name: "Gender"
      expr: gender
    - name: "Graduation Date"
      expr: graduation_date
    - name: "Graduation Term Code"
      expr: graduation_term_code
    - name: "Graduation Year"
      expr: graduation_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Alumnus"
      expr: COUNT(DISTINCT alumnus_id)
    - name: "Total Cumulative Gpa"
      expr: SUM(cumulative_gpa)
    - name: "Average Cumulative Gpa"
      expr: AVG(cumulative_gpa)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal business metrics"
  source: "`education_ecm`.`advancement`.`appeal`"
  dimensions:
    - name: "Appeal Code"
      expr: appeal_code
    - name: "Appeal Description"
      expr: appeal_description
    - name: "Appeal Name"
      expr: appeal_name
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Appeal Type"
      expr: appeal_type
    - name: "Ask Currency Code"
      expr: ask_currency_code
    - name: "Case Reportable Flag"
      expr: case_reportable_flag
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Owning Office"
      expr: owning_office
    - name: "Package Code"
      expr: package_code
    - name: "Response Count"
      expr: response_count
    - name: "Reunion Class Year"
      expr: reunion_class_year
    - name: "Revenue Currency Code"
      expr: revenue_currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Appeal"
      expr: COUNT(DISTINCT appeal_id)
    - name: "Total Ask Amount High"
      expr: SUM(ask_amount_high)
    - name: "Average Ask Amount High"
      expr: AVG(ask_amount_high)
    - name: "Total Ask Amount Low"
      expr: SUM(ask_amount_low)
    - name: "Average Ask Amount Low"
      expr: AVG(ask_amount_low)
    - name: "Total Average Gift Amount"
      expr: SUM(average_gift_amount)
    - name: "Average Average Gift Amount"
      expr: AVG(average_gift_amount)
    - name: "Total Response Rate Percentage"
      expr: SUM(response_rate_percentage)
    - name: "Average Response Rate Percentage"
      expr: AVG(response_rate_percentage)
    - name: "Total Roi Percentage"
      expr: SUM(roi_percentage)
    - name: "Average Roi Percentage"
      expr: AVG(roi_percentage)
    - name: "Total Solicitation Cost Amount"
      expr: SUM(solicitation_cost_amount)
    - name: "Average Solicitation Cost Amount"
      expr: AVG(solicitation_cost_amount)
    - name: "Total Total Revenue Amount"
      expr: SUM(total_revenue_amount)
    - name: "Average Total Revenue Amount"
      expr: AVG(total_revenue_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_award_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award Catalog business metrics"
  source: "`education_ecm`.`advancement`.`award_catalog`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Award Category"
      expr: award_category
    - name: "Award Code"
      expr: award_code
    - name: "Award Name"
      expr: award_name
    - name: "Award Type"
      expr: award_type
    - name: "Commencement Presentation Flag"
      expr: commencement_presentation_flag
    - name: "Conferral Frequency"
      expr: conferral_frequency
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Description"
      expr: award_catalog_description
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Award Catalog"
      expr: COUNT(DISTINCT award_catalog_id)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_award_recipient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award Recipient business metrics"
  source: "`education_ecm`.`advancement`.`award_recipient`"
  dimensions:
    - name: "Award Year"
      expr: award_year
    - name: "Citation Text"
      expr: citation_text
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Engagement Score Impact"
      expr: engagement_score_impact
    - name: "Featured In Publication Flag"
      expr: featured_in_publication_flag
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Nomination Date"
      expr: nomination_date
    - name: "Nomination Source"
      expr: nomination_source
    - name: "Nomination Statement"
      expr: nomination_statement
    - name: "Nominator Name"
      expr: nominator_name
    - name: "Nominator Relationship"
      expr: nominator_relationship
    - name: "Notes"
      expr: notes
    - name: "Presentation Date"
      expr: presentation_date
    - name: "Presentation Location"
      expr: presentation_location
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Award Recipient"
      expr: COUNT(DISTINCT award_recipient_id)
    - name: "Total Monetary Award Amount"
      expr: SUM(monetary_award_amount)
    - name: "Average Monetary Award Amount"
      expr: AVG(monetary_award_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign business metrics"
  source: "`education_ecm`.`advancement`.`campaign`"
  dimensions:
    - name: "Active Membership Count"
      expr: active_membership_count
    - name: "Campaign Description"
      expr: campaign_description
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Number"
      expr: campaign_number
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Case Reporting Classification"
      expr: case_reporting_classification
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Donor Count"
      expr: donor_count
    - name: "End Date"
      expr: end_date
    - name: "Gift Counting Rules"
      expr: gift_counting_rules
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Member Benefits Description"
      expr: member_benefits_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign"
      expr: COUNT(DISTINCT campaign_id)
    - name: "Total Amount Raised"
      expr: SUM(amount_raised)
    - name: "Average Amount Raised"
      expr: AVG(amount_raised)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Goal Amount"
      expr: SUM(goal_amount)
    - name: "Average Goal Amount"
      expr: AVG(goal_amount)
    - name: "Total Minimum Giving Threshold"
      expr: SUM(minimum_giving_threshold)
    - name: "Average Minimum Giving Threshold"
      expr: AVG(minimum_giving_threshold)
    - name: "Total Quiet Phase Goal Amount"
      expr: SUM(quiet_phase_goal_amount)
    - name: "Average Quiet Phase Goal Amount"
      expr: AVG(quiet_phase_goal_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_campaign_volunteer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Volunteer business metrics"
  source: "`education_ecm`.`advancement`.`campaign_volunteer`"
  dimensions:
    - name: "Participation End Date"
      expr: participation_end_date
    - name: "Participation Start Date"
      expr: participation_start_date
    - name: "Recognition Level"
      expr: recognition_level
    - name: "Recruitment Date"
      expr: recruitment_date
    - name: "Solicitation Assignment Count"
      expr: solicitation_assignment_count
    - name: "Training Completed Date"
      expr: training_completed_date
    - name: "Volunteer Role"
      expr: volunteer_role
    - name: "Volunteer Status"
      expr: volunteer_status
    - name: "Participation End Date Month"
      expr: DATE_TRUNC('MONTH', participation_end_date)
    - name: "Participation Start Date Month"
      expr: DATE_TRUNC('MONTH', participation_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Volunteer"
      expr: COUNT(DISTINCT campaign_volunteer_id)
    - name: "Total Dollars Raised"
      expr: SUM(dollars_raised)
    - name: "Average Dollars Raised"
      expr: AVG(dollars_raised)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_career_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Career Record business metrics"
  source: "`education_ecm`.`advancement`.`career_record`"
  dimensions:
    - name: "Career Field Alignment"
      expr: career_field_alignment
    - name: "Career Notes"
      expr: career_notes
    - name: "Cip Code"
      expr: cip_code
    - name: "Company Website"
      expr: company_website
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Collection Method"
      expr: data_collection_method
    - name: "Data Source"
      expr: data_source
    - name: "Employer Industry Code"
      expr: employer_industry_code
    - name: "Employer Name"
      expr: employer_name
    - name: "Employer Size Category"
      expr: employer_size_category
    - name: "Employment City"
      expr: employment_city
    - name: "Employment Country"
      expr: employment_country
    - name: "Employment State Province"
      expr: employment_state_province
    - name: "Employment Type"
      expr: employment_type
    - name: "End Date"
      expr: end_date
    - name: "Is Current Position"
      expr: is_current_position
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Career Record"
      expr: COUNT(DISTINCT career_record_id)
    - name: "Total Years To Position"
      expr: SUM(years_to_position)
    - name: "Average Years To Position"
      expr: AVG(years_to_position)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Constituent business metrics"
  source: "`education_ecm`.`advancement`.`constituent`"
  dimensions:
    - name: "Alternate Email"
      expr: alternate_email
    - name: "Alumni Status"
      expr: alumni_status
    - name: "Business Phone"
      expr: business_phone
    - name: "Constituent Status"
      expr: constituent_status
    - name: "Constituent Type"
      expr: constituent_type
    - name: "Data Source"
      expr: data_source
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Deceased Date"
      expr: deceased_date
    - name: "Deceased Flag"
      expr: deceased_flag
    - name: "Degree Earned"
      expr: degree_earned
    - name: "Donor Status"
      expr: donor_status
    - name: "Employer Name"
      expr: employer_name
    - name: "Engagement Score"
      expr: engagement_score
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Giving Capacity Rating"
      expr: giving_capacity_rating
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Constituent"
      expr: COUNT(DISTINCT constituent_id)
    - name: "Total Lifetime Giving Amount"
      expr: SUM(lifetime_giving_amount)
    - name: "Average Lifetime Giving Amount"
      expr: AVG(lifetime_giving_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_corporate_sponsorship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate Sponsorship business metrics"
  source: "`education_ecm`.`advancement`.`corporate_sponsorship`"
  dimensions:
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Benefit Package Description"
      expr: benefit_package_description
    - name: "Contract Document Url"
      expr: contract_document_url
    - name: "Contract Duration Months"
      expr: contract_duration_months
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fulfillment Completion Date"
      expr: fulfillment_completion_date
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Payment Date"
      expr: last_payment_date
    - name: "Naming Rights Granted"
      expr: naming_rights_granted
    - name: "Next Payment Due Date"
      expr: next_payment_due_date
    - name: "Notes"
      expr: notes
    - name: "Payment Schedule"
      expr: payment_schedule
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Corporate Sponsorship"
      expr: COUNT(DISTINCT corporate_sponsorship_id)
    - name: "Total Payment Outstanding"
      expr: SUM(payment_outstanding)
    - name: "Average Payment Outstanding"
      expr: AVG(payment_outstanding)
    - name: "Total Payment Received To Date"
      expr: SUM(payment_received_to_date)
    - name: "Average Payment Received To Date"
      expr: AVG(payment_received_to_date)
    - name: "Total Sponsorship Amount"
      expr: SUM(sponsorship_amount)
    - name: "Average Sponsorship Amount"
      expr: AVG(sponsorship_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_donor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor business metrics"
  source: "`education_ecm`.`advancement`.`donor`"
  dimensions:
    - name: "Address Verification Status"
      expr: address_verification_status
    - name: "Alternate Email"
      expr: alternate_email
    - name: "Consecutive Giving Years"
      expr: consecutive_giving_years
    - name: "Constituent Classification"
      expr: constituent_classification
    - name: "Deceased Date"
      expr: deceased_date
    - name: "Deceased Flag"
      expr: deceased_flag
    - name: "Do Not Contact Flag"
      expr: do_not_contact_flag
    - name: "Do Not Solicit Flag"
      expr: do_not_solicit_flag
    - name: "Donor Status"
      expr: donor_status
    - name: "Donor Type"
      expr: donor_type
    - name: "Giving Capacity Rating"
      expr: giving_capacity_rating
    - name: "Legal Name"
      expr: legal_name
    - name: "Mobile Phone"
      expr: mobile_phone
    - name: "Ncoa Update Date"
      expr: ncoa_update_date
    - name: "Portfolio Assignment"
      expr: portfolio_assignment
    - name: "Preferred Name"
      expr: preferred_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Donor"
      expr: COUNT(DISTINCT donor_id)
    - name: "Total Fiscal Year Giving Total"
      expr: SUM(fiscal_year_giving_total)
    - name: "Average Fiscal Year Giving Total"
      expr: AVG(fiscal_year_giving_total)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_endowment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Endowment business metrics"
  source: "`education_ecm`.`advancement`.`endowment`"
  dimensions:
    - name: "Accounting Segment"
      expr: accounting_segment
    - name: "Benefiting College"
      expr: benefiting_college
    - name: "Benefiting Department"
      expr: benefiting_department
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Establishment Date"
      expr: establishment_date
    - name: "Fund Name"
      expr: fund_name
    - name: "Fund Number"
      expr: fund_number
    - name: "Fund Purpose"
      expr: fund_purpose
    - name: "Fund Status"
      expr: fund_status
    - name: "Fund Type"
      expr: fund_type
    - name: "Ipeds Reportable Flag"
      expr: ipeds_reportable_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Stewardship Report Date"
      expr: last_stewardship_report_date
    - name: "Market Value Date"
      expr: market_value_date
    - name: "Nacubo Reportable Flag"
      expr: nacubo_reportable_flag
    - name: "Named Honoree"
      expr: named_honoree
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Endowment"
      expr: COUNT(DISTINCT endowment_id)
    - name: "Total Annual Distribution Amount"
      expr: SUM(annual_distribution_amount)
    - name: "Average Annual Distribution Amount"
      expr: AVG(annual_distribution_amount)
    - name: "Total Current Principal Amount"
      expr: SUM(current_principal_amount)
    - name: "Average Current Principal Amount"
      expr: AVG(current_principal_amount)
    - name: "Total Market Value"
      expr: SUM(market_value)
    - name: "Average Market Value"
      expr: AVG(market_value)
    - name: "Total Minimum Balance Required"
      expr: SUM(minimum_balance_required)
    - name: "Average Minimum Balance Required"
      expr: AVG(minimum_balance_required)
    - name: "Total Original Principal Amount"
      expr: SUM(original_principal_amount)
    - name: "Average Original Principal Amount"
      expr: AVG(original_principal_amount)
    - name: "Total Spending Policy Rate"
      expr: SUM(spending_policy_rate)
    - name: "Average Spending Policy Rate"
      expr: AVG(spending_policy_rate)
    - name: "Total Underwater Amount"
      expr: SUM(underwater_amount)
    - name: "Average Underwater Amount"
      expr: AVG(underwater_amount)
    - name: "Total Unit Market Value"
      expr: SUM(unit_market_value)
    - name: "Average Unit Market Value"
      expr: AVG(unit_market_value)
    - name: "Total Units Held"
      expr: SUM(units_held)
    - name: "Average Units Held"
      expr: AVG(units_held)
    - name: "Total Ytd Distribution Amount"
      expr: SUM(ytd_distribution_amount)
    - name: "Average Ytd Distribution Amount"
      expr: AVG(ytd_distribution_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_engagement_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement Activity business metrics"
  source: "`education_ecm`.`advancement`.`engagement_activity`"
  dimensions:
    - name: "Activity Date"
      expr: activity_date
    - name: "Activity Status"
      expr: activity_status
    - name: "Activity Timestamp"
      expr: activity_timestamp
    - name: "Activity Type"
      expr: activity_type
    - name: "Attendee Count"
      expr: attendee_count
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Follow Up Date"
      expr: follow_up_date
    - name: "Follow Up Required"
      expr: follow_up_required
    - name: "Is Major Gift Related"
      expr: is_major_gift_related
    - name: "Is Volunteer Activity"
      expr: is_volunteer_activity
    - name: "Location"
      expr: location
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Engagement Activity"
      expr: COUNT(DISTINCT engagement_activity_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Engagement Score"
      expr: SUM(engagement_score)
    - name: "Average Engagement Score"
      expr: AVG(engagement_score)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event business metrics"
  source: "`education_ecm`.`advancement`.`event`"
  dimensions:
    - name: "Actual Attendance"
      expr: actual_attendance
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Mode"
      expr: delivery_mode
    - name: "Early Registration Deadline"
      expr: early_registration_deadline
    - name: "End Time"
      expr: end_time
    - name: "Event Date"
      expr: event_date
    - name: "Event Description"
      expr: event_description
    - name: "Event Name"
      expr: event_name
    - name: "Event Number"
      expr: event_number
    - name: "Event Status"
      expr: event_status
    - name: "Event Type"
      expr: event_type
    - name: "Is Fundraising Event"
      expr: is_fundraising_event
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Purpose"
      expr: purpose
    - name: "Registration Capacity"
      expr: registration_capacity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Event"
      expr: COUNT(DISTINCT event_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Early Registration Fee"
      expr: SUM(early_registration_fee)
    - name: "Average Early Registration Fee"
      expr: AVG(early_registration_fee)
    - name: "Total Fundraising Goal Amount"
      expr: SUM(fundraising_goal_amount)
    - name: "Average Fundraising Goal Amount"
      expr: AVG(fundraising_goal_amount)
    - name: "Total Guest Registration Fee"
      expr: SUM(guest_registration_fee)
    - name: "Average Guest Registration Fee"
      expr: AVG(guest_registration_fee)
    - name: "Total Standard Registration Fee"
      expr: SUM(standard_registration_fee)
    - name: "Average Standard Registration Fee"
      expr: AVG(standard_registration_fee)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift business metrics"
  source: "`education_ecm`.`advancement`.`gift`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Acknowledgment Status"
      expr: acknowledgment_status
    - name: "Anonymous Flag"
      expr: anonymous_flag
    - name: "Case Reportable Flag"
      expr: case_reportable_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deposit Date"
      expr: deposit_date
    - name: "First Gift Date"
      expr: first_gift_date
    - name: "Gift Date"
      expr: gift_date
    - name: "Gift Number"
      expr: gift_number
    - name: "Gift Source"
      expr: gift_source
    - name: "Gift Status"
      expr: gift_status
    - name: "Gift Type"
      expr: gift_type
    - name: "In Kind Description"
      expr: in_kind_description
    - name: "Ipeds Reportable Flag"
      expr: ipeds_reportable_flag
    - name: "Last Gift Date"
      expr: last_gift_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gift"
      expr: COUNT(DISTINCT gift_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Amount Usd"
      expr: SUM(amount_usd)
    - name: "Average Amount Usd"
      expr: AVG(amount_usd)
    - name: "Total Largest Gift Amount"
      expr: SUM(largest_gift_amount)
    - name: "Average Largest Gift Amount"
      expr: AVG(largest_gift_amount)
    - name: "Total Lifetime Giving Total"
      expr: SUM(lifetime_giving_total)
    - name: "Average Lifetime Giving Total"
      expr: AVG(lifetime_giving_total)
    - name: "Total Stock Shares"
      expr: SUM(stock_shares)
    - name: "Average Stock Shares"
      expr: AVG(stock_shares)
    - name: "Total Tax Deductible Amount"
      expr: SUM(tax_deductible_amount)
    - name: "Average Tax Deductible Amount"
      expr: AVG(tax_deductible_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_gift_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift Agreement business metrics"
  source: "`education_ecm`.`advancement`.`gift_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Final Payment Date"
      expr: final_payment_date
    - name: "First Payment Date"
      expr: first_payment_date
    - name: "Gift Purpose"
      expr: gift_purpose
    - name: "Gift Valuation Date"
      expr: gift_valuation_date
    - name: "Is Anonymous"
      expr: is_anonymous
    - name: "Is Matching Eligible"
      expr: is_matching_eligible
    - name: "Legal Document Reference"
      expr: legal_document_reference
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Naming Opportunity"
      expr: naming_opportunity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gift Agreement"
      expr: COUNT(DISTINCT gift_agreement_id)
    - name: "Total Balance Amount"
      expr: SUM(balance_amount)
    - name: "Average Balance Amount"
      expr: AVG(balance_amount)
    - name: "Total Commitment Amount"
      expr: SUM(commitment_amount)
    - name: "Average Commitment Amount"
      expr: AVG(commitment_amount)
    - name: "Total Paid Amount"
      expr: SUM(paid_amount)
    - name: "Average Paid Amount"
      expr: AVG(paid_amount)
    - name: "Total Tax Deductible Amount"
      expr: SUM(tax_deductible_amount)
    - name: "Average Tax Deductible Amount"
      expr: AVG(tax_deductible_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_group_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Membership business metrics"
  source: "`education_ecm`.`advancement`.`group_membership`"
  dimensions:
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Communication Preference"
      expr: communication_preference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dues Currency Code"
      expr: dues_currency_code
    - name: "Dues Paid Date"
      expr: dues_paid_date
    - name: "Dues Payment Status"
      expr: dues_payment_status
    - name: "Election Date"
      expr: election_date
    - name: "End Date"
      expr: end_date
    - name: "Events Attended Count"
      expr: events_attended_count
    - name: "Join Method"
      expr: join_method
    - name: "Last Event Attended Date"
      expr: last_event_attended_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renewed Date"
      expr: last_renewed_date
    - name: "Leadership End Date"
      expr: leadership_end_date
    - name: "Leadership Start Date"
      expr: leadership_start_date
    - name: "Membership Number"
      expr: membership_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Membership"
      expr: COUNT(DISTINCT group_membership_id)
    - name: "Total Dues Amount"
      expr: SUM(dues_amount)
    - name: "Average Dues Amount"
      expr: AVG(dues_amount)
    - name: "Total Volunteer Hours"
      expr: SUM(volunteer_hours)
    - name: "Average Volunteer Hours"
      expr: AVG(volunteer_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_lifelong_learning_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lifelong Learning Enrollment business metrics"
  source: "`education_ecm`.`advancement`.`lifelong_learning_enrollment`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Certificate Issue Date"
      expr: certificate_issue_date
    - name: "Certificate Issued Flag"
      expr: certificate_issued_flag
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Completion Status"
      expr: completion_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Modality"
      expr: delivery_modality
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Notes"
      expr: enrollment_notes
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Expected Completion Date"
      expr: expected_completion_date
    - name: "Grade Earned"
      expr: grade_earned
    - name: "Instructor Name"
      expr: instructor_name
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Oer Based Flag"
      expr: oer_based_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lifelong Learning Enrollment"
      expr: COUNT(DISTINCT lifelong_learning_enrollment_id)
    - name: "Total Ceu Credits Earned"
      expr: SUM(ceu_credits_earned)
    - name: "Average Ceu Credits Earned"
      expr: AVG(ceu_credits_earned)
    - name: "Total Contact Hours"
      expr: SUM(contact_hours)
    - name: "Average Contact Hours"
      expr: AVG(contact_hours)
    - name: "Total Engagement Score"
      expr: SUM(engagement_score)
    - name: "Average Engagement Score"
      expr: AVG(engagement_score)
    - name: "Total Scholarship Amount"
      expr: SUM(scholarship_amount)
    - name: "Average Scholarship Amount"
      expr: AVG(scholarship_amount)
    - name: "Total Tuition Amount"
      expr: SUM(tuition_amount)
    - name: "Average Tuition Amount"
      expr: AVG(tuition_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_major_gift_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major Gift Proposal business metrics"
  source: "`education_ecm`.`advancement`.`major_gift_proposal`"
  dimensions:
    - name: "Actual Close Date"
      expr: actual_close_date
    - name: "Ask Date"
      expr: ask_date
    - name: "Board Approval Date"
      expr: board_approval_date
    - name: "Board Approval Required Flag"
      expr: board_approval_required_flag
    - name: "Confidential Flag"
      expr: confidential_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Decline Reason"
      expr: decline_reason
    - name: "Expected Close Date"
      expr: expected_close_date
    - name: "Fund Designation"
      expr: fund_designation
    - name: "Gift Agreement Date"
      expr: gift_agreement_date
    - name: "Gift Agreement Executed Flag"
      expr: gift_agreement_executed_flag
    - name: "Gift Purpose"
      expr: gift_purpose
    - name: "Last Contact Date"
      expr: last_contact_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Naming Opportunity"
      expr: naming_opportunity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Major Gift Proposal"
      expr: COUNT(DISTINCT major_gift_proposal_id)
    - name: "Total Ask Amount"
      expr: SUM(ask_amount)
    - name: "Average Ask Amount"
      expr: AVG(ask_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Weighted Amount"
      expr: SUM(weighted_amount)
    - name: "Average Weighted Amount"
      expr: AVG(weighted_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_matching_gift_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matching Gift Claim business metrics"
  source: "`education_ecm`.`advancement`.`matching_gift_claim`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Acknowledgment Sent Flag"
      expr: acknowledgment_sent_flag
    - name: "Appeal Date"
      expr: appeal_date
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Appeal Submitted Flag"
      expr: appeal_submitted_flag
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Status"
      expr: claim_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deadline Date"
      expr: deadline_date
    - name: "Denial Date"
      expr: denial_date
    - name: "Denial Reason"
      expr: denial_reason
    - name: "Employer Name"
      expr: employer_name
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Matching Gift Program Name"
      expr: matching_gift_program_name
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Matching Gift Claim"
      expr: COUNT(DISTINCT matching_gift_claim_id)
    - name: "Total Claimed Match Amount"
      expr: SUM(claimed_match_amount)
    - name: "Average Claimed Match Amount"
      expr: AVG(claimed_match_amount)
    - name: "Total Employer Organization Code"
      expr: SUM(employer_organization_code)
    - name: "Average Employer Organization Code"
      expr: AVG(employer_organization_code)
    - name: "Total Match Ratio"
      expr: SUM(match_ratio)
    - name: "Average Match Ratio"
      expr: AVG(match_ratio)
    - name: "Total Maximum Match Amount"
      expr: SUM(maximum_match_amount)
    - name: "Average Maximum Match Amount"
      expr: AVG(maximum_match_amount)
    - name: "Total Minimum Gift Amount"
      expr: SUM(minimum_gift_amount)
    - name: "Average Minimum Gift Amount"
      expr: AVG(minimum_gift_amount)
    - name: "Total Original Gift Amount"
      expr: SUM(original_gift_amount)
    - name: "Average Original Gift Amount"
      expr: AVG(original_gift_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_mentorship_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mentorship Match business metrics"
  source: "`education_ecm`.`advancement`.`mentorship_match`"
  dimensions:
    - name: "Actual Duration Months"
      expr: actual_duration_months
    - name: "Agreement Signed Date"
      expr: agreement_signed_date
    - name: "Agreement Signed Flag"
      expr: agreement_signed_flag
    - name: "Communication Frequency"
      expr: communication_frequency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expected Duration Months"
      expr: expected_duration_months
    - name: "Focus Area"
      expr: focus_area
    - name: "Industry Alignment"
      expr: industry_alignment
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Match Date"
      expr: match_date
    - name: "Match End Date"
      expr: match_end_date
    - name: "Match Method"
      expr: match_method
    - name: "Match Notes"
      expr: match_notes
    - name: "Match Number"
      expr: match_number
    - name: "Match Start Date"
      expr: match_start_date
    - name: "Match Status"
      expr: match_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mentorship Match"
      expr: COUNT(DISTINCT mentorship_match_id)
    - name: "Total Match Quality Score"
      expr: SUM(match_quality_score)
    - name: "Average Match Quality Score"
      expr: AVG(match_quality_score)
    - name: "Total Mentee Satisfaction Rating"
      expr: SUM(mentee_satisfaction_rating)
    - name: "Average Mentee Satisfaction Rating"
      expr: AVG(mentee_satisfaction_rating)
    - name: "Total Mentor Satisfaction Rating"
      expr: SUM(mentor_satisfaction_rating)
    - name: "Average Mentor Satisfaction Rating"
      expr: AVG(mentor_satisfaction_rating)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_mentorship_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mentorship Program business metrics"
  source: "`education_ecm`.`advancement`.`mentorship_program`"
  dimensions:
    - name: "Application Close Date"
      expr: application_close_date
    - name: "Application Open Date"
      expr: application_open_date
    - name: "Background Check Required Flag"
      expr: background_check_required_flag
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "Funding Source"
      expr: funding_source
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Matching Criteria"
      expr: matching_criteria
    - name: "Matching Methodology"
      expr: matching_methodology
    - name: "Maximum Mentee Capacity"
      expr: maximum_mentee_capacity
    - name: "Maximum Mentor Capacity"
      expr: maximum_mentor_capacity
    - name: "Orientation Required Flag"
      expr: orientation_required_flag
    - name: "Program Code"
      expr: program_code
    - name: "Program Cycle"
      expr: program_cycle
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mentorship Program"
      expr: COUNT(DISTINCT mentorship_program_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Program Fee Amount"
      expr: SUM(program_fee_amount)
    - name: "Average Program Fee Amount"
      expr: AVG(program_fee_amount)
    - name: "Total Time Commitment Hours"
      expr: SUM(time_commitment_hours)
    - name: "Average Time Commitment Hours"
      expr: AVG(time_commitment_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organization business metrics"
  source: "`education_ecm`.`advancement`.`organization`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Donor Recognition Level"
      expr: donor_recognition_level
    - name: "Employee Count"
      expr: employee_count
    - name: "Fax Number"
      expr: fax_number
    - name: "Industry Classification"
      expr: industry_classification
    - name: "Last Gift Date"
      expr: last_gift_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Name"
      expr: legal_name
    - name: "Matching Gift Eligible"
      expr: matching_gift_eligible
    - name: "Matching Gift Ratio"
      expr: matching_gift_ratio
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Organization"
      expr: COUNT(DISTINCT organization_id)
    - name: "Total Annual Revenue"
      expr: SUM(annual_revenue)
    - name: "Average Annual Revenue"
      expr: AVG(annual_revenue)
    - name: "Total Foundation Assets"
      expr: SUM(foundation_assets)
    - name: "Average Foundation Assets"
      expr: AVG(foundation_assets)
    - name: "Total Last Gift Amount"
      expr: SUM(last_gift_amount)
    - name: "Average Last Gift Amount"
      expr: AVG(last_gift_amount)
    - name: "Total Lifetime Giving Amount"
      expr: SUM(lifetime_giving_amount)
    - name: "Average Lifetime Giving Amount"
      expr: AVG(lifetime_giving_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_outreach_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outreach Communication business metrics"
  source: "`education_ecm`.`advancement`.`outreach_communication`"
  dimensions:
    - name: "Bounce Reason"
      expr: bounce_reason
    - name: "Clicked Flag"
      expr: clicked_flag
    - name: "Clicked Timestamp"
      expr: clicked_timestamp
    - name: "Communication Date"
      expr: communication_date
    - name: "Communication Notes"
      expr: communication_notes
    - name: "Communication Number"
      expr: communication_number
    - name: "Communication Status"
      expr: communication_status
    - name: "Communication Timestamp"
      expr: communication_timestamp
    - name: "Communication Type"
      expr: communication_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Ferpa Compliant Flag"
      expr: ferpa_compliant_flag
    - name: "Follow Up Date"
      expr: follow_up_date
    - name: "Follow Up Notes"
      expr: follow_up_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Outreach Communication"
      expr: COUNT(DISTINCT outreach_communication_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_planned_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned Gift business metrics"
  source: "`education_ecm`.`advancement`.`planned_gift`"
  dimensions:
    - name: "Actual Maturity Date"
      expr: actual_maturity_date
    - name: "Anonymous Flag"
      expr: anonymous_flag
    - name: "Commitment Date"
      expr: commitment_date
    - name: "Commitment Number"
      expr: commitment_number
    - name: "Commitment Status"
      expr: commitment_status
    - name: "Contingent Beneficiary Flag"
      expr: contingent_beneficiary_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Designation Purpose"
      expr: designation_purpose
    - name: "Documentation Date"
      expr: documentation_date
    - name: "Expected Maturity Date"
      expr: expected_maturity_date
    - name: "Gift Vehicle Type"
      expr: gift_vehicle_type
    - name: "Last Contact Date"
      expr: last_contact_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Documentation Status"
      expr: legal_documentation_status
    - name: "Next Contact Date"
      expr: next_contact_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Planned Gift"
      expr: COUNT(DISTINCT planned_gift_id)
    - name: "Total Estate Percentage"
      expr: SUM(estate_percentage)
    - name: "Average Estate Percentage"
      expr: AVG(estate_percentage)
    - name: "Total Estimated Value Amount"
      expr: SUM(estimated_value_amount)
    - name: "Average Estimated Value Amount"
      expr: AVG(estimated_value_amount)
    - name: "Total Fixed Amount"
      expr: SUM(fixed_amount)
    - name: "Average Fixed Amount"
      expr: AVG(fixed_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge business metrics"
  source: "`education_ecm`.`advancement`.`pledge`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Acknowledgment Sent Flag"
      expr: acknowledgment_sent_flag
    - name: "Anonymous Flag"
      expr: anonymous_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Designation"
      expr: designation
    - name: "Final Installment Date"
      expr: final_installment_date
    - name: "First Installment Date"
      expr: first_installment_date
    - name: "Installment Frequency"
      expr: installment_frequency
    - name: "Installments Paid"
      expr: installments_paid
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Payment Date"
      expr: last_payment_date
    - name: "Matching Gift Eligible Flag"
      expr: matching_gift_eligible_flag
    - name: "Next Installment Date"
      expr: next_installment_date
    - name: "Notes"
      expr: notes
    - name: "Number Of Installments"
      expr: number_of_installments
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pledge"
      expr: COUNT(DISTINCT pledge_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Amount Paid"
      expr: SUM(amount_paid)
    - name: "Average Amount Paid"
      expr: AVG(amount_paid)
    - name: "Total Balance Outstanding"
      expr: SUM(balance_outstanding)
    - name: "Average Balance Outstanding"
      expr: AVG(balance_outstanding)
    - name: "Total Last Payment Amount"
      expr: SUM(last_payment_amount)
    - name: "Average Last Payment Amount"
      expr: AVG(last_payment_amount)
    - name: "Total Next Installment Amount"
      expr: SUM(next_installment_amount)
    - name: "Average Next Installment Amount"
      expr: AVG(next_installment_amount)
    - name: "Total Tax Deductible Amount"
      expr: SUM(tax_deductible_amount)
    - name: "Average Tax Deductible Amount"
      expr: AVG(tax_deductible_amount)
    - name: "Total Write Off Amount"
      expr: SUM(write_off_amount)
    - name: "Average Write Off Amount"
      expr: AVG(write_off_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_prospect_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect Rating business metrics"
  source: "`education_ecm`.`advancement`.`prospect_rating`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Assigned Rating Tier"
      expr: assigned_rating_tier
    - name: "Board Memberships"
      expr: board_memberships
    - name: "Capacity Currency Code"
      expr: capacity_currency_code
    - name: "Capacity Rating"
      expr: capacity_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Foundation Affiliations"
      expr: foundation_affiliations
    - name: "Inclination Rating"
      expr: inclination_rating
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Philanthropic Interests"
      expr: philanthropic_interests
    - name: "Political Contributions Flag"
      expr: political_contributions_flag
    - name: "Portfolio Assignment Date"
      expr: portfolio_assignment_date
    - name: "Rating Date"
      expr: rating_date
    - name: "Rating Effective Date"
      expr: rating_effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Prospect Rating"
      expr: COUNT(DISTINCT prospect_rating_id)
    - name: "Total Affinity Score"
      expr: SUM(affinity_score)
    - name: "Average Affinity Score"
      expr: AVG(affinity_score)
    - name: "Total Business Interests Value"
      expr: SUM(business_interests_value)
    - name: "Average Business Interests Value"
      expr: AVG(business_interests_value)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Estimated Annual Income"
      expr: SUM(estimated_annual_income)
    - name: "Average Estimated Annual Income"
      expr: AVG(estimated_annual_income)
    - name: "Total Estimated Capacity Amount"
      expr: SUM(estimated_capacity_amount)
    - name: "Average Estimated Capacity Amount"
      expr: AVG(estimated_capacity_amount)
    - name: "Total Estimated Capacity Range High"
      expr: SUM(estimated_capacity_range_high)
    - name: "Average Estimated Capacity Range High"
      expr: AVG(estimated_capacity_range_high)
    - name: "Total Estimated Capacity Range Low"
      expr: SUM(estimated_capacity_range_low)
    - name: "Average Estimated Capacity Range Low"
      expr: AVG(estimated_capacity_range_low)
    - name: "Total Estimated Net Worth"
      expr: SUM(estimated_net_worth)
    - name: "Average Estimated Net Worth"
      expr: AVG(estimated_net_worth)
    - name: "Total Propensity Score"
      expr: SUM(propensity_score)
    - name: "Average Propensity Score"
      expr: AVG(propensity_score)
    - name: "Total Real Estate Holdings Value"
      expr: SUM(real_estate_holdings_value)
    - name: "Average Real Estate Holdings Value"
      expr: AVG(real_estate_holdings_value)
    - name: "Total Stock Ownership Value"
      expr: SUM(stock_ownership_value)
    - name: "Average Stock Ownership Value"
      expr: AVG(stock_ownership_value)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_recognition_society`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recognition Society business metrics"
  source: "`education_ecm`.`advancement`.`recognition_society`"
  dimensions:
    - name: "Active Member Count"
      expr: active_member_count
    - name: "Annual Recognition Event Flag"
      expr: annual_recognition_event_flag
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Endowment Funded Flag"
      expr: endowment_funded_flag
    - name: "Founding Date"
      expr: founding_date
    - name: "Giving Level Tier"
      expr: giving_level_tier
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifetime Member Count"
      expr: lifetime_member_count
    - name: "Member Benefits Summary"
      expr: member_benefits_summary
    - name: "Membership Renewal Required Flag"
      expr: membership_renewal_required_flag
    - name: "Notes"
      expr: notes
    - name: "Prospect Qualification Flag"
      expr: prospect_qualification_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recognition Society"
      expr: COUNT(DISTINCT recognition_society_id)
    - name: "Total Minimum Giving Threshold"
      expr: SUM(minimum_giving_threshold)
    - name: "Average Minimum Giving Threshold"
      expr: AVG(minimum_giving_threshold)
    - name: "Total Total Funds Raised Ytd"
      expr: SUM(total_funds_raised_ytd)
    - name: "Average Total Funds Raised Ytd"
      expr: AVG(total_funds_raised_ytd)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_stewardship_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stewardship Action business metrics"
  source: "`education_ecm`.`advancement`.`stewardship_action`"
  dimensions:
    - name: "Action Date"
      expr: action_date
    - name: "Action Number"
      expr: action_number
    - name: "Action Status"
      expr: action_status
    - name: "Action Type"
      expr: action_type
    - name: "Assigned Staff Name"
      expr: assigned_staff_name
    - name: "Communication Channel"
      expr: communication_channel
    - name: "Completion Date"
      expr: completion_date
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Donor Response Date"
      expr: donor_response_date
    - name: "Donor Response Notes"
      expr: donor_response_notes
    - name: "Donor Response Received"
      expr: donor_response_received
    - name: "Donor Response Type"
      expr: donor_response_type
    - name: "Fund Name"
      expr: fund_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stewardship Action"
      expr: COUNT(DISTINCT stewardship_action_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_stewardship_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stewardship Plan business metrics"
  source: "`education_ecm`.`advancement`.`stewardship_plan`"
  dimensions:
    - name: "Annual Report Flag"
      expr: annual_report_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Benefits Summary"
      expr: benefits_summary
    - name: "Contact Strategy"
      expr: contact_strategy
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Description"
      expr: stewardship_plan_description
    - name: "Donor Segment"
      expr: donor_segment
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Engagement Frequency"
      expr: engagement_frequency
    - name: "Event Invitation Flag"
      expr: event_invitation_flag
    - name: "Gift Acknowledgment Template"
      expr: gift_acknowledgment_template
    - name: "Last Review Date"
      expr: last_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stewardship Plan"
      expr: COUNT(DISTINCT stewardship_plan_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Gift Level Maximum"
      expr: SUM(gift_level_maximum)
    - name: "Average Gift Level Maximum"
      expr: AVG(gift_level_maximum)
    - name: "Total Gift Level Minimum"
      expr: SUM(gift_level_minimum)
    - name: "Average Gift Level Minimum"
      expr: AVG(gift_level_minimum)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_survey_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey Response business metrics"
  source: "`education_ecm`.`advancement`.`survey_response`"
  dimensions:
    - name: "Academic College"
      expr: academic_college
    - name: "Accreditation Reporting Cycle"
      expr: accreditation_reporting_cycle
    - name: "Continuing Education Institution"
      expr: continuing_education_institution
    - name: "Continuing Education Program"
      expr: continuing_education_program
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Employer Name"
      expr: employer_name
    - name: "Employment Status"
      expr: employment_status
    - name: "First Access Date"
      expr: first_access_date
    - name: "Graduation Year"
      expr: graduation_year
    - name: "Incentive Offered Flag"
      expr: incentive_offered_flag
    - name: "Incentive Type"
      expr: incentive_type
    - name: "Industry Sector"
      expr: industry_sector
    - name: "Ipeds Reportable Flag"
      expr: ipeds_reportable_flag
    - name: "Job Location City"
      expr: job_location_city
    - name: "Job Location Country Code"
      expr: job_location_country_code
    - name: "Job Location State Province"
      expr: job_location_state_province
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Survey Response"
      expr: COUNT(DISTINCT survey_response_id)
    - name: "Total Completion Percentage"
      expr: SUM(completion_percentage)
    - name: "Average Completion Percentage"
      expr: AVG(completion_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_volunteer_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer Assignment business metrics"
  source: "`education_ecm`.`advancement`.`volunteer_assignment`"
  dimensions:
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Number"
      expr: assignment_number
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Background Check Date"
      expr: background_check_date
    - name: "Background Check Required Flag"
      expr: background_check_required_flag
    - name: "Background Check Status"
      expr: background_check_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Performance Notes"
      expr: performance_notes
    - name: "Performance Rating"
      expr: performance_rating
    - name: "Recognition Awarded Flag"
      expr: recognition_awarded_flag
    - name: "Recognition Date"
      expr: recognition_date
    - name: "Recognition Level"
      expr: recognition_level
    - name: "Renewal Date"
      expr: renewal_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Volunteer Assignment"
      expr: COUNT(DISTINCT volunteer_assignment_id)
    - name: "Total Engagement Score"
      expr: SUM(engagement_score)
    - name: "Average Engagement Score"
      expr: AVG(engagement_score)
    - name: "Total Hours Served"
      expr: SUM(hours_served)
    - name: "Average Hours Served"
      expr: AVG(hours_served)
    - name: "Total Time Commitment Hours"
      expr: SUM(time_commitment_hours)
    - name: "Average Time Commitment Hours"
      expr: AVG(time_commitment_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_volunteer_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer Role business metrics"
  source: "`education_ecm`.`advancement`.`volunteer_role`"
  dimensions:
    - name: "Active Status"
      expr: active_status
    - name: "Application Required"
      expr: application_required
    - name: "Approval Required"
      expr: approval_required
    - name: "Associated Program"
      expr: associated_program
    - name: "Background Check Required"
      expr: background_check_required
    - name: "Benefits Description"
      expr: benefits_description
    - name: "Capacity Target"
      expr: capacity_target
    - name: "Created Date"
      expr: created_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Impact Statement"
      expr: impact_statement
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Owning Office"
      expr: owning_office
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Volunteer Role"
      expr: COUNT(DISTINCT volunteer_role_id)
    - name: "Total Time Commitment Hours Max"
      expr: SUM(time_commitment_hours_max)
    - name: "Average Time Commitment Hours Max"
      expr: AVG(time_commitment_hours_max)
    - name: "Total Time Commitment Hours Min"
      expr: SUM(time_commitment_hours_min)
    - name: "Average Time Commitment Hours Min"
      expr: AVG(time_commitment_hours_min)
$$;
