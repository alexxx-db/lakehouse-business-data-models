-- Metric views for domain: library | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_loan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core circulation metrics tracking loan activity, overdue rates, fine collection, and patron borrowing patterns"
  source: "`education_ecm`.`library`.`loan`"
  dimensions:
    - name: "loan_status"
      expr: loan_status
      comment: "Current status of the loan (active, returned, overdue, lost, claimed returned)"
    - name: "loan_type"
      expr: loan_type
      comment: "Type of loan (standard, reserve, interlibrary, special collections)"
    - name: "material_type"
      expr: material_type
      comment: "Type of material borrowed (book, journal, media, equipment)"
    - name: "patron_group"
      expr: patron_group
      comment: "Patron category (undergraduate, graduate, faculty, staff, community)"
    - name: "location_code"
      expr: location_code
      comment: "Library location where loan originated"
    - name: "checkout_month"
      expr: DATE_TRUNC('MONTH', checkout_timestamp)
      comment: "Month when item was checked out"
    - name: "is_overdue"
      expr: is_overdue
      comment: "Whether the loan is currently overdue"
    - name: "is_lost"
      expr: is_lost
      comment: "Whether the item has been declared lost"
    - name: "recall_requested"
      expr: recall_requested
      comment: "Whether the item has been recalled by another patron"
  measures:
    - name: "total_loans"
      expr: COUNT(1)
      comment: "Total number of loan transactions"
    - name: "total_fine_amount_accrued"
      expr: SUM(CAST(fine_amount_accrued AS DOUBLE))
      comment: "Total fines accrued across all loans"
    - name: "total_fine_amount_paid"
      expr: SUM(CAST(fine_amount_paid AS DOUBLE))
      comment: "Total fines paid by patrons"
    - name: "total_fine_amount_waived"
      expr: SUM(CAST(fine_amount_waived AS DOUBLE))
      comment: "Total fines waived by library staff"
    - name: "fine_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fine_amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(fine_amount_accrued AS DOUBLE)), 0), 2)
      comment: "Percentage of accrued fines successfully collected"
    - name: "avg_renewal_count"
      expr: AVG(CAST(renewal_count AS DOUBLE))
      comment: "Average number of renewals per loan"
    - name: "avg_overdue_days"
      expr: AVG(CAST(overdue_days AS DOUBLE))
      comment: "Average number of days items are overdue"
    - name: "overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overdue = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loans that are currently overdue"
    - name: "lost_item_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lost = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loans where items were declared lost"
    - name: "recall_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loans that were recalled due to high demand"
    - name: "unique_patrons"
      expr: COUNT(DISTINCT patron_id)
      comment: "Number of unique patrons with loan activity"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_acquisition_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection development and acquisition spend metrics tracking order fulfillment, vendor performance, and budget utilization"
  source: "`education_ecm`.`library`.`acquisition_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the acquisition order (pending, approved, ordered, received, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (firm, approval, standing, gift)"
    - name: "material_type"
      expr: material_type
      comment: "Type of material being acquired (book, journal, media, database)"
    - name: "collection_code"
      expr: collection_code
      comment: "Collection the material is being acquired for"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Status of invoice processing (pending, approved, paid, disputed)"
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of physical receipt (not received, partially received, fully received)"
    - name: "rush_order_flag"
      expr: rush_order_flag
      comment: "Whether this is a rush order requiring expedited processing"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month when order was placed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the order"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of acquisition orders"
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Total list price of all ordered materials"
    - name: "total_net_price"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net price after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount negotiated with vendors"
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost AS DOUBLE))
      comment: "Total shipping and handling costs"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on orders"
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total acquisition spend including all costs"
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated across orders"
    - name: "effective_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(list_price AS DOUBLE)), 0), 2)
      comment: "Actual discount rate achieved as percentage of list price"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total value per acquisition order"
    - name: "rush_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rush_order_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders requiring rush processing"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT library_vendor_id)
      comment: "Number of unique vendors used for acquisitions"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_electronic_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic resource subscription and access metrics tracking cost per use, renewal decisions, and digital collection ROI"
  source: "`education_ecm`.`library`.`electronic_resource`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of electronic resource (database, journal, ebook, streaming media)"
    - name: "access_model"
      expr: access_model
      comment: "Access model (subscription, perpetual, pay-per-view, open access)"
    - name: "activation_status"
      expr: activation_status
      comment: "Current activation status (active, inactive, trial, cancelled)"
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (annual, multi-year, perpetual)"
    - name: "subject_area"
      expr: subject_area
      comment: "Primary subject area or discipline"
    - name: "provider_name"
      expr: provider_name
      comment: "Name of the content provider or vendor"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether subscription auto-renews"
    - name: "trial_flag"
      expr: trial_flag
      comment: "Whether this is a trial subscription"
    - name: "counter_compliant_flag"
      expr: counter_compliant_flag
      comment: "Whether resource provides COUNTER-compliant usage statistics"
    - name: "oer_flag"
      expr: oer_flag
      comment: "Whether this is an Open Educational Resource"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for subscription cost"
  measures:
    - name: "total_resources"
      expr: COUNT(1)
      comment: "Total number of electronic resources"
    - name: "total_annual_cost"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual subscription cost across all electronic resources"
    - name: "avg_annual_cost"
      expr: AVG(CAST(annual_cost AS DOUBLE))
      comment: "Average annual cost per electronic resource"
    - name: "trial_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN trial_flag = FALSE AND activation_status = 'active' THEN 1 END) / NULLIF(COUNT(CASE WHEN trial_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of trial subscriptions converted to paid subscriptions"
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions set to auto-renew"
    - name: "counter_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN counter_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resources providing COUNTER-compliant usage data"
    - name: "oer_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oer_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of electronic resources that are Open Educational Resources"
    - name: "unique_providers"
      expr: COUNT(DISTINCT provider_name)
      comment: "Number of unique content providers"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_course_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course reserve usage and copyright compliance metrics supporting instructional needs and fair use management"
  source: "`education_ecm`.`library`.`course_reserve`"
  dimensions:
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of the reserve (active, expired, pending, cancelled)"
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (physical, electronic, streaming, link)"
    - name: "copyright_clearance_status"
      expr: copyright_clearance_status
      comment: "Status of copyright clearance (cleared, pending, denied, not required)"
    - name: "term_code"
      expr: term_code
      comment: "Academic term for which reserve is active"
    - name: "oer_flag"
      expr: oer_flag
      comment: "Whether the reserve material is an Open Educational Resource"
    - name: "accessibility_compliant_flag"
      expr: accessibility_compliant_flag
      comment: "Whether the material meets accessibility standards"
    - name: "lms_integration_flag"
      expr: lms_integration_flag
      comment: "Whether the reserve is integrated with the Learning Management System"
    - name: "alternative_format_available_flag"
      expr: alternative_format_available_flag
      comment: "Whether alternative accessible formats are available"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month when reserve was requested"
  measures:
    - name: "total_reserves"
      expr: COUNT(1)
      comment: "Total number of course reserve items"
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total usage count across all course reserves"
    - name: "avg_usage_per_reserve"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage count per reserve item"
    - name: "copyright_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN copyright_clearance_status = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reserves with completed copyright clearance"
    - name: "oer_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oer_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of course reserves using Open Educational Resources"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accessibility_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reserves meeting accessibility standards"
    - name: "lms_integration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lms_integration_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reserves integrated with LMS"
    - name: "unique_courses"
      expr: COUNT(DISTINCT course_section_id)
      comment: "Number of unique course sections with reserves"
    - name: "unique_instructors"
      expr: COUNT(DISTINCT instructor_id)
      comment: "Number of unique instructors requesting reserves"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_oer_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open Educational Resource adoption and cost savings metrics tracking textbook affordability initiatives and student savings"
  source: "`education_ecm`.`library`.`oer_resource`"
  dimensions:
    - name: "adoption_status"
      expr: adoption_status
      comment: "Current adoption status (adopted, pilot, under review, rejected)"
    - name: "review_status"
      expr: review_status
      comment: "Quality review status (approved, pending, in review, not reviewed)"
    - name: "resource_format"
      expr: resource_format
      comment: "Format of the OER (textbook, video, interactive, module)"
    - name: "license_type"
      expr: license_type
      comment: "Creative Commons or other open license type"
    - name: "subject_area"
      expr: subject_area
      comment: "Academic subject area or discipline"
    - name: "academic_term"
      expr: academic_term
      comment: "Academic term when OER was adopted"
    - name: "accessibility_compliance_flag"
      expr: accessibility_compliance_flag
      comment: "Whether the OER meets accessibility standards"
    - name: "institutional_repository_flag"
      expr: institutional_repository_flag
      comment: "Whether the OER is hosted in institutional repository"
    - name: "cip_code"
      expr: cip_code
      comment: "Classification of Instructional Programs code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost savings calculations"
  measures:
    - name: "total_oer_resources"
      expr: COUNT(1)
      comment: "Total number of Open Educational Resources"
    - name: "total_estimated_student_count"
      expr: SUM(CAST(estimated_student_count AS DOUBLE))
      comment: "Total number of students impacted by OER adoption"
    - name: "total_cost_savings"
      expr: SUM(CAST(total_estimated_cost_savings AS DOUBLE))
      comment: "Total estimated cost savings to students from OER adoption"
    - name: "avg_cost_savings_per_student"
      expr: AVG(CAST(estimated_cost_savings_per_student AS DOUBLE))
      comment: "Average cost savings per student from OER adoption"
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating of OER resources"
    - name: "adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adoption_status = 'adopted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OER resources fully adopted in courses"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accessibility_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OER resources meeting accessibility standards"
    - name: "institutional_hosting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN institutional_repository_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OER resources hosted in institutional repository"
    - name: "unique_instructors"
      expr: COUNT(DISTINCT instructor_id)
      comment: "Number of unique instructors adopting OER"
    - name: "unique_courses"
      expr: COUNT(DISTINCT course_id)
      comment: "Number of unique courses using OER"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_usage_stat`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic resource usage statistics and cost-per-use metrics for collection assessment and renewal decisions"
  source: "`education_ecm`.`library`.`usage_stat`"
  dimensions:
    - name: "metric_type"
      expr: metric_type
      comment: "Type of usage metric (COUNTER, proprietary, custom)"
    - name: "data_type"
      expr: data_type
      comment: "Type of content (journal, book, database, multimedia)"
    - name: "access_method"
      expr: access_method
      comment: "Method of access (regular, TDM, mobile)"
    - name: "access_type"
      expr: access_type
      comment: "Type of access (controlled, OA_Gold, other)"
    - name: "section_type"
      expr: section_type
      comment: "Section type (article, chapter, book)"
    - name: "data_source"
      expr: data_source
      comment: "Source of usage data (SUSHI, manual, vendor portal)"
    - name: "oer_flag"
      expr: oer_flag
      comment: "Whether the resource is an Open Educational Resource"
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month of the usage reporting period"
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Currency for cost calculations"
  measures:
    - name: "total_usage_records"
      expr: COUNT(1)
      comment: "Total number of usage statistic records"
    - name: "total_item_requests"
      expr: SUM(CAST(total_item_requests AS DOUBLE))
      comment: "Total number of item requests (full-text downloads, views)"
    - name: "total_item_investigations"
      expr: SUM(CAST(total_item_investigations AS DOUBLE))
      comment: "Total number of item investigations (abstract views, clicks)"
    - name: "unique_item_requests"
      expr: SUM(CAST(unique_item_requests AS DOUBLE))
      comment: "Total unique item requests (deduplicated by user session)"
    - name: "unique_item_investigations"
      expr: SUM(CAST(unique_item_investigations AS DOUBLE))
      comment: "Total unique item investigations (deduplicated by user session)"
    - name: "unique_title_requests"
      expr: SUM(CAST(unique_title_requests AS DOUBLE))
      comment: "Total unique title requests"
    - name: "unique_title_investigations"
      expr: SUM(CAST(unique_title_investigations AS DOUBLE))
      comment: "Total unique title investigations"
    - name: "total_searches_regular"
      expr: SUM(CAST(searches_regular AS DOUBLE))
      comment: "Total number of regular searches performed"
    - name: "total_searches_automated"
      expr: SUM(CAST(searches_automated AS DOUBLE))
      comment: "Total number of automated searches (bots, crawlers)"
    - name: "total_searches_federated"
      expr: SUM(CAST(searches_federated AS DOUBLE))
      comment: "Total number of federated searches"
    - name: "total_limit_exceeded_requests"
      expr: SUM(CAST(limit_exceeded_requests AS DOUBLE))
      comment: "Total requests denied due to concurrent user limits"
    - name: "total_no_license_requests"
      expr: SUM(CAST(no_license_requests AS DOUBLE))
      comment: "Total requests denied due to lack of license"
    - name: "total_cost"
      expr: SUM(CAST(cost_in_local_currency AS DOUBLE))
      comment: "Total cost of resources in local currency"
    - name: "cost_per_use"
      expr: ROUND(SUM(CAST(cost_in_local_currency AS DOUBLE)) / NULLIF(SUM(CAST(total_item_requests AS DOUBLE)), 0), 2)
      comment: "Cost per use (total cost divided by total item requests)"
    - name: "request_to_investigation_ratio"
      expr: ROUND(SUM(CAST(total_item_requests AS DOUBLE)) / NULLIF(SUM(CAST(total_item_investigations AS DOUBLE)), 0), 2)
      comment: "Ratio of full-text requests to investigations (conversion rate)"
    - name: "access_denial_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(limit_exceeded_requests AS DOUBLE)) + SUM(CAST(no_license_requests AS DOUBLE))) / NULLIF(SUM(CAST(total_item_requests AS DOUBLE)), 0), 2)
      comment: "Percentage of requests denied due to access limits or licensing"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_fine`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fine assessment and collection metrics tracking revenue recovery, waiver patterns, and patron account management"
  source: "`education_ecm`.`library`.`fine`"
  dimensions:
    - name: "fine_status"
      expr: fine_status
      comment: "Current status of the fine (outstanding, paid, waived, in collections)"
    - name: "fine_type"
      expr: fine_type
      comment: "Type of fine (overdue, lost item, damage, processing)"
    - name: "collections_status"
      expr: collections_status
      comment: "Collections status (not sent, sent, resolved, written off)"
    - name: "patron_group"
      expr: patron_group
      comment: "Patron category (undergraduate, graduate, faculty, staff)"
    - name: "library_location"
      expr: library_location
      comment: "Library location where fine was assessed"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the fine has been disputed by patron"
    - name: "billing_integration_flag"
      expr: billing_integration_flag
      comment: "Whether fine is integrated with student billing system"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (cash, card, online, student account)"
    - name: "waiver_reason"
      expr: waiver_reason
      comment: "Reason for waiving the fine"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month when fine was assessed"
  measures:
    - name: "total_fines"
      expr: COUNT(1)
      comment: "Total number of fine transactions"
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original fine amount assessed"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total fine amount paid by patrons"
    - name: "total_amount_waived"
      expr: SUM(CAST(amount_waived AS DOUBLE))
      comment: "Total fine amount waived by library"
    - name: "total_balance_due"
      expr: SUM(CAST(balance_due AS DOUBLE))
      comment: "Total outstanding balance due"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed fines successfully collected"
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_waived AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed fines waived"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fines disputed by patrons"
    - name: "avg_fine_amount"
      expr: AVG(CAST(original_amount AS DOUBLE))
      comment: "Average fine amount assessed"
    - name: "avg_overdue_days"
      expr: AVG(CAST(overdue_days AS DOUBLE))
      comment: "Average number of overdue days per fine"
    - name: "unique_patrons_with_fines"
      expr: COUNT(DISTINCT patron_id)
      comment: "Number of unique patrons with fine activity"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_ill_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interlibrary loan request fulfillment and cost recovery metrics tracking resource sharing efficiency and patron service"
  source: "`education_ecm`.`library`.`ill_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of ILL request (pending, shipped, received, returned, cancelled)"
    - name: "request_type"
      expr: request_type
      comment: "Type of request (loan, copy, returnables)"
    - name: "lending_institution_name"
      expr: lending_institution_name
      comment: "Name of the lending institution"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method of shipping (courier, mail, electronic)"
    - name: "copyright_compliance_flag"
      expr: copyright_compliance_flag
      comment: "Whether request complies with copyright guidelines"
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency for cost tracking"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month when request was placed"
  measures:
    - name: "total_ill_requests"
      expr: COUNT(1)
      comment: "Total number of interlibrary loan requests"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for ILL requests"
    - name: "total_patron_charged_amount"
      expr: SUM(CAST(patron_charged_amount AS DOUBLE))
      comment: "Total amount charged to patrons for ILL services"
    - name: "avg_cost_per_request"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per ILL request"
    - name: "cost_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(patron_charged_amount AS DOUBLE)) / NULLIF(SUM(CAST(cost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of ILL costs recovered from patron charges"
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'received' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ILL requests successfully fulfilled"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ILL requests cancelled"
    - name: "copyright_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN copyright_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests complying with copyright guidelines"
    - name: "avg_renewal_count"
      expr: AVG(CAST(renewal_count AS DOUBLE))
      comment: "Average number of renewals per ILL request"
    - name: "unique_patrons"
      expr: COUNT(DISTINCT patron_id)
      comment: "Number of unique patrons using ILL services"
    - name: "unique_lending_institutions"
      expr: COUNT(DISTINCT lending_institution_code)
      comment: "Number of unique lending institutions used"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`library_digital_object`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Institutional repository and digital scholarship metrics tracking open access compliance, downloads, and scholarly impact"
  source: "`education_ecm`.`library`.`digital_object`"
  dimensions:
    - name: "object_type"
      expr: object_type
      comment: "Type of digital object (thesis, dissertation, article, dataset, presentation)"
    - name: "degree_level"
      expr: degree_level
      comment: "Degree level for theses/dissertations (masters, doctoral)"
    - name: "academic_department"
      expr: academic_department
      comment: "Academic department of the author"
    - name: "license_type"
      expr: license_type
      comment: "License type (Creative Commons, copyright, public domain)"
    - name: "access_rights"
      expr: access_rights
      comment: "Access rights (open, embargoed, restricted, closed)"
    - name: "oer_flag"
      expr: oer_flag
      comment: "Whether the object is an Open Educational Resource"
    - name: "peer_reviewed_flag"
      expr: peer_reviewed_flag
      comment: "Whether the object is peer-reviewed"
    - name: "open_access_mandate_compliance"
      expr: open_access_mandate_compliance
      comment: "Whether object complies with open access mandates"
    - name: "preservation_status"
      expr: preservation_status
      comment: "Digital preservation status (preserved, at risk, not preserved)"
    - name: "file_format"
      expr: file_format
      comment: "File format of the digital object"
    - name: "deposit_month"
      expr: DATE_TRUNC('MONTH', deposit_date)
      comment: "Month when object was deposited"
  measures:
    - name: "total_digital_objects"
      expr: COUNT(1)
      comment: "Total number of digital objects in repository"
    - name: "total_downloads"
      expr: SUM(CAST(download_count AS DOUBLE))
      comment: "Total number of downloads across all digital objects"
    - name: "total_views"
      expr: SUM(CAST(view_count AS DOUBLE))
      comment: "Total number of views across all digital objects"
    - name: "avg_downloads_per_object"
      expr: AVG(CAST(download_count AS DOUBLE))
      comment: "Average number of downloads per digital object"
    - name: "avg_views_per_object"
      expr: AVG(CAST(view_count AS DOUBLE))
      comment: "Average number of views per digital object"
    - name: "total_file_size_gb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0, 2)
      comment: "Total file size of all digital objects in gigabytes"
    - name: "total_estimated_student_savings"
      expr: SUM(CAST(estimated_student_savings_usd AS DOUBLE))
      comment: "Total estimated student savings from OER digital objects"
    - name: "open_access_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN open_access_mandate_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of objects complying with open access mandates"
    - name: "peer_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_reviewed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of objects that are peer-reviewed"
    - name: "oer_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oer_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of objects designated as Open Educational Resources"
    - name: "unique_authors"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique authors contributing to repository"
    - name: "unique_departments"
      expr: COUNT(DISTINCT academic_department)
      comment: "Number of unique academic departments represented"
$$;
